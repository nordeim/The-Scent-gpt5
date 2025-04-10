{extends file='page.tpl'}

{block name='page_content'}
  <section id="hero" class="hero-section">
    <div class="hero-media">
      <img src="{$urls.theme_assets}img/hero-bg.jpg" alt="Calming Nature">
    </div>
    <div class="container hero-content">
      <h1>{l s='Find Your Moment of Calm' d='Shop.Theme.Global'}</h1>
      <p>{l s='Experience premium, natural aromatherapy crafted to enhance well-being and restore balance.' d='Shop.Theme.Global'}</p>
      <a href="{$urls.pages.shop}" class="btn btn-primary">{l s='Explore Our Collections' d='Shop.Theme.Global'}</a>
    </div>
  </section>

  <section id="about" class="about-section">
    <div class="container about-container">
      <div class="about-image">
        <img src="{$urls.theme_assets}img/about.jpg" alt="Natural Ingredients">
      </div>
      <div class="about-text">
        <h2>{l s='Rooted in Nature, Crafted with Care' d='Shop.Theme.Global'}</h2>
        <p>{l s='At The Scent, we harness the power of nature to nurture your mental and physical well-being. Our high-quality, sustainably sourced ingredients are transformed into exquisite aromatherapy products that help you reclaim balance and serenity.' d='Shop.Theme.Global'}</p>
        <a href="{$urls.pages.about}" class="btn btn-secondary">{l s='Learn Our Story' d='Shop.Theme.Global'}</a>
      </div>
    </div>
  </section>

  <section id="products" class="products-section">
    <div class="container">
      <h2>{l s='Featured Collections' d='Shop.Theme.Catalog'}</h2>
      {hook h='displayHome'}
      <div class="view-all-cta">
        <a href="{$urls.pages.shop}" class="btn btn-primary">{l s='Shop All Products' d='Shop.Theme.Global'}</a>
      </div>
    </div>
  </section>

  <section id="finder" class="finder-section">
    <div class="container">
      <h2>{l s='Discover Your Perfect Scent' d='Shop.Theme.Global'}</h2>
      <p class="finder-subtitle">{l s='Tailor your aromatherapy experience to your mood and needs.' d='Shop.Theme.Global'}</p>
      <div class="finder-grid">
        {* Finder cards will be added here or managed via CMS/module *}
      </div>
      <div class="finder-cta">
        <a href="#" class="btn btn-secondary">{l s='Take the Full Scent Quiz' d='Shop.Theme.Global'}</a>
      </div>
    </div>
  </section>
{/block}