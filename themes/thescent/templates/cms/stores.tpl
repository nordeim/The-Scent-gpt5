{extends file='page.tpl'}

{block name='page_title'}
  {l s='Our Stores' d='Shop.Theme.Global'}
{/block}

{block name='page_content_container'}
  <div class="stores-container">
    {if $stores}
      <div class="stores-grid">
        {foreach $stores as $store}
          <article class="store-card" id="store-{$store.id}">
            {if $store.image}
              <div class="store-image">
                <img
                  src="{$store.image.bySize.stores_default.url}"
                  alt="{$store.name}"
                  title="{$store.name}"
                  loading="lazy"
                >
              </div>
            {/if}
            
            <div class="store-info">
              <h3>{$store.name}</h3>
              
              <div class="store-address">
                <i class="fas fa-map-marker-alt"></i>
                {$store.address.formatted nofilter}
              </div>

              {if $store.phone}
                <div class="store-contact">
                  <i class="fas fa-phone"></i>
                  <a href="tel:{$store.phone}">{$store.phone}</a>
                </div>
              {/if}

              {if $store.email}
                <div class="store-contact">
                  <i class="fas fa-envelope"></i>
                  <a href="mailto:{$store.email}">{$store.email}</a>
                </div>
              {/if}

              {if $store.note}
                <div class="store-description">
                  {$store.note nofilter}
                </div>
              {/if}

              {if $store.hours}
                <div class="store-hours">
                  <h4>{l s='Working Hours' d='Shop.Theme.Global'}</h4>
                  <table>
                    {foreach $store.hours as $day}
                      <tr>
                        <td>{$day.day}</td>
                        <td>{$day.hours}</td>
                      </tr>
                    {/foreach}
                  </table>
                </div>
              {/if}

              {if $store.latitude && $store.longitude}
                <a href="https://www.google.com/maps/dir/?api=1&destination={$store.latitude},{$store.longitude}"
                   class="btn btn-secondary store-map-link"
                   target="_blank"
                   rel="noopener noreferrer">
                  <i class="fas fa-directions"></i>
                  {l s='Get Directions' d='Shop.Theme.Global'}
                </a>
              {/if}
            </div>
          </article>
        {/foreach}
      </div>
    {else}
      <div class="alert alert-info">
        {l s='No stores found' d='Shop.Theme.Global'}
      </div>
    {/if}
  </div>
{/block}