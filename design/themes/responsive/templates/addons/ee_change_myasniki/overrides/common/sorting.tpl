{ab__hide_content bot_type="ALL"}
<div class="ty-sort-dropdown">
    <a id="sw_elm_sort_fields" class="ty-sort-dropdown__wrapper cm-combination"><i class="material-icons">&#xE164;</i></a>
    <ul id="elm_sort_fields" class="ty-sort-dropdown__content cm-popup-box hidden">
	    <li class="ypi-sort-active-item"><span>{__("sort_by_`$search.sort_by`_`$search.sort_order`")}</span></li>
        {foreach from=$sorting key="option" item="value"}
            {if $search.sort_by == $option}
                {assign var="sort_order" value=$search.sort_order_rev}
            {else}
                {if $value.default_order}
                    {assign var="sort_order" value=$value.default_order}
                {else}
                    {assign var="sort_order" value="asc"}
                {/if}
            {/if}
            
            {foreach from=$sorting_orders item="sort_order"}
                {if $search.sort_by != $option || $search.sort_order_rev == $sort_order}
                    {assign var="sort_class" value="sort-by-`$class_pref``$option`-`$sort_order`"}
                    {assign var="sort_key" value="`$option`-`$sort_order`"}
                    {if !$avail_sorting || $avail_sorting[$sort_key] == 'Y' || $option == "code"}
                    <li class="{$sort_class} ty-sort-dropdown__content-item">
                        <a class="{$ajax_class} ty-sort-dropdown__content-item-a" data-ca-target-id="{$pagination_id}" href="{"`$curl`&sort_by=`$option`&sort_order=`$sort_order`"|fn_url}" rel="nofollow">{__("sort_by_`$option`_`$sort_order`")}</a>
                    </li>
                    {/if}
                {/if}
            {/foreach}
        {/foreach}
    </ul>
</div>
{/ab__hide_content}
