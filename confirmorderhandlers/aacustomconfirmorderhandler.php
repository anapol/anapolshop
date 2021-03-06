<?php
//
// Copyright 2010, anapol s.r.o.
// based on eZDefaultConfirmOrderHandler 4.4.0

// Changes: if customer/order email is not set, still send out mail to the admin
// FIXME: could be merged to upstream


class AACustomConfirmOrderHandler
{
    /*!
     Constructor
    */
    function AACustomConfirmOrderHandler()
    {
    }

    function execute( $params = array() )
    {
        $ini = eZINI::instance();
        $sendOrderEmail = $ini->variable( 'ShopSettings', 'SendOrderEmail' );
        if ( $sendOrderEmail == 'enabled' )
        {
            $this->sendOrderEmail( $params );
        }
    }

    function sendOrderEmail( $params )
    {
        $ini = eZINI::instance();
        if ( isset( $params['order'] ) )
        {
            $order = $params['order'];

            $tpl = eZTemplate::factory();
            $tpl->setVariable( 'order', $order );
            $templateResult = $tpl->fetch( 'design:shop/orderemail.tpl' );

            $subject = $tpl->variable( 'subject' );

            $emailSender = $ini->variable( 'MailSettings', 'EmailSender' );
            if ( !$emailSender )
                $emailSender = $ini->variable( "MailSettings", "AdminEmail" );

            if ( isset( $params['email'] ) and $params['email'] != "" )
            {
                $email = $params['email'];

                $mail = new eZMail();

                if ( $tpl->hasVariable( 'content_type' ) )
                    $mail->setContentType( $tpl->variable( 'content_type' ) );

                $mail->setReceiver( $email );
                $mail->setSender( $emailSender );
                $mail->setSubject( $subject );
                $mail->setBody( $templateResult );
                $mailResult = eZMailTransport::send( $mail );

                // order email set, send email to admin with that sender address
                $adminMail = new eZMail();
                $adminAddress = $ini->variable( 'MailSettings', 'AdminEmail' );

                if ( $tpl->hasVariable( 'content_type' ) )
                    $adminMail->setContentType( $tpl->variable( 'content_type' ) );

                $adminMail->setReceiver( $adminAddress );
                $adminMail->setSender( $email );
                $adminMail->setSubject( $subject );
                $adminMail->setBody( $templateResult );
                $mailResult = eZMailTransport::send( $adminMail );
            } else {
                // no order email set, send email to admin with default sender address
                $email = $ini->variable( 'MailSettings', 'AdminEmail' );

                $mail = new eZMail();

                if ( $tpl->hasVariable( 'content_type' ) )
                    $mail->setContentType( $tpl->variable( 'content_type' ) );

                $mail->setReceiver( $email );
                $mail->setSender( $emailSender );
                $mail->setSubject( $subject );
                $mail->setBody( $templateResult );
                $mailResult = eZMailTransport::send( $mail );
            }
        }
    }
}

?>
