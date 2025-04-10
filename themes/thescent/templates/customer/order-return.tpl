{extends file='customer/page.tpl'}

{block name='page_title'}
  {l s='Return #%number%' d='Shop.Theme.Customeraccount' sprintf=['%number%' => $return.return_number]}
{/block}

{block name='page_content'}
  <div class="order-return">
    {block name='order_return_infos'}
      <div class="return-info-card">
        <div class="return-header">
          <div class="return-status">
            <span class="status-label">{l s='Return Status:' d='Shop.Theme.Customeraccount'}</span>
            <span class="status-badge status-{$return.state|lower}">{$return.state_name}</span>
          </div>
          <div class="return-date">
            <span class="date-label">{l s='Date issued:' d='Shop.Theme.Customeraccount'}</span>
            <span class="date-value">{$return.return_date}</span>
          </div>
        </div>

        <div class="return-details">
          <div class="order-ref">
            <span class="ref-label">{l s='Order:' d='Shop.Theme.Customeraccount'}</span>
            <a href="{$return.order_url}" class="ref-value">
              {$return.reference}
            </a>
          </div>
        </div>
      </div>
    {/block}

    {block name='order_return_products'}
      <div class="return-products-card">
        <h3>{l s='Returned Items' d='Shop.Theme.Customeraccount'}</h3>
        <div class="table-wrapper">
          <table class="table">
            <thead>
              <tr>
                <th>{l s='Product' d='Shop.Theme.Catalog'}</th>
                <th>{l s='Quantity' d='Shop.Theme.Checkout'}</th>
                <th>{l s='Reason' d='Shop.Theme.Customeraccount'}</th>
              </tr>
            </thead>
            <tbody>
              {foreach from=$products item=product}
                <tr>
                  <td class="product-cell">
                    <span class="product-name">{$product.product_name}</span>
                    {if $product.customizations}
                      {foreach from=$product.customizations item=customization}
                        <div class="customization">
                          {foreach from=$customization.fields item=field}
                            <div class="customization-field">
                              <span class="field-label">{$field.label}:</span>
                              {if $field.type == 'text'}
                                <span class="field-value">{$field.text}</span>
                              {elseif $field.type == 'image'}
                                <img src="{$field.image.small.url}" alt="{$field.label}">
                              {/if}
                            </div>
                          {/foreach}
                        </div>
                      {/foreach}
                    {/if}
                  </td>
                  <td class="quantity-cell">{$product.quantity}</td>
                  <td class="reason-cell">{$product.return_reason}</td>
                </tr>
              {/foreach}
            </tbody>
          </table>
        </div>
      </div>
    {/block}

    {if $return.state == 'Waiting for package'}
      <div class="return-instructions-card">
        <h3>{l s='Return Instructions' d='Shop.Theme.Customeraccount'}</h3>
        <div class="instructions-content">
          <p>{l s='Please send your package to:' d='Shop.Theme.Customeraccount'}</p>
          <div class="address-block">
            {$return.return_address nofilter}
          </div>
          <div class="instructions-note">
            <i class="fas fa-info-circle"></i>
            <p>{l s='Remember to include your return number on the package: %return_number%' sprintf=['%return_number%' => $return.return_number] d='Shop.Theme.Customeraccount'}</p>
          </div>
        </div>
      </div>
    {/if}

    <div class="return-actions">
      <a href="{$urls.pages.history}" class="btn btn-secondary">
        <i class="fas fa-arrow-left"></i>
        {l s='Back to order history' d='Shop.Theme.Actions'}
      </a>
      {if $return.state == 'Waiting for package'}
        <a href="#" onclick="window.print();" class="btn btn-primary">
          <i class="fas fa-print"></i>
          {l s='Print Return Label' d='Shop.Theme.Actions'}
        </a>
      {/if}
    </div>
  </div>
{/block}