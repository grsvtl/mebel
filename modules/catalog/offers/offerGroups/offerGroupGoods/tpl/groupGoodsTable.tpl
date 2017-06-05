<table class="goodsList">
	<?$goodsCount = $goods->count()?>

	
	<br />Товаров - <?=$goodsCount?><br />


	<?if( is_numeric($goodsCount)  &&  $goodsCount > 0 ):?>
	<tr class="top">
		<td>Товар</td>
		<td class="borderLeft">Цена / Старая цена</td>
		<td class="borderLeft">Мин<br />кол.</td>
		<td class="borderLeft"></td>
	</tr>
	<?foreach($goods as $good):?>
	<tr class="line">
		<td>
			<a href="<?=$good->getGood()->getFirstPrimaryImage()->getImage('800x600')?>" class="lightbox noNextPrev">
				<img src="<?=$good->getGood()->getFirstPrimaryImage()->getImage('40x40')?>" />
			</a>
			<a href="<?=$good->getGood()->getAdminUrl()?>/" target="blank">
				<?=$good->getGood()->getName()?> (<?=$good->getGood()->getCode()?>)
			</a>
			<br />
			<div class="comment"><?=$good->getGood()->goodDescription?></div>
		</td>
		<td>
			<b><?=$good->getGood()->getNativePriceByMinQuantity()?></b> /
			<span style="color: #666;">
				<?= $good->getGood()->getPrices()->getMinQuantity()
					?
						$good->getGood()->getPrices()->getPriceByQuantity($good->getGood()->getPrices()->getMinQuantity())->getOldPrice()
					:
						$good->getGood()->getPriceByMinQuantity()
				?>
				<br />
				( -<?= $good->getGood()->getPrices()->getMinQuantity()
					?
						$good->getGood()->getPrices()->getPriceByQuantity($good->getGood()->getPrices()->getMinQuantity())->getDiscount()
					:
						0
				?> )
			</span>
		</td>
		<td>
			<?=$good->getGood()->getPrices()->getMinQuantity()?>
		</td>
		<td>
			<div class="removeOfferGroupGoodForm" data-action="/admin/offers/removeOfferGroupGood/" data-post-action="none">
				<a class="removeOfferGroupGoodFormSubmit pointer" style="margin: 0px 2px 0px 5px"><img src="/admin/images/buttons/delete.png" alt=""></a>
				<input type="hidden" name="removedGoodId" value="<?=$good->id?>">
			</div>
		</td>
	</tr>
	<?endforeach?>
	<?endif?>
</table>
