{extends file='customer/page.tpl'}

{block name='page_title'}
  {if $id_address}
    {l s='Update your address' d='Shop.Theme.Customeraccount'}
  {else}
    {l s='New address' d='Shop.Theme.Customeraccount'}
  {/if}
{/block}

{block name='page_content'}
  <div class="address-form-container">
    {render file='customer/_partials/address-form.tpl' ui=$address_form}

    <div class="address-form-footer">
      <a href="{$urls.pages.addresses}" class="btn btn-secondary">
        <i class="fas fa-arrow-left"></i>
        {l s='Back to addresses' d='Shop.Theme.Actions'}
      </a>
    </div>
  </div>
{/block}