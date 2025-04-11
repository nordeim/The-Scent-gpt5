{extends file='page.tpl'}

{block name='page_content_container'}
  <section id="content" class="page-content page-order-confirmation">
    <div class="order-confirmation-content">
      <div class="confirmation-header">
        <i class="fas fa-check-circle"></i>
        <h1>{l s='Thank You for Your Order!' d='Shop.Theme.Checkout'}</h1>
        <p>{l s='Your order has been successfully placed.' d='Shop.Theme.Checkout'}</p>
      </div>

      <div class="order-details-cards">
        <div class="details-card">
          <h4>{l s='Order Reference' d='Shop.Theme.Checkout'}</h4>
          <p>{$order.details.reference}</p>
        </div>

        <div class="details-card">
          <h4>{l s='Payment Method' d='Shop.Theme.Checkout'}</h4>
          <p>{$order.details.payment}</p>
        </div>

        <div class="details-card">
          <h4>{l s='Shipping Method' d='Shop.Theme.Checkout'}</h4>
          <p>{$order.carrier.name}</p>
        </div>
      </div>

      {if $HOOK_PAYMENT_RETURN}
        <div class="payment-return">
          {$HOOK_PAYMENT_RETURN nofilter}
        </div>
      {/if}

      {if $customer.is_guest}
        <div class="guest-to-customer">
          <p>{l s='Save time on your next order, sign up now' d='Shop.Theme.Checkout'}</p>
          <a href="{$urls.pages.register}" class="btn btn-secondary">
            {l s='Create an account' d='Shop.Theme.Actions'}
          </a>
        </div>
      {/if}

      <div class="order-actions">
        {if $is_guest}
          <a href="{$urls.pages.guest_tracking}" class="btn btn-primary">
            {l s='Track Order' d='Shop.Theme.Actions'}
          </a>
        {else}
          <a href="{$urls.pages.history}" class="btn btn-primary">
            {l s='View Order History' d='Shop.Theme.Actions'}
          </a>
        {/if}
        
        <a href="{$urls.pages.index}" class="btn btn-secondary">
          {l s='Continue Shopping' d='Shop.Theme.Actions'}
        </a>
      </div>
    </div>
  </section>
{/block}