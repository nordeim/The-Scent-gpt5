{block name='header'}
  <header class="main-header">
    <div class="container header-container">
      {* Logo *}
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

      {* Main Navigation *}
      <nav class="main-nav" id="_desktop_top_menu">
        {hook h='displayTop'}
      </nav>

      {* Header Icons *}
      <div class="header-icons">
        {hook h='displaySearch'}
        {hook h='displayCustomerAccount'}
        {hook h='displayShoppingCart'}
      </div>

      {* Mobile Nav Toggle *}
      <button class="mobile-nav-toggle" aria-label="{l s='Toggle navigation' d='Shop.Theme.Global'}">
        <i class="fas fa-bars"></i>
      </button>
    </div>

    {* Mobile Navigation Panel *}
    <nav class="mobile-nav">
      <div class="container">
        {hook h='displayMobileMenu'}
        <div class="mobile-search">
          {hook h='displaySearch'}
        </div>
        <div class="mobile-account">
          {hook h='displayCustomerAccount'}
        </div>
      </div>
    </nav>
  </header>

  {* Search Overlay *}
  {include file='_partials/search-overlay.tpl'}
{/block}

{block name='header_banner'}
  <div class="header-banner">
    {hook h='displayBanner'}
  </div>
{/block}

{block name='header_nav'}
  <nav class="header-nav">
    <div class="container">
      <div class="header-nav-left">
        {hook h='displayNav1'}
      </div>
      <div class="header-nav-right">
        {hook h='displayNav2'}
      </div>
    </div>
  </nav>
{/block}

{block name='header_top'}
  <div class="header-top">
    <div class="container">
      {* Logo *}
      <div class="header-logo">
        <a href="{$urls.base_url}">
          <img
            class="logo"
            src="{$shop.logo}"
            alt="{$shop.name}"
            width="100"
            height="50"
            loading="lazy"
          >
        </a>
      </div>

      {* Main Navigation *}
      <div class="header-navigation">
        {hook h='displayTop'}
      </div>

      {* User Actions *}
      <div class="header-actions">
        {* Search Button *}
        {hook h='displaySearch'}

        {* Account *}
        {hook h='displayNav2'}

        {* Cart *}
        {hook h='displayCart'}

        {* Mobile Menu Toggle *}
        <button class="mobile-nav-toggle" aria-label="{l s='Toggle menu' d='Shop.Theme.Global'}" aria-expanded="false">
          <span class="hamburger-icon"></span>
        </button>
      </div>
    </div>
  </div>

  {* Mobile Navigation *}
  <div class="mobile-nav">
    <div class="container">
      <nav class="mobile-menu">
        {hook h='displayTop'}
      </nav>
      <div class="mobile-actions">
        {hook h='displayNav1'}
        {hook h='displayNav2'}
      </div>
    </div>
  </div>

  {* Search Overlay - Will be shown/hidden via JS *}
  {hook h='displaySearch'}
{/block}

{block name='header_bottom'}
  <div class="header-bottom">
    <div class="container">
      {hook h='displayNavFullWidth'}
    </div>
  </div>
{/block}