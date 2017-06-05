<? $headerTitle = 'Таблица заказов для водителей' ?>
<? include ('headerSimple.tpl'); ?>
	<table>
		<tr>
			<td style="padding-left: 10px; font-size: 9px;">
				<p>
					<?=$data['text']?>
					<br /><br /><br />
					<?=$data['table']?>
					<br />
				</p>
			</td>
		</tr>
	</table>
<? include ('footerAdmin.tpl'); ?>