{extends file='customer/page.tpl'}

{block name='page_title'}
  {l s='Guest Order Tracking' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
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
          {l s='Send' d='Shop.Theme.Actions'}
        </button>
      </footer>
    </form>

    <div class="guest-form-footer">
      <p>{l s='Are you a registered customer?' d='Shop.Theme.Customeraccount'}</p>
      <a href="{$urls.pages.authentication}" class="btn btn-secondary">
        {l s='Log in instead' d='Shop.Theme.Actions'}
      </a>
    </div>
  </div>
{/block}