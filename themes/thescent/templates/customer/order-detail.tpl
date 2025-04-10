{extends file='customer/page.tpl'}

{block name='page_title'}
  {l s='Order details' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <div class="order-detail">
    {block name='order_infos'}
      <div class="order-info-card">
        <div class="order-header">
          <div class="order-reference">
            <span class="label">{l s='Order Reference:' d='Shop.Theme.Customeraccount'}</span>
            <span class="value">{$order.details.reference}</span>
          </div>
          <div class="order-status">
            <span class="label">{l s='Status:' d='Shop.Theme.Customeraccount'}</span>
            <span class="status-badge status-{$order.history.current.id_order_state|lower}">
              {$order.history.current.ostate_name}
            </span>
          </div>
          <div class="order-date">
            <span class="label">{l s='Date:' d='Shop.Theme.Customeraccount'}</span>
            <span class="value">{$order.details.order_date}</span>
          </div>
        </div>

        {if $order.follow_up}
          <div class="order-tracking">
            <a href="{$order.follow_up}" class="btn btn-secondary btn-sm">
              <i class="fas fa-truck"></i> {l s='Track Package' d='Shop.Theme.Actions'}
            </a>
          </div>
        {/if}
      </div>
    {/block}

    {block name='order_history'}
      <div class="order-history-card">
        <h3>{l s='Order History' d='Shop.Theme.Customeraccount'}</h3>
        <div class="timeline">
          {foreach from=$order.history.history item=state}
            <div class="timeline-item {if $state.contrast}contrast{/if}">
              <div class="timeline-date">{$state.date_add}</div>
              <div class="timeline-content">
                <span class="status-badge status-{$state.id_order_state|lower}">
                  {$state.ostate_name}
                </span>
                {if $state.message}
                  <div class="timeline-message">{$state.message}</div>
                {/if}
              </div>
            </div>
          {/foreach}
        </div>
      </div>
    {/block}

    {block name='order_products'}
      <div class="order-products-card">
        <h3>{l s='Products' d='Shop.Theme.Customeraccount'}</h3>
        <div class="table-wrapper">
          <table class="table">
            <thead>
              <tr>
                <th>{l s='Product' d='Shop.Theme.Catalog'}</th>
                <th>{l s='Quantity' d='Shop.Theme.Checkout'}</th>
                <th>{l s='Unit price' d='Shop.Theme.Catalog'}</th>
                <th>{l s='Total price' d='Shop.Theme.Catalog'}</th>
              </tr>
            </thead>
            <tbody>
              {foreach from=$order.products item=product}
                <tr>
                  <td class="product-cell">
                    <div class="product-info">
                      {if $product.cover}
                        <div class="product-image">
                          <img src="{$product.cover.small.url}" alt="{$product.name}"/>
                        </div>
                      {/if}
                      <div class="product-details">
                        <span class="product-name">{$product.name}</span>
                        {if $product.reference}
                          <div class="product-reference">
                            {l s='Reference' d='Shop.Theme.Catalog'}: {$product.reference}
                          </div>
                        {/if}
                        {if $product.customizations}
                          {foreach from=$product.customizations item="customization"}
                            <div class="customization">
                              {foreach from=$customization.fields item="field"}
                                <div class="customization-field">
                                  <span class="label">{$field.label}:</span>
                                  {if $field.type == 'text'}
                                    <span class="value">{$field.text}</span>
                                  {elseif $field.type == 'image'}
                                    <img src="{$field.image.small.url}" alt="{$field.label}">
                                  {/if}
                                </div>
                              {/foreach}
                            </div>
                          {/foreach}
                        {/if}
                      </div>
                    </div>
                  </td>
                  <td class="qty-cell">{$product.quantity}</td>
                  <td class="price-cell">{$product.price}</td>
                  <td class="total-cell">{$product.total}</td>
                </tr>
              {/foreach}
            </tbody>
            <tfoot>
              {foreach $order.subtotals as $line}
                {if $line.value}
                  <tr class="subtotal-line">
                    <td colspan="3">{$line.label}</td>
                    <td>{$line.value}</td>
                  </tr>
                {/if}
              {/foreach}
              <tr class="total-line">
                <td colspan="3">{$order.totals.total.label}</td>
                <td>{$order.totals.total.value}</td>
              </tr>
            </tfoot>
          </table>
        </div>
      </div>
    {/block}

    <div class="order-details-grid">
      {block name='order_addresses'}
        <div class="addresses-card">
          <div class="delivery-address">
            <h4>{l s='Delivery Address' d='Shop.Theme.Customeraccount'}</h4>
            {$order.addresses.delivery format=html}
          </div>
          <div class="invoice-address">
            <h4>{l s='Invoice Address' d='Shop.Theme.Customeraccount'}</h4>
            {$order.addresses.invoice format=html}
          </div>
        </div>
      {/block}

      {block name='order_payment'}
        <div class="payment-card">
          <h4>{l s='Payment Method' d='Shop.Theme.Checkout'}</h4>
          <p>{$order.details.payment}</p>
          {if $order.details.invoice_url}
            <a href="{$order.details.invoice_url}" class="btn btn-secondary btn-sm">
              <i class="fas fa-file-pdf"></i> {l s='Download Invoice' d='Shop.Theme.Customeraccount'}
            </a>
          {/if}
        </div>
      {/block}
    </div>

    {block name='order_actions'}
      <div class="order-actions">
        <a href="{$urls.pages.history}" class="btn btn-secondary">
          <i class="fas fa-arrow-left"></i> {l s='Back to orders' d='Shop.Theme.Actions'}
        </a>
        {if $order.details.reorder_url}
          <a href="{$order.details.reorder_url}" class="btn btn-primary">
            <i class="fas fa-sync"></i> {l s='Reorder' d='Shop.Theme.Actions'}
          </a>
        {/if}
      </div>
    {/block}
  </div>
{/block}