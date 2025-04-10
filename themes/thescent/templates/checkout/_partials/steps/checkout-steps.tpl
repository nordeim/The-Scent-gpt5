{block name='checkout_steps'}
  <div class="checkout-steps js-checkout-steps">
    {foreach from=$steps item="step" key="position" name="checkout_steps"}
      <div class="checkout-step -{if $step.isCurrent}current{/if} -{if $step.isComplete}complete{/if}" id="{$step.id}">
        <span class="step-number">{$position + 1}</span>
        <span class="step-title">{$step.title}</span>
        {if $step.isComplete}
          <i class="fas fa-check step-complete-icon"></i>
        {/if}
      </div>
    {/foreach}
  </div>
{/block}