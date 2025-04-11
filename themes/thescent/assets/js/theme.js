/**
 * The Scent Theme JavaScript
 * Core functionality for PrestaShop theme
 */

// Ensure prestashop object exists
if (typeof prestashop === 'undefined') {
  var prestashop = {};
}

/**
 * Theme entry point
 */
$(document).ready(() => {
  // Initialize core theme functionality
  thescent.init();
});

/**
 * Theme namespace
 */
const thescent = {
  // Theme settings
  settings: {
    breakpoints: {
      tablet: 992,
      mobile: 576
    },
    selectors: {
      productMinitature: '.js-product-miniature',
      addToCart: '.js-add-to-cart',
      productQuantity: '.js-product-quantity',
      cart: '#_desktop_cart',
      cartProducts: '.cart-products-count',
      searchWidget: '#search_widget',
      // Add more selectors as needed
    }
  },

  /**
   * Theme initialization
   */
  init() {
    // Initialize core components
    this.initComponents();
    
    // Bind core events
    this.bindEvents();
    
    // Initialize product handlers
    this.initProducts();
    
    // Initialize cart functionality
    this.initCart();
    
    // Initialize search functionality
    this.initSearch();

    // Initialize forms
    this.initForms();
  },

  /**
   * Initialize core components
   */
  initComponents() {
    // Initialize tooltips if Bootstrap is used
    if (typeof $().tooltip === 'function') {
      $('[data-toggle="tooltip"]').tooltip();
    }

    // Initialize dropdowns
    this.initDropdowns();

    // Initialize modals if needed
    this.initModals();
  },

  /**
   * Bind core PrestaShop events
   */
  bindEvents() {
    // Update cart
    prestashop.on('updateCart', (event) => {
      this.updateCart(event);
    });

    // Update product list
    prestashop.on('updateProductList', () => {
      this.refreshProductList();
    });

    // Quick view modal
    prestashop.on('showQuickview', (event) => {
      this.handleQuickView(event);
    });

    // Handle responsive updates
    $(window).on('resize', _.debounce(() => {
      this.handleResponsive();
    }, 300));
  },

  /**
   * Initialize product-related functionality
   */
  initProducts() {
    const self = this;

    // Handle add to cart
    $(document).on('click', this.settings.selectors.addToCart, function(e) {
      e.preventDefault();
      self.handleAddToCart($(this));
    });

    // Handle quantity changes
    $(document).on('change', this.settings.selectors.productQuantity, function(e) {
      self.handleQuantityChange($(this));
    });

    // Initialize product miniatures
    $(this.settings.selectors.productMinitature).each(function() {
      self.initProductMiniature($(this));
    });
  },

  /**
   * Initialize cart functionality
   */
  initCart() {
    const self = this;

    // Update cart preview on hover/click
    $(this.settings.selectors.cart).on('mouseenter click', function(e) {
      self.updateCartPreview();
    });

    // Handle cart updates
    prestashop.on('updateCart', (event) => {
      if (!event.reason || event.reason.linkAction !== 'add-to-cart') {
        this.updateCartPreview();
      }
    });
  },

  /**
   * Initialize search functionality
   */
  initSearch() {
    const $searchWidget = $(this.settings.selectors.searchWidget);
    
    if ($searchWidget.length) {
      // Handle search input
      $searchWidget.find('input[type=text]').on('keyup', _.debounce((e) => {
        this.handleSearch($(e.currentTarget));
      }, 300));
    }
  },

  /**
   * Initialize form handling
   */
  initForms() {
    // Add custom form validation
    this.initFormValidation();

    // Handle form submissions
    $('form').on('submit', (e) => {
      if (!this.validateForm($(e.currentTarget))) {
        e.preventDefault();
      }
    });
  },

  /**
   * Handle add to cart action
   * @param {jQuery} $button
   */
  handleAddToCart($button) {
    if ($button.data('disabled')) {
      return;
    }

    const $form = $button.closest('form');
    const query = $form.serialize() + '&add=1&action=update';
    const actionURL = $form.attr('action');

    $.post(actionURL, query, null, 'json').then((resp) => {
      prestashop.emit('updateCart', {
        reason: {
          idProduct: resp.id_product,
          idProductAttribute: resp.id_product_attribute,
          linkAction: 'add-to-cart'
        }
      });
    }).catch((resp) => {
      prestashop.emit('handleError', {
        eventType: 'addProductToCart',
        resp: resp
      });
    });
  },

  /**
   * Handle quantity changes
   * @param {jQuery} $input
   */
  handleQuantityChange($input) {
    const minQuantity = parseInt($input.attr('min'), 10);
    let currentValue = parseInt($input.val(), 10);

    if (currentValue < minQuantity) {
      $input.val(minQuantity);
      currentValue = minQuantity;
    }

    prestashop.emit('updateProduct', {
      eventType: 'updateProductQuantity',
      event: event,
      quantity: currentValue
    });
  },

  /**
   * Update cart preview
   */
  updateCartPreview() {
    const $cart = $(this.settings.selectors.cart);
    const refresh_url = $cart.data('refresh-url');

    if (refresh_url) {
      $.get(refresh_url).then((resp) => {
        this.updateCartContent(resp);
      });
    }
  },

  /**
   * Update cart content
   * @param {Object} resp - Cart data
   */
  updateCartContent(resp) {
    const $cart = $(this.settings.selectors.cart);
    const $cartProducts = $(this.settings.selectors.cartProducts);

    if ($cartProducts.length) {
      $cartProducts.text(resp.cart.products_count);
    }

    prestashop.emit('updatedCart', resp);
  },

  /**
   * Handle search input
   * @param {jQuery} $input
   */
  handleSearch($input) {
    const minChars = 3;
    const query = $input.val();

    if (query.length >= minChars) {
      this.performSearch(query);
    }
  },

  /**
   * Perform search request
   * @param {string} query
   */
  performSearch(query) {
    const $searchWidget = $(this.settings.selectors.searchWidget);
    const searchURL = $searchWidget.data('search-url');

    if (searchURL) {
      $.get(searchURL, {
        s: query
      }).then((resp) => {
        this.updateSearchResults(resp);
      });
    }
  },

  /**
   * Update search results
   * @param {Object} resp - Search results
   */
  updateSearchResults(resp) {
    const $searchWidget = $(this.settings.selectors.searchWidget);
    const $results = $searchWidget.find('.search-results');

    if ($results.length) {
      $results.html(resp.rendered_products || '');
    }
  },

  /**
   * Initialize form validation
   */
  initFormValidation() {
    // Add custom validation rules if needed
    $.validator.addMethod('phone', function(value, element) {
      return this.optional(element) || /^[+]?[\d\s-]+$/.test(value);
    }, 'Please enter a valid phone number');
  },

  /**
   * Validate form
   * @param {jQuery} $form
   * @returns {boolean}
   */
  validateForm($form) {
    if (typeof $.validator === 'undefined') {
      return true;
    }

    return $form.valid();
  },

  /**
   * Handle responsive updates
   */
  handleResponsive() {
    const width = $(window).width();
    
    if (width <= this.settings.breakpoints.mobile) {
      prestashop.emit('responsive update', {
        mobile: true
      });
    } else if (width <= this.settings.breakpoints.tablet) {
      prestashop.emit('responsive update', {
        tablet: true
      });
    } else {
      prestashop.emit('responsive update', {
        desktop: true
      });
    }
  },

  /**
   * Initialize dropdowns
   */
  initDropdowns() {
    $('.dropdown-toggle').dropdown();
  },

  /**
   * Initialize modals
   */
  initModals() {
    // Initialize product modal
    $(document).on('click', '.js-product-modal', (e) => {
      e.preventDefault();
      const $trigger = $(e.currentTarget);
      const modalUrl = $trigger.data('modal-url');

      if (modalUrl) {
        this.loadModal(modalUrl);
      }
    });
  },

  /**
   * Load modal content
   * @param {string} url
   */
  loadModal(url) {
    $.get(url).then((resp) => {
      const $modal = $(resp).modal();
      prestashop.emit('modalLoaded', {
        modal: $modal
      });
    });
  },

  /**
   * Utility function to format currency
   * @param {number} price
   * @param {string} currencySign
   * @returns {string}
   */
  formatCurrency(price, currencySign = '€') {
    return `${price.toFixed(2)} ${currencySign}`;
  },

  /**
   * Handle quick view
   * @param {Object} event
   */
  handleQuickView(event) {
    if (!event.quickViewUrl) {
      return;
    }

    $.get(event.quickViewUrl).then((resp) => {
      $('body').append(resp);
      const $modal = $('#product-modal');
      
      $modal.modal('show');
      
      prestashop.emit('quickviewOpened', {
        modal: $modal,
        productId: event.productId
      });
    });
  },

  /**
   * Refresh product list
   */
  refreshProductList() {
    $(this.settings.selectors.productMinitature).each((index, element) => {
      this.initProductMiniature($(element));
    });
  },

  /**
   * Initialize product miniature
   * @param {jQuery} $miniature
   */
  initProductMiniature($miniature) {
    // Add any specific product miniature initialization
    // For example, equalizing heights, initializing sliders, etc.
    this.equalizeProductHeights($miniature);
  },

  /**
   * Equalize product heights in a row
   * @param {jQuery} $miniature
   */
  equalizeProductHeights($miniature) {
    const $info = $miniature.find('.product-info');
    const $row = $miniature.closest('.row');
    const $siblings = $row.find('.product-info');
    
    let maxHeight = 0;
    
    $siblings.css('height', 'auto');
    
    $siblings.each((index, element) => {
      maxHeight = Math.max(maxHeight, $(element).outerHeight());
    });
    
    $siblings.css('height', maxHeight + 'px');
  }
};

// Export for module usage if needed
export default thescent;

/**
 * The Scent Theme JS
 */
class TheScentTheme {
  constructor() {
    this.init();
  }

  init() {
    // Initialize all components
    this.initMobileNav();
    this.initStickyHeader();
    this.initSearchOverlay();
    this.initProductGallery();
    this.initQuantityControls();
    this.initFormValidation();
    this.initNewsletterPopup();
    this.initLiveSearch();
  }

  // Mobile Navigation
  initMobileNav() {
    const toggleBtn = document.querySelector('.mobile-nav-toggle');
    const mobileNav = document.querySelector('.mobile-nav');
    const header = document.querySelector('.main-header');

    if (toggleBtn && mobileNav) {
      toggleBtn.addEventListener('click', () => {
        mobileNav.classList.toggle('active');
        header.classList.toggle('mobile-menu-active');
        toggleBtn.setAttribute('aria-expanded', 
          toggleBtn.getAttribute('aria-expanded') === 'true' ? 'false' : 'true'
        );
      });

      // Close menu when clicking outside
      document.addEventListener('click', (e) => {
        if (!mobileNav.contains(e.target) && !toggleBtn.contains(e.target)) {
          mobileNav.classList.remove('active');
          header.classList.remove('mobile-menu-active');
          toggleBtn.setAttribute('aria-expanded', 'false');
        }
      });
    }
  }

  // Sticky Header
  initStickyHeader() {
    const header = document.querySelector('.main-header');
    let lastScroll = 0;
    
    if (header) {
      window.addEventListener('scroll', () => {
        const currentScroll = window.pageYOffset;
        
        if (currentScroll <= 0) {
          header.classList.remove('sticky', 'show', 'hide');
          return;
        }
        
        if (currentScroll > lastScroll && !header.classList.contains('hide')) {
          // Scrolling down
          header.classList.remove('show');
          header.classList.add('hide');
        } else if (currentScroll < lastScroll && header.classList.contains('hide')) {
          // Scrolling up
          header.classList.remove('hide');
          header.classList.add('show', 'sticky');
        }
        lastScroll = currentScroll;
      });
    }
  }

  // Search Overlay
  initSearchOverlay() {
    const searchToggle = document.querySelector('.search-toggle');
    const searchOverlay = document.querySelector('.search-overlay');
    const closeSearch = document.querySelector('.close-search');
    const searchInput = document.querySelector('.search-overlay input[type="text"]');

    if (searchToggle && searchOverlay) {
      searchToggle.addEventListener('click', (e) => {
        e.preventDefault();
        searchOverlay.classList.add('active');
        document.body.style.overflow = 'hidden';
        if (searchInput) {
          setTimeout(() => searchInput.focus(), 100);
        }
      });

      if (closeSearch) {
        closeSearch.addEventListener('click', () => {
          searchOverlay.classList.remove('active');
          document.body.style.overflow = '';
        });
      }

      // Close on escape key
      document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape' && searchOverlay.classList.contains('active')) {
          searchOverlay.classList.remove('active');
          document.body.style.overflow = '';
        }
      });
    }
  }

  // Product Gallery
  initProductGallery() {
    const productCover = document.querySelector('.product-cover');
    const thumbs = document.querySelectorAll('.product-images img');
    
    if (productCover && thumbs.length) {
      thumbs.forEach(thumb => {
        thumb.addEventListener('click', () => {
          const mainImg = productCover.querySelector('img');
          if (mainImg) {
            mainImg.src = thumb.src;
            thumbs.forEach(t => t.classList.remove('selected'));
            thumb.classList.add('selected');
          }
        });
      });
    }
  }

  // Quantity Controls
  initQuantityControls() {
    document.querySelectorAll('.qty-controls').forEach(control => {
      const input = control.querySelector('input[type="number"]');
      const btnUp = control.querySelector('.qty-up');
      const btnDown = control.querySelector('.qty-down');

      if (input && btnUp && btnDown) {
        btnUp.addEventListener('click', () => {
          input.value = parseInt(input.value) + 1;
          input.dispatchEvent(new Event('change'));
        });

        btnDown.addEventListener('click', () => {
          if (parseInt(input.value) > 1) {
            input.value = parseInt(input.value) - 1;
            input.dispatchEvent(new Event('change'));
          }
        });
      }
    });
  }

  // Form Validation
  initFormValidation() {
    const forms = document.querySelectorAll('form[data-validate]');
    
    forms.forEach(form => {
      form.addEventListener('submit', (e) => {
        let isValid = true;
        
        // Clear previous errors
        form.querySelectorAll('.form-error').forEach(error => error.remove());
        form.querySelectorAll('.has-error').forEach(field => {
          field.classList.remove('has-error');
        });

        // Validate required fields
        form.querySelectorAll('[required]').forEach(field => {
          if (!field.value.trim()) {
            isValid = false;
            this.showFieldError(field, prestashop.translations.required_field);
          }
        });

        // Validate email fields
        form.querySelectorAll('input[type="email"]').forEach(field => {
          if (field.value && !this.isValidEmail(field.value)) {
            isValid = false;
            this.showFieldError(field, prestashop.translations.invalid_email);
          }
        });

        if (!isValid) {
          e.preventDefault();
        }
      });
    });
  }

  showFieldError(field, message) {
    field.classList.add('has-error');
    const error = document.createElement('div');
    error.className = 'form-error';
    error.textContent = message;
    field.parentNode.appendChild(error);
  }

  isValidEmail(email) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
  }

  // Newsletter Popup
  initNewsletterPopup() {
    const popup = document.querySelector('.newsletter-popup');
    if (!popup) return;

    // Show popup after 5 seconds if not previously dismissed
    if (!localStorage.getItem('newsletter_popup_dismissed')) {
      setTimeout(() => {
        popup.classList.add('active');
      }, 5000);

      const closeBtn = popup.querySelector('.close-popup');
      if (closeBtn) {
        closeBtn.addEventListener('click', () => {
          popup.classList.remove('active');
          localStorage.setItem('newsletter_popup_dismissed', 'true');
        });
      }
    }
  }

  // Live Search Implementation
  initLiveSearch() {
    const searchInput = document.querySelector('.search-overlay input[type="search"]');
    const resultsContainer = document.querySelector('.live-search-results');
    let searchTimeout;

    if (searchInput && resultsContainer) {
      searchInput.addEventListener('input', (e) => {
        clearTimeout(searchTimeout);
        const query = e.target.value;

        if (query.length >= 3) {
          searchTimeout = setTimeout(() => {
            this.performLiveSearch(query, resultsContainer);
          }, 300);
        } else {
          resultsContainer.innerHTML = '';
        }
      });
    }
  }

  performLiveSearch(query, container) {
    const searchUrl = prestashop.urls.base_url + 'modules/ps_searchbar/ps_searchbar-ajax.php';
    
    fetch(searchUrl, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: `s=${encodeURIComponent(query)}&resultsPerPage=4`
    })
    .then(response => response.json())
    .then(data => {
      if (data.products && data.products.length) {
        this.renderSearchResults(data.products, container);
      } else {
        container.innerHTML = `
          <div class="no-results">
            <p>${prestashop.translations.no_products_found}</p>
          </div>
        `;
      }
    })
    .catch(error => {
      console.error('Search error:', error);
      container.innerHTML = `
        <div class="search-error">
          <p>${prestashop.translations.search_error}</p>
        </div>
      `;
    });
  }

  renderSearchResults(products, container) {
    const html = `
      <div class="search-results-grid">
        ${products.map(product => `
          <a href="${product.url}" class="search-result-item">
            <div class="result-image">
              <img src="${product.cover.small.url}" alt="${product.name}" loading="lazy">
            </div>
            <div class="result-info">
              <h4>${product.name}</h4>
              <div class="result-price">
                ${product.price}
              </div>
            </div>
          </a>
        `).join('')}
      </div>
      <div class="view-all-results">
        <a href="${prestashop.urls.pages.search}?s=${encodeURIComponent(document.querySelector('.search-overlay input[type="search"]').value)}" class="btn btn-secondary">
          ${prestashop.translations.view_all_results}
        </a>
      </div>
    `;
    
    container.innerHTML = html;
  }
}

// Initialize theme when DOM is ready
document.addEventListener('DOMContentLoaded', () => {
  new TheScentTheme();
});

/**
 * PrestaShop Theme Core JS
 */
$(document).ready(function() {
  // Initialize core components
  prestashop.thescent = {
    init: function() {
      this.initTopMenu();
      this.initSearch();
      this.initCart();
    },

    initTopMenu: function() {
      $('.js-top-menu').find('[data-depth="0"]').hover(function() {
        $(this).addClass('sfHover');
      }, function() {
        $(this).removeClass('sfHover');
      });
    },

    initSearch: function() {
      // Search functionality
    },

    initCart: function() {
      // Cart functionality  
    }
  };

  prestashop.thescent.init();
});