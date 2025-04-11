{* Price formatting helper *}
{function name="formatPrice"}
  {if isset($amount)}
    {$currencySign = Currency::getDefaultCurrency()->sign}
    {$price = Tools::displayPrice($amount, $currencySign)}
    <span class="price">{$price}</span>
  {/if}
{/function}

{* Image loading helper *}
{function name="renderImage"}
  {if isset($image)}
    <img
      src="{$image.url}"
      alt="{$image.legend|default:''}"
      width="{$image.width}"
      height="{$image.height}"
      loading="lazy"
      {if isset($image.srcset)} srcset="{$image.srcset}"{/if}
      {if isset($image.sizes)} sizes="{$image.sizes}"{/if}
    >
  {/if}
{/function}

{* Rating display helper *}
{function name="displayRating"}
  {if isset($rating)}
    <div class="product-rating" aria-label="{l s='Rating %rating% out of 5' sprintf=['%rating%' => $rating] d='Shop.Theme.Global'}">
      {for $i=1 to 5}
        <i class="fa{if $i <= $rating} fa-star{else} fa-star-o{/if}"></i>
      {/for}
    </div>
  {/if}
{/function}

{* Stock status helper *}
{function name="displayStock"}
  {if isset($stock)}
    <div class="stock-info">
      {if $stock > 0}
        <span class="in-stock">{l s='In Stock' d='Shop.Theme.Global'}</span>
      {else}
        <span class="out-of-stock">{l s='Out of Stock' d='Shop.Theme.Global'}</span>
      {/if}
    </div>
  {/if}
{/function}

{* Discount badge helper *}
{function name="displayDiscount"}
  {if isset($discount)}
    <span class="discount-badge">
      -{$discount}%
    </span>
  {/if}
{/function}

{* Breadcrumb helper *}
{function name="renderBreadcrumb"}
  {if isset($breadcrumb)}
    <nav aria-label="{l s='Breadcrumb' d='Shop.Theme.Global'}">
      <ol class="breadcrumb">
        {foreach from=$breadcrumb.links item=path name=breadcrumb}
          <li class="breadcrumb-item{if $smarty.foreach.breadcrumb.last} active{/if}">
            {if !$smarty.foreach.breadcrumb.last}
              <a href="{$path.url}">{$path.title}</a>
            {else}
              <span>{$path.title}</span>
            {/if}
          </li>
        {/foreach}
      </ol>
    </nav>
  {/if}
{/function}

{* Form validation helper *}
{function name="displayErrors"}
  {if isset($errors) && $errors|count > 0}
    <div class="form-errors alert alert-danger">
      <ul>
        {foreach $errors as $error}
          <li>{$error}</li>
        {/foreach}
      </ul>
    </div>
  {/if}
{/function}

{* Social sharing helper *}
{function name="displaySocialSharing"}
  {if isset($social_share_links) && $social_share_links|count > 0}
    <div class="social-sharing">
      <span class="share-title">{l s='Share:' d='Shop.Theme.Global'}</span>
      {foreach from=$social_share_links item=social_share_link}
        <a 
          href="{$social_share_link.url}" 
          class="social-share-btn {$social_share_link.class}"
          title="{$social_share_link.label}"
          target="_blank"
          rel="noopener noreferrer"
        >
          <i class="fab fa-{$social_share_link.class}"></i>
        </a>
      {/foreach}
    </div>
  {/if}
{/function}