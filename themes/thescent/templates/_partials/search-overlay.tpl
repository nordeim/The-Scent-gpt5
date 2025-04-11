<div class="search-overlay">
  <div class="search-overlay-content">
    <form action="{$urls.pages.search}" method="get">
      <input 
        type="text" 
        class="search-input" 
        name="s" 
        placeholder="{l s='Search our store...' d='Shop.Theme.Catalog'}"
        aria-label="{l s='Search' d='Shop.Theme.Catalog'}"
      >
    </form>
  </div>
  <button class="close-search" aria-label="{l s='Close search' d='Shop.Theme.Global'}">
    <i class="fas fa-times"></i>
  </button>
</div>
