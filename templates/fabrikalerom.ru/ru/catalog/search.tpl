<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

<script type="text/javascript" src="/js/fabrikaLerom/catalog.js"></script>
<script src="/js/fabrikaLerom/colorChoose.js"></script>

<main>
    <div class="container main-content">
        <?$this->getController('Catalog')->getLeftMenu()?>
        <div class="right-block">
            <?$this->includeBreadcrumbs()?>
            <h1><?=$h1?></h1>
            <div class="tab-catalog">
                <?if($objects->count()):?>
                <!-- Nav tabs -->
                <ul class="nav nav-tabs">
                    <li class="active" data-tab="composition"><a href="#composition" data-toggle="tab">Товары</a></li>
                </ul>
                <!-- Tab panes -->
                <div class="tab-content">
                    <div class="tab-pane active" id="composition">
                        <div class="row">
                            <?foreach ($objects as $object):?>
                            <div class="col-md-4 col-sm-6 col-xs-6 productItemSingle">
                                <?$this->getController('Catalog')->getCatalogListContentItemBlock($object)?>
                            </div>
                            <?endforeach?>
                        </div>
                    </div>
                </div>
                <?else:?>
                <!--                <div class="navigation text-center">-->
                <!--                    <span class="see-more-offers btn loadMoreButton">Показать еще </span>-->
                <!--                </div>-->
                <div class="text-content-inset">
                    <!--                    <h3>Заголовок сео текса</h3>-->
                    <p>Таких товаров не найдено.</p>
                    <p>Попробуйте изменить запрос.</p>
                </div>
                <?endif?>
            </div>
        </div>
    </div>
</main>

<span class="listLevel" data-value="<?=$level?>"></span>
<span class="query" data-value="<?=$query?>"></span>
<span class="paramSearchOn" data-value="<?=$isParameterSearchActive?>"></span>

<?$this->includeTemplate('footer')?>