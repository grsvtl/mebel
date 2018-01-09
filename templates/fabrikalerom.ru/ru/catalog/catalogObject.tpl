<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

<link href="/css/fabrikalerom.ru/content/catalogObject.css" rel="stylesheet">
<script type="text/javascript" src="/js/fabrikaLerom/catalogObject.js"></script>
<script src="/js/fabrikaLerom/colorChoose.js"></script>

    <script src="/js/plugins/lightbox/lightbox.js"></script>
    <link href="/js/plugins/lightbox/css/lightbox.css" rel="stylesheet">

<main>
    <div class="container main-content">
        <?$this->getController('Catalog')->getLeftMenu()?>
        <div class="right-block">
            <?$this->includeBreadcrumbs()?>
            <h1><?=$object->getName()?></h1>
            <div class="row offer-block">
                <div class="col-md-8 banner-photo-slide">
                    <div id="foto-banner" class="carousel slide" data-ride="carousel">
                        <div class="carousel-inner">
                            <? $i = 0; foreach($object->getImagesByObjectId() as $image ): ?>
                            <div class="item slide-foto <?=$i == 0 ? 'active' : ''?>">
                                <a data-href="<?=$image->getUserImage('0x0', 'watermarkPng')?>" class="bigImage"
                                   href="<?=$image->getUserImage('0x0', 'watermarkPng')?>"
                                   data-lightbox="set"
                                >
                                    <img src="<?=$image->getUserImage('543x340', 'watermarkPng')?>" alt="">
                                </a>
                            </div>
                            <? $i++; endforeach; ?>
                        </div>
                        <ol class="carousel-indicators">
                            <? $i = 0; foreach($object->getImagesByObjectId() as $image ): ?>
                            <li data-target="#foto-banner" data-slide-to="<?=$i?>" class="prev-photo <?= $i == 0 ? 'active' : ''?>">
                                <img src="<?=$image->getUserImage('123x77', 'watermarkPng')?>" alt="">
                            </li>
                            <? $i++; endforeach ?>
                        </ol>
                    </div>
                </div>
                <div class="col-md-4 info-offer">

                    <?if($this->getController('Authorization')->isAdminAuthorizated()):?>
                        <a class="adminShow" href="<?=$object->getAdminPath()?>" target="_blank" title="Эта ссылка видна только авторизованному в админской части пользователю">
                            Редактировать [id = <?=$object->id?>]
                        </a>
                    <?endif?>

                    <div class="price-main">
                        <div class="price-inset">
                            <span>Цена</span>
                            <strong><?=number_format( $object->getShowPrice(), 0, ',', ' ' )?> ₽</strong>
                        </div>
                        <div class="count-inset">
                            <span>Кол-во</span>
                            <select name="productQuantity" class="productQuantitySelect">
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                            </select>
                            <span class="itemQuantity byeMoreQuantity" data-objectId="<?=$object->id?>">1</span>
                        </div>
                    </div>
                    <div
                            class="add-to-card addToShopcart"
                            data-objectId="<?=$object->id?>"
                            data-objectClass="<?=$object->getClass()?>"
                            data-objectColor=""
                    >
                        <div class="add-to-card-btn btn">
                            <?$this->includeTemplate('catalog/shopcartImage')?>
                            <span class="add-t-c">Добавить в корзину</span>
                        </div>
                    </div>

                    <div class="alert alert-success text-center okAddShopcartMessage">
                        Товар добавлен в корзину
                    </div>

                    <?$colors = $this->getColorParametersArrayByObjects(array($object) );?>
                    <?if(!empty($colors)):?>
                    <div class="color-block">
                        <span class="name-select-color">Цвета:</span>
                        <div class="select-main-block">
                            <div class="back-fon-select"></div>
                            <div class="select-block-inset check-select">
                                <div class="name-select">Выбрать цвет</div>
                                <div class="list-select">
                                    <?foreach ($colors as $color):?>
                                    <div class="line-select">
                                        <input type="radio" name="cheked-b" id="check-a-<?=$color['id']?>" class="hidden input-select" >
                                        <label for="check-a-<?=$color['id']?>" class="label-select">
                                            <img src="/images/fabrikaLerom/oval6.png" alt="">
                                            <span class="choosedColor" data-colorId="<?=$color['id']?>"><?=$color['name']?></span>
                                        </label>
                                    </div>
                                    <?endforeach?>
                                </div>
                            </div>
                        </div>
                    </div>
                    <?endif;?>

                    <? $labels = ['Материалы:']; $i = 0; foreach( [$materialArray] as $array ): ?>
                    <? if($array): ?>
                    <div class="info-inset-block">
                        <span><?=$labels[$i]?></span>
                        <p>
                            <? $j = 1; foreach ($array as $params):?>
                            <?= $j == count($array) ? $this->mb_ucfirst($params['name']) : $this->mb_ucfirst($params['name']) . ','?>
                            <? $j++; endforeach?>
                        </p>
                    </div>
                    <? endif ?>
                    <? $i++; endforeach; ?>

                    <? if($dimensions): ?>
                    <div class="info-inset-block">
                        <? $dimension = ''; ?>
                        <? $i=1; foreach($dimensions as $parameter):?>
                            <? $dimension = $dimension . $parameter['name']; ?>
                            <? if (count($dimensions)==$i) { $dimension = $dimension . ' '.$parameter['measure']; } else { $dimension = $dimension . ' x '; } ?>
                            <? $i++; endforeach?>
                        <span>Размер (ш.г.в.):</span>
                        <p><?=$dimension?></p>
                    </div>
                    <? endif ?>

                    <?if (!empty($weightAndSizeArray)):?>
                    <div class="info-inset-block">
                        <span>Вес и объем:</span>
                        <p>
                            <?=$weightAndSizeArray[0]['name']?> <?=$weightAndSizeArray[0]['measure']?>
                            <?if(isset($weightAndSizeArray[1])):?>
                            |
                            <?=$weightAndSizeArray[1]['name']?> <?=$weightAndSizeArray[1]['measure']?>
                            <?endif;?>
                        </p>

                    </div>
                    <?endif;?>

                    <?if (!empty($subGoodsString)):?>
                    <div class="info-inset-block">
                        <span>Состав набора:</span>
                        <p><?=$subGoodsString?></p>
                    </div>
                    <?endif;?>

                </div>
                <div class="clear"></div>

                <div class="complect-block">


                    <?if(!empty($subGoodsArray)):?>
                    <h3>Состав комплека</h3>
                    <?foreach($subGoodsArray as $subGood):?>
                    <div class="col-md-4 col-sm-6 col-xs-6">
                        <div class="container-offer">
                            <a href="" class="img-c-o">
                                <img src="<?=$subGood->getGood()->getFirstPrimaryImage()->getImage('254x170')?>" alt="">
                            </a>
                            <div class="body-offer">
                                <a href="<?=$subGood->getGood()->getPath()?>" class="link-c-o"><?=$subGood->getGood()->getName()?></a>
                                <span class="type-offer"><?=$this->getCategoryModyName($object->getCategory())?></span>
                                <ul>
                                    <?$sizesAndWeight = $this->getObjectPropertiesListByAlias('sizesAndWeight', $subGood->getGood(), 3);?>
                                    <? if($sizesAndWeight): ?>
                                        <? foreach( $sizesAndWeight as $size ): ?>
                                            <? if($size['name']): ?>
                                                <li>
                                                    <strong><?=$size['name']?> <?=$size['measure']?></strong>
                                                    <span><?=$size['value']?>:</span>
                                                </li>
                                            <? endif; ?>
                                        <? endforeach; ?>
                                    <? endif; ?>
                                </ul>
                                <div class="price-offer-block complect-include">
                                    <a href="<?=$subGood->getGood()->getPath()?>" class="more-offer">Подробнее</a>
                                </div>

                            </div>
                        </div>
                    </div>
                    <?endforeach;?>
                    <div class="clear"></div>
                    <?endif?>

                    <?$otherSubGoods = $this->getOtherSubGoodsByCategoryArray($category,$object);?>
                    <?if(!empty($otherSubGoods)):?>
                    <h3>Другие модули этой коллекции</h3>
                    <?foreach($otherSubGoods as $otherItem):?>
                    <div class="col-md-4 col-sm-6 col-xs-6">
                        <?$this->getController('Catalog')->getCatalogListContentItemBlock($otherItem)?>
                    </div>
                    <?endforeach?>
                    <?endif?>

                    <div class="clear"></div>
                </div>
            </div>
        </div>
    </div>

    <div class="modalsBlock">

    </div>
</main>

<?$this->includeTemplate('footer')?>