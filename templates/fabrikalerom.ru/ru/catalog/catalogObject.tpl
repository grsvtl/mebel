<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

<link href="/css/fabrikalerom.ru/content/catalogObject.css" rel="stylesheet">
<script type="text/javascript" src="/js/fabrikaLerom/catalogObject.js"></script>

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
                                <a data-href="<?=$image->getUserImage('0x0', 'watermarkPng')?>" class="bigImage">
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
                    <div class="add-to-card addToShopcart" data-objectId="<?=$object->id?>" data-objectClass="<?=$object->getClass()?>">
                        <div class="add-to-card-btn btn">
                            <?$this->includeTemplate('catalog/shopcartImage')?>
                            <span class="add-t-c">Добавить в корзину</span>
                        </div>
                    </div>
                    <div class="color-block">
                    </div>
                    <!--<div class="color-block">
                        <span class="name-select-color">Цвета</span>
                        <div class="select-main-block">
                            <div class="back-fon-select"></div>
                            <div class="select-block-inset">
                                <div class="name-select">Выбрать цвет</div>
                                <div class="list-select">
                                    <div class="line-select">
                                        <input type="radio" name="cheked-b" id="check-a-1" class="hidden input-select">
                                        <label for="check-a-1" class="label-select">
                                            <img src="img/Oval 6.png" alt=""> <span>Цвет 1</span>
                                        </label>
                                    </div>
                                    <div class="line-select">
                                        <input type="radio" name="cheked-b" id="check-a-2" class="hidden input-select">
                                        <label for="check-a-2" class="label-select">
                                            <img src="img/Oval 6.png" alt=""> <span>Цвет 2</span>
                                        </label>
                                    </div>
                                    <div class="line-select">
                                        <input type="radio" name="cheked-b" id="check-a-3" class="hidden input-select">
                                        <label for="check-a-3" class="label-select">
                                            <img src="img/Oval 6.png" alt=""> <span>Цвет 3</span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>-->

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

                    <? if($hasOtherProperties): ?>
                    <?for ($i = 2; $i <= count($sizesAndWeight) - 1; $i++):?>
                    <div class="info-inset-block">
                        <span><?=$sizesAndWeight[$i]['value']?>:</span>
                        <p><?=$sizesAndWeight[$i]['name']?> <?=$sizesAndWeight[$i]['measure']?></p>
                    </div>
                    <? endfor ?>
                    <? endif ?>

                    <? $labels = ['Материал:','Корпус:','Фасад:']; $i = 0; foreach( [$materialArray, $corpusArray, $fasadArray] as $array ): ?>
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

                </div>
                <div class="clear"></div>

                <div class="complect-block">
                    <h3>Другие модули </h3>
                    <?foreach($this->getOtherGoodsByCategory($category,$object) as $otherItem):?>
                    <div class="col-md-4 col-sm-6 col-xs-6">
                        <?$this->getController('Catalog')->getCatalogListContentItemBlock($otherItem)?>
                    </div>
                    <?endforeach?>
                    <div class="clear"></div>
                </div>
            </div>
        </div>
    </div>

    <div class="modalsBlock">

    </div>
</main>

<?$this->includeTemplate('footer')?>