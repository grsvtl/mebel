<div class="shopcartContent" xmlns="http://www.w3.org/1999/html">

    <link href="/css/fabrikalerom.ru/content/shopcart.css" rel="stylesheet">
    <script type="text/javascript" src="/js/fabrikaLerom/shopcartFunctions.js"></script>

    <?if($this->isGoodsInShopcart()):?>
    <div class="table-card">
        <table class="card">
            <thead>
                <tr>
                    <td>Фото</td>
                    <td>Название </td>
                    <td>Стоимость</td>
                    <td>Кол-во</td>
                    <td>Сумма</td>
                    <td>Удалить</td>
                </tr>
            </thead>
            <tbody>
            <?foreach($shopcart->getSortedByIndexArray() as $object):?>
            <tr>
                <td class="card-inset-1">
                    <div>
                        <a href="<?=$object->getPath()?>">
                            <img src="<?=$object->getFirstPrimaryImage()->getImage('181x114')?>" alt="">
                        </a>
                    </div>
                </td>
                <td class="card-inset-2">
                    <div>
                        <? $obj = $this->getObject($object->getObjectClass(), $object->getObjectId()) ?>
                        <? $dimensions = $this->getController('Catalog')->getObjectPropertiesListByAlias('sizesAndWeight', $obj, 3) ?>

                        <a href="<?=$object->getPath()?>"><?=$object->getName()?></a>

                        <?if($object->hasColor()):?>
                        <br>
                        Цвет: <?=$object->getColorParameter()->getValue()?>
                        <?endif?>

                        <? if($dimensions): ?>
                            <? $dimension = ''; ?>
                            <? $i=1; foreach($dimensions as $parameter):?>
                            <? $dimension = $dimension . $parameter['name']; ?>
                            <? if (count($dimensions)==$i) { $dimension = $dimension . ' '.$parameter['measure']; } else { $dimension = $dimension . ' x '; } ?>
                            <? $i++; endforeach?>
                            <strong>Размер (ш.г.в.):</strong>
                            <span><?=$dimension?></span>
                        <? endif ?>
                    </div>
                </td>
                <td class="card-inset-3">
                    <div>
                        <span><?=number_format( $object->getShowPrice(), 0, ',', ' ' )?> ₽</span>
                    </div>
                </td>
                <td class="card-inset-4">
                    <div>
                        <span class="itemQuantity">1</span>
                        <button class="btn btn-primary plusQuantity changeQuantity" <?= $object->getQuantity()==1 ? 'disabled="disabled"' : ''?>
                            data-goodId="<?=$object->id?>"
                            data-goodClass="<?=$object->getClass()?>"
                            data-goodCode="<?=$object->getCode()?>"
                            data-quantity="<?=$object->getQuantity() - 1?>"
                            data-goodColorId="<?=$object->hasColor() ? $object->getObjectColor() : ''?>"
                        >-</button>
                        <span class="shopcartItemQnt"><?=$object->getQuantity()?></span>
                        <button class="btn btn-primary minusQuantity changeQuantity"
                            data-goodId="<?=$object->id?>"
                            data-goodClass="<?=$object->getClass()?>"
                            data-goodCode="<?=$object->getCode()?>"
                            data-quantity="<?=$object->getQuantity() + 1?>"
                            data-goodColorId="<?=$object->hasColor() ? $object->getObjectColor() : ''?>"
                        >+</button>
                    </div>
                </td>
                <td class="card-inset-5">
                    <div>
                        <?=number_format( $object->getTotalPrice(), 0, ',', ' ' )?> ₽
                    </div>
                </td>
                <td class="card-inset-6">
                    <div class="removeFromShopcart" data-goodId="<?=$object->id?>" data-goodClass="<?=$object->getClass()?>" data-goodCode="<?=$object->getCode()?>">
                        <span>
                            <img src="/images/fabrikaLerom/close-card.svg" alt="">
                        </span>
                    </div>
                </td>
            </tr>
            <?endforeach?>

            </tbody>
        </table>
    </div>

    <div class="form-cargo">
        <h3 class="text-center">Оформить заказ</h3>
        <p class="text-f-c">01. Выберите тип получения товара. </p>
        <div class="button-block">
            <ul class="nav">
                <li>
                    <a href="#sam" class="btn samovyvoz" data-toggle="tab">
                        <?$this->includeTemplate('shopcart/pickupImageSvg')?>
                        Самовывоз
                    </a>
                </li>
                <li>
                    <a href="#vyv" class="btn vyvoz" data-toggle="tab">
                        <?$this->includeTemplate('shopcart/shippingImageSvg')?>
                        Доставка
                    </a>
                </li>
            </ul>
        </div>
        <div class="tab-content cargo-content">
            <div class="tab-pane samovyvoz" id="sam">
                <div class="address-sam">
                    <p><span>Адрес нашего магазина: </span>Калуга, ул. Ленина 27</p>
                    <p><span>Телефон для справок: </span>+7 (495) 226-44-34</p>

                </div>
                <p class="text-f-c">02. Заполните форму заявки</p>
                <div class="checked-clock">
                    <div class="form-group">
                        <label for="familyInput" class="col-sm-3 control-label">Фамилия</label>
                        <div class="col-sm-9">
                            <input type="text" data-name="family" data-namedefault="s1" name="s1" class="form-control" id="familyInput" placeholder="Фамилия">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="nameInput" class="col-sm-3 control-label">Имя</label>
                        <div class="col-sm-9">
                            <input type="text" data-name="name" data-namedefault="s2" name="s2" class="form-control" id="nameInput" placeholder="Имя">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="parentNameInput" class="col-sm-3 control-label">Отчество</label>
                        <div class="col-sm-9">
                            <input type="text" data-name="parentName" data-namedefault="s3" name="s3" class="form-control" id="parentNameInput" placeholder="Отчество">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="phoneInput" class="col-sm-3 control-label">Телефон</label>
                        <div class="col-sm-9">
                            <input type="text" data-name="phone" data-namedefault="s4" name="s4" class="form-control" id="phoneInput" placeholder="Телефон">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="emailInput" class="col-sm-3 control-label">Email</label>
                        <div class="col-sm-9">
                            <input type="text" data-name="email" data-namedefault="s5" name="s5" class="form-control" id="emailInput" placeholder="Email">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="infoInput" class="col-sm-3 control-label">Комментарий</label>
                        <div class="col-sm-9">
                            <textarea data-name="info" data-namedefault="s6" name="info" class="form-control" rows="3" id="infoInput"></textarea>
                        </div>
                    </div>
                </div>
                <div class="button-center-bl">
                    <button class="of-order btn sendOrderGetSuccessBlock">Оформить заказ</button>
                    <button class="ot-order btn cancelOrder">Отменить заказ</button>
                </div>
            </div>
            <div class="tab-pane vyvoz" id="vyv">
                <p class="text-f-c">02. Выберите способ поднятия на этаж</p>
                <div class="checked-clock">
                    <div class="radio">
                        <label>
                            <input type="radio" name="lift" id="liftBySelf" checked="">
                            <label for="liftBySelf">Не нужно (Сами поднимаем)</label>
                        </label>
                    </div>
                    <div class="radio">
                        <label>
                            <input type="radio" name="lift" id="liftWithoutLift">
                            <label for="liftWithoutLift">Заказываем подъём (нет лифта)</label>
                        </label>
                    </div>
                    <div class="radio">
                        <label>
                            <input type="radio" name="lift" id="liftWithSmallLift">
                            <label for="liftWithSmallLift">Заказываем подъём (пассажирский лифт)</label>
                        </label>
                    </div>
                    <div class="radio">
                        <label>
                            <input type="radio" name="lift" id="liftWithBigLift">
                            <label for="liftWithBigLift">Заказываем подъём (грузовой лифт)</label>
                        </label>
                    </div>
                </div>
                <p class="text-f-c">03. Заполните форму заявки</p>
                <div class="checked-clock">
                    <div class="form-group">
                        <label for="familyInput" class="col-sm-3 control-label">Фамилия</label>
                        <div class="col-sm-9">
                            <input name="v1" data-namedefault="v1" data-name="family" type="text" class="form-control" id="familyInput" placeholder="Фамилия">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="nameInput" class="col-sm-3 control-label">Имя</label>
                        <div class="col-sm-9">
                            <input name="v2" data-namedefault="v2" data-name="name" type="text" class="form-control" id="nameInput" placeholder="Имя">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="parentNameInput" class="col-sm-3 control-label">Отчество</label>
                        <div class="col-sm-9">
                            <input name="v3" data-namedefault="v3" data-name="parentName" type="text" class="form-control" id="parentNameInput" placeholder="Отчество">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="phoneInput" class="col-sm-3 control-label">Телефон</label>
                        <div class="col-sm-9">
                            <input name="v4" data-namedefault="v4" data-name="phone" type="text" class="form-control" id="phoneInput" placeholder="Телефон">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="emailInput" class="col-sm-3 control-label">Email</label>
                        <div class="col-sm-9">
                            <input name="v5" data-namedefault="v5" data-name="email" type="text" class="form-control" id="emailInput" placeholder="Email">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="infoInput" class="col-sm-3 control-label">Комментарий</label>
                        <div class="col-sm-9">
                            <textarea name="v6" data-namedefault="v6" data-name="info" class="form-control" rows="3" id="infoInput"></textarea>
                        </div>
                    </div>
                </div>
                <p class="text-f-c">Адрес доставки</p>
                <div class="checked-clock">
                    <div class="form-group">
                        <label for="indexInput" class="col-sm-3 control-label">Индекс</label>
                        <div class="col-sm-9">
                            <input type="text" name="v7" data-namedefault="v7" data-name="index" class="form-control" id="indexInput" placeholder="Индекс">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="regionInput" class="col-sm-3 control-label">Область</label>
                        <div class="col-sm-9">
                            <input type="text" name="v8" data-namedefault="v8" data-name="region" class="form-control" id="regionInput" placeholder="Область">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="cityInput" class="col-sm-3 control-label">Город</label>
                        <div class="col-sm-9">
                            <input type="text" name="v9" data-namedefault="v9" data-name="city" class="form-control" id="cityInput" placeholder="Город">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="streetInput" class="col-sm-3 control-label">Улица</label>
                        <div class="col-sm-9">
                            <input type="text" name="v10" data-namedefault="v10" data-name="street" class="form-control" id="streetInput" placeholder="Улица">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="blockInput" class="col-sm-3 control-label">Корпус</label>
                        <div class="col-sm-9">
                            <input type="text" name="v11" data-namedefault="v11" data-name="block" class="form-control" id="blockInput" placeholder="Корпус">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="homeInput" class="col-sm-3 control-label">Дом</label>
                        <div class="col-sm-9">
                            <input type="text" name="v12" data-namedefault="v12" data-name="home" class="form-control" id="homeInput" placeholder="Дом">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="flatInput" class="col-sm-3 control-label">Квартира</label>
                        <div class="col-sm-9">
                            <input type="text" name="v13" data-namedefault="v13" data-name="flat" class="form-control" id="flatInput" placeholder="Квартира">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="flatInput" class="col-sm-3 control-label">Способ оплаты</label>
                        <div class="col-sm-9">
                            <select class="form-control" name="paymentType">
                                <option>Наличные</option>
                                <option>Банковский перевод</option>
                                <option>Кредитная карта</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="button-center-bl">
                    <button type="submit" class="of-order btn sendOrderGetSuccessBlock">Оформить заказ</button>
                    <button class="ot-order btn cancelOrder">Отменить заказ</button>
                </div>
            </div>
        </div>
    </div>

    <?else:?>
    <div class="emptyShopcart">
        Ваша корзина пуста
    </div>
    <?endif?>

</div>