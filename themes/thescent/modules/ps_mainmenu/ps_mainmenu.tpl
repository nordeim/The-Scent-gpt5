{assign var=_counter value=0}
{function name="menu" nodes=[] depth=0 parent=null}
  {if $nodes|count}
    <ul class="{if $depth == 0}top-menu{else}submenu{/if}" data-depth="{$depth}">
      {foreach from=$nodes item=node}
        <li class="{$node.type}{if $node.current} current{/if}">
          <a href="{$node.url}" class="menu-link{if $depth >= 1} submenu-link{/if}"{if $node.open_in_new_window} target="_blank"{/if}>
            {$node.label}
          </a>
          {if $node.children|count}
            {menu nodes=$node.children depth=$node.depth parent=$node}
          {/if}
        </li>
      {/foreach}
    </ul>
  {/if}
{/function}

<nav class="main-nav">
  {menu nodes=$menu.children}
</nav>
