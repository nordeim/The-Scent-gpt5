<div id="_desktop_cart" class="cart-preview">
  <div class="shopping-cart">
    <a rel="nofollow" href="{$cart_url}" class="cart-link">
      <i class="fas fa-shopping-bag"></i>
      <span class="cart-products-count">{$cart.products_count}</span>
    </a>
    
    {* Cart Dropdown Preview *}
    <div class="cart-dropdown">
      {if $cart.products_count > 0}
        <ul class="cart-items">
          {foreach from=$cart.products item=product}
            <li class="cart-item">
              <div class="product-image">
                <img
                  src="{$product.cover.small.url}"
                  alt="{$product.name|escape:'html':'UTF-8'}"
                  loading="lazy"
                >
              </div>
              <div class="product-info">
                <a class="product-name" href="{$product.url}">{$product.name}</a>
                <div class="product-price">
                  {$product.price}
                  <span class="quantity">x {$product.quantity}</span>
                </div>
              </div>
              <a
                class="remove-from-cart"
                rel="nofollow"
                href="{$product.remove_from_cart_url}"
                data-link-action="remove-from-cart"
                data-id-product="{$product.id_product|escape:'javascript'}"
                data-id-product-attribute="{$product.id_product_attribute|escape:'javascript'}"
                data-id-customization="{$product.id_customization|escape:'javascript'}"
              >
                <i class="fas fa-times"></i>
              </a>
            </li>
          {/foreach}
        </ul>
        
        <div class="cart-subtotals">
          {foreach from=$cart.subtotals item="subtotal"}
            {if $subtotal && $subtotal.value|count_characters > 0 && $subtotal.type !== 'tax'}
              <div class="cart-summary-line">
                <span class="label">{$subtotal.label}</span>
                <span class="value">{$subtotal.value}</span>
              </div>
            {/if}
          {/foreach}
        </div>
        
        <div class="cart-total">
          <span class="label">{$cart.totals.total.label}</span>
          <span class="value">{$cart.totals.total.value}</span>
        </div>
        
        <div class="cart-actions">
          <a class="btn btn-primary" href="{$cart_url}">
            {l s='Checkout' d='Shop.Theme.Actions'}
          </a>
        </div>
      {else}
        <div class="cart-empty">
          <p>{l s='Your cart is empty' d='Shop.Theme.Checkout'}</p>
        </div>
      {/if}
    </div>
  </div>
</div>