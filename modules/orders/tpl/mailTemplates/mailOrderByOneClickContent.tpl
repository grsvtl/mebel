<? include ('headerOneClick.tpl'); ?>
	<table>
		<tr>
			<td>
				<b style="font-size: 14px;">Выбранный товар:</b>
				<table width="150" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td style="font-size: 12px; padding: 0;">
							Название:
						</td>
						<td style="font-size: 13px; padding: 0;">
							<b><?=$good->getName()?></b>
						</td>
					</tr>
					<tr>
						<td style="font-size: 13px; padding: 0;">
							Код:
						</td>
						<td style="font-size: 12px; padding: 0;">
							<b><?=$good->getCode()?></b>
						</td>
					</tr>
					<tr>
						<td colspan="2" style="padding: 0;">
							<img src="<?=DIR_HTTP?><?=$good->getFirstPrimaryImage()->getImage('150x150')?>">
						</td>
					</tr>
				</table>
			</td>
			<td valign="top">
				<p>
					Позвонить клиенту по номеру: <b style="font-size: 20px;"><?=$clientPhoneNumber?></b>
				</p>
				<?if($managers):?>
				Менеджеры :&nbsp;&nbsp;&nbsp;&nbsp;
				<?foreach($managers as $manager):?>
				<?=$manager?>&nbsp;&nbsp;&nbsp;&nbsp;
				<?endforeach?>
				<br /><br />
				<?endif?>
			</td>
		</tr>
	</table>
<? include ('footerAdmin.tpl'); ?>