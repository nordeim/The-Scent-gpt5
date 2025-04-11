{* Helper function to format prices *}
{function name="formatPrice" price=0 currency=$currency}
  {$price|number_format:2:$currency.decimal_separator:$currency.thousands_separator} {$currency.sign}
{/function}

{* Format price with currency *}
{function name="format_price"}
    {$price|number_format:2:$currency.iso_code}
{/function}

{* Helper function to format dates *}
{function name="formatDate" date=null format="F j, Y"}
  {if $date}
    {$date|date_format:$format}
  {/if}
{/function}

{* Format date in localized format *}
{function name="format_date"}
    {$date|date_format:"%B %e, %Y"}
{/function}

{* Helper function for responsive images *}
{function name="responsiveImage" image=null sizes=null class="" lazy=true}
  {if $image}
    <img
      {if $lazy}loading="lazy"{/if}
      src="{$image.bySize.home_default.url}"
      {if $image.bySize.large_default}
        srcset="
          {$image.bySize.home_default.url} {$image.bySize.home_default.width}w,
          {$image.bySize.medium_default.url} {$image.bySize.medium_default.width}w,
          {$image.bySize.large_default.url} {$image.bySize.large_default.width}w
        "
      {/if}
      {if $sizes}sizes="{$sizes}"{/if}
      width="{$image.bySize.home_default.width}"
      height="{$image.bySize.home_default.height}"
      alt="{$image.legend|default: ''}"
      class="{$class}"
    >
  {/if}
{/function}

{* Generate product image with fallback *}
{function name="product_image"}
    {if isset($product.cover) && $product.cover}
        <img
            src="{$product.cover.bySize.home_default.url}"
            alt="{$product.name|escape:'html':'UTF-8'}"
            loading="lazy"
            width="{$product.cover.bySize.home_default.width}"
            height="{$product.cover.bySize.home_default.height}"
        >
    {else}
        <img
            src="{$urls.no_picture_image.bySize.home_default.url}"
            alt="{l s='No image available' d='Shop.Theme.Catalog'}"
            loading="lazy"
        >
    {/if}
{/function}

{* Helper function for breadcrumbs *}
{function name="renderBreadcrumb" breadcrumb=null}
  {if $breadcrumb.links|count > 0}
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        {foreach from=$breadcrumb.links item=path name=breadcrumb}
          {if $smarty.foreach.breadcrumb.last}
            <li class="breadcrumb-item active" aria-current="page">{$path.title}</li>
          {else}
            <li class="breadcrumb-item">
              <a href="{$path.url}">{$path.title}</a>
            </li>
          {/if}
        {/foreach}
      </ol>
    </nav>
  {/if}
{/function}

{* Generate breadcrumb trail *}
{function name="breadcrumb_trail"}
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item">
                <a href="{$urls.base_url}">
                    <i class="material-icons">home</i>
                </a>
            </li>
            {foreach from=$breadcrumb.links item=path name=breadcrumb}
                <li class="breadcrumb-item{if $smarty.foreach.breadcrumb.last} active{/if}">
                    {if $smarty.foreach.breadcrumb.last}
                        <span>{$path.title}</span>
                    {else}
                        <a href="{$path.url}">{$path.title}</a>
                    {/if}
                </li>
            {/foreach}
        </ol>
    </nav>
{/function}

{* Helper function for social sharing buttons *}
{function name="socialShare" url=$urls.current_url title=$page.meta.title}
  <div class="social-sharing">
    <button class="btn btn-social btn-facebook" data-type="facebook" data-url="{$url}">
      <i class="fab fa-facebook-f"></i>
    </button>
    <button class="btn btn-social btn-twitter" data-type="twitter" data-url="{$url}" data-title="{$title}">
      <i class="fab fa-twitter"></i>
    </button>
    <button class="btn btn-social btn-pinterest" data-type="pinterest" data-url="{$url}">
      <i class="fab fa-pinterest-p"></i>
    </button>
  </div>
{/function}

{* Generate social sharing buttons *}
{function name="social_sharing"}
    {if isset($social_share_links) && $social_share_links|count}
        <div class="social-sharing">
            <span class="share-title">{l s='Share:' d='Shop.Theme.Actions'}</span>
            {foreach from=$social_share_links item='social_share_link'}
                <a 
                    href="{$social_share_link.url}"
                    title="{$social_share_link.label}"
                    target="_blank"
                    rel="noopener noreferrer"
                    class="social-share-button {$social_share_link.class}"
                >
                    <i class="material-icons">{$social_share_link.icon}</i>
                </a>
            {/foreach}
        </div>
    {/if}
{/function}

{* Helper function for star ratings *}
{function name="starRating" rating=0 max=5}
  <div class="star-rating" aria-label="{$rating}/{$max} {l s='stars' d='Shop.Theme.Global'}">
    {for $i=1 to $max}
      <span class="star {if $i <= $rating}filled{/if}">★</span>
    {/for}
  </div>
{/function}

{* Generate star rating display *}
{function name="star_rating"}
    {assign var="full_stars" value=($rating|floor)}
    {assign var="half_star" value=($rating - $full_stars) >= 0.5}
    {assign var="empty_stars" value=5 - $full_stars - ($half_star|intval)}
    
    <div class="star-rating" title="{$rating} {if $rating == 1}star{else}stars{/if}">
        {for $i=1 to $full_stars}
            <i class="material-icons">star</i>
        {/for}
        
        {if $half_star}
            <i class="material-icons">star_half</i>
        {/if}
        
        {for $i=1 to $empty_stars}
            <i class="material-icons">star_border</i>
        {/for}
    </div>
{/function}

{* Helper function for product flags (new, sale, etc) *}
{function name="productFlags" flags=null}
  {if $flags}
    <ul class="product-flags">
      {foreach from=$flags item=flag}
        <li class="product-flag {$flag.type}">{$flag.label}</li>
      {/foreach}
    </ul>
  {/if}
{/function}

{* Helper function for "add to cart" forms *}
{function name="addToCartForm" product=null}
  <form action="{$urls.pages.cart}" method="post" class="add-to-cart-form">
    <input type="hidden" name="token" value="{$static_token}">
    <input type="hidden" name="id_product" value="{$product.id}">
    <input type="hidden" name="qty" value="1">
    <button 
      class="btn btn-primary add-to-cart"
      data-button-action="add-to-cart"
      type="submit"
      {if !$product.add_to_cart_url}disabled{/if}>
      <i class="material-icons shopping-cart"></i>
      {l s='Add to cart' d='Shop.Theme.Actions'}
    </button>
  </form>
{/function}

{* Helper function for quick view buttons *}
{function name="quickViewButton" product=null}
  <button 
    class="btn btn-secondary quick-view" 
    data-link-action="quickview"
    data-id-product="{$product.id}"
    type="button">
    <i class="material-icons search"></i>
    {l s='Quick view' d='Shop.Theme.Actions'}
  </button>
{/function}

{* Generate pagination links *}
{function name="pagination_links"}
    {if $pagination.should_be_displayed}
        <nav class="pagination">
            <ul class="page-list">
                {foreach from=$pagination.pages item="page"}
                    <li class="page-item{if $page.current} active{/if}">
                        {if $page.type === 'spacer'}
                            <span class="spacer">&hellip;</span>
                        {else}
                            <a
                                rel="{if $page.type === 'previous'}prev{elseif $page.type === 'next'}next{else}nofollow{/if}"
                                href="{$page.url}"
                                class="page-link {if $page.type === 'previous'}previous{elseif $page.type === 'next'}next{/if}"
                                {if $page.current}aria-current="page"{/if}
                            >
                                {if $page.type === 'previous'}
                                    <i class="material-icons">chevron_left</i>
                                {elseif $page.type === 'next'}
                                    <i class="material-icons">chevron_right</i>
                                {else}
                                    {$page.page}
                                {/if}
                            </a>
                        {/if}
                    </li>
                {/foreach}
            </ul>
        </nav>
    {/if}
{/function}

{* Format file size in human readable format *}
{function name="format_size"}
    {if $bytes < 1024}
        {$bytes} B
    {elseif $bytes < 1048576}
        {($bytes/1024)|number_format:1} KB
    {elseif $bytes < 1073741824}
        {($bytes/1048576)|number_format:1} MB
    {else}
        {($bytes/1073741824)|number_format:1} GB
    {/if}
{/function}

{* Display alert messages *}
{function name="show_alerts"}
    {if isset($alerts) && $alerts}
        <div class="alerts-container">
            {foreach $alerts as $alert}
                <div class="alert alert-{$alert.type}" role="alert">
                    {if $alert.title}
                        <h4 class="alert-heading">{$alert.title}</h4>
                    {/if}
                    {if is_array($alert.message)}
                        <ul class="alert-list">
                            {foreach $alert.message as $message}
                                <li>{$message nofilter}</li>
                            {/foreach}
                        </ul>
                    {else}
                        <p>{$alert.message nofilter}</p>
                    {/if}
                </div>
            {/foreach}
        </div>
    {/if}
{/function}

{* Display loading spinner *}
{function name="loading_spinner"}
    <div class="loading-spinner">
        <div class="spinner-border text-primary" role="status">
            <span class="visually-hidden">{l s='Loading...' d='Shop.Theme.Global'}</span>
        </div>
    </div>
{/function}