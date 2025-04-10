{extends file='page.tpl'}

{block name='page_title'}
  {l s='Forbidden Access' d='Shop.Theme.Global'}
{/block}

{block name='page_content_container'}
  <section class="error-section forbidden">
    <div class="container error-container">
      <div class="error-content">
        <div class="error-icon">
          <i class="fas fa-lock"></i>
        </div>
        <h1>403</h1>
        <h2>{l s='Access Forbidden' d='Shop.Theme.Global'}</h2>
        <p>{l s='Sorry, you don\'t have permission to access this page.' d='Shop.Theme.Global'}</p>
        <div class="error-actions">
          <a href="{$urls.base_url}" class="btn btn-primary">
            <i class="fas fa-home"></i> {l s='Return to Homepage' d='Shop.Theme.Global'}
          </a>
          <a href="{$urls.pages.contact}" class="btn btn-secondary">
            <i class="fas fa-envelope"></i> {l s='Contact Support' d='Shop.Theme.Global'}
          </a>
        </div>
      </div>
    </div>
  </section>
{/block}