<? include ('header.tpl'); ?>
	<tr>
		<td valign="top">
			<p>
				Клиент просит позвонить по номеру: <b style="font-size: 20px;"><?=$clientPhoneNumber?></b>
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
<? include ('footerAdmin.tpl'); ?>