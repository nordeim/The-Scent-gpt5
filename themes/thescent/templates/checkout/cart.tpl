{extends file='page.tpl'}

{block name='page_title'}
  {l s='Shopping Cart' d='Shop.Theme.Checkout'}
{/block}

{block name='page_content'}
  {block name='cart_overview'}
    <div class="cart-container">
      {if $cart.products_count > 0}
        <div class="cart-overview">
          {* Products List *}
          <div class="cart-items">
            {foreach from=$cart.products item=product}
              <div class="cart-item" data-id-product="{$product.id_product}">
                <div class="item-image">
                  {if $product.cover}
                    <a href="{$product.url}">
                      <img
                        src="{$product.cover.bySize.cart_default.url}"
                        alt="{$product.name|escape:'quotes'}"
                        loading="lazy"
                      >
                    </a>
                  {/if}
                </div>

                <div class="item-details">
                  <h3 class="item-name">
                    <a href="{$product.url}">{$product.name}</a>
                  </h3>
                  
                  {if $product.has_discount}
                    <div class="item-discount">
                      <span class="regular-price">{$product.regular_price}</span>
                      <span class="discount">-{$product.discount_percentage_absolute}</span>
                    </div>
                  {/if}
                  
                  <div class="item-price">
                    {$product.price}
                  </div>

                  {if isset($product.attributes) && $product.attributes}
                    <div class="item-variants">
                      {foreach from=$product.attributes key=attribute item=value}
                        <span><span class="label">{$attribute}:</span> {$value}</span>
                      {/foreach}
                    </div>
                  {/if}
                </div>

                <div class="item-actions">
                  <div class="qty-wrapper">
                    <label class="label" for="qty_{$product.id_product}">
                      {l s='Quantity' d='Shop.Theme.Catalog'}
                    </label>
                    <div class="qty-controls">
                      <button class="btn-qty decrease">-</button>
                      <input
                        type="number"
                        class="form-control"
                        value="{$product.quantity}"
                        name="product-quantity-spin"
                        id="qty_{$product.id_product}"
                        min="{$product.minimal_quantity}"
                        aria-label="{l s='Quantity' d='Shop.Theme.Actions'}"
                      >
                      <button class="btn-qty increase">+</button>
                    </div>
                  </div>

                  <div class="item-subtotal">
                    <span class="label">{l s='Subtotal' d='Shop.Theme.Checkout'}</span>
                    <span class="value">{$product.total}</span>
                  </div>

                  <a 
                    href="{$product.remove_from_cart_url}" 
                    class="remove-from-cart"
                    rel="nofollow"
                    data-link-action="delete-from-cart"
                    title="{l s='Remove' d='Shop.Theme.Actions'}"
                  >
                    <i class="fas fa-times"></i>
                  </a>
                </div>
              </div>
            {/foreach}
          </div>

          {* Cart Summary *}
          <div class="cart-summary">
            <div class="summary-content">
              {* Subtotal *}
              <div class="summary-line">
                <span class="label">{l s='Subtotal' d='Shop.Theme.Checkout'}</span>
                <span class="value">{$cart.subtotals.products.value}</span>
              </div>

              {* Shipping *}
              {if $cart.subtotals.shipping.value}
                <div class="summary-line">
                  <span class="label">{l s='Shipping' d='Shop.Theme.Checkout'}</span>
                  <span class="value">{$cart.subtotals.shipping.value}</span>
                </div>
              {/if}

              {* Tax *}
              {if $cart.subtotals.tax}
                <div class="summary-line">
                  <span class="label">{l s='Tax' d='Shop.Theme.Checkout'}</span>
                  <span class="value">{$cart.subtotals.tax.value}</span>
                </div>
              {/if}

              {* Total *}
              <div class="summary-line grand-total">
                <span class="label">{l s='Total' d='Shop.Theme.Checkout'}</span>
                <span class="value">{$cart.totals.total.value}</span>
              </div>

              {* Checkout Button *}
              <div class="checkout-action">
                <a href="{$urls.pages.order}" class="btn btn-primary">
                  {l s='Proceed to Checkout' d='Shop.Theme.Actions'}
                </a>
              </div>

              {* Continue Shopping *}
              <div class="continue-shopping">
                <a href="{$urls.pages.index}" class="btn btn-secondary">
                  <i class="fas fa-arrow-left"></i>
                  {l s='Continue Shopping' d='Shop.Theme.Actions'}
                </a>
              </div>
            </div>
          </div>
        </div>
      {else}
        <div class="cart-empty">
          <div class="cart-empty-content">
            <i class="fas fa-shopping-bag"></i>
            <p>{l s='Your cart is empty' d='Shop.Theme.Checkout'}</p>
            <a href="{$urls.pages.index}" class="btn btn-primary">
              {l s='Continue Shopping' d='Shop.Theme.Actions'}
            </a>
          </div>
        </div>
      {/if}
    </div>
  {/block}
{/block}

{block name='javascript_bottom'}
  {$smarty.block.parent}
  <script type="text/javascript">
    // Quantity controls
    document.querySelectorAll('.qty-controls').forEach(control => {
      const input = control.querySelector('input');
      const decreaseBtn = control.querySelector('.decrease');
      const increaseBtn = control.querySelector('.increase');

      decreaseBtn.addEventListener('click', () => {
        const currentValue = parseInt(input.value, 10);
        if (currentValue > parseInt(input.min, 10)) {
          input.value = currentValue - 1;
          input.dispatchEvent(new Event('change'));
        }
      });

      increaseBtn.addEventListener('click', () => {
        input.value = parseInt(input.value, 10) + 1;
        input.dispatchEvent(new Event('change'));
      });
    });
  </script>
{/block}