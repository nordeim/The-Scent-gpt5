document.addEventListener('DOMContentLoaded', function() {
  // Enhanced Sticky Header
  const header = document.querySelector('.main-header');
  let lastScroll = 0;
  const scrollThreshold = 100; // Increased threshold for better UX

  function handleScroll() {
    const currentScroll = window.pageYOffset;
    
    if (currentScroll <= scrollThreshold) {
      header.classList.remove('sticky');
      return;
    }

    if (currentScroll > lastScroll && !header.classList.contains('sticky')) {
      header.classList.add('sticky');
      header.classList.remove('header-absolute');
    }

    lastScroll = currentScroll;
  }

  // Optimize scroll handling
  let ticking = false;
  window.addEventListener('scroll', () => {
    if (!ticking) {
      window.requestAnimationFrame(() => {
        handleScroll();
        ticking = false;
      });
      ticking = true;
    }
  });

  // Newsletter Form Validation
  const newsletterForm = document.querySelector('.newsletter-form');
  if (newsletterForm) {
    newsletterForm.addEventListener('submit', function(e) {
      const emailInput = this.querySelector('input[type="email"]');
      if (!emailInput.value.match(/^[^\s@]+@[^\s@]+\.[^\s@]+$/)) {
        e.preventDefault();
        alert('Please enter a valid email address');
      }
    });
  }

  // Main Menu Dropdown Handling
  const menuItems = document.querySelectorAll('.main-menu > li');
  menuItems.forEach(item => {
    const submenu = item.querySelector('.submenu');
    if (submenu) {
      item.addEventListener('mouseenter', () => {
        submenu.style.opacity = '1';
        submenu.style.visibility = 'visible';
        submenu.style.transform = 'translateY(0)';
      });
      
      item.addEventListener('mouseleave', () => {
        submenu.style.opacity = '0';
        submenu.style.visibility = 'hidden';
        submenu.style.transform = 'translateY(10px)';
      });
    }
  });

  // Lazy loading implementation
  if ('IntersectionObserver' in window) {
    const imageObserver = new IntersectionObserver((entries, observer) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          const img = entry.target;
          img.src = img.dataset.src;
          img.classList.remove('lazy');
          observer.unobserve(img);
        }
      });
    });

    document.querySelectorAll('img.lazy').forEach(img => {
      imageObserver.observe(img);
    });
  }
});

// Newsletter Form Enhancement
document.addEventListener('submit', function(e) {
  if (e.target.classList.contains('newsletter-form')) {
    e.preventDefault();
    const form = e.target;
    const email = form.querySelector('input[name="email"]').value;
    
    // Add loading state
    form.classList.add('loading');
    
    // Simulate AJAX submission (replace with actual AJAX call)
    setTimeout(() => {
      form.classList.remove('loading');
      // Show success message (implement actual logic)
      const alert = document.createElement('p');
      alert.className = 'alert alert-success';
      alert.textContent = 'Thank you for subscribing!';
      form.insertAdjacentElement('afterend', alert);
    }, 1000);
  }
});
