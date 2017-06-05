<?include(TEMPLATES_ADMIN.'top.tpl');?>

		<link rel="stylesheet" type="text/css" href="/modules/catalog/catalog/css/csvUpdate.css" />
		<script type="text/javascript" src="/modules/catalog/catalog/js/csvUpdate.js"></script>

		<div class="main single">
			<div class="max_width">
				<p class="speedbar">
					<a href="/admin/">Главная</a><span> > </span>
					<a href="/admin/catalog/">Каталог</a><span> > </span>
					CSV цены
				</p>
				<div class="clear"></div>
				<div class="sitebar"></div><!--end sitebar-->
				<div id="contentBlock">
					  <div class="loadBlock">
						  <p class="title">Генерация CSV файла с ценами</p>
						  <form class="dwnld" action="/admin/catalog/downloadPricesCsv/" method="post" enctype="multipart/form-data" target="_blank">
							<select name="partnerId" style="width:150px;">
								<option value="0">Все партнеры</option>
							  <?if ($this->getPartners()): foreach($this->getPartners() as $partner):?>
							  <option value="<?=$partner->id?>"><?=$partner->name?></option>
							  <?endforeach; endif?>
							</select>
							<select name="fabricatorId" style="width:150px;">
								<option value="0">Все производители</option>
								<?if ($fabricators): foreach($fabricators as $fabricator):?>
								<option value="<?=$fabricator->id?>"><?=$fabricator->name?></option>
								<?endforeach; endif?>
							</select>
							<a class="downloadCsv">
								<img src="/admin/images/buttons/but_return.png" alt="" /> Скачать CSV
							</a>
						</form>
					 </div>
					<div class="loadBlock">
						<p class="title">Загрузка и автоматическое изменение цен CSV файлом</p>
						<form class="uploadForm" action="/admin/catalog/csvUpdate/" method="post" enctype="multipart/form-data">
							<select name="partnerId" style="width:150px;">
								<option value="0">Все партнеры</option>
								<?if ($this->getPartners()): foreach($this->getPartners() as $partner):?>
								<option value="<?=$partner->id?>"><?=$partner->name?></option>
								<?endforeach; endif?>
							</select>
							<input class="uploadFile" type="file" name="csvFile">
							<!--<input class="uploadSubmit" type="submit" value="Загрузить CSV">-->
							<!--<input class="uploadSubmit" value="Загрузить CSV">-->
							<a class="uploadSubmit">
								<img src="/admin/images/buttons/upload.png" alt="" /> Загрузить CSV
							</a>
						</form>
					</div>
<?if(isset($resultUpdate)):?>
					<div class="result loadBlock table_edit">
						<p class="ok title"><strong>Результат обновления каталога:</strong></p>
						<table>
							<tr>
								<th class="first">Код</th>
								<th>Название</th>
								<th>Обновление цены</th>
								<th>Обновление себестоимости</th>
								<th class='last'>Обновление наличия</th>
							</tr>
<?foreach($resultUpdate as $code => $row):?>
							<tr>
								<td><?=$code?></td>
								<td><?=$row['name']?></td>
								<td><?=$row['priceUpdate'] ? 'Успешно' : 'Ошибка'?></td>
								<td><?=$row['salePriceUpdate'] ? 'Успешно' : 'Ошибка'?></td>
								<td><?=$row['availabilityUpdate'] ? 'Успешно' : 'Ошибка'?></td>
							</tr>
<?endforeach;?>
						</table>
					</div>
<?endif?>

				</div>
			</div>
		</div><!--main-->
		<div class="vote"></div>
	</div><!--root-->
    <?include(TEMPLATES_ADMIN.'footer.tpl');?>