{extends file='page.tpl'}

{block name='content'}
  <section id="main">
    <div class="container checkout-container">
      <header class="checkout-header">
        <h1>{l s='Secure Checkout' d='Shop.Theme.Checkout'}</h1>
        {block name='checkout_process_steps'}
          {include file='checkout/_partials/steps/checkout-steps.tpl' steps=$checkout_process.steps}
        {/block}
      </header>

      <div class="checkout-columns">
        <div class="checkout-main">
          {block name='checkout_process'}
            {render file='checkout/checkout-process.tpl' ui=$checkout_process}
          {/block}
        </div>

        <div class="checkout-sidebar">
          {block name='cart_summary'}
            {include file='checkout/_partials/cart-summary.tpl' cart=$cart}
          {/block}

          <div class="secure-checkout-info">
            <div class="secure-icon">
              <i class="fas fa-shield-alt"></i>
            </div>
            <div class="secure-text">
              <h3>{l s='Secure Payment' d='Shop.Theme.Checkout'}</h3>
              <p>{l s='Your payment information is processed securely.' d='Shop.Theme.Checkout'}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
{/block}