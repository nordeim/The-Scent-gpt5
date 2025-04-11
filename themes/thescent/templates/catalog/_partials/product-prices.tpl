{block name='product_price'}
  <div class="product-prices js-product-prices">
    {* Regular Price Display *}
    <div class="product-price {if $product.has_discount}has-discount{/if}">
      {* Current Price *}
      <div class="current-price">
        <span class="price" itemprop="price" content="{$product.price_amount}">
          {$product.price}
        </span>

        {if $product.has_discount}
          <span class="regular-price">{$product.regular_price}</span>
          {if $product.discount_type === 'percentage'}
            <span class="discount-percentage">
              -{$product.discount_percentage_absolute}
            </span>
          {elseif $product.discount_type === 'amount'}
            <span class="discount-amount">
              -{$product.discount_to_display}
            </span>
          {/if}
        {/if}

        {* Unit Price *}
        {if $product.unit_price_full}
          <div class="unit-price">
            <span class="unit-price-label">{l s='Unit price:' d='Shop.Theme.Catalog'}</span>
            <span class="unit-price-value">{$product.unit_price_full}</span>
          </div>
        {/if}
      </div>

      {* Tax Information *}
      {block name='product_tax_info'}
        {if $configuration.display_taxes_label}
          <div class="tax-info">
            {if $configuration.taxes_enabled}
              {l s='Tax included' d='Shop.Theme.Catalog'}
            {else}
              {l s='Tax excluded' d='Shop.Theme.Catalog'}
            {/if}
          </div>
        {/if}
      {/block}

      {* Eco Tax *}
      {block name='product_ecotax'}
        {if $product.ecotax.amount > 0}
          <div class="eco-tax">
            <span class="eco-tax-label">{l s='Including' d='Shop.Theme.Catalog'}</span>
            <span class="eco-tax-value">{$product.ecotax.value}</span>
            <span class="eco-tax-desc">{l s='for ecotax' d='Shop.Theme.Catalog'}</span>
          </div>
        {/if}
      {/block}
    </div>

    {* Shipping Information *}
    {block name='product_shipping_info'}
      {if $configuration.show_shipping_info}
        <div class="shipping-info">
          {hook h='displayProductPriceShipping'}
        </div>
      {/if}
    {/block}

    {* Additional Price Hooks *}
    {block name='product_price_hooks'}
      {hook h='displayProductPriceBlock' product=$product type="before_price"}
      {hook h='displayProductPriceBlock' product=$product type="weight"}
      {hook h='displayProductPriceBlock' product=$product type="after_price"}
    {/block}
  </div>
{/block}