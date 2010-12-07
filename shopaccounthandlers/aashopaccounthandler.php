<?php

//
// Copyright 2010, anapol s.r.o.
// based on ezusershopaccounthandler.php from 4.4
//
// changes: configurable xml/tpl variables and account name from aashopaccount.ini


class AAShopAccountHandler
{
    function AAShopAccountHandler()
    {

    }

    /*!
     Will verify that the user has supplied the correct user information.
     Returns true if we have all the information needed about the user.
    */
    function verifyAccountInformation()
    {
        return false;
    }

    /*!
     Redirectes to the user registration page.
    */
    function fetchAccountInformation( &$module )
    {
        $module->redirectTo( '/anapolshop/userregister/' );
    }

    /*!
     \return the account information for the given order
    */
    function email( $order )
    {
        $email = false;
        $xmlString = $order->attribute( 'data_text_1' );
        if ( $xmlString != null )
        {
            $dom = new DOMDocument( '1.0', 'utf-8' );
            $success = $dom->loadXML( $xmlString );
            $emailNode = $dom->getElementsByTagName( 'email' )->item( 0 );
            if ( $emailNode )
            {
                $email = $emailNode->textContent;
            }
        }

        return $email;
    }

    /*!
     \return the account information for the given order
    */
    function accountName( $order )
    {
        $accountName = '';
        $xmlString = $order->attribute( 'data_text_1' );
        if ( $xmlString != null )
        {
            $dom = new DOMDocument( '1.0', 'utf-8' );
            $success = $dom->loadXML( $xmlString );

            $ini = eZINI::instance( 'aashopaccount.ini' );
            $resultArray = array();
            foreach ( $ini->variable( "OrderAccount", "AccountNameArray" ) as $accountNameSpec ) {
                $valueNode = $dom->getElementsByTagName( $accountNameSpec )->item( 0 );
                $value = $valueNode->textContent;
                if ( $value != "" and $accountName != "" ) {
                    $accountName = $accountName . " ";
                }
                $accountName = $accountName . $value;
            }
        }

        return $accountName;
    }


    function accountInformation( $order )
    {
        // initialize an populated array of default values
        $ini = eZINI::instance( 'aashopaccount.ini' );
        $resultArray = array();
        foreach ( $ini->variableArray( "OrderAccount", "FieldsArray" ) as $accountItemSpec ) {
            $processedAISpec = AnapolShopUtilities::accountItem( $accountItemSpec );
            $tplName = $processedAISpec["tplName"];
            $resultArray[$tplName] = '';
        }

        // try to parse the xml data and override the default values accordingly
        $dom = new DOMDocument( '1.0', 'utf-8' );
        $xmlString = $order->attribute( 'data_text_1' );
        if ( $xmlString != null )
        {
            $dom = new DOMDocument( '1.0', 'utf-8' );
            $success = $dom->loadXML( $xmlString );

            foreach ( $ini->variableArray( "OrderAccount", "FieldsArray" ) as $accountItemSpec ) {
                $processedAISpec = AnapolShopUtilities::accountItem( $accountItemSpec );
                $xmlName = $processedAISpec["xmlName"];
                $tplName = $processedAISpec["tplName"];
                
                $value = '';
                $valueNode = $dom->getElementsByTagName( $xmlName )->item( 0 );
                if ( $valueNode )
                {
                    $value = $valueNode->textContent;
                }
                $resultArray[$tplName] = $value;
            }

        }

        return $resultArray;
    }
}

?>
