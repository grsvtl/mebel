<ul class="listOffersInset">
	<?foreach($objects as $object):?>
	<li>
		<div class="borderBlock">

            <?include ('bands/bandBlock.tpl')?>

			<?if($this->getController('Authorization')->isAdminAuthorizated()):?>
				<a class="adminShow" href="<?=$object->getAdminPath()?>" target="_blank" title="Эта ссылка видна только авторизованному в админской части пользователю">
					Редактировать [id = <?=$object->id?>]
				</a>
			<?endif?>

			<a href="<?=$object->getPath()?>">
				<img src="<?=$object->getFirstPrimaryImage()->getImage('270x187')?>" alt="">
			</a>
			<a href="<?=$object->getPath()?>" class="titleOffer"><span><?=$object->getName()?></span></a>


			<?
				$sizesAndWeightArray = array();
				$i = 1;
				foreach( $sizesAndWeight as $size ){
					if($object->getPropertyValueById($size->id)->value){
						$sizesAndWeightArray[] = ($i>1 ? 'x' : '').$object->getPropertyValueById($size->id)->value;
						$measureName = $object->getPropertyValueById($size->id)->getMeasure()->shortName;
					}
					$i++;
				}
			?>
			<?if(!empty($sizesAndWeightArray)):?>
			<span class="parametrs">
				Размеры:
				<br>
				<? foreach( $sizesAndWeightArray as $item ): ?>
				<?=$item?>
				<? endforeach; ?>
				(<?=$measureName?>)
			</span>
			<?endif?>

            <?if($object->getOffer()):?>
                <div class="price-left">
                    <div class="offer_only">Только в период акции!</div>
                    <div class="priceOffer old-price">
                        <?=number_format( $object->getShowOldPrice(), 0, ',', ' ' )?>
                        <span>c</span>
                    </div>
                    <div class="priceOffer">
                        <?=number_format( $object->getShowPrice(), 0, ',', ' ' )?>
                        <span>c</span>
                    </div>
                    <div class="clear"></div>
                </div>
            <?else:?>
                <div class="priceOffer">
                    <?=number_format( $object->getShowPrice(), 0, ',', ' ' )?> <span>c</span>
                </div>
            <?endif?>

			<div class="addCard addToShopcart" data-objectId="<?=$object->id?>" data-objectClass="<?=$object->getClass()?>">
				В корзину
			</div>
		</div>
	</li>
	<?endforeach?>
</ul>