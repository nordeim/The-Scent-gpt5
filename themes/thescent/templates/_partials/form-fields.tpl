{**
 * Form fields template
 * Used for rendering various form input types
 *}

{if $field.type == 'hidden'}
  {block name='form_field_item_hidden'}
    <input type="hidden" name="{$field.name}" value="{$field.value}">
  {/block}
{else}

  {block name='form_field'}
    <div class="form-group{if !empty($field.errors)} has-error{/if}">
      {* Label *}
      {block name='form_field_label'}
        {if $field.type !== 'checkbox'}
          <label class="form-label{if $field.required} required{/if}" for="{$field.name}">
            {if $field.type === 'password'}
              {$field.label}
            {else}
              {$field.label}
            {/if}
          </label>
        {/if}
      {/block}

      {* Field container *}
      <div class="form-field-wrapper">
        {block name='form_field_errors'}
          {include file='_partials/form-errors.tpl' errors=$field.errors}
        {/block}

        {* Different field types *}
        {block name='form_field_item'}
          {if $field.type === 'select'}
            {block name='form_field_item_select'}
              <select class="form-control form-select" name="{$field.name}" {if $field.required}required{/if}>
                <option value disabled selected>{l s='-- please choose --' d='Shop.Forms.Labels'}</option>
                {foreach from=$field.availableValues item="label" key="value"}
                  <option value="{$value}" {if $field.value == $value} selected {/if}>{$label}</option>
                {/foreach}
              </select>
            {/block}

          {elseif $field.type === 'countrySelect'}
            {block name='form_field_item_country'}
              <select class="form-control form-select js-country" name="{$field.name}" {if $field.required}required{/if}>
                <option value disabled selected>{l s='-- please choose --' d='Shop.Forms.Labels'}</option>
                {foreach from=$field.availableValues item="label" key="value"}
                  <option value="{$value}" {if $field.value == $value} selected {/if}>{$label}</option>
                {/foreach}
              </select>
            {/block}

          {elseif $field.type === 'radio-buttons'}
            {block name='form_field_item_radio'}
              {foreach from=$field.availableValues item="label" key="value"}
                <div class="custom-radio-wrapper">
                  <label>
                    <input
                      name="{$field.name}"
                      type="radio"
                      value="{$value}"
                      {if $field.required}required{/if}
                      {if $field.value == $value}checked{/if}
                    >
                    <span class="custom-radio-label">{$label}</span>
                  </label>
                </div>
              {/foreach}
            {/block}

          {elseif $field.type === 'checkbox'}
            {block name='form_field_item_checkbox'}
              <div class="custom-checkbox-wrapper">
                <label>
                  <input name="{$field.name}" type="checkbox" value="1" {if $field.value}checked="checked"{/if} {if $field.required}required{/if}>
                  <span class="custom-checkbox-label">{$field.label nofilter}</span>
                </label>
              </div>
            {/block}

          {elseif $field.type === 'date'}
            {block name='form_field_item_date'}
              <input
                class="form-control"
                type="date"
                name="{$field.name}"
                value="{$field.value}"
                placeholder="{if isset($field.availableValues.placeholder)}{$field.availableValues.placeholder}{/if}"
                {if $field.required}required{/if}
              >
            {/block}

          {elseif $field.type === 'birthday'}
            {block name='form_field_item_birthday'}
              <div class="js-parent-focus">
                {html_select_date
                  field_order=DMY
                  time={$field.value}
                  field_array={$field.name}
                  prefix=false
                  reverse_years=true
                  field_separator='<br>'
                  day_extra='class="form-control form-select"'
                  month_extra='class="form-control form-select"'
                  year_extra='class="form-control form-select"'
                  day_empty={l s='-- day --' d='Shop.Forms.Labels'}
                  month_empty={l s='-- month --' d='Shop.Forms.Labels'}
                  year_empty={l s='-- year --' d='Shop.Forms.Labels'}
                }
              </div>
            {/block}

          {elseif $field.type === 'password'}
            {block name='form_field_item_password'}
              <div class="input-group js-parent-focus">
                <input
                  class="form-control js-child-focus js-visible-password"
                  name="{$field.name}"
                  type="password"
                  value=""
                  pattern=".{literal}{{/literal}5,{literal}}{/literal}"
                  placeholder="{if isset($field.availableValues.placeholder)}{$field.availableValues.placeholder}{/if}"
                  {if $field.required}required{/if}
                >
                <button
                  class="btn btn-secondary"
                  type="button"
                  data-action="show-password"
                  data-text-show="{l s='Show' d='Shop.Theme.Actions'}"
                  data-text-hide="{l s='Hide' d='Shop.Theme.Actions'}"
                >
                  {l s='Show' d='Shop.Theme.Actions'}
                </button>
              </div>
            {/block}

          {elseif $field.type === 'textarea'}
            {block name='form_field_item_textarea'}
              <textarea
                class="form-control"
                name="{$field.name}"
                placeholder="{if isset($field.availableValues.placeholder)}{$field.availableValues.placeholder}{/if}"
                {if $field.required}required{/if}
              >{$field.value}</textarea>
            {/block}

          {else}
            {block name='form_field_item_other'}
              <input
                class="form-control"
                name="{$field.name}"
                type="{$field.type}"
                value="{$field.value}"
                placeholder="{if isset($field.availableValues.placeholder)}{$field.availableValues.placeholder}{/if}"
                {if $field.required}required{/if}
                {if isset($field.maxLength)}maxlength="{$field.maxLength}"{/if}
                {if isset($field.pattern)}pattern="{$field.pattern}"{/if}
              >
            {/block}
          {/if}

          {* Help text *}
          {block name='form_field_comment'}
            {if (!$field.required && !in_array($field.type, ['radio-buttons', 'checkbox']))}
              <small class="form-text text-muted">
                {l s='Optional' d='Shop.Forms.Labels'}
              </small>
            {/if}
          {/block}
        {/block}
      </div>
    </div>
  {/block}

{/if}