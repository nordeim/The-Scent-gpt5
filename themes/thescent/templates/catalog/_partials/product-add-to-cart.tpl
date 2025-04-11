{block name='product_add_to_cart'}
  <div class="product-add-to-cart js-product-add-to-cart">
    {if !$configuration.is_catalog}
      {block name='product_quantity'}
        <div class="product-quantity">
          <div class="qty-control">
            <label for="quantity_wanted" class="label">{l s='Quantity' d='Shop.Theme.Catalog'}</label>
            <div class="qty-input-wrapper">
              <button type="button" class="btn btn-qty" data-action="decrease">
                <i class="fas fa-minus"></i>
                <span class="sr-only">{l s='Decrease quantity' d='Shop.Theme.Actions'}</span>
              </button>
              <input
                type="number"
                name="qty"
                id="quantity_wanted"
                inputmode="numeric"
                pattern="[0-9]*"
                {if $product.quantity_wanted}
                  value="{$product.quantity_wanted}"
                {else}
                  value="1"
                {/if}
                class="input-qty"
                min="{$product.minimal_quantity}"
                aria-label="{l s='Quantity' d='Shop.Theme.Actions'}"
              >
              <button type="button" class="btn btn-qty" data-action="increase">
                <i class="fas fa-plus"></i>
                <span class="sr-only">{l s='Increase quantity' d='Shop.Theme.Actions'}</span>
              </button>
            </div>
          </div>

          <div class="add">
            <button
              class="btn btn-primary add-to-cart"
              data-button-action="add-to-cart"
              type="submit"
              {if !$product.add_to_cart_url}
                disabled
              {/if}
            >
              <i class="fas fa-shopping-bag"></i>
              <span class="add-to-cart-text">
                {if $product.quantity > 0}
                  {l s='Add to Cart' d='Shop.Theme.Actions'}
                {else}
                  {l s='Out of Stock' d='Shop.Theme.Actions'}
                {/if}
              </span>
            </button>
          </div>
        </div>
      {/block}

      {* Minimal Quantity Notice *}
      {block name='product_minimal_quantity'}
        {if $product.minimal_quantity > 1}
          <div class="minimal-quantity-notice">
            {l s='The minimum purchase order quantity for the product is %quantity%.' d='Shop.Theme.Checkout' sprintf=['%quantity%' => $product.minimal_quantity]}
          </div>
        {/if}
      {/block}

      {* Stock Information *}
      {if $product.show_availability}
        <div class="stock-info">
          {if $product.availability === 'available'}
            <span class="stock-status in-stock">
              <i class="fas fa-check"></i>
              {$product.availability_message}
            </span>
          {elseif $product.availability === 'last_remaining_items'}
            <span class="stock-status low-stock">
              <i class="fas fa-exclamation-triangle"></i>
              {$product.availability_message}
            </span>
          {else}
            <span class="stock-status out-of-stock">
              <i class="fas fa-times"></i>
              {$product.availability_message}
            </span>
          {/if}
        </div>
      {/if}

      {* Additional Buttons *}
      <div class="additional-actions">
        {hook h='displayProductActions' product=$product}
      </div>
    {/if}
  </div>

  {* Quantity Controls Script *}
  <script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function() {
      const quantityInput = document.getElementById('quantity_wanted');
      const minQuantity = parseInt(quantityInput.min) || 1;
      
      document.querySelectorAll('.btn-qty').forEach(button => {
        button.addEventListener('click', () => {
          let currentValue = parseInt(quantityInput.value);
          
          if (button.dataset.action === 'decrease') {
            if (currentValue > minQuantity) {
              quantityInput.value = currentValue - 1;
            }
          } else {
            quantityInput.value = currentValue + 1;
          }
          
          // Trigger change event for PrestaShop
          quantityInput.dispatchEvent(new Event('change'));
        });
      });
      
      // Validate manual input
      quantityInput.addEventListener('change', () => {
        let value = parseInt(quantityInput.value);
        if (isNaN(value) || value < minQuantity) {
          quantityInput.value = minQuantity;
        }
      });
    });
  </script>
{/block}