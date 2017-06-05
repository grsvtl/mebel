<?if($object->isNew()):?>
    <span class="specialStatusNameBig">Новинка</span>
    <img class="specialStatusImageBig" src="/images/bg/red1Big.png" />
<?endif?>

<?if($object->isSuperPrice()):?>
    <span class="specialStatusNameBig">Супер цена!</span>
    <img class="specialStatusImageBig" src="/images/bg/red2Big.png" />
<?endif?>

<?if($object->isTopSell()):?>
    <span class="specialStatusNameBig">Топ продаж</span>
    <img class="specialStatusImageBig" src="/images/bg/red3Big.png" />
<?endif?>

<?if($object->isSale()):?>
    <span class="specialStatusNameBig">Распродажа</span>
    <img class="specialStatusImageBig" src="/images/bg/red2Big.png" />
<?endif?>

<?if($object->isAkcia()  &&  !$object->getOffer()):?>
    <span class="specialStatusNameBig">Акция</span>
    <img class="specialStatusImageBig" src="/images/bg/red1Big.png" />
<?endif?>


