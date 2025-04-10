document.addEventListener('DOMContentLoaded', function() {
  // Enhanced Sticky Header
  const header = document.querySelector('.main-header');
  let lastScroll = 0;
  let scrollThreshold = 50;

  function handleScroll() {
    const currentScroll = window.pageYOffset;
    
    // Show/hide header based on scroll direction
    if (currentScroll > lastScroll && currentScroll > scrollThreshold) {
      header.classList.add('hide');
      header.classList.remove('show');
    } else {
      header.classList.remove('hide');
      header.classList.add('show');
    }
    
    // Add/remove sticky class
    if (currentScroll > scrollThreshold) {
      header.classList.add('sticky');
    } else {
      header.classList.remove('sticky');
    }

    lastScroll = currentScroll;
  }

  window.addEventListener('scroll', handleScroll);

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
  const toggleButton = document.querySelector('.mobile-nav-toggle');
  const mobileNav = document.querySelector('.mobile-nav');
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
});