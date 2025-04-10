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