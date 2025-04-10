# Technical Design Specification for "The Scent" PrestaShop Theme

*Document Version: 1.0*
*Based on Initial Implementation Plan: April 2025*

---

## Table of Contents

1.  [Overview](#overview)
2.  [Design Philosophy and Goals](#design-philosophy-and-goals)
3.  [Site Structure and Layout](#site-structure-and-layout)
    *   3.1 [Header](#header)
    *   3.2 [Navigation and Branding](#navigation-and-branding)
    *   3.3 [Product Grid (Homepage Focus)](#product-grid-homepage-focus)
    *   3.4 [Footer](#footer)
4.  [Visual Identity](#visual-identity)
    *   4.1 [Color Scheme](#color-scheme)
    *   4.2 [Typography](#typography)
5.  [UI Animations and Interactions](#ui-animations-and-interactions)
    *   5.1 [Mouse-Over Effects](#mouse-over-effects)
    *   5.2 [Subtle Animation Cues](#subtle-animation-cues)
    *   5.3 [Transitions and Micro-Interactions](#transitions-and-micro-interactions)
6.  [Component Analysis](#component-analysis)
    *   6.1 [Header Components](#header-components)
    *   6.2 [Product Card Components](#product-card-components)
    *   6.3 [Footer Components](#footer-components)
7.  [Code Architecture and Implementation (PrestaShop Theme)](#code-architecture-and-implementation-prestashop-theme)
    *   7.1 [Theme Structure & Smarty Templates (.tpl)](#theme-structure--smarty-templates-tpl)
    *   7.2 [CSS Styling (custom.css)](#css-styling-customcss)
    *   7.3 [JavaScript Enhancements (custom.js)](#javascript-enhancements-customjs)
    *   7.4 [Theme Configuration (theme.yml)](#theme-configuration-themeyml)
8.  [Responsive and Adaptive Design](#responsive-and-adaptive-design)
9.  [Performance and Accessibility Considerations](#performance-and-accessibility-considerations)
10. [Testing, Maintenance, and Future Enhancements](#testing-maintenance-and-future-enhancements)
11. [Conclusion](#conclusion)

---

## 1. Overview

This document provides the technical design specification for "The Scent," a custom PrestaShop theme developed for an e-commerce platform specializing in premium aromatherapy and natural well-being products. Built upon an Apache/PHP/MySQL stack leveraging the PrestaShop framework (v1.7.x/8.x), this theme translates a specific visual design concept (provided via HTML/CSS) into a functional and aesthetically pleasing online storefront. The design emphasizes elegance, natural elements, and a seamless user experience, integrating the brand's identity throughout the customer journey.

---

## 2. Design Philosophy and Goals

The design philosophy for "The Scent" theme revolves around creating a serene, sophisticated, and trustworthy online environment that reflects the brand's focus on natural well-being.

*   **Elegance & Sophistication:** Utilizing refined typography (`Cormorant Garamond`, `Montserrat`, `Raleway`) and a mature color palette (deep teal, soft mint, muted gold) to create a premium feel.
*   **Natural & Calming:** Reflecting the product nature through visual choices and aiming for an uncluttered, easy-to-navigate interface.
*   **User-Friendly & Functional:** Ensuring clear calls-to-action, intuitive navigation, and a straightforward layout to facilitate the e-commerce journey. Built on PrestaShop to leverage its robust e-commerce features.
*   **Interactive Engagement:** Incorporating subtle animations and hover effects (sticky header, product card interactions, button feedback) to enhance user engagement without causing distraction.
*   **Brand Consistency:** Maintaining a cohesive visual identity across all pages and components through consistent use of colors, fonts, and spacing defined via CSS variables.
*   **Responsiveness:** Ensuring a seamless and accessible experience across various devices (desktop, tablet, mobile).

### Key Goals

*   Successfully implement the provided visual design within the PrestaShop theme structure.
*   Deliver a fully functional e-commerce frontend experience based on PrestaShop's capabilities.
*   Reinforce "The Scent" brand identity through consistent visual design.
*   Optimize for user engagement and conversion through clear layout and CTAs.
*   Ensure the theme is responsive and reasonably performant.

---

## 3. Site Structure and Layout

The theme implements the core layout defined in the HTML concept, adapted for PrestaShop's structure using Smarty templates (`.tpl` files).

### 3.1 Header

The header provides primary navigation, branding, and essential user actions (search, account, cart). It is designed to be sticky on scroll for persistent access.

*   **Layout:** Full-width, initially positioned absolutely on the homepage and becoming fixed (`sticky`) on scroll. Contains logo, primary navigation (desktop), header icons (desktop), and a mobile navigation toggle.
*   **Design Elements:** Features a text-based logo with a tagline, uppercase navigation links, and Font Awesome icons for user actions. Uses `--color-primary` and `--color-text-light` with transitions for sticky state.
*   **Implementation (`thescent/templates/_partials/header.tpl`):**
    ```smarty
    {* Simplified Structure Example *}
    <header class="main-header {if $page.page_name == 'index'}header-absolute{/if}"> {* Conditional class for homepage *}
      <div class="container header-container">
        <div class="logo" id="_desktop_logo">
          <a href="{$urls.base_url}">
             {$shop.name} {* Dynamic Shop Name *}
             <span>AROMATHERAPY</span>
          </a>
        </div>

        {* Desktop Main Navigation (Hooked) *}
        <nav class="main-nav" id="_desktop_top_menu">
          {hook h='displayNavFullWidth'} {* Hook for ps_mainmenu *}
        </nav>

        {* Desktop Header Icons (Hooked) *}
        <div class="header-icons" id="_desktop_header_icons">
           <div id="_desktop_search_widget">{hook h='displaySearch'}</div>
           <div id="_desktop_user_info">{hook h='displayCustomerAccount'}</div>
           <div id="_desktop_cart">{hook h='displayShoppingCart'}</div>
        </div>

        {* Mobile Toggle Button *}
        <button class="mobile-nav-toggle" id="_mobile_menu_toggle" aria-label="{l s='Toggle navigation' d='Shop.Theme.Actions'}">
          <i class="fas fa-bars"></i>
        </button>
      </div>

      {* Mobile Menu Panel (Toggled via JS) *}
      <nav class="mobile-nav" id="_mobile_nav">
         {* Links populated via hook or manually *}
      </nav>
    </header>
    ```
*   **Styling (`custom.css`):**
    ```css
    .main-header {
      /* position: absolute; Applied via .header-absolute */
      top: 0; left: 0; width: 100%;
      z-index: 1000;
      padding: calc(var(--spacing-unit) * 1.5) 0;
      background: transparent;
      transition: background-color var(--transition-speed) ease, box-shadow var(--transition-speed) ease, padding var(--transition-speed) ease;
    }
    .main-header.sticky {
      position: fixed;
      background-color: rgba(255, 255, 255, 0.95);
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
      padding: calc(var(--spacing-unit) * 0.8) 0;
    }
    /* Color changes for sticky state */
    .main-header.sticky .logo a,
    .main-header.sticky .logo span,
    .main-header.sticky #_desktop_top_menu a,
    .main-header.sticky .header-icons a {
      color: var(--color-primary);
    }
    ```

### 3.2 Navigation and Branding

Navigation and branding elements use the defined visual identity consistently.

*   **Branding:** Text-based logo using `var(--font-heading)` and `var(--font-accent)` for the tagline. Uses `var(--color-text-light)` normally and `var(--color-primary)` when sticky.
*   **Navigation:** Desktop navigation uses `var(--font-accent)`, uppercase text, and a subtle underline effect on hover. Mobile navigation uses a slide-down panel. Relies heavily on PrestaShop modules (`ps_mainmenu`) hooked into appropriate positions (`displayNavFullWidth`).
*   **Styling Example (`custom.css`):**
    ```css
    /* Desktop Navigation Link Styling */
    #_desktop_top_menu a {
      font-family: var(--font-accent);
      font-weight: 500;
      color: var(--color-text-light); /* Default color */
      text-transform: uppercase;
      letter-spacing: 1px;
      padding: 5px 0;
      position: relative;
      text-decoration: none;
    }
    #_desktop_top_menu a::after { /* Hover underline effect */
      content: '';
      position: absolute;
      width: 0; height: 2px; bottom: 0; left: 50%;
      transform: translateX(-50%);
      background-color: var(--color-accent);
      transition: width var(--transition-speed) ease;
    }
    #_desktop_top_menu a:hover::after { width: 100%; }
    #_desktop_top_menu a:hover { color: var(--color-accent); } /* Hover color change */
    ```

### 3.3 Product Grid (Homepage Focus)

The homepage features a grid showcasing featured products, designed for visual appeal and easy browsing.

*   **Layout:** Uses a responsive CSS Grid (`repeat(auto-fit, minmax(280px, 1fr))`) to display product cards. Defined in `custom.css` targeting the `.products` container rendered by PrestaShop's `ps_featuredproducts` module (hooked to `displayHome`).
*   **Card Design:** Each product is displayed in a `.product-card` containing an image, title, short description (optional), and a "View Product" link. Defined in `thescent/templates/catalog/_partials/miniatures/product.tpl`.
*   **Hover Effects:** Cards lift slightly (`transform: translateY`), gain more shadow, image opacity changes, and the product link gains an underline on hover.
*   **Implementation (`product.tpl` Snippet):**
    ```smarty
    {block name='product_miniature_item'}
      <article class="product-miniature js-product-miniature product-card" ...>
        <div class="thumbnail-container">
          {block name='product_thumbnail'}
            <a href="{$product.url}" class="thumbnail product-thumbnail">
              <img src="{$product.cover.bySize.home_default.url}" ... >
            </a>
          {/block}
        </div>
        <div class="product-description product-info">
          {block name='product_name'}
            <h3 class="h3 product-title"><a href="{$product.url}">{$product.name|truncate:30:'...'}</a></h3>
          {/block}
          {block name='product_description_short'}
            <p>{$product.description_short|strip_tags:'UTF-8'|truncate:50:'...'}</p>
          {/block}
          {* Price block would be here *}
          <div class="product-link-wrapper">
            <a href="{$product.url}" class="product-link">{l s='View Product' d='Shop.Theme.Actions'}</a>
          </div>
        </div>
      </article>
    {/block}
    ```
*   **Styling (`custom.css`):**
    ```css
    /* Product Grid Container (from module output) */
    #products .products, .product-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
      gap: calc(var(--spacing-unit) * 2.5);
    }
    /* Individual Product Card */
    .product-card {
      background-color: #fff;
      border-radius: 8px;
      overflow: hidden;
      box-shadow: 0 4px 15px rgba(0,0,0,0.05);
      transition: transform var(--transition-speed) ease, box-shadow var(--transition-speed) ease;
      text-align: center;
    }
    .product-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 8px 25px rgba(0,0,0,0.1);
    }
    .product-card .thumbnail-container img {
      height: 250px; width: 100%; object-fit: cover;
      transition: opacity var(--transition-speed) ease;
    }
    .product-card:hover .thumbnail-container img { opacity: 0.85; }
    .product-link { /* View Product Link */
      /* ... styling ... */
      position: relative; padding-bottom: 3px;
    }
    .product-link::after { /* Underline effect */
      /* ... dimensions and positioning ... */
      background-color: var(--color-accent);
      transition: width var(--transition-speed) ease;
    }
    .product-card:hover .product-link::after { width: 50%; }
    ```

### 3.4 Footer

The footer provides essential supplementary information, links, and contact details.

*   **Layout:** A multi-column grid layout (`repeat(auto-fit, minmax(200px, 1fr))`) containing sections for About text, Shop links, Help links, and Contact Info. Below this grid is a full-width bottom bar with copyright and payment methods. Implemented in `thescent/templates/_partials/footer.tpl`.
*   **Design Elements:** Uses dark background (`#2f3d41`), light text (`#ccc`), accent font for headings, and Font Awesome icons for contact details and social media links. Links have hover effects.
*   **Implementation:** Relies on PrestaShop hooks (`displayFooter` for `ps_linklist` modules, potentially `displayFooterContact` for `ps_contactinfo`) to populate link and contact sections dynamically. Social icons and About text might be hardcoded initially or managed by other modules/theme settings.
*   **Styling (`custom.css`):**
    ```css
    .main-footer {
      background-color: #2f3d41;
      color: #ccc;
      padding-top: calc(var(--spacing-unit) * 4);
      font-size: 0.9rem;
    }
    .footer-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      gap: calc(var(--spacing-unit) * 3);
      margin-bottom: calc(var(--spacing-unit) * 3);
    }
    .footer-grid h3, .footer-grid .block h3 { /* Target section titles */
      font-family: var(--font-accent);
      color: var(--color-text-light);
      /* ... other styles ... */
    }
    .social-icons a { color: #ccc; /* ... */ transition: color var(--transition-speed) ease, transform var(--transition-speed) ease; }
    .social-icons a:hover { color: var(--color-accent); transform: scale(1.1); }
    .footer-bottom { /* Bottom bar styling */
      background-color: #222b2e; padding: calc(var(--spacing-unit) * 1.5) 0; /* ... */
    }
    ```

---

## 4. Visual Identity

The theme strictly adheres to the visual identity defined in `style.css`.

### 4.1 Color Scheme

A palette designed for sophistication and calm, defined using CSS variables for consistency and maintainability.

*   **Primary:** `--color-primary: #1A4D5A` (Deep Teal) - Used for headings, primary buttons, sticky header text.
*   **Secondary:** `--color-secondary: #A0C1B1` (Soft Mint Green) - Used for finder section background, testimonial border, potentially hover states.
*   **Accent:** `--color-accent: #D4A76A` (Muted Gold/Ochre) - Used for hover effects, product link, ratings, newsletter button.
*   **Background:** `--color-background: #F8F5F2` (Warm Off-White) - Main body background. `#fff` used for alternate sections (About, Testimonials, Product Cards).
*   **Text:** `--color-text: #333333` (Dark Gray) - Default body text. `--color-text-light: #FFFFFF` - Used on dark backgrounds (Hero, Header, Newsletter, Footer).
*   **Borders:** `--color-border: #e0e0e0` - Used for subtle borders if needed (e.g., form inputs).
*   **Gradients:** No complex gradients are defined in the base `style.css`; solid colors and rgba backgrounds are used.

**Implementation (`custom.css`):**
```css
:root {
  --color-primary: #1A4D5A;
  --color-secondary: #A0C1B1;
  --color-accent: #D4A76A;
  --color-background: #F8F5F2;
  --color-text: #333333;
  --color-text-light: #FFFFFF;
  --color-border: #e0e0e0;
  /* ... other variables ... */
}
```

### 4.2 Typography

Three distinct fonts are used to create hierarchy and character, defined via Google Fonts and CSS variables.

*   **Headings (`h1`-`h6`):** `--font-heading: 'Cormorant Garamond', serif` (Weight 600). Provides elegance.
*   **Body Text (`body`, `p`):** `--font-body: 'Montserrat', sans-serif`. Clean and readable.
*   **Accent/Buttons (`.btn`, `.product-link`, footer headings):** `--font-accent: 'Raleway', sans-serif` (Weight 500/600). Modern sans-serif for UI elements.
*   **Hierarchy:** Achieved through distinct font families, sizes (`clamp()` used for responsive headings), weights, and color (`--color-primary` for headings, `--color-text` for body).

**Implementation (`custom.css`):**
```css
:root {
  --font-heading: 'Cormorant Garamond', serif;
  --font-body: 'Montserrat', sans-serif;
  --font-accent: 'Raleway', sans-serif;
}

body {
  font-family: var(--font-body);
  color: var(--color-text);
  line-height: 1.7;
}

h1, h2, h3, h4, h5, h6 {
  font-family: var(--font-heading);
  font-weight: 600;
  color: var(--color-primary);
  /* ... other styles ... */
}

.btn {
  font-family: var(--font-accent);
  font-weight: 500;
  /* ... other styles ... */
}
```
**Implementation (`_partials/head.tpl`):**
```smarty
{block name='head_fonts'}
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;600;700&family=Montserrat:wght@300;400;500&family=Raleway:wght@400;500;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" ...> {* Font Awesome *}
{/block}
```

---

## 5. UI Animations and Interactions

Subtle animations and transitions enhance the user experience and provide visual feedback.

### 5.1 Mouse-Over Effects

Applied to most interactive elements using CSS transitions.

*   **Buttons (`.btn`):** Background color change, slight upward translation (`transform: translateY(-2px)`).
*   **Navigation Links:** Text color change (`color: var(--color-accent)`), underline reveal (`width: 100%`).
*   **Product Cards:** Upward translation (`transform: translateY(-5px)`), increased shadow, image opacity decrease, product link underline reveal.
*   **Social Icons:** Color change (`color: var(--color-accent)`), slight scaling (`transform: scale(1.1)`).
*   **Footer Links:** Text color change (`color: var(--color-text-light)`), underline.

**Implementation (`custom.css`):**
```css
a { transition: color var(--transition-speed) ease; }
.btn { transition: background-color var(--transition-speed) ease, transform var(--transition-speed) ease, border-color var(--transition-speed) ease; }
.product-card { transition: transform var(--transition-speed) ease, box-shadow var(--transition-speed) ease; }
.product-card img { transition: opacity var(--transition-speed) ease; }
.product-link::after { transition: width var(--transition-speed) ease; }
/* ... hover state definitions ... */
```

### 5.2 Subtle Animation Cues

Used primarily in the Hero section for initial visual impact.

*   **Hero Content (`.hero-content`):** Fades in and slides up slightly on load (`@keyframes fadeIn`).
*   **Hero Media (`.hero-media img, .hero-media video`):** Slowly zooms in and out infinitely (`@keyframes zoomInOut`).

**Implementation (`custom.css`):**
```css
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(20px); }
  to { opacity: 1; transform: translateY(0); }
}
@keyframes zoomInOut {
  from { transform: scale(1); }
  to { transform: scale(1.05); }
}

.hero-content { animation: fadeIn 1.5s ease-out; }
.hero-media video, .hero-media img { animation: zoomInOut 25s infinite alternate ease-in-out; }
```

### 5.3 Transitions and Micro-Interactions

Handled via CSS transitions triggered by JavaScript-added classes.

*   **Sticky Header:** Smooth transition for `background-color`, `padding`, and `box-shadow` when `.sticky` class is added/removed by JS on scroll.
*   **Mobile Menu:** Smooth slide-down effect using `max-height` transition when `.active` class is added/removed by JS on toggle button click. Background of header also transitions when `.mobile-menu-active` class is applied.

**Implementation (`custom.css`):**
```css
.main-header { transition: background-color var(--transition-speed) ease, box-shadow var(--transition-speed) ease, padding var(--transition-speed) ease; }
.mobile-nav { transition: max-height 0.5s ease-out, padding 0.5s ease-out; max-height: 0; overflow: hidden; }
.mobile-nav.active { max-height: 70vh; /* Or other appropriate value */ }
```
**Implementation (`custom.js`):**
*   Event listeners for `scroll` (sticky header) and `click` (mobile toggle) add/remove `.sticky`, `.active`, and `.mobile-menu-active` classes.

---

## 6. Component Analysis

Breaking down key reusable components based on the PrestaShop implementation.

### 6.1 Header Components

*   **Elements:** Logo (`.logo`), Desktop Navigation (`#_desktop_top_menu` containing hooked `ps_mainmenu`), Header Icons (`.header-icons` containing hooked search, cart, user info modules), Mobile Toggle (`.mobile-nav-toggle`), Mobile Nav Panel (`.mobile-nav`).
*   **Implementation:** Structure defined in `_partials/header.tpl`. Styling in `custom.css`. Interactions (sticky, mobile toggle) handled by `custom.js`.
*   **Technical Considerations:** Relies heavily on PrestaShop hooks (`displayNavFullWidth`, `displaySearch`, `displayCustomerAccount`, `displayShoppingCart`) being correctly configured in `theme.yml` and modules being active. Sticky behavior requires careful JS implementation to toggle classes correctly. Absolute positioning on homepage needs JS/CSS coordination.

### 6.2 Product Card Components

*   **Elements:** Image container (`.thumbnail-container`), Image (`img`), Info container (`.product-info`), Title (`h3`), Short Description (`p`), View Link (`.product-link`).
*   **Implementation:** Defined in `catalog/_partials/miniatures/product.tpl`. Used by modules hooked to `displayHome` (like `ps_featuredproducts`) and product listing pages. Styled via `.product-card` and related classes in `custom.css`.
*   **Technical Considerations:** Uses PrestaShop's image regeneration system (`home_default` size defined in `theme.yml`). Dynamically displays product data (`{$product.name}`, `{$product.cover...url}`, `{$product.url}`, `{$product.description_short}`). Hover effects are CSS-driven. Layout within grids depends on parent container (e.g., `.products` grid).

### 6.3 Footer Components

*   **Elements:** Main wrapper (`.main-footer`), Content grid (`.footer-grid`), About section (`.footer-about`), Link sections (`.footer-links`, often rendered via `ps_linklist` module blocks), Contact section (`.footer-contact`, often rendered via `ps_contactinfo` module block), Social icons (`.social-icons`), Bottom bar (`.footer-bottom`).
*   **Implementation:** Structure in `_partials/footer.tpl`. Styling in `custom.css`. Dynamic content relies on modules hooked to `displayFooter`.
*   **Technical Considerations:** Uses CSS Grid for layout flexibility. Dynamic content population depends on PrestaShop module configuration. Styling needs to target both custom classes and potentially default module classes (`.block`, `.block_content`, etc.).

---

## 7. Code Architecture and Implementation (PrestaShop Theme)

The theme follows standard PrestaShop theme development practices.

### 7.1 Theme Structure & Smarty Templates (.tpl)

*   **Directory Structure:** Follows the structure outlined in `design_steps_detailed.md` (e.g., `themes/thescent/`, `assets/`, `templates/`, `config/`).
*   **Templating Engine:** Uses Smarty (`.tpl` files). Key features employed:
    *   Layout inheritance: `{extends file='layouts/layout-full-width.tpl'}`
    *   Template inclusion: `{include file='_partials/header.tpl'}`
    *   Blocks for overriding sections: `{block name='content'}...{/block}`
    *   Dynamic content insertion: `{hook h='displayHome'}`, PrestaShop variables (`{$shop.name}`, `{$product.price}`), Link generation (`{$link->getCategoryLink(3)}`).
*   **Key Template Files:** `layout-*.tpl`, `index.tpl`, `_partials/head.tpl`, `_partials/header.tpl`, `_partials/footer.tpl`, `catalog/_partials/miniatures/product.tpl`. Other templates (`product.tpl`, `product-list.tpl`, `cart.tpl`, etc.) exist but require further styling based on this initial design.

**Example (`index.tpl` structure):**
```smarty
{extends file='layouts/layout-full-width.tpl'}

{block name='content'}
  {* Hero Section (Hardcoded or Module) *}
  <section id="hero" ...>...</section>

  {* About Section (Hardcoded or Module/CMS) *}
  <section id="about" ...>...</section>

  {* Featured Products (Hook for Module) *}
  <section id="products" ...>
    <div class="container">
      <h2>Featured Collections</h2>
      {block name='hook_home'}
        {$HOOK_HOME nofilter} {* Renders ps_featuredproducts *}
      {/block}
      {* View All CTA *}
    </div>
  </section>

  {* Finder Section (Hardcoded or Module/CMS) *}
  <section id="finder" ...>...</section>

  {* Testimonials Section (Hardcoded or Module/CMS) *}
  <section id="testimonials" ...>...</section>

  {* Newsletter is typically hooked in footer area *}
{/block}
```

### 7.2 CSS Styling (custom.css)

*   **Location:** `themes/thescent/assets/css/custom.css`. Linked via `theme.yml`.
*   **Methodology:** Uses CSS variables (`:root`) for maintainable theming (colors, fonts, spacing). Organizes styles logically (base, layout, components, sections). Includes responsive styles via `@media` queries.
*   **Implementation:** Based directly on the provided `style.css`, with adjustments made to target PrestaShop's generated HTML structure and module classes where necessary.

**Example (Variable Usage):**
```css
:root {
  --color-primary: #1A4D5A;
  --font-heading: 'Cormorant Garamond', serif;
}
h1 { color: var(--color-primary); font-family: var(--font-heading); }
```

### 7.3 JavaScript Enhancements (custom.js)

*   **Location:** `themes/thescent/assets/js/custom.js`. Linked via `theme.yml`.
*   **Implementation:** Uses vanilla JavaScript, wrapped in a `DOMContentLoaded` listener.
*   **Functionality:**
    *   Handles mobile menu toggle (adds/removes `.active` class on `.mobile-nav` and `.mobile-menu-active` on `.main-header`).
    *   Handles sticky header (adds/removes `.sticky` class on `.main-header` based on scroll position).
    *   Coordinates absolute header positioning on homepage based on scroll.

**Example (Mobile Toggle Logic Snippet):**
```javascript
document.addEventListener('DOMContentLoaded', function() {
  const toggleButton = document.querySelector('.mobile-nav-toggle');
  const mobileNav = document.querySelector('.mobile-nav');
  const mainHeader = document.querySelector('.main-header');

  if (toggleButton && mobileNav && mainHeader) {
    toggleButton.addEventListener('click', () => {
      mobileNav.classList.toggle('active');
      mainHeader.classList.toggle('mobile-menu-active');
      // ... icon class toggle ...
    });
    // ... close on link click ...
  }
});
```

### 7.4 Theme Configuration (theme.yml)

*   **Location:** `themes/thescent/config/theme.yml`.
*   **Purpose:** Defines theme metadata (name, version, author, compatibility), layouts, assets (CSS/JS loading), global hook configurations (which modules attach to which hooks), required module dependencies, and image type definitions.
*   **Key Settings:** Ensures `custom.css` and `custom.js` are loaded, specifies default layout, lists necessary modules (`ps_mainmenu`, `ps_featuredproducts`, etc.), and defines image sizes (`home_default`, `large_default`, etc.) used in `.tpl` files.

**Example (`theme.yml` Snippet):**
```yaml
name: thescent
display_name: The Scent Theme
version: 1.0.0
# ... author, meta ...
assets:
  use_parent_assets: false
  css:
    all:
      - id: theme-custom-css
        path: assets/css/custom.css
  js:
    all:
      - id: theme-custom-js
        path: assets/js/custom.js
        priority: 200
        position: bottom
global_settings:
  hooks:
    modules_to_hook:
      displayNavFullWidth: [ps_mainmenu]
      displayHome: [ps_featuredproducts]
      # ... other hooks ...
  image_types:
    home_default: { width: 250, height: 250, scope: [products] }
    # ... other image sizes ...
dependencies:
  modules: [ps_mainmenu, ps_featuredproducts, ...]
```

---

## 8. Responsive and Adaptive Design

The theme incorporates responsive design principles to ensure usability across devices.

*   **Breakpoints:** Primarily uses `max-width: 992px` (tablet/small desktop) and `max-width: 576px` (mobile) media queries defined in `custom.css`. An intermediate `767px` breakpoint is also included for finer control.
*   **Key Adjustments:**
    *   **992px:** Hides desktop navigation/icons, displays mobile toggle button. Stacks About section columns. Adjusts footer grid columns.
    *   **767px:** Adjusts heading sizes, section padding, product/finder grid `minmax` values.
    *   **576px:** Further adjusts heading/font sizes, section padding. Stacks product grid, finder grid, and testimonials into single columns. Adjusts newsletter form layout to vertical stack. Stacks footer grid columns and centers content. Centers footer bottom content.
*   **Fluid Layouts:** Uses CSS Grid (`repeat(auto-fit, minmax(...))`) and Flexbox where appropriate to allow content to reflow naturally. Uses relative units (`rem`, `%`, `vw` via `clamp()`) for spacing and typography where feasible.
*   **Touch Interactions:** Standard browser handling for touch events. Mobile menu provides large, clear tap targets. Hover effects relying purely on `:hover` might need consideration for touch-only devices (though many mobile browsers emulate hover on tap).

**Example (`custom.css` Media Query):**
```css
@media (max-width: 992px) {
  .main-nav, #_desktop_top_menu, .header-icons { display: none !important; }
  .mobile-nav-toggle { display: block !important; }
  .about-container { grid-template-columns: 1fr; /* Stack columns */ }
}

@media (max-width: 576px) {
  #products .products, .product-grid { grid-template-columns: 1fr; /* Single column */ }
  .footer-grid { grid-template-columns: 1fr; text-align: center; }
  /* ... other mobile adjustments ... */
}
```

---

## 9. Performance and Accessibility Considerations

While the initial focus is on implementing the design, standard best practices for performance and accessibility should be followed.

### Performance

*   **PrestaShop Caching:** Utilize PrestaShop's built-in caching mechanisms (Smarty cache, CCC for CSS/JS aggregation/minification) via `Advanced Parameters > Performance`.
*   **Image Optimization:** Leverage PrestaShop's image regeneration using the defined sizes in `theme.yml`. Ensure source images uploaded are reasonably sized. Consider using modern formats like WebP via modules or server configuration if possible.
*   **CSS/JS:** `custom.css` and `custom.js` are relatively lean in the initial implementation. PrestaShop's CCC feature helps minimize requests. Avoid overly complex selectors or heavy JS operations where possible.
*   **Font Loading:** Google Fonts are loaded via `<link>` in the head. Consider font-display strategies (`swap`) for better perceived performance.
*   **Lazy Loading:** Implement lazy loading for product images (especially on category pages) using JavaScript IntersectionObserver (as shown in sample spec, though not explicitly in initial JS) or a PrestaShop module.

### Accessibility

*   **Semantic HTML:** Use appropriate HTML5 tags (`<header>`, `<nav>`, `<main>`, `<section>`, `<footer>`, `<article>`) as implemented in the `.tpl` files.
*   **Color Contrast:** Review color combinations (e.g., `--color-accent` on white/light backgrounds, white text on `--color-secondary`) against WCAG AA guidelines. Adjust shades if necessary.
*   **Keyboard Navigation:** Ensure all interactive elements (links, buttons, form inputs) are navigable and operable using the keyboard. Rely on default browser/PrestaShop behavior initially, but test thoroughly.
*   **Focus Indicators:** Implement clear and visible `:focus` styles for all interactive elements, potentially enhancing browser defaults using outlines that match the theme's aesthetic (e.g., using `--color-accent`). Needs explicit CSS rules.
*   **ARIA Attributes:** Use `aria-label` for icon-only buttons (as implemented for header icons and mobile toggle). Add other ARIA roles/attributes as needed for complex dynamic components if introduced later.
*   **Alternative Text:** Ensure all meaningful images uploaded via PrestaShop (products, banners) have descriptive alt text. Decorative images (like potentially the hero background) should have empty `alt=""`.

---

## 10. Testing, Maintenance, and Future Enhancements

### Testing

*   **Cross-Browser Testing:** Verify appearance and functionality on latest versions of major browsers (Chrome, Firefox, Safari, Edge).
*   **Responsive Testing:** Test thoroughly on various screen sizes using browser developer tools and real devices if possible.
*   **Functional Testing:** Test all core PrestaShop user flows: browsing, searching, adding to cart, checkout, user account creation/login, newsletter signup.
*   **Module Compatibility:** Ensure compatibility with essential PrestaShop modules listed in `theme.yml`.
*   **Accessibility Audit:** Perform basic checks using browser tools (Lighthouse) and manual keyboard navigation tests.

### Maintenance

*   **Version Control:** Use Git for tracking changes to theme files.
*   **PrestaShop Updates:** Keep the PrestaShop core and modules updated, testing the theme's compatibility after significant updates.
*   **Code Clarity:** Maintain clean, commented code in `.tpl`, `.css`, and `.js` files.

### Future Enhancements

*   **Dynamic Content Sections:** Replace hardcoded homepage sections (About, Finder, Testimonials) with content manageable via PrestaShop CMS blocks, custom modules, or theme configuration options.
*   **Scent Finder Tool:** Develop the "Scent Quiz" functionality, likely requiring a custom module or integration with a third-party service.
*   **Advanced Animations:** Introduce more sophisticated scroll-triggered animations or micro-interactions if desired and performance permits.
*   **Performance Tuning:** Further optimize image loading, investigate critical CSS, and refine JS execution.
*   **Full Page Styling:** Complete the styling for remaining PrestaShop pages (product detail, category listing, cart, checkout, account, CMS) to match the homepage aesthetic.
*   **Accessibility Improvements:** Conduct thorough accessibility audits and implement necessary fixes/enhancements based on findings.

---

## 11. Conclusion

This technical design specification details the implementation of "The Scent" custom theme for the PrestaShop platform. It successfully translates the provided visual design into a functional theme structure leveraging PrestaShop's Smarty templating, module system, and configuration options.

Key achievements include:
*   Establishing the core theme file structure and configuration (`theme.yml`).
*   Implementing the distinct visual identity using CSS variables for colors (`--color-primary`, `--color-accent`, etc.) and typography (`Cormorant Garamond`, `Montserrat`, `Raleway`).
*   Creating the main layout components: a dynamic sticky header, a multi-column footer, and core page structure (`layout-full-width.tpl`).
*   Styling key e-commerce components, particularly the homepage product grid (`product.tpl` miniature).
*   Integrating essential UI interactions like the mobile menu toggle and subtle hover effects via CSS and vanilla JavaScript.
*   Ensuring a responsive design adapting to various screen sizes via media queries.

This specification provides a solid foundation for the "The Scent" e-commerce site. Further development will focus on styling the remaining page templates, potentially replacing static content with dynamic solutions, and refining performance and accessibility based on ongoing testing and requirements.

https://drive.google.com/file/d/11h0VaPhqz5-19seVdVKRCJ6hdgUAwWOC/view?usp=sharing,  
https://drive.google.com/file/d/18qQ1e8wFx2VFsHibo36pz1OVvsaYOyjw/view?usp=sharing,  
https://drive.google.com/file/d/1DZ5zKYkujc7DFuhdejjxkUmPUWWLgYRw/view?usp=sharing,  
https://drive.google.com/file/d/1XlSbOkJE89uirhnCUTNLm-FSqQdJ1vDa/view?usp=sharing,  
https://aistudio.google.com/app/prompts?state=%7B%22ids%22:%5B%221eS1XtsjYZ-zdDSdpZfNCswf9QjmayN1e%22%5D,%22action%22:%22open%22,%22userId%22:%22103961307342447084491%22,%22resourceKeys%22:%7B%7D%7D&usp=sharing,  
https://drive.google.com/file/d/1mVlM5TkgWIczlZIsulOde5oJen79L7GW/view?usp=sharing
