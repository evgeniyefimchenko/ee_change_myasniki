{if $runtime.controller == 'order_management' && $runtime.mode == 'update'}
<style>
 .span8 {
	 width: 100%!important;
 }
 .span4 {
	display: block!important;
	width: auto;
	margin: 0;
 }
 .cm-om-totals-recalculate>td>button {
	display: none!important;
 }
 .controls {
	margin: 0;
	display : contents;
 }
 .total.nowrap.cm-om-totals-price {
	display: none!important;
 }
</style>
{$cart.use_discount = 1}
<table width="100%" class="table table--relative table-responsive table-middle order-management-products">
<thead>
    <tr>
        <th class="left">
            {include file="common/check_items.tpl"}</th>
        <th width="50%">{__("product")}</th>
		<th class="center">{__("quantity")}</th>
        <th width="20%" colspan="2">{__("price")}</th>
        {if $cart.use_discount}
			<th width="10%">{__("discount")}</th>
        {/if}
		<th width="20%">Сумма</th>
        <th width="3%">{__("options")}</th>
    </tr>
</thead>

{capture name="extra_items"}
    {hook name="order_management:products_extra_items"}{/hook}
{/capture}

{*Сортировка по коду*}
	{$product_codes = array_column($cart_products, 'product_code')}
	{$sort_order = SORT_DESC}
	{array_multisort($product_codes, $sort_order, $cart_products)}
{*Конец сортировке*}

{foreach from=$cart_products item="cp" key="key"}
{hook name="order_management:items_list_row"}
<tr class="ee_recalc_tr">
    <td class="left order-management-product-check">
        <input type="checkbox" name="cart_ids[]" value="{$key}" class="cm-item" /></td>
    <td data-th="{__("product")}">
        <div class="order-product-image">
            {include file="common/image.tpl" image=$cp.main_pair.icon|default:$cp.main_pair.detailed image_id=$cp.main_pair.image_id image_width=$settings.Thumbnails.product_admin_mini_icon_width image_height=$settings.Thumbnails.product_admin_mini_icon_height href="products.update?product_id=`$cp.product_id`"|fn_url}
        </div>
        <div class="order-product-info">
            <a href="{"products.update?product_id=`$cp.product_id`"|fn_url}">{$cp.product nofilter}</a>
            <a class="cm-confirm cm-post hidden-tools icon-remove-sign order-management-delete" href="{"order_management.delete?cart_ids[]=`$key`"|fn_url}" title="{__("delete")}"></a>
            <div class="products-hint">
            {hook name="orders:product_info"}
                {if $cp.product_code}<p class="products-hint__code">{__("sku")}:{$cp.product_code}</p>{/if}
            {/hook}
            </div>
            {include file="views/companies/components/company_name.tpl" object=$cp}
        </div>
    </td>
    <td data-th="{__("quantity")}" class="center order-management-quantity">
        <input type="hidden" name="cart_products[{$key}][product_id]" value="{$cp.product_id}" />
        {if $cp.exclude_from_calculate}
        <input type="hidden" size="3" name="cart_products[{$key}][amount]" value="{$cp.amount}" />
        {/if}
        <span class="cm-reload-{$key}" id="amount_update_{$key}">
            <input class="ee_quantity input-hidden input-micro" type="text" size="3" name="cart_products[{$key}][amount]" value="{$cp.amount}" {if $cp.exclude_from_calculate}disabled="disabled"{/if} />
        <!--amount_update_{$key}--></span>
    </td>		
    <td data-th="{__("price")}" width="3%" class="order-management-price-check">
        {if $cp.exclude_from_calculate}
            {__("free")}
            {else}
            <input type="hidden" name="cart_products[{$key}][stored_price]" value="N" />
            <input style="display: none;" class="inline order-management-price-check-checkbox" type="checkbox" name="cart_products[{$key}][stored_price]" value="Y" checked="checked" onchange="Tygh.$('#db_price_{$key},#manual_price_{$key}').toggle();"/>
        {/if}
    </td>
    <td class="left order-management-price">
    {if !$cp.exclude_from_calculate}
        {if $cp.stored_price == "Y"}
            {math equation="price - modifier" price=$cp.original_price modifier=$cp.modifiers_price|default:0 assign="original_price"}
        {else}
            {assign var="original_price" value=$cp.original_price}
        {/if}
        <span class="{if $cp.stored_price == "Y"}hidden{/if}" id="db_price_{$key}">{include file="common/price.tpl" value=$original_price}</span>
        <div class="{if $cp.stored_price != "Y"}hidden{/if}" id="manual_price_{$key}">
            {include file="common/price.tpl" value=$cp.base_price view="input" input_id="cart_products[`$key`][price]" input_name="cart_products[`$key`][price]" class="input-hidden input-full" product_id=$cp.product_id}
        </div>
    {/if}
    </td>
    {if $cart.use_discount}
    <td data-th="{__("discount")}" class="no-padding nowrap">
    {if $cp.exclude_from_calculate}
        {include file="common/price.tpl" value=""}
    {else}
        {if $cart.order_id}
        <input type="hidden" name="cart_products[{$key}][stored_discount]" value="Y" />
		<input class="ee_discount" type="hidden" value="{$cp.discount}">
        <input type="text" class="ee_discount_input cm-numeric input-hidden input-full" size="5" name="cart_products[{$key}][discount]" value="{$cp.discount}" data-a-sign=" ₽ " data-p-sign="s" data-a-dec="." data-a-sep="," />
        {else}
			{include file="common/price.tpl" value=$cp.discount class="input-hidden input-full"}
        {/if}
    {/if}
    </td>
    {/if}
	{$calc_sum = $cp.base_price * $cp.amount}
	{if $cp.discount}
		{$calc_sum =$calc_sum - ($cp.amount * $cp.discount)}
	{/if}
	<td data-th="Сумма" width="20%"><input readonly type="text" data-a-sign=" ₽ " data-p-sign="s" data-a-dec="." data-a-sep="," style="width: 100%;" class="ee_calc_sum cm-numeric input-hidden input-full" value="{$calc_sum}" /></td>
	
    <td data-th="{__("options")}" width="3%" class="nowrap order-management-options">
        {if $cp.product_options}
        <div id="on_product_options_{$key}_{$cp.product_id}" alt="{__("expand_collapse_list")}" title="{__("expand_collapse_list")}" class="hand cm-combination-options-{$id}">
            <div class="order-management-options-desktop">
                <div class="icon-list-ul cm-external-click" data-ca-external-click-id="on_product_options_{$key}_{$cp.product_id}"></div>
            </div>
            <div class="order-management-options-mobile">
                <div class="btn cm-external-click" data-ca-external-click-id="on_product_options_{$key}_{$cp.product_id}">{__("show_options")}</div>
            </div>
        </div>
        <div id="off_product_options_{$key}_{$cp.product_id}" alt="{__("expand_collapse_list")}" title="{__("expand_collapse_list")}" class="hand hidden cm-combination-options-{$id}">
            <div class="order-management-options-desktop">
                <div class="icon-list-ul cm-external-click" data-ca-external-click-id="off_product_options_{$key}_{$cp.product_id}"></div>
            </div>
            <div class="order-management-options-mobile">
                <div class="btn cm-external-click"  data-ca-external-click-id="off_product_options_{$key}_{$cp.product_id}">{__("hide_options")}</div>
            </div>
        </div>
        {/if}
    </td>	
</tr>
{if $cp.product_options}
<tr id="product_options_{$key}_{$cp.product_id}" class="cm-ex-op hidden row-more row-gray order-management-options-content">
    <td class="mobile-hide">&nbsp;</td>
    <td colspan="{if $cart.use_discount}9{else}8{/if}">
        {include file="views/products/components/select_product_options.tpl" product_options=$cp.product_options name="cart_products" id=$key use_exceptions="Y" product=$cp additional_class="option-item"}
        <div id="warning_{$key}" class="pull-left notification-title-e hidden">&nbsp;&nbsp;&nbsp;{__("nocombination")}</div>
    </td>
</tr>
{/if}
{/hook}
{/foreach}

<tr>
    <td colspan="7" class="mixed-controls">
        <div class="form-inline object-product-add cm-object-product-add-container">
            {include file="views/products/components/picker/picker.tpl"
                input_name="product_data"
                multiple=true
                select_class="cm-object-product-add"
                autofocus=$autofocus
                view_mode="simple"
                display="options_price"
                extra_var="order_management.add"
                company_id=$order_company_id
                dialog_opener_meta="cm-dialog-destroy-on-close"
            }
        </div>
    </td>
</tr>
    {$smarty.capture.extra_items nofilter}
	<tr>
	<td colspan="7">
{literal}
	<script>
		(function(_, $) {
			function recalc_sum() {
				$('.ee_quantity, [id^="manual_price_"]>input, .ee_discount_input, [name="subtotal_discount"], [name^="stored_shipping_cost"]').each(function(){
					$(this).data('value', $(this).val());
				});
				$('.ee_recalc_tr').each(function() {
					var quan = parseFloat($(this).find('.ee_quantity').val()).toFixed(2);
					var price = parseFloat($(this).find('[id^="manual_price_"]>input').val()).toFixed(2);
					var calc_sum = price * quan;
					var disc = parseFloat($(this).find('.ee_discount').val()).toFixed(2);
					if (disc) {
						calc_sum = (calc_sum - (disc * quan)).toFixed(2);
					}
					setTimeout($('.ee_calc_sum').click(), 1000);
				});
				$('.ee_quantity, [id^="manual_price_"]>input, .ee_discount_input, [name="subtotal_discount"], [name^="stored_shipping_cost"]').on({'blur' : function () {
					if ($(this).val() != $(this).data('value')) {
						$('.hidden.cm-om-totals-recalculate').find('.btn.cm-ajax').click();
					}
				}});
				$('#ee_button').click(function() {
					$('[name="subtotal_discount"], .ee_discount_input').val(0);
					$('.hidden.cm-om-totals-recalculate').find('.btn.cm-ajax').click();
				});
				$('[id^="db_price_"]').hide();
				$('[id^="manual_price_"]').show();
				var sum = parseFloat($('.toggle-elm').parent().find('tr:eq(1)').find('span').text().replace(/\s+/g, '')).toFixed(2);
				var mega_sum = sum - parseFloat($('.toggle-elm').find('span').text()).toFixed(2);
				$('#mega_sum').text(mega_sum);
			}
			recalc_sum();
			$.ceEvent('on', 'ce.ajaxdone', function(elms, inline_scripts, params, data, text) {
				if (!$('#mega_sum').length) $('.toggle-elm').after('<tr><td class="statistic-label">Сумма заказа с учетом скидки:</td><td class="right"><span id="mega_sum"></span>&nbsp;<span class="ty-rub">₽</span></td></tr>');	
				recalc_sum();				
			});
			$('#elm_sidebar').prepend($('.span4'));
			$('.statuses').hide();						
		} (Tygh, Tygh.$));
	</script>
{/literal}	
	</td>
	<tr>
</table>
<button type="button" id="ee_button" class="btn  btn-primary">Убрать все скидки</button>
<!-- design/backend/templates/addons/ee_change_myasniki/overrides/views/order_management/components/products.tpl -->
{else}
<table width="100%" class="table table--relative table-responsive table-middle order-management-products">
<thead>
    <tr>
        <th class="left">
            {include file="common/check_items.tpl"}</th>
        <th width="50%">{__("product")}</th>		
        <th width="20%" colspan="2">{__("price")}</th>
        {if $cart.use_discount}
        <th width="10%">{__("discount")}</th>
        {/if}
		<th class="center">{__("quantity")}</th>
        <th width="3%">{__("options")}</th>
    </tr>
</thead>

{capture name="extra_items"}
    {hook name="order_management:products_extra_items"}{/hook}
{/capture}

{foreach from=$cart_products item="cp" key="key"}
{hook name="order_management:items_list_row"}
<tr>
    <td class="left order-management-product-check">
        <input type="checkbox" name="cart_ids[]" value="{$key}" class="cm-item" /></td>
    <td data-th="{__("product")}">
        <div class="order-product-image">
            {include file="common/image.tpl" image=$cp.main_pair.icon|default:$cp.main_pair.detailed image_id=$cp.main_pair.image_id image_width=$settings.Thumbnails.product_admin_mini_icon_width image_height=$settings.Thumbnails.product_admin_mini_icon_height href="products.update?product_id=`$cp.product_id`"|fn_url}
        </div>
        <div class="order-product-info">
            <a href="{"products.update?product_id=`$cp.product_id`"|fn_url}">{$cp.product nofilter}</a>
            <a class="cm-confirm cm-post hidden-tools icon-remove-sign order-management-delete" href="{"order_management.delete?cart_ids[]=`$key`"|fn_url}" title="{__("delete")}"></a>
            <div class="products-hint">
            {hook name="orders:product_info"}
                {if $cp.product_code}<p class="products-hint__code">{__("sku")}:{$cp.product_code}</p>{/if}
            {/hook}
            </div>
            {include file="views/companies/components/company_name.tpl" object=$cp}
        </div>
    </td>
    <td data-th="{__("price")}" width="3%" class="order-management-price-check">
        {if $cp.exclude_from_calculate}
            {__("free")}
            {else}
            <input type="hidden" name="cart_products[{$key}][stored_price]" value="N" />
            <input class="inline order-management-price-check-checkbox" type="checkbox" name="cart_products[{$key}][stored_price]" value="Y" {if $cp.stored_price == "Y"}checked="checked"{/if} onchange="Tygh.$('#db_price_{$key},#manual_price_{$key}').toggle();"/>
        {/if}
    </td>
    <td class="left order-management-price">
    {if !$cp.exclude_from_calculate}
        {if $cp.stored_price == "Y"}
            {math equation="price - modifier" price=$cp.original_price modifier=$cp.modifiers_price|default:0 assign="original_price"}
        {else}
            {assign var="original_price" value=$cp.original_price}
        {/if}
        <span class="{if $cp.stored_price == "Y"}hidden{/if}" id="db_price_{$key}">{include file="common/price.tpl" value=$original_price}</span>
        <div class="{if $cp.stored_price != "Y"}hidden{/if}" id="manual_price_{$key}">
            {include file="common/price.tpl" value=$cp.base_price view="input" input_name="cart_products[`$key`][price]" class="input-hidden input-full" product_id=$cp.product_id}
        </div>
    {/if}
    </td>
    {if $cart.use_discount}
    <td data-th="{__("discount")}" class="no-padding nowrap">
    {if $cp.exclude_from_calculate}
        {include file="common/price.tpl" value=""}
    {else}
        {if $cart.order_id}
        <input type="hidden" name="cart_products[{$key}][stored_discount]" value="Y" />
        <input type="text" class="input-hidden input-mini cm-numeric" size="5" name="cart_products[{$key}][discount]" value="{$cp.discount}" data-a-sign="{$currencies.$primary_currency.symbol|strip_tags nofilter}" data-a-dec="," data-a-sep="." />
        {else}
        {include file="common/price.tpl" value=$cp.discount}
        {/if}
    {/if}
    </td>
    {/if}
    <td data-th="{__("quantity")}" class="center order-management-quantity">
        <input type="hidden" name="cart_products[{$key}][product_id]" value="{$cp.product_id}" />
        {if $cp.exclude_from_calculate}
        <input type="hidden" size="3" name="cart_products[{$key}][amount]" value="{$cp.amount}" />
        {/if}
        <span class="cm-reload-{$key}" id="amount_update_{$key}">
            <input class="input-hidden input-micro" type="text" size="3" name="cart_products[{$key}][amount]" value="{$cp.amount}" {if $cp.exclude_from_calculate}disabled="disabled"{/if} />
        <!--amount_update_{$key}--></span>
    </td>
    <td data-th="{__("options")}" width="3%" class="nowrap order-management-options">
        {if $cp.product_options}
        <div id="on_product_options_{$key}_{$cp.product_id}" alt="{__("expand_collapse_list")}" title="{__("expand_collapse_list")}" class="hand cm-combination-options-{$id}">
            <div class="order-management-options-desktop">
                <div class="icon-list-ul cm-external-click" data-ca-external-click-id="on_product_options_{$key}_{$cp.product_id}"></div>
            </div>
            <div class="order-management-options-mobile">
                <div class="btn cm-external-click" data-ca-external-click-id="on_product_options_{$key}_{$cp.product_id}">{__("show_options")}</div>
            </div>
        </div>
        <div id="off_product_options_{$key}_{$cp.product_id}" alt="{__("expand_collapse_list")}" title="{__("expand_collapse_list")}" class="hand hidden cm-combination-options-{$id}">
            <div class="order-management-options-desktop">
                <div class="icon-list-ul cm-external-click" data-ca-external-click-id="off_product_options_{$key}_{$cp.product_id}"></div>
            </div>
            <div class="order-management-options-mobile">
                <div class="btn cm-external-click"  data-ca-external-click-id="off_product_options_{$key}_{$cp.product_id}">{__("hide_options")}</div>
            </div>
        </div>
        {/if}
    </td>
</tr>
{if $cp.product_options}
<tr id="product_options_{$key}_{$cp.product_id}" class="cm-ex-op hidden row-more row-gray order-management-options-content">
    <td class="mobile-hide">&nbsp;</td>
    <td colspan="{if $cart.use_discount}9{else}8{/if}">
        {include file="views/products/components/select_product_options.tpl" product_options=$cp.product_options name="cart_products" id=$key use_exceptions="Y" product=$cp additional_class="option-item"}
        <div id="warning_{$key}" class="pull-left notification-title-e hidden">&nbsp;&nbsp;&nbsp;{__("nocombination")}</div>
    </td>
</tr>
{/if}
{/hook}
{/foreach}

<tr>
    <td colspan="7" class="mixed-controls">
        <div class="form-inline object-product-add cm-object-product-add-container">
            {include file="views/products/components/picker/picker.tpl"
                input_name="product_data"
                multiple=true
                select_class="cm-object-product-add"
                autofocus=$autofocus
                view_mode="simple"
                display="options_price"
                extra_var="order_management.add"
                company_id=$order_company_id
                dialog_opener_meta="cm-dialog-destroy-on-close"
            }
        </div>
    </td>
</tr>

    {$smarty.capture.extra_items nofilter}
</table>
{/if}