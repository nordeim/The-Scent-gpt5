{extends file='page.tpl'}

{block name='page_title'}
  {l s='Sitemap' d='Shop.Theme.Global'}
{/block}

{block name='page_content_container'}
  <div class="sitemap-container">
    <div class="sitemap-section">
      <h2>{l s='Products' d='Shop.Theme.Global'}</h2>
      {if isset($categories) && $categories}
        <ul class="sitemap-list">
          {foreach $categories as $category}
            <li>
              <a href="{$category.url}">{$category.name}</a>
              {if isset($category.children) && $category.children}
                <ul>
                  {foreach $category.children as $child}
                    <li>
                      <a href="{$child.url}">{$child.name}</a>
                    </li>
                  {/foreach}
                </ul>
              {/if}
            </li>
          {/foreach}
        </ul>
      {/if}
    </div>

    <div class="sitemap-section">
      <h2>{l s='Our Company' d='Shop.Theme.Global'}</h2>
      {if isset($cms_pages) && $cms_pages}
        <ul class="sitemap-list">
          {foreach $cms_pages as $cms_page}
            <li>
              <a href="{$cms_page.url}">{$cms_page.title}</a>
            </li>
          {/foreach}
        </ul>
      {/if}
    </div>

    <div class="sitemap-section">
      <h2>{l s='Your Account' d='Shop.Theme.Global'}</h2>
      <ul class="sitemap-list">
        {if !$is_logged}
          <li>
            <a href="{$urls.pages.authentication}">{l s='Sign in' d='Shop.Theme.Actions'}</a>
          </li>
          <li>
            <a href="{$urls.pages.register}">{l s='Create new account' d='Shop.Theme.Actions'}</a>
          </li>
        {/if}
        <li>
          <a href="{$urls.pages.my_account}">{l s='My Account' d='Shop.Theme.Global'}</a>
        </li>
        <li>
          <a href="{$urls.pages.order_history}">{l s='Order history' d='Shop.Theme.Global'}</a>
        </li>
        <li>
          <a href="{$urls.pages.addresses}">{l s='Addresses' d='Shop.Theme.Global'}</a>
        </li>
        {if $feature_active.wishlist}
          <li>
            <a href="{$urls.pages.wishlist}">{l s='Wishlist' d='Shop.Theme.Global'}</a>
          </li>
        {/if}
      </ul>
    </div>

    <div class="sitemap-section">
      <h2>{l s='Store Information' d='Shop.Theme.Global'}</h2>
      <ul class="sitemap-list">
        <li>
          <a href="{$urls.pages.contact}">{l s='Contact us' d='Shop.Theme.Global'}</a>
        </li>
        <li>
          <a href="{$urls.pages.stores}">{l s='Our stores' d='Shop.Theme.Global'}</a>
        </li>
        {if $feature_active.newsletter}
          <li>
            <a href="{$urls.pages.newsletter}">{l s='Newsletter' d='Shop.Theme.Global'}</a>
          </li>
        {/if}
      </ul>
    </div>
  </div>
{/block}