{extends file='page.tpl'}

{block name='left_column'}{/block}
{block name='right_column'}{/block}

{block name='content_wrapper'}
  <div id="content-wrapper" class="js-content-wrapper">
    {hook h="displayContentWrapperTop"}
    {block name='content'}
      <p>Hello world! This is the content wrapper.</p>
    {/block}
    {hook h="displayContentWrapperBottom"}
  </div>
{/block}