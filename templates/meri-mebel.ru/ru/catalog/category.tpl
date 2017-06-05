<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>
    <main id="main">
        <div class="container">
            <br>
            <?$this->includeBreadcrumbs()?>
            <h1 class="text-center"><?=$h1?></h1>
            <br>
            <div class="products-catalog">
                <?if($series->count()):?>
                <section class="row products">
                    <?foreach($series as $seria):?>
                    <?
                    $objects = $this->getController('Catalog')->getObjectsByFabricatorAndSeria($fabricator->id, $seria->getValue());
                    $objectsCount = $objects->count();
                    if($objectsCount):
                    ?>
                    <div class="col-md-4 col-sm-6">
                        <div class="product-item">
                            <a
                                href="<?=$category->getPath().$seria->alias.'/'?>"
                                class="img-cover"
                                style="background-image: url(<?=$seria->description?>); background-size: cover"
                            ></a>
                            <div class="product-item-details">
                                <h5><a href="<?=$category->getPath().$seria->alias.'/'?>" class="product--name">Серия <?=$seria->getValue()?></a></h5>
                                <div>
                                    <span class="product--price">от <?=number_format( $this->getController('Catalog')->getMinPriceByObjects($objects), 0, ',', ' ' )?></span>
                                    <span class="glyphicon glyphicon-ruble"></span>
                                    <a href="<?=$category->getPath().$seria->alias.'/'?>" class="btn btn-default btn-sm pull-right">Подробнее</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <?endif?>
                    <?endforeach?>
                </section>
                </br>
                <?endif?>
            </div>
        </div>
    </main>
<?$this->includeTemplate('footer')?>