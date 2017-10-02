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
                <?$i = 0; foreach($topMenu as $category):?>
                <ul class="ul-main-list-c-l">
                    <li class="main-list-c-l">
                        <img src="/images/fabrikaLerom/decorating.svg" alt="">
                        <?$categ = $this->getCategoryByAlias(array_keys($topMenu)[$i])?>
                        <a href="<?=$categ->getPath()?>"><?=$categ->getName()?></a>
                        <?if (is_array($category)):?>
                        <ul class="inset-list-c-l">
                            <?foreach($category as $subCategory):?>
                            <li>
                                <a href="<?=$subCategory->getPath()?>"><?=$subCategory->getName()?></a>
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