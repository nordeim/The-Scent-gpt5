{extends file='page.tpl'}

{block name='page_title'}
  {l s='Create an account' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <div class="register-form-container">
    {render file='customer/_partials/customer-form.tpl' ui=$register_form}
  </div>

  <hr class="separator">

  <div class="login-link">
    {l s='Already have an account?' d='Shop.Theme.Customeraccount'} 
    <a href="{$urls.pages.authentication}" class="btn btn-secondary">
      {l s='Log in instead' d='Shop.Theme.Actions'}
    </a>
  </div>
{/block}