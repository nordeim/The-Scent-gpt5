{block name='modal_window'}
<div class="modal fade" id="{$modal_id}" tabindex="-1" role="dialog" aria-labelledby="{$modal_id}-label" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
    <div class="modal-content">
      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{l s='Close' d='Shop.Theme.Global'}">
        <i class="fas fa-times"></i>
      </button>

      <div class="modal-body">
        <div class="row">
          {* Product Images *}
          <div class="col-md-6">
            <div class="quickview-images">
              {block name='product_cover'}
                <div class="product-cover">
                  {if $product.cover}
                    <img 
                      class="js-qv-product-cover" 
                      src="{$product.cover.bySize.large_default.url}" 
                      alt="{$product.cover.legend}" 
                      title="{$product.cover.legend}"
                      width="{$product.cover.bySize.large_default.width}"
                      height="{$product.cover.bySize.large_default.height}"
                      loading="lazy"
                    >
                  {/if}
                </div>
              {/block}

              {block name='product_images'}
                <div class="product-thumb-images">
                  {foreach from=$product.images item=image}
                    <div class="thumb-container">
                      <img
                        class="thumb js-thumb {if $image.id_image == $product.cover.id_image} selected {/if}"
                        src="{$image.bySize.small_default.url}"
                        alt="{$image.legend}"
                        title="{$image.legend}"
                        width="{$image.bySize.small_default.width}"
                        height="{$image.bySize.small_default.height}"
                        data-image-large-src="{$image.bySize.large_default.url}"
                        loading="lazy"
                      >
                    </div>
                  {/foreach}
                </div>
              {/block}
            </div>
          </div>

          {* Product Info *}
          <div class="col-md-6">
            <div class="quickview-info">
              {* Product Name *}
              <h1 class="h3 product-title">{$product.name}</h1>

              {* Product Price *}
              {block name='product_prices'}
                {include file='catalog/_partials/product-prices.tpl'}
              {/block}

              {* Short Description *}
              {block name='product_description_short'}
                <div class="product-description-short">{$product.description_short nofilter}</div>
              {/block}

              {* Product Variants *}
              {block name='product_variants'}
                {include file='catalog/_partials/product-variants.tpl'}
              {/block}

              {* Add to Cart Form *}
              {block name='product_add_to_cart'}
                {include file='catalog/_partials/product-add-to-cart.tpl'}
              {/block}

              {* Additional Info *}
              <div class="additional-info">
                {* Product Reference *}
                {if isset($product.reference_to_display) && $product.reference_to_display neq ''}
                  <p class="product-reference">
                    <label>{l s='SKU:' d='Shop.Theme.Catalog'}</label>
                    <span>{$product.reference_to_display}</span>
                  </p>
                {/if}

                {* Stock Status *}
                {if $product.show_availability && $product.availability_message}
                  <p class="product-availability {if $product.availability == 'available'}in-stock{elseif $product.availability == 'last_remaining_items'}last-items{else}out-of-stock{/if}">
                    <i class="fas fa-check"></i>
                    {$product.availability_message}
                  </p>
                {/if}
              </div>

              {* View Full Details Button *}
              <div class="quickview-footer">
                <a href="{$product.url}" class="btn btn-secondary btn-block">
                  {l s='View Full Details' d='Shop.Theme.Actions'}
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
{/block}