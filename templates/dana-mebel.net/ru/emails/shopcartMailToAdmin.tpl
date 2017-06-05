<? include ('header.tpl'); ?>
    <tr>
    <td colspan="2" style="padding-left: 10px;">
    <h2 class="subject" style="width: 100%;text-align: center;color: #24667B;">Получен новый заказ с сайта <?=SEND_FROM?></h2>
    <p>
    Здравствуйте.
    <br /><br />
    С сайта <?=SEND_FROM?> был отправлен новый заказ.
    <br /><br />
    Данные заказа:
    <br />
    Фамилия: <strong><?=$data['family']?></strong>
    <br />
    Имя: <strong><?=$data['name']?></strong>
    <br />
    Отчество: <strong><?=$data['parentName']?></strong>
    <br />
    Телефон: <strong><?=$data['phone']?></strong>
    <br />
    Email: <strong><?=$data['email']?></strong>
    <br /><br />

<?if(isset($data['lift'])  &&  !empty($data['lift'])):?>
    Адрес доставки:
    <?if($data['index']):?>
        <br />
        Индекс: <strong><?=$data['index']?></strong>
    <?endif?>
    <?if($data['region']):?>
        <br />
        Область: <strong><?=$data['region']?></strong>
    <?endif?>
    <br />
    Город: <strong><?=$data['city']?></strong>
    <br />
    Улица: <strong><?=$data['street']?></strong>
    <?if($data['block']):?>
        <br />
        Корп.: <strong><?=$data['block']?></strong>
    <?endif?>
    <br />
    Дом: <strong><?=$data['home']?></strong>
    <?if($data['flat']):?>
        <br />
        Квартира: <strong><?=$data['flat']?></strong>
    <?endif?>
    <br />
    Подъем на этаж: <strong><?=$data['lift']?></strong>
    <br /><br />
<?endif?>

<?if(isset($data['paymentType'])  &&  !empty($data['paymentType'])):?>
    Способ оплаты: <strong><?=$data['paymentType']?></strong>
<?endif?>
    <br /><br />
    Содержание заказа:
    <br />
    <table width="100%" border="1" style="border-color: grey; border-spacing: 0px; text-align: center;">
    <tr style="background-color: #DAE2FE; color: #24667B;">
        <th colspan="2" class="first"><div>Название товара или услуги</div></th>
        <th><div>Количество</div></th>
        <th class="last"><div>Стоимость</div></th>
    </tr>
<?foreach($shopcart as $good):?>


    <?if($good->isAnComplect()):?>
        <tr style="border-top: 1px solid black;">
            <td></td>
            <td>
        <p>
            <u>
                <a href="<?=$_SERVER['HTTP_HOST'].$good->getPrimaryGood()->getGood()->getPath()?>">
                    Комплект со скидкой!
                </a>
            </u>
        </p>
        </td>
        <td><p><?=$good->getQuantity()?></p></td>
        <?$complectGoodsQuantity = ($good->getSecondaryGoods()->count() ? $good->getSecondaryGoods()->count() : 0) + 1?>
        <td rowspan="<?=$complectGoodsQuantity + 1?>"><p class="price"><span><span><?=$good->getTotalPrice()?></span> руб </p></td>
        </tr>
        <tr>
            <td>
                <div class="image">
                    <a href="<?=$_SERVER['HTTP_HOST'].$good->getPrimaryGood()->getGood()->getPath()?>">
                        <img src="http://<?= $_SERVER['HTTP_HOST'].$good->getPrimaryGood()->getGood()->getFirstPrimaryImage()->getFocusImage('100x0')?>" alt="" />
                    </a>
                </div>
            </td>
            <td>
                <p class="name">
                    <a href="<?=$_SERVER['HTTP_HOST'].$good->getPrimaryGood()->getGood()->getPath()?>">
                        <?=$good->getPrimaryGood()->getGood()->getName()?>
                    </a>
                    &nbsp;(<?=$good->getPrimaryGood()->getPrice()?>  руб)
                </p>
            </td>
            <td><p><?=$good->getPrimaryGood()->quantity?></p></td>
            <!--<td></td>-->
        </tr>

        <?if($good->getSecondaryGoods()->count()):?>
            <? $i=1; foreach($good->getSecondaryGoods() as $complectSubgood):?>
                <tr>
                    <td>
                        <div class="image">
                            <img src="http://<?= $_SERVER['HTTP_HOST'].$complectSubgood->getGood()->getFirstPrimaryImage()->getFocusImage('100x0')?>" alt="" />
                        </div>
                    </td>
                    <td>
                        <p class="name">
                            <?=$complectSubgood->getGood()->getName()?>
                            &nbsp;(<?=$complectSubgood->getPrice()?> руб)
                        </p>
                    </td>
                    <td><p><?=$complectSubgood->quantity?></p></td>
                    <!--<td></td>-->
                </tr>
            <?endforeach?>
        <?endif;?>
        <tr style="border-bottom: 1px solid black;">
            <td colspan="4"></td>
        </tr>

    <?else:?>

        <tr>
            <td><div class="image"><a href="<?=$_SERVER['HTTP_HOST'].$good->getPath()?>"><img src="http://<?= $_SERVER['HTTP_HOST'].$good->getFirstPrimaryImage()->getFocusImage('100x0')?>" alt="" /></a></div></td>
            <td>
                <p class="name"><a href="<?=$_SERVER['HTTP_HOST'].$good->getPath()?>"><?=$good->getName()?></a></p>
                <?if($good->getSubgoods() && $good->getSubgoods()->count()):?>
                    <table>
                        <tr>
                            <td style="text-align: left; margin-left: 20px;">Подтовары:</td>
                        </tr>
                        <?$i=1; foreach($good->getSubgoods() as $subGood):?>
                            <tr>
                                <td style="text-align: left; margin-left: 20px;">
                                    <?=$i?>.
                                    <img src="<?=$_SERVER['HTTP_HOST'].$subGood->getGood()->getFirstPrimaryImage()->getUserImage('30x0')?>" alt="">
                                    <a href="<?=$_SERVER['HTTP_HOST'].$subGood->getGood()->getPath()?>"><?=$subGood->getGood()->getName()?></a>
                                </td>
                            </tr>
                            <?$i++; endforeach?>
                    </table>
                <?endif?>
            </td>
            <td><p><?=$good->getQuantity()?></p></td>
            <td><p class="price"><span><span><?=$good->getTotalPrice()?></span> руб </p></td>
        </tr>


    <?endif?>


<?  endforeach;?>
    <tr class="itog">
        <td colspan="3"><p class="sum"><strong>ИТОГО:</strong></p></td>
        <td><p class="price"><strong><span><?=$shopcart->getTotalPrice()?></span> руб.</strong></p></td>
    </tr>
    </table>
    </p>
    <br />
    <p>
        Свяжитесь с клиентом в ближайшее время. Он ожидает вашего звонка.
    </p>
    </td>
    </tr>
<? include ('footerAdmin.tpl'); ?>