<!-- responsive_clone_clipsator -->
<div class="ty-compact-list__item">
	<form {if !$config.tweaks.disable_dhtml}class="cm-ajax cm-ajax-full-render"{/if} action="{""|fn_url}" method="post" name="short_list_form{$obj_prefix}">
		<input type="hidden" name="result_ids" value="cart_status*,wish_list*,account_info*" />
		<input type="hidden" name="redirect_url" value="{$config.current_url}" />
		<div class="ty-compact-list__content" style="width: 100%;">
			{hook name="products:product_compact_list_image"}
				<div class="ty-compact-list__image" style="">
					<a href="{"products.view?product_id=`$product.product_id`"|fn_url}">
						{include file="common/image.tpl" image_width=$image_width image_height=$image_height images=$product.main_pair obj_id=$obj_id_prefix lazy_load=true}
					</a>
					{assign var="product_labels" value="product_labels_`$obj_prefix``$obj_id`"}
					{$smarty.capture.$product_labels nofilter}
				</div>
			{/hook}

			<div class="ty-compact-list__title" style="">
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
			<div class="ty-compact-list__title" style="width: 20%;">
				{if $settings.abt__yt.product_list.show_sku == 'Y'}
					{$product.product_code}
				{/if}
			</div>
			<div class="ty-compact-list__controls" style="width: 50%;">
				<div class="ty-compact-list__price" style="margin-bottom: 5px;">
					{if $product.amount > 0}
						<span style="display: inline-block; margin-right: 15px; font-size: 12px; font-weight: 550; line-height: 1; padding: 3px 8px 3px 7px; border: 1px dotted #5aab5d; color: #5aab5d; -webkit-border-radius: 11px; -moz-border-radius: 11px; border-radius: 11px;">
						<i class="material-icons" style="position: relative; font-size: 17px; top: 1px;"></i> <span style="position: relative; bottom: 3px;">{$product.amount} шт.</span></span>
					{/if}				
					{assign var="old_price" value="old_price_`$obj_id`"}
					{if $smarty.capture.$old_price|trim}
						<span style="position: relative; bottom: 2px; margin-right: 15px;">{$smarty.capture.$old_price nofilter}</span>
					{/if}
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
<script>
	setInterval(function() {
		$('.ty-compact-list__price > span').css('display', 'inline-block');
	}, 100);	
</script>