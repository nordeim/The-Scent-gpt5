{extends file='customer/page.tpl'}

{block name='page_title'}
  {l s='Order History' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <div class="order-history">
    {if $orders}
      <div class="order-list">
        {foreach from=$orders item=order}
          <div class="order-card">
            <div class="order-header">
              <div class="order-ref">
                <h3>{l s='Order' d='Shop.Theme.Customeraccount'} {$order.details.reference}</h3>
                <span class="order-date">{$order.details.order_date}</span>
              </div>
              <div class="order-status">
                <span class="status-badge status-{$order.history.current.id_order_state|lower}">
                  {$order.history.current.ostate_name}
                </span>
              </div>
            </div>
            
            <div class="order-details">
              <div class="order-info">
                <p class="info-row">
                  <span>{l s='Total' d='Shop.Theme.Checkout'}</span>
                  <strong>{$order.totals.total.value}</strong>
                </p>
                <p class="info-row">
                  <span>{l s='Payment' d='Shop.Theme.Checkout'}</span>
                  <span>{$order.details.payment}</span>
                </p>
              </div>
              
              <div class="order-actions">
                <a href="{$order.details.details_url}" class="btn btn-secondary">
                  {l s='View Details' d='Shop.Theme.Actions'}
                </a>
                {if $order.details.reorder_url}
                  <a href="{$order.details.reorder_url}" class="btn btn-primary">
                    {l s='Reorder' d='Shop.Theme.Actions'}
                  </a>
                {/if}
              </div>
            </div>
          </div>
        {/foreach}
      </div>
    {else}
      <div class="empty-state">
        <i class="fas fa-shopping-bag"></i>
        <p>{l s='You haven\'t placed any orders yet.' d='Shop.Theme.Customeraccount'}</p>
        <a href="{$urls.pages.index}" class="btn btn-primary">
          {l s='Start Shopping' d='Shop.Theme.Actions'}
        </a>
      </div>
    {/if}
  </div>
{/block}