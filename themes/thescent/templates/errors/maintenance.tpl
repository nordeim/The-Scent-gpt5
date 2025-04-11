<!DOCTYPE html>
<html lang="{$language.locale}">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <title>{l s='We\'ll be back soon' d='Shop.Theme.Global'} - {$shop.name}</title>
    
    {block name='stylesheets'}
      <link rel="stylesheet" href="{$urls.css_url}custom.css">
      <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600;700&family=Montserrat:wght@300;400;500;600&display=swap" rel="stylesheet">
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    {/block}

    <style>
      body {
        display: flex;
        align-items: center;
        justify-content: center;
        min-height: 100vh;
        margin: 0;
        padding: 20px;
        background-color: var(--color-background);
        font-family: var(--font-body);
      }

      .maintenance-container {
        max-width: 600px;
        text-align: center;
        padding: 40px;
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.1);
      }

      .logo {
        margin-bottom: 30px;
      }

      .logo img {
        max-width: 200px;
        height: auto;
      }

      h1 {
        font-family: var(--font-heading);
        color: var(--color-primary);
        margin-bottom: 20px;
      }

      .maintenance-message {
        margin-bottom: 30px;
        line-height: 1.6;
        color: var(--color-text);
      }

      .social-links {
        margin-top: 30px;
      }

      .social-links a {
        display: inline-block;
        margin: 0 10px;
        color: var(--color-primary);
        font-size: 24px;
        transition: color 0.3s ease;
      }

      .social-links a:hover {
        color: var(--color-accent);
      }

      .countdown {
        margin: 30px 0;
        font-size: 1.2em;
        color: var(--color-primary);
      }
    </style>
  </head>

  <body>
    <div class="maintenance-container">
      <div class="logo">
        <img src="{$shop.logo}" alt="{$shop.name}">
      </div>

      <h1>{l s='We\'re Getting a Fresh Look!' d='Shop.Theme.Global'}</h1>

      <div class="maintenance-message">
        <p>{l s='Our online store is currently undergoing scheduled maintenance. We\'ll be back soon with a refreshed shopping experience.' d='Shop.Theme.Global'}</p>
        <p>{l s='Thank you for your patience!' d='Shop.Theme.Global'}</p>
      </div>

      {if isset($maintenance_text)}
        <div class="custom-message">
          {$maintenance_text}
        </div>
      {/if}

      {if isset($maintenance_end_time)}
        <div class="countdown">
          <p>{l s='Expected completion time:' d='Shop.Theme.Global'}</p>
          <span class="countdown-timer" data-end="{$maintenance_end_time}"></span>
        </div>
      {/if}

      <div class="social-links">
        {if Configuration::get('PS_SOCIAL_TWITTER')}
          <a href="{Configuration::get('PS_SOCIAL_TWITTER')}" target="_blank" rel="noopener noreferrer">
            <i class="fab fa-twitter"></i>
          </a>
        {/if}
        {if Configuration::get('PS_SOCIAL_FACEBOOK')}
          <a href="{Configuration::get('PS_SOCIAL_FACEBOOK')}" target="_blank" rel="noopener noreferrer">
            <i class="fab fa-facebook"></i>
          </a>
        {/if}
        {if Configuration::get('PS_SOCIAL_INSTAGRAM')}
          <a href="{Configuration::get('PS_SOCIAL_INSTAGRAM')}" target="_blank" rel="noopener noreferrer">
            <i class="fab fa-instagram"></i>
          </a>
        {/if}
      </div>
    </div>

    {if isset($maintenance_end_time)}
      <script>
        // Countdown functionality
        function updateCountdown() {
          const endTime = new Date("{$maintenance_end_time}").getTime();
          const now = new Date().getTime();
          const distance = endTime - now;

          const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
          const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
          const seconds = Math.floor((distance % (1000 * 60)) / 1000);

          document.querySelector('.countdown-timer').innerHTML = 
            hours + "h " + minutes + "m " + seconds + "s";

          if (distance < 0) {
            clearInterval(countdownInterval);
            document.querySelector('.countdown-timer').innerHTML = "{l s='Maintenance completed soon' d='Shop.Theme.Global'}";
          }
        }

        const countdownInterval = setInterval(updateCountdown, 1000);
        updateCountdown();
      </script>
    {/if}
  </body>
</html>