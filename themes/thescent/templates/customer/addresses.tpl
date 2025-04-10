{extends file='customer/page.tpl'}

{block name='page_title'}
  {l s='Your addresses' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <div class="addresses-container">
    {if $customer.addresses}
      {* Add New Address Button *}
      <div class="address-actions">
        <a href="{$urls.pages.address}" class="btn btn-primary">
          <i class="fas fa-plus"></i>
          {l s='Add a new address' d='Shop.Theme.Actions'}
        </a>
      </div>

      {* Addresses Grid *}
      <div class="addresses-grid">
        {foreach $customer.addresses as $address}
          <article class="address-card" data-id-address="{$address.id}">
            <div class="address-header">
              <h4>{$address.alias}</h4>
              <div class="address-actions">
                <a href="{url entity=address id=$address.id}"
                   class="btn btn-secondary btn-sm"
                   title="{l s='Update' d='Shop.Theme.Actions'}"
                   data-link-action="edit-address">
                  <i class="fas fa-edit"></i>
                </a>
                <a href="{url entity=address id=$address.id params=['delete' => 1, 'token' => $token]}"
                   class="btn btn-secondary btn-sm"
                   data-link-action="delete-address"
                   title="{l s='Delete' d='Shop.Theme.Actions'}"
                   onclick="return confirm('{l s='Are you sure you want to delete this address?' d='Shop.Theme.Customeraccount'}');">
                  <i class="fas fa-trash"></i>
                </a>
              </div>
            </div>

            <div class="address-content">
              {$address.formatted nofilter}
            </div>
          </article>
        {/foreach}
      </div>
    {else}
      <div class="alert alert-info" role="alert">
        <i class="fas fa-info-circle"></i>
        <p>{l s='No addresses are available.' d='Shop.Notifications.Warning'}</p>
      </div>
      <div class="address-actions">
        <a href="{$urls.pages.address}" class="btn btn-primary">
          <i class="fas fa-plus"></i>
          {l s='Add your first address' d='Shop.Theme.Actions'}
        </a>
      </div>
    {/if}
  </div>
{/block}