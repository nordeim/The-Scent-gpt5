document.addEventListener('DOMContentLoaded', function() {
  // Sticky Header
  const header = document.querySelector('.main-header');
  let lastScroll = 0;
  
  function handleScroll() {
    const currentScroll = window.pageYOffset;
    if (currentScroll > 50) {
      header.classList.add('sticky');
    } else {
      header.classList.remove('sticky');
    }
    lastScroll = currentScroll;
  }

  window.addEventListener('scroll', handleScroll);

  // Mobile Menu Toggle
  const toggleButton = document.querySelector('.mobile-nav-toggle');
  const mobileNav = document.querySelector('.mobile-nav');
  
  if (toggleButton && mobileNav) {
    toggleButton.addEventListener('click', () => {
      mobileNav.classList.toggle('active');
      header.classList.toggle('nav-open');
    });
  }

  // Loading State Handler
  function addLoadingState(button) {
    button.classList.add('loading');
    button.disabled = true;
  }

  function removeLoadingState(button) {
    button.classList.remove('loading');
    button.disabled = false;
  }

  // Apply to forms
  document.querySelectorAll('form').forEach(form => {
    form.addEventListener('submit', function(e) {
      const submitButton = this.querySelector('[type="submit"]');
      if (submitButton) {
        addLoadingState(submitButton);
      }
    });
  });

  // Quick View Handler (if module is present)
  document.querySelectorAll('.quick-view-btn').forEach(btn => {
    btn.addEventListener('click', function(e) {
      e.preventDefault();
      // Quick view logic here (depends on PrestaShop's quick view module)
    });
  });

  // Enhanced Mobile Menu
  const mainHeader = document.querySelector('.main-header');

  if (toggleButton && mobileNav && mainHeader) {
    toggleButton.addEventListener('click', () => {
      const isExpanded = toggleButton.getAttribute('aria-expanded') === 'true';
      
      mobileNav.classList.toggle('active');
      mainHeader.classList.toggle('mobile-menu-active');
      
      toggleButton.setAttribute('aria-expanded', !isExpanded);
      
      const icon = toggleButton.querySelector('i');
      if (icon) {
        icon.classList.toggle('fa-bars');
        icon.classList.toggle('fa-times');
      }
    });

    // Close menu when clicking outside
    document.addEventListener('click', function(e) {
      if (!mobileNav.contains(e.target) && !toggleButton.contains(e.target)) {
        if (mobileNav.classList.contains('active')) {
          mobileNav.classList.remove('active');
          mainHeader.classList.remove('mobile-menu-active');
          toggleButton.setAttribute('aria-expanded', 'false');
          
          const icon = toggleButton.querySelector('i');
          if (icon) {
            icon.classList.add('fa-bars');
            icon.classList.remove('fa-times');
          }
        }
      }
    });
  }

  // Scent Finder Handler
  document.querySelectorAll('.finder-card').forEach(card => {
    card.addEventListener('click', function() {
      const category = this.dataset.category;
      if (category) {
        window.location.href = `${prestashop.urls.base_url}category/${category}`;
      }
    });
  });

  // Add smooth scroll for anchor links
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
      e.preventDefault();
      const target = document.querySelector(this.getAttribute('href'));
      if (target) {
        target.scrollIntoView({
          behavior: 'smooth',
          block: 'start'
        });
      }
    });
  });

  // Add intersection observer for scroll animations
  const animateOnScroll = () => {
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('animate');
        }
      });
    }, {
      threshold: 0.1
    });

    document.querySelectorAll('.animate-on-scroll').forEach((el) => observer.observe(el));
  };

  // Initialize animations
  animateOnScroll();

  // Search Overlay
  const searchToggle = document.querySelector('.search-toggle');
  const searchOverlay = document.querySelector('.search-overlay');
  const closeSearch = document.querySelector('.close-search');
  const searchInput = document.querySelector('.search-input');

  if (searchToggle && searchOverlay) {
    searchToggle.addEventListener('click', () => {
      searchOverlay.classList.add('active');
      searchInput.focus();
      document.body.style.overflow = 'hidden';
    });

    closeSearch.addEventListener('click', () => {
      searchOverlay.classList.remove('active');
      document.body.style.overflow = '';
    });
  }

  // Cart Popup
  const cartToggle = document.querySelector('.cart-toggle');
  const cartPopup = document.querySelector('.cart-popup');

  if (cartToggle && cartPopup) {
    cartToggle.addEventListener('click', (e) => {
      e.preventDefault();
      cartPopup.classList.toggle('active');
    });

    // Close cart popup when clicking outside
    document.addEventListener('click', (e) => {
      if (!cartPopup.contains(e.target) && !cartToggle.contains(e.target)) {
        cartPopup.classList.remove('active');
      }
    });
  }

  // Form Validation
  const newsletterForm = document.querySelector('.newsletter-form');
  if (newsletterForm) {
    newsletterForm.addEventListener('submit', async (e) => {
      e.preventDefault();
      const button = newsletterForm.querySelector('button');
      const email = newsletterForm.querySelector('input[type="email"]');
      
      button.classList.add('loading');
      
      try {
        // Simulate API call
        await new Promise(resolve => setTimeout(resolve, 1000));
        
        showMessage('Successfully subscribed!', 'success');
        email.value = '';
      } catch (error) {
        showMessage('An error occurred. Please try again.', 'error');
      } finally {
        button.classList.remove('loading');
      }
    });
  }

  // Helper function to show form messages
  function showFormMessage(form, message, type) {
    const existingMessage = form.querySelector('.form-message');
    if (existingMessage) {
      existingMessage.remove();
    }

    const messageDiv = document.createElement('div');
    messageDiv.className = `form-message form-${type}`;
    messageDiv.textContent = message;
    form.insertAdjacentElement('afterend', messageDiv);

    // Remove message after 5 seconds
    setTimeout(() => {
      messageDiv.remove();
    }, 5000);
  }

  // Helper Functions
  function showMessage(message, type) {
    const messageDiv = document.createElement('div');
    messageDiv.classList.add('form-message', `form-${type}`);
    messageDiv.textContent = message;
    
    const container = document.querySelector('.newsletter-content');
    container.appendChild(messageDiv);
    
    setTimeout(() => messageDiv.remove(), 3000);
  }

  // Mobile Menu Toggle
  const toggleButton = document.querySelector('.mobile-nav-toggle');
  const mobileNav = document.querySelector('.mobile-nav');
  const mainHeader = document.querySelector('.main-header');

  if (toggleButton && mobileNav && mainHeader) {
    toggleButton.addEventListener('click', () => {
      mobileNav.classList.toggle('active');
      mainHeader.classList.toggle('mobile-menu-active');
      const icon = toggleButton.querySelector('i');
      icon.classList.toggle('fa-bars');
      icon.classList.toggle('fa-times');
    });
  }

  // Sticky Header
  const header = document.querySelector('.main-header');
  let lastScroll = 0;

  window.addEventListener('scroll', () => {
    const currentScroll = window.pageYOffset;
    
    if (currentScroll > 50) {
      header.classList.add('sticky');
    } else {
      header.classList.remove('sticky');
    }

    if (currentScroll > lastScroll && currentScroll > 100) {
      header.classList.add('hide');
    } else {
      header.classList.remove('hide');
    }
    
    lastScroll = currentScroll;
  });

  // Loading States
  document.addEventListener('DOMContentLoaded', () => {
    // Add loading skeletons
    document.querySelectorAll('.product-card').forEach(card => {
      card.classList.remove('skeleton');
    });
  });

  // Form Validation and Loading States
  const forms = document.querySelectorAll('form');
  forms.forEach(form => {
    form.addEventListener('submit', async (e) => {
      if (form.classList.contains('newsletter-form')) {
        e.preventDefault();
        const button = form.querySelector('button[type="submit"]');
        const email = form.querySelector('input[type="email"]');
        
        if (!validateEmail(email.value)) {
          showFormMessage(form, 'Please enter a valid email address', 'error');
          return;
        }
        
        button.classList.add('loading');
        
        try {
          await submitNewsletterForm(email.value);
          showFormMessage(form, 'Successfully subscribed!', 'success');
          email.value = '';
        } catch (error) {
          showFormMessage(form, 'An error occurred. Please try again.', 'error');
        } finally {
          button.classList.remove('loading');
        }
      }
    });
  });

  // Helper Functions
  function validateEmail(email) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
  }

  function showFormMessage(form, message, type) {
    const existingMessage = form.querySelector('.form-message');
    if (existingMessage) {
      existingMessage.remove();
    }

    const messageDiv = document.createElement('div');
    messageDiv.classList.add('form-message', `form-message-${type}`);
    messageDiv.textContent = message;
    form.appendChild(messageDiv);

    setTimeout(() => messageDiv.remove(), 5000);
  }

  async function submitNewsletterForm(email) {
    // Simulate API call - replace with actual API endpoint
    return new Promise((resolve) => setTimeout(resolve, 1000));
  }

  // Live Search Implementation
  document.addEventListener('DOMContentLoaded', function() {
    const searchOverlay = document.querySelector('.search-overlay');
    const searchInput = document.querySelector('.search-input');
    const searchResults = document.querySelector('.search-results');
    const loadingIndicator = document.querySelector('.search-loading');
    const noResultsMessage = document.querySelector('.search-no-results');
    const categoryList = document.querySelector('.category-list');
    const productList = document.querySelector('.product-list-mini');
    
    // Search toggle
    document.querySelectorAll('.search-toggle').forEach(button => {
      button.addEventListener('click', () => {
        searchOverlay.classList.add('active');
        searchInput.focus();
      });
    });

    document.querySelector('.btn-close-search').addEventListener('click', () => {
      searchOverlay.classList.remove('active');
    });

    // Close on escape key
    document.addEventListener('keydown', (e) => {
      if (e.key === 'Escape' && searchOverlay.classList.contains('active')) {
        searchOverlay.classList.remove('active');
      }
    });

    let searchTimeout;
    const debounceDelay = 300;

    searchInput.addEventListener('input', function(e) {
      clearTimeout(searchTimeout);
      const query = e.target.value.trim();

      if (query.length < 2) {
        resetSearch();
        return;
      }

      searchTimeout = setTimeout(() => performSearch(query), debounceDelay);
    });

    function performSearch(query) {
      showLoading();
      
      fetch(`${prestashop.urls.base_url}module/ps_searchbar/ajax?q=${encodeURIComponent(query)}`)
        .then(response => response.json())
        .then(data => {
          hideLoading();
          updateResults(data);
        })
        .catch(error => {
          console.error('Search error:', error);
          hideLoading();
          showError();
        });
    }

    function updateResults(data) {
      if (!data.products.length && !data.categories.length) {
        showNoResults();
        return;
      }

      // Update categories
      categoryList.innerHTML = data.categories.map(category => `
        <li class="category-item">
          <a href="${category.url}" class="category-link">
            <span>${category.name}</span>
            <span class="product-count">${category.product_count}</span>
          </a>
        </li>
      `).join('');

      // Update products
      productList.innerHTML = data.products.map(product => `
        <div class="col-6 col-md-4">
          <article class="product-miniature">
            <a href="${product.url}" class="product-link">
              <div class="product-image">
                <img src="${product.cover_image}" alt="${product.name}" loading="lazy">
              </div>
              <div class="product-meta">
                <h3 class="product-title">${product.name}</h3>
                <div class="product-price">${product.price}</div>
              </div>
            </a>
          </article>
        </div>
      `).join('');

      showResults();
    }

    function showLoading() {
      loadingIndicator.classList.remove('d-none');
      noResultsMessage.classList.add('d-none');
      categoryList.innerHTML = '';
      productList.innerHTML = '';
    }

    function hideLoading() {
      loadingIndicator.classList.add('d-none');
    }

    function showNoResults() {
      noResultsMessage.classList.remove('d-none');
      categoryList.innerHTML = '';
      productList.innerHTML = '';
    }

    function showResults() {
      noResultsMessage.classList.add('d-none');
    }

    function showError() {
      // Could enhance this with a proper error message display
      showNoResults();
    }

    function resetSearch() {
      categoryList.innerHTML = '';
      productList.innerHTML = '';
      noResultsMessage.classList.add('d-none');
    }
  });

  // Live Search Implementation
  class LiveSearch {
    constructor() {
      this.overlay = document.getElementById('search-overlay');
      this.form = document.getElementById('live-search-form');
      this.input = this.form?.querySelector('.search-input');
      this.results = document.querySelector('.search-results');
      this.closeBtn = document.querySelector('.btn-close-search');
      this.loadingEl = document.querySelector('.search-loading');
      this.noResultsEl = document.querySelector('.search-no-results');
      this.productList = document.querySelector('.product-list-mini');
      this.categoryList = document.querySelector('.category-list');
      this.suggestionList = document.querySelector('.suggestion-list');
      
      this.searchDelay = 300;
      this.minChars = 2;
      this.searchTimeout = null;
  
      this.init();
    }
  
    init() {
      // Initialize search trigger buttons
      document.querySelectorAll('[data-action="show-search"]').forEach(btn => {
        btn.addEventListener('click', () => this.showOverlay());
      });
  
      // Close button event
      this.closeBtn?.addEventListener('click', () => this.hideOverlay());
  
      // Close on escape key
      document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape' && this.overlay.classList.contains('active')) {
          this.hideOverlay();
        }
      });
  
      // Input handler
      this.input?.addEventListener('input', (e) => {
        clearTimeout(this.searchTimeout);
        const query = e.target.value.trim();
  
        if (query.length >= this.minChars) {
          this.searchTimeout = setTimeout(() => {
            this.performSearch(query);
          }, this.searchDelay);
        } else {
          this.hideResults();
        }
      });
  
      // Form submit handler
      this.form?.addEventListener('submit', (e) => {
        const query = this.input.value.trim();
        if (query.length < this.minChars) {
          e.preventDefault();
        }
      });
    }
  
    showOverlay() {
      this.overlay.classList.add('active');
      this.input?.focus();
      document.body.style.overflow = 'hidden';
    }
  
    hideOverlay() {
      this.overlay.classList.remove('active');
      document.body.style.overflow = '';
      this.input.value = '';
      this.hideResults();
    }
  
    showLoading() {
      this.loadingEl.style.display = 'block';
      this.noResultsEl.style.display = 'none';
      this.results.style.display = 'block';
    }
  
    hideLoading() {
      this.loadingEl.style.display = 'none';
    }
  
    async performSearch(query) {
      this.showLoading();
  
      try {
        const response = await fetch(`${prestashop.urls.base_url}module/ps_searchbar/ajax`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            s: query,
            resultsPerPage: 8,
            page: 1
          })
        });
  
        const data = await response.json();
        this.hideLoading();
        
        if (data.products?.length > 0 || data.categories?.length > 0) {
          this.displayResults(data);
        } else {
          this.showNoResults();
        }
      } catch (error) {
        console.error('Search error:', error);
        this.hideLoading();
        this.showNoResults();
      }
    }
  
    displayResults(data) {
      this.results.style.display = 'block';
      this.noResultsEl.style.display = 'none';
  
      // Display products
      this.productList.innerHTML = '';
      const productTemplate = document.getElementById('search-product-template');
      
      data.products?.forEach(product => {
        const clone = document.importNode(productTemplate.content, true);
        const link = clone.querySelector('.product-link');
        const image = clone.querySelector('img');
        const title = clone.querySelector('.product-title');
        const price = clone.querySelector('.product-price');
  
        link.href = product.url;
        image.src = product.cover_image_url;
        image.alt = product.name;
        title.textContent = product.name;
        price.textContent = product.price;
  
        this.productList.appendChild(clone);
      });
  
      // Display categories
      this.categoryList.innerHTML = '';
      const categoryTemplate = document.getElementById('search-category-template');
  
      data.categories?.forEach(category => {
        const clone = document.importNode(categoryTemplate.content, true);
        const link = clone.querySelector('.category-link');
        const name = clone.querySelector('.category-name');
        const count = clone.querySelector('.product-count');
  
        link.href = category.url;
        name.textContent = category.name;
        count.textContent = `(${category.product_count})`;
  
        this.categoryList.appendChild(clone);
      });
    }
  
    showNoResults() {
      this.results.style.display = 'block';
      this.noResultsEl.style.display = 'block';
      this.productList.innerHTML = '';
      this.categoryList.innerHTML = '';
    }
  
    hideResults() {
      this.results.style.display = 'none';
      this.noResultsEl.style.display = 'none';
      this.loadingEl.style.display = 'none';
    }
  }
  
  // Initialize live search when DOM is ready
  document.addEventListener('DOMContentLoaded', () => {
    new LiveSearch();
  });
  
  // Theme configuration and initialization
  window.themeConfig = window.themeConfig || {};
  
  // Initialize components when DOM is ready
  document.addEventListener('DOMContentLoaded', () => {
    // Smooth scroll for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
      anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
          target.scrollIntoView({
            behavior: 'smooth',
            block: 'start'
          });
        }
      });
    });
  
    // Initialize tooltips
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function (tooltipTriggerEl) {
      return new bootstrap.Tooltip(tooltipTriggerEl);
    });
  
    // Initialize popovers
    const popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
    popoverTriggerList.map(function (popoverTriggerEl) {
      return new bootstrap.Popover(popoverTriggerEl);
    });
  
    // Mobile menu toggle
    const mobileMenuToggle = document.querySelector('.mobile-menu-toggle');
    const mobileMenu = document.querySelector('.mobile-menu');
    
    if (mobileMenuToggle && mobileMenu) {
      mobileMenuToggle.addEventListener('click', () => {
        mobileMenu.classList.toggle('active');
        document.body.classList.toggle('mobile-menu-active');
      });
    }
  
    // Add to cart animation
    prestashop.on('updateCart', () => {
      const cartButton = document.querySelector('.cart-preview');
      if (cartButton) {
        cartButton.classList.add('shake');
        setTimeout(() => {
          cartButton.classList.remove('shake');
        }, 500);
      }
    });
  });
});