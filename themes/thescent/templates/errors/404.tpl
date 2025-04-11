{extends file='page.tpl'}

{block name='page_title'}
  {l s='Page not found' d='Shop.Theme.Global'}
{/block}

{block name='page_content_container'}
  <section class="page-not-found">
    <div class="container">
      <div class="error-content text-center">
        <h1>404</h1>
        <h2>{l s='Oops! Page Not Found' d='Shop.Theme.Global'}</h2>
        <p>{l s='We\'re sorry, but the page you\'re looking for cannot be found. It might have been moved or no longer exists.' d='Shop.Theme.Global'}</p>
        
        <div class="error-actions">
          <a href="{$urls.pages.index}" class="btn btn-primary">
            <i class="fas fa-home"></i>
            {l s='Return to Homepage' d='Shop.Theme.Global'}
          </a>
          
          <form action="{$urls.pages.search}" method="get" class="error-search">
            <div class="input-group">
              <input type="text" name="s" class="form-control" placeholder="{l s='Search our store' d='Shop.Theme.Global'}" aria-label="{l s='Search' d='Shop.Theme.Global'}">
              <button type="submit" class="btn btn-secondary">
                <i class="fas fa-search"></i>
              </button>
            </div>
          </form>
        </div>

        <div class="suggested-links">
          <h3>{l s='You might be interested in:' d='Shop.Theme.Global'}</h3>
          <ul>
            <li><a href="{$urls.pages.best_sales}">{l s='Best Sellers' d='Shop.Theme.Global'}</a></li>
            <li><a href="{$urls.pages.new_products}">{l s='New Arrivals' d='Shop.Theme.Global'}</a></li>
            <li><a href="{$urls.pages.contact}">{l s='Contact Us' d='Shop.Theme.Global'}</a></li>
          </ul>
        </div>
      </div>
    </div>
  </section>
{/block}