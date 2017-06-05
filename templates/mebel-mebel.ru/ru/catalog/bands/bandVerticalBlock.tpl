<?if($object->getOffer()):?>
    <img class="akcia akciaInVerticalList" alt="" src="/images/bg/akcia.png">
<?else:?>
    <?if($object->isNew()):?>
        <span class="specialStatusName">Новинка</span>
        <img class="specialStatusImage" src="/images/bg/red1.png" />
    <?endif?>

    <?if($object->isSuperPrice()):?>
        <span class="specialStatusName">Супер цена!</span>
        <img class="specialStatusImage" src="/images/bg/red2.png" />
    <?endif?>

    <?if($object->isTopSell()):?>
        <span class="specialStatusName">Топ продаж</span>
        <img class="specialStatusImage" src="/images/bg/red3.png" />
    <?endif?>

    <?if($object->isSale()):?>
        <span class="specialStatusName">Распродажа</span>
        <img class="specialStatusImage" src="/images/bg/red2.png" />
    <?endif?>

    <?if($object->isAkcia()):?>
        <span class="specialStatusName">Акция</span>
        <img class="specialStatusImage" src="/images/bg/red1.png" />
    <?endif?>
<?endif?>