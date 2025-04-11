{if $testimonials}
  <section class="testimonials-section">
    <div class="container">
      <h2>{l s='What Our Community Says' d='Shop.Theme.Global'}</h2>
      
      <div class="testimonial-grid">
        {foreach from=$testimonials item=testimonial}
          <div class="testimonial-card">
            {if $testimonial.image}
              <div class="testimonial-author-image">
                <img 
                  src="{$testimonial.image}" 
                  alt="{$testimonial.author|escape:'html':'UTF-8'}"
                  width="60"
                  height="60"
                >
              </div>
            {/if}
            
            <div class="testimonial-content">
              <blockquote>
                <p>{$testimonial.content|truncate:150:'...'}</p>
              </blockquote>
            </div>
            
            <div class="testimonial-meta">
              <div class="testimonial-author">{$testimonial.author|escape:'html':'UTF-8'}</div>
              {if $testimonial.rating}
                <div class="testimonial-rating">
                  {for $i=1 to 5}
                    {if $i <= $testimonial.rating}
                      <i class="fas fa-star"></i>
                    {else}
                      <i class="far fa-star"></i>
                    {/if}
                  {/for}
                </div>
              {/if}
              {if $testimonial.location}
                <div class="testimonial-location">{$testimonial.location|escape:'html':'UTF-8'}</div>
              {/if}
            </div>
          </div>
        {/foreach}
      </div>
      
      {if isset($view_all_link) && $view_all_link}
        <div class="text-center mt-4">
          <a href="{$view_all_link}" class="btn btn-secondary">
            {l s='View All Reviews' d='Shop.Theme.Global'}
          </a>
        </div>
      {/if}
    </div>
  </section>
{/if}