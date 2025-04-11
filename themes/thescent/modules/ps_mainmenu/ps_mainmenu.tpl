{assign var=_counter value=0}
{function name="menu" nodes=[] depth=0 parent=null}
  {if $nodes|count}
    <ul class="top-menu" {if $depth == 0}id="top-menu"{/if} data-depth="{$depth}">
      {foreach from=$nodes item=node}
        <li class="{$node.type}{if $node.current} current{/if}" id="{$node.page_identifier}">
          <a
            class="{if $depth >= 0}dropdown-item{/if}{if $depth === 1} dropdown-submenu{/if}"
            href="{$node.url}" data-depth="{$depth}"
            {if $node.open_in_new_window} target="_blank" {/if}
          >
            {if $node.children|count}
              {* Add dropdown arrow for parent items *}
              <span class="float-xs-right hidden-md-up">
                <span data-target="#top_sub_menu_{$_counter}" data-toggle="collapse" class="navbar-toggler collapse-icons">
                  <i class="material-icons add">&#xE313;</i>
                  <i class="material-icons remove">&#xE316;</i>
                </span>
              </span>
            {/if}
            {$node.label}
          </a>
          {if $node.children|count}
            <div {if $depth === 0} class="sub-menu collapse"{else} class="collapse"{/if} id="top_sub_menu_{$_counter}">
              {menu nodes=$node.children depth=$node.depth parent=$node}
            </div>
          {/if}
        </li>
        {assign var=_counter value=$_counter+1}
      {/foreach}
    </ul>
  {/if}
{/function}

<div class="main-nav">
  {menu nodes=$menu.children}
  <div class="clearfix"></div>
</div>
