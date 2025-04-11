<div class="footer-container">
  {block name='hook_footer_before'}
    {hook h='displayFooterBefore'}
  {/block}

  <footer class="main-footer">
    <div class="container">
      <div class="footer-grid">
        {* About Section *}
        <div class="footer-about">
          <h3>{l s='About The Scent' d='Shop.Theme.Global'}</h3>
          <p>{l s='Experience the transformative power of aromatherapy with our premium, ethically sourced essential oils and natural products.' d='Shop.Theme.Global'}</p>
          <div class="social-icons">
            {hook h='displaySocialFollowLinks'}
          </div>
        </div>

        {* Quick Links *}
        <div class="footer-links">
          {hook h='displayFooter'}
        </div>

        {* Contact Info *}
        <div class="footer-contact">
          <h3>{l s='Get in Touch' d='Shop.Theme.Global'}</h3>
          {hook h='displayContactInfo'}
        </div>
      </div>

      {* Newsletter Section moved to footer *}
      {block name='hook_footer'}
        {hook h='displayFooter'}
      {/block}
    </div>

    {* Footer Bottom *}
    <div class="footer-bottom">
      <div class="container">
        <div class="copyright">
          {block name='copyright_link'}
            <a href="https://www.prestashop.com" target="_blank" rel="noopener noreferrer nofollow">
              {l s='%copyright% %year% - Ecommerce software by %prestashop%'
                sprintf=['%prestashop%' => 'PrestaShop™', '%year%' => 'Y'|date, '%copyright%' => '©']
                d='Shop.Theme.Global'}
            </a>
          {/block}
        </div>
        
        <div class="payment-methods">
          <span>{l s='Payment Methods:' d='Shop.Theme.Global'}</span>
          <i class="fab fa-cc-visa"></i>
          <i class="fab fa-cc-mastercard"></i>
          <i class="fab fa-cc-amex"></i>
          <i class="fab fa-cc-paypal"></i>
        </div>
      </div>
    </div>
  </footer>
</div>