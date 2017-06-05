<div class="main_edit">
	<script type="text/javascript" src="/modules/orders/js/orderHandler.js"></script>
	<script type="text/javascript" src="/modules/orders/js/order.class.js"></script>
	<script type="text/javascript" src="/js/ajaxLoader.class.js"></script>
	<input type="hidden" class="objectId" value="<?=$order->id?>">
	<div class="main_param">
		<div class="col_in">
			<p class="title">Основные параметры:</p>
			<table width="100%">
				<tr>
					<td class="first">Страна:</td>
					<td>
						<?= $order->country?>
					</td>
				</tr>
				<tr>
					<td class="first">Область:</td>
					<td><?=$object->region?></td>
				</tr>
				<tr>
					<td class="first">Индекс:</td>
					<td><?=$object->index?></td>
				</tr>
				<tr>
					<td class="first">Город:</td>
					<td><?= $order->city?></td>
				</tr>
				<tr>
					<td class="first">Улица:</td>
					<td><?=$order->street?></td>
				</tr>
				<tr>
					<td class="first">Дом:</td>
					<td><?=$order->home?></td>
				</tr>
				<tr>
					<td class="first">Корпус:</td>
					<td><?=$order->block?></td>
				</tr>
				<tr>
					<td class="first">Квартира:</td>
					<td><?=$order->flat?></td>
				</tr>
				<tr>
					<td class="first">Контактное лицо:</td>
					<td><?=$order->person?></td>
				</tr>
				<tr>
					<td class="first">Телефон:</td>
					<td><?=$order->phone?></td>
				</tr>
				<tr>
					<td class="first">Доп. информация<br />(видит клиент):</td>
					<td><textarea name="information" cols="95" rows="5" readonly><?=$order->information?></textarea></td>
				</tr>
				<tr>
					<td class="first">Заметки:</td>
					<td><textarea name="description" cols="95" rows="5" readonly><?=$order->description?></textarea></td>
				</tr>
				<tr>
					<td class="first">% обналички:</td>
					<td><?=$order->cashRate?></td>
				</tr>
				<tr>
					<td class="first">История оповещений<br />партнера:</td>
					<td>
						<script>
							$(function() {
								$( "#resizable" ).resizable();
							});
						</script>
						<div id="resizable" class="ui-widget-content partnerHistory" style="position: absolute; z-index: 1; width: 490px; border: 1px #999 solid; padding: 5px; overflow: auto; height: 100px;">
							<?=$order->partnerNotifyHistory?>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div><!--main_param-->
	<div class="dop_param" style="width: 325px">
		<div class="col_in">
			<p class="title">Дополнительные параметры:</p>
			<table width="100%">
				<tr>
					<td class="first">Номер заказа:</td>
					<td><?=$order->nr; ?></td>
				</tr>
				<tr>
					<td class="first">Номер счета:</td>
					<td><?=$order->invoiceNr; ?></td>
				</tr>
				<tr>
					<td class="first">Номер платежного<br />поручения:</td>
					<td><br /><?=$order->paymentOrderNr; ?></td>
				</tr>
				<tr>
					<td class="first">Статус:</td>
					<td>
						<input type="hidden" name="id" value="<?=$order->id?>" />
						<select name="statusId" style="width:150px; border: 3px solid blue">
							<?if ($orders->getStatuses()): foreach($orders->getStatuses() as $status):?>
							<option value="<?=$status->id?>" <?= $status->id==$order->statusId ? 'selected' : ''?>><?=$status->name?></option>
							<?endforeach; endif?>
						</select>
					</td>
				</tr>
				<tr>
					<td class="first">Категория:</td>
					<td>
						<?=$order->getCategory()->name?>
					</td>
				</tr>
				<tr>
					<td class="first">Дата заявки:</td>
					<td><?=$order->date?></td>
				</tr>
				<tr>
					<td class="first">Дата поставки:</td>
					<td><?=$order->deadline?></td>
				</tr>
				<tr class="hide">
					<td class="first">Приоритет:</td>
					<td><?=$order->priority; ?></td>
				</tr>
				<tr>
					<td class="first">Валютный курс:</td>
					<td><?= $order->rate ? $order->rate : $settingsRate?></td>
				</tr>
				<tr>
					<td class="first">Партнер подтвердил последнее оповещение:</td>
					<td><input style="width: 15px;" type="checkbox" name="partnerNotified" value="1" disabled="disabled" <?= $order->partnerNotified ? 'checked' : ''?> /></td>
				</tr>
				<tr>
					<td colspan="2">
						<table width="100%" style="border: 2px solid #009AFF;">
							<tr>
								<td colspan="2" style="text-align: center; padding-top: 10px;">
									Данные клиента
								</td>
							</tr>
							<?if($client->id):?>
							<tr>
								<td style="text-align: center;">
									ФИО:
								</td>
								<td style="font-weight: normal;">
									<?=$client->getAllName()?>
								</td>
							</tr>
							<?if($client->id):?>
							<tr>
								<td style="text-align: center;">
									Организация:
								</td>
								<td style="font-weight: normal;">
									<?=$client->company?>
								</td>
							</tr>
							<?endif?>
							<tr>
								<td style="text-align: center;">
									Телефон:
								</td>
								<td style="font-weight: normal;">
									<?=$client->phone?>
								</td>
							</tr>
							<?if($client->mobile):?>
							<tr>
								<td style="text-align: center;">
									Моб. телефон:
								</td>
								<td style="font-weight: normal;">
									<?=$client->mobile?>
								</td>
							</tr>
							<?endif?>
							<tr>
								<td style="text-align: center;">
									Логин:
								</td>
								<td style="font-weight: normal;">
									<?=$client->getLogin()?>
								</td>
							</tr>
							<?endif?>
						</table>
					</td>
				</tr>
			</table>
		</div>
	</div><!--dop_param-->
	<div class="clear"></div>
</div><!--main_edit-->