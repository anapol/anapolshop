{*?template charset=utf-8?*}

{def $anapolshopSettingsClass = fetch( 'content', 'class', hash( 'class_id', 'anapolshop_settings' ) )
     $delivery_discount = 0
     $delivery_discount_description = ""
}
{if $anapolshopSettingsClass.object_count|eq( 0 )|not}
    {def $anapolshop_settings = $anapolshopSettingsClass.object_list[0]}
{/if}

{foreach $anapolshop_settings.data_map.delivery_discounts.content.rows.sequential as $row}
{def $c_order_over = $row.columns[0]
     $c_delivery_discount = $row.columns[1]
     $c_delivery_discount_desc = $row.columns[2]}
{if $order.product_total_inc_vat|ge($c_order_over)}
    {if $c_delivery_discount|ge($delivery_discount)}
        {set $delivery_discount=$c_delivery_discount
             $delivery_discount_description = $c_delivery_discount_desc}
    {/if}
{/if}
{undef $c_order_over $c_delivery_discount $c_delivery_discount_desc}
{/foreach}

{set $delivery_discount=div(sub(100,$delivery_discount),100)}




<form action={$request_uri|ezroot} method="post" >
<h3>Průběh objednávky:</h3>
<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="shop-basket">

<ul>
    <li>1. <a href={"/shop/basket"|ezurl()}>Nákupní košík</a></li>
    <li>2. <a href={"/anapolshop/userregister"|ezurl()}>Zákazník</a></li>
    <li class="selected">3. Doprava a typ platby
    <li>4. Potvrzení objednávky</li>
</ul>

<div style="float:right"><div class="buttonblock">
<input class='button' type="submit" name="Dale" value="Pokračovat &gt;" />
</div>
</div>


</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>

<h3>Doprava a typ platby</h3>
<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="shop-basket">

Prosím zvolte typ doručení zboží a platbu:<br/>
<div class="block" style="padding-left: 10px;">
{foreach $anapolshop_settings.data_map.delivery_options.content.rows.sequential as $rowID => $row}

    {if $row.columns[1]|eq('')}
        <hr>
    {else}
        <label>
            <input name="payment" type="radio" value="dlvry{$rowID}"{if $rowID|eq(0)} checked{/if}/>{$row.columns[0]|wash} ({$row.columns[1]|mul($delivery_discount)|round},- Kč)
        </label>
        <div class="labelbreak"></div>
    {/if}

{/foreach}


Pro více podrobností o možnostech doručení a plateb nahlédněte prosím do našich <a href={"/x_obchodni_podminky"|ezurl} target="_blank">Obchodních podmínek.</a><br/>

 <br/>
  <br/>
</div> 

<div class="buttonblock"  style="float: right;">
<input class='button' type="submit" name="cancel" value="Storno" /><input class='button' type="submit" name="Dale" value="Pokračovat" />
</div>

<br/>

</form>


</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>

