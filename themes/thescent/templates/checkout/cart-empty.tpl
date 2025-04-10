{extends file='checkout/cart.tpl'}

{block name='content'}
  <div class="cart-empty-container">
    <div class="cart-empty-content">
      <div class="empty-cart-icon">
        <i class="fas fa-shopping-bag"></i>
      </div>
      <h1>{l s='Your cart is empty' d='Shop.Theme.Checkout'}</h1>
      <p>{l s='Discover our natural aromatherapy products and find your perfect scent.' d='Shop.Theme.Checkout'}</p>
      <div class="cart-empty-actions">
        <a href="{$urls.pages.index}" class="btn btn-primary">
          {l s='Continue Shopping' d='Shop.Theme.Actions'}
        </a>
        {if $customer.is_logged}
          <a href="{$urls.pages.my_account}" class="btn btn-secondary">
            {l s='View My Account' d='Shop.Theme.Customeraccount'}
          </a>
        {/if}
      </div>
      
      {block name='continue_shopping'}
        <div class="cart-empty-suggestions">
          <h2>{l s='Suggested Categories' d='Shop.Theme.Checkout'}</h2>
          <div class="suggestion-links">
            <a href="{$urls.pages.index}#essential-oils" class="suggestion-link">
              <i class="fas fa-leaf"></i>
              {l s='Essential Oils' d='Shop.Theme.Catalog'}
            </a>
            <a href="{$urls.pages.index}#natural-soaps" class="suggestion-link">
              <i class="fas fa-soap"></i>
              {l s='Natural Soaps' d='Shop.Theme.Catalog'}
            </a>
            <a href="{$urls.pages.index}#diffusers" class="suggestion-link">
              <i class="fas fa-wind"></i>
              {l s='Diffusers' d='Shop.Theme.Catalog'}
            </a>
            <a href="{$urls.pages.index}#gift-sets" class="suggestion-link">
              <i class="fas fa-gift"></i>
              {l s='Gift Sets' d='Shop.Theme.Catalog'}
            </a>
          </div>
        </div>
      {/block}
    </div>
  </div>
{/block}