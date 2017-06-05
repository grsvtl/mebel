<div class="shopcartContent">

    <script src="/js/shopcart/shopcartDeliveryChoose.js"></script>

    <?if($this->isGoodsInShopcart()):?>
    <section id="basket" class="panel panel-default">
        <table class="table table-basket table-adaptive">
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
                <tr class="row-product-complect">
                    <td class="col-photo">
                        <div class="img-cover" style="background-image: url(<?=$object->getFirstPrimaryImage()->getImage('154x90')?>);"></div>
                    </td>
                    <td class="col-name">
                        <h4><?=$object->getName()?></h4>
                        <?if($object->getSubgoods()->count()):?>
                        <label>Комплект</label>
                        <div>
                            <button type="button" class="btn btn-info btn-sm text-uppercase" data-toggle="collapse" href="#complectDetailsContent-<?=$object->id?>">Состав комплекта</button>
                        </div>
                        <?endif?>
                    </td>
                    <td class="col-price product--price"><var><?=number_format( $object->getShowPrice(), 0, ',', ' ' )?></var> руб.</td>
                    <td class="product-item-form">
                        <button
                            class="btn btn-warning btn-minus changeQuantity" <?= $object->getQuantity()==1 ? 'disabled="disabled"\\' : ''?>
                            data-goodId="<?=$object->id?>"
                            data-goodClass="<?=$object->getClass()?>"
                            data-goodCode="<?=$object->getCode()?>"
                            data-quantity="<?=$object->getQuantity() - 1?>"
                        >
                            <span class="glyphicon glyphicon-minus"></span>
                        </button>
                        <span class="shopcartItemQnt"><?=$object->getQuantity()?></span>
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
                    <td class="col-total-price product--price"><var><?=number_format( $object->getTotalPrice(), 0, ',', ' ' )?></var> руб.</td>
                    <td class="col-remove">
                        <button
                            class="btn btn-danger btn-remove removeFromShopcart"
                            data-goodId="<?=$object->id?>"
                            data-goodClass="<?=$object->getClass()?>"
                            data-goodCode="<?=$object->getCode()?>"
                        >
                            <span class="glyphicon glyphicon glyphicon-trash"></span><span class="visible-xs-inline">&nbsp;&nbsp;Удалить</span>
                        </button>
                    </td>
                </tr>
                <?if($object->getSubgoods()->count()):?>
                <tr class="row-product-complect-details">
                    <td colspan="6">
                        <div id="complectDetailsContent-<?=$object->id?>" class="collapse product-complect-details">
                            <div class="row complect products">
                                <?foreach ($object->getSubgoods() as $subGood):?>
                                <div class="col-md-3 col-sm-6">
                                    <div class="complect-item product-item">
<!--                                        <a href="#" class="btn btn-link btn-block remove-complect-item"><span class="glyphicon glyphicon glyphicon-trash"></span>&nbsp;&nbsp;Удалить</a>-->
                                        <a href="#" class="img-cover" style="background-image: url(<?=$subGood->getGood()->getFirstPrimaryImage()->getUserImage('250x150')?>);"></a>
                                        <div class="product-item-details">
                                            <div class="product-name row">
                                                <div class="col-xs-10">
                                                    <h4><?=$subGood->getGood()->getName()?></h4>
                                                </div>
                                                <div class="col-xs-2">
                                                    <span class="shopcartComplectQnt"><?=$subGood->getQuantity()?> шт.</span>
                                                </div>
                                            </div>
<!--                                            --><?//$sizesAndWeight = $this->getController('Catalog')->getPropertiesListByAlias('sizesAndWeight');?>
<!--                                            <table class="table-options">-->
<!--                                                <tbody>-->
<!--                                                --><?// foreach( $sizesAndWeight as $size ): ?>
<!--                                                --><?// if($subGood->getGood()->getPropertyValueById($size->id)->value): ?>
<!--                                                    <tr>-->
<!--                                                        <td><label>--><?//=$size->getValue()?><!--:</label></td>-->
<!--                                                        <td>-->
<!--                                                                <span>-->
<!--                                                                    --><?//=$subGood->getGood()->getPropertyValueById($size->id)->value?><!-- --><?//=$subGood->getGood()->getPropertyValueById($size->id)->getMeasure()->shortName?>
<!--                                                                </span>-->
<!--                                                        </td>-->
<!--                                                    </tr>-->
<!--                                                --><?// endif; ?>
<!--                                                --><?// endforeach; ?>
<!--                                                </tbody>-->
<!--                                            </table>-->
                                            <div class="row">
                                                <div class="col-lg-6 product--old-price"></div>
                                                <div class="col-lg-6 product--price"><var><?=number_format( $subGood->getGood()->getShowPrice(), 0, ',', ' ' )?></var> руб.</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <?endforeach;?>
                            </div>
                        </div>
                    </td>
                </tr>
                <?endif?>
                <?endforeach;?>
            </tbody>
            <tfoot class="text-right">
            <tr>
                <td colspan="4">Итоговая стоимость: </td>
                <td class="product--price"><?=number_format( $shopcart->getTotalPrice(), 0, ',', ' ' )?> руб.</td>
                <td></td>
            </tr>
            </tfoot>
        </table>
    </section>


    <p class="text-center padded">
        <a role="button" class="btn btn-info btn-lg" data-toggle="collapse" href="#drawingUpOfAnOrder">Оформление заказа</a>
    </p>
    <section id="drawingUpOfAnOrder" class="collapse">
        <div role="tabpanel">
            <ul class="nav nav-tabs" role="tablist">
                <li role="presentation" class="active">
                    <a href="#pickup" aria-controls="home" role="tab" data-toggle="tab"><span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;Самовывоз</a>
                </li>
                <li role="presentation">
                    <a href="#delivery" aria-controls="tab" role="tab" data-toggle="tab"><span class="glyphicon glyphicon-home"></span>&nbsp;&nbsp;Доставка</a>
                </li>
            </ul>
            <form class="tab-content">
                <div class="col-md-4 col-sm-6 col-md-offset-4 col-sm-offset-3">
                    <div class="form-group">
                        <label for="">Фамилия</label>
                        <input type="text" class="form-control" id="" placeholder="" name="family">
                    </div>
                    <div class="form-group">
                        <label for="">Имя</label>
                        <input type="text" class="form-control" id="" placeholder="" name="name">
                    </div>
                    <div class="form-group">
                        <label for="">Отчество</label>
                        <input type="text" class="form-control" id="" placeholder="" name="parentName">
                    </div>
                    <div class="form-group">
                        <label for="">Телефон</label>
                        <input type="text" class="form-control" id="" placeholder="" name="phone">
                    </div>
                    <div class="form-group">
                        <label for="">E-mail</label>
                        <input type="text" class="form-control" id="" placeholder="" name="email">
                    </div>
                </div>

                <div role="tabpanel" class="tab-pane active" id="pickup"></div>

                <div role="tabpanel" class="tab-pane" id="delivery">
                    <div class="col-md-4 col-sm-6 col-md-offset-4 col-sm-offset-3">
                        <legend class="text-center">Подъем на этаж</legend>
                        <div class="form-group">
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
                        </div>

                        <legend class="text-center">Адрес доставки</legend>
                        <div class="form-group">
                            <label for="">Индекс</label>
                            <input type="text" class="form-control" id="" placeholder="" name="index">
                        </div>
                        <div class="form-group">
                            <label for="">Область</label>
                            <input type="text" class="form-control" id="" placeholder="" name="region">
                        </div>
                        <div class="form-group">
                            <label for="">Город</label>
                            <input type="text" class="form-control" id="" placeholder="" name="city">
                        </div>
                        <div class="form-group">
                            <label for="">Улица</label>
                            <input type="text" class="form-control" id="" placeholder="" name="street">
                        </div>
                        <div class="form-group">
                            <label for="">Корпус</label>
                            <input type="text" class="form-control" id="" placeholder="" name="block">
                        </div>
                        <div class="form-group">
                            <label for="">Дом</label>
                            <input type="text" class="form-control" id="" placeholder="" name="home">
                        </div>
                        <div class="form-group">
                            <label for="">Квартира</label>
                            <input type="text" class="form-control" id="" placeholder="" name="flat">
                        </div>
                        <div class="form-group">
                            <label for="">Способ оплаты</label>
                            <select class="form-control" name="paymentType">
                                <option>Наличные</option>
                                <option>Банковский перевод</option>
                                <option>Кредитная карта</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 col-sm-6 col-md-offset-4 col-sm-offset-3">
                    <p class="text-center">
                        <button type="submit" class="btn btn-primary btn-lg sendOrderGetSuccessBlock" data-dataLayerPushEvent="zakaz_cart">
                            Оформить заказ
                        </button>
                    </p>
                </div>

            </form>
        </div>
    </section>
    <?else:?>
        <div class="yourEmptyShopcart">Ваша корзина пуста</div>
    <?endif?>
</div>