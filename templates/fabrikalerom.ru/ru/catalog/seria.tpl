<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

    <script type="text/javascript" src="/js/fabrikaLerom/catalog.js"></script>

    <main>
        <div class="container main-content">

            <?$this->getController('Catalog')->getLeftMenu()?>

            <div class="right-block">
                <?$this->includeBreadcrumbs()?>

                <h1><?=$h1?></h1>

                <?$this->includeTemplate('catalog/filterBlock')?>

                <?if($objects->count()  ||  $subGoods->count()):?>
                <div class="tab-catalog">
                    <ul class="nav nav-tabs">
                        <?if($objects->count()):?>
                        <li class="active" data-tab="composition"><a href="#composition" data-toggle="tab"><?=$seria->getValue()?></a></li>
                        <?endif?>
                        <?if($subGoods->count()):?>
                        <li data-tab="modules"><a href="#modules" data-toggle="tab">Мoдули</a></li>
                        <?endif?>
                    </ul>
                    <div class="tab-content">
                        <?if($objects->count()):?>
                        <div class="tab-pane active" id="composition">
                            <div class="row">
                                <?foreach ($objects as $object):?>
                                    <div class="col-md-4 col-sm-6 col-xs-6 productItemSingle">
                                        <?$this->getController('Catalog')->getCatalogListContentItemBlock($object)?>
                                    </div>
                                <?endforeach?>
                            </div>
                        </div>
                        <?endif?>
                        <?if($subGoods->count()):?>
                            <div class="tab-pane" id="modules">
                                <div class="row">
                                    <?foreach ($subGoods as $subGood):?>
                                        <div class="col-md-4 col-sm-6 col-xs-6 productItemSingle">
                                            <?$this->getController('Catalog')->getCatalogListContentItemBlock($subGood)?>
                                        </div>
                                    <?endforeach?>
                                </div>
                            </div>
                        <?endif?>
                    </div>
                    <div class="navigation text-center">
                        <span class="see-more-offers btn loadMoreButton">Показать еще 9 шт. </span>
                    </div>
                </div>
                <?endif?>

            </div>

        </div>
    </main>

    <div class="modalsBlock">

    </div>

    <span class="listLevel" data-value="<?=$level?>"></span>
    <span class="currentCategoryId" data-value="<?=$category->id?>"></span>
    <span class="paramSearchOn" data-value="<?=$isParameterSearchActive?>"></span>

<?$this->includeTemplate('footer')?>