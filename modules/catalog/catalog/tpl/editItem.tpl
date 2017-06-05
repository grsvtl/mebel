<?if ($object->id):?><input type="hidden" name="id" value="<?=$object->id?>"/><?endif;?>
<div class="main_edit">
	<div class="main_param">
		<div class="col_in">
			<p class="title">Основные параметры:</p>
			<table width="100%">
				<tr>
					<td class="first">Имя:</td>
					<td><input type="text" name="name" value="<?=$object->getName()?>" /></td>
				</tr>
				<tr>
					<td class="first">Описание:</td>
					<td><textarea name="description" cols="95" rows="10"><?=$object->description?></textarea>
				</tr>
				<tr>
					<td class="first">Текст:</td>
					<td><textarea name="text" cols="95" rows="40" style="height: 440px;"><?=$object->text?></textarea>
				</tr>
				<tr>
					<td class="first">Youtube видео:</td>
					<td><input name="video" style="width:498px;" value="<?=$object->video?>">
				</tr>
			</table>
		</div>
	</div><!--main_param-->
	<div class="dop_param">
		<div class="col_in">
			<p class="title">Дополнительные параметры:</p>
			<table width="100%">
				<tr>
					<td class="first">Код:</td>
					<!--<td><input name="code" value="<?//=$object->getCode()?>" /></td>-->
					<td><?= is_numeric($object->getCode()) ? $object->getCode() : \core\db\Db::getNextId('tbl_catalog')?></td>
					<td><input type="hidden" name="code" value="<?= is_numeric($object->getCode()) ? $object->getCode() : \core\db\Db::getNextId('tbl_catalog')?>" /></td>
				</tr>
				<tr>
					<td class="first">Статус:</td>
					<td>
						<select name="statusId" style="width:150px;">
							<?if ($objects->getStatuses()): foreach($objects->getStatuses() as $status):?>
							<option value="<?=$status->id?>" style="color:<?=$status->color?>; font-weight:bold;" <?= $status->id==$object->statusId ? 'selected' : ''?>><?=$status->name?></option>
							<?endforeach; endif?>
						</select>
					</td>
				</tr>
				<tr>
					<td class="first">Категория:</td>
					<td>
						<select name="categoryId" style="width:150px;">
						<option></option>
						<?if ($objects->getMainCategories()->count()): foreach($objects->getMainCategories() as $categoryObject):?>
						<option value="<?=$categoryObject->id?>" <?=($categoryObject->id==$object->categoryId) ? 'selected' : ''; ?>><?=$categoryObject->name?></option>
							<?php if ($categoryObject->getChildren()): foreach($categoryObject->getChildren() as $children):?>
							<option value="<?=$children->id?>" <?=($children->id==$object->categoryId) ? 'selected' : ''; ?>>&nbsp;&nbsp;|-&nbsp;<?=$children->name?></option>
								<?php if ($children->getChildren()): foreach($children->getChildren() as $children2):?>
								<option value="<?=$children2->id?>" <?=($children2->id==$object->categoryId) ? 'selected' : ''; ?>>&nbsp;&nbsp;&nbsp;&nbsp;|-&nbsp;<?=$children2->name?></option>
								<?php endforeach; endif;?>
							<?php endforeach; endif;?>
						<?php endforeach; endif;?>
						</select>
					</td>
				</tr>
				<tr>
					<td class="first">Производитель:</td>
					<td>
						<select name="fabricatorId" style="width:150px;">
							<option></option>
							<?if ($objects->getFabricators()): foreach($objects->getFabricators() as $fabricator):?>
							<option value="<?=$fabricator->id?>" <?= $fabricator->id==$object->fabricatorId ? 'selected' : ''?>><?=$fabricator->name?></option>
							<?endforeach; endif?>
						</select>
					</td>
				</tr>
				<tr>
					<td class="first">Серия:</td>
					<td>
						<?= $this->getSeriaIdSelect($object->fabricatorId)?>
					</td>
				</tr>
				<tr>
					<td class="first">Дополнительные категории:</td>
					<td>
						<select name="additionalCategories[]" multiple="multiple" class="additionalCategories" style="width:150px;">
						<?if ($objects->getMainCategories()->count()): foreach($objects->getMainCategories() as $categoryObject):?>
						<optgroup label="<?=$categoryObject->name?>">
							<?php if ($categoryObject->getChildren()): foreach($categoryObject->getChildren() as $children):?>
							<option value="<?=$children->id?>" <?=   isset($object->id)   ?   (in_array($children->id, $object->additionalCategoriesArray)) ? 'selected' : ''   :    '' ?>><?=$children->name?></option>
								<?php if ($children->getChildren()): foreach($children->getChildren() as $children2):?>
							<option value="<?=$children2->id?>" <?=   isset($object->id)   ?   (in_array($children->id, $object->additionalCategoriesArray)) ? 'selected' : ''   :    '' ?>>&nbsp;&nbsp;|-&nbsp;<?=$children2->name?></option>
								<?php endforeach; endif;?>
							<?php endforeach; endif;?>
						</optgroup>
						<?php endforeach; endif;?>
						</select>
					</td>
				</tr>
				<tr>
					<td class="first">Дата:</td>
					<td><input class="date" name="date" title="Date" value="<?=$object->date?>"/></td>
				</tr>
				<tr>
					<td class="first">Приоритет:</td>
					<td><input name="priority" value="<?=$object->priority; ?>" /></td>
				</tr>
				<tr>
					<td class="first">Оплата карточкой:</td>
					<td><input type="checkbox" name="card" value="1" style="width: 20px; height: 20px;" <?=($object->card)?'checked':'';?> /></td>
				</tr>

				<?if(isset($object->id)):?>
				<?if($object->isDana()):?>
				<tr>
					<td class="first">На главную Дана:</td>
					<td><input type="checkbox" name="onMainDanaPage" value="1" style="width: 20px; height: 20px;" <?=($object->onMainDanaPage)?'checked':'';?> /></td>
				</tr>
				<?endif?>
				<?endif?>

                <?if(isset($object->id)):?>
                    <?if($object->isMeri()):?>
                        <tr>
                            <td class="first">На главную Мэри:</td>
                            <td><input type="checkbox" name="onMainMeriPage" value="1" style="width: 20px; height: 20px;" <?=($object->onMainMeriPage)?'checked':'';?> /></td>
                        </tr>
                    <?endif?>
                <?endif?>
			</table>

			<p class="title">Sitemap XML:</p>
			<table width="100%">
				<tr>
					<td class="first">Посл. обновление:</td>
					<td>
						<input
							class="date" name="lastUpdateTime" title="Время последнего обновления"
							value="<?=\core\utils\Dates::toSimpleDate( \core\utils\Dates::dateTimeToTimestamp( $this->isNoop($object) ? date('Y-m-d h:i:s') : $object->getLastUpdateTime() ) )?>"
						/>
					</td>
				</tr>
				<tr>
					<td class="first">Приоритет:</td>
					<td>
						<select name="sitemapPriority">
							<?foreach (\core\seo\sitemap\SitemapValues::getPriorityValues() as $value):?>
							<option value="<?=$value?>" <?=($object->sitemapPriority == $value) ? 'selected' : ''?>>
									<?=
										$value=='default'
										?
										'по урл'.($object->id ? ' ('.$object->getSitemapPriorityByPath($object->getPath()).')' : '')
										:
										$value
									?>
							</option>
							<?endforeach;?>
						</select>
					</td>
				</tr>
				<tr>
					<td class="first">Частота обновлений:</td>
					<td>
						<select name="changeFreq">
<?foreach (\core\seo\sitemap\SitemapValues::getChangeFreqValues() as $key => $value):?>
							<option value="<?=$key?>" <?=($object->getChangeFreq() == $key) ? 'selected' : ''?>><?=$value?></option>
<?endforeach;?>
						</select>
					</td>
				</tr>
			</table>
		</div>
	</div><!--dop_param-->
	<?$this->includeTemplate('images')?>
	<div class="clear"></div>
</div><!--main_edit-->