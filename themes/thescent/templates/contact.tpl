{extends file='page.tpl'}

{block name='page_header_container'}{/block}

{block name='page_content'}
  <section class="contact-section">
    <div class="container">
      <div class="contact-header">
        <h1>{l s='Contact Us' d='Shop.Theme.Global'}</h1>
        <p class="contact-intro">{l s='Have questions? We\'re here to help.' d='Shop.Theme.Global'}</p>
      </div>

      <div class="contact-columns">
        {widget name="contactform"}
        
        <div class="contact-info">
          <div class="info-card">
            <div class="info-icon">
              <i class="fas fa-map-marker-alt"></i>
            </div>
            <h3>{l s='Visit Us' d='Shop.Theme.Global'}</h3>
            {$contact_infos.address.formatted nofilter}
          </div>

          {if $contact_infos.phone}
            <div class="info-card">
              <div class="info-icon">
                <i class="fas fa-phone"></i>
              </div>
              <h3>{l s='Call Us' d='Shop.Theme.Global'}</h3>
              <p>{$contact_infos.phone}</p>
            </div>
          {/if}

          {if $contact_infos.email}
            <div class="info-card">
              <div class="info-icon">
                <i class="fas fa-envelope"></i>
              </div>
              <h3>{l s='Email Us' d='Shop.Theme.Global'}</h3>
              <p>{$contact_infos.email}</p>
            </div>
          {/if}

          <div class="info-card">
            <div class="info-icon">
              <i class="fas fa-clock"></i>
            </div>
            <h3>{l s='Business Hours' d='Shop.Theme.Global'}</h3>
            <p>Monday - Friday: 9:00 AM - 6:00 PM<br>
               Saturday: 10:00 AM - 4:00 PM<br>
               Sunday: Closed</p>
          </div>
        </div>
      </div>
    </div>
  </section>
{/block}