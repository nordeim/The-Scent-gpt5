{block name='head_charset'}
  <meta charset="utf-8">
{/block}

{block name='head_ie_compatibility'}
  <meta http-equiv="x-ua-compatible" content="ie=edge">
{/block}

{block name='head_seo'}
  <title>{block name='head_seo_title'}{$page.meta.title}{/block}</title>
  <meta name="description" content="{block name='head_seo_description'}{$page.meta.description}{/block}">
  <meta name="keywords" content="{block name='head_seo_keywords'}{$page.meta.keywords}{/block}">
  {if $page.meta.robots !== 'index'}
    <meta name="robots" content="{$page.meta.robots}">
  {/if}
  {if $page.canonical}
    <link rel="canonical" href="{$page.canonical}">
  {/if}
  {block name='head_hreflang'}
    {foreach from=$urls.alternative_langs item=pageUrl key=code}
      <link rel="alternate" href="{$pageUrl}" hreflang="{$code}">
    {/foreach}
  {/block}
  
  {* Open Graph tags *}
  <meta property="og:title" content="{$page.meta.title}">
  <meta property="og:description" content="{$page.meta.description}">
  <meta property="og:url" content="{$urls.current_url}">
  <meta property="og:site_name" content="{$shop.name}">
  {if isset($product) && $page.page_name == 'product'}
    <meta property="og:type" content="product">
    <meta property="og:price:amount" content="{$product.price_amount}">
    <meta property="og:price:currency" content="{$currency.iso_code}">
    {if isset($product.images) && $product.images|count > 0}
      <meta property="og:image" content="{$product.images[0].large.url}">
    {/if}
  {else}
    <meta property="og:type" content="website">
  {/if}
{/block}

{block name='head_viewport'}
  <meta name="viewport" content="width=device-width, initial-scale=1">
{/block}

{block name='head_icons'}
  <link rel="icon" type="image/vnd.microsoft.icon" href="{$shop.favicon}?{$shop.favicon_update_time}">
  <link rel="shortcut icon" type="image/x-icon" href="{$shop.favicon}?{$shop.favicon_update_time}">
  <link rel="apple-touch-icon" href="{$urls.img_ps_url}app-icon.png">
{/block}

{block name='stylesheets'}
  {include file="_partials/stylesheets.tpl" stylesheets=$stylesheets}
{/block}

{block name='javascript_head'}
  {include file="_partials/javascript.tpl" javascript=$javascript.head vars=$js_custom_vars}

  {* Theme Configuration Object *}
  <script>
    window.themeConfig = {
      animations: true,
      searchOverlay: true,
      cartType: 'offcanvas',
      breakpoints: {
        sm: 576,
        md: 768,
        lg: 992,
        xl: 1200
      }
    };
  </script>
{/block}

{block name='hook_header'}
  {$HOOK_HEADER nofilter}
{/block}

{block name='hook_extra'}{/block}