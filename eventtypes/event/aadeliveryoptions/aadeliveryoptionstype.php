<?php
//
// Copyright 2010 anapol s.r.o.
// Initially based on:
//
// Definition of paymentmethods class
//
// Created on: <2006-03-27 N. Leutner>
//
// Copyright (C) 2006 all2e GmbH. All rights reserved.
//

/*! \file ezpaymentmethods.php*/

/*!
  \class eZWrappingType ezwrappingtype.php
  \brief The class eZWrappingType does

*/


class AADeliveryOptionsType extends eZWorkflowEventType
{

    const WORKFLOW_TYPE_STRING = 'aadeliveryoptions';

    /*!
     Constructor
    */
    function AADeliveryOptionsType()
    {
        $this->eZWorkflowEventType( AADeliveryOptionsType::WORKFLOW_TYPE_STRING, "Delivery options" );
        $this->setTriggerTypes( array( 'shop' => array( 'confirmorder' => array ( 'before' ) ) ) );
    }
    
    
    function execute( $process, $event )
    {

        $parameters = $process->attribute( 'parameter_list' );
        $http = eZHTTPTool::instance();

        eZDebug::writeNotice( $parameters, "parameters" );
        $orderID = $parameters['order_id'];
        $order = eZOrder::fetch( $orderID );
        $orderItems = $order->attribute( 'order_items' );

        //eZDebug::writeWarning( get_class( $order ) , "Shopsender" );
		    
        if (empty($orderID) || get_class( $order ) != 'eZOrder')
        {
            eZDebug::writeWarning( "Can't proceed without a Order ID.", "Delivery options" );
            return eZWorkflowType::STATUS_FETCH_TEMPLATE_REPEAT;
        }       
        if ($http->hasPostVariable("cancel")){
            return eZWorkflowType::STATUS_WORKFLOW_CANCELLED;
        }
        
        if ($http->hasPostVariable("payment"))
        {

            $anapolshopSettingsClass = eZContentClass::fetchByIdentifier( "anapolshop_settings" );
            $anapolshopSettings = $anapolshopSettingsClass->objectList();
            $anapolshopSettings = $anapolshopSettings[0];
            $aashopDataMap = $anapolshopSettings->dataMap();
            $discountsAttribute = $aashopDataMap["delivery_discounts"];
            $discountsAttributeContent = $discountsAttribute->content();
            $discount_matrix = $discountsAttributeContent->Matrix;
            $discount_percent=0;
            $discount=1;
            foreach( $discount_matrix["rows"]["sequential"] as $row )
            {
                //print($row["columns"][2]);
                //print("X");
                if ( $order->productTotalIncVAT() >= $row["columns"][0] )
                {
                    if ( $row["columns"][1] > $discount_percent )
                    {
                        $discount_percent = $row["columns"][1];
                        $discount = (100.0-$discount_percent)/100.0;
                    }
                }
            }
            //print_r($discount_matrix);

            $deliveryOptionsAttribute = $aashopDataMap["delivery_options"];
            $deliveryOptionsAttributeContent = $deliveryOptionsAttribute->content();
            $deliveryOptionsMatrix = $deliveryOptionsAttributeContent->Matrix;

            $ana_setup=array();
            $deliveryRow = 0;
            foreach( $deliveryOptionsMatrix["rows"]["sequential"] as $row )
            {
                $optionSpec = "dlvry" . $deliveryRow;
                $ana_setup[$optionSpec] = array($row["columns"][1], $row["columns"][0]);
                $deliveryRow++;
            }

            $payment = $http->postVariable( "payment" );                
            eZDebug::writeDebug( 'Got paymentmethod:', $payment );
            
            if ( array_key_exists($payment, $ana_setup) )
            {
                $parameters = $process->attribute( 'parameter_list' );
                eZDebug::writeDebug( 'payment: '.$payment );
                $orderID = $parameters['order_id'];
                
                $description=$ana_setup[$payment][1];
                if ($discount_percent>0) {
                    $description = $description . ', sleva ' . $discount_percent . '%';
                }
                $price = round($discount * $ana_setup[$payment][0]);
                
                
                $addValue = true;
                
                foreach ( array_keys( $orderItems ) as $key )
                {
                    $orderItem =& $orderItems[$key];
                    if ( $orderItem->attribute( 'description' ) == $description )
                    {
                        $addValue = false;
                        break;
                    }
                }
              
                if ( $addValue )
                {
                  $orderItem = new eZOrderItem( array( 'order_id' => $orderID,
                                                       'description' => $description,
                                                       'price' => $price,
                                                       'vat_is_included' => true,
                                                       'vat_type_id' => 2 ) );
                  $orderItem->store();
                }
            
                return eZWorkflowType::STATUS_ACCEPTED;
            }
            else 
            {
                eZDebug::writeDebug( 'payment: keine Auswahl' );
                $requestUri = eZSys::requestURI();
                $process->Template = array( 'templateName' => 'design:workflow/eventtype/result/' . 'event_aadeliveryoptions' . '.tpl',
                                          'templateVars' => array( 'request_uri' => $requestUri )
                                         );
                
                
                return eZWorkflowType::STATUS_FETCH_TEMPLATE_REPEAT;
            }
        }
        else
        {
            $requestUri = eZSys::requestURI();
            $process->Template = array( 'templateName' => 'design:workflow/eventtype/result/' . 'event_aadeliveryoptions' . '.tpl',
                                      'templateVars' => array( 'request_uri' => $requestUri )
                                     );
            
            return eZWorkflowType::STATUS_FETCH_TEMPLATE_REPEAT;
        }
    }
}

eZWorkflowEventType::registerEventType( AADeliveryOptionsType::WORKFLOW_TYPE_STRING, "AADeliveryOptionsType" );

?>
