<!--Начало блока с добавлением товара-->
<section class="info-add-block">
	<div class="title-block"><?=$object->getName()?></div>
	<img src="<?=$object->getFirstPrimaryImage()->getUserImage('232x146', 'watermarkPng')?>">

	<?if(!$object->isBlocked()):?>
	<?if($object->getOffer()):?>
	<div class="price-info-block">
		<div class="offer_only">Только в период акции!</div>
		<p class="price-info">
			<?=number_format( $object->getShowPrice(), 0, ',', ' ' )?>
			<strong>c</strong>
		</p>
	</div>
	<?else:?>
	<div class="price-info-block">
<!--		<p class="old-price-info">
			Старая цена:
			<span>
				<strong>c</strong>
			</span>
		</p>-->
		<p class="price-info">
			<?=number_format( $object->getShowPrice(), 0, ',', ' ' )?>
			<strong>c</strong>
		</p>
	</div>
	<?endif?>
	<span class="add-to-cart-info addToShopcart" data-objectId="<?=$object->id?>" data-objectClass="<?=$object->getClass()?>"  onclick="dataLayer.push({'event': 'event_addcart'});">
		Добавить в корзину
	</span>
	<p class="ili">ИЛИ</p>
	<span class="clock-one-info orderOneClickModalShow"
		  data-objectId="<?=$object->id?>"
		  title="<?=$object->getName()?> - купить в 1 клик"
	>
		купите в 1 клик
	</span>
	<?else:?>
	<div class="price-info-block">
		<p class="past">Товар снят с продажи</p>
	</div>
	<?endif?>

</section>
<!--Конец блока с добавлением товара-->