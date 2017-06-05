<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>
        <main id="main">
            <div class="container good-page">
                <br>
                <?$this->includeBreadcrumbs()?>
                <?if($this->getController('Authorization')->isAdminAuthorizated()):?>
                    <a
                        class="adminShow"
                        href="<?=$object->getAdminPath()?>"
                        target="_blank" title="Эта ссылка видна только авторизованному в админской части пользователю"
                        style="position: relative"
                    >
                        Редактировать [id = <?=$object->id?>]
                    </a>
                <?endif?>
                <h1><?=$object->getName()?></h1>
                <br>
                <div class="row">
                    <div class="col-lg-8 col-md-7 col-sm-6">
                        <div id="productCarousel" class="carousel slide" data-ride="carousel">

                            <?$this->includeTemplate('catalog/bands/bandBigBlock')?>

                            <?$images = $object->getImagesByCategoryAndStatus('1,2', 1);?>


                            <link rel="stylesheet" type="text/css" href="/js/extensions/slick/slick.css"/>
                            <link rel="stylesheet" type="text/css" href="/js/extensions/slick/slick-theme.css"/>
                            <script src="/js/extensions/slick/slick.js" type="text/javascript" charset="utf-8"></script>
                            <script src="/js/slick/catalogObjectSlick.js" type="text/javascript" charset="utf-8"></script>
                            <script type="text/javascript" src="/js/plugins/gallery/gallery.js"></script>
                            <input type="hidden" value="5" class="slick-slidesToShow">
                            <div class="slider slider-for">
                                <div class="item">
                                    <a data-href="<?=$object->getFirstPrimaryImage()->getUserImage('0x0', 'watermarkPng')?>" class="bigImage">
                                        <img src="<?=$object->getFirstPrimaryImage()->getUserImage('750x376', 'watermark')?>">
                                    </a>
                                </div>
                                <?foreach($images as $image ): ?>
                                <div class="item">
                                    <a data-href="<?=$image->getUserImage('0x0', 'watermarkPng')?>" class="bigImage">
                                        <img src="<?=$image->getUserImage('750x376', 'watermark')?>">
                                    </a>
                                </div>
                                <? endforeach; ?>
                            </div>
                            <div class="slider slider-nav">
                                <div class="item-small">
                                    <img src="<?=$object->getFirstPrimaryImage()->getUserImage('100x60', 'watermark')?>">
                                </div>
                                <?foreach($images as $image ): ?>
                                <div class="item-small">
                                    <img src="<?=$image->getUserImage('100x60', 'watermark')?>">
                                </div>
                                <? endforeach; ?>
                            </div>

                        </div>
                    </div>
                    <div class="col-lg-4 col-md-5 col-sm-6 co product-info">
                        <?if ($object->getOffer()):?>
                            <span class="offer_only">Только в период акции!</span>
                        <?endif;?>
                        <div class="product-info--price">
                            <?=number_format( $object->getShowPrice(), 0, ',', ' ' )?>
                            <span class="glyphicon glyphicon-ruble"></span>
                            <?if ($object->getOffer()):?>
                                <span class="old_price">
                                <?=number_format( $object->getShowPrice(), 0, ',', ' ' )?>
                                    <span class="glyphicon glyphicon-ruble"></span>
                            </span>
                            <?endif;?>
                        </div>
                        <div class="product-info-buying">
                            <button
                                type="button" class="btn btn-primary btn-md addToShopcart"
                                data-objectId="<?=$object->id?>" data-objectClass="<?=$object->getClass()?>"
                                data-dataLayerPushEvent="event_addcart"
                            >
                                В корзину
                            </button>
                            <button
                                type="button"
                                class="btn btn-default btn-md orderOneClickModalShow"
                                data-objectId="<?=$object->id?>"
                                title="Купить в 1 клик - <?=$object->getName()?>"
                            >
                                Купить в 1 клик
                            </button>
                        </div>
                        <br>
                        <h4 class="text-dark">Характеристики</h4>
                        <ul class="list-unstyled product-info-characteristics">

                            <?if($materialArray):?>
                            <li>
                                <b class="text-dark">Материал:</b>
                                <?$i=1; foreach($materialArray as $material):?>
                                    <?=$material['name']?><?= $i==count($materialArray) ? '' : ', '?>
                                <?$i++; endforeach?>
                            </li>
                            <?endif?>

                            <?if($corpusArray  ||  $fasadArray):?>
                            <li class="product-info-surfaces">
                                <b class="text-dark">Цвет:</b>&nbsp;
                                <?if($corpusArray):?>
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
                                <?endif?>
                                <?if($fasadArray):?>
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
                                <?endif?>
                            <?endif?>

                            <? foreach( $sizesAndWeight as $size ): ?>
                            <? if($object->getPropertyValueById($size->id)->value): ?>
                            <li>
                                <b class="text-dark"><?=$size->getValue()?>:</b>
                                <?=$object->getPropertyValueById($size->id)->value?> <?=$object->getPropertyValueById($size->id)->getMeasure()->shortName?>
                            </li>
                            <? endif; ?>
                            <? endforeach; ?>
                        </ul>
                    </div>
                </div>

                <br>

                <?if($object->isSubGoodsExists()):?>
                <div class="products-catalog">
                    <p>Все товары комплекта <?=$object->getName()?>:</p>
                    <section class="row products">
                        <?foreach ($object->getSubgoods() as $subgood):?>
                        <div class="col-md-3 col-sm-6">
                            <div class="product-item">
                                <a href="<?=$subgood->getGood()->getPath()?>" class="img-cover" style="background-image: url(<?=$subgood->getGood()->getFirstPrimaryImage()->getUserImage('260x150', 'watermark')?>);"></a>
                                <div class="product-item-details">
                                    <h5><a href="<?=$subgood->getGood()->getPath()?>" class="product--name"><?=$subgood->getGood()->getName()?></a></h5>
                                    <form class="product-item-form">
                                        <?=$subgood->getQuantity()?>&nbsp;&nbsp;шт.
                                    </form>
                                </div>
                            </div>
                        </div>
                        <?endforeach?>
                    </section>
                    <br>
                </div>
                <?endif?>

                <br>

                <?if($otherGoodsOfSeriaAndCategory->count()):?>
                <div class="products-catalog">
                    <p>С этим покупают:</p>
                    <section class="row products">
                        <?foreach ($otherGoodsOfSeriaAndCategory as $object):?>
                        <div class="col-md-3 col-sm-6">
                            <div class="product-item">
                                <a
                                    href="<?=$object->getPath()?>"
                                    class="img-cover"
                                    style="background-image: url(<?=$object->getFirstPrimaryImage()->getUserImage('260x150', 'watermark')?>);"
                                ></a>
                                <div class="product-item-details">
                                    <h5><a href="<?=$object->getPath()?>" class="product--name"><?=$object->getName()?></a></h5>
                                    <div>
                                        <span class="product--price"><?=number_format( $object->getShowPrice(), 0, ',', ' ' )?></span>
                                        <span class="glyphicon glyphicon-ruble"></span>
                                        <a
                                            class="btn btn-default btn-xs pull-right addToShopcart"
                                            data-objectId="<?=$object->id?>" data-objectClass="<?=$object->getClass()?>"
                                            data-dataLayerPushEvent="event_addcart"
                                        >
                                            В корзину
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <?endforeach?>
                    </section>
                    <br>
                    <br>
                </div>
                <?endif?>
            </div>
        </main>
<?$this->includeTemplate('footer')?>