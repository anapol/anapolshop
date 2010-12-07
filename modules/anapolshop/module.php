<?php
//
// Created on: <31-Jul-2002 16:47:15 bf>
//
// SOFTWARE NAME: eZ publish
// SOFTWARE RELEASE: 3.9.1rc1
// BUILD VERSION: 18210
// COPYRIGHT NOTICE: Copyright (C) 1999-2006 eZ systems AS
// SOFTWARE LICENSE: GNU General Public License v2.0
// NOTICE: >
//   This program is free software; you can redistribute it and/or
//   modify it under the terms of version 2.0  of the GNU General
//   Public License as published by the Free Software Foundation.
//
//   This program is distributed in the hope that it will be useful,
//   but WITHOUT ANY WARRANTY; without even the implied warranty of
//   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//   GNU General Public License for more details.
//
//   You should have received a copy of version 2.0 of the GNU General
//   Public License along with this program; if not, write to the Free
//   Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
//   MA 02110-1301, USA.
//
//


$Module = array( "name" => "anapolshop",
                 "variable_params" => true );

$ViewList = array();

$ViewList["userregister"] = array(
    "functions" => array( 'buy'),
    "script" => "userregister.php",
    'ui_context' => 'edit',
    "default_navigation_part" => 'ezshopnavigationpart',
    'single_post_actions' => array( 'StoreButton' => 'Store',
                                    'CancelButton' => 'Cancel'
                                    )
    );

$FunctionList = array();
$FunctionList['buy'] = array( );

$ViewList["orderview"] = array(
    "functions" => array( 'buy' ),
    "script" => "orderview.php",
    "default_navigation_part" => 'ezshopnavigationpart',
    "params" => array( "OrderID" ) );

$ViewList["customerorderview"] = array(
    "functions" => array( 'user_view_orders' ),
    "script" => "customerorderview.php",
    "default_navigation_part" => 'ezshopnavigationpart',
    "params" => array( "CustomerID", "Email" ) );

$FunctionList['user_view_orders'] = array( );

?>
