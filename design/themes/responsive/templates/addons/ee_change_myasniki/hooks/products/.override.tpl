{if $products}

    {script src="js/tygh/exceptions.js"}

    {if !$no_pagination}
        {include file="common/pagination.tpl"}
    {/if}

    {if !$no_sorting}
        {include file="views/products/components/sorting.tpl"}
    {/if}

    {assign var="image_width" value=$image_width|default:60}
    {assign var="image_height" value=$image_height|default:60}

    <div class="ty-compact-list">
        {hook name="products:product_compact_list_view"}
            {foreach from=$products item="product" key="key" name="products"}
                {assign var="obj_id" value=$product.product_id}
                {assign var="obj_id_prefix" value="`$obj_prefix``$product.product_id`"}
                {include file="common/product_data.tpl" product=$product}
                {hook name="products:product_compact_list"}{*$product|print_r*}
                    <div class="ty-compact-list__item">
                        <form {if !$config.tweaks.disable_dhtml}class="cm-ajax cm-ajax-full-render"{/if} action="{""|fn_url}" method="post" name="short_list_form{$obj_prefix}">
                            <input type="hidden" name="result_ids" value="cart_status*,wish_list*,account_info*" />
                            <input type="hidden" name="redirect_url" value="{$config.current_url}" />
                            <div class="ty-compact-list__content">
                                {hook name="products:product_compact_list_image"}
                                    <div class="ty-compact-list__image">
                                        <a href="{"products.view?product_id=`$product.product_id`"|fn_url}">
                                            {include file="common/image.tpl" image_width=$image_width image_height=$image_height images=$product.main_pair obj_id=$obj_id_prefix lazy_load=true}
                                        </a>
                                        {assign var="product_labels" value="product_labels_`$obj_prefix``$obj_id`"}
                                        {$smarty.capture.$product_labels nofilter}
                                    </div>
                                {/hook}

                                <div class="ty-compact-list__title">
                                    {assign var="name" value="name_$obj_id"}<bdi>{$smarty.capture.$name nofilter}</bdi>

                                    {hook name="products:ypi_product_list_block_top"}{/hook}

                                    {assign var="rating" value="rating_$obj_id"}
                                    <div class="compact-list__rating">
                                        {if ($ab_dotd_product_ids && $product.product_id|in_array:$ab_dotd_product_ids) or ($product.promotions)}
                                            <div class="ab_dotd_product_label">{__('ab__dotd_product_label')}</div>
                                        {/if}
                                        {$smarty.capture.$rating nofilter}
                                        {if $product.discussion_amount_posts > 0}
                                            <span class="cn-comments">({$product.discussion_amount_posts})</span>
                                        {/if}
                                    </div>
                                </div>
<style>
.ty-control-group__item {
	font-size: 18px;
}								
</style>
<div class="ty-compact-list__controls" style="display: inline-block; float: left; width: 150px; text-align: left;">
	<div>
		{if $settings.abt__yt.product_list.show_sku == 'Y'}
			{$sku = "sku_`$obj_id`"}
			{$smarty.capture.$sku nofilter}
		{/if}
	</div>
 </div>
 
<div class="ty-compact-list__controls" style="display: inline-block; float: left; width: 250px; text-align: left;">
	<div style="float: right;">
		{if $product.amount > 0}
			<span style="font-size: 12px; font-weight: 550; line-height: 1; padding: 3px 8px 3px 7px; border: 1px dotted #5aab5d; color: #5aab5d; -webkit-border-radius: 11px; -moz-border-radius: 11px; border-radius: 11px;">
			<i class="material-icons" style="position: relative; font-size: 17px; top: 4px;"></i> {$product.amount} шт.</span>
		{/if}
	</div>
 </div>
 
<div class="ty-compact-list__controls" style="display: inline-block; float: left; width: 100px; text-align: right; position: relative; left: 5%;">
	<div style="float: right; margin-top: 7px;">
		{assign var="old_price" value="old_price_`$obj_id`"}
		{if $smarty.capture.$old_price|trim}
			{$smarty.capture.$old_price nofilter}
		{/if}
	</div>
 </div>
                                <div class="ty-compact-list__controls" style="width: auto;">
                                    <div class="ty-compact-list__price">
                                        {assign var="price" value="price_`$obj_id`"}
                                        {$smarty.capture.$price nofilter}

                                        {assign var="clean_price" value="clean_price_`$obj_id`"}
                                        {$smarty.capture.$clean_price nofilter}
                                    </div>

                                    {if !$smarty.capture.capt_options_vs_qty}
                                        {assign var="product_options" value="product_options_`$obj_id`"}
                                        {$smarty.capture.$product_options nofilter}

                                        {assign var="qty" value="qty_`$obj_id`"}
                                        {$smarty.capture.$qty nofilter}
                                    {/if}

                                    {if $show_add_to_cart}
                                        {assign var="add_to_cart" value="add_to_cart_`$obj_id`"}
                                        {$smarty.capture.$add_to_cart nofilter}
                                    {/if}
                                </div>
                            </div>
                        </form>
                    </div>
                {/hook}
            {/foreach}
        {/hook}
    </div>

{if !$no_pagination}
    {include file="common/pagination.tpl" force_ajax=$force_ajax}
{/if}

{/if}