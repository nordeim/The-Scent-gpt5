/**
 * Theme specific JS functionality
 */
document.addEventListener('DOMContentLoaded', () => {
  // Initialize Product Grid
  const initProductGrid = () => {
    const productCards = document.querySelectorAll('.product-card');
    productCards.forEach(card => {
      // Add hover animation class
      card.addEventListener('mouseenter', () => {
        card.classList.add('hover');
      });
      card.addEventListener('mouseleave', () => {
        card.classList.remove('hover');
      });
    });
  };

  // Initialize Newsletter Form
  const initNewsletterForm = () => {
    const form = document.querySelector('.newsletter-form');
    if (form) {
      form.addEventListener('submit', (e) => {
        const email = form.querySelector('input[type="email"]');
        if (!email.value.trim()) {
          e.preventDefault();
          email.classList.add('error');
        }
      });
    }
  };

  // Initialize
  initProductGrid();
  initNewsletterForm();
});
