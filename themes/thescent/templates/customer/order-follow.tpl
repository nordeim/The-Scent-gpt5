{extends file='customer/page.tpl'}

{block name='page_title'}
  {l s='Return Merchandise Authorization (RMA)' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  {if $ordersReturn && count($ordersReturn)}
    <div class="order-returns-list">
      <div class="table-wrapper">
        <table class="table">
          <thead>
            <tr>
              <th>{l s='Order' d='Shop.Theme.Customeraccount'}</th>
              <th>{l s='Return ID' d='Shop.Theme.Customeraccount'}</th>
              <th>{l s='Date issued' d='Shop.Theme.Customeraccount'}</th>
              <th>{l s='Package status' d='Shop.Theme.Customeraccount'}</th>
              <th class="text-center">{l s='Actions' d='Shop.Theme.Customeraccount'}</th>
            </tr>
          </thead>
          <tbody>
            {foreach from=$ordersReturn item=return}
              <tr>
                <td>
                  <a href="{$return.details_url}">
                    {$return.reference}
                  </a>
                </td>
                <td class="text-muted">
                  #{$return.id_order_return}
                </td>
                <td>
                  {$return.return_date}
                </td>
                <td>
                  <span class="status-badge status-{$return.state|lower}">
                    {$return.state_name}
                  </span>
                </td>
                <td class="text-center">
                  <a href="{$return.return_url}" class="btn btn-secondary btn-sm">
                    <i class="fas fa-eye"></i>
                    {l s='View details' d='Shop.Theme.Actions'}
                  </a>
                  {if $return.print_url}
                    <a href="{$return.print_url}" class="btn btn-outline-secondary btn-sm" target="_blank" rel="noopener">
                      <i class="fas fa-print"></i>
                      {l s='Print' d='Shop.Theme.Actions'}
                    </a>
                  {/if}
                </td>
              </tr>
            {/foreach}
          </tbody>
        </table>
      </div>
    </div>
  {else}
    <div class="alert alert-info" role="alert">
      <i class="fas fa-info-circle"></i>
      <p class="alert-text">
        {l s='You have no merchandise return authorizations.' d='Shop.Notifications.Warning'}
      </p>
    </div>
  {/if}
{/block}