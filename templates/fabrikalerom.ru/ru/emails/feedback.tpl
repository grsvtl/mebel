<? include ('header.tpl'); ?>
			<tr>
				<td colspan="2" style="padding-left: 10px;">
					<h2 class="subject" style="width: 100%;text-align: center;color: #24667B;">Новое письмо с сайта <?=SEND_FROM?></h2>
					<p>
						Здравствуйте.
						<br /><br />
						Со страницы <?=$_SERVER['HTTP_REFERER']?> сайта <?=SEND_FROM?> было отправлено новое письмо.
						<br /><br />
						Данные отправителя:
						<br />
						Имя: <strong><?=$data['askName']?></strong>
						<br />
						Телефон: <strong><?=$data['askPhone']?></strong>
						<br />
						Email: <strong><?=$data['askEmail']?></strong>
						<br /><br />
						Текст: <strong><?=$data['askText']?></strong>
						<br /><br />
					</p>
				</td>
			</tr>
<? include ('footerAdmin.tpl'); ?>