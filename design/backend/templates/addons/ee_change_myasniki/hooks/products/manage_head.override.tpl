{if $addons.ee_change_myasniki.active_prod_table == 'Y'}
{literal}
	<style>
		.table-middle tr td, .table-middle tr th {
			vertical-align: top;
		}
	</style>
{/literal}
<th class="left mobile-hide table__check-items-column{if !$has_available_products} table__check-items-column--disabled{/if}">
	{include file="common/check_items.tpl"
		check_statuses=''|fn_get_default_status_filters:true
		is_check_disabled=!$has_select_permission
		meta="table__check-items"
	}

	<input type="checkbox"
		class="bulkedit-toggler hide"
		data-ca-bulkedit-disable="[data-ca-bulkedit-default-object=true]"
		data-ca-bulkedit-enable="[data-ca-bulkedit-expanded-object=true]"
	/>
</th>
<th class="table__column-without-title"></th>
{if $search.cid && $search.subcats !== "Y"}
<th width="7%" class="nowrap">
	{include file="common/table_col_head.tpl"
		type="position"
		text=__("position_short")
	}
</th>
{/if}
<th>
	<div class="th-text-overflow th-text-overflow-wrapper">
		{include file="common/table_col_head.tpl" type="product" text=__("name")}
		<a class="{$ajax_class} th-text-overflow {if $search.sort_by === "code"}th-text-overflow--{$search.sort_order_rev}{/if}"
			href="{"`$c_url`&sort_by=code&sort_order=`$search.sort_order_rev`"|fn_url}"
			data-ca-target-id={$rev}
		>
			{__("sku")}
		</a>
	</div>
</th>
<th width="12%" class="nowrap">
</th>
<th width="9%" class="nowrap">
</th>
	{hook name="products:manage_head_amount"}
	<th width="9%" class="nowrap">
		{include file="common/table_col_head.tpl"
			type="amount"
			text=__("quantity")
			title=__("quantity_long")
		}
	</th>
	{/hook}
<th width="{if $show_update_for_all}16%{else}13%{/if}">
	{include file="common/table_col_head.tpl"
		type="price"
		text="{__("price")} ({$currencies.$primary_currency.symbol nofilter})"
	}
</th>
{if $show_list_price_column}
<th width="12%" class="mobile-hide">
	{include file="common/table_col_head.tpl"
		type="list_price"
		text="{__("list_price_short_2")} ({$currencies.$primary_currency.symbol nofilter})"
		title=__("list_price")
	}
</th>
{/if}
{if $search.order_ids}
<th width="9%">
	{include file="common/table_col_head.tpl" type="p_qty" text=__("purchased_qty")}
</th>
<th width="9%">
	{include file="common/table_col_head.tpl"
		type="p_subtotal"
		text="{__("subtotal_sum")} ({$currencies.$primary_currency.symbol nofilter})"
	}
</th>
{/if}
{else}
                <th class="left mobile-hide table__check-items-column{if !$has_available_products} table__check-items-column--disabled{/if}">
                    {include file="common/check_items.tpl"
                        check_statuses=''|fn_get_default_status_filters:true
                        is_check_disabled=!$has_select_permission
                        meta="table__check-items"
                    }

                    <input type="checkbox"
                        class="bulkedit-toggler hide"
                        data-ca-bulkedit-disable="[data-ca-bulkedit-default-object=true]"
                        data-ca-bulkedit-enable="[data-ca-bulkedit-expanded-object=true]"
                    />
                </th>
                <th class="table__column-without-title"></th>
                {if $search.cid && $search.subcats !== "Y"}
                <th width="7%" class="nowrap">
                    {include file="common/table_col_head.tpl"
                        type="position"
                        text=__("position_short")
                    }
                </th>
                {/if}
                <th>
                    <div class="th-text-overflow th-text-overflow-wrapper">
                        {include file="common/table_col_head.tpl" type="product" text=__("name")}
                        <a class="{$ajax_class} th-text-overflow {if $search.sort_by === "code"}th-text-overflow--{$search.sort_order_rev}{/if}"
                            href="{"`$c_url`&sort_by=code&sort_order=`$search.sort_order_rev`"|fn_url}"
                            data-ca-target-id={$rev}
                        >
                            {__("sku")}
                        </a>
                    </div>
                </th>
                <th width="{if $show_update_for_all}16%{else}13%{/if}">
                    {include file="common/table_col_head.tpl"
                        type="price"
                        text="{__("price")} ({$currencies.$primary_currency.symbol nofilter})"
                    }
                </th>
                {if $show_list_price_column}
                <th width="12%" class="mobile-hide">
                    {include file="common/table_col_head.tpl"
                        type="list_price"
                        text="{__("list_price_short_2")} ({$currencies.$primary_currency.symbol nofilter})"
                        title=__("list_price")
                    }
                </th>
                {/if}
                {if $search.order_ids}
                <th width="9%">
                    {include file="common/table_col_head.tpl" type="p_qty" text=__("purchased_qty")}
                </th>
                <th width="9%">
                    {include file="common/table_col_head.tpl"
                        type="p_subtotal"
                        text="{__("subtotal_sum")} ({$currencies.$primary_currency.symbol nofilter})"
                    }
                </th>
                {/if}
                    {hook name="products:manage_head_amount"}
                    <th width="9%" class="nowrap">
                        {include file="common/table_col_head.tpl"
                            type="amount"
                            text=__("quantity")
                            title=__("quantity_long")
                        }
                    </th>
                    {/hook}
{/if}