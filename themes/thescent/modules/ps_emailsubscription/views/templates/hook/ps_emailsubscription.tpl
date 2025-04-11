<div id="newsletter" class="block_newsletter">
  <div class="container newsletter-container">
    <h2>{l s='Stay Connected' d='Shop.Theme.Global'}</h2>
    <p>{l s='Subscribe for exclusive offers and aromatherapy insights' d='Shop.Theme.Global'}</p>
    
    <form action="{$urls.pages.index}#footer" method="post">
      <div class="newsletter-form">
        <input
          name="email"
          type="email"
          value="{$value}"
          placeholder="{l s='Your email address' d='Shop.Forms.Labels'}"
          aria-label="{l s='Email subscription input' d='Shop.Forms.Labels'}"
          required
        >
        <button class="btn btn-primary" name="submitNewsletter" type="submit" value="1">
          {l s='Subscribe' d='Shop.Theme.Actions'}
        </button>
      </div>
      {if $conditions}
        <p class="newsletter-consent">{$conditions}</p>
      {/if}
      {if $msg}
        <p class="alert {if $nw_error}alert-danger{else}alert-success{/if}">
          {$msg}
        </p>
      {/if}
      <input type="hidden" name="action" value="0" aria-label="Hidden input">
    </form>
  </div>
</div>
