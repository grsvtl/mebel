<div class="catalog-left">
    <div class="button-c-l"></div>
    <div class="fon-c-l"></div>
    <div class="overlow-c-l">
        <div class="head-c-l">
            <img src="/images/fabrikaLerom/list-menu.svg" alt="" class="h-c-l-1">
            <img src="/images/fabrikaLerom/path-2.svg" alt="" class="h-c-l-2">
            <h4>Каталог товаров</h4>
        </div>
        <div class="list-cl">
            <div class="block-catalog-c-l">
                <?$i = 0; foreach($leftMenu as $category):?>
                <ul class="ul-main-list-c-l">
                    <li class="main-list-c-l">
                        <?
                            $categ = $this->getCategoryByAlias(array_keys($leftMenu)[$i]);
                            $series = $this->getSeriesByCategory($categ);
                        ?>
                        <?if($series):?>
                        <img src="/images/fabrikaLerom/decorating.svg" alt="">
                        <a href="<?=$categ->getPath()?>"><?=$categ->getName()?></a>
                        <ul class="inset-list-c-l">
                            <?foreach($series as $seria):?>
                            <li>
                                <a href="<?=$categ->getPath().$seria->alias.'/'?>"><?=$seria->getValue()?></a>
                            </li>
                            <?endforeach?>
                        </ul>
                        <?endif?>
                    </li>
                </ul>
                <? $i++ ?>
                <?endforeach?>
            </div>
        </div>
        <div class="bg-left-menu"></div>
        <!--<div class="close-left-menu">Свернуть</div>-->
    </div>
</div>