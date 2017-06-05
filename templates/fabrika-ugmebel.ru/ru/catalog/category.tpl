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
                    $objectsCount = $objects->count();
                    if($objectsCount):
                    ?>
                    <div class="col-md-4 col-sm-6">
                        <div class="product-item">
                            <a
                                href="<?=$category->getPath().$seria->alias.'/'?>"
                                class="img-cover <?= $seria->description ? 'background-size-contain' : ''?>"
                                style="background-image: url(<?=
                                    $seria->description ?
                                    $seria->description :
                                    $objects->current()->getFirstPrimaryImage()->getFocusImage('0x200')
                                ?>);"
                            ></a>
                            <div class="product-item-details">
                                <h4><a href="<?=$category->getPath().$seria->alias.'/'?>" class="product--name">Серия <?=$seria->getValue()?></a></h4>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="product--price"><var>от <?=number_format( $this->getController('Catalog')->getMinPriceByObjects($objects), 0, ',', ' ' )?></var> руб.</div>
                                    </div>
                                    <div class="col-sm-6">
                                        <a href="<?=$category->getPath().$seria->alias.'/'?>" class="btn btn-default pull-right">Подробнее</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <?endif?>
                    <?endforeach?>

                </div>
            </div>
            <?endif?>

        </div>
    </section>
</main>

<?$this->includeTemplate('footer')?>