Create the initial project file structure and the core files for the custom PrestaShop theme, "The Scent," based on the provided HTML and CSS files, 'improved landing page.html' and style.css.

**Assumptions:**

1.  You have a working PrestaShop installation (v1.7.x or 8.x, as the theme structure is similar).
2.  You will place this theme within the `/themes/` directory of your PrestaShop installation.
3.  We'll name the theme directory `thescent`.
4.  This focuses on creating the *theme* structure and integrating the *homepage* look and feel. Other pages (category, product detail, cart, checkout, account) will inherit the basic header/footer but will require further customization of their specific `.tpl` files and potentially CSS adjustments to fully match the design aesthetic.
5.  Dynamic content (menus, product lists, cart info) will rely on standard PrestaShop modules being enabled and hooked into the correct positions.

**1. Project File Structure (Inside `/themes/thescent/`)**

```
thescent/
├── _dev/                 # Optional: For source files like SASS/LESS if you use them
├── assets/
│   ├── css/
│   │   └── custom.css    # Our main CSS file (adapted from style.css)
│   ├── js/
│   │   └── custom.js     # Our custom JavaScript (from landing page)
│   ├── img/
│   │   └── logo.png      # Place your store logo here (example name)
│   └── fonts/            # If you were hosting fonts locally
├── config/
│   └── theme.yml         # Theme configuration file (CRITICAL)
├── modules/              # Overrides for module templates (start empty)
├── templates/
│   ├── index.tpl         # Homepage specific template
│   ├── _partials/
│   │   ├── header.tpl    # Header section
│   │   ├── footer.tpl    # Footer section
│   │   ├── head.tpl      # HTML head content (CSS, JS links)
│   │   └── notifications.tpl # To display PrestaShop messages
│   ├── catalog/
│   │   ├── listing/      # Templates for product lists (category, search...)
│   │   │   └── product-list.tpl # (Needs styling later)
│   │   ├── _partials/
│   │   │   └── miniatures/
│   │   │       └── product.tpl # Template for individual product blocks (CRITICAL for homepage grid)
│   │   └── product.tpl     # Product detail page (needs styling later)
│   ├── checkout/           # Cart & Checkout templates (need styling later)
│   │   └── cart.tpl
│   │   └── checkout.tpl
│   ├── cms/                # Static pages (About Us, T&C, etc.)
│   │   └── page.tpl        # (Needs styling later)
│   ├── customer/           # User account pages (need styling later)
│   │   └── my-account.tpl
│   │   └── login.tpl
│   ├── layouts/
│   │   └── layout-full-width.tpl # Base layout for most pages
│   │   └── layout-left-column.tpl # Example if you need sidebars
│   │   └── layout-right-column.tpl # Example if you need sidebars
│   └── errors/             # Error page templates (e.g., 404)
│       └── not-found.tpl
├── preview.png           # Screenshot of your theme (approx 160x218px)
└── LICENSE.txt           # Optional license file
```

---

**2. Necessary Project Files Content**

Here's the initial content for the key files, adapting your HTML/CSS:

**`thescent/config/theme.yml`** (Essential for theme recognition)

```yaml
name: thescent
display_name: The Scent Theme
version: 1.0.0
author:
  name: "Your Name" # Change this
  email: ""
  url: ""

meta:
  compatibility: # Specify PrestaShop versions this theme works with
    from: 1.7.7.0
    to: ~ # ~ means latest stable within the major version branch (e.g., 8.x)
  available_layouts:
    layout-full-width:
      name: Full Width
      description: No side columns, ideal for homepage and simple pages.
    layout-left-column:
      name: Two Columns, small left column
      description: A small left column ideal for category navigation.
    layout-right-column:
      name: Two Columns, small right column
      description: A small right column ideal for filters or banners.
    # Add more layouts if needed

assets: # Define assets to be loaded
  use_parent_assets: false # Set to true ONLY if this is a child theme inheriting from 'classic'
  css:
    all: # Load on all pages
      - id: theme-custom-css
        path: assets/css/custom.css
  js:
    all: # Load on all pages
      - id: theme-custom-js
        path: assets/js/custom.js
        priority: 200 # Adjust priority if needed
        position: bottom # Load JS at the bottom

global_settings:
  hooks:
    modules_to_hook:
      # Hooks needed for core functionality, ensure modules are installed/enabled
      displayNavFullWidth: # For main menu module (ps_mainmenu)
        - ps_mainmenu
      displayTop: # Alternative hook for menu, search, cart, user info
        - ps_customersignin
        # - ps_shoppingcart # Cart is often handled differently in modern themes, often via displayHeader hook or custom JS
        - ps_searchbar
      displayHeader: # Often used for cart module JS/data
        - ps_shoppingcart
      displayHome: # For featured products on homepage (ps_featuredproducts)
        - ps_featuredproducts
      displayFooter: # Footer links, info block (ps_linklist, ps_contactinfo)
        - ps_linklist
        - ps_contactinfo
        - ps_customeraccountlinks
      displayFooterBefore: # Good spot for newsletter block (ps_emailsubscription)
        - ps_emailsubscription
      # Add other essential hooks: displayProductAdditionalInfo, displayShoppingCartFooter, etc.
  image_types:
    cart_default:
      width: 125
      height: 125
      scope: [products]
    small_default:
      width: 98
      height: 98
      scope: [products, categories, manufacturers, suppliers]
    medium_default:
      width: 452
      height: 452
      scope: [products, manufacturers, suppliers]
    home_default: # Used by featured products potentially
      width: 250 # Match your .product-card img height/aspect ratio if possible
      height: 250
      scope: [products]
    large_default:
      width: 800
      height: 800
      scope: [products, manufacturers, suppliers]
    category_default:
      width: 141
      height: 180
      scope: [categories]
    stores_default:
      width: 170
      height: 115
      scope: [stores]

theme_settings:
  default_layout: layout-full-width # Set the default layout

dependencies: # Modules required by the theme
  modules:
    - ps_mainmenu
    - ps_featuredproducts
    - ps_emailsubscription
    - ps_shoppingcart
    - ps_customersignin
    - ps_searchbar
    - ps_linklist # For footer links
    - ps_contactinfo # For footer contact info
    - ps_customeraccountlinks # For footer account links
```

**`thescent/templates/layouts/layout-full-width.tpl`** (Base structure)

```smarty
{* Base layout structure for pages without sidebars *}
<!doctype html>
<html lang="{$language.iso_code}">

<head>
  {block name='head'}
    {include file='_partials/head.tpl'}
  {/block}
</head>

<body id="{$page.page_name}" class="{$page.body_classes|implode:' '}">

  {block name='hook_after_body_opening_tag'}
    {hook h='displayAfterBodyOpeningTag'}
  {/block}

  <main>
    {block name='header'}
      {include file='_partials/header.tpl'}
    {/block}

    {block name='notifications'}
      {include file='_partials/notifications.tpl'}
    {/block}

    {* --- Optional: Breadcrumb --- *}
    {block name='breadcrumb'}
      {* Example: Use a standard breadcrumb module hook *}
      {* {hook h='displayBreadcrumb'} *}
       {* You might need to wrap this in a <div class="container"> if needed *}
    {/block}


    <section id="wrapper">
      {block name='hook_wrapper_top'}
         {* Hook for content above main content area *}
         {hook h='displayWrapperTop'}
      {/block}

      {* No columns structure here, direct content *}
      <div class="container"> {* Add container if needed around content *}
        {block name='content'}
          {* Page specific content will be injected here *}
        {/block}
      </div>

      {block name='hook_wrapper_bottom'}
         {* Hook for content below main content area *}
         {hook h='displayWrapperBottom'}
      {/block}
    </section>

    {block name='footer'}
      {include file='_partials/footer.tpl'}
    {/block}

  </main>

  {block name='javascript_bottom'}
    {include file="_partials/javascript.tpl" javascript=$javascript.bottom}
  {/block}

  {block name='hook_before_body_closing_tag'}
    {hook h='displayBeforeBodyClosingTag'}
  {/block}

</body>

</html>
```

**`thescent/templates/_partials/head.tpl`** (HTML Head Content)

```smarty
{* PrestaShop standard head elements + Custom additions *}
{block name='head_charset'}
  <meta charset="utf-8">
{/block}
{block name='head_ie_compatibility'}
  <meta http-equiv="x-ua-compatible" content="ie=edge">
{/block}

{block name='head_seo'}
  <title>{$page.meta.title}</title>
  <meta name="description" content="{$page.meta.description}">
  <meta name="keywords" content="{$page.meta.keywords}">
  {if $page.meta.robots !== 'index'}
    <meta name="robots" content="{$page.meta.robots}">
  {/if}
  {if $page.canonical}
    <link rel="canonical" href="{$page.canonical}">
  {/if}
  {* You can add hreflang links here if needed for multilingual sites *}
  {* {foreach from=$urls.alternative_langs item=pageUrl key=code}
    <link rel="alternate" href="{$pageUrl}" hreflang="{$code}">
  {/foreach} *}
{/block}

{block name='head_viewport'}
  <meta name="viewport" content="width=device-width, initial-scale=1">
{/block}

{block name='head_icons'}
  <link rel="icon" type="image/vnd.microsoft.icon" href="{$shop.favicon}?v={$shop.favicon_update_time}">
  <link rel="shortcut icon" type="image/x-icon" href="{$shop.favicon}?v={$shop.favicon_update_time}">
{/block}

{* --- Custom Additions Start --- *}
{block name='head_fonts'}
  {* Google Fonts *}
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;600;700&family=Montserrat:wght@300;400;500&family=Raleway:wght@400;500;600&display=swap" rel="stylesheet">
  {* Font Awesome for Icons *}
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
{/block}
{* --- Custom Additions End --- *}

{block name='stylesheets'}
  {include file="_partials/stylesheets.tpl" stylesheets=$stylesheets}
{/block}

{block name='javascript_head'}
  {include file="_partials/javascript.tpl" javascript=$javascript.head vars=$js_custom_vars}
{/block}

{block name='hook_header'}
  {$HOOK_HEADER nofilter} {* Renders things like Analytics code, cart data *}
{/block}

{block name='hook_extra'}
  {hook h='displayExtraHead'}
{/block}
```

**`thescent/templates/_partials/header.tpl`** (Adapted Header)

```smarty
{block name='header'}
  {block name='header_nav'}
    {* Optional Top Nav Bar - if needed, often used for contact info, lang/currency selectors *}
    {* <nav class="header-nav">
      <div class="container">
        {hook h='displayNav1'} {* Hook for language/currency *}
        {hook h='displayNav2'} {* Hook for contact link, sign in/out *}
      </div>
    </nav> *}
  {/block}

  {block name='header_top'}
    {* --- Main Header Area --- *}
    <header class="main-header {if $page.page_name == 'index'}absolute{/if}"> {* Add logic if absolute positioning is only for homepage *}
      <div class="container header-container">
        <div class="logo" id="_desktop_logo">
          <a href="{$urls.base_url}">
            {* Use Image Logo *}
            {* <img class="logo img-responsive" src="{$shop.logo}" alt="{$shop.name}"> *}

            {* Use Text Logo based on HTML *}
             {$shop.name} {* Or use 'The Scent' directly if preferred *}
             <span>AROMATHERAPY</span>
          </a>
        </div>

        {* --- Desktop Main Navigation --- *}
        <nav class="main-nav" id="_desktop_top_menu">
          {hook h='displayNavFullWidth'} {* Hook for ps_mainmenu *}
          {* Example Fallback/Manual structure if not using module: *}
          {* <ul>
            <li><a href="{$urls.pages.index}">Home</a></li>
            <li><a href="{$link->getCategoryLink(3)}">Shop</a></li> {* Replace 3 with actual shop category ID *}
            <li><a href="#finder">Scent Finder</a></li> {* Requires corresponding ID on homepage *}
            <li><a href="{$link->getCMSLink(4)}">About</a></li> {* Replace 4 with actual About Us CMS page ID *}
            <li><a href="{$link->getPageLink('contact')}">Contact</a></li>
          </ul> *}
        </nav>

        {* --- Desktop Header Icons --- *}
        <div class="header-icons" id="_desktop_header_icons">
           <div id="_desktop_search_widget">
             {hook h='displaySearch'} {* Hook for ps_searchbar *}
           </div>
           <div id="_desktop_user_info">
             {hook h='displayCustomerAccount'} {* Hook for ps_customersignin *}
           </div>
           <div id="_desktop_cart">
             {hook h='displayShoppingCart'} {* Hook for ps_shoppingcart - might need custom implementation *}
           </div>
        </div>

        {* --- Mobile Toggle Button --- *}
        <button class="mobile-nav-toggle" id="_mobile_menu_toggle" aria-label="{l s='Toggle navigation' d='Shop.Theme.Actions'}">
          <i class="fas fa-bars"></i>
        </button>
      </div>

      {* --- Mobile Menu (hidden by default) --- *}
      <nav class="mobile-nav" id="_mobile_nav">
         {* Hook content is preferred, but requires module compatibility/overrides *}
         {* {hook h='displayMobileTopSiteMap'} *}
         {* Fallback: Replicate links from desktop or provide essential ones *}
         <ul>
           <li><a href="{$urls.pages.index}">Home</a></li>
           <li><a href="{$link->getCategoryLink(3)}">Shop</a></li> {* Replace 3 *}
           <li><a href="#finder">Scent Finder</a></li>
           <li><a href="{$link->getCMSLink(4)}">About</a></li> {* Replace 4 *}
           <li><a href="{$link->getPageLink('contact')}">Contact</a></li>
           <li class="separator">--</li>
           {* Include mobile versions of search, account, cart if not handled by specific mobile hooks *}
           <li> {hook h='displaySearch'}</li>
           <li> {hook h='displayCustomerAccount'}</li>
           <li> {hook h='displayShoppingCart'}</li>
         </ul>
      </nav>
       {* Hook for elements below the main nav/header area *}
       {hook h='displayNavFullWidth'}
    </header>
  {/block}
{/block}
```

**`thescent/templates/_partials/footer.tpl`** (Adapted Footer)

```smarty
{block name='footer'}
<footer id="contact" class="main-footer">
  <div class="container">
    <div class="footer-grid">

      {* --- About & Social --- *}
      <div class="footer-about">
        {block name='hook_footer_about'}
           {* Use Contact Info Module or hardcode *}
           {hook h='displayFooterContact'}
           {* Example using contact info module data if available: *}
           {* <h3>{$shop.name}</h3> *}
           {* <p>{$contact_infos.description}</p> *}

           {* Fallback using hardcoded text based on HTML: *}
            <h3>About The Scent</h3>
            <p>Creating premium aromatherapy products to enhance mental and physical well-being through the power of nature.</p>

           <div class="social-icons">
             {* Example using hook (if theme/module supports it) *}
             {* {hook h='displayFollowButtons'} *}
             {* Fallback: hardcoded links - replace # with actual URLs *}
             <a href="#" aria-label="Facebook"><i class="fab fa-facebook-f"></i></a>
             <a href="#" aria-label="Instagram"><i class="fab fa-instagram"></i></a>
             <a href="#" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
             <a href="#" aria-label="Pinterest"><i class="fab fa-pinterest"></i></a>
           </div>
        {/block}
      </div>

      {* --- Footer Links (Using ps_linklist module is recommended) --- *}
      {block name='hook_footer_links'}
        {hook h='displayFooter'} {* This hook usually renders ps_linklist blocks *}

        {* Example Fallback structure if not using linklist module: *}
        {* <div class="footer-links">
          <h3>Shop</h3>
          <ul>
            <li><a href="{$link->getCategoryLink(4)}">Essential Oils</a></li> {* Replace 4 *}
            <li><a href="{$link->getCategoryLink(5)}">Natural Soaps</a></li> {* Replace 5 *}
            <li><a href="#">Gift Sets</a></li>
            <li><a href="#">New Arrivals</a></li>
            <li><a href="#">Bestsellers</a></li>
          </ul>
        </div>
        <div class="footer-links">
          <h3>Help</h3>
          <ul>
            <li><a href="{$link->getPageLink('contact')}">Contact Us</a></li>
            <li><a href="{$link->getCMSLink(1)}">FAQs</a></li> {* Replace 1 *}
            <li><a href="{$link->getCMSLink(2)}">Shipping & Returns</a></li> {* Replace 2 *}
            <li><a href="#">Track Your Order</a></li> {* Requires specific integration *}
            <li><a href="{$link->getCMSLink(3)}">Privacy Policy</a></li> {* Replace 3 *}
          </ul>
        </div> *}
      {/block}

      {* --- Contact Info (Using ps_contactinfo module is recommended) --- *}
       <div class="footer-contact">
         {block name='hook_footer_contact_info'}
            {* Hook is preferred *}
            {* {hook h='displayContactFooter'} *}
            {* Fallback using contact info variables: *}
            {* <h3>{l s='Contact Us' d='Shop.Theme.Global'}</h3>
            <p><i class="fas fa-map-marker-alt"></i> {$contact_infos.address.formatted nofilter}</p>
            {if $contact_infos.phone}
              <p><i class="fas fa-phone"></i> {$contact_infos.phone}</p>
            {/if}
            {if $contact_infos.email}
              <p><i class="fas fa-envelope"></i> {$contact_infos.email}</p>
            {/if} *}

            {* Absolute Fallback hardcoded based on HTML: *}
             <h3>Contact Us</h3>
             <p><i class="fas fa-map-marker-alt"></i> 123 Aromatherapy Lane, Wellness City, WB 12345</p>
             <p><i class="fas fa-phone"></i> +1 (555) 123-4567</p>
             <p><i class="fas fa-envelope"></i> hello@thescent.com</p>
         {/block}
       </div>

    </div> {* End .footer-grid *}
  </div> {* End .container *}

  {* --- Footer Bottom --- *}
  <div class="footer-bottom">
    <div class="container">
      <p>&copy; {$smarty.now|date_format:'%Y'} {$shop.name}. {l s='All rights reserved.' d='Shop.Theme.Global'}</p>
      <div class="payment-methods">
        {* This could be driven by a module hook if available, or hardcoded *}
        <span>{l s='Accepted Payments:' d='Shop.Theme.Checkout'}</span>
        <i class="fab fa-cc-visa"></i>
        <i class="fab fa-cc-mastercard"></i>
        <i class="fab fa-cc-paypal"></i>
        <i class="fab fa-cc-amex"></i>
      </div>
    </div>
  </div>
</footer>
{/block}
```

**`thescent/templates/index.tpl`** (Homepage Content - Integrating Sections)

```smarty
{**
 * @file
 * Homepage template file.
 *}

{extends file='layouts/layout-full-width.tpl'} {* Use the full-width layout *}

{block name='content'}

  {* --- Hero Section --- *}
  <section id="hero" class="hero-section">
    <div class="hero-media">
      {* PrestaShop doesn't have built-in video background handling easily. *}
      {* Option 1: Use a module for sliders/hero banners that supports video *}
      {* Option 2: Use CSS background-image as fallback if video fails or isn't set *}
      {* Option 3: Hardcode video (requires path to be correct within theme assets or absolute URL) *}
      {* <video autoplay muted loop playsinline>
        <source src="{$urls.theme_assets}path/to/your/video.mp4" type="video/mp4"> *}
        {* Fallback image - Use a configurable image from a module if possible *}
        <img src="https://raw.githubusercontent.com/nordeim/The-Scent/refs/heads/main/images/scent5.jpg" alt="Calming Nature">
      {* </video> *}
    </div>
    <div class="container hero-content">
      {* Make text configurable via back office if needed (e.g., Custom text module) *}
      <h1>Find Your Moment of Calm</h1>
      <p>Experience premium, natural aromatherapy crafted to enhance well-being and restore balance.</p>
      <a href="#products" class="btn btn-primary">Explore Our Collections</a> {* Link to section below *}
      {* Or link directly to shop page: <a href="{$link->getCategoryLink(3)}" class="btn btn-primary">...</a> *}
    </div>
  </section>

  {* --- About/Mission Section --- *}
  {* For easy editing, this content should ideally come from a CMS page or a dedicated module *}
  {* Hook example: {hook h='displayHomeTextBlock'} *}
  {* Hardcoded based on HTML for now: *}
  <section id="about" class="about-section">
    <div class="container about-container">
      <div class="about-image">
        <img src="https://raw.githubusercontent.com/nordeim/The-Scent/refs/heads/main/images/scent6.jpg" alt="Natural Ingredients">
      </div>
      <div class="about-text">
        <h2>Rooted in Nature, Crafted with Care</h2>
        <p>At The Scent, we harness the power of nature to nurture your mental and physical well-being. Our high-quality, sustainably sourced ingredients are transformed into exquisite aromatherapy products that help you reclaim balance and serenity.</p>
        <a href="{$link->getCMSLink(4)}" class="btn btn-secondary">Learn Our Story</a> {* Replace 4 with About Us CMS Page ID *}
      </div>
    </div>
  </section>

  {* --- Featured Products Section --- *}
  <section id="products" class="products-section">
    <div class="container">
      <h2>Featured Collections</h2>
      {block name='hook_home'}
        {$HOOK_HOME nofilter} {* This renders modules hooked to displayHome, like ps_featuredproducts *}
      {/block}
      <div class="view-all-cta">
         <a href="{$link->getCategoryLink(3)}" class="btn btn-primary">Shop All Products</a> {* Replace 3 with main Shop Category ID *}
      </div>
    </div>
  </section>

  {* --- Scent Finder Section --- *}
  {* This could be a custom module or just static content linking to a quiz page/category *}
  {* Hardcoded based on HTML for now: *}
  <section id="finder" class="finder-section">
    <div class="container">
      <h2>Discover Your Perfect Scent</h2>
      <p class="finder-subtitle">Tailor your aromatherapy experience to your mood and needs.</p>
      <div class="finder-grid">
        {* These cards could link to specific category pages *}
        <div class="finder-card" onclick="location.href='{$link->getCategoryLink(6)}';"> {* Replace 6 etc. with category IDs *}
          <i class="fas fa-leaf finder-icon"></i>
          <h3>Relaxation</h3>
          <p>Calming scents to help you unwind.</p>
        </div>
        <div class="finder-card" onclick="location.href='{$link->getCategoryLink(7)}';">
          <i class="fas fa-bolt finder-icon"></i>
          <h3>Energy</h3>
          <p>Invigorating aromas to uplift your day.</p>
        </div>
        <div class="finder-card" onclick="location.href='{$link->getCategoryLink(8)}';">
          <i class="fas fa-brain finder-icon"></i>
          <h3>Focus</h3>
          <p>Clarifying blends for a clear mind.</p>
        </div>
         <div class="finder-card" onclick="location.href='{$link->getCategoryLink(9)}';">
            <i class="fas fa-moon finder-icon"></i>
            <h3>Sleep</h3>
            <p>Soothing scents for a peaceful night's rest.</p>
          </div>
          <div class="finder-card" onclick="location.href='{$link->getCategoryLink(10)}';">
            <i class="fas fa-balance-scale finder-icon"></i>
            <h3>Balance</h3>
            <p>Harmonious aromas to center you.</p>
          </div>
      </div>
      <div class="finder-cta">
        <a href="#" class="btn btn-secondary">Take the Full Scent Quiz</a> {* Link to actual quiz page/tool *}
      </div>
    </div>
  </section>

  {* --- Testimonials Section --- *}
  {* Best handled by a dedicated testimonials module *}
  {* Hook example: {hook h='displayHomeTestimonials'} *}
  {* Hardcoded based on HTML for now: *}
  <section id="testimonials" class="testimonials-section">
    <div class="container">
      <h2>What Our Community Says</h2>
      <div class="testimonial-grid">
        <div class="testimonial-card">
          <p>"The Lavender Essential Oil transformed my bedtime routine—its calming aroma truly helps me unwind."</p>
          <span class="testimonial-author">- Sarah L., Los Angeles</span>
          <div class="testimonial-rating">★★★★★</div>
        </div>
        <div class="testimonial-card">
          <p>"The Focus Blend oil improved my concentration at home without overwhelming my senses."</p>
          <span class="testimonial-author">- Michael T., Chicago</span>
          <div class="testimonial-rating">★★★★★</div>
        </div>
        <div class="testimonial-card">
          <p>"Handcrafted soaps that feel divine and truly nourish sensitive skin. A luxurious experience."</p>
          <span class="testimonial-author">- Emma R., Seattle</span>
          <div class="testimonial-rating">★★★★★</div>
        </div>
      </div>
    </div>
  </section>

  {* --- Newsletter Section --- *}
  {* This is usually hooked in the footer or footerBefore area via theme.yml *}
  {* If you need it specifically here, you might need a custom hook or module placement *}
  {* Example Hook: {hook h='displayHomeNewsletter'} *}
  {* Alternatively, structure is often in modules/ps_emailsubscription/views/templates/hook/ps_emailsubscription.tpl *}
  {* We will rely on the hook defined in theme.yml: displayFooterBefore *}

{/block}
```

**`thescent/templates/catalog/_partials/miniatures/product.tpl`** (Styling for Product Grid Items - CRITICAL)

```smarty
{**
 * @file Defines the product miniature template. Needs heavy styling based on .product-card CSS.
 *}
{block name='product_miniature_item'}
  <article class="product-miniature js-product-miniature product-card" data-id-product="{$product.id_product}" data-id-product-attribute="{$product.id_product_attribute}">
    <div class="thumbnail-container"> {* Corresponds roughly to the outer div of product-card *}
      {block name='product_thumbnail'}
        <a href="{$product.url}" class="thumbnail product-thumbnail">
          <img
            src="{$product.cover.bySize.home_default.url}" {* Use the 'home_default' image size defined in theme.yml *}
            alt="{$product.cover.legend|escape:'html':'UTF-8'}"
            data-full-size-image-url="{$product.cover.large.url}"
            width="{$product.cover.bySize.home_default.width}"
            height="{$product.cover.bySize.home_default.height}"
            loading="lazy"
          >
        </a>
      {/block}

      {* --- Optional: Quick View --- *}
      {* <div class="product-quick-view">
        <a class="quick-view" href="#" data-link-action="quickview">
          <i class="material-icons search">&#xE8B6;</i> {l s='Quick view' d='Shop.Theme.Actions'}
        </a>
      </div> *}

      {* --- Optional: Product Flags (New, On Sale) --- *}
     {* <ul class="product-flags">
        {foreach from=$product.flags item=flag}
          <li class="product-flag {$flag.type}">{$flag.label}</li>
        {/foreach}
      </ul> *}
    </div>

    <div class="product-description product-info"> {* Corresponds to .product-info *}
      {block name='product_name'}
        <h3 class="h3 product-title"><a href="{$product.url}">{$product.name|truncate:30:'...'}</a></h3>
      {/block}

      {block name='product_description_short'} {* Adding the short description / subtitle from your design *}
          <p>{$product.description_short|strip_tags:'UTF-8'|truncate:50:'...'}</p> {* Adjust truncation as needed *}
      {/block}

      {block name='product_price_and_shipping'}
        {if $product.show_price}
          <div class="product-price-and-shipping">
            {* Display Price *}
            <span class="price" aria-label="{l s='Price' d='Shop.Theme.Catalog'}">{$product.price}</span>

            {if $product.has_discount}
              {hook h='displayProductPriceBlock' product=$product type="old_price"}
              <span class="regular-price" aria-label="{l s='Regular price' d='Shop.Theme.Catalog'}">{$product.regular_price}</span>
              {if $product.discount_type === 'percentage'}
                <span class="discount-percentage discount-product">{$product.discount_percentage}</span>
              {elseif $product.discount_type === 'amount'}
                <span class="discount-amount discount-product">{$product.discount_amount_to_display}</span>
              {/if}
            {/if}

            {hook h='displayProductPriceBlock' product=$product type="before_price"}
            {hook h='displayProductPriceBlock' product=$product type='unit_price'}
            {hook h='displayProductPriceBlock' product=$product type='weight'}
          </div>
        {/if}
      {/block}

      {* --- View Product Link (from your design) --- *}
      <div class="product-link-wrapper">
        <a href="{$product.url}" class="product-link">{l s='View Product' d='Shop.Theme.Actions'}</a>
      </div>

      {* --- Optional: Add to Cart Button (can be added here or rely on quick view) --- *}
      {* <div class="product-add-to-cart">
        {include file='catalog/_partials/customize/button-cart.tpl'}
      </div> *}

    </div>
  </article>
{/block}

```

**`thescent/assets/css/custom.css`**

```css
/* --- Base Styles & Variables --- */
:root {
  --font-heading: 'Cormorant Garamond', serif;
  --font-body: 'Montserrat', sans-serif;
  --font-accent: 'Raleway', sans-serif;

  --color-primary: #1A4D5A; /* Deep Teal */
  --color-secondary: #A0C1B1; /* Soft Mint Green */
  --color-accent: #D4A76A; /* Muted Gold/Ochre */
  --color-background: #F8F5F2; /* Warm Off-White */
  --color-text: #333333;
  --color-text-light: #FFFFFF;
  --color-border: #e0e0e0;

  --container-width: 1200px;
  --spacing-unit: 1rem;
  --transition-speed: 0.3s;
}

/* --- COPY ALL CSS RULES FROM YOUR style.css FILE HERE --- */
/* --- Ensure paths for background images etc. are relative, e.g., ../img/background.jpg --- */

*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
html { scroll-behavior: smooth; font-size: 100%; }
body {
  font-family: var(--font-body);
  background-color: var(--color-background);
  color: var(--color-text);
  line-height: 1.7;
  /* overflow-x: hidden; */ /* Be careful with this on body, might hide scrollbars needed by PS elements */
}

/* Headings & Paragraphs */
h1, h2, h3, h4, h5, h6 {
  font-family: var(--font-heading);
  font-weight: 600;
  color: var(--color-primary);
  margin-bottom: calc(var(--spacing-unit) * 1);
  line-height: 1.2;
}
h1 { font-size: clamp(2.5rem, 5vw, 4rem); }
h2 { font-size: clamp(1.8rem, 4vw, 2.8rem); }
h3 { font-size: clamp(1.3rem, 3vw, 1.8rem); }
p { margin-bottom: calc(var(--spacing-unit) * 1); max-width: 70ch; } /* Check this max-width doesn't break PS layouts */

a { color: var(--color-primary); text-decoration: none; transition: color var(--transition-speed) ease; }
a:hover, a:focus { color: var(--color-accent); }
img { max-width: 100%; display: block; height: auto; } /* Added height: auto */
ul { list-style: none; padding-left: 0; } /* Added padding-left: 0 */

/* Container */
/* PrestaShop uses .container class already, ensure your styles merge or override correctly */
.container {
  width: 90%;
  max-width: var(--container-width);
  margin: 0 auto;
  padding-left: var(--spacing-unit); /* Use padding-left/right instead of padding: 0 var(--...) */
  padding-right: var(--spacing-unit);
}

/* Buttons */
/* Ensure PrestaShop's default button classes don't conflict heavily */
/* Target specific PS buttons if needed: e.g., .btn.btn-primary, form button[type=submit] */
.btn {
  display: inline-block;
  font-family: var(--font-accent);
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  padding: calc(var(--spacing-unit) * 0.8) calc(var(--spacing-unit) * 2);
  border-radius: 50px;
  cursor: pointer;
  transition: background-color var(--transition-speed) ease, transform var(--transition-speed) ease, border-color var(--transition-speed) ease; /* Added border-color transition */
  border: 2px solid transparent;
  line-height: normal; /* Add line-height */
}
.btn-primary {
  background-color: var(--color-primary);
  color: var(--color-text-light) !important; /* Use !important carefully if needed to override PS defaults */
  border-color: var(--color-primary);
}
.btn-primary:hover,
.btn-primary:focus {
  background-color: var(--color-accent);
  border-color: var(--color-accent);
  transform: translateY(-2px);
  color: var(--color-text-light) !important;
}
.btn-secondary {
  background-color: transparent;
  color: var(--color-primary);
  border-color: var(--color-primary);
}
.btn-secondary:hover,
.btn-secondary:focus {
  background-color: var(--color-primary);
  color: var(--color-text-light) !important;
  transform: translateY(-2px);
  border-color: var(--color-primary); /* Keep border color on hover? Or match bg? */
}


/* --- Header --- */
.main-header {
  /* position: absolute; */ /* Apply conditionally via JS or Smarty variable for homepage only */
  top: 0;
  left: 0;
  width: 100%;
  z-index: 1000;
  padding: calc(var(--spacing-unit) * 1.5) 0;
  background: transparent;
  transition: background-color var(--transition-speed) ease, box-shadow var(--transition-speed) ease, padding var(--transition-speed) ease;
}
/* Add class 'header-absolute' on homepage body or header tag for this */
body#index .main-header, .main-header.header-absolute {
     position: absolute;
}


/* When sticky, apply a light background and update text colors */
.main-header.sticky {
  position: fixed;
  background-color: rgba(255, 255, 255, 0.95);
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  padding: calc(var(--spacing-unit) * 0.8) 0;
}
.main-header.sticky .logo a,
.main-header.sticky .logo span {
   color: var(--color-primary); /* Target text logo */
}
/* Target specific module links if needed */
.main-header.sticky #_desktop_top_menu a, /* Target menu module container */
.main-header.sticky .header-icons a { /* Target icon container */
  color: var(--color-primary);
}
/* Specifically target text logo */
.main-header .logo a {
  font-family: var(--font-heading);
  font-size: 1.8rem;
  font-weight: 700;
  color: var(--color-text-light);
  text-transform: uppercase;
  letter-spacing: 1px;
  text-decoration: none; /* Ensure no underline */
}
/* Adjust if using image logo */
.main-header .logo img {
    max-height: 50px; /* Example max height */
    width: auto;
}

.main-header .logo span {
  display: block;
  font-family: var(--font-accent);
  font-size: 0.6rem;
  letter-spacing: 3px;
  text-transform: uppercase;
  color: var(--color-text-light);
  margin-top: -5px;
  opacity: 0.8;
}

/* Style the containers for modules */
.header-container { display: flex; justify-content: space-between; align-items: center; }

/* Style PrestaShop Menu (ps_mainmenu often uses #main-menu) */
#_desktop_top_menu ul, .main-nav ul { /* Target both potential structures */
    display: flex;
    gap: calc(var(--spacing-unit) * 2);
    list-style: none;
    margin: 0;
    padding: 0;
}
#_desktop_top_menu a, .main-nav a {
  font-family: var(--font-accent);
  font-weight: 500;
  color: var(--color-text-light); /* Default color for non-sticky */
  text-transform: uppercase;
  letter-spacing: 1px;
  padding: 5px 0;
  position: relative;
  text-decoration: none;
  transition: color var(--transition-speed) ease; /* Add transition */
}
#_desktop_top_menu a::after, .main-nav a::after {
  content: '';
  position: absolute;
  width: 0;
  height: 2px;
  bottom: 0;
  left: 50%;
  transform: translateX(-50%);
  background-color: var(--color-accent);
  transition: width var(--transition-speed) ease;
}
#_desktop_top_menu a:hover, .main-nav a:hover,
#_desktop_top_menu a:focus, .main-nav a:focus {
    color: var(--color-accent); /* Hover color for non-sticky */
}
.main-header.sticky #_desktop_top_menu a:hover,
.main-header.sticky #_desktop_top_menu a:focus {
     color: var(--color-accent); /* Hover color for sticky */
}

#_desktop_top_menu a:hover::after, .main-nav a:hover::after,
#_desktop_top_menu a:focus::after, .main-nav a:focus::after { width: 100%; }

/* Style Header Icons (Need to target specific module wrappers) */
.header-icons { display: flex; gap: calc(var(--spacing-unit) * 1.5); align-items: center;}
.header-icons a {
    color: var(--color-text-light); /* Default color non-sticky */
    font-size: 1.2rem;
    transition: color var(--transition-speed) ease;
    text-decoration: none;
}
.header-icons a:hover, .header-icons a:focus {
     color: var(--color-accent); /* Hover color non-sticky */
}
.main-header.sticky .header-icons a:hover,
.main-header.sticky .header-icons a:focus {
     color: var(--color-accent); /* Hover color sticky */
}

/* Style specific icons if needed (e.g., cart count) */
#_desktop_cart .cart-products-count {
    background: var(--color-accent);
    color: var(--color-primary);
    border-radius: 50%;
    font-size: 0.7rem;
    padding: 2px 5px;
    position: relative;
    top: -8px;
    left: -5px;
}

/* Mobile Nav Toggle */
.mobile-nav-toggle {
  display: none; /* Default hidden, shown via media query */
  background: none;
  border: none;
  color: var(--color-text-light); /* Default color non-sticky */
  font-size: 1.5rem;
  cursor: pointer;
  z-index: 1001;
  padding: 0; /* Remove default button padding */
}
.main-header.sticky .mobile-nav-toggle {
    color: var(--color-primary); /* Color when sticky */
}

/* Mobile Nav Panel */
.mobile-nav {
    display: none; /* Hidden until active */
    position: absolute;
    top: 100%; /* Position below header */
    left: 0;
    width: 100%;
    background-color: rgba(255, 255, 255, 0.98);
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    padding: var(--spacing-unit);
    max-height: 0;
    overflow: hidden;
    transition: max-height 0.5s ease-out, padding 0.5s ease-out; /* Add padding transition */
}
.mobile-nav.active {
    display: block; /* Show when active */
    max-height: 70vh; /* Use vh or large px value */
    padding: var(--spacing-unit);
    overflow-y: auto; /* Allow scrolling if content is long */
}

/* Change header background when mobile menu is open */
.main-header.mobile-menu-active {
    background-color: rgba(255, 255, 255, 0.98);
    position: fixed; /* Ensure it stays fixed when mobile menu is open */
}
/* Ensure logo/toggle color changes when mobile menu is active and header becomes white */
.main-header.mobile-menu-active .logo a,
.main-header.mobile-menu-active .logo span,
.main-header.mobile-menu-active .mobile-nav-toggle {
    color: var(--color-primary);
}

.mobile-nav ul {
    display: flex;
    flex-direction: column;
    gap: var(--spacing-unit);
    list-style: none;
    padding: 0; margin: 0;
}
.mobile-nav a {
  display: block;
  padding: calc(var(--spacing-unit) * 0.5);
  color: var(--color-primary);
  font-family: var(--font-accent);
  text-transform: uppercase;
  text-align: center;
  font-size: 1.1rem;
  transition: background-color var(--transition-speed) ease, color var(--transition-speed) ease; /* Added color transition */
  text-decoration: none;
}
.mobile-nav a:hover, .mobile-nav a:focus {
  background-color: var(--color-secondary);
  color: var(--color-primary);
}
/* Style separators or module wrappers if needed */
.mobile-nav .separator { display: none; } /* Hide separator from TPL for now */
.mobile-nav #search_widget form input[type=text] { /* Example: Style mobile search */
    width: 100%;
    padding: 0.5rem;
    border: 1px solid var(--color-border);
    margin-bottom: 0.5rem;
}


/* --- Hero Section --- */
.hero-section {
  position: relative;
  height: 100vh; /* Full viewport height */
  min-height: 600px; /* Minimum height */
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
  overflow: hidden;
  color: var(--color-text-light);
  background-color: var(--color-primary); /* Fallback bg color */
}
/* Ensure header doesn't overlap hero content when absolute */
body#index {
    padding-top: 0; /* Remove any default padding */
}
body#index main > section:first-child {
     margin-top: 0; /* Ensure no margin above hero */
}

.hero-media {
  position: absolute;
  top: 0; left: 0;
  width: 100%; height: 100%;
  overflow: hidden;
  z-index: 1; /* Below overlay */
}
.hero-media video,
.hero-media img {
  width: 100%;
  height: 100%;
  object-fit: cover; /* Cover the area */
  animation: zoomInOut 25s infinite alternate ease-in-out;
}
.hero-section::before { /* Overlay */
  content: '';
  position: absolute;
  top: 0; left: 0;
  width: 100%; height: 100%;
  background-color: rgba(0,0,0,0.4);
  z-index: 2; /* Above media, below content */
}
.hero-content {
  position: relative;
  z-index: 3; /* Above overlay */
  max-width: 800px;
  padding: var(--spacing-unit); /* Add padding for smaller screens */
  animation: fadeIn 1.5s ease-out;
}
/* Apply text shadow only to H1 within hero */
.hero-content h1 {
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.7);
  color: var(--color-text-light); /* Ensure H1 is light */
  margin-bottom: calc(var(--spacing-unit) * 1);
}
.hero-content p {
    font-size: 1.2rem;
    margin-bottom: calc(var(--spacing-unit) * 2);
    max-width: 60ch;
    margin-left: auto;
    margin-right: auto;
    color: var(--color-text-light); /* Ensure p is light */
}

/* Animations */
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(20px); }
  to { opacity: 1; transform: translateY(0); }
}
@keyframes zoomInOut {
  from { transform: scale(1); }
  to { transform: scale(1.05); }
}

/* --- Generic Section Styling --- */
/* Be careful applying padding directly to <section>, PS structure might have wrappers */
/* It might be better to apply padding to the .container within each section */
#wrapper section { /* Target sections within the main wrapper */
     padding: calc(var(--spacing-unit) * 5) 0;
}
/* Style sections based on ID or class if needed for background */
#about, #testimonials { background-color: #fff; }
#products { background-color: var(--color-background); } /* Assuming default bg */
#finder { background-color: var(--color-secondary); }
#newsletter { background-color: var(--color-primary); }

#wrapper section h2 { /* Target h2 within sections */
    text-align: center;
    margin-bottom: calc(var(--spacing-unit) * 3);
}

/* --- About Section --- */
/* #about is handled by generic section style */
.about-container {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: calc(var(--spacing-unit) * 4);
    align-items: center;
}
.about-image img {
    border-radius: 8px;
    box-shadow: 0 10px 20px rgba(0,0,0,0.1);
    transition: transform var(--transition-speed) ease;
}
.about-image img:hover { transform: scale(1.03); }
.about-text h2 { text-align: left; } /* Override generic centered h2 */
.about-text p { margin-bottom: calc(var(--spacing-unit) * 2); }


/* --- Products Section --- */
/* #products handled by generic */
/* Target the container added by the featured products module hook {$HOOK_HOME} */
/* Usually '.products', check module output */
#products .products, .product-grid { /* Target both potential class names */
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: calc(var(--spacing-unit) * 2.5);
    margin-top: calc(var(--spacing-unit) * 3); /* Add space below h2 */
}

/* Style the individual product miniature (.product-miniature.product-card) */
.product-card { /* Merging styles for .product-miniature */
  background-color: #fff;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 4px 15px rgba(0,0,0,0.05);
  transition: transform var(--transition-speed) ease, box-shadow var(--transition-speed) ease;
  text-align: center; /* Center align all content */
  margin-bottom: var(--spacing-unit); /* Add margin between rows if needed */
}
.product-card:hover { transform: translateY(-5px); box-shadow: 0 8px 25px rgba(0,0,0,0.1); }

.product-card .thumbnail-container { /* Wrapper for image */
    position: relative; /* For potential flags/quickview */
    overflow: hidden; /* Ensure image hover effect stays contained */
}
.product-card .thumbnail-container img {
    height: 250px; /* Fixed height */
    width: 100%; /* Ensure full width */
    object-fit: cover;
    transition: opacity var(--transition-speed) ease;
    display: block; /* Remove extra space below image */
}
.product-card:hover .thumbnail-container img { opacity: 0.85; }

.product-card .product-info { /* Renamed from .product-description */
    padding: calc(var(--spacing-unit) * 1.5);
    text-align: center;
}
.product-card .product-info h3,
.product-card .product-info .h3 { /* Target h3 or .h3 */
    margin-bottom: calc(var(--spacing-unit) * 0.5);
    font-size: 1.3rem;
    font-family: var(--font-heading); /* Ensure font */
    color: var(--color-primary); /* Ensure color */
    font-weight: 600; /* Ensure weight */
    line-height: 1.2; /* Ensure line height */
}
.product-card .product-info h3 a,
.product-card .product-info .h3 a {
     color: inherit; /* Inherit color from h3 */
     text-decoration: none;
}
.product-card .product-info p { /* Style the short description */
    font-size: 0.9rem;
    color: #666;
    margin-bottom: calc(var(--spacing-unit) * 1);
    font-family: var(--font-body); /* Ensure font */
    max-width: none; /* Remove max-width from generic p */
}
/* Style Price Block */
.product-card .product-price-and-shipping {
    margin-bottom: calc(var(--spacing-unit) * 1);
    font-weight: bold;
    color: var(--color-primary);
}
.product-card .product-price-and-shipping .regular-price {
    text-decoration: line-through;
    font-weight: normal;
    color: #999;
    margin-left: 0.5rem;
}

/* Style View Product Link */
.product-card .product-link-wrapper { /* Add wrapper div if needed */
     margin-top: auto; /* Push link down if card uses flex */
}
.product-link {
  font-family: var(--font-accent);
  font-weight: 500;
  color: var(--color-accent);
  text-transform: uppercase;
  font-size: 0.85rem;
  letter-spacing: 0.5px;
  position: relative;
  padding-bottom: 3px;
  display: inline-block; /* Ensure it behaves like a block for centering/positioning */
  text-decoration: none;
}
.product-link::after {
  content: '';
  position: absolute;
  width: 0;
  height: 1px;
  bottom: 0;
  left: 50%;
  transform: translateX(-50%);
  background-color: var(--color-accent);
  transition: width var(--transition-speed) ease;
}
.product-card:hover .product-link::after { width: 50%; }

.view-all-cta { text-align: center; margin-top: calc(var(--spacing-unit) * 3); }


/* --- Scent Finder Section --- */
/* #finder handled by generic */
.finder-section {
  color: var(--color-primary); /* Default text color for this section */
}
.finder-section h2 { color: var(--color-primary); } /* Ensure h2 color */
.finder-subtitle { text-align: center; margin: calc(var(--spacing-unit) * -2) 0 calc(var(--spacing-unit) * 3) 0; opacity: 0.9; }
.finder-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); gap: calc(var(--spacing-unit) * 2); }
.finder-card {
  background-color: rgba(255,255,255,0.5);
  padding: calc(var(--spacing-unit) * 2) calc(var(--spacing-unit) * 1.5);
  border-radius: 8px;
  text-align: center;
  transition: background-color var(--transition-speed) ease, transform var(--transition-speed) ease;
  cursor: pointer;
}
.finder-card:hover { background-color: rgba(255,255,255,0.8); transform: translateY(-5px); }
.finder-icon { font-size: 2.5rem; color: var(--color-primary); margin-bottom: var(--spacing-unit); display: block; }
.finder-card h3 { font-size: 1.2rem; margin-bottom: calc(var(--spacing-unit) * 0.5); color: var(--color-primary); } /* Ensure color */
.finder-card p { font-size: 0.9rem; line-height: 1.5; color: var(--color-text); margin-bottom: 0; max-width: none;} /* Ensure color */
.finder-cta { text-align: center; margin-top: calc(var(--spacing-unit) * 3); }
/* Specific button style override for finder */
.finder-cta .btn-secondary { border-color: var(--color-primary); color: var(--color-primary);}
.finder-cta .btn-secondary:hover { background-color: var(--color-primary); color: var(--color-text-light); border-color: var(--color-primary); }

/* --- Testimonials Section --- */
/* #testimonials handled by generic */
.testimonial-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: calc(var(--spacing-unit) * 2); }
.testimonial-card {
  background-color: var(--color-background);
  padding: calc(var(--spacing-unit) * 2);
  border-radius: 8px;
  border-left: 5px solid var(--color-secondary);
  box-shadow: 0 4px 10px rgba(0,0,0,0.03);
}
.testimonial-card p { font-style: italic; margin-bottom: var(--spacing-unit); color: #555; max-width: none;}
.testimonial-author { font-weight: 500; color: var(--color-primary); margin-bottom: calc(var(--spacing-unit) * 0.5); display: block; }
.testimonial-rating { color: var(--color-accent); font-size: 1.1rem; }

/* --- Newsletter Section --- */
/* #newsletter handled by generic */
/* Style the container added by the newsletter module hook (often .block_newsletter) */
#newsletter {
  color: var(--color-text-light);
  padding: calc(var(--spacing-unit) * 4) 0;
}
#newsletter h2 { color: var(--color-text-light); }
.newsletter-container { text-align: center; max-width: 700px; margin-left: auto; margin-right: auto;} /* Add margin auto */
.newsletter-container p { opacity: 0.9; margin-bottom: calc(var(--spacing-unit) * 1.5); max-width: none; color: inherit;}
/* Target the form within the module */
#newsletter form, .newsletter-form {
    display: flex;
    justify-content: center;
    gap: var(--spacing-unit);
    margin-bottom: var(--spacing-unit);
    flex-wrap: wrap;
}
#newsletter form input[type="email"], #newsletter form input[type="text"], .newsletter-form input[type="email"] { /* Handle both type=email and type=text */
  padding: calc(var(--spacing-unit) * 0.8);
  border: 1px solid var(--color-secondary);
  border-radius: 50px;
  font-family: var(--font-body);
  min-width: 300px;
  flex-grow: 1;
  background-color: #fff; /* Add background */
  color: var(--color-text); /* Add text color */
}
/* Target the button within the module */
#newsletter form button[type="submit"], .newsletter-form .btn {
  background-color: var(--color-accent);
  color: var(--color-primary) !important; /* Override button text color */
  border-color: var(--color-accent);
  /* Inherit .btn styles for padding, border-radius, etc. */
}
#newsletter form button[type="submit"]:hover, .newsletter-form .btn:hover {
  background-color: var(--color-secondary);
  border-color: var(--color-secondary);
  color: var(--color-primary) !important; /* Override button text color */
}
/* Style the consent text if provided by the module */
.newsletter-consent { font-size: 0.8rem; opacity: 0.7; margin-bottom: 0; }
.newsletter-consent a { color: var(--color-secondary); text-decoration: underline; }
.newsletter-consent a:hover { color: var(--color-text-light); }


/* --- Footer --- */
.main-footer {
  background-color: #2f3d41;
  color: #ccc;
  padding-top: calc(var(--spacing-unit) * 4);
  font-size: 0.9rem;
}
/* Target wrapper div added by displayFooter hook if needed */
.footer-container { /* PrestaShop often adds this class */
    /* Styles for the wrapper if necessary */
}
.footer-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: calc(var(--spacing-unit) * 3);
  margin-bottom: calc(var(--spacing-unit) * 3);
}
/* Style wrappers for link lists, contact info modules */
.footer-grid .block { /* ps_linklist, ps_contactinfo often use .block */
    /* Add spacing or styles if needed */
}

.footer-about h3, .footer-links h3, .footer-contact h3,
.footer-grid .block h3, .footer-grid .block .h3 { /* Target module titles */
  font-family: var(--font-accent);
  color: var(--color-text-light);
  font-weight: 600;
  margin-bottom: calc(var(--spacing-unit) * 1.2);
  font-size: 1.1rem;
}
.footer-about p { line-height: 1.6; margin-bottom: var(--spacing-unit); max-width: none;}
.social-icons { display: flex; gap: var(--spacing-unit); justify-content: flex-start; /* Default alignment */}
.social-icons a { color: #ccc; font-size: 1.2rem; transition: color var(--transition-speed) ease, transform var(--transition-speed) ease; }
.social-icons a:hover { color: var(--color-accent); transform: scale(1.1); }

/* Styling for ps_linklist module */
.footer-links ul, .footer-grid .block ul {
    list-style: none;
    padding: 0;
    margin: 0;
}
.footer-links ul li, .footer-grid .block ul li { margin-bottom: calc(var(--spacing-unit) * 0.5); }
.footer-links a, .footer-grid .block a { color: #ccc; text-decoration: none; }
.footer-links a:hover, .footer-grid .block a:hover { color: var(--color-text-light); text-decoration: underline; }

/* Styling for ps_contactinfo module */
.footer-contact p, .footer-grid .contact-rich p { margin-bottom: calc(var(--spacing-unit) * 0.6); display: flex; align-items: center; gap: calc(var(--spacing-unit) * 0.5); max-width: none;}
.footer-contact i, .footer-grid .contact-rich i { color: var(--color-secondary); width: 16px; text-align: center; flex-shrink: 0; } /* Add shrink */

/* Footer Bottom */
.footer-bottom { background-color: #222b2e; padding: calc(var(--spacing-unit) * 1.5) 0; margin-top: calc(var(--spacing-unit) * 2); }
.footer-bottom .container {
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: var(--spacing-unit);
  font-size: 0.85rem;
}
.payment-methods { display: flex; align-items: center; gap: calc(var(--spacing-unit) * 0.8); }
.payment-methods span { margin-right: calc(var(--spacing-unit) * 0.5); }
.payment-methods i { font-size: 1.8rem; color: #aaa; }

/* --- Responsive Design --- */
@media (max-width: 992px) {
  .header-container { padding: 0 calc(var(--spacing-unit) * 1.5); }
  .main-nav, #_desktop_top_menu, .header-icons { display: none !important; } /* Hide desktop elements */
  .mobile-nav-toggle { display: block !important; } /* Show mobile toggle */

  .about-container { grid-template-columns: 1fr; text-align: center; }
  .about-image { margin-bottom: calc(var(--spacing-unit) * 2); order: -1; margin-left: auto; margin-right: auto; max-width: 80%; } /* Center image */
  .about-text h2 { text-align: center; } /* Center heading */

  .footer-grid { grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); }
}

@media (max-width: 767px) { /* Add breakpoint for slightly larger mobiles if needed */
    h1 { font-size: 2.2rem; } /* Adjust clamp or values */
    h2 { font-size: 1.7rem; }
    h3 { font-size: 1.25rem; }

    /* Adjust section padding */
    #wrapper section {
        padding: calc(var(--spacing-unit) * 4) 0;
    }
    #wrapper section h2 {
        margin-bottom: calc(var(--spacing-unit) * 2.5);
    }

    /* Ensure product grid stacks early enough */
    #products .products, .product-grid {
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); /* Adjust minmax */
    }
    .finder-grid {
        grid-template-columns: repeat(auto-fit, minmax(160px, 1fr)); /* Adjust minmax */
    }
}


@media (max-width: 576px) {
  h1 { font-size: 2rem; }
  h2 { font-size: 1.6rem; }
  h3 { font-size: 1.2rem; }

  .hero-section { min-height: 500px; }
  .hero-content p { font-size: 1rem; }

  .btn { padding: calc(var(--spacing-unit) * 0.7) calc(var(--spacing-unit) * 1.5); font-size: 0.9rem; }

  #wrapper section { padding: calc(var(--spacing-unit) * 3) 0; }
  #wrapper section h2 { margin-bottom: calc(var(--spacing-unit) * 2); }

  #products .products, .product-grid { grid-template-columns: 1fr; gap: calc(var(--spacing-unit) * 1.5); } /* Stack products */
  .product-card .thumbnail-container img { height: 200px; } /* Adjust image height */

  .finder-grid { grid-template-columns: repeat(auto-fit, minmax(140px, 1fr)); gap: var(--spacing-unit); }
  .finder-card { padding: calc(var(--spacing-unit) * 1.5) var(--spacing-unit); }

  .testimonial-grid { grid-template-columns: 1fr; } /* Stack testimonials */

  /* Newsletter form adjustments */
  #newsletter form, .newsletter-form { flex-direction: column; align-items: stretch; }
  #newsletter form input[type="email"], #newsletter form input[type="text"], .newsletter-form input[type="email"] { width: 100%; min-width: auto; }
  #newsletter form button[type="submit"], .newsletter-form .btn { width: 100%; }

  .footer-grid { grid-template-columns: 1fr; text-align: center; }
  .footer-grid .block { text-align: center; } /* Center module content */
  .footer-contact p, .footer-grid .contact-rich p { justify-content: center; } /* Center contact items */
  .social-icons { justify-content: center; margin-top: var(--spacing-unit); }

  .footer-bottom .container { flex-direction: column; text-align: center; }
  .payment-methods { margin-top: var(--spacing-unit); justify-content: center; } /* Center payment icons */
}

/* --- PrestaShop Specific Overrides & Helper Classes --- */
/* Add minor overrides for default PS styles if they interfere */
.clearfix::after { display: block; content: ""; clear: both; }
/* Add any other specific PS class overrides needed */

```

**`thescent/assets/js/custom.js`**

```javascript
document.addEventListener('DOMContentLoaded', function() {

  // Mobile Menu Toggle Script
  const toggleButton = document.querySelector('.mobile-nav-toggle'); // Use class selector
  const mobileNav = document.querySelector('.mobile-nav'); // Use class selector
  const mainHeader = document.querySelector('.main-header'); // Use class selector

  if (toggleButton && mobileNav && mainHeader) {
    toggleButton.addEventListener('click', () => {
      mobileNav.classList.toggle('active');
      mainHeader.classList.toggle('mobile-menu-active');

      // Toggle burger/close icon
      const icon = toggleButton.querySelector('i');
      if (icon) {
        icon.classList.toggle('fa-bars');
        icon.classList.toggle('fa-times');
      }
    });

    // Close mobile menu when a link is clicked
    mobileNav.querySelectorAll('a').forEach(link => {
      link.addEventListener('click', () => {
        if (mobileNav.classList.contains('active')) { // Check if active before trying to close
          mobileNav.classList.remove('active');
          mainHeader.classList.remove('mobile-menu-active');
          const icon = toggleButton.querySelector('i');
          if (icon) {
            icon.classList.add('fa-bars');
            icon.classList.remove('fa-times');
          }
        }
      });
    });
  } else {
      console.warn('Mobile navigation elements not found.');
  }

  // Sticky Header Script
  const header = document.querySelector('.main-header');
  const body = document.body;
  let lastScroll = 0;

  if(header) {
      const scrollThreshold = 50; // How far to scroll before making header sticky

      window.addEventListener('scroll', () => {
          const currentScroll = window.pageYOffset;

          if (currentScroll <= scrollThreshold) {
              // Near the top or scrolling up to the top
              header.classList.remove('sticky');
              // Optional: remove padding-top from body if you added it
              // body.style.paddingTop = '0';
              return;
          }

          if (currentScroll > lastScroll && !header.classList.contains('sticky')) {
              // Scrolling down and not already sticky
              header.classList.add('sticky');
              // Optional: Add padding to body to prevent jump when header becomes fixed
              // let headerHeight = header.offsetHeight;
              // body.style.paddingTop = headerHeight + 'px';
          } else if (currentScroll < lastScroll && header.classList.contains('sticky')) {
             // Scrolling up - keep sticky (or remove if you want it to hide on scroll up)
             // If you want it to disappear on scroll up and reappear on scroll down past threshold:
             // header.classList.remove('sticky');
          }


          lastScroll = currentScroll;
      });

      // Add header-absolute class for homepage if JS is enabled
      if (document.body.id === 'index' && !header.classList.contains('sticky')) {
           header.classList.add('header-absolute');
      }
       window.addEventListener('scroll', () => {
            if (document.body.id === 'index') {
                if (window.pageYOffset > scrollThreshold) {
                    header.classList.remove('header-absolute');
                } else if (!header.classList.contains('mobile-menu-active')) { // Don't re-add if mobile menu is open
                     header.classList.add('header-absolute');
                }
            }
       });

  } else {
      console.warn('Main header element not found for sticky script.');
  }


  // You can add other theme-specific JS here

});

```

---

**Next Steps:**

1.  **Place Files:** Create this directory structure and place these files inside your PrestaShop `/themes/` directory.
2.  **Install & Enable Modules:** Go to your PrestaShop Back Office -> Modules -> Module Manager. Install and enable the modules listed in `theme.yml` under `dependencies` and `global_settings.hooks` (like `ps_mainmenu`, `ps_featuredproducts`, `ps_shoppingcart`, `ps_customersignin`, `ps_searchbar`, `ps_emailsubscription`, `ps_linklist`, `ps_contactinfo`).
3.  **Configure Hooks:** Go to Design -> Positions. Check that the installed modules are hooked to the positions specified in `theme.yml` (e.g., `ps_mainmenu` to `displayNavFullWidth` or `displayTop`, `ps_featuredproducts` to `displayHome`). You might need to transplant modules if they are not in the correct hooks by default.
4.  **Activate Theme:** Go to Design -> Theme & Logo. Find "The Scent" theme and activate it.
5.  **Clear Cache:** Go to Advanced Parameters -> Performance. Click "Clear cache".
6.  **Review & Refine:** View your homepage.
    *   The basic structure and styling should be applied.
    *   The header/footer should use your layout.
    *   The featured products section should display products using the `product.tpl` styling (you'll likely need CSS tweaks).
    *   Menus, cart, search, etc., depend on the modules being correctly installed, enabled, and hooked.
    *   **CSS Conflicts:** You will likely need to inspect elements and add more specific CSS rules in `custom.css` to override default PrestaShop styles or module styles that interfere with your design.
    *   **Other Pages:** Start customizing the `.tpl` files for category pages (`catalog/listing/product-list.tpl`), product pages (`catalog/product.tpl`), cart (`checkout/cart.tpl`), checkout, CMS pages, etc., applying your CSS classes and structure.

https://drive.google.com/file/d/13igRY4D5DOVT6UR9lYnJgR2DOS5xCfu7/view?usp=sharing, https://drive.google.com/file/d/1AYEccQgzlka5JsdP8MOuN2fJ_yEsBRR9/view?usp=sharing, https://aistudio.google.com/app/prompts?state=%7B%22ids%22:%5B%221G0WhMKhtRJzVoztGiOjmw5EmeiEQ2ARI%22%5D,%22action%22:%22open%22,%22userId%22:%22103961307342447084491%22,%22resourceKeys%22:%7B%7D%7D&usp=sharing, https://drive.google.com/file/d/1I-0ma0FxV4oHroJg1OY6wfB8w6mIpedu/view?usp=sharing, https://drive.google.com/file/d/1PZiQEPCf4nVbXU_agnsp6xSE5SJg4BEY/view?usp=sharing
