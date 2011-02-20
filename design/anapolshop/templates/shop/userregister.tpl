{*?template charset=utf-8?*}
<form method="post" action={"/anapolshop/userregister/"|ezurl}>
<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="shop-userregister">

<ul>
    <li>1. <a href={"/shop/basket"|ezurl()}>Nákupní košík</a></li>
    <li class="selected">2. Zákazník</li>
    <li>3. Doprava a typ platby
    <li>4. Potvrzení objednávky</li>
</ul>
<div class="buttonblock">
{*    <input class="button" type="submit" name="CancelButton" value="Zpět do košíku" />*}
    <input class="defaultbutton" type="submit" name="StoreButton" value="Pokračovat" />
</div>

</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>

<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="shop-userregister">

<div class="attribute-header">
     <h1 class="long">Informace o zákazníkovi</h1>
</div>

{shop_account_view_gui view=html order=$order}

{if $input_error}
 <div class="warning">
 <p>
 {"Input did not validate. All fields marked with * must be filled in."|i18n("design/anapolshop/shop/userregister")}
 </p>
 </div>
 {if $email_input_error}
  <div class="warning">
  <p>
  Zadaná e-mailová adresa není platná, zadejte prosím platnou e-mailovou adresu.
  </p>
  </div>
 {/if}
{else}
 {def $the_user=fetch( user, current_user )}
 {if $the_user.is_logged_in|not()}
  <div class="ana-mar-usershopregisteroptions">
  <h3>Vaše možnosti:</h3>
  <ul>
   <li>nejste registrovaný zákazník a nechcete se registrovat - vyplňte prosím adresu pro zaslání a fakturaci</li>
   <li>nejste registrovaný zákazník a chcete se zaregistrovat - zaregistrujte se prosím <a href={"/user/register"|ezurl()}>zde</a></li>
   <li>jste zaregistrovaný zákazník a chcete se přihlásit pro využití výhod registrovaného zákazníka - přihlaste se prosím <a href={"/user/login"|ezurl()}>zde</a></li>
  </ul>
  </div>
 {else}
  <div class="ana-mar-usershopregisterinfo">
  <p>Jako registrovanému a přihlášenému zákazníku Vám budou níže uvedené informace automaticky předvyplněny údaji z předcházející objednávky.</p>
  </div>
 {/if}
{/if}
{*<form method="post" action={"/shop2/userregister/"|ezurl}>*}

<div class="ana-mar-group">
<span class="ana-mar-legend">Adresa pro zaslání</span>
<p>Položky označené * musí být vyplněny.</p>

<div class="block">
<label>
Titul:
</label><div class="labelbreak"></div>
<input class="box" type="text" name="anaTitul" size="20" value="{$anaTitul|wash}" />
</div>

<div class="block">
<label>
Jméno:*
</label>
<div class="labelbreak"></div>
<input class="box" type="text" name="FirstName" size="20" value="{$first_name|wash}" />
</div>

<div class="block">
<label>
Příjmení:*
</label>
<div class="labelbreak"></div>
<input class="box" type="text" name="LastName" size="20" value="{$last_name|wash}" />
</div>

<div class="block">
<label>
Firma:
</label><div class="labelbreak"></div>
<input class="box" type="text" name="Street1" size="20" value="{$street1|wash}" />
</div>


<div class="block">
<label>
E-mail pro zaslání potvrzení objednávky:*
</label>
<div class="labelbreak"></div>
<input class="box" type="text" name="EMail" size="20" value="{$email|wash}" {if $email_input_error}style="background-color: red;"{/if}/>
</div>

<div class="block">
<label>
Ulice:*
</label>
<div class="labelbreak"></div>
<input class="box" type="text" name="Street2" size="20" value="{$street2|wash}" />
</div>

<div class="block">
<label>
Obec, město:*
</label>
<div class="labelbreak"></div>
<input class="box" type="text" name="Place" size="20" value="{$place|wash}" />
</div>

<div class="block">
<label>
PSČ:*
</label>
<div class="labelbreak"></div>
<input class="box" type="text" name="Zip" size="20" value="{$zip|wash}" />
</div>


</div>

<div class="ana-mar-group">
<span class="ana-mar-legend">Fakturační údaje</span>
<p>Vyplňte pouze v případě, že se liší od dodacích údajů.</p>
<div class="block">
<label>
Jméno:
</label><div class="labelbreak"></div>
<input class="box" type="text" name="anaDodJmeno" size="20" value="{$anaDodJmeno|wash}" />
</div>
<div class="block">
<label>
Příjmení:
</label><div class="labelbreak"></div>
<input class="box" type="text" name="anaDodPrijmeni" size="20" value="{$anaDodPrijmeni|wash}" />
</div>
<div class="block">
<label>
Firma:
</label><div class="labelbreak"></div>
<input class="box" type="text" name="anaDodFirma" size="20" value="{$anaDodFirma|wash}" />
</div>
<div class="block">
<label>
IČO:
</label><div class="labelbreak"></div>
<input class="box" type="text" name="anaICO" size="20" value="{$anaICO|wash}" />
</div>

<div class="block">
<label>
DIČ:
</label><div class="labelbreak"></div>
<input class="box" type="text" name="anaDIC" size="20" value="{$anaDIC|wash}" />
</div>

<div class="block">
<label>
Ulice:
</label><div class="labelbreak"></div>
<input class="box" type="text" name="anaDodUlice" size="20" value="{$anaDodUlice|wash}" />
</div>
<div class="block">
<label>
Obec, město:
</label><div class="labelbreak"></div>
<input class="box" type="text" name="anaDodMesto" size="20" value="{$anaDodMesto|wash}" />
</div>
<div class="block">
<label>
PSČ:
</label><div class="labelbreak"></div>
<input class="box" type="text" name="anaDodPSC" size="20" value="{$anaDodPSC|wash}" />
</div>

</div>

<div class="block" style="margin:1em 1em">
<label>
Poznámka:
</label><div class="labelbreak"></div>
<textarea style="width:95%;" name="comment" cols="80" rows="5">{$comment|wash}</textarea>
</div>


<div class="buttonblock">
    <input class="button" type="submit" name="CancelButton" value="Zpět" />
    <input class="defaultbutton" type="submit" name="StoreButton" value="{"Continue"|i18n( 'design/ezwebin/shop/userregister')}" />
</div>

</form>


</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>
