{extends file='customer/page.tpl'}

{block name='page_title'}
  {l s='My Account' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <div class="account-dashboard">
    <div class="dashboard-grid">
      {* Orders *}
      <div class="dashboard-card">
        <div class="card-icon">
          <i class="fas fa-shopping-bag"></i>
        </div>
        <h2>{l s='Orders' d='Shop.Theme.Customeraccount'}</h2>
        <p>{l s='Check your order history and track packages' d='Shop.Theme.Customeraccount'}</p>
        <a href="{$urls.pages.history}" class="btn btn-secondary">
          {l s='View Orders' d='Shop.Theme.Customeraccount'}
        </a>
      </div>

      {* Personal Info *}
      <div class="dashboard-card">
        <div class="card-icon">
          <i class="fas fa-user"></i>
        </div>
        <h2>{l s='Personal Information' d='Shop.Theme.Customeraccount'}</h2>
        <p>{l s='Update your personal information and password' d='Shop.Theme.Customeraccount'}</p>
        <a href="{$urls.pages.identity}" class="btn btn-secondary">
          {l s='Edit Profile' d='Shop.Theme.Customeraccount'}
        </a>
      </div>

      {* Addresses *}
      <div class="dashboard-card">
        <div class="card-icon">
          <i class="fas fa-map-marker-alt"></i>
        </div>
        <h2>{l s='Addresses' d='Shop.Theme.Customeraccount'}</h2>
        <p>{l s='Manage your shipping and billing addresses' d='Shop.Theme.Customeraccount'}</p>
        <a href="{$urls.pages.addresses}" class="btn btn-secondary">
          {l s='Manage Addresses' d='Shop.Theme.Customeraccount'}
        </a>
      </div>

      {* Wishlist if module is active *}
      {if isset($wishlistEnabled) && $wishlistEnabled}
        <div class="dashboard-card">
          <div class="card-icon">
            <i class="fas fa-heart"></i>
          </div>
          <h2>{l s='Wishlist' d='Shop.Theme.Customeraccount'}</h2>
          <p>{l s='View and manage your saved items' d='Shop.Theme.Customeraccount'}</p>
          <a href="{$urls.pages.wishlist}" class="btn btn-secondary">
            {l s='View Wishlist' d='Shop.Theme.Customeraccount'}
          </a>
        </div>
      {/if}
    </div>
  </div>
{/block}