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

});