<div class="main_edit">
	<script type="text/javascript" src="/modules/orders/js/orderHandler.js"></script>
	<script type="text/javascript" src="/modules/orders/js/order.class.js"></script>
	<script type="text/javascript" src="/js/ajaxLoader.class.js"></script>
	<script type="text/javascript" src="/modules/orders/js/autosuggest/autosuggest.js"></script>
	<script type="text/javascript" src="/modules/orders/js/autosuggest/jquery.autoSuggest.js"></script>
	<link rel="stylesheet" type="text/css" href="/modules/orders/css/autoSuggest.css" />
	<input type="hidden" class="objectId" value="<?=$order->id?>">
	<div class="main_param">
		<div class="col_in">
			<p class="title">Основные параметры:</p>
			<table width="100%">
				<tr>
					<td class="first">Страна:</td>
					<td>
						<select name="country" style="width:150px;">
							<option value="Россия" <?= $order->country=='Россия' ? 'selected' : ''?>>Россия</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="first">Область:</td>
					<td><input type="text" name="region" value="<?=$object->region?>" /></td>
				</tr>
				<tr>
					<td class="first">Индекс:</td>
					<td><input type="text" name="index" value="<?=$object->index?>" /></td>
				</tr>
				<tr>
					<td class="first">Город:</td>
					<td><input type="text" name="city" value="<?= $order->city ? $order->city : 'г.Москва'?>" /></td>
				</tr>
				<tr>
					<td class="first">Улица:</td>
					<td><input type="text" name="street" value="<?=$order->street?>" /></td>
				</tr>
				<tr>
					<td class="first">Дом:</td>
					<td><input type="text" name="home" value="<?=$order->home?>" /></td>
				</tr>
				<tr>
					<td class="first">Корпус:</td>
					<td><input type="text" name="block" value="<?=$order->block?>" /></td>
				</tr>
				<tr>
					<td class="first">Квартира:</td>
					<td><input type="text" name="flat" value="<?=$order->flat?>" /></td>
				</tr>
				<tr>
					<td class="first">Контактное лицо:</td>
					<td><input type="text" name="person" value="<?=$order->person?>" /></td>
				</tr>
				<tr>
					<td class="first">Телефон:</td>
					<td><input type="text" name="phone" value="<?=$order->phone?>" /></td>
				</tr>
				<tr>
					<td class="first">Доп. информация<br />(видит клиент):</td>
					<td><textarea name="information" cols="95" rows="5"><?=$order->information?></textarea></td>
				</tr>
				<tr>
					<td class="first">Заметки:</td>
					<td><textarea name="description" cols="95" rows="5"><?=$order->description?></textarea></td>
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
					<td class="first">Модуль:</td>
					<td>
						<select name="moduleId" style="width:150px;">
							<option></option>
							<?if ($this->getController('ModulesDomain')->getModules()->current()): foreach($this->getController('ModulesDomain')->getModules() as $module):?>
							<option value="<?=$module->id?>" <?= $module->id==$order->moduleId ? 'selected' : ''?>><?=$module->name?></option>
							<?endforeach; endif?>
						</select>
					<td>
				</tr>
				<tr>
					<td class="first">Домен:</td>
					<td>
						<select name="domain" style="width:150px;">
							<option></option>
							<?if ($this->getController('ModulesDomain')->getAllDomains()): foreach($this->getController('ModulesDomain')->getAllDomains() as $domain=>$value):?>
							<option value="<?=$domain?>" <?= $domain==$order->domain ? 'selected' : ''?>><?=$domain?></option>
							<?endforeach; endif?>
						</select>
					</td>
				</tr>
				<tr>
					<td class="first">Номер заказа:</td>
					<td><input name="nr" value="<?=$order->nr; ?>" /></td>
				</tr>
				<tr>
					<td class="first">Номер счета:</td>
					<td><input name="invoiceNr" value="<?=$order->invoiceNr; ?>" /></td>
				</tr>
				<tr>
					<td class="first">Номер платежного<br />поручения:</td>
					<td><br /><input name="paymentOrderNr" value="<?=$order->paymentOrderNr; ?>" /></td>
				</tr>
				<tr>
					<td class="first">Выплачен %:</td>
					<td><input name="paidPercent" type="checkbox" <?=($order->paidPercent)?'checked':''?> value="1" /></td>
				</tr>
				<tr>
					<td class="first">Статус:</td>
					<td>
						<input type="hidden" name="id" value="<?=$order->id?>" />
						<select name="statusId" style="width:150px;">
							<?if ($orders->getStatuses()): foreach($orders->getStatuses() as $status):?>
							<option value="<?=$status->id?>" <?= $status->id==$order->statusId ? 'selected' : ''?>><?=$status->name?></option>
							<?endforeach; endif?>
						</select>
					</td>
				</tr>
				<tr>
					<td class="first">Статус оплаты:</td>
					<td>
						<input type="hidden" name="id" value="<?=$order->id?>" />
						<select name="paymentStatusId" style="width:150px;">
							<?if ($orders->getPaymentStatuses()): foreach($orders->getPaymentStatuses() as $paymentStatus):?>
							<option value="<?=$paymentStatus->id?>" <?= $paymentStatus->id==$order->paymentStatusId ? 'selected' : ''?>><?=$paymentStatus->name?></option>
							<?endforeach; endif?>
						</select>
					</td>
				</tr>
				<tr>
					<td class="first">Способ оплаты:</td>
					<td>
						<select name="cashPayment">
							<option value="0" <?=$order->cashPayment==0 ? 'selected' : ''?>>безналичный</option>
							<option value="1" <?=$order->cashPayment==1 ? 'selected' : ''?>>наличный</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="first">Категория:</td>
					<td>
						<select name="categoryId" style="width:150px;">
							<option></option>
							<? if ($mainCategories->count()): foreach($mainCategories as $categoryObject):?>
							<option value="<?=$categoryObject->id?>" <?= $categoryObject->id==$order->categoryId ? 'selected' : ''; ?>><?=$categoryObject->name?></option>
								<?if ($categoryObject->getChildren() != NULL): foreach($categoryObject->getChildren() as $children):?>
								<option value="<?=$children->id?>" <?= $children->id==$order->categoryId ? 'selected' : ''; ?>>&nbsp;&nbsp;|-&nbsp;<?=$children->name?></option>
									<? if ($children->getChildren() != NULL): foreach($children->getChildren() as $children2):?>
									<option value="<?=$children2->id?>" <?= $children2->id==$order->categoryId ? 'selected' : ''; ?>>&nbsp;&nbsp;&nbsp;&nbsp;|-&nbsp;<?=$children2->name?></option>
									<?endforeach; endif?>
								<?endforeach; endif?>
							<?endforeach; endif?>
						</select>
					</td>
				</tr>
				<tr>
					<td class="first">Дата заявки:</td>
					<td><input class="date" name="date" title="Date" value="<?=$order->date?>"/></td>
				</tr>
				<tr>
					<td class="first">Дата поставки:</td>
					<td><input class="date" name="deadline" title="Date" value="<?=$order->deadline?>"/></td>
				</tr>
				<tr class="hide">
					<td class="first">Приоритет:</td>
					<td><input name="priority" value="<?=$order->priority; ?>" /></td>
				</tr>
				<tr>
					<td class="first">Валютный курс:</td>
					<td><input name="rate" value="<?= $order->rate ? $order->rate : $settingsRate?>" /></td>
				</tr>
				<tr>
					<td class="first">Партнер:</td>
					<td>
						<select
							name="partnerId"
							style="width:150px;"
							class="changePartner"
							data-action="/admin/orders/changePartner/<?=$order->id?>/"
						>
							<option></option>
							<?if ($activePartners): foreach($activePartners as $partner):?>
							<option value="<?=$partner->id?>" <?= $partner->id==$order->partnerId ? 'selected' : ''?>><?=$partner->name?></option>
							<?endforeach; endif?>
						</select>
					</td>
				</tr>
				<tr>
					<td class="first">% обналички:</td>
					<td><input name="cashRate" value="<?=$order->cashRate?>" /></td>
				</tr>
				<tr>
					<td class="first">Партнер подтвердил последнее оповещение:</td>
					<td><input style="width: 15px;" type="checkbox" name="partnerNotified" value="1" <?= $order->partnerNotified ? 'checked' : ''?> /></td>
				</tr>
				<tr>
					<td class="first">Менеджер:</td>
					<td>
						<select name="managerId" style="width:150px;">
							<option></option>
							<?if ($activeManagers): foreach($activeManagers as $manager):?>
							<option value="<?=$manager->id?>" <?= $manager->id==$order->managerId ? 'selected' : ''?>><?=$manager->getLogin()?></option>
							<?endforeach; endif?>
						</select>
					</td>
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
							<tr>
								<td colspan="2" style="text-align: right; padding-right: 20px;">
									<a style="color: #009AFF;" target="blank" href="/admin/clients/client/<?=$client->id?>/">подробно о клиенте</a>
								</td>
							</tr>
							<?endif?>
							<tr>
								<td colspan="2" style="text-align: center;">
									<input type="text" class="inputClient">
									<input type="hidden" name="curentClientId" value="<?=$order->clientId?>">
									<input type="hidden" name="pastClientId" value="">
									<img class="inputClientLoader" style="margin: 5px 0px -10px 140px; display: none;" src="/images/loaders/loading-small.gif" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
	</div><!--dop_param-->
	<div class="clear"></div>
</div><!--main_edit-->