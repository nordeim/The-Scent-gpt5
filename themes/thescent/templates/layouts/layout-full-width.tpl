<!doctype html>
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

    <div id="app"> {* Add wrapper for potential Vue/React integration *}
      <header id="header" class="main-header">
        {block name='header'}
          {include file='_partials/header.tpl'}
        {/block}
      </header>

      <main id="wrapper">
        {hook h="displayWrapperTop"}
        
        {block name='notifications'}
          {include file='_partials/notifications.tpl'}
        {/block}
        
        {block name='content_wrapper'}
          <div id="content-wrapper" class="js-content-wrapper">
            {hook h="displayContentWrapperTop"}
            {block name='content'}
              <p>Hello world! This is HTML5 Boilerplate.</p>
            {/block}
            {hook h="displayContentWrapperBottom"}
          </div>
        {/block}

        {hook h="displayWrapperBottom"}
      </main>

      <footer id="footer">
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