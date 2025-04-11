<div class="search-overlay" id="search-overlay">
  <div class="search-container">
    <button class="close-search" aria-label="{l s='Close search' d='Shop.Theme.Global'}">
      <i class="fas fa-times"></i>
    </button>
    
    <div class="search-content">
      <h2>{l s='Search Our Collection' d='Shop.Theme.Global'}</h2>
      
      <form method="get" action="{$urls.pages.search}" class="search-form">
        <div class="search-input-wrapper">
          <input
            type="search"
            name="s"
            value="{$search_string}"
            placeholder="{l s='What are you looking for?' d='Shop.Theme.Global'}"
            aria-label="{l s='Search' d='Shop.Theme.Global'}"
            autocomplete="off"
            required
          >
          <button type="submit" class="search-submit">
            <i class="fas fa-search"></i>
            <span class="sr-only">{l s='Search' d='Shop.Theme.Global'}</span>
          </button>
        </div>
        
        {* Quick Links *}
        <div class="search-quick-links">
          <span>{l s='Popular searches:' d='Shop.Theme.Global'}</span>
          <a href="{$urls.pages.search}?s=essential+oils">{l s='Essential Oils' d='Shop.Theme.Global'}</a>
          <a href="{$urls.pages.search}?s=diffusers">{l s='Diffusers' d='Shop.Theme.Global'}</a>
          <a href="{$urls.pages.search}?s=aromatherapy">{l s='Aromatherapy' d='Shop.Theme.Global'}</a>
          <a href="{$urls.pages.search}?s=gift+sets">{l s='Gift Sets' d='Shop.Theme.Global'}</a>
        </div>
      </form>
      
      {* Live Search Results - Will be populated by JS *}
      <div class="live-search-results" aria-live="polite"></div>
      
      {* Search Categories *}
      <div class="search-categories">
        <h3>{l s='Shop by Category' d='Shop.Theme.Global'}</h3>
        <div class="category-grid">
          <a href="{$urls.pages.category}?id_category=2" class="category-card">
            <i class="fas fa-leaf"></i>
            <span>{l s='Single Oils' d='Shop.Theme.Global'}</span>
          </a>
          <a href="{$urls.pages.category}?id_category=3" class="category-card">
            <i class="fas fa-wind"></i>
            <span>{l s='Diffusers' d='Shop.Theme.Global'}</span>
          </a>
          <a href="{$urls.pages.category}?id_category=4" class="category-card">
            <i class="fas fa-gift"></i>
            <span>{l s='Gift Sets' d='Shop.Theme.Global'}</span>
          </a>
          <a href="{$urls.pages.category}?id_category=5" class="category-card">
            <i class="fas fa-home"></i>
            <span>{l s='Home & Living' d='Shop.Theme.Global'}</span>
          </a>
        </div>
      </div>
    </div>
  </div>
</div>
