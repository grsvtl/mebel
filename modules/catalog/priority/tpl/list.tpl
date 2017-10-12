<? if ( $objects->count() == 0 ) : ?>
    <div class="row">
        <div class="col-md-12">
            <p class="alert alert-info">
                Не найдено ни одного товара
            </p>
        </div>
    </div>
<? endif; ?>


<div class="row sortable">
    <? foreach ( $objects as $object ): ?>
        <div class="col-sm-3 col-md-2 item" data-id="<?=$object->id?>" data-priority="<?=$object->getPriority( $domainAlias, $category->id )->priority?>">
            <div class="thumbnail">
                <img src="<?=$object->getFirstPrimaryImage()->getImage('230x168')?>" alt="">
                <div class="caption">
                    <div class="row">
                        <div class="col-md-6">
                            <h5 class="pull-left"><?=$object->id?> </h5>
                        </div>
                        <div class="col-md-6">
                            <h5 class="pull-right priority"><?=$object->getPriority( $domainAlias, $category->id )->priority?></h5>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <small class="pull-left"><?=$object->getName()?></small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    <? endforeach; ?>
</div>