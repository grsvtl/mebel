<script type="text/javascript" src="/js/catalog/complectsHandler.js"></script>

<section class="action slides_complect">
	<div class="title-action">
		Купите вместе и получите скидку!
	</div>

	<span class="prev left-action"></span>
	<span class="next right-action"></span>

	<div class="slides_container"style="overflow: hidden; position: relative; display: block;">
		<? foreach( $objects as $object ):
			$primaryGood = $object->getPrimaryGood();
			$secondaryGoods = $object->getSecondaryGoods();
		?>
		<div class="block slide">
			<div class="pr1">
				<?if($primaryGood->discount):?>
				<span class="discont">товары со скидкой</span>
				<?endif?>
				<a href="<?=$primaryGood->getGood()->getPath()?>" class="img-link">
					<img src="<?=$primaryGood->getGood()->getFirstPrimaryImage()->getUserImage('207x135', 'watermarkPng')?>">
				</a>
				<a href="<?=$primaryGood->getGood()->getPath()?>">
					<?=$primaryGood->getGood()->getName()?>
					<?= $primaryGood->quantity > 1 ? '<b> ('.$primaryGood->quantity.'&nbsp;шт.)</b>' : ''?>
				</a>
				<?if($primaryGood->discount):?>
				<span class="old-price-action"><?= number_format( $primaryGood->getTotalBaseSum(), 0, ',', ' ')?><strong>a</strong></span>
				<?endif?>
				<span class="price-action"><?=number_format( $primaryGood->getTotalSum(), 0, ',', ' ')?><strong>c</strong></span>
				<div class="clear"></div>
			</div>
			<div class="plus"></div>
			<div class="pr1">
				<?$secondaryGood = $secondaryGoods->current()?>
				<?if($secondaryGood->discount):?>
				<span class="discont">товары со скидкой</span>
				<?endif?>
				<a href="<?=$secondaryGood->getGood()->getPath()?>" class="img-link">
					<img src="<?=$secondaryGood->getGood()->getFirstPrimaryImage()->getUserImage('207x135', 'watermarkPng')?>">
				</a>
				<a href="<?=$primaryGood->getGood()->getPath()?>">
					<?=$secondaryGood->getGood()->getName()?>
					<?= $secondaryGood->quantity > 1 ? '<b> ('.$secondaryGood->quantity.'&nbsp;шт.)</b>' : ''?>
				</a>
				<?if($secondaryGood->discount):?>
				<span class="old-price-action"><?= number_format( $secondaryGood->getTotalBaseSum(), 0, ',', ' ')?><strong>a</strong></span>
				<?endif?>
				<span class="price-action"><?=number_format( $secondaryGood->getTotalSum(), 0, ',', ' ')?><strong>c</strong></span>
				<div class="clear"></div>
			</div>
			<div class="equally"></div>
			<div class="pr2" style="<?= $object->getMinQuantityDiscount() ? '' : 'background: none; margin-top:29px;'?>">
				<?if($object->getBasePriceByMinQuantity() != $object->getPriceByMinQuantity() ):?>
				<span class="old-price-action"><?= number_format( $object->getBasePriceByMinQuantity(), 0, ',', ' ')?><strong>c</strong></span>
				<?endif?>
				<span class="price-action"><?= number_format( $object->getPriceByMinQuantity(), 0, ',', ' ')?><strong>c</strong></span>
				<?if($object->getMinQuantityDiscount()):?>
				<span class="total">Вы экономите <?= number_format( $object->getMinQuantityDiscount(), 0, ',', ' ')?> <strong>c</strong></span>
				<?endif?>

				<?if(!$object->isBlocked()):?>
				<span class="add-to-cart addToShopcart" data-objectId="<?=$object->id?>" data-objectClass="<?=$object->getClass()?>"  onclick="dataLayer.push({'event': 'event_addcart'});">
					Добавить в корзину
				</span>
				<?endif?>

				<div class="clear"></div>
			</div>
			<div class="clear"></div>
		</div>
		<?endforeach?>
	</div>
</section>