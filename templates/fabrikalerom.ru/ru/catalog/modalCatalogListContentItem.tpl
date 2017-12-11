<div class="modal fade" id="objectModal<?=$object->id?>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel-<?=$object->id?>" aria-hidden="true">
    <div class="modal-dialog good-block">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel-<?=$object->id?>"><?=$object->getName()?></h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-8 banner-photo-slide">
                        <div id="foto-banner-<?=$object->id?>" class="carousel slide" data-ride="carousel">
                            <div class="carousel-inner">
                                <? $i = 0; foreach($object->getImagesByObjectId() as $image ): ?>
                                <div class="item slide-foto <?=$i == 0 ? 'active' : ''?>">
                                    <img src="<?=$image->getUserImage('502x315', 'watermarkPng')?>" alt="">
                                </div>
                                <? $i++; endforeach; ?>
                            </div>
                            <ol class="carousel-indicators">
                                <? $i = 0; foreach($object->getImagesByObjectId() as $image ): ?>
                                <li data-target="#foto-banner-<?=$object->id?>" data-slide-to="<?=$i?>" class="prev-photo <?= $i == 0 ? 'active' : ''?>">
                                    <img src="<?=$image->getUserImage('113x71', 'watermarkPng')?>" alt="">
                                </li>
                                <? $i++; endforeach ?>
                            </ol>
                        </div>
                    </div>
                    <div class="col-md-4 info-offer">
                        <div class="price-main">
                            <div class="price-inset">
                                <span>Цена</span>
                                <strong><?=number_format( $object->getShowPrice(), 0, ',', ' ' )?> ₽</strong>
                            </div>
                        </div>
                        <div class="add-to-card addToShopcart" data-objectId="<?=$object->id?>" data-objectClass="<?=$object->getClass()?>">
                            <div class="add-to-card-btn btn">
                                <?$this->includeTemplate('catalog/shopcartImage')?>
                                <span class="add-t-c">Добавить в корзину</span>
                                <span class="del-t-c removeFromShopcart" data-goodId="<?=$object->id?>" data-goodClass="<?=$object->getClass()?>" data-goodCode="<?=$object->getCode()?>">Удалить из корзины</span>
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
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
                <!--<button type="button" class="btn btn-primary">Сохранить изменения</button>-->
            </div>
        </div>
    </div>
</div>