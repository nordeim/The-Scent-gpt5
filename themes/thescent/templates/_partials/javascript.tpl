{if $javascript.external|count}
  {foreach from=$javascript.external item=js}
    <script type="text/javascript" src="{$js.uri}" {$js.attribute}></script>
  {/foreach}
{/if}

{if $javascript.inline|count}
  {foreach from=$javascript.inline item=js}
    <script type="text/javascript">
      {$js.content nofilter}
    </script>
  {/foreach}
{/if}

{if isset($vars) && $vars|@count}
  <script type="text/javascript">
    {foreach from=$vars key=var_name item=var_value}
    var {$var_name} = {$var_value|json_encode nofilter};
    {/foreach}
  </script>
{/if}

{* Core JavaScript *}
{$javascript_header nofilter}

<script src="{$urls.theme_assets}js/custom.js"></script>

{* Additional Components *}
<script>
  // Theme Configuration
  window.themeConfig = {
    animations: true,
    searchOverlay: true
  };
  
  // PrestaShop Configuration
  var prestashop = {
    cart: {
      products: {$cart.products|json_encode nofilter},
      totals: {$cart.totals|json_encode nofilter},
      count: {$cart.products_count}
    }
  };
</script>

{* Footer JavaScript *}
{$javascript_footer nofilter}
