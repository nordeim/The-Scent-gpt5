{extends file='page.tpl'}

{block name='page_content_container'}
  <section id="content" class="page-content page-cms page-cms-{$cms.id}">
    <div class="cms-header">
      <h1>{$cms.meta_title}</h1>
      {if isset($cms_category)}
        <div class="cms-category">
          <span>{$cms_category.name}</span>
        </div>
      {/if}
    </div>

    <div class="cms-content">
      {$cms.content nofilter}
    </div>

    {block name='hook_cms_dispute_information'}
      {hook h='displayCMSDisputeInformation'}
    {/block}

    {block name='hook_cms_print_button'}
      {hook h='displayCMSPrintButton'}
    {/block}
  </section>
{/block}