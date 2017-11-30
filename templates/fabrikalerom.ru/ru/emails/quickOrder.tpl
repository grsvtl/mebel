<? include ('header.tpl'); ?>
			<tr>
				<td colspan="2" style="padding-left: 10px;">
					<h2 class="subject" style="width: 100%;text-align: center;color: #24667B;">Быстрый заказ с сайта <?=SEND_FROM?></h2>
					<p>
						<br />
						Оформлена заявка из формы быстрого заказа на сайте <?SEND_FROM?>!
						<br />
						Свяжитесь с клиентом в кратчайшее время!
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td style="padding-left: 10px;">
									<img src="<?=DIR_HTTP?><?=$this->getGood()->getFirstPrimaryImage()->getFocusImage('350x0')?>">
								</td>
								<td style="padding-left: 10px;">
									<strong>Данные клиента:</strong>
									<br />
									Имя: <strong><?=$data['name']?></strong>
									<br />
									Телефон: <strong><?=$data['phone']?></strong>
									<br />
									Email: <strong><?=$data['email']?></strong>
									<br />
									Текст: <strong><?=$data['text']?></strong>
									<br /><br />
									<strong>Данные товара:</strong>
									<br />
									Наименование: <strong><?=$this->getGood()->getName()?></strong>
									<br />
									Код: <strong><?=$this->getGood()->getInfo()->code?></strong>
									<br />
									Цена: <strong>
										<?if($this->getGood()->isZeroPrice()):?>
										договорная
										<?else:?>
										<?=$this->getGood()->getShowPrice()?> <span class="rub">p</span></strong>
										<?endif?>
									<br />
									Ссылка: <a href="<?=rtrim(DIR_HTTP,'/')?><?=$this->getGood()->getPath()?>">Просмотреть на сайте</a></strong>
								</td>
							</tr>
						</table>
					</p>
				</td>
			</tr>
<? include ('footerAdmin.tpl'); ?>