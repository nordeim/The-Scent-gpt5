{extends file='customer/page.tpl'}

{block name='page_title'}
  {l s='Your personal information' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <div class="identity-form-container">
    {block name='customer_identity'}
      <div class="identity-form-wrapper">
        {render file='customer/_partials/customer-form.tpl' ui=$customer_form}
      </div>

      <div class="identity-form-footer">
        <a href="{$urls.pages.my_account}" class="btn btn-secondary">
          <i class="fas fa-arrow-left"></i>
          {l s='Back to your account' d='Shop.Theme.Actions'}
        </a>
      </div>
    {/block}
  </div>
{/block}