{if $pagination.should_be_displayed}
  <nav class="pagination-nav">
    <div class="container">
      <div class="row align-items-center">
        {* Results Summary *}
        <div class="col-12 col-md-4">
          <p class="showing-results">
            {l s='Showing %from%-%to% of %total% item(s)' d='Shop.Theme.Catalog' sprintf=[
              '%from%' => $pagination.items_shown_from,
              '%to%' => $pagination.items_shown_to,
              '%total%' => $pagination.total_items
            ]}
          </p>
        </div>

        {* Pagination Links *}
        <div class="col-12 col-md-8">
          <ul class="page-list pagination justify-content-center justify-content-md-end">
            {* Previous Page *}
            <li class="page-item {if $pagination.current_page == 1}disabled{/if}">
              <a 
                rel="{if $pagination.current_page == 1}nofollow{/if}"
                href="{$pagination.previous_url}"
                class="page-link previous"
                {if $pagination.current_page == 1}aria-disabled="true"{/if}
              >
                <i class="fas fa-chevron-left"></i>
                <span class="sr-only">{l s='Previous' d='Shop.Theme.Actions'}</span>
              </a>
            </li>

            {* Page Numbers *}
            {foreach from=$pagination.pages item="page"}
              <li class="page-item {if $page.current}active{/if}">
                <a
                  rel="{if $page.type === 'link'}nofollow{/if}"
                  href="{$page.url}"
                  class="page-link {if $page.type === 'spacer'}disabled{/if}"
                  {if $page.current}aria-current="page"{/if}
                >
                  {if $page.type === 'spacer'}
                    <span class="spacer">&hellip;</span>
                  {else}
                    {$page.page}
                  {/if}
                </a>
              </li>
            {/foreach}

            {* Next Page *}
            <li class="page-item {if $pagination.current_page == $pagination.pages_count}disabled{/if}">
              <a
                rel="{if $pagination.current_page == $pagination.pages_count}nofollow{/if}"
                href="{$pagination.next_url}"
                class="page-link next"
                {if $pagination.current_page == $pagination.pages_count}aria-disabled="true"{/if}
              >
                <i class="fas fa-chevron-right"></i>
                <span class="sr-only">{l s='Next' d='Shop.Theme.Actions'}</span>
              </a>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </nav>
{/if}