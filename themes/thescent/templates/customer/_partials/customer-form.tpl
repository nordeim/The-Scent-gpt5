{block name='customer_form'}
  {block name='customer_form_errors'}
    {include file='_partials/form-errors.tpl' errors=$errors['']}
  {/block}

  <form action="{block name='customer_form_actionurl'}{$action}{/block}" id="customer-form" class="js-customer-form" method="post">
    <div class="form-group row">
      {block "form_fields"}
        {foreach from=$formFields item="field"}
          {block "form_field"}
            <div class="form-group col-md-6">
              {if $field.type === "checkbox"}
                <div class="custom-checkbox">
                  <label class="checkbox-label">
                    <input
                      class="form-control"
                      name="{$field.name}"
                      type="checkbox"
                      value="1"
                      {if $field.value}checked{/if}
                    >
                    <span>{$field.label}</span>
                  </label>
                </div>
              {else}
                <label class="form-label" for="{$field.name}">
                  {$field.label}
                  {if $field.required}
                    <span class="required">*</span>
                  {/if}
                </label>
                <input
                  class="form-control"
                  name="{$field.name}"
                  type="{$field.type}"
                  value="{$field.value}"
                  {if $field.required}required{/if}
                >
                {if $field.comment}
                  <small class="form-text text-muted">{$field.comment}</small>
                {/if}
              {/if}
            </div>
          {/block}
        {/foreach}
      {/block}
    </div>

    {block 'customer_form_footer'}
      <footer class="form-footer">
        <input type="hidden" name="submitCreate" value="1">
        {block "form_buttons"}
          <button class="btn btn-primary" data-link-action="save-customer" type="submit">
            {l s='Create account' d='Shop.Theme.Actions'}
          </button>
        {/block}
      </footer>
    {/block}
  </form>
{/block}