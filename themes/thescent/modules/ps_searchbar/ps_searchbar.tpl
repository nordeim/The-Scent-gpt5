{* Search toggle button in header *}
<div class="search-toggle-wrapper">
  <button class="search-toggle" aria-label="{l s='Search' d='Shop.Theme.Catalog'}">
    <i class="fas fa-search"></i>
  </button>
</div>

{* Search overlay *}
<div class="search-overlay">
  <div class="search-overlay-content">
    <button class="close-search" aria-label="{l s='Close search' d='Shop.Theme.Global'}">
      <i class="fas fa-times"></i>
    </button>

    <div class="search-form">
      <form method="get" action="{$search_controller_url}">
        <input type="hidden" name="controller" value="search">
        <div class="input-group">
          <input 
            type="text" 
            name="s" 
            value="{$search_string}" 
            placeholder="{l s='Search our store' d='Shop.Theme.Catalog'}"
            aria-label="{l s='Search' d='Shop.Theme.Catalog'}"
            class="form-control search-input"
            autocomplete="off"
            required
          >
          <button class="btn btn-primary" type="submit" aria-label="{l s='Search' d='Shop.Theme.Catalog'}">
            <i class="fas fa-search"></i>
          </button>
        </div>
      </form>
    </div>

    {* Quick links *}
    <div class="search-suggestions">
      <h3>{l s='Popular Searches' d='Shop.Theme.Catalog'}</h3>
      <div class="suggestion-tags">
        <a href="{$urls.pages.search}?s=aromatherapy">{l s='Aromatherapy' d='Shop.Theme.Catalog'}</a>
        <a href="{$urls.pages.search}?s=essential+oils">{l s='Essential Oils' d='Shop.Theme.Catalog'}</a>
        <a href="{$urls.pages.search}?s=diffusers">{l s='Diffusers' d='Shop.Theme.Catalog'}</a>
        <a href="{$urls.pages.search}?s=gift+sets">{l s='Gift Sets' d='Shop.Theme.Catalog'}</a>
      </div>
    </div>

    {* Live search results will be injected here *}
    <div id="search-results"></div>
  </div>
</div>
