{*?template charset=utf-8?*}
{def $typ=''
     $varsymbol=0
     $castka=0
     $castka_ebanka=0
}
{def $currency = fetch( 'shop', 'currency', hash( 'code', $order.productcollection.currency_code ) )
         $locale = false()
         $symbol = false()}
{if $currency}
    {set locale = $currency.locale
         symbol = $currency.symbol}
{/if}
{set $varsymbol=$order.order_nr}
{set $castka=$order.total_inc_vat|l10n( 'currency', $locale, $symbol )}
{def $hal=$order.total_inc_vat|mul(100)|ceil()|concat('')|extract_right(2)}
{def $kor=$order.total_inc_vat|floor()}
{set $castka_ebanka=concat($kor,'.',$hal)}
{def $ebanka=concat("https://klient3.rb.cz/ebts/owa/shop.payment?shopname=XXXXX&creditaccount=0000000&amount=",$castka_ebanka,"&varsymbol=",$varsymbol,"&url=http://example.com/&creditbank=5500")}

{foreach $order.order_items as $orderItem}
{*$orderItem.description}: {$orderItem.price_inc_vat|l10n( 'currency', $locale, $symbol )*}
{if $orderItem.description|contains('edem')}
{set $typ='predem'}
{elseif $orderItem.description|contains('eBank')}
{set $typ='ebanka'}
{/if}
{/foreach}


    <script type="text/javascript">
    
_gaq.push(['_addTrans',
   '{$order.order_nr}',           // order ID - required
   'e-shop', // affiliation or store name
   '{$order.total_inc_vat}',          // total - required
   '0',           // tax
   '0',          // shipping
   '',       // city
   '',     // state or province
   ''             // country
]);
_gaq.push(['_trackTrans']);

    </script>





<form action={$request_uri|ezroot} method="post" >
<input type="hidden" name="ConfirmOrderButton" value="1"/>
<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="shop-basket">

<h1>Vaše objednávka byla přijata</h1>

</div>

<p>Číslo Vaší objednávky je {$varsymbol|wash()}</p>



</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>

<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="shop-basket">



<div class="maincontentheader">
<h1>
{if $typ|eq('ebanka')}
 <h1>Nyní prosím zaplaťte v Reiffeisenbank (eKonto)</h1>
 </div>

<p>Zvolili jste platbu eKontem Reiffeisenbank. Zaplaťte prosím pomocí níže uvedených údajů:</p>
<h2><a href="{$ebanka}">Zaplatit eKontem nyní</a></h2>
<h3>Údaje platby (budou předvyplněny):</h3>
<ul>
 <li>Číslo účtu: 000000000/5500 Raiffeisenbank (eBanka)</li>
 <li>částka: {$castka}</li>
 <li>Variabilní symbol: {$varsymbol}</li>
 <li>Konstantní symbol: 0308</li>
 <li>Fakturu zašleme společně s objednaným zbožím, pokud potřebujete fakturu dříve, napište nám prosím.</li>
</ul>


{elseif $typ|eq('predem')}
 <h1>Nyní prosím zaplaťte pomocí níže uvedených údajů</h1>
 </div>
<p>Děkujeme za Vaši objednávku. Potvrzení přijetí objednávky naleznete také v mailu.</p>
<p>Zvolili jste platbu předem. Zaplaťte prosím pomocí níže uvedených údajů:</p>
<ul>
 <li>Číslo účtu: 000000000/5500 Raiffeisenbank</li>
 <li>částka: {$castka}</li>
 <li>Variabilní symbol: {$varsymbol}</li>
 <li>Konstantní symbol: 0308</li>
 <li>Fakturu zašleme společně s objednaným zbožím, pokud potřebujete fakturu dříve, napište nám prosím.</li>
</ul>

{else}
 <h1>Děkujeme za Vaši objednávku</h1>
 </div>
 <p>Potvrzení přijetí objednávky naleznete také v mailu. Tip: pokud jste zaregistrováni v našem obchodě, můžete stav vyřízení Vaší objednávky sledovat po přihlášení ve Vašem profilu.</p>
{/if}


{*
{if eq($order.user.contentobject.data_map.bankeinzug.data_int,'1')}
  <label><input name="payment" type="radio" value="Bankeinzug" />Bankeinzug</label><div class="labelbreak"></div>
{else}
  <label><input name="payment" type="radio" value="Bankeinzug" disabled />Bankeinzug</label><div class="labelbreak"></div>
{/if}

  <br/>
  Pro více podrobností o možnostech doručení a plateb nahlédněte prosím do našich <a href={"/x_obchodni_podminky"|ezurl} target="_blank">Obchodních podmínek.</a><br/>
 <br/>
  <br/>
</div> 
*}

<div class="buttonblock"  style="float: right;">
{*<input class='button' type="submit" name="zpet" value="Zpátky do obchodu" />*}
<a href={"/"|ezurl()}>Zpátky do obchodu</a>
<input class='button' type="submit" name="dale" value="Zobrazit stav zadané objednávky" />
</div>

<br/>

</form>


</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>

