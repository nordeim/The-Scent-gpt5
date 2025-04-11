{include file='_partials/helpers.tpl'}

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

    <main id="main-content">
      {block name='product_activation'}
        {include file='catalog/_partials/product-activation.tpl'}
      {/block}

      {block name='header'}
        {include file='_partials/header.tpl'}
      {/block}

      {block name='notifications'}
        {include file='_partials/notifications.tpl'}
      {/block}

      <section id="wrapper">
        {block name='breadcrumb'}
          {include file='_partials/breadcrumb.tpl'}
        {/block}

        <div class="container">
          <div class="row">
            {block name="left_column"}
              <div id="left-column" class="col-12 col-lg-3">
                {hook h="displayLeftColumn"}
              </div>
            {/block}

            {block name="content_wrapper"}
              <div id="content-wrapper" class="col">
                {block name="content"}
                  <p>Hello world! This is content!</p>
                {/block}
              </div>
            {/block}

            {block name="right_column"}
              <div id="right-column" class="col-12 col-lg-3">
                {hook h="displayRightColumn"}
              </div>
            {/block}
          </div>
        </div>
      </section>

      {block name='footer'}
        {include file='_partials/footer.tpl'}
      {/block}
    </main>

    {block name='javascript_bottom'}
      {include file="_partials/javascript.tpl" javascript=$javascript.bottom}
    {/block}

    {block name='hook_before_body_closing_tag'}
      {hook h='displayBeforeBodyClosingTag'}
    {/block}
  </body>
</html>
