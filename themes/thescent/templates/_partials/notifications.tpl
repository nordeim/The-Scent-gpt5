{block name='notifications'}
<aside id="notifications">
  <div class="container">
    {if $notifications.error}
      {block name='notifications_error'}
        <article class="alert alert-danger" role="alert">
          <ul>
            {foreach $notifications.error as $notif}
              <li>{$notif nofilter}</li>
            {/foreach}
          </ul>
        </article>
      {/block}
    {/if}

    {if $notifications.warning}
      {block name='notifications_warning'}
        <article class="alert alert-warning" role="alert">
          <ul>
            {foreach $notifications.warning as $notif}
              <li>{$notif nofilter}</li>
            {/foreach}
          </ul>
        </article>
      {/block}
    {/if}

    {if $notifications.success}
      {block name='notifications_success'}
        <article class="alert alert-success" role="alert">
          <ul>
            {foreach $notifications.success as $notif}
              <li>{$notif nofilter}</li>
            {/foreach}
          </ul>
        </article>
      {/block}
    {/if}

    {if $notifications.info}
      {block name='notifications_info'}
        <article class="alert alert-info" role="alert">
          <ul>
            {foreach $notifications.info as $notif}
              <li>{$notif nofilter}</li>
            {/foreach}
          </ul>
        </article>
      {/block}
    {/if}
  </div>
</aside>
{/block}
