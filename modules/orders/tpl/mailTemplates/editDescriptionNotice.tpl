<? $headerTitle = 'Обновлены заметки' ?>
<? include ('header.tpl'); ?>
	<table style="font-size: 12px;">
		<tr>
			<td>
				<p>Менджер <b><?=$this->getAuthorizatedUser()->getAllName()?></b> обновил заметки:</p>
				<table style="font-size: 12px;">
					<tr>
						<td style="padding: 0"> <h4 style="padding: 0; margin: 0; color: #222; font-weight: bold; font-size: 12px;">Новые заметки:</h4> </td>
						<td style="padding: 0"> <h4 style="padding: 0; margin: 0; color: #999; font-weight: bold; font-size: 12px;">Предыдущие заметки:</h4> </td>
					</tr>
					<tr>
						<td style="font-size: 11px;"> <?=$newDescription?str_replace("\r\n", '<br/>', $newDescription):'не указаны'?> <br/></td>
						<td style="font-size: 11px; color: #999"> <?=$order->description?str_replace("\r\n", '<br/>', $order->description):'не указаны'?> <br/></td>
					</tr>
				</table>

				<table style="margin-top: 10px; font-size: 12px;">
					<tr>
						<td colspan="3" style="padding: 0; margin: 0;">
							<h4 style="padding: 0; margin: 0; color: #222; font-weight: bold; font-size: 12px;">Данные заказа:</h4>
						</td>
					</tr>
					<tr>
						<td style="padding: 0; margin: 0; padding-top: 10px; font-size: 11px; font-weight: bold;" valign="top">
							Оплаты:
						</td>
						<td style="padding: 0; margin: 0; padding-top: 10px; font-size: 11px; font-weight: bold;" valign="top">
							Клиент:
						</td>
						<? if($order->deliveryId): ?>
						<td style="padding: 0; margin: 0; padding-top: 10px; font-size:12px; font-weight: bold;" valign="top">
							Доставить:
						</td>
						<? endif; ?>
					</tr>
					<tr>
						<td style="padding: 0; margin: 0;">
							<table style="margin-top: 3px; font-size: 12px;">
								<tr>
									<td style="margin: 0; padding: 0; font-size: 12px; color: #333;">
										Счёт № <b><?=$order->invoiceNr?$order->invoiceNr:'не указан'?></b> <? if($order->invoiceNr): ?><?=$order->invoiceNrDate?'от':''?> <b><?=$order->invoiceNrDate?><? endif; ?></b>
										<br />
										Способ оплаты: <b><?=$order->cashPayment?'наличный':'безналичный'?></b>
										<br />
										Статус: <b style="font-size: 12px;  color: <?=$order->getPaymentStatus()->color?>"><?=$order->getPaymentStatus()->name?></b>
										<br />
										Платежное поручение № <b><?=$order->paymentOrderNr?$order->paymentOrderNr:'не указан'?></b> <? if($order->paymentOrderNr): ?><?=$order->paymentOrderNrDate?'от':''?> <b><?=$order->paymentOrderNrDate?><? endif; ?></b>
									</td>
								</tr>
							</table>
						</td>
						<td style="padding: 0; margin: 0;">
							<table style="margin-top: 3px; font-size: 12px;">
								<tr>
									<td style="padding: 0; margin: 0; color: #333; font-size: 12px;">
										<?=$order->getClient()->surname?>
										<?=$order->getClient()->name?>
										<?=$order->getClient()->patronimic?>
									</td>
								</tr>
								<tr>
									<td style="padding: 0; margin: 0">
										<p style="color: #999; font-size: 11px; padding: 0; margin: 0;">
											Контакты:
											тел. <strong><?=$order->getClient()->phone?></strong>
											моб. <strong><?=$order->getClient()->mobile?></strong>
											<br />
											E-mail: <?= $order->getClient()->haveTestMail() ? '-' : $order->getClient()->getLogin()?>
										</p>
									</td>
								</tr>
							</table>
						</td>
						<? if($order->deliveryId): ?>
						<td style="padding: 0; margin: 0;" valign="top">
							<?=$order->getDeliveryAddressString()?><br />
							<?=$order->deliveryDate?> <?=$order->deliveryTime?>
							<br><strong>Получатель:</strong> <br>
							<?=$order->person?><br> моб. <?=$order->phone?>
						</td>
						<? endif; ?>
					</tr>
				</table>

				<table style="margin-top: 10px; font-size: 12px;">
					<tr>
						<td style="padding: 0; margin: 0;">
							<h4 style="padding: 0; margin: 0; color: #222; font-weight: bold; font-size: 12px;">Товары:</h4>
						</td>
					</tr>
					<tr>
						<td style="padding: 0; margin: 0; padding-top: 10px;">
							<table width="800" style="text-align:center; font-size: 12px;">
								<tr style="font-weight: bold;background-color: #DAE2FE;">
									<td>&nbsp;#&nbsp;</td>
									<td colspan="2">Товар</td>
									<td>Цена / Базовая цена</td>
									<td>Количество</td>
									<td>Стоимость</td>
								</tr>
								<? $i=1; foreach($order->getOrderGoods() as $good):?>
									<? include $good->getGood()->getConfig()->orderGoodAdminTemplate.'.tpl'; ?>
								<? $i++; endforeach?>
								<?if ($this->isNotNoop($order->getPromoCode())):?>
								<tr>
									<td colspan="5" style="text-align: right;">Скидка по промо коду (<?=$order->getPromoCodeDiscount()?> %):</td>
									<td>- <?=$order->getOrderGoods()->getPromoCodeDiscountSum()?></td>
								</tr>
								<?endif?>
								<?if ($this->isNotNoop($order->getDelivery())):?>
								<tr>
									<td colspan="3" style="text-align: right;">
										Доставка -
										<?=$order->getDelivery()->getCategory()->name?>
										<?if ($this->isNotNoop($order->getDelivery())):?>
											(<?=$order->getDelivery()->getName()?>)
										<?endif;?>
										:
									</td>
									<td>
										<?if( $order->getDelivery()->id == (new \modules\deliveries\lib\DeliveryConfig)->getFloatPriceDeliveryId() ):?>
											договорная
										<?elseif ($this->isNotNoop($order->getDelivery())):?>
											<?=$order->deliveryPrice?> / <?=$order->deliveryBasePrice?>
										<?endif;?>
									</td>
									<td></td>
									<td>
										<?if( $order->getDelivery()->id == (new \modules\deliveries\lib\DeliveryConfig)->getFloatPriceDeliveryId() ):?>
											договорная
										<?elseif ($this->isNotNoop($order->getDelivery())):?>
											<?=$order->deliveryPrice?>
										<?endif;?>
									</td>
								</tr>
								<?endif?>
								<tr>
									<td colspan="4" style="text-align: right;"><strong>Итого:<strong></td>
									<td><?=$order->getOrderGoods()->getTotalGoodsQuantity()?></td>
									<td>
										<?if($order->getOrderGoods()->isZeroPriceGoods()):?>
										<strong>договорная</strong>
										<?else:?>
										<strong><?=$order->getTotalSum()?></strong>
										<?endif?>
										<?if( $order->getDelivery()->id == 223 ): ?>
										<br />+ стоимость доставки
										<?endif?>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<br/>
			</td>
		</tr>
	</table>
<? include ('footerAdmin.tpl'); ?>