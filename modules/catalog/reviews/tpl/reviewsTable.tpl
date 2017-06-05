<!--<script type="text/javascript" src="/modules/orders/js/transformerEditMode.js"></script>-->
<!--<script type="text/javascript" src="/modules/catalog/subGoods/js/subGoodsTableFunctions.js"></script>-->
<!---->
<!---->
<link rel="stylesheet" type="text/css" href="/modules/catalog/subGoods/css/style.css">



<div class="goodsTable">
    <p class="title">Список подтоваров:</p>
<!--    --><?//if ($subGoods->count()):?>
        <table class="goodsList">
            <tr class="top">
                <td>&nbsp;#&nbsp;</td>
                <td class="borderLeft">Подтовар</td>
                <td class="borderLeft">Цена / <span class="grayText">Себестоимость</span> <span class="normalWeight">(руб.)</span></td>
                <td class="borderLeft">Количество <span class="normalWeight">(шт.)</span></td>
                <td class="borderLeft">Стоимость / <span class="grayText">Себестоимость</span> <span class="normalWeight">(руб.)</span></td>
                <td class="borderLeft">Прибыль <span class="normalWeight">(руб.)</span></td>
                <td class="borderLeft"><img src="/admin/images/bg/trash.png" alt="Удалить" /></td>
            </tr>
<!--            --><?// $i=1; foreach($subGoods as $subGood):?>
<!--                <tr class="line">-->
<!--                    <td class="center">--><?//=$i?><!--</td>-->
<!--                    <td>-->
<!--                        <a href="--><?//=$subGood->getGood()->getAdminUrl()?><!--" target="blank">-->
<!--                            --><?//=$subGood->getGood()->getName()?><!-- (--><?//=$subGood->getGood()->getCode()?><!--)-->
<!--                        </a>-->
<!--                    </td>-->
<!--                    <td  class="center">-->
<!--                        --><?//= $subGood->getGood()->getPriceByQuantity($subGood->subGoodQuantity)?>
<!--                        /-->
<!--                        <span class="grayText">--><?//= $subGood->getGood()->getBasePriceByQuantity($subGood->subGoodQuantity)?><!--</span>-->
<!--                    </td>-->
<!--                    <td class="center">-->
<!--                        <input-->
<!--                            type="text"-->
<!--                            class="editDelivery transformer"-->
<!--                            name="subGoodQuantity"-->
<!--                            value="--><?//=$subGood->subGoodQuantity?><!--"-->
<!--                            data-action="/admin/subGoods/ajaxEditSubgood/"-->
<!--                            data-post="&id=--><?//=$subGood->id?><!--"-->
<!--                        />-->
<!--                    </td>-->
<!--                    <td  class="center">-->
<!--                        --><?//= $subGood->getCost()?><!-- / <span class="grayText">--><?//= $subGood->getBaseCost()?><!--</span>-->
<!--                    </td>-->
<!--                    <td  class="center">--><?//=$subGood->getIncome()?><!--</td>-->
<!--                    <td  class="center">-->
<!--                        <div><a class="pointer delete deleteSubGood" data-id="--><?//=$subGood->id?><!--"  title="Удалить подтовар"></a></div>-->
<!--                    </td>-->
<!--                </tr>-->
<!--                --><?// $i++; endforeach?>
            <tr class="line">
<!--                <td class="right" colspan="3">Итого:</td>-->
<!--                <td class="center">--><?//=$subGoods->getQuantity()?><!--</td>-->
<!--                <td class="center">--><?//=$subGoods->getCost()?><!--  / <span class="grayText">--><?//=$subGoods->getBaseCost()?><!--</span></td>-->
<!--                <td class="center">--><?//=$subGoods->getIncome()?><!--</td>-->
                <td></td>
            </tr>
        </table>
    <?//else:?>
        <i>Нет отзывов.</i>
    <?// endif;?>
    <br /><br />
</div>