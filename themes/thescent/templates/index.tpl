{extends file='page.tpl'}

{block name='page_content_container'}
  <section class="page-home">
    {* Hero Section *}
    <div class="hero-section">
      <div class="hero-media">
        <video autoplay muted loop playsinline poster="{$urls.img_ps_url}hero-poster.jpg">
          <source src="{$urls.img_ps_url}hero-video.mp4" type="video/mp4">
        </video>
      </div>
      <div class="hero-content container">
        <h1>{l s='Discover the Power of Natural Aromatherapy' d='Shop.Theme.Global'}</h1>
        <p>{l s='Transform your space and elevate your well-being with our premium collection of essential oils and diffusers.' d='Shop.Theme.Global'}</p>
        <div class="hero-buttons">
          <a href="{$urls.pages.category}?id_category=2" class="btn btn-primary">
            {l s='Shop Collection' d='Shop.Theme.Global'}
          </a>
          <a href="#about-section" class="btn btn-secondary">
            {l s='Learn More' d='Shop.Theme.Global'}
          </a>
        </div>
      </div>
    </div>

    {* About Section *}
    <section id="about-section" class="about-section">
      <div class="container about-container">
        <div class="about-text">
          <h2>{l s='Pure. Natural. Effective.' d='Shop.Theme.Global'}</h2>
          <p>{l s='At The Scent, we believe in the transformative power of nature. Our carefully curated collection of essential oils is sourced from the finest natural ingredients, ensuring pure and potent aromatherapy experiences.' d='Shop.Theme.Global'}</p>
          <a href="{$urls.pages.about}" class="btn btn-secondary">
            {l s='Our Story' d='Shop.Theme.Global'}
          </a>
        </div>
        <div class="about-image">
          <img src="{$urls.img_ps_url}about-image.jpg" alt="{l s='About The Scent' d='Shop.Theme.Global'}" loading="lazy">
        </div>
      </div>
    </section>

    {* Featured Products *}
    {hook h='displayFeaturedProducts'}

    {* Scent Finder Section *}
    <section class="finder-section">
      <div class="container">
        <h2>{l s='Find Your Perfect Scent' d='Shop.Theme.Global'}</h2>
        <p class="finder-subtitle">{l s='Not sure where to start? Let us help you discover the perfect aromatherapy products for your needs.' d='Shop.Theme.Global'}</p>
        
        <div class="finder-grid">
          <div class="finder-card">
            <i class="far fa-heart finder-icon"></i>
            <h3>{l s='For Relaxation' d='Shop.Theme.Global'}</h3>
            <p>{l s='Calming scents for stress relief and relaxation' d='Shop.Theme.Global'}</p>
          </div>
          <div class="finder-card">
            <i class="fas fa-spa finder-icon"></i>
            <h3>{l s='For Wellness' d='Shop.Theme.Global'}</h3>
            <p>{l s='Supporting your health and well-being naturally' d='Shop.Theme.Global'}</p>
          </div>
          <div class="finder-card">
            <i class="far fa-sun finder-icon"></i>
            <h3>{l s='For Energy' d='Shop.Theme.Global'}</h3>
            <p>{l s='Invigorating scents to boost your energy' d='Shop.Theme.Global'}</p>
          </div>
          <div class="finder-card">
            <i class="fas fa-home finder-icon"></i>
            <h3>{l s='For Home' d='Shop.Theme.Global'}</h3>
            <p>{l s='Create your perfect atmosphere at home' d='Shop.Theme.Global'}</p>
          </div>
        </div>

        <div class="finder-cta">
          <a href="{$urls.pages.scent_finder}" class="btn btn-secondary">
            {l s='Take The Quiz' d='Shop.Theme.Global'}
          </a>
        </div>
      </div>
    </section>

    {* Testimonials *}
    {hook h='displayTestimonials'}

    {* Newsletter Section *}
    {hook h='displayNewsletterSubscription'}
  </section>
{/block}