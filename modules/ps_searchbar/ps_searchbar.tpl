<div id="search_widget">
  <a href="#" class="search-toggle">
    <i class="fas fa-search"></i>
  </a>
  <form method="get" action="{$search_controller_url}" class="search-form">
    <input type="hidden" name="controller" value="search">
    <div class="search-input-group">
      <input 
        type="text" 
        name="s" 
        value="{$search_string}"
        placeholder="{l s='Search our store' d='Shop.Theme.Catalog'}"
        aria-label="{l s='Search' d='Shop.Theme.Catalog'}"
      >
      <button type="submit">
        <i class="fas fa-search"></i>
      </button>
    </div>
  </form>
</div>
