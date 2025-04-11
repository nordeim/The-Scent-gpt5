{if $listing.products|count}
  <div id="js-product-list">
    <div class="products row">
      {foreach from=$listing.products item="product"}
        <div class="{$productClass}">
          {block name='product_miniature'}
            {include file='catalog/_partials/miniatures/product.tpl' product=$product}
          {/block}
        </div>
      {/foreach}
    </div>

    {block name='pagination'}
      {include file='_partials/pagination.tpl' pagination=$listing.pagination}
    {/block}
  </div>
{else}
  <div id="js-product-list-top"></div>
  <div id="js-product-list">
    <div class="products-empty">
      <div class="container">
        <div class="empty-state text-center">
          <i class="fas fa-search fa-3x mb-3"></i>
          <h2>{l s='No products found' d='Shop.Theme.Catalog'}</h2>
          
          {if isset($allProductsLink)}
            <p>{l s='Try adjusting your filters or browse our full collection.' d='Shop.Theme.Catalog'}</p>
            <a href="{$allProductsLink}" class="btn btn-primary">
              {l s='View All Products' d='Shop.Theme.Catalog'}
            </a>
          {/if}

          {* Suggested Categories *}
          {if isset($categories) && $categories|count > 0}
            <div class="suggested-categories mt-5">
              <h3>{l s='Popular Categories' d='Shop.Theme.Catalog'}</h3>
              <div class="category-suggestions">
                {foreach from=$categories item=category name=categoryLoop}
                  {if $smarty.foreach.categoryLoop.index < 4}
                    <a href="{$category.url}" class="category-suggestion">
                      {if $category.image}
                        <img 
                          src="{$category.image.small.url}" 
                          alt="{$category.name}"
                          width="{$category.image.small.width}"
                          height="{$category.image.small.height}"
                          loading="lazy"
                        >
                      {/if}
                      <span>{$category.name}</span>
                    </a>
                  {/if}
                {/foreach}
              </div>
            </div>
          {/if}
        </div>
      </div>
    </div>
  </div>
{/if}