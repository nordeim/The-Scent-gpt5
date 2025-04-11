{include file='_partials/helpers.tpl'}

<!DOCTYPE html>
<html lang="{$language.locale}">
  <head>
    {block name='head'}
      {include file='_partials/head.tpl'}
    {/block}
  </head>

  <body id="{$page.page_name}" class="{$page.body_classes|classnames}">
    {block name='hook_after_body_opening_tag'}
      {hook h='displayAfterBodyOpeningTag'}
    {/block}

    <div id="app" class="site-wrapper">
      {block name='product_activation'}
        {include file='catalog/_partials/product-activation.tpl'}
      {/block}

      <header class="site-header">
        {block name='header'}
          {include file='_partials/header.tpl'}
        {/block}
      </header>

      {block name='notifications'}
        {include file='_partials/notifications.tpl'}
      {/block}

      <main id="main-content">
        {hook h="displayWrapperTop"}
        
        <div class="container">
          {block name='breadcrumb'}
            {include file='_partials/breadcrumb.tpl'}
          {/block}

          <div class="row">
            {block name="left_column"}
              <div id="left-column" class="col-12 col-lg-3">
                {if $page.page_name == 'product'}
                  {hook h='displayLeftColumnProduct'}
                {else}
                  {hook h='displayLeftColumn'}
                {/if}
              </div>
            {/block}

            {block name="content_wrapper"}
              <div id="content-wrapper" class="col-12 {if $page.page_name != 'index'}{if $page.left_column.displayed && $page.right_column.displayed}col-lg-6{else if $page.left_column.displayed || $page.right_column.displayed}col-lg-9{else}col-lg-12{/if}{/if}">
                {block name="content"}
                  <p>Hello world! This is HTML5 Boilerplate.</p>
                {/block}
              </div>
            {/block}

            {block name="right_column"}
              <div id="right-column" class="col-12 col-lg-3">
                {if $page.page_name == 'product'}
                  {hook h='displayRightColumnProduct'}
                {else}
                  {hook h='displayRightColumn'}
                {/if}
              </div>
            {/block}
          </div>
        </div>
        {hook h="displayWrapperBottom"}
      </main>

      <footer class="site-footer">
        {block name='footer'}
          {include file='_partials/footer.tpl'}
        {/block}
      </footer>

    </div>

    {block name='javascript_bottom'}
      {include file="_partials/javascript.tpl" javascript=$javascript.bottom}
    {/block}

    {block name='hook_before_body_closing_tag'}
      {hook h='displayBeforeBodyClosingTag'}
    {/block}
  </body>
</html>
