{extends file='page.tpl'}

{block name='page_content'}
  {* Hero Section *}
  <section id="hero" class="hero-section">
    <div class="hero-media">
      <video autoplay muted loop playsinline>
        <source src="{$urls.theme_assets}videos/hero-bg.mp4" type="video/mp4">
        <img src="{$urls.theme_assets}img/hero-bg.jpg" alt="Calming Nature">
      </video>
    </div>
    <div class="container hero-content">
      <h1>{l s='Find Your Moment of Calm' d='Shop.Theme.Homepage'}</h1>
      <p>{l s='Experience premium, natural aromatherapy crafted to enhance well-being and restore balance.' d='Shop.Theme.Homepage'}</p>
      <a href="{$urls.pages.products}" class="btn btn-primary">{l s='Explore Our Collections' d='Shop.Theme.Homepage'}</a>
    </div>
  </section>

  {* About Section *}
  <section id="about" class="about-section">
    <div class="container about-container">
      <div class="about-image">
        <img src="{$urls.theme_assets}img/about.jpg" alt="Natural Ingredients">
      </div>
      <div class="about-text">
        <h2>{l s='Rooted in Nature, Crafted with Care' d='Shop.Theme.Homepage'}</h2>
        <p>{l s='At The Scent, we harness the power of nature to nurture your mental and physical well-being. Our high-quality, sustainably sourced ingredients are transformed into exquisite aromatherapy products that help you reclaim balance and serenity.' d='Shop.Theme.Homepage'}</p>
        <a href="{$urls.pages.cms['4']}" class="btn btn-secondary">{l s='Learn Our Story' d='Shop.Theme.Homepage'}</a>
      </div>
    </div>
  </section>

  {* Featured Products *}
  <section id="products" class="products-section">
    <div class="container">
      <h2>{l s='Featured Collections' d='Shop.Theme.Catalog'}</h2>
      {hook h='displayFeaturedProducts'}
    </div>
  </section>

  {* Scent Finder *}
  <section id="finder" class="finder-section">
    <div class="container">
      <h2>{l s='Discover Your Perfect Scent' d='Shop.Theme.Homepage'}</h2>
      <p class="finder-subtitle">{l s='Tailor your aromatherapy experience to your mood and needs.' d='Shop.Theme.Homepage'}</p>
      <div class="finder-grid">
        {include file='module:scent_finder/views/templates/hook/finder-categories.tpl'}
      </div>
      <div class="finder-cta">
        <a href="{$urls.pages.scent_finder}" class="btn btn-secondary">{l s='Take the Full Scent Quiz' d='Shop.Theme.Homepage'}</a>
      </div>
    </div>
  </section>

  {* Testimonials *}
  <section id="testimonials" class="testimonials-section">
    <div class="container">
      <h2>{l s='What Our Community Says' d='Shop.Theme.Homepage'}</h2>
      <div class="testimonial-grid">
        {include file='module:ps_testimonials/views/templates/hook/testimonials.tpl'}
      </div>
    </div>
  </section>

  {* Newsletter *}
  {block name='newsletter'}
    {include file='_partials/newsletter.tpl'}
  {/block}
{/block}