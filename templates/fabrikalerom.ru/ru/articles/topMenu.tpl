<?if($topMenu->count()):?>
<div class="menu-head">
    <div class="button-m-h">МЕНЮ</div>
    <div class="content-m-h">
        <?foreach($topMenu as $item):?>
        <a href="<?=$item->getPath()?>"><?=$item->getName()?></a>
        <?endforeach;?>
        <div class="close-block">ЗАКРЫТЬ</div>
    </div>
</div>
<?endif?>