<?php
//
// Copyright 2010 anapol s.r.o.
//



class AAThankYouForYourOrderType extends eZWorkflowEventType
{


    const WORKFLOW_TYPE_STRING = 'aathankyouforyourorder';
    

    function AAThankYouForYourOrderType()
    {
        $this->eZWorkflowEventType( AAThankYouForYourOrderType::WORKFLOW_TYPE_STRING, "Thank you for your order" );
        $this->setTriggerTypes( array( 'shop' => array( 'checkout' => array ( 'after' ) ) ) );
    }


    function execute( $process, $event )
    {
        $parameters = $process->attribute( 'parameter_list' );
        $http = eZHTTPTool::instance();
        $requestUri = eZSys::requestURI();

        eZDebug::writeNotice( $parameters, "parameters" );
        eZDebug::writeNotice( 'AAThankYouForYourOrderType' );

        $process->Template = array( 'templateName' => 'design:workflow/eventtype/result/' . 'event_aathankyouforyourorder' . '.tpl',
                                    'templateVars' => array( 'request_uri' => $requestUri )
                                  );
	

        eZDebug::writeNotice( 'BEFORE $http->hasPostVariable("zpet")' );
        if ($http->hasPostVariable("zpet")){
            eZDebug::writeNotice( '$http->hasPostVariable("zpet")' );
            //$process->RedirectUrl['redirect_url']= 'content/view/full/2';
            $process->RedirectUrl = 'content/view/full/2';
            //return EZ_WORKFLOW_STATUS_REDIRECT;
            //$process->RedirectUrl = "/";
            return eZWorkflowType::STATUS_REDIRECT;
        }
        else
        {
          return eZWorkflowType::STATUS_FETCH_TEMPLATE;
        }
    }


}



eZWorkflowEventType::registerEventType( AAThankYouForYourOrderType::WORKFLOW_TYPE_STRING, "AAThankYouForYourOrderType" );



?>
