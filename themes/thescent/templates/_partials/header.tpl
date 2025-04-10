{block name='header'}
  <header class="main-header {if $page.page_name == 'index'}header-absolute{/if}">
    <div class="container header-container">
      <div class="logo" id="_desktop_logo">
        <a href="{$urls.base_url}">
          {$shop.name}
          <span>AROMATHERAPY</span>
        </a>
      </div>

      <nav class="main-nav" id="_desktop_top_menu">
        {hook h='displayNavFullWidth'}
      </nav>

      <div class="header-icons">
        {hook h='displaySearch'}
        {hook h='displayCustomerAccount'}
        {hook h='displayShoppingCart'}
      </div>

      <button class="mobile-nav-toggle" aria-label="{l s='Toggle navigation' d='Shop.Theme.Actions'}">
        <i class="fas fa-bars"></i>
      </button>
    </div>

    <nav class="mobile-nav">
      <ul>
        {hook h='displayMobileTopMenu'}
      </ul>
    </nav>
  </header>
{/block}