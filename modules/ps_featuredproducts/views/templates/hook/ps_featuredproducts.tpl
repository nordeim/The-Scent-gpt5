<section class="featured-products clearfix">
  <div class="products-section">
    <div class="product-grid">
      {foreach from=$products item="product"}
        {include file="catalog/_partials/miniatures/product.tpl" product=$product}
      {/foreach}
    </div>
    <div class="view-all-cta">
      <a href="{$allProductsLink}" class="btn btn-primary">
        {l s='View All Products' d='Shop.Theme.Catalog'}
      </a>
    </div>
  </div>
</section>
