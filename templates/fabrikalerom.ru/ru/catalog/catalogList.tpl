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

            <div class="tab-catalog">
                <!-- Nav tabs -->
                <ul class="nav nav-tabs">
                    <li class="active" data-tab="composition"><a href="#composition" data-toggle="tab"><?=$category->getName()?></a></li>
                    <?if($hasModules):?><li data-tab="modules"><a href="#modules" data-toggle="tab">Мoдули</a></li><?endif?>
                </ul>
                <!-- Tab panes -->
                <div class="tab-content">
                    <div class="tab-pane active" id="composition">
                        <div class="row">
                            <?foreach ($mainObjects as $mainObject):?>
                            <div class="col-md-4 col-sm-6 col-xs-6 productItemSingle">
                                <?$this->getController('Catalog')->getCatalogListContentItemBlock($mainObject)?>
                            </div>
                            <?endforeach?>
                        </div>
                    </div>

                    <?if($hasModules):?>
                    <div class="tab-pane" id="modules">
                        <div class="row">
                            <?foreach ($restObjects as $restObject):?>
                            <div class="col-md-4 col-sm-6 col-xs-6 productItemSingle">
                                <?$this->getController('Catalog')->getCatalogListContentItemBlock($restObject)?>
                            </div>
                            <?endforeach?>
                        </div>
                    </div>
                    <?endif?>
                </div>
                <div class="navigation text-center">
                    <span class="see-more-offers btn loadMoreButton">Показать еще</span>
                </div>
                <div class="text-content-inset">
                    <?=$category->getText()?>
                </div>
            </div>
        </div>

    </div>
</main>

<div class="modalsBlock">

</div>

<span class="listLevel" data-value="<?=$level?>"></span>
<span class="currentCategoryId" data-value="<?=$category->id?>"></span>
<span class="paramSearchOn" data-value="<?=$isParameterSearchActive?>"></span>

<?$this->includeTemplate('footer')?>