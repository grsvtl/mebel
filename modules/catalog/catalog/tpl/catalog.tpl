<?include(TEMPLATES_ADMIN.'top.tpl');?>

<!--        <script type="text/javascript" src="/admin/js/base/system/sorting.js"></script>-->

		<script type="text/javascript" src="/modules/catalog/catalog/js/sorting.js"></script>
		<script type="text/javascript" src="/modules/catalog/catalog/js/groupSort.js"></script>
		<script type="text/javascript" src="/admin/js/base/system/groupActions.js"></script>
		<div class="main single">
			<div class="max_width">
				<div class="action_buts">
					<?if( ! $this->isAuthorisatedUserAnManager()):?>
					<a href="/admin/catalog/csvUpdate/"><img src="/admin/images/buttons/excelDoc.png" alt="" /> CSV цены</a>
					<a href="/admin/catalog/catalogItem/"><img src="/admin/images/buttons/add.png" alt="" /> Создать</a>
					<?endif?>
					<a class="filters pointer"><img src="/admin/images/buttons/search.png" alt="" /> Фильтрация</a>
					<?if( ! $this->isAuthorisatedUserAnManager()):?>
					<a href="/admin/catalog/categories/"><img src="/admin/images/buttons/folder.png" alt="" /> Категории</a>
					<?endif?>
				</div>
				<p class="speedbar"><a href="/admin/">Главная</a>
					<span> > </span>
					Каталог
				</p>
				<div class="clear"></div>
				<!-- Start: Filetrs Block -->
				<div id="filter-form"  style="<?=(isset($_REQUEST['form_in_use'])?'display:block;':'display:none;')?>">
					<form id="search" action="" method="get">
						<input type="hidden" name="form_in_use" value="true" />
						<table>
							<tr>
								<td class="right">Категория:</td>
								<td>
									<select class="filterInput categoryId" name="categoryId">
										<option></option>
										<?php if ($objects->getMainCategories()->count() != 0): foreach($objects->getMainCategories() as $categoryObject):?>
										<option value="<?=$categoryObject->id?>" <?=($categoryObject->id==$this->getGET()['categoryId']) ? 'selected' : ''; ?>><?=$categoryObject->name?></option>
											<?php if ($categoryObject->getChildren()): foreach($categoryObject->getChildren() as $children):?>
											<option value="<?=$children->id?>" <?=($children->id==$this->getGET()['categoryId']) ? 'selected' : ''; ?>>&nbsp;&nbsp;|-&nbsp;<?=$children->name?></option>
												<?php if ($children->getChildren() != NULL): foreach($children->getChildren() as $children2):?>
												<option value="<?=$children2->id?>" <?=($children2->id==$this->getGET()['categoryId']) ? 'selected' : ''; ?>>&nbsp;&nbsp;&nbsp;&nbsp;|-&nbsp;<?=$children2->name?></option>
												<?php endforeach; endif;?>
											<?php endforeach; endif;?>
										<?php endforeach; endif;?>
									</select>
								</td>
								<td class="right">Статус:</td>
								<td><select class="filterInput" name="statusId">
										<option value="">&nbsp;</option>
										<?php foreach ($objects->getStatuses() as $status):?>
										<option value="<?=$status->id?>" <?=($this->getGET()['statusId']==$status->id)?'selected':''?>><?=$status->name?></option>
										<?php endforeach;?>
									</select>
								</td>
								<td class="right">ID:</td>
								<td><input class="filterInput" type="text" name="id" value="<?=$this->getGET()['id']?>" /></td>
								<td class="right">Код:</td>
								<td><input class="filterInput" type="text" name="code" value="<?=$this->getGET()['code']?>" /></td>
							</tr>
							<tr>
								<td class="right">Производители:</td>
								<td><select class="filterInput" name="fabricatorId">
										<option value="">&nbsp;</option>
										<?php foreach ($objects->getFabricators() as $fabricator):?>
										<option value="<?=$fabricator->id?>" <?=($this->getGET()['fabricatorId']==$fabricator->id)?'selected':''?>><?=$fabricator->name?></option>
										<?php endforeach;?>
									</select>
								</td>
								<td class="right">Название:</td>
								<td><input class="filterInput" type="text" name="name" value="<?=$this->getGET()['name']?>" /></td>
								<td class="right">Описание:</td>
								<td><textarea style="width: 171px" name="description" cols="60"><?=$this->getGET()['description']?></textarea></td>
								<td class="right">Текст:</td>
								<td><textarea style="width: 171px" name="text" cols="60"><?=$this->getGET()['text']?></textarea></td>
							</tr>
                            <tr>
                                <td class="right">Подтовары:</td>
                                <td>
                                    <select class="filterInput" name="subGoods">
                                        <option value=""> </option>
                                        <option value="with" <?= $this->getGET()['subGoods']=='with' ? 'selected' : ''?>>С подтоварами</option>
                                        <option value="without" <?= $this->getGET()['subGoods']=='without' ? 'selected' : ''?>>Без подтоваров</option>
                                    </select>
                                </td>
                                <td class="right">Спец. метки:</td>
                                <td>
                                    <select class="filterInput" name="mark">
                                        <option value="">&nbsp;</option>
                                        <?foreach ($objects->getConfig()->getCheckboxFieldsArray() as $alias=>$name):?>
                                        <option value="<?=$alias?>" <?= $this->getGET()['mark']==$alias ? 'selected' : ''?>><?=$name?></option>
                                        <?php endforeach;?>
                                    </select>
                                </td>
                                <td class="right"></td>
                                <td></td>
                                <td class="right"></td>
                                <td></td>
                            </tr>
							<tr>
								<td colspan="8">
									<div class="action_buts">
										<a class="pointer" onclick="$('#search').submit()"><img src="/admin/images/buttons/search.png" /> Поиск</a>
										<a class="resetFilters" href="/admin/<?=$_REQUEST['controller']?>/"><img src="/admin/images/buttons/delete.png" /> Сбросить фильтры</a>
									</div>
								</td>
							<tr>
						</table>
					</form>
				</div>
				<!-- End: Filters Block -->
				<? if (!count($objects)): echo 'No Data'; else: ?>
				<div class="table_edit">
<!--                    <table id="objects-tbl" data-sortUrlAction="/admin/catalog/changePriority/?" width="100%">-->
                    <table id="objects-tbl" width="100%">
						<tr>
							<th colspan="2" class="first">#</th>
							<th>Фото</th>
							<th>id</th>
							<th>
                                Название<br>(цена / <font color="#a9a9a9">старая цена</font>)
                                <i><font color="#4b0082">наличие подтоваров</font></i>
                                ,
                                <i><font color="#ff00ff">акции</font></i>
                            </th>
							<th>Производитель</th>
							<th>Категория</th>
							<th>Статус</th>



<!--                            <th class="last" colspan="4">Приоритет</th>-->




							<th class="last" colspan="4">
                                <a href="/admin/catalogPriority/catalog" class="btn">Редактировать приоритет</a>
                            </th>
						</tr>
						<? $counter = 0; foreach ($objects as $object): ?>
							<tr id="id<?=$object->id?>" class="dblclick" data-url="/admin/catalog/catalogItem/<?= $object->id?>" data-id="<?= $object->id?>" data-priority="<?= $object->priority?>">
								<td><input type="checkbox" class="groupElements" /></td>
								<td><?=++$counter;?></td>
								<td>
									<a href="<?=$object->getFirstPrimaryImage()->getImage('800x600')?>" class="lightbox noNextPrev">
										<img src="<?=$object->getFirstPrimaryImage()->getImage('40x40')?>" />
									</a>
								</td>
								<td><?=$object->id?></td>
								<td>
                                    <p class="name">
                                        <b><?=$object->getName()?></b>
                                        <br><br>
                                        (
                                            <?=number_format( $object->getShowPrice(), 0, ',', ' ' )?>
                                            /
                                            <font color="#a9a9a9"><?=number_format( $object->getShowOldPrice(), 0, ',', ' ' )?></font>
                                        )
                                        <?= $object->isSubGoodsExists() ? '<i><font color="#4b0082">есть подтовары</font></i>' : ''?>
                                        <?= $object->getOffer() ? '<i><font color="#ff00ff">акция</font></i>' : ''?>
                                    </p>
                                </td>
								<td><p class="name"><i><?=$object->getFabricator()->getName()?></i></p></td>
								<td><p class="name"><?=$object->getCategory()->name?></p></td>
								<td><p class="status on"><font color="<?=$object->getStatus()->color?>"><?=$object->getStatus()->name?></font></p></td>


<!--                                <td class="td_bord sortHandle header">--><?//= $object->priority?><!--</td>-->



                                <td class="td_bord header">
                                </td>
								<td><a href="/admin/catalog/catalogItem/<?=$object->id?>/" class="pen"></a></td>
								<td><a class="del pointer button confirm" data-confirm="Remove the item?" data-action="/admin/catalog/remove/<?=$object->id?>/" data-callback="postRemoveArticle"></a></td>
							</tr>
						<? endforeach; ?>
					</table>
				</div>
				<?endif?>

				<?$this->printPager($pager, 'pager')?>

				<div class="action_edit">
					<form id="groupArray" action="/admin/catalog/groupActions/" class="groupArray" method="post" data-callback="reloadPage">
						<table>
							<tr>
								<td><a href="javascript:" class="check_all"><span>Выделить все</span></a></td>
								<td>
									<select class="groupActionSelect">
										<option value="">- С выделенными -</option>
										<option value="statusId">Назначить статус</option>
										<option value="categoryId">Назначить категорию</option>
										<option value="groupRemove">Удалить</option>
                                        <option value="changePrice">Изменить цены</option>
									</select>
								</td>
							</tr>
							<tr class="groupAction statusId">
								<td class="first"><strong></strong></td>
								<td>
									<select id="statusId" name="statusId">
										<option value="">- Статусы -</option>
										<?php foreach ($objects->getStatuses() as $status):?>
										<option value="<?=$status->id?>" <?=($this->getGET()['statusId']==$status->id)?'selected':''?>><?=$status->name?></option>
										<?php endforeach;?>
									</select>
								<td>
									<button  class="ok groupArraySubmit">
										<span>ок</span>
									</button>
								</td>
							</tr>
							<tr class="groupAction categoryId">
								<td class="first"><strong></strong></td>
								<td>
									<select id="categoryId" name="categoryId">
										<option value="">- Категории -</option>
										<?php if ($objects->getMainCategories()->count() != 0): foreach($objects->getMainCategories() as $categoryObject):?>
										<option value="<?=$categoryObject->id?>" <?=($categoryObject->id==$this->getGET()['categoryId']) ? 'selected' : ''; ?>><?=$categoryObject->name?></option>
											<?php if ($categoryObject->getChildren()): foreach($categoryObject->getChildren() as $children):?>
											<option value="<?=$children->id?>" <?=($children->id==$this->getGET()['categoryId']) ? 'selected' : ''; ?>>&nbsp;&nbsp;|-&nbsp;<?=$children->name?></option>
												<?php if ($children->getChildren() != NULL): foreach($children->getChildren() as $children2):?>
												<option value="<?=$children2->id?>" <?=($children2->id==$this->getGET()['categoryId']) ? 'selected' : ''; ?>>&nbsp;&nbsp;&nbsp;&nbsp;|-&nbsp;<?=$children2->name?></option>
												<?php endforeach; endif;?>
											<?php endforeach; endif;?>
										<?php endforeach; endif;?>
									</select>
								</td>
								<td>
									<button  class="ok groupArraySubmit" name="actionButton">
										<span>ок</span>
									</button>
								</td>
							</tr>
							<tr class="groupAction groupRemove" name="removeButton">
								<td class="first"></td>
								<td>
									<button class="remove button confirm active" data-confirm="Удалить объекты?" data-action="/admin/catalog/groupRemove/" data-data="input[name*=group]" data-callback="reloadPage">ок</button>
								</td>
							</tr>

                            <tr class="groupAction changePrice">
                                <script src="/modules/catalog/catalog/js/changePrices.js"></script>
                                <td class="first"></td>
                                <td style="border: 2px dotted #009AFF; padding: 10px; margin-bottom: 10px;">
                                    <div style="float:left;">
                                        <label><input type="checkbox" name="prices[price]"> текущая цена</label>
                                        <br>
                                        <label><input type="checkbox" name="prices[oldPrice]"> старая цена</label>
                                    </div>

                                    <select name="changePriceSign" style="float:left; margin: 8px; width: 85px;">
                                        <option></option>
                                        <option value="+">повысить</option>
                                        <option value="-">понизить</option>
                                    </select>

                                    <div style="float:left; margin: 8px;">на</div>

                                    <input type="text" name="changePriceValue" style="float: left;margin: 8px;width: 60px;padding: 1px 4px;">

                                    <select name="changePriceCurrency" style="float:left; margin: 8px; width: 37px;">
                                        <option></option>
                                        <option value="р">р</option>
                                        <option value="%">%</option>
                                    </select>

                                    <div class="action_buts" style="float:left;">
                                        <a class="changePriceTrigger"><img src="/admin/images/buttons/but_apply.png"> Изменить</a>
                                    </div>

                                    <div class="changePriceErrorMessage hide" style="float: left; margin: 8px; padding: 1px 4px; color: red">
                                        Проверьте все данные!
                                    </div>
                                </td>
                                <div id="changePricesOkDialog" class="hide" title="Подтверждение изменения цен">
                                    <style>
                                        .ui-change-price-ok-dialog{border: 1px solid gray;}
                                        .ui-change-price-ok-dialog .ui-dialog-titlebar-close{display: none}
                                        #changePricesOkDialog p{margin: 10px;font-size: 15px;text-align: justify}
                                        #changePricesOkDialog button{margin: 20px;height: 35px;font-size: 15px;}
                                    </style>
                                    <p>Цены были изменены.</p>
                                    <p>Ознакомиться с новыми ценами вы можете в <strong><a href="<?="http://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]"?>" target="_blank">новой вкладке</a></strong>.</p>
                                    <p>Вы можете отменить изменения или согласиться с изменениями.</p>
                                    <button id="roolBackPricesButton">Отменить изменения</button>
                                    <button id="deleteDumpFileButton">Согласиться с изменениями</button>
                                </div>
                            </tr>


						</table>
					</form>
				</div>
			</div>
		</div><!--main-->
		<div class="vote"></div>
	</div><!--root-->
<?include(TEMPLATES_ADMIN.'footer.tpl');?>