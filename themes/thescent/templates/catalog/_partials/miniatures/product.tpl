{block name='product_miniature_item'}
<div class="product-card js-product-miniature" data-id-product="{$product.id_product}" data-id-product-attribute="{$product.id_product_attribute}">
  <div class="thumbnail-container">
    {block name='product_thumbnail'}
      <a href="{$product.url}" class="thumbnail product-thumbnail">
        <img
          src="{$product.cover.bySize.home_default.url}"
          alt="{$product.cover.legend}"
          loading="lazy"
          width="{$product.cover.bySize.home_default.width}"
          height="{$product.cover.bySize.home_default.height}"
        >
      </a>
    {/block}

    <div class="product-flags">
      {foreach from=$product.flags item=flag}
        <span class="product-flag {$flag.type}">{$flag.label}</span>
      {/foreach}
    </div>

    {if !empty($product.specific_prices) && $product.specific_prices.reduction > 0}
      <span class="discount-badge">
        -{$product.specific_prices.reduction * 100}%
      </span>
    {/if}

    <div class="quick-view-wrapper">
      <button class="quick-view-btn" data-link-action="quickview">
        {l s='Quick View' d='Shop.Theme.Actions'}
      </button>
    </div>
  </div>

  <div class="product-info">
    {block name='product_name'}
      <h3 class="product-title">
        <a href="{$product.url}">{$product.name}</a>
      </h3>
    {/block}

    {block name='product_description_short'}
      <div class="product-description">
        {$product.description_short|strip_tags|truncate:150:'...'}
      </div>
    {/block}

    {block name='product_price_and_shipping'}
      {if $product.show_price}
        <div class="product-price-and-shipping">
          {hook h='displayProductPriceBlock' product=$product type="before_price"}

          {if $product.has_discount}
            <span class="regular-price">{$product.regular_price}</span>
          {/if}

          <span class="price" aria-label="{l s='Price' d='Shop.Theme.Catalog'}">
            {$product.price}
          </span>

          {hook h='displayProductPriceBlock' product=$product type='unit_price'}
          {hook h='displayProductPriceBlock' product=$product type='weight'}
        </div>
      {/if}
    {/block}

    {block name='product_reviews'}
      {hook h='displayProductListReviews' product=$product}
    {/block}

    <div class="product-actions">
      {if !$configuration.is_catalog}
        <form action="{$urls.pages.cart}" method="post" class="add-to-cart-form">
          <input type="hidden" name="token" value="{$static_token}">
          <input type="hidden" name="id_product" value="{$product.id_product}">
          <input type="hidden" name="id_customization" value="0">
          <button
            class="btn btn-primary add-to-cart"
            data-button-action="add-to-cart"
            type="submit"
            {if !$product.add_to_cart_url}disabled{/if}
          >
            {l s='Add to Cart' d='Shop.Theme.Actions'}
          </button>
        </form>
      {/if}
    </div>
  </div>
</div>
{/block}