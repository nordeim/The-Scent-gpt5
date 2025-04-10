{extends file='page.tpl'}

{block name='page_content_container'}
  <section id="content" class="page-content page-cms-category">
    <div class="cms-category-header">
      <h1>{$cms_category.name}</h1>
      {if $cms_category.description}
        <div class="category-description">
          {$cms_category.description nofilter}
        </div>
      {/if}
    </div>

    {if !empty($sub_categories) || !empty($cms_pages)}
      <div class="cms-content-grid">
        {* Display Sub Categories *}
        {if !empty($sub_categories)}
          <div class="cms-categories">
            <h2>{l s='Categories' d='Shop.Theme.Global'}</h2>
            <div class="category-grid">
              {foreach from=$sub_categories item=sub_category}
                <div class="category-card">
                  <h3>{$sub_category.name}</h3>
                  {if $sub_category.description}
                    <p>{$sub_category.description|truncate:120:'...'|strip_tags}</p>
                  {/if}
                  <a href="{$sub_category.link}" class="btn btn-secondary">
                    {l s='View Category' d='Shop.Theme.Actions'}
                  </a>
                </div>
              {/foreach}
            </div>
          </div>
        {/if}

        {* Display CMS Pages *}
        {if !empty($cms_pages)}
          <div class="cms-pages">
            <h2>{l s='Pages' d='Shop.Theme.Global'}</h2>
            <div class="page-grid">
              {foreach from=$cms_pages item=cms_page}
                <div class="page-card">
                  <h3>{$cms_page.meta_title}</h3>
                  {if $cms_page.meta_description}
                    <p>{$cms_page.meta_description|truncate:120:'...'}</p>
                  {/if}
                  <a href="{$cms_page.link}" class="btn btn-secondary">
                    {l s='Read More' d='Shop.Theme.Actions'}
                  </a>
                </div>
              {/foreach}
            </div>
          </div>
        {/if}
      </div>
    {else}
      <div class="empty-state">
        <i class="fas fa-file-alt"></i>
        <p>{l s='No content available in this category.' d='Shop.Theme.Global'}</p>
      </div>
    {/if}
  </section>
{/block}