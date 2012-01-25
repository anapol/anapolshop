<?php

class AnapolShopUtilities
{

    // get's set or default value of template name from account item spec
    public static function accountItem( $accountItemSpec ) {
        $spec = array(
            "xmlName" => "",
            "tplName" => "",
            "userObjectAttributeName" => "",
            "copyFromPreviousOrder" => true,
            "httpPostName" => "",
            "validations" => array()
        );
        $spec["xmlName"] = $spec["tplName"] = $spec["httpPostName"] = $accountItemSpec[0];
        if ( count($accountItemSpec) > 1 and ( $accountItemSpec[1] or $accountItemSpec[1] == "0" )) {
            $spec["tplName"] = $accountItemSpec[1];
        }
        if ( count($accountItemSpec) > 2 and ( $accountItemSpec[2] or $accountItemSpec[2] == "0" )) {
            $spec["userObjectAttributeName"] = $accountItemSpec[2];
        }
        if ( count($accountItemSpec) > 3 and $accountItemSpec[3] != "nocopy" ) {
            $spec["copyFromPreviousOrder"] = false;
        }
        if ( count($accountItemSpec) > 4 and ( $accountItemSpec[4] or $accountItemSpec[4] == "0" )) {
            $spec["httpPostName"] = $accountItemSpec[4];
        }
        if ( count($accountItemSpec) ) > 5 {
            for($specItemID=5; $specItemID<count($accountItemSpec); $specItemID++) {
                if ($accountItemSpec[$specItemID] or $accountItemSpec[$specItemID] === "0" ) {
                    array_push($spec["validation"], $accountItemSpec[$specItemID]);
                }
            }
        }
        return $spec;
    }


}

?>
