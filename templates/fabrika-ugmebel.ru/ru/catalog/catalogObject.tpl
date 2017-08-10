<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

    <section id="content" class="container">
        <?if($this->getController('Authorization')->isAdminAuthorizated()):?>
            <a
                class="adminShow"
                href="<?=$object->getAdminPath()?>"
                target="_blank" title="Эта ссылка видна только авторизованному в админской части пользователю"
                style="position: relative;"
            >
                Редактировать [id = <?=$object->id?>]
            </a>
        <?endif?>
        <div class="row">
            <div class="col-lg-8 col-md-7">
                <div id="productCarousel" class="slide">
                    <?$images = $object->getImagesByCategoryAndStatus('1,2', 1);?>


                    <link rel="stylesheet" type="text/css" href="/js/extensions/slick/slick.css"/>
                    <link rel="stylesheet" type="text/css" href="/js/extensions/slick/slick-theme.css"/>
                    <script src="/js/extensions/slick/slick.js" type="text/javascript" charset="utf-8"></script>
                    <script src="/js/slick/catalogObjectSlick.js" type="text/javascript" charset="utf-8"></script>
                    <script type="text/javascript" src="/js/plugins/gallery/gallery.js"></script>
                    <input type="hidden" value="4" class="slick-slidesToShow">
                    <div class="slider slider-for">
                        <div class="item">
                            <a data-href="<?=$object->getFirstPrimaryImage()->getImage('0x0', 'watermarkPng')?>" class="bigImage">
                                <img src="<?=$object->getFirstPrimaryImage()->getImage('750x376', 'watermark')?>">
                            </a>
                        </div>
                        <?foreach($images as $image ): ?>
                            <div class="item">
                                <a data-href="<?=$image->getImage('0x0', 'watermarkPng')?>" class="bigImage">
                                    <img src="<?=$image->getImage('750x376', 'watermark')?>">
                                </a>
                            </div>
                        <? endforeach; ?>
                    </div>
                    <div class="slider slider-nav">
                        <div class="item-small">
                            <img src="<?=$object->getFirstPrimaryImage()->getImage('167x90', 'watermark')?>">
                        </div>
                        <?foreach($images as $image ): ?>
                            <div class="item-small">
                                <img src="<?=$image->getImage('167x90', 'watermark')?>">
                            </div>
                        <? endforeach; ?>
                    </div>


                </div>
            </div>
            <div class="col-lg-4 col-md-5 product-info">
                <h1><?=$object->getName()?></h1>
                <?if ($object->getOffer()):?>
                <div class="row offer_only">
                    Только в период акции!
                </div>
                <?endif?>
                <div class="row product-price-bar">
                    <div class="col-sm-5 col-xs-7">
                        <label>Цена</label>
                        <div class="product--price"><var><?=number_format( $object->getShowPrice(), 0, ',', ' ' )?></var> руб.</div>
                    </div>
                    <?if ($object->getOffer()):?>
                    <div class="col-sm-5 col-xs-5">
                        <label>Старая цена</label>
                        <div class="product--old-price"><var><?=number_format( $object->getShowOldPrice(), 0, ',', ' ' )?></var> руб.</div>
                    </div>
                    <?endif?>
                    <div class="col-sm-2 hidden-xs">
<!--                        <div class="product-item-discount">-<var>33</var>%</div>-->
                    </div>
                </div>
                <br>
                <div class="product-info-buying">
                    <button
                        type="button" class="btn btn-primary addToShopcart"
                        data-objectId="<?=$object->id?>" data-objectClass="<?=$object->getClass()?>"
                    ><span class="glyphicon glyphicon-shopping-cart"></span>&nbsp;Купить</button>

                    <button
                        type="button"
                        class="btn btn-default btn-md orderOneClickModalShow"
                        data-objectId="<?=$object->id?>"
                        title="Купить в 1 клик - <?=$object->getName()?>"
                    >Купить в один клик</button>
                </div>
                <hr>

                <table class="table-options">
                    <tbody>
                        <?if($materialArray):?>
                        <tr>
                            <td><label>Материал</label></td>
                            <td>
                                <span>
                                    <?$i=1; foreach($materialArray as $material):?>
                                    <?=$material['name']?><?= $i==count($materialArray) ? '' : ', '?>
                                    <?$i++; endforeach?>
                                </span>
                            </td>
                        </tr>
                        <?endif?>

                        <?if($corpusArray  ||  $fasadArray):?>
                        <tr>
                            <td><label>Цвет</label></td>
                            <?if($corpusArray):?>
                            <td>
                                <span>
                                <?$i=1; foreach($corpusArray as $corpus):?>
                                    <?//=$corpus['name']?><?//= $i==count($corpusArray) ? '' : ', '?>
                                    <? if (file_exists(DIR.'/images/colors/'.$corpus['description'].'.png') ): ?>
                                        <img src="/images/colors/<?=$corpus['description']?>.png" title="<?=$corpus['name']?>" width="54" height="54">
                                    <?elseif(file_exists(DIR.'/images/colors/'.$corpus['description'].'.jpg')):?>
                                        <img src="/images/colors/<?=$corpus['description']?>.jpg" title="<?=$corpus['name']?>"  width="54" height="54">
                                    <?elseif(file_exists(DIR.'/images/colors/'.$corpus['description'].'.gif')):?>
                                        <img src="/images/colors/<?=$corpus['description']?>.gif" title="<?=$corpus['name']?>"  width="54" height="54">
                                    <?else:?>
                                        <?=$corpus['name'].($i==count($corpusArray) ? '' : ', ')?>
                                    <? endif; ?>
                                    <?$i++; endforeach?>
                                </span>
                            </td>
                            <?endif?>
                            <?if($fasadArray):?>
                            <td>
                                <span>
                                <?$i=1; foreach($fasadArray as $fasad):?>
                                    <?//=$fasad['name']?><?//= $i==count($fasadArray) ? '' : ', '?>
                                    <? if (file_exists(DIR.'/images/colors/'.$fasad['description'].'.png') ): ?>
                                        <img src="/images/colors/<?=$fasad['description']?>.png" title="<?=$fasad['name']?>" width="54" height="54">
                                    <?elseif(file_exists(DIR.'/images/colors/'.$fasad['description'].'.jpg')):?>
                                        <img src="/images/colors/<?=$fasad['description']?>.jpg" title="<?=$fasad['name']?>"  width="54" height="54">
                                    <?elseif(file_exists(DIR.'/images/colors/'.$fasad['description'].'.gif')):?>
                                        <img src="/images/colors/<?=$fasad['description']?>.gif" title="<?=$fasad['name']?>"  width="54" height="54">
                                    <?else:?>
                                        <?=$fasad['name'].($i==count($fasadArray) ? '' : ', ')?>
                                    <? endif; ?>
                                    <?$i++; endforeach?>
                                    </span>
                            </td>
                            <?endif?>
                        </tr>
                        <?endif?>

                        <? foreach( $sizesAndWeight as $size ): ?>
                        <? if($object->getPropertyValueById($size->id)->value): ?>
                        <tr>
                            <td><label><?=$size->getValue()?>:</label></td>
                            <td>
                                <span>
                                    <?=$object->getPropertyValueById($size->id)->value?> <?=$object->getPropertyValueById($size->id)->getMeasure()->shortName?>
                                </span>
                            </td>
                        </tr>
                        <? endif; ?>
                        <? endforeach; ?>
                    </tbody>
                </table>

                <hr>
                <br>
                <div class="row text-center text-dark product-option-bar">
                    <div class="col-xs-4">
                        <img src="/images/ugMebel/bg/2_years_warranty.png" alt="">
                        <p><small>года гарантии</small></p>
                    </div>
                    <div class="col-xs-4">
                        <img src="/images/ugMebel/bg/pay_methods.png" alt="">
                        <p><small>Оплата по факту VISA и MC</small></p>
                    </div>
                    <div class="col-xs-4">
                        <img src="/images/ugMebel/bg/assembly_and_delivery.png" alt="">
                        <p><small>Осуществляем сборку и доставку</small></p>
                    </div>
                </div>
            </div>
        </div>
        <br>

        <?if($object->isSubGoodsExists()  ||  $object->getText()):?>
        <section id="productComplect">
            <div role="tabpanel">
                <!-- Nav tabs -->
                <ul class="nav nav-tabs" role="tablist">
                    <?$i = 0;?>
                    <?if($object->isSubGoodsExists()):?>
                    <li role="presentation" class="active" <?$i = 1;?>>
                        <a href="#theKitIncludes" aria-controls="tab" role="tab" data-toggle="tab">В комплект входит</a>
                    </li>
                    <?endif?>
                    <?if($object->getText()):?>
                    <li role="presentation" class="<?= $i==0 ? 'active' : ''?>">
                        <a href="#productDescription" aria-controls="tab" role="tab" data-toggle="tab">Описание</a>
                    </li>
                    <?endif?>
<!--                    <li class="pull-right hidden-xs">-->
<!--                        <a href="#">Посмотреть больше фото в Instagram&nbsp;&nbsp;&nbsp;<img src="/images/ugMebel/bg/more_photos_in_instagram.png" class="link-to-instagram hidden-sm"></a>-->
<!--                    </li>-->
                </ul>

                <?if($object->isSubGoodsExists()):?>
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="theKitIncludes">
                        <div class="row complect products">
                            <?foreach ($object->getSubgoods() as $subgood):?>
                            <div class="col-md-3 col-sm-6">
                                <div class="complect-item product-item">
<!--                                    <a href="#" class="btn btn-link btn-block remove-complect-item hidden" toggle-on-edit-complect>Удалить</a>-->
                                    <a href="<?=$subgood->getGood()->getPath()?>" class="img-cover" style="background-image: url(<?=$subgood->getGood()->getFirstPrimaryImage()->getImage('260x150')?>);"></a>
                                    <div class="product-item-details">
                                        <div class="product-name row">
                                            <div class="col-xs-10">
                                                <h4><a href="<?=$subgood->getGood()->getPath()?>"><?=$subgood->getGood()->getName()?></a></h4>
                                            </div>
                                            <div class="col-xs-2">
                                                <span class="pull-right product-count"><?=$subgood->getQuantity()?> шт</span>
                                            </div>
                                        </div>

                                        <table class="table-options"><tbody>
                                        <? foreach( $sizesAndWeight as $size ): ?>
                                        <? if($subgood->getGood()->getPropertyValueById($size->id)->value): ?>
                                        <tr>
                                            <td><label><?=$size->getValue()?>:</label></td>
                                            <td>
                                            <span>
                                                <?=$subgood->getGood()->getPropertyValueById($size->id)->value?>
                                                <?=$subgood->getGood()->getPropertyValueById($size->id)->getMeasure()->shortName?>
                                            </span>
                                            </td>
                                        </tr>
                                        <? endif; ?>
                                        <? endforeach; ?>
                                        </tbody></table>

                                        <div class="row">
                                            <div class="col-lg-6 col-md-12 col-sm-6 col-xs-6">
                                                <div class="product--price">
                                                    <var>
                                                        <?=number_format( $subgood->getGood()->getShowPrice(), 0, ',', ' ' )?>
                                                    </var>
                                                    руб.
                                                </div>
                                            </div>
                                            <div class="col-lg-6 col-md-12 col-sm-6 col-xs-6">
                                                <a href="<?=$subgood->getGood()->getPath()?>" class="btn btn-default pull-right">Подробнее</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <?endforeach?>
                        </div>

                        <div class="well hidden" toggle-on-edit-complect>
                            <div class="row">
                                <div class="col-lg-10 col-md-offset-1">
                                    <form action="" method="POST" class="form-inline" role="form">
                                        <div class="form-group total-cost">
                                            <label>Итоговая стоимость:&nbsp;&nbsp;</label>
                                            <div class="input-group input-group-lg">
                                                <input type="text" disabled class="form-control" id="totalCost" value="151 697">
                                                <div class="input-group-addon">руб.</div>
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-primary btn-lg">Добавить в корзину</button>
                                        <button id="cancelEditComplect" type="button" class="btn btn-danger btn-lg pull-right">Отмена</button>
                                    </form>
                                </div>
                            </div>
                        </div>
<!--                        <p class="text-center">-->
<!--                            <button id="editComplect" type="button" class="btn btn-primary btn-lg">Изменить комплектацию</button>-->
<!--                        </p>-->
                    </div>
                    <div role="tabpanel" class="tab-pane" id="productDescription">
                        <?=$object->getText()?>
                    </div>
                </div>
                <?endif?>

            </div>
        </section>
        <?endif?>

        <?if($otherGoodsOfSeriaAndCategory->count()):?>
        <section class="product-catalog">
            <h3 class="text-center">Похожие товары</h3>
            <div class="row products">
                <?foreach ($otherGoodsOfSeriaAndCategory as $object):?>
                <?$this->setContent('object', $object)->includeTemplate('catalog/catalogListItem')?>
                <?endforeach?>
            </div>
<!--            <div class="text-center">-->
<!--                <button type="button" class="btn btn-primary btn-lg">Все комплекты</button>-->
<!--            </div>-->
<!--            <br>-->
        </section>
        <?endif?>

    </section>

</main>

<?$this->includeTemplate('footer')?>