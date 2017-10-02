<div class="productListItemBlock">
    <div class="container-offer">
        <a href="<?=$object->getPath()?>" class="img-c-o">
            <img src="<?=$object->getFirstPrimaryImage()->getImage('0x174')?>" alt="">
        </a>
        <div class="body-offer">
            <a href="<?=$object->getPath()?>" class="link-c-o"><?=$object->getName()?></a>
            <span class="type-offer">Для спальни</span>
            <ul>
                <? if($sizesAndWeight): ?>
                <? foreach( $sizesAndWeight as $size ): ?>
                <? if($size['name']): ?>
                <li>
                    <strong><?=$size['name']?> <?=$size['measure']?></strong>
                    <span><?=$size['value']?>:</span>
                </li>
                <? endif; ?>
                <? endforeach; ?>
                <? endif; ?>
            </ul>
            <div class="price-offer-block">
                <a href="<?=$object->getPath()?>" class="more-offer">Подробнее</a>
                <span><?=number_format( $object->getShowPrice(), 0, ',', ' ' )?> <strong>₽</strong></span>
            </div>
            <a class="buy-button btn btn-red-line getObjectModalButton" data-objectId="<?=$object->id?>">Купить</a>
        </div>
    </div>
</div>