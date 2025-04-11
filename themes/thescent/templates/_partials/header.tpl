{block name='header'}
  <header class="main-header">
    <div class="container header-container">
      <div class="logo" id="_desktop_logo">
        <a href="{$urls.pages.index}">
          {if $shop.logo_details}
            <img
              class="logo-image"
              src="{$shop.logo}"
              alt="{$shop.name}"
              width="{$shop.logo_details.width}"
              height="{$shop.logo_details.height}">
          {else}
            {$shop.name}
            <span class="logo-subtitle">{l s='AROMATHERAPY' d='Shop.Theme.Global'}</span>
          {/if}
        </a>
      </div>

      <nav class="main-nav" id="_desktop_top_menu">
        {hook h='displayTop'}
      </nav>

      <div class="header-icons">
        {hook h='displaySearch'}
        {hook h='displayCustomerAccount'}
        {hook h='displayShoppingCart'}
      </div>

      <button class="mobile-nav-toggle" aria-label="{l s='Toggle navigation' d='Shop.Theme.Global'}">
        <i class="fas fa-bars"></i>
      </button>
    </div>

    <nav class="mobile-nav">
      {hook h='displayMobileMenu'}
    </nav>
  </header>
{/block}