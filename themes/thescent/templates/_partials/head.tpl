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
{/block}

{block name='head_viewport'}
  <meta name="viewport" content="width=device-width, initial-scale=1">
{/block}

{block name='head_icons'}
  <link rel="icon" type="image/vnd.microsoft.icon" href="{$shop.favicon}?{$shop.favicon_update_time}">
  <link rel="shortcut icon" type="image/x-icon" href="{$shop.favicon}?{$shop.favicon_update_time}">
  {* Add Apple touch icons if needed *}
{/block}

{block name='stylesheets'}
  {foreach $stylesheets.external as $stylesheet}
    <link rel="stylesheet" href="{$stylesheet.uri}" type="text/css" media="{$stylesheet.media}">
  {/foreach}
  
  {* Google Fonts *}
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600;700&family=Montserrat:wght@300;400;500;600&family=Raleway:wght@300;400;500;600&display=swap" rel="stylesheet">

  {* Font Awesome *}
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

  {foreach $stylesheets.inline as $stylesheet}
    <style>
      {$stylesheet.content}
    </style>
  {/foreach}
{/block}

{block name='javascript_head'}
  {foreach $javascript.head as $js}
    <script src="{$js.uri}" {$js.attribute}></script>
  {/foreach}

  {foreach $javascript.inline as $js}
    <script>
      {$js.content nofilter}
    </script>
  {/foreach}
{/block}

{block name='hook_header'}
  {$HOOK_HEADER nofilter}
{/block}

{block name='hook_extra'}
  <meta property="og:title" content="{$page.meta.title}">
  <meta property="og:description" content="{$page.meta.description}">
  <meta property="og:type" content="website">
  <meta property="og:site_name" content="{$shop.name}">
  {if isset($product) && $page.page_name == 'product'}
    <meta property="og:image" content="{$product.cover.large.url}">
  {else}
    <meta property="og:image" content="{$urls.shop_domain_url}{$shop.logo}">
  {/if}
  
  {* Add structured data if needed *}
  {if $page.page_name == 'index'}
    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@type": "Organization",
      "name": "{$shop.name}",
      "url": "{$urls.shop_domain_url}",
      "logo": "{$urls.shop_domain_url}{$shop.logo}"
    }
    </script>
  {/if}
{/block}