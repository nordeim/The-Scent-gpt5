{block name='featured_products'}
<section id="products" class="products-section">
  <div class="container">
    <h2>{l s='Featured Collections' d='Shop.Theme.Catalog'}</h2>
    <div class="featured-products products-section">
      <div class="products">
        {foreach from=$products item="product" name="products"}
          {include file="catalog/_partials/miniatures/product.tpl" product=$product}
        {/foreach}
      </div>
      <div class="view-all-cta">
        <a href="{$allProductsLink}" class="btn btn-primary">
          {l s='View All Products' d='Shop.Theme.Catalog'}
        </a>
      </div>
    </div>
  </div>
</section>
{/block}
