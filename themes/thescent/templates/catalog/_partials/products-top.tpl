<div id="js-product-list-top" class="products-list-top">
  <div class="container">
    <div class="row align-items-center">
      {* Results Count *}
      <div class="col-12 col-md-6">
        {if $listing.products|count > 0}
          <p class="products-count">
            {l s='Showing %from%-%to% of %total% item(s)' d='Shop.Theme.Catalog' sprintf=[
              '%from%' => $listing.pagination.items_shown_from ,
              '%to%' => $listing.pagination.items_shown_to,
              '%total%' => $listing.pagination.total_items
            ]}
          </p>
        {/if}
      </div>

      {* Sort Options *}
      <div class="col-12 col-md-6">
        <div class="sort-options d-flex justify-content-end align-items-center">
          {* View Mode Toggle *}
          <div class="view-mode me-3">
            <button class="btn btn-view" data-view="grid" title="{l s='Grid view' d='Shop.Theme.Actions'}" aria-label="{l s='Grid view' d='Shop.Theme.Actions'}">
              <i class="fas fa-th"></i>
            </button>
            <button class="btn btn-view" data-view="list" title="{l s='List view' d='Shop.Theme.Actions'}" aria-label="{l s='List view' d='Shop.Theme.Actions'}">
              <i class="fas fa-list"></i>
            </button>
          </div>

          {* Sort Dropdown *}
          <div class="products-sort-order dropdown">
            <button class="btn btn-sort dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
              {if isset($listing.sort_selected)}{$listing.sort_selected}{else}{l s='Sort by:' d='Shop.Theme.Global'}{/if}
            </button>
            <ul class="dropdown-menu dropdown-menu-end">
              {foreach from=$listing.sort_orders item=sort_order}
                <li>
                  <a
                    class="dropdown-item{if $sort_order.current} active{/if}"
                    href="{$sort_order.url}"
                    rel="nofollow"
                  >
                    {$sort_order.label}
                  </a>
                </li>
              {/foreach}
            </ul>
          </div>

          {* Items Per Page *}
          {if !empty($listing.pagination.nber_products)}
            <div class="items-per-page dropdown ms-3">
              <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                {$listing.products|count} {l s='per page' d='Shop.Theme.Catalog'}
              </button>
              <ul class="dropdown-menu dropdown-menu-end">
                <li><a class="dropdown-item" href="{$listing.current_url}&products_per_page=12">12</a></li>
                <li><a class="dropdown-item" href="{$listing.current_url}&products_per_page=24">24</a></li>
                <li><a class="dropdown-item" href="{$listing.current_url}&products_per_page=36">36</a></li>
              </ul>
            </div>
          {/if}
        </div>
      </div>
    </div>

    {* Active Filters *}
    {if $listing.rendered_active_filters}
      <div class="active-filters mt-3">
        <h3 class="h6">{l s='Active filters' d='Shop.Theme.Global'}</h3>
        {$listing.rendered_active_filters nofilter}
      </div>
    {/if}
  </div>
</div>