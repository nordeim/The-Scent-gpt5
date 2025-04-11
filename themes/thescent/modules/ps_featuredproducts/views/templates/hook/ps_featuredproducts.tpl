{block name='featured_products'}
<section class="featured-products">
  <div class="container">
    <h2 class="text-center">
      {l s='Our Featured Collections' d='Shop.Theme.Catalog'}
    </h2>
    
    <div class="products product-grid">
      {foreach from=$products item="product" name="featuredProducts"}
        {include file="catalog/_partials/miniatures/product.tpl" product=$product}
      {/foreach}
    </div>
    
    <div class="view-all-cta text-center">
      <a class="btn btn-secondary" href="{$allProductsLink}">
        {l s='View All Products' d='Shop.Theme.Catalog'}
      </a>
    </div>
  </div>
</section>
{/block}
