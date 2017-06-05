<div class="col-md-4 col-sm-6">
    <?if($this->getController('Authorization')->isAdminAuthorizated()):?>
        <a
            class="adminShow"
            href="<?=$object->getAdminPath()?>"
            target="_blank" title="Эта ссылка видна только авторизованному в админской части пользователю"
            style="position: relative"
        >
            Редактировать [id = <?=$object->id?>]
        </a>
    <?endif?>
    <div class="product-item">
        <?if ($object->getOffer()):?>
            <div class="alert alert-info">Только в период акции!</div>
            <!--                                        <div class="product-item-discount">-<var>33</var>%</div>-->
        <?endif?>
        <a href="<?=$object->getPath()?>" class="img-cover" style="background-image: url(<?=$object->getFirstPrimaryImage()->getImage('0x200')?>);"></a>
        <div class="product-item-details">
            <h4><a href="<?=$object->getPath()?>" class="product--name"><?=$object->getName()?></a></h4>
            <div class="row">
                <div class="col-sm-6">
                    <?if ($object->getOffer()):?>
                        <div class="product--old-price"><var><?=number_format( $object->getShowOldPrice(), 0, ',', ' ' )?></var> руб.</div>
                    <?endif?>
                    <div class="product--price"><var><?=number_format( $object->getShowPrice(), 0, ',', ' ' )?></var> руб.</div>
                </div>
                <div class="col-sm-6">
                    <a href="<?=$object->getPath()?>" class="btn btn-default pull-right">Подробнее</a>
                </div>
            </div>
        </div>
    </div>
</div>