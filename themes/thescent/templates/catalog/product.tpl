{extends file='page.tpl'}

{block name='page_content'}
  {block name='page_header_container'}{/block}

  <div class="product-container">
    <div class="product-main-content">
      {* Left Column - Product Images *}
      <div class="product-left-column">
        {block name='product_cover_thumbnails'}
          {include file='catalog/_partials/product-cover-thumbnails.tpl'}
        {/block}
      </div>

      {* Right Column - Product Info *}
      <div class="product-right-column">
        {* Product Title *}
        <h1 class="product-title">{$product.name}</h1>

        {* Reference & Brand *}
        {if $product.reference}
          <div class="product-reference">
            {l s='Reference' d='Shop.Theme.Catalog'}: {$product.reference}
          </div>
        {/if}

        {* Brand *}
        {if $product.manufacturer_name}
          <div class="product-brand">
            {l s='Brand' d='Shop.Theme.Catalog'}: {$product.manufacturer_name}
          </div>
        {/if}

        {* Short Description *}
        {if $product.description_short}
          <div class="product-short-description">
            {$product.description_short nofilter}
          </div>
        {/if}

        {* Prices Section *}
        {block name='product_prices'}
          {include file='catalog/_partials/product-prices.tpl'}
        {/block}

        {* Product Variants *}
        {block name='product_variants'}
          {include file='catalog/_partials/product-variants.tpl'}
        {/block}

        {* Add to Cart Form *}
        {block name='product_add_to_cart'}
          {include file='catalog/_partials/product-add-to-cart.tpl'}
        {/block}

        {* Additional Info (Shipping, Returns) *}
        <div class="product-additional-info">
          {if $configuration.show_prices}
            <div class="shipping-info">
              <i class="fas fa-truck"></i>
              {l s='Free shipping on orders over $50' d='Shop.Theme.Catalog'}
            </div>
          {/if}
          <div class="returns-info">
            <i class="fas fa-undo"></i>
            {l s='30-day return policy' d='Shop.Theme.Catalog'}
          </div>
        </div>

        {* Social Share *}
        {block name='product_social_sharing'}
          {if $product.show_social_sharing}
            <div class="social-sharing">
              <span class="share-title">{l s='Share:' d='Shop.Theme.Global'}</span>
              {hook h='displaySocialSharing'}
            </div>
          {/if}
        {/block}
      </div>
    </div>

    {* Product Details Tabs *}
    <div class="product-details-tabs">
      <div class="tabs-navigation">
        <button class="tab-button active" data-tab="description">
          {l s='Description' d='Shop.Theme.Catalog'}
        </button>
        {if $product.features}
          <button class="tab-button" data-tab="features">
            {l s='Details' d='Shop.Theme.Catalog'}
          </button>
        {/if}
        {if $product.attachments}
          <button class="tab-button" data-tab="attachments">
            {l s='Downloads' d='Shop.Theme.Catalog'}
          </button>
        {/if}
      </div>

      <div class="tabs-content">
        {* Description Tab *}
        <div class="tab-panel active" id="description">
          {block name='product_description'}
            <div class="product-description">
              {$product.description nofilter}
            </div>
          {/block}
        </div>

        {* Features Tab *}
        {if $product.features}
          <div class="tab-panel" id="features">
            <div class="product-features">
              {foreach from=$product.features item=feature}
                <div class="feature-item">
                  <span class="feature-name">{$feature.name}:</span>
                  <span class="feature-value">{$feature.value}</span>
                </div>
              {/foreach}
            </div>
          </div>
        {/if}

        {* Attachments Tab *}
        {if $product.attachments}
          <div class="tab-panel" id="attachments">
            <div class="product-attachments">
              {foreach from=$product.attachments item=attachment}
                <div class="attachment-item">
                  <a href="{url entity='attachment' params=['id_attachment' => $attachment.id_attachment]}">
                    <i class="fas fa-file-download"></i>
                    {$attachment.name}
                  </a>
                  {if $attachment.description}
                    <p>{$attachment.description}</p>
                  {/if}
                </div>
              {/foreach}
            </div>
          </div>
        {/if}
      </div>
    </div>

    {* Related Products *}
    {block name='product_accessories'}
      {if $accessories}
        <section class="related-products">
          <h2>{l s='You might also like' d='Shop.Theme.Catalog'}</h2>
          <div class="products product-grid">
            {foreach from=$accessories item="product_accessory"}
              {block name='product_miniature'}
                {include file='catalog/_partials/miniatures/product.tpl' product=$product_accessory}
              {/block}
            {/foreach}
          </div>
        </section>
      {/if}
    {/block}

    {* Product Footer - Additional Hooks *}
    {block name='product_footer'}
      {hook h='displayFooterProduct' product=$product category=$category}
    {/block}
  </div>

  {* Product Modals *}
  {block name='product_images_modal'}
    {include file='catalog/_partials/product-images-modal.tpl'}
  {/block}
{/block}