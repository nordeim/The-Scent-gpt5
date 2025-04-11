{extends file='page.tpl'}

{block name='page_content'}
  {* Hero Section *}
  <section id="hero" class="hero-section">
    <div class="hero-media">
      {if isset($thescent_hero_image)}
        <img src="{$thescent_hero_image}" alt="{$shop.name}" loading="eager">
      {else}
        <img src="{$urls.theme_assets}img/hero-default.jpg" alt="{$shop.name}" loading="eager">
      {/if}
    </div>
    <div class="container hero-content">
      {if isset($cms_hero)}
        {$cms_hero.content nofilter}
      {else}
        <h1>Find Your Moment of Calm</h1>
        <p>Experience premium, natural aromatherapy crafted to enhance well-being and restore balance.</p>
      {/if}
      <a href="{$urls.pages.products}" class="btn btn-primary">Explore Our Collections</a>
    </div>
  </section>

  {* About Section *}
  {hook h='displayHomeAbout'}
  
  {* Products Section *}
  <section id="products" class="products-section">
    <div class="container">
      <h2>Featured Collections</h2>
      {hook h='displayFeaturedProducts'}
      <div class="view-all-cta">
        <a href="{$urls.pages.category}" class="btn btn-primary">Shop All Products</a>
      </div>
    </div>
  </section>
  
  {* Scent Finder Section *}
  {hook h='displayHomeFinder'}

  {* Testimonials Section *}
  {hook h='displayHomeTestimonials'}
{/block}