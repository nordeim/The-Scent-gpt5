<div class="newsletter-section">
  <div class="container newsletter-container">
    <div class="newsletter-content">
      <h2>{l s='Stay in the Loop' d='Shop.Theme.Global'}</h2>
      <p>{l s='Subscribe to our newsletter for exclusive offers, aromatherapy tips, and new product announcements.' d='Shop.Theme.Global'}</p>

      <form action="{$urls.pages.index}#footer" method="post">
        <div class="newsletter-form">
          <input
            name="email"
            type="email"
            value="{$value}"
            placeholder="{l s='Your email address' d='Shop.Forms.Labels'}"
            aria-label="{l s='Your email address' d='Shop.Forms.Labels'}"
            required
          >
          <button
            class="btn btn-primary"
            name="submitNewsletter"
            type="submit"
            value="1"
            aria-label="{l s='Subscribe' d='Shop.Theme.Actions'}"
          >
            <span>{l s='Subscribe' d='Shop.Theme.Actions'}</span>
          </button>
        </div>

        <div class="newsletter-consent">
          <p>
            {l s='By subscribing, you agree to our Privacy Policy and consent to receive our marketing emails. You can unsubscribe at any time.' d='Shop.Theme.Global'}
            <a href="{$urls.pages.privacy}" target="_blank">{l s='Learn more' d='Shop.Theme.Global'}</a>
          </p>
        </div>

        {if $conditions}
          <div class="newsletter-conditions">
            <p>{$conditions}</p>
          </div>
        {/if}

        {if $msg}
          <div class="alert {if $nw_error}alert-danger{else}alert-success{/if}">
            {$msg}
          </div>
        {/if}

        {hook h='displayNewsletterRegistration'}
        <input type="hidden" name="blockHookName" value="{$hookName}" />
        <input type="hidden" name="action" value="0">
      </form>
    </div>
  </div>
</div>
