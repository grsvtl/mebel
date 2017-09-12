<div class="additionalGoodsTable">
    <p class="title">Список дополнительных товаров:</p>
    <?if ($additionalGoods->count()):?>
    <table class="goodsList">
        <tr class="top">
            <td>&nbsp;#&nbsp;</td>
            <td class="borderLeft">Подтовар</td>
            <td class="borderLeft">Цена / <span class="grayText">Себестоимость</span> <span class="normalWeight">(руб.)</span></td>
            <td class="borderLeft">Стоимость / <span class="grayText">Себестоимость</span> <span class="normalWeight">(руб.)</span></td>
            <td class="borderLeft">Прибыль <span class="normalWeight">(руб.)</span></td>
            <td class="borderLeft"><img src="/admin/images/bg/trash.png" alt="Удалить" /></td>
        </tr>
        <? $i=1; foreach($additionalGoods as $additionalGood):?>
        <tr class="line">
            <td class="center"><?=$i?></td>
            <td>
                <a href="<?=$additionalGood->getGood()->getAdminUrl()?>" target="blank">
                    <?=$additionalGood->getGood()->getName()?> (<?=$additionalGood->getGood()->getCode()?>)
                </a>
            </td>
            <td  class="center">
                <?= $additionalGood->getGood()->getPriceByQuantity(1)?>
                /
                <span class="grayText"><?= $additionalGood->getGood()->getBasePriceByQuantity(1)?></span>
            </td>
            <td  class="center">
                <?= $additionalGood->getCost()?> / <span class="grayText"><?= $additionalGood->getBaseCost()?></span>
            </td>
            <td  class="center"><?=$additionalGood->getIncome()?></td>
            <td  class="center">
                <div><a class="pointer delete deleteAdditionalGood" data-id="<?=$additionalGood->id?>"  title="Удалить подтовар"></a></div>
            </td>
        </tr>
        <? $i++; endforeach?>
    </table>
    <?else:?>
    <i>Не добавлено ни одного товара.</i>
    <? endif;?>
    <br /><br />
    <p class="title">Добавить дополнительные товары:</p>
    <div class="addGoodBlock">
        <table width="100%">
            <tr>
                <td class="first">Дополнительный товар:</td>
                <td>
                    <input type="text" class="inputAdditionalGoodId">
                    <img class="inputGoodLoader" style="margin: 5px 0px -10px 140px; display: none;" src="/images/loaders/loading-small.gif" />
                </td>
            </tr>
            <tr>
                <td class="first"></td>
                <td><a id="addAdditionalGood" class="add-bottom pointer" data-mainGoodId="<?=$good->id?>" style="margin: 0px 0px 0px -20px; ">Добавить</a></td>
            </tr>
        </table>
    </div>
</div>