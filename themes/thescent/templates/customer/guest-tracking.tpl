{extends file='customer/guest-login.tpl'}

{block name='page_title'}
  {l s='Guest Order Tracking' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <div class="guest-tracking-container">
    {if isset($order_info)}
      <div class="order-info-card">
        <div class="order-header">
          <h2>{l s='Order Reference %reference%' sprintf=['%reference%' => $order_info.reference] d='Shop.Theme.Customeraccount'}</h2>
          <div class="order-status">
            <span class="status-label">{l s='Current Status:' d='Shop.Theme.Customeraccount'}</span>
            <span class="status-badge status-{$order_info.order_state|lower}">
              {$order_info.order_state}
            </span>
          </div>
        </div>

        <div class="order-details">
          <div class="detail-row">
            <span class="label">{l s='Order Date:' d='Shop.Theme.Customeraccount'}</span>
            <span class="value">{$order_info.date_add}</span>
          </div>
          <div class="detail-row">
            <span class="label">{l s='Total Amount:' d='Shop.Theme.Customeraccount'}</span>
            <span class="value">{$order_info.total_paid}</span>
          </div>
        </div>

        {if $order_info.carrier.tracking_number}
          <div class="tracking-info">
            <h3>{l s='Shipping Information' d='Shop.Theme.Checkout'}</h3>
            <p>
              {l s='Carrier:' d='Shop.Theme.Checkout'} {$order_info.carrier.name}
            </p>
            <p>
              {l s='Tracking number:' d='Shop.Theme.Checkout'}
              {if $order_info.carrier.url}
                <a href="{$order_info.carrier.url|replace:'@':$order_info.carrier.tracking_number}" target="_blank" rel="noopener">
                  {$order_info.carrier.tracking_number}
                </a>
              {else}
                {$order_info.carrier.tracking_number}
              {/if}
            </p>
          </div>
        {/if}

        {if $order_info.details}
          <div class="order-items">
            <h3>{l s='Order Items' d='Shop.Theme.Customeraccount'}</h3>
            <div class="table-wrapper">
              <table class="table">
                <thead>
                  <tr>
                    <th>{l s='Product' d='Shop.Theme.Catalog'}</th>
                    <th>{l s='Quantity' d='Shop.Theme.Checkout'}</th>
                    <th>{l s='Price' d='Shop.Theme.Catalog'}</th>
                    <th>{l s='Total' d='Shop.Theme.Checkout'}</th>
                  </tr>
                </thead>
                <tbody>
                  {foreach from=$order_info.details item=product}
                    <tr>
                      <td class="product-cell">
                        <span class="product-name">{$product.name}</span>
                        {if $product.reference}
                          <span class="product-reference">
                            {l s='Reference:' d='Shop.Theme.Catalog'} {$product.reference}
                          </span>
                        {/if}
                      </td>
                      <td>{$product.quantity}</td>
                      <td>{$product.price}</td>
                      <td>{$product.total}</td>
                    </tr>
                  {/foreach}
                </tbody>
              </table>
            </div>
          </div>
        {/if}
      </div>

      {if !$customer.is_logged}
        <div class="guest-to-customer">
          <h3>{l s='Create an account for easier order tracking' d='Shop.Theme.Customeraccount'}</h3>
          <p>{l s='Set up an account to track your orders easily and get personalized recommendations.' d='Shop.Theme.Customeraccount'}</p>
          <form action="{$urls.pages.guest_tracking}" method="post">
            <div class="form-group">
              <label class="form-label" for="guest_email">
                {l s='Set your password' d='Shop.Forms.Labels'}
              </label>
              <div class="password-wrapper">
                <input
                  class="form-control"
                  type="password"
                  data-validate="isPasswd"
                  name="password"
                  id="guest_email"
                  required
                >
              </div>
            </div>
            <input type="hidden" name="submitTransformGuestToCustomer" value="1">
            <input type="hidden" name="id_order" value="{$order_info.id}">
            <button class="btn btn-primary" type="submit">
              {l s='Create account' d='Shop.Theme.Actions'}
            </button>
          </form>
        </div>
      {/if}

    {else}
      <div class="guest-form-container">
        <form action="{$urls.pages.guest_tracking}" method="post">
          <section class="form-fields">
            <div class="form-group">
              <label class="form-label required" for="email">
                {l s='Email' d='Shop.Forms.Labels'}
              </label>
              <input
                class="form-control"
                type="email"
                name="email"
                id="email"
                value="{if isset($smarty.post.email)}{$smarty.post.email}{/if}"
                required
              >
            </div>

            <div class="form-group">
              <label class="form-label required" for="order_reference">
                {l s='Order Reference' d='Shop.Forms.Labels'}
              </label>
              <input
                class="form-control"
                type="text"
                name="order_reference"
                id="order_reference"
                value="{if isset($smarty.post.order_reference)}{$smarty.post.order_reference}{/if}"
                required
              >
            </div>

            <div class="guest-form-info">
              <i class="fas fa-info-circle"></i>
              <p>{l s='For example: QIIXJXNUI or QIIXJXNUI#1' d='Shop.Theme.Customeraccount'}</p>
            </div>
          </section>

          <footer class="form-footer">
            <button class="btn btn-primary" type="submit" name="submit">
              {l s='Track Order' d='Shop.Theme.Actions'}
            </button>
          </footer>
        </form>

        <div class="guest-form-footer">
          <p>{l s='Are you a registered customer?' d='Shop.Theme.Customeraccount'}</p>
          <a href="{$urls.pages.my_account}" class="btn btn-secondary">
            {l s='Log in instead' d='Shop.Theme.Actions'}
          </a>
        </div>
      </div>
    {/if}
  </div>
{/block}