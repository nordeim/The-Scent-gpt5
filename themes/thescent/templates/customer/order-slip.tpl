{extends file='customer/page.tpl'}

{block name='page_title'}
  {l s='Credit Slips' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <div class="credit-slips">
    <h6 class="credit-slips-subtitle">
      {l s='Credit slips you have received after canceled orders.' d='Shop.Theme.Customeraccount'}
    </h6>

    {if $credit_slips}
      <div class="table-wrapper">
        <table class="table table-striped table-bordered credit-slips-table">
          <thead class="thead-default">
            <tr>
              <th>{l s='Order' d='Shop.Theme.Customeraccount'}</th>
              <th>{l s='Credit slip' d='Shop.Theme.Customeraccount'}</th>
              <th>{l s='Date issued' d='Shop.Theme.Customeraccount'}</th>
              <th>{l s='View credit slip' d='Shop.Theme.Customeraccount'}</th>
            </tr>
          </thead>
          <tbody>
            {foreach from=$credit_slips item=slip}
              <tr>
                <td>
                  <a href="{$slip.order_url_details}" data-link-action="view-order-details">
                    {$slip.order_reference}
                  </a>
                </td>
                <td scope="row">{$slip.credit_slip_number}</td>
                <td>{$slip.credit_slip_date}</td>
                <td>
                  <a href="{$slip.url}"
                     class="btn btn-secondary btn-sm"
                     target="_blank"
                     rel="noopener noreferrer">
                    <i class="fas fa-file-pdf"></i>
                    {l s='PDF' d='Shop.Theme.Actions'}
                  </a>
                </td>
              </tr>
            {/foreach}
          </tbody>
        </table>
      </div>
    {else}
      <div class="alert alert-info" role="alert">
        <i class="fas fa-info-circle"></i>
        <p class="alert-text">
          {l s='You have not received any credit slips.' d='Shop.Notifications.Warning'}
        </p>
      </div>
    {/if}
  </div>
{/block}