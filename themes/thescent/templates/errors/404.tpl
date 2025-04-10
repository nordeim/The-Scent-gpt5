{extends file='page.tpl'}

{block name='page_title'}
  {l s='Page not found' d='Shop.Theme.Global'}
{/block}

{block name='page_content_container'}
  <section class="error-section error-404">
    <div class="container error-container">
      <div class="error-content">
        <div class="error-icon">
          <i class="fas fa-compass"></i>
        </div>
        
        <h1>404</h1>
        <h2>{l s='Page Not Found' d='Shop.Theme.Global'}</h2>
        
        <p class="error-message">
          {l s='We\'re sorry, but the page you\'re looking for could not be found.' d='Shop.Theme.Global'}
        </p>
        
        <div class="error-suggestions">
          <p>{l s='Here are a few suggestions:' d='Shop.Theme.Global'}</p>
          <ul>
            <li>{l s='Check the URL for spelling errors' d='Shop.Theme.Global'}</li>
            <li>{l s='Return to our homepage' d='Shop.Theme.Global'}</li>
            <li>{l s='Browse our product categories' d='Shop.Theme.Global'}</li>
            <li>{l s='Use the search bar above' d='Shop.Theme.Global'}</li>
          </ul>
        </div>

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