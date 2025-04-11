{block name='search_overlay'}
<div class="search-overlay">
    <div class="search-overlay-content">
        <div class="search-header">
            <form method="get" action="{$urls.pages.search}" class="search-form">
                <div class="input-group">
                    <input 
                        type="text" 
                        class="form-control search-input" 
                        placeholder="{l s='Search products...' d='Shop.Theme.Catalog'}"
                        aria-label="{l s='Search' d='Shop.Theme.Catalog'}"
                    >
                    <button class="btn-close-search" type="button" aria-label="{l s='Close search' d='Shop.Theme.Global'}">
                        <i class="material-icons">close</i>
                    </button>
                </div>
            </form>
        </div>

        <div class="search-loading d-none">
            {include file='_partials/helpers.tpl'}
            {call name='loading_spinner'}
        </div>

        <div class="search-results">
            <div class="search-no-results d-none">
                <p>{l s='No results found for your search' d='Shop.Theme.Catalog'}</p>
            </div>

            <div class="row">
                <div class="col-md-3">
                    <div class="categories-section">
                        <h3>{l s='Categories' d='Shop.Theme.Catalog'}</h3>
                        <ul class="category-list"></ul>
                    </div>
                </div>
                
                <div class="col-md-9">
                    <div class="products-section">
                        <h3>{l s='Products' d='Shop.Theme.Catalog'}</h3>
                        <div class="row product-list-mini"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
{/block}
