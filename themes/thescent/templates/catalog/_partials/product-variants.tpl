{if $groups}
  <div class="product-variants js-product-variants">
    {foreach from=$groups key=id_attribute_group item=group}
      {if !empty($group.attributes)}
      <div class="product-variant-group">
        <label for="group_{$id_attribute_group}" class="form-label">
          {$group.name}{if $group.group_type !== 'color'}: <span class="variant-value"></span>{/if}
        </label>

        {if $group.group_type == 'select'}
          <select
            id="group_{$id_attribute_group}"
            class="form-select"
            data-product-attribute="{$id_attribute_group}"
            name="group[{$id_attribute_group}]"
            aria-label="{$group.name}"
          >
            {foreach from=$group.attributes key=id_attribute item=group_attribute}
              <option 
                value="{$id_attribute}" 
                title="{$group_attribute.name}"
                {if $group_attribute.selected} selected="selected"{/if}
              >
                {$group_attribute.name}
              </option>
            {/foreach}
          </select>

        {elseif $group.group_type == 'color'}
          <div class="color-group">
            {foreach from=$group.attributes key=id_attribute item=group_attribute}
              <div class="color-option">
                <input 
                  class="input-color" 
                  type="radio"
                  data-product-attribute="{$id_attribute_group}"
                  name="group[{$id_attribute_group}]"
                  value="{$id_attribute}"
                  id="color_{$id_attribute}"
                  {if $group_attribute.selected} checked="checked"{/if}
                >
                <label 
                  aria-label="{$group_attribute.name}"
                  for="color_{$id_attribute}"
                  class="color-label"
                  title="{$group_attribute.name}"
                >
                  <span 
                    class="color-swatch"
                    style="background-color: {$group_attribute.html_color_code}"
                  ></span>
                </label>
              </div>
            {/foreach}
          </div>

        {elseif $group.group_type == 'radio'}
          <div class="radio-group">
            {foreach from=$group.attributes key=id_attribute item=group_attribute}
              <div class="radio-option">
                <input
                  class="input-radio"
                  type="radio"
                  data-product-attribute="{$id_attribute_group}"
                  name="group[{$id_attribute_group}]"
                  value="{$id_attribute}"
                  id="radio_{$id_attribute}"
                  {if $group_attribute.selected} checked="checked"{/if}
                >
                <label for="radio_{$id_attribute}">
                  {$group_attribute.name}
                </label>
              </div>
            {/foreach}
          </div>
        {/if}
      </div>
      {/if}
    {/foreach}
  </div>

  {* Variant Change Script *}
  <script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function() {
      // Update variant value display
      function updateVariantValue(select) {
        const label = select.closest('.product-variant-group').querySelector('.variant-value');
        if (label) {
          const selectedOption = select.options[select.selectedIndex];
          label.textContent = selectedOption.text;
        }
      }

      // Initialize variant values
      document.querySelectorAll('.product-variants select').forEach(select => {
        updateVariantValue(select);
        select.addEventListener('change', () => updateVariantValue(select));
      });
    });
  </script>
{/if}