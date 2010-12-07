<?php
//
// Copyright 2010, anapol s.r.o.
// based on ezpublish/shop/userregister.php 4.4
//


$http = eZHTTPTool::instance();
$module = $Params['Module'];


$tpl = eZTemplate::factory();

if ( $module->isCurrentAction( 'Cancel' ) )
{
    $module->redirectTo( '/shop/basket/' );
    return;
}

$user = eZUser::currentUser();


// check if we have a recent cancelled order and if so, 
// pre-fill the form with the info once entered
$previous_account_information = array();
$orderID = $http->sessionVariable( 'MyTemporaryOrderID' );
$order = eZOrder::fetch( $orderID );
if ( is_object( $order ) and  $order instanceof eZOrder )
{
    $previous_account_information = $order->accountInformation();
}

$aaXMLValues = array();
$aaTPLValues = array();
$inputErrors = array();


$ini = eZINI::instance( 'aashopaccount.ini' );

// Check if user is logged in, if so, copy relevant information from the contentobject
if ( $user->isLoggedIn() )
{
    $userObject = $user->attribute( 'contentobject' );
    $userMap = $userObject->dataMap();

    foreach ( $ini->variableArray( "OrderAccount", "FieldsArray" ) as $accountItemSpec ) {
        $processedAISpec = AnapolShopUtilities::accountItem( $accountItemSpec );
        $xmlName = $processedAISpec["xmlName"];
        $tplName = $processedAISpec["tplName"];
        $userContentObjectAttributeName = $processedAISpec["userObjectAttributeName"];
        
        if ($userContentObjectAttributeName and is_object($userMap[$userContentObjectAttributeName])) {
            $aaXMLValues[$xmlName] = $userMap[$userContentObjectAttributeName]->content();
            $aaTPLValues[$tplName] = $userMap[$userContentObjectAttributeName]->content();
        }
    }
    
    $emailAccountItemSpec = $ini->variableArray( "OrderAccount", "EmailItemSpec" );
    $aaXMLValues[$emailAccountItemSpec[0]] = $user->attribute( 'email' );
    $aaTPLValues[$emailAccountItemSpec[1]] = $user->attribute( 'email' );
}



// Check if user has an earlier order, copy order info from that one
$orderList = eZOrder::activeByUserID( $user->attribute( 'contentobject_id' ) );
if ( count( $orderList ) > 0 and  $user->isLoggedIn() )
{
    $accountInfo = $orderList[0]->accountInformation();

    foreach ( $ini->variableArray( "OrderAccount", "FieldsArray" ) as $accountItemSpec ) {
        $processedAISpec = AnapolShopUtilities::accountItem( $accountItemSpec );
        $xmlName = $processedAISpec["xmlName"];
        $tplName = $processedAISpec["tplName"];
                
        $aaXMLValues[$xmlName] = $accountInfo[$tplName];
        $aaTPLValues[$tplName] = $accountInfo[$tplName];
    }
}



$tpl->setVariable( "input_error", false );
if ( $module->isCurrentAction( 'Store' ) )
{
    $inputIsValid = true;

    foreach ( $ini->variableArray( "OrderAccount", "FieldsArray" ) as $accountItemSpec ) {
        $processedAISpec = AnapolShopUtilities::accountItem( $accountItemSpec );
        $httpVariableName = $processedAISpec["httpPostName"];
        $validation = $processedAISpec["validation"];
        
        $valueFromHTTP = trim( $http->postVariable( $httpVariableName ) );
        if ( $validation == "nonempty" ) {
            if ( $valueFromHTTP == "" ) {
                $inputIsValid = false;
                $inputErrors[$httpVariableName] = "nonempty";
            }
        } else if ( $validation == "email" ){
            if ( ! eZMail::validate( $valueFromHTTP ) ) {
                $inputIsValid = false;
                $inputErrors[$httpVariableName] = "email";
            }
        }

        $xmlName = $processedAISpec["xmlName"];
        $tplName = $processedAISpec["tplName"];

        $aaXMLValues[$xmlName] = $valueFromHTTP;
        $aaTPLValues[$tplName] = $valueFromHTTP;
    }

    if ( $inputIsValid == true )
    {
        // Check for validation
        $basket = eZBasket::currentBasket();

        $db = eZDB::instance();
        $db->begin();
        $order = $basket->createOrder();

        $doc = new DOMDocument( '1.0', 'utf-8' );

        $root = $doc->createElement( "shop_account" );
        $doc->appendChild( $root );


        foreach ( $ini->variableArray( "OrderAccount", "FieldsArray" ) as $accountItemSpec ) {
            $processedAISpec = AnapolShopUtilities::accountItem( $accountItemSpec );
            $xmlName = $processedAISpec["xmlName"];

            $valueNode = $doc->createElement( $xmlName, $aaXMLValues[$xmlName] );
            $root->appendChild( $valueNode );
        }


        $xmlString = $doc->saveXML();

        $order->setAttribute( 'data_text_1', $xmlString );
        $order->setAttribute( 'account_identifier', "ez" );

        $order->setAttribute( 'ignore_vat', 0 );

        $order->store();
        $db->commit();
        //eZShopFunctions::setPreferredUserCountry( $country );
        $http->setSessionVariable( 'MyTemporaryOrderID', $order->attribute( 'id' ) );

        $module->redirectTo( '/shop/confirmorder/' );
        return;
    }
    else
    {
        $tpl->setVariable( "input_error", true );
        $tpl->setVariable( "input_errors", $inputErrors );
    }
} else {
    // If the form was recently filled in, fill it again
    if ( $previous_account_information ) {
        foreach ( $ini->variableArray( "OrderAccount", "FieldsArray" ) as $accountItemSpec ) {
            $processedAISpec = AnapolShopUtilities::accountItem( $accountItemSpec );
            $xmlName = $processedAISpec["xmlName"];
            $tplName = $processedAISpec["tplName"];

            $aaXMLValues[$xmlName] = $previous_account_information[$tplName];
            $aaTPLValues[$tplName] = $previous_account_information[$tplName];
        }
    }
}


foreach ( $ini->variableArray( "OrderAccount", "FieldsArray" ) as $accountItemSpec ) {    
    $processedAISpec = AnapolShopUtilities::accountItem( $accountItemSpec );
    $tplName = $processedAISpec["tplName"];

    $tpl->setVariable( $tplName, $aaTPLValues[$tplName] );
}


$Result = array();
$Result['content'] = $tpl->fetch( "design:shop/userregister.tpl" );
$Result['path'] = array( array( 'url' => false,
                                'text' => ezpI18n::tr( 'kernel/shop', 'Enter account information' ) ) );
?>
