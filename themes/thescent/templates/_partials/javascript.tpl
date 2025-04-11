{* Core scripts that should load first *}
{foreach $javascript.external as $js}
  <script src="{$js.uri}" {$js.attribute}></script>
{/foreach}

{foreach $javascript.inline as $js}
  <script>
    {$js.content nofilter}
  </script>
{/foreach}

{if isset($javascript.custom)}
  {foreach $javascript.custom as $js}
    <script src="{$js.uri}" {$js.attribute}></script>
  {/foreach}
{/if}

{* Initialize prestashop object with theme settings *}
<script>
  var prestashop = {ldelim}
    ...{$prestashop|json_encode nofilter},
    theme: {ldelim}
      breakpoints: {ldelim}
        tablet: 992,
        mobile: 576
      {rdelim}
    {rdelim}
  {rdelim};
</script>

{* Theme initialization *}
<script>
  document.addEventListener('DOMContentLoaded', function() {
    new TheScentTheme();
  });
</script>

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
