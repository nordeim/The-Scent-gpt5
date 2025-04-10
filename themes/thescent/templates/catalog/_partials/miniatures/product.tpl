{block name='product_miniature_item'}
<article class="product-miniature js-product-miniature product-card" data-id-product="{$product.id_product}" data-id-product-attribute="{$product.id_product_attribute}">
  <div class="thumbnail-container">
    {block name='product_thumbnail'}
      <a href="{$product.url}" class="thumbnail product-thumbnail">
        <img
          src="{$product.cover.bySize.home_default.url}"
          alt="{if !empty($product.cover.legend)}{$product.cover.legend}{else}{$product.name|truncate:30:'...'}{/if}"
          loading="lazy"
          width="{$product.cover.bySize.home_default.width}"
          height="{$product.cover.bySize.home_default.height}"
        >
      </a>
    {/block}
  </div>

  <div class="product-info">
    {block name='product_name'}
      <h3 class="h3 product-title">
        <a href="{$product.url}">{$product.name|truncate:30:'...'}</a>
      </h3>
    {/block}

    {block name='product_description_short'}
      <p class="product-description">
        {$product.description_short|strip_tags:'UTF-8'|truncate:50:'...'}
      </p>
    {/block}

    {block name='product_price_and_shipping'}
      {if $product.show_price}
        <div class="product-price-and-shipping">
          {if $product.has_discount}
            {hook h='displayProductPriceBlock' product=$product type="old_price"}
            <span class="regular-price" aria-label="{l s='Regular price' d='Shop.Theme.Catalog'}">{$product.regular_price}</span>
          {/if}

          {hook h='displayProductPriceBlock' product=$product type="before_price"}
          <span class="price" aria-label="{l s='Price' d='Shop.Theme.Catalog'}">{$product.price}</span>
          {hook h='displayProductPriceBlock' product=$product type='unit_price'}
          {hook h='displayProductPriceBlock' product=$product type='weight'}
        </div>
      {/if}
    {/block}

    <a href="{$product.url}" class="product-link">{l s='View Product' d='Shop.Theme.Actions'}</a>
  </div>
</article>
{/block}