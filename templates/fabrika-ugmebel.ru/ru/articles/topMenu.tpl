<?if($topMenu->count()):?>
<div class="collapse navbar-collapse navbar-top">
    <ul class="nav navbar-nav">
        <?foreach($topMenu as $item):?>
        <li class="<?= $this->getRequest()['action']==$item->alias  ?  'active'  :  ''?>">
            <a href="<?=$item->getPath()?>"><?=$item->getName()?></a>
        </li>
        <?endforeach;?>
    </ul>
</div>
<?endif?>