<div id="search_widget" class="search-widget" data-search-controller-url="{$search_controller_url}">
  <form method="get" action="{$search_controller_url}">
    <input type="hidden" name="controller" value="search">
    <div class="search-input-wrapper">
      <input 
        type="text" 
        name="s" 
        value="{$search_string}" 
        placeholder="{l s='Search our store' d='Shop.Theme.Catalog'}"
        aria-label="{l s='Search' d='Shop.Theme.Catalog'}"
      >
      <button type="submit" class="search-button">
        <i class="fas fa-search"></i>
        <span class="hidden-text">{l s='Search' d='Shop.Theme.Catalog'}</span>
      </button>
    </div>
  </form>
</div>
