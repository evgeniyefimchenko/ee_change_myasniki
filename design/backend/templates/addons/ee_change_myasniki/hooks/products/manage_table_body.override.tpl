{if $addons.ee_change_myasniki.active_prod_table == 'Y'}
{$is_use_context_menu = true}

{if "ULTIMATE"|fn_allowed_for}
	{if $runtime.company_id && $product.is_shared_product == "Y" && $product.company_id != $runtime.company_id}
		{assign var="hide_inputs_if_shared_product" value="cm-hide-inputs"}
		{assign var="no_hide_input_if_shared_product" value="cm-no-hide-input"}
	{else}
		{assign var="hide_inputs_if_shared_product" value=""}
		{assign var="no_hide_input_if_shared_product" value=""}
	{/if}
	{if !$runtime.company_id && $product.is_shared_product == "Y"}
		{assign var="show_update_for_all" value=true}
	{else}
		{assign var="show_update_for_all" value=false}
	{/if}

	{$is_use_context_menu = !$runtime.company_id || ($product.company_id|intval === $runtime.company_id|intval)}
{/if}

<tr class="cm-row-status-{$product.status|lower} cm-longtap-target {$hide_inputs_if_shared_product} {if !$is_use_context_menu}longtap-selection-disable{/if}"
		data-ca-longtap-action="setCheckBox"
		data-ca-longtap-target="input.cm-item"
		data-ca-id="{$product.product_id}"
		data-ca-category-ids="{$product.category_ids|to_json}"
		{if !$is_use_context_menu}data-ca-bulkedit-disabled-notice="{__("products_are_not_selectable_for_context_menu")}"{/if}
	>
		{hook name="products:manage_body"}
		<td class="left mobile-hide table__check-items-cell">
		<input type="checkbox" name="product_ids[]" value="{$product.product_id}" class="cm-item cm-item-status-{$product.status|lower} hide" /></td>
		<td width="{$image_width + 18px}" class="products-list__image">
			{include
					file="common/image.tpl"
					image=$product.main_pair.icon|default:$product.main_pair.detailed
					image_id=$product.main_pair.image_id
					image_width=$image_width
					image_height=$image_height
					href="products.update?product_id=`$product.product_id`"|fn_url
					image_css_class="products-list__image--img"
					link_css_class="products-list__image--link"
			}
		</td>
		{if $search.cid && $search.subcats != "Y"}
		<td width="7%" class="{if $no_hide_input_if_shared_product}{$no_hide_input_if_shared_product}{/if}">
			<input type="text" name="products_data[{$product.product_id}][position]" size="3" value="{$product.position}" class="input-micro" /></td>
		{/if}
		<td class="product-name-column wrap-word" data-th="{__("name")}">
			<input type="hidden" name="products_data[{$product.product_id}][product]" value="{$product.product}" {if $no_hide_input_if_shared_product} class="{$no_hide_input_if_shared_product}"{/if} />
			<a class="row-status" href="{"products.update?product_id=`$product.product_id`"|fn_url}">{$product.product nofilter}</a>
			<div class="product-list__labels">

			</div>
			{include file="views/companies/components/company_name.tpl" object=$product}
		</td>
		<td width="9%">			
			<div class="product-code">
				<span class="product-code__label">{$product.product_code}</span>
			</div>
		</td>
		<td width="9%">
			{hook name="products:product_additional_info"}
			{/hook}
		</td>
		<td width="9%" data-th="{__("quantity")}">
			{hook name="products:list_quantity"}
				<input type="text" name="products_data[{$product.product_id}][amount]" size="6" value="{$product.inventory_amount|default:$product.amount}" class="input-mini input-hidden" />
			{/hook}
		</td>		
		<td width="{if $show_update_for_all}16%{else}13%{/if}" class="{if $no_hide_input_if_shared_product}{$no_hide_input_if_shared_product}{/if} products-list__list-price" data-th="{__("price")}">
			{hook name="products:list_price"}
				{include file="buttons/update_for_all.tpl"
					display=$show_update_for_all
					object_id="price_`$product.product_id`"
					name="update_all_vendors[price][`$product.product_id`]"
					component="products.price_`$product.product_id`"
				}

				<input type="text" name="products_data[{$product.product_id}][price]" size="6" value="{$product.price|fn_format_price:$primary_currency:null:false}" class="input-small input-hidden cm-numeric" data-a-sep/>
			{/hook}
		</td>
		{if $show_list_price_column}
		<td width="12%" class="mobile-hide" data-th="{__("list_price")}">
			{hook name="products:list_list_price"}
				<input type="text" name="products_data[{$product.product_id}][list_price]" size="6" value="{$product.list_price|fn_format_price:$primary_currency:null:false}" class="input-small input-hidden cm-numeric" data-a-sep />
			{/hook}
		</td>
		{/if}
		{if $search.order_ids}
		<td width="9%" data-th="{__("purchased_qty")}">{$product.purchased_qty}</td>
		<td width="9%" data-th="{__("subtotal_sum")}">{$product.purchased_subtotal}</td>
		{/if}
		{/hook}
		<td width="9%" class="right nowrap" data-th="{__("status")}">
			{include file="views/products/components/status_on_manage.tpl"
				id=$product.product_id
				status=$product.status
				hidden=true
				object_id_name="product_id"
				table="products"
				non_editable_status=!fn_check_permissions("tools", "update_status", "admin", "POST", ["table" => "products"])
			}
			<div class="hidden-tools">
				{capture name="tools_list"}
					{hook name="products:list_extra_links"}
						<li>{btn type="list" text=__("edit") href="products.update?product_id=`$product.product_id`"}</li>
						{if !$hide_inputs_if_shared_product}
							<li>{btn
									type="list"
									text=__("delete")
									class="cm-confirm"
									href="products.delete?product_id=`$product.product_id`{if $delete_redirect_url}&redirect_url={$delete_redirect_url}{/if}"
									method="POST"
								}
							</li>
						{/if}
					{/hook}
				{/capture}
				{dropdown content=$smarty.capture.tools_list}
			</div>			
		</td>
	</tr>
{literal}
	<script>
		$.ceEvent('on', 'ce.ajaxdone', function(response_data) {
			var ee_rm_flag_th = false;
			$('.products-table th').each(function (i , e) {
				if (i == 8 && !ee_rm_flag_th && $(e).hasClass('mobile-hide')) {
					$(e).remove();
					ee_rm_flag_th = false;
				}
			});
		});		
	</script>
{/literal}	
{else}

            {$is_use_context_menu = true}

            {if "ULTIMATE"|fn_allowed_for}
                {if $runtime.company_id && $product.is_shared_product == "Y" && $product.company_id != $runtime.company_id}
                    {assign var="hide_inputs_if_shared_product" value="cm-hide-inputs"}
                    {assign var="no_hide_input_if_shared_product" value="cm-no-hide-input"}
                {else}
                    {assign var="hide_inputs_if_shared_product" value=""}
                    {assign var="no_hide_input_if_shared_product" value=""}
                {/if}
                {if !$runtime.company_id && $product.is_shared_product == "Y"}
                    {assign var="show_update_for_all" value=true}
                {else}
                    {assign var="show_update_for_all" value=false}
                {/if}

                {$is_use_context_menu = !$runtime.company_id || ($product.company_id|intval === $runtime.company_id|intval)}
            {/if}

            <tr class="cm-row-status-{$product.status|lower} cm-longtap-target {$hide_inputs_if_shared_product} {if !$is_use_context_menu}longtap-selection-disable{/if}"
                    data-ca-longtap-action="setCheckBox"
                    data-ca-longtap-target="input.cm-item"
                    data-ca-id="{$product.product_id}"
                    data-ca-category-ids="{$product.category_ids|to_json}"
                    {if !$is_use_context_menu}data-ca-bulkedit-disabled-notice="{__("products_are_not_selectable_for_context_menu")}"{/if}
                >
                    {hook name="products:manage_body"}
                    <td class="left mobile-hide table__check-items-cell">
                    <input type="checkbox" name="product_ids[]" value="{$product.product_id}" class="cm-item cm-item-status-{$product.status|lower} hide" /></td>
                    <td width="{$image_width + 18px}" class="products-list__image">
                        {include
                                file="common/image.tpl"
                                image=$product.main_pair.icon|default:$product.main_pair.detailed
                                image_id=$product.main_pair.image_id
                                image_width=$image_width
                                image_height=$image_height
                                href="products.update?product_id=`$product.product_id`"|fn_url
                                image_css_class="products-list__image--img"
                                link_css_class="products-list__image--link"
                        }
                    </td>
                    {if $search.cid && $search.subcats != "Y"}
                    <td width="7%" class="{if $no_hide_input_if_shared_product}{$no_hide_input_if_shared_product}{/if}">
                        <input type="text" name="products_data[{$product.product_id}][position]" size="3" value="{$product.position}" class="input-micro" /></td>
                    {/if}
                    <td class="product-name-column wrap-word" data-th="{__("name")}">
                        <input type="hidden" name="products_data[{$product.product_id}][product]" value="{$product.product}" {if $no_hide_input_if_shared_product} class="{$no_hide_input_if_shared_product}"{/if} />
                        <a class="row-status" href="{"products.update?product_id=`$product.product_id`"|fn_url}">{$product.product nofilter}</a>
                        <div class="product-list__labels">
                            {hook name="products:product_additional_info"}
                                <div class="product-code">
                                    <span class="product-code__label">{$product.product_code}</span>
                                </div>
                            {/hook}
                        </div>
                        {include file="views/companies/components/company_name.tpl" object=$product}
                    </td>
                    <td width="{if $show_update_for_all}16%{else}13%{/if}" class="{if $no_hide_input_if_shared_product}{$no_hide_input_if_shared_product}{/if} products-list__list-price" data-th="{__("price")}">
                        {hook name="products:list_price"}
                            {include file="buttons/update_for_all.tpl"
                                display=$show_update_for_all
                                object_id="price_`$product.product_id`"
                                name="update_all_vendors[price][`$product.product_id`]"
                                component="products.price_`$product.product_id`"
                            }

                            <input type="text" name="products_data[{$product.product_id}][price]" size="6" value="{$product.price|fn_format_price:$primary_currency:null:false}" class="input-small input-hidden cm-numeric" data-a-sep/>
                        {/hook}
                    </td>
                    {if $show_list_price_column}
                    <td width="12%" class="mobile-hide" data-th="{__("list_price")}">
                        {hook name="products:list_list_price"}
                            <input type="text" name="products_data[{$product.product_id}][list_price]" size="6" value="{$product.list_price|fn_format_price:$primary_currency:null:false}" class="input-small input-hidden cm-numeric" data-a-sep />
                        {/hook}
                    </td>
                    {/if}
                    {if $search.order_ids}
                    <td width="9%" data-th="{__("purchased_qty")}">{$product.purchased_qty}</td>
                    <td width="9%" data-th="{__("subtotal_sum")}">{$product.purchased_subtotal}</td>
                    {/if}
                    <td width="9%" data-th="{__("quantity")}">
                        {hook name="products:list_quantity"}
                            <input type="text" name="products_data[{$product.product_id}][amount]" size="6" value="{$product.inventory_amount|default:$product.amount}" class="input-mini input-hidden" />
                        {/hook}
                    </td>
                    {/hook}
                    <td width="9%" class="nowrap mobile-hide">
                        <div class="hidden-tools">
                            {capture name="tools_list"}
                                {hook name="products:list_extra_links"}
                                    <li>{btn type="list" text=__("edit") href="products.update?product_id=`$product.product_id`"}</li>
                                    {if !$hide_inputs_if_shared_product}
                                        <li>{btn
                                                type="list"
                                                text=__("delete")
                                                class="cm-confirm"
                                                href="products.delete?product_id=`$product.product_id`{if $delete_redirect_url}&redirect_url={$delete_redirect_url}{/if}"
                                                method="POST"
                                            }
                                        </li>
                                    {/if}
                                {/hook}
                            {/capture}
                            {dropdown content=$smarty.capture.tools_list}
                        </div>
                    </td>
                    <td width="9%" class="right nowrap" data-th="{__("status")}">
                        {include file="views/products/components/status_on_manage.tpl"
                            id=$product.product_id
                            status=$product.status
                            hidden=true
                            object_id_name="product_id"
                            table="products"
                            non_editable_status=!fn_check_permissions("tools", "update_status", "admin", "POST", ["table" => "products"])
                        }
                    </td>
                </tr>
{/if}