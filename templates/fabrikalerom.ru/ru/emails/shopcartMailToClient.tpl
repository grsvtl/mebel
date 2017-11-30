<? include ('header.tpl'); ?>
			<tr>
				<td colspan="2" style="padding-left: 10px;">
					<h2 class="subject" style="width: 100%;text-align: center;color: #24667B;">Получен новый заказ с сайта <?=SEND_FROM?></h2>
					<p>
						Здравствуйте.
						<br /><br />
						С сайта <?=SEND_FROM?> был отправлен новый заказ в котором указывается ваш e-mail.
						<br /><br />
						Данные указанные в заказе с сайта:
						<br />
						Имя: <strong><?=$data['clientName']?></strong>
						<br />
						Телефон: <strong><?=$data['phone']?></strong>
						<br />
						Email: <strong><?=$data['email']?></strong>
						<br /><br />
						Содержание заказа:
						<br />
						Тип заказа: <strong><?=$serviceType?></strong>
						<br />
						<table width="100%" border="1" style="border-color: grey; border-spacing: 0px; text-align: center;">
							<tr style="background-color: #DAE2FE; color: #24667B;">
								<th colspan="2" class="first"><div>Название товара или услуги</div></th>
								<th><div>Количество</div></th>
								<th class="last"><div>Стоимость</div></th>
							</tr>
							<?foreach($shopcart as $good):?>
							<tr>
								<td><div class="image"><img src="http://<?= $_SERVER['HTTP_HOST'].$good->getFirstImage()->getFocusImage('100x0')?>" alt="" /></div></td>
								<td><p class="name"><?=$good->getName()?></p></td>
								<td><p><?=$good->getQuantity()?></p></td>
								<td><p class="price"><span><span><?=$good->getTotalPrice()?></span>руб </p></td>
							</tr>
							<?  endforeach;?>
							<tr class="itog">
								<td colspan="3"><p class="sum"><strong>ИТОГО:</strong></p></td>
								<td><p class="price"><strong><span><?=$shopcart->getTotalPrice()?></span> руб.</strong></p></td>
							</tr>
						</table>
					</p>
					<br />
					<p>
						Если вы не ничего не заказывали, просто проигнорируйте это сообщение.
					</p>
				</td>
			</tr>
<? include ('footerClient.tpl'); ?>