{extends file='page.tpl'}

{block name='page_title'}
  {l s='Log in to your account' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  {block name='login_form_container'}
    <div class="login-page">
      <div class="login-form-container">
        <section class="login-form">
          {render file='customer/_partials/login-form.tpl' ui=$login_form}
        </section>
        <hr class="separator">
        <div class="no-account">
          <a href="{$urls.pages.register}" class="btn btn-secondary">
            {l s='No account? Create one here' d='Shop.Theme.Customeraccount'}
          </a>
        </div>
      </div>
    </div>
  {/block}
{/block}