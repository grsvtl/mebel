<?foreach ($objects as $object):?>

	<?if(strstr($_SERVER['REQUEST_URI'], '/admin/orders/groupDriver/')):?>
	<b><a href="/admin/orders/order/<?=$object->id?>/">
	<?endif?>
	Заказ № <?=$object->nr?> от <?=$object->date?>
	<?if(strstr($_SERVER['REQUEST_URI'], '/admin/orders/groupDriver/')):?>
	</a></b>
	<?endif?>

	<br />
	<span style="font-size: 13px;color: #9E9E9E;">Заказчик:</span>
	<?= $object->getClient()->company ? $object->getClient()->company.', ' : ''?>
	<?= $object->getClient()->inn ? 'ИНН '.$object->getClient()->inn.', ' : ''?>
	<?= $object->getClient()->kpp ? 'КПП '.$object->getClient()->kpp.', ' : ''?>
	<?=$object->getClient()->surname?>
	<?=$object->getClient()->name?>
	<?=$object->getClient()->patronimic?>
	<?= $object->getClient()->phone ? ', '.$object->getClient()->phone : ''?>
	<?= $object->getClient()->mobile ? ', '.$object->getClient()->mobile : ''?>
	<br />
	<span style="font-size: 13px;color: #9E9E9E;">Адрес доставки:</span> <?=$object->getDeliveryAddressString()?> <a href="http://maps.yandex.ru/?text=<?=$object->getDeliveryAddressString()?>&z=12" target="_blank">на Яндекс-карте</a>
	<br />
	<span style="font-size: 13px;color: #9E9E9E;">Принимающий:</span> <?=$object->person?> <?= $object->phone ? ', '.$object->phone : ''?>
	<br />
	<span style="font-size: 13px;color: #9E9E9E;">Статус оплаты:</span> <?=$object->getPaymentStatus()->name?>
	<br />
	<span style="font-size: 13px;color: #9E9E9E;">Способ оплаты:</span> <?= $object->cashPayment==0 ? 'безналичный' : 'наличный'?>
	<?if($object->deliveryDate || $object->deliveryTime):?>
	<br />
	<span style="font-size: 13px;color: #9E9E9E;">Время доставки:</span> <?= $object->deliveryDate ? $object->deliveryDate : ''?> <?= $object->deliveryTime ? $object->deliveryTime : ''?>
	<?endif?>
	<br /><br />

	<?if($object->getOrderGoods()):?>
	<table width="100%" style="border-top: 2px solid #E5E5E5;text-align: center;">
		<tr class="first_line" style="border-bottom: 2px solid #E5E5E5;border-top: 2px solid #E5E5E5;text-align: center;">
			<th class="first" style="font-weight:normal;">№</th>
			<th style="background: url(<?=DIR_HTTP?>/admin/images/backgrounds/bdr.png) no-repeat left center;padding: 0 10px;font-weight:normal;">Наименование</th>
			<th style="background: url(<?=DIR_HTTP?>/admin/images/backgrounds/bdr.png) no-repeat left center;padding: 0 10px;font-weight:normal;">Количество (шт.)</th>
			<th style="background: url(<?=DIR_HTTP?>/admin/images/backgrounds/bdr.png) no-repeat left center;padding: 0 10px;font-weight:normal;">Цена за шт. (руб.)</th>
			<th style="background: url(<?=DIR_HTTP?>/admin/images/backgrounds/bdr.png) no-repeat left center;padding: 0 10px;font-weight:normal;">Стоимость (руб)</div></th>
		</tr>
		<? $i=1; foreach($object->getOrderGoods() as $good):?>
		<tr>
			<td style="border-top: 1px solid #E5E5E5;"><?=$i?></td>
			<td style="border-top: 1px solid #E5E5E5;"><?=$good->getGood()->getName()?></td>
			<td style="border-top: 1px solid #E5E5E5;"><?=$good->quantity?></td>
			<td style="border-top: 1px solid #E5E5E5;"><?=\core\utils\Prices::standartPrice($good->getPrice())?></td>
			<td style="border-top: 1px solid #E5E5E5;"><?=\core\utils\Prices::standartPrice($good->getPrice() * $good->quantity)?></td>
		</tr>
		<? $i++; endforeach?>
		<tr>
			<td colspan="2" style="border-top: 2px solid #E5E5E5;border-bottom: 2px solid #E5E5E5;text-align: right; padding-right: 10px;"><b>Всего:</b></td>
			<td style="border-top: 2px solid #E5E5E5;border-bottom: 2px solid #E5E5E5;"><b><?=\core\utils\Prices::standartPrice($object->getTotalQuantity())?></b></td>
			<td style="border-top: 2px solid #E5E5E5;border-bottom: 2px solid #E5E5E5;"></td>
			<td style="border-top: 2px solid #E5E5E5;border-bottom: 2px solid #E5E5E5;"><b><?=\core\utils\Prices::standartPrice($object->getTotalSumForGoods())?></b></td>
		</tr>
		<?if($object->getDelivery()->getCategory()->name):?>
		<tr>
			<td colspan="2" style="border-top: 2px solid #E5E5E5;border-bottom: 2px solid #E5E5E5;text-align: right; padding-right: 10px;">
				<b>Доставка:</b>
			</td>
			<td style="border-top: 2px solid #E5E5E5;border-bottom: 2px solid #E5E5E5;">
				<?=$object->getDelivery()->getCategory()->name?> (<?=$object->getDelivery()->getName()?>)
			</td>
			<td style="border-top: 2px solid #E5E5E5;border-bottom: 2px solid #E5E5E5;"></td>
			<td style="border-top: 2px solid #E5E5E5;border-bottom: 2px solid #E5E5E5;">
				<b><?=\core\utils\Prices::standartPrice($object->getDelivery()->getPrice())?></b>
			</td>
		</tr>
		<?endif?>
		<tr>
			<td colspan="2" style="border-top: 2px solid #E5E5E5;border-bottom: 2px solid #E5E5E5;text-align: right; padding-right: 10px;"><b>Итого:</b></td>
			<td style="border-top: 2px solid #E5E5E5;border-bottom: 2px solid #E5E5E5;"></td>
			<td style="border-top: 2px solid #E5E5E5;border-bottom: 2px solid #E5E5E5;"></td>
			<td style="border-top: 2px solid #E5E5E5;border-bottom: 2px solid #E5E5E5;">
				<b><?=\core\utils\Prices::standartPrice($object->getTotalSum())?></b>
			</td>
		</tr>
	</table>
	<?endif?>

	<?if($object->driverNotice):?>
	<br />
	<span style="font-size: 13px;color: #9E9E9E;">Примечания для водителя:</span>
	<br />
	<?=$object->driverNotice?>
	<?endif?>

	<br /><br /><br />

<?endforeach?>