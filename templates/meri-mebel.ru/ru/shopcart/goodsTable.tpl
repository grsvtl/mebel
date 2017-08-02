<div class="shopcartContent">

    <script src="/js/shopcart/shopcartDeliveryChoose.js"></script>

    <?if($this->isGoodsInShopcart()):?>
    <div class="panel panel-default">
        <table class="table table-basket">
            <thead>
                <tr>
                    <td class="col-photo">Фото</td>
                    <td class="col-name">Наименование</td>
                    <td class="col-price">Цена</td>
                    <td class="col-count">Количество</td>
                    <td class="col-total-price">Итоговая стоимость</td>
                    <td class="col-remove"></td>
                </tr>
            </thead>
            <tbody>

                <?foreach($shopcart->getSortedByIndexArray() as $object):?>

                <tr class="row-product">
                    <td width="150" class="col-photo"><div class="img-cover" style="background-image: url(<?=$object->getFirstPrimaryImage()->getImage('146x80', 'watermark')?>);"></div></td>
                    <td class="col-name">
                        <h5 class="text-uppercase"><?=$object->getName()?></h5>
                        <small>Товар</small>
                    </td>
                    <td class="col-price is--price">
                        <?=number_format( $object->getShowPrice(), 0, ',', ' ' )?>
                        <span class="glyphicon glyphicon-ruble"></span>
                    </td>
                    <td class="col-price is--price">
                        <button
                            class="btn btn-warning btn-minus changeQuantity" <?= $object->getQuantity()==1 ? 'disabled="disabled"\\' : ''?>
                            data-goodId="<?=$object->id?>"
                            data-goodClass="<?=$object->getClass()?>"
                            data-goodCode="<?=$object->getCode()?>"
                            data-quantity="<?=$object->getQuantity() - 1?>"
                        >
                            <span class="glyphicon glyphicon-minus"></span>
                        </button>
                        <?=$object->getQuantity()?>
                        <button
                            class="btn btn-warning btn-plus changeQuantity"
                            data-goodId="<?=$object->id?>"
                            data-goodClass="<?=$object->getClass()?>"
                            data-goodCode="<?=$object->getCode()?>"
                            data-quantity="<?=$object->getQuantity() + 1?>"
                        >
                            <span class="glyphicon glyphicon-plus"></span>
                        </button>
                    </td>
                    <td class="col-total-price is--price">
                        <?=number_format( $object->getTotalPrice(), 0, ',', ' ' )?>
                        <span class="glyphicon glyphicon-ruble"></span>
                    </td>
                    <td class="col-remove">
                        <button
                            class="btn btn-danger btn-remove removeFromShopcart"
                            data-goodId="<?=$object->id?>"
                            data-goodClass="<?=$object->getClass()?>"
                            data-goodCode="<?=$object->getCode()?>"
                        >
                            <span class="glyphicon glyphicon-remove"></span>
                        </button>
                    </td>
                </tr>
                <?if($object->getSubgoods()->count()):?>
                <tr class="row-product-complect-details">
                    <td colspan="6">
                        <a role="button" class="btn btn-outline" data-toggle="collapse" href="#complectDetailsContent-<?=$object->id?>">Состав комлекта</a>
                        <div id="complectDetailsContent-<?=$object->id?>" class="collapse product-complect-details">
                            <h4>В комплект входит</h4>
                            <table><tbody>
                                <?foreach ($object->getSubgoods() as $subGood):?>
                                <tr>
                                    <td width="150">
                                        <div class="img-cover" style="background-image: url(<?=$subGood->getGood()->getFirstPrimaryImage()->getUserImage('150x80', 'watermark')?>);"></div>
                                    </td>
                                    <td>
                                        <h5><?=$subGood->getGood()->getName()?></h5>
                                        <small>Кол-во — <?=$subGood->getQuantity()?> шт.</small>
                                    </td>
                                </tr>
                                <?endforeach;?>
                            </tbody></table>
                        </div>
                    </td>
                </tr>
                <?endif?>

                <?endforeach;?>

            </tbody>

            <tfoot class="text-right">
            <tr>
                <td colspan="4">Итоговая стоимость: </td>
                <td class="is--price">
                    <?=number_format( $shopcart->getTotalPrice(), 0, ',', ' ' )?>
                    <span class="glyphicon glyphicon-ruble"></span>
                </td>
                <td></td>
            </tr>
            </tfoot>
        </table>
    </div>

    <br>
    <div class="text-center">
        <a role="button" class="btn btn-outline text-uppercase" data-toggle="collapse" href="#drawingUpOfAnOrder">Оформление заказа</a>
        <div id="drawingUpOfAnOrder" class="collapse">
            <br>
            <h3 class="text-uppercase">Оформление заказа</h3>
            <br>
            <h4>Тип доставки</h4>
            <div class="btn-group" data-toggle="buttons">
                <label class="btn btn-outline active">
                    <input type="radio" name="needDelivery" id="option1" value="false" autocomplete="off" checked><span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;Самовывоз
                </label>
                <label class="btn btn-outline">
                    <input type="radio" name="needDelivery" id="option2" value="true" autocomplete="off"><span class="glyphicon glyphicon-home"></span>&nbsp;&nbsp;Доставка
                </label>
            </div>
            <br>
            <br>
            <div class="row">
                <div class="col-md-7 col-sm-8 col-md-offset-2 col-sm-offset-2">
                    <form action="" method="POST" class="form-horizontal form-order" role="form">
                        <div class="delivery-block collapse">
                            <div class="row">
                                <div class="col-md-2"></div>
                                <div class="col-md-10">
                                    <h4>Подъем на этаж</h4>
                                </div>
                            </div>
                            <ul class="list-unstyled text-left the-rise-of-the-floor">
                                <li>
                                    <div class="radio">
                                        <label>
                                            <input type="radio" id="liftBySelf" name="lift" checked="">
                                            <label for="liftBySelf">Не нужно (Сами поднимаем)</label>
                                        </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="radio">
                                        <label>
                                            <input type="radio" id="liftWithoutLift" name="lift">
                                            <label for="liftWithoutLift">Заказываем подъём (нет лифта)</label>
                                        </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="radio">
                                        <label>
                                            <input type="radio" id="liftWithSmallLift" name="lift">
                                            <label for="liftWithSmallLift">Заказываем подъём (пассажирский лифт)</label>
                                        </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="radio">
                                        <label>
                                            <input type="radio" id="liftWithBigLift" name="lift">
                                            <label for="liftWithBigLift">Заказываем подъём (грузовой лифт)</label>
                                        </label>
                                    </div>
                                </li>
                            </ul>
                            <br>
                            <br>
                        </div>
                        <div id="personalInfo">
                            <div class="row">
                                <div class="col-md-2"></div>
                                <div class="col-md-10">
                                    <h4>Форма заявки</h4>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 is-label">Фамилия</div>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="family">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 is-label">Имя</div>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="name">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 is-label">Отчество</div>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="parentName">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 is-label">Телефон</div>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="phone" placeholder="+7 (400) 45 85 692">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 is-label">E-mail</div>
                                <div class="col-sm-9">
                                    <input type="email" class="form-control" name="email">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 is-label">Другая информация</div>
                                <div class="col-sm-9">
                                    <textarea class="form-control" name="info"></textarea>
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="collapse delivery-block">
                            <div class="row">
                                <div class="col-md-2"></div>
                                <div class="col-md-10">
                                    <h4>Адрес доставки</h4>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 is-label">Индекс</div>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="index">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 is-label">Область</div>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="region">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 is-label">Город</div>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="city">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 is-label">Улица</div>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="street">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 is-label">Корпус</div>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="block">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 is-label">Дом</div>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="home">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 is-label">Квартира</div>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="flat">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 is-label">Способ оплаты</div>
                                <div class="col-sm-9">
                                    <select class="form-control" name="paymentType">
                                        <option>Наличные</option>
                                        <option>Банковский перевод</option>
                                        <option>Кредитная карта</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <br>
                        <button type="button" class="btn btn-info btn-lg sendOrderGetSuccessBlock"
                                data-dataLayerPushEvent="event_zakaz"
                        >
                            Оформить заказ
                        </button>
                        <br>
                        <br>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <?else:?>
    <div class="yourEmptyShopcart">Ваша корзина пуста</div>
    <?endif?>
</div>