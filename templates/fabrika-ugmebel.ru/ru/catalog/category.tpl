<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

    <section id="catalog">
        <div class="container">
            <h1 class="text-center"><?=$category->getName()?></h1>
            <div class="row">
                <div class="col-md-8 col-md-offset-2">
                    <?=$category->getText()?>
                </div>
            </div>
            <br>

            <?if($series->count()):?>
            <div class="product-catalog">
                <div class="row products">
                    <?foreach($series as $seria):?>
                    <?
                    $objects = $this->getController('Catalog')->getObjectsByFabricatorAndSeria($fabricator->id, $seria->getValue());
                    $objects = $this->getController('Catalog')->filterObjectsExcludeSubCategories($objects, $category);
                    $objectsCount = $objects->count();
                    if($objectsCount):
                    ?>
                        <?foreach($objects as $object):?>
                        <div class="col-md-4 col-sm-6">
                            <div class="product-item">
                                <a
                                    href="<?=$object->getPath()?>"
                                    class="img-cover"
                                    style="background-image: url(<?=$object->getFirstPrimaryImage()->getImage('0x200')?>);"
                                ></a>
                                <div class="product-item-details">
                                    <h4><a href="<?=$object->getPath()?>" class="product--name"><?=$object->getName()?></a></h4>
                                    <div class="row">
                                        <div class="col-sm-4">
                                            <?if ($object->getOffer()):?>
                                            <div class="product--old-price"><var><?=number_format( $object->getShowOldPrice(), 0, ',', ' ' )?></var> руб.</div>
                                            <?endif?>
                                            <div class="product--price"><var><?=number_format( $object->getShowPrice(), 0, ',', ' ' )?></var> руб.</div>
                                        </div>
                                        <div class="col-sm-8 list-buying-block">
                                            <button
                                                    type="button" class="btn btn-primary addToShopcart"
                                                    data-objectId="<?=$object->id?>" data-objectClass="<?=$object->getClass()?>"
                                            ><span class="glyphicon glyphicon-shopping-cart"></span>&nbsp;Купить</button>
                                            <a href="<?=$object->getPath()?>" class="btn btn-default pull-right">Подробнее</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <?endforeach?>
                    <?endif?>
                    <?endforeach?>

                </div>
            </div>
            <?endif?>

        </div>
    </section>
</main>

<?$this->includeTemplate('footer')?>