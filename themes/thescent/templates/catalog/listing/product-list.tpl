{extends file=$layout}

{block name='content'}
  <section id="main">
    {block name='product_list_header'}
      <div class="category-header">
        <div class="container">
          {if $category.image}
            <div class="category-cover">
              <img
                src="{$category.image.large.url}"
                alt="{$category.name}"
                loading="lazy"
                width="{$category.image.large.width}"
                height="{$category.image.large.height}"
              >
            </div>
          {/if}

          <h1 class="category-title">{$category.name}</h1>
          {if $category.description}
            <div class="category-description">{$category.description nofilter}</div>
          {/if}
        </div>
      </div>
    {/block}

    {block name='product_list_top'}
      {include file='catalog/_partials/products-top.tpl' listing=$listing}
    {/block}

    {block name='product_list_active_filters'}
      {$listing.rendered_active_filters nofilter}
    {/block}

    <div class="container">
      <div class="row">
        {* Left Column - Filters *}
        {block name="left_column"}
          <div id="left-column" class="col-12 col-lg-3">
            {if $page.page_name == 'category'}
              {hook h="displayLeftColumn"}
            {/if}
          </div>
        {/block}

        {* Product Grid *}
        <div id="content-wrapper" class="col-12 {if $page.page_name == 'category'}col-lg-9{else}col-lg-12{/if}">
          {block name='product_list'}
            {include file='catalog/_partials/products.tpl' listing=$listing productClass="col-6 col-md-4 col-lg-4"}
          {/block}
        </div>
      </div>
    </div>

    {block name='product_list_bottom'}
      {include file='catalog/_partials/products-bottom.tpl' listing=$listing}
    {/block}

    {block name='product_list_footer'}{/block}
  </section>

  {* Category Features *}
  {if $category.additional_description}
    <section class="category-features">
      <div class="container">
        <div class="category-content">
          {$category.additional_description nofilter}
        </div>
      </div>
    </section>
  {/if}

  {* Featured Categories *}
  {if isset($subcategories) && $subcategories|count > 0}
    <section class="subcategories-grid">
      <div class="container">
        <h2>{l s='Shop by Category' d='Shop.Theme.Catalog'}</h2>
        <div class="row">
          {foreach from=$subcategories item=subcategory}
            <div class="col-6 col-md-4 col-lg-3">
              <div class="subcategory-card">
                <a href="{$subcategory.url}">
                  {if $subcategory.image}
                    <div class="subcategory-image">
                      <img
                        src="{$subcategory.image.medium.url}"
                        alt="{$subcategory.name}"
                        loading="lazy"
                        width="{$subcategory.image.medium.width}"
                        height="{$subcategory.image.medium.height}"
                      >
                    </div>
                  {/if}
                  <h3>{$subcategory.name}</h3>
                  {if $subcategory.description}
                    <p>{$subcategory.description|truncate:120:'...'}</p>
                  {/if}
                </a>
              </div>
            </div>
          {/foreach}
        </div>
      </div>
    </section>
  {/if}

  {* Related Content *}
  {block name='product_list_related'}
    {hook h='displayRelatedPosts'}
  {/block}
</section>

{block name='product_list_modals'}
  {include file='_partials/modals/quickview.tpl' modal_id='quickview-modal'}
{/block}
