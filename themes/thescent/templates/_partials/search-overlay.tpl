<div class="search-overlay">
  <div class="search-overlay-content">
    <form action="{$urls.pages.search}" method="get" class="search-form">
      <div class="search-input-wrapper">
        <input 
          type="text" 
          class="search-input" 
          name="s" 
          placeholder="{l s='Search our store...' d='Shop.Theme.Catalog'}"
          aria-label="{l s='Search' d='Shop.Theme.Catalog'}"
        >
        <button type="submit" class="search-submit" aria-label="{l s='Search' d='Shop.Theme.Catalog'}">
          <i class="fas fa-search"></i>
        </button>
      </div>
    </form>
    <div class="search-suggestions">
      <div class="popular-searches">
        <h3>{l s='Popular Searches' d='Shop.Theme.Catalog'}</h3>
        <ul>
          <li><a href="{$urls.pages.search}?s=essential+oils">Essential Oils</a></li>
          <li><a href="{$urls.pages.search}?s=lavender">Lavender</a></li>
          <li><a href="{$urls.pages.search}?s=diffuser">Diffusers</a></li>
          <li><a href="{$urls.pages.search}?s=gift+sets">Gift Sets</a></li>
        </ul>
      </div>
      <div class="featured-categories">
        <h3>{l s='Categories' d='Shop.Theme.Catalog'}</h3>
        <ul>
          {foreach from=$categories item=category}
            <li><a href="{$category.url}">{$category.name}</a></li>
          {/foreach}
        </ul>
      </div>
    </div>
  </div>
  <button class="close-search" aria-label="{l s='Close search' d='Shop.Theme.Global'}">
    <i class="fas fa-times"></i>
  </button>
</div>
