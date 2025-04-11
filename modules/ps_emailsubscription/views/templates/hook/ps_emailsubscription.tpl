<div class="newsletter-block">
  <div class="container newsletter-container">
    <h2>{l s='Stay Connected' d='Shop.Theme.Global'}</h2>
    <p>{l s='Subscribe for exclusive offers and aromatherapy insights' d='Shop.Theme.Global'}</p>
    
    <form action="{$urls.pages.index}#footer" method="post" class="newsletter-form">
      <div class="input-wrapper">
        <input
          name="email"
          type="email"
          value="{$value}"
          placeholder="{l s='Your email address' d='Shop.Forms.Labels'}"
          aria-labelledby="block-newsletter-label"
          required
        >
      </div>
      <button class="btn btn-primary" name="submitNewsletter" type="submit" value="1">
        {l s='Subscribe' d='Shop.Theme.Actions'}
      </button>
      <input type="hidden" name="action" value="0">
    </form>
    
    {if $msg}
      <p class="alert {if $nw_error}alert-danger{else}alert-success{/if}">
        {$msg}
      </p>
    {/if}
    
    {if $conditions}
      <p class="newsletter-consent">{$conditions}</p>
    {/if}
  </div>
</div>
