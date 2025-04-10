{block name='footer'}
<footer id="footer" class="main-footer">
  <div class="container">
    <div class="footer-grid">
      <div class="footer-about">
        <h3>{l s='About The Scent' d='Shop.Theme.Global'}</h3>
        <p>{l s='Creating premium aromatherapy products to enhance mental and physical well-being through the power of nature.' d='Shop.Theme.Global'}</p>
        <div class="social-icons">
          <a href="#" aria-label="Facebook"><i class="fab fa-facebook-f"></i></a>
          <a href="#" aria-label="Instagram"><i class="fab fa-instagram"></i></a>
          <a href="#" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
          <a href="#" aria-label="Pinterest"><i class="fab fa-pinterest"></i></a>
        </div>
      </div>

      <div class="footer-links">
        {hook h='displayFooter'}
      </div>

      <div class="footer-contact">
        {hook h='displayContactInfo'}
      </div>
    </div>
  </div>

  <div class="footer-bottom">
    <div class="container">
      <p>&copy; {$smarty.now|date_format:'%Y'} {$shop.name}. {l s='All rights reserved.' d='Shop.Theme.Global'}</p>
      <div class="payment-methods">
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