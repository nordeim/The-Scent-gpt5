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
});