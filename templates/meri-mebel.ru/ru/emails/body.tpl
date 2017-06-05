<? include ('header.tpl'); ?>
			<tr>
				<td colspan="2" style="padding: 5px;border-bottom: 1px dotted blue; color: #000;" class="title">
					Новая вопрос с сайта <a href="<?= DIR_HTTP?>"><?= DIR_HTTP?></a>
				</td>
			</tr>
			<tr>
				<td width="150"  style="padding: 5px;border-bottom: 1px dotted #B23840; color: #000;" class="title">
					Имя: 
				</td>
				<td style="padding: 5px;border-bottom: 1px dotted #B23840; color: #000;" class="title">
					<?=$data['name'] ?>
				</td>			
			</tr>
			<tr>
				<td style="padding: 5px;border-bottom: 1px dotted #B23840; color: #000;" class="title">
					E-mail: 
				</td>
				<td style="padding: 5px;border-bottom: 1px dotted #B23840; color: #000;" class="title">
					<?=$data['email'] ?>
				</td>			
			</tr>
			<tr>
				<td style="padding: 5px;border-bottom: 1px dotted #B23840; color: #000;" class="title">
					Сообщение: 
				</td>
				<td style="padding: 5px;border-bottom: 1px dotted #B23840; color: #000;" class="title">
					<?=$data['message'] ?>
				</td>			
			</tr>
<? include ('footer.tpl'); ?>