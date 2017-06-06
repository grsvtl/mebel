<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

	<?$this->includeTemplate('clearCurrentPageCacheBlock');?>

	<script type="text/javascript" src="/admin/js/jquery/touch/touchslider.js"></script>
	<script type="text/javascript" src="/js/plugins/gallery/gallery.js"></script>
	<script type="text/javascript" src="/js/catalog/catalogObject.js"></script>

	<!--Начало основного контента-->
	<article>
		<section class="main">
			<div class="id">
				ID <?=$object->id?>
			</div>
			<h1 class="catalogH1"><?=$object->getName()?></h1>

			<?if($this->getController('Authorization')->isAdminAuthorizated()):?>
			<a class="adminShow" href="<?=$object->getAdminPath()?>" target="_blank" title="Эта ссылка видна только авторизованному в админской части пользователю">
				Редактировать [id = <?=$object->id?>]
			</a>
			<?endif?>
			<div class="clear"></div>

			<?if($object->getOffer()):?>
			<? $this->includeOfferToObjectContent($object) ?>
			<?endif?>

			<section class="tab">
				<span class="tabs select" data-target="general-information">
					<span>Обзор</span>
				</span>
				<span class="tabs" data-target="specification-v">
					<span>Описание</span>
				</span>
				<span class="tabs" data-target="characteristics-v">
					<span>Характеристики</span>
				</span>
				<?if($object->getFabricator()->getConditions()):?>
				<span class="tabs" data-target="conditions">
					<span>Условия</span>
				</span>
				<?endif?>
				<?if($object->getSubgoods()->count()):?>
				<span class="tabs" id="grade" data-target="grade-v">
					<span>Комплектация</span>
					<strong><?=$object->getSubgoods()->count()?></strong>
				</span>
				<?endif?>
				<?if($object->getFabricator()->getFiles()->count()):?>
				<span class="tabs" id="files" data-target="files-v">
					<span>Документы</span>
				</span>
				<?endif?>
				<span class="tabs" id="question" data-target="ask-question-v">
					<span>Задать вопрос</span>
				</span>








<!--                <span class="tabs" data-target="reviews-v">-->
<!--					<span>Отзывы 10</span>-->
<!--<!--                    <strong>10</strong>-->
<!--				</span>-->





				<div class="clear"></div>
			</section>
			<!--Начало блока фото и цены-->
			<section class="general-information target">
				<section class="g-i">
					<div class="photo">

                        <?include ('bands/bandBigBlock.tpl')?>

						<div class="big-photo">
							<a class="pointer size"></a>
							<ul>
								<li>
									<div class="img-offers touchslider">
										<div class="touchslider-viewport"><div>
											<?if($object->video):?>
												<iframe width="689" height="450" src="//<?=$object->video?>" frameborder="0" allowfullscreen></iframe>
											<?endif?>
											<? foreach($object->getImagesByObjectId() as $image ): ?>
												<div class="touchslider-item">
													<a data-href="<?=$image->getUserImage('0x0', 'watermarkPng')?>" class="bigImage">
														<img src="<?=$image->getUserImage('689x449', 'watermarkPng')?>">
													</a>
												</div>
											<? endforeach; ?>
										</div></div>
										<a class="left-arrow touchslider-prev"></a>
										<a class="right-arrow touchslider-next"></a>
									</div>
								</li>
							</ul>
						</div>

						<?if($object->card):?>
							<img class="cardCatalogObject" src="/images/bg/visaMc.png" />
						<?endif?>

						<div class="mini-photo">
							<div class="hidden-photo">
								<div class="touchslider-nav">
								<ul>
									<?if($object->video):?>
									<li>
										<a class="touchslider-nav-item " >
											<img src="/images/bg/video.png" alt="">
										</a>
									</li>
									<?endif?>
									<? $count=2; foreach($object->getImagesByObjectId() as $image ): ?>
									<li>
										<a class="touchslider-nav-item <?=(1==$count++)?' touchslider-nav-item-current':''?>" >
											<img src="<?=$image->getUserImage('121x64', 'watermarkPng')?>" style="width: 121px; height: 64px;" alt="">
										</a>
									</li>
									<? endforeach; ?>
								</ul>
								</div>
							</div>
						</div>



					</div>
					<div class="info">
						<?if($object->isBlocked()):?>
						<span class="past">Товар снят с продажи</span>
						<?else:?>
						<?if($object->getOffer()):?>
						<div class="offer_only">Только в период акции!</div>
						<div class="active-price">
							<span>
								<?=number_format( $object->getShowPrice(), 0, ',', ' ' )?>
								<strong>a</strong>
							</span>
							<div class="clear"></div>
						</div>
						<?else:?>
<!--						<div class="old-price">
							<span class="text-price">Старая цена:</span>
							<span class="num-price"><strong>c</strong></span>
							<div class="clear"></div>
						</div>-->
						<div class="active-price">
							<span>
								<?=number_format( $object->getShowPrice(), 0, ',', ' ' )?>
								<strong>a</strong>
							</span>
							<div class="clear"></div>
						</div>
						<?endif?>

						<?if(!$object->isBlocked()):?>
						<span class="add-to-cart addToShopcart" data-objectId="<?=$object->id?>" data-objectClass="<?=$object->getClass()?>" onclick="dataLayer.push({'event': 'event_addcart'});">
							Добавить в корзину
						</span>
						<div class="one-click">
							<span class="info-click">
								Спешите? Тогда
							</span>
							<span class="motion-click orderOneClickModalShow"
								  data-objectId="<?=$object->id?>"
								  title="<?=$object->getName()?> - купить в 1 клик"
							>
								купите в 1 клик
							</span>
							<div class="clear"></div>
						</div>
						<?endif?>

						<div class="information">
							<?if($delivery):?>
							<div class="delivery">
								<strong>ДОСТАВКА</strong>
								<!--<span>( 1-2 дня )</span>-->
								<ul>
									<? foreach( $delivery as $item ): ?>
									<li>
										<?=$item['name']?> -
										<span class="orang">
											<?= $item['value'] === '0' ? 'бесплатно' : $item['value']?>
											<?= $item['value'] === '0' ? '' : $item['measure']?>
										</span>
									</li>
									<? endforeach; ?>
								</ul>
							</div>
							<?endif?>
							<?if($lifting):?>
							<div class="rise">
								<strong>ПОДЪЁМ</strong>
								<ul>
									<? foreach( $lifting as $item ): ?>
									<li>
										<?=$item['name']?> -
										<span class="orang">
											<?= $item['value'] === '0' ? 'бесплатно' : $item['value']?>
											<?= $item['value'] === '0' ? '' : $item['measure']?>
										</span>
									</li>
									<? endforeach; ?>
								</ul>
							</div>
							<?endif?>
							<?if($fitting):?>
							<div class="assembly">
								<strong>СБОРКА</strong>
								<ul>
									<? foreach( $fitting as $item ): ?>
									<li>
										<?=$item['name']?> -
										<span class="orang">
											<?= $item['value'] === '0' ? 'бесплатно' : $item['value']?>
											<?= $item['value'] === '0' ? '' : $item['measure']?>
										</span>
									</li>
									<? endforeach; ?>
								</ul>
							</div>
							<?endif?>
						</div>
						<?endif?>
					</div>
					<div class="clear"></div>
				</section>
				<!--Конец блока фото и цены-->

				<?$this->getComplectsBlock($object->id);?>

				<section class="product-information">
					<!--Начало блока левой колонки-->
					<section class="left-information">

<!--						<section class="description">
							<script type="text/javascript" src="/js/catalog/initDescriptionTab.js"></script>
							<h2><a class="pointer tabs" data-target="specification-v">Описание</a></h2>
							<div class="descriptionText">
								<?//=$object->getInfo()->description?>
							</div>
							<a class="more pointer more-text" data-text="Скрыть -">
								Ещё +
							</a>
						</section>-->

						<div class="measurements">
							<!--<h3>Размеры и вес</h3>-->
							<h2>Размеры и вес</h2>
							<ul class="list-info">
								<? foreach( $sizesAndWeight as $size ): ?>
								<? if($object->getPropertyValueById($size->id)->value): ?>
								<li>
									<div class="right-ch"><?=$object->getPropertyValueById($size->id)->value?> <?=$object->getPropertyValueById($size->id)->getMeasure()->shortName?></div>
									<div class="left-ch"><?=$size->getValue()?>:</div>
									<div class="clear"></div>
								</li>
								<? endif; ?>
								<? endforeach; ?>
							</ul>
						</div>

						<?if($object->getSubgoods()->count()):?>
						<section class="options">
							<h2><a class="pointer tabs" data-target="grade-v">Комплектация</a></h2>
							<ul class="list-info">
								<?foreach($object->getSubgoods() as $subGood):?>
								<li>
									<div class="right-ch"><?=$subGood->subGoodQuantity?> шт</div>
									<div class="left-ch"><?=$subGood->getGood()->getName()?></div>
									<div class="clear"></div>
								</li>
								<?endforeach?>
							</ul>
						</section>
						<a class="more pointer tabs" data-target="grade-v">Изменить комплектацию</a>
						<?endif?>




					</section>
					<!--Конец блока левой колонки-->
					<!--Начало блока правой колонки-->
					<section class="right-information">
						<section class="characteristics">
							<h2><a class="pointer tabs" data-target="characteristics-v">Характеристики</a></h2>
							<div class="gl-information">
								<h3>Общая информация</h3>
								<ul class="list-info">
									<li>
										<div class="right-ch"><?=$object->getFabricator()->name?></div>
										<div class="left-ch">Производитель:</div>
										<div class="clear"></div>
									</li>
									<?if($object->getSeriaObject()):?>
									<li>
										<div class="right-ch"><?=$object->getSeriaObject()->getValue()?></div>
										<div class="left-ch">Серия:</div>
										<div class="clear"></div>
									</li>
									<?endif?>
									<? foreach( $parameters as $parameter ):?>
									<?$parameterValues = $parameter->getParameterValuesByObjectParametersArray($object->getParametersArray())?>
									<?if(isset($parameterValues[0])):?>
									<li>
										<div class="right-ch">
											<?foreach($parameterValues  as $value ):?>
											<? if (file_exists(DIR.'/images/colors/'.$value['description'].'.png') ): ?>
											<img src="/images/colors/<?=$value['description']?>.png" title="<?=$value['name']?>" width="54" height="54">
											<?elseif(file_exists(DIR.'/images/colors/'.$value['description'].'.jpg')):?>
											<img src="/images/colors/<?=$value['description']?>.jpg" title="<?=$value['name']?>"  width="54" height="54">
											<?elseif(file_exists(DIR.'/images/colors/'.$value['description'].'.gif')):?>
											<img src="/images/colors/<?=$value['description']?>.gif" title="<?=$value['name']?>"  width="54" height="54">
											<?else:?>
												<?=$value['name'].($value === end($parameterValues) ? '' : ', ')?>
											<? endif; ?>
											<?endforeach?>
										</div>
										<div class="left-ch"><?=$parameter->name?>:</div>
										<div class="clear"></div>
									</li>
									<?endif?>
									<? endforeach?>
								</ul>
							</div>

						</section>
					</section>
					<!--Конец блока правой колонки-->
					<div class="clear"></div>
				</section>
			</section>

			<!--Конец блока основной информации-->
			<!--Начало блоков вкладок-->
			<section class="specification-v target">
				<?include('catalogObjectByeBlock.tpl')?>
				<!--Контент-->
				<section class="info-text">
					<?=$object->getInfo()->description?>
				</section>
				<!--Конец контента-->
			</section>
			<section class="characteristics-v target">
				<?include('catalogObjectByeBlock.tpl')?>
				<!--Контент-->
				<section class="info-text-characteristics">
					<h2>Характеристики</h2>
					<section class="characteristics">
						<div class="gl-information">
							<h3>Общая информация</h3>
							<ul class="list-info">
								<? foreach( $parameters as $parameter ):?>
								<?$parameterValues = $parameter->getParameterValuesByObjectParametersArray($object->getParametersArray())?>
								<?if(isset($parameterValues[0])):?>
								<li>
									<div class="right-ch">
										<?foreach($parameterValues  as $value ):?>
										<? if (file_exists(DIR.'/images/colors/'.$value['description'].'.png') ): ?>
											<img src="/images/colors/<?=$value['description']?>.png" title="<?=$value['name']?>"  width="54" height="54">
										<?elseif(file_exists(DIR.'/images/colors/'.$value['description'].'.jpg')):?>
											<img src="/images/colors/<?=$value['description']?>.jpg" title="<?=$value['name']?>"  width="54" height="54">
										<?else:?>
										<?=$value['name'].($value === end($parameterValues) ? '' : ', ')?>
										<? endif; ?>
										<?endforeach?>
									</div>
									<div class="left-ch"><?=$parameter->name?>:</div>
									<div class="clear"></div>
								</li>
								<?endif?>
								<? endforeach?>
							</ul>
						</div>
						<div class="measurements">
							<h3>Размеры и вес</h3>
							<ul class="list-info">
								<? foreach( $sizesAndWeight as $size ): ?>
								<? if($this->isNotNoop($object->getPropertyValueById($size->id))): ?>
								<li>
									<div class="right-ch"><?=$object->getPropertyValueById($size->id)->value?> <?=$object->getPropertyValueById($size->id)->getMeasure()->shortName?></div>
									<div class="left-ch"><?=$size->getValue()?>:</div>
									<div class="clear"></div>
								</li>
								<? endif; ?>
								<? endforeach; ?>
							</ul>
						</div>
					</section>
				</section>
				<!--Конец контента-->
			</section>

			<?if($object->getSubgoods()->count()):?>
			<section class="info-text-grade grade-v target">
				<section class="block-product-grade">
					<div class="grade-img">
						<img src="<?=$object->getFirstPrimaryImage()->getUserImage('320x210', 'watermarkPng')?>">
					</div>
					<h2>Комплектация <?=$object->getName()?></h2>
					<?if($object->isBlocked()):?>
					<div class="price-grade">
						<div class="old-price">
							<span class="past">Товар снят с продажи</span>
						</div>
					</div>
					<?else:?>
					<div class="price-grade">
						<?if($object->getOffer()):?>
						<div class="offer_only">Только в период акции!</div>
						<div class="old-price">
							<span class="text-price">Старая цена:</span>
							<span class="num-price">
								<?=number_format( $object->getShowOldPrice(), 0, ',', ' ' )?>
								<strong>c</strong>
							</span>
							<div class="clear"></div>
							<span class="price-active">
								<?=number_format( $object->getShowPrice(), 0, ',', ' ' )?>
								<strong>a</strong>
							</span>
						</div>
						<?else:?>
						<div class="old-price">
							<!--<span class="text-price">Старая цена:</span>-->
<!--							<span class="num-price">
								<strong>c</strong>
							</span>-->
							<div class="clear"></div>
							<span class="price-active">
								<?=number_format( $object->getShowPrice(), 0, ',', ' ' )?>
								<strong>a</strong>
							</span>
						</div>
						<?endif?>
					</div>
					<div class="add-grade">
						<span class="add-to-cart addToShopcart" data-objectId="<?=$object->id?>" data-objectClass="<?=$object->getClass()?>"  onclick="dataLayer.push({'event': 'event_addcart'});">
							Добавить в корзину
						</span>
						<p>или</p>
						<span class="motion-click orderOneClickModalShow"
							  data-objectId="<?=$object->id?>"
							  title="<?=$object->getName()?> - купить в 1 клик"
						>
							купите в 1 клик
						</span>
					</div>
					<?endif?>

					<div class="clear"></div>
				</section>

				<h3 class="h3-grade">Изменить комплектацию</h3>
				<table class="table-grade">
					<tbody>
						<tr class="top-table-line">
							<td class="cell1">Наименование</td>
							<td class="cell1">Фото товара</td>
							<td class="cell2">Характеристики</td>
							<td class="cell3">В комплекте</td>
							<?if(!$object->isBlocked()):?>
							<td class="cell4">Докупить</td>
							<?endif?>
						</tr>
						<?foreach($object->getSubgoods() as $subGood):?>
						<tr>
							<td class="cell1">
								<span>[ID <?=$subGood->getGood()->id?>]</span>
								<a href="<?=$subGood->getGood()->getPath()?>"><?=$subGood->getGood()->getName()?></a>
								<a href="<?=$subGood->getGood()->getPath()?>" class="more-grade">Подробнее</a>
							</td>
							<td class="cell1">
								<a href="<?=$subGood->getPath()?>">
									<img src="<?=$subGood->getGood()->getFirstPrimaryImage()->getUserImage('149x99', 'watermarkPng')?>">
								</a>
							</td>
							<td class="cell2">
								<div class="list-grade">
									<ul>
										<? foreach( $sizesAndWeight as $size ): ?>
										<? if($subGood->getGood()->getPropertyValueById($size->id)->value): ?>
										<li>
											<div class="right-grade"><?=$subGood->getGood()->getPropertyValueById($size->id)->value?> <?=$subGood->getGood()->getPropertyValueById($size->id)->getMeasure()->shortName?></div>
											<div class="left-grade"><?=$size->getValue()?>:</div>
											<div class="clear"></div>
										</li>
										<? endif; ?>
										<? endforeach; ?>
										<li class="link-bottom">
											<a href="<?=$subGood->getGood()->getPath()?>">Подробнее</a>
										</li>
									</ul>
									<div class="clear"></div>
								</div>
							</td>
							<td class="cell3">
								<p><?=$subGood->subGoodQuantity?><span>шт.</span></p>
							</td>
							<?if(!$object->isBlocked()):?>
							<td class="cell4">
								<div class="price-and-number">
									<div class="pr-rg">
										<span>Количество</span>
										<strong class="p1 decrement" data-objectId="<?=$subGood->getGood()->id?>">-</strong>
										<p class="byeMoreQuantity" data-objectId="<?=$subGood->getGood()->id?>">1</p>
										<strong class="p2 increment" data-objectId="<?=$subGood->getGood()->id?>"">+</strong>
										<div class="clear"></div>
									</div>
									<div class="pr-lf">
										<span>Стоимость</span>
										<p>
											<span class="costByQunatity" data-objectId="<?=$subGood->getGood()->id?>">
												<?=number_format( $subGood->getGood()->getShowPrice(), 0, ',', ' ' )?>
											</span>
											<strong>a</strong>
										</p>
									</div>
									<div class="clear"></div>
								</div>
								<span class="add-to-cart-2 addToShopcart" data-objectId="<?=$subGood->getGood()->id?>" data-objectClass="<?=$subGood->getGood()->getClass()?>">
									в корзину
								</span>
							</td>
							<?endif?>
						</tr>
						<?endforeach?>
					</tbody>
				</table>
			</section>
			<?endif?>




<!--			<section class="reviews-v target">-->
				<?//include('catalogObjectByeBlock.tpl')?>
<!--				<section class="info-text-reviews">-->
<!--					<h2>Отзывы покупателей</h2>-->
<!--                    <img src="/images/bg/otzyvy.png">-->
<!--				</section>-->
<!--			</section>-->




			<?if($object->getFabricator()->getFiles()->count()):?>
			<section class="files-v target">
				<?include('catalogObjectByeBlock.tpl')?>
				<section class="files">
					<h2>Документы производителя</h2>
					<div class="table_files">
						<table width="80%">
							<tbody>
								<?foreach($object->getFabricator()->getFiles() as $file):?>
								<tr>
									<td>
										<a href="<?=$object->getPath()?>?downloadFile=<?=$file->getAlias()?>.<?=$file->getExtension()?>" title="Скачать">
											<img src="<?=$file->getFileIcon()?>" alt="Скачать">
										</a>
									</td>
									<td>
										<div class="overflow">
											<div class="sh"></div>
											<p class="name"><?= $file->getTitle()?> (<?=$file->getSize()?>)</p>
										</div>
									</td>
									<td>
										<a href="<?=$object->getPath()?>?downloadFile=<?=$file->getAlias()?>.<?=$file->getExtension()?>">скачать</a>
									</td>
								</tr>
								<?endforeach?>
							</tbody>
						</table>
					</div>
				</section>
			</section>
			<?endif?>
			<?if($object->getFabricator()->getConditions()):?>
			<section class="conditions target">
				<?include('catalogObjectByeBlock.tpl')?>
				<section class="info-text">
					<?=$object->getFabricator()->getConditions()?>
				</section>
			</section>
			<?endif?>
			<section class="ask-question-v target">
				<?include('catalogObjectByeBlock.tpl')?>
				<!--Контент-->
				<section class="info-text-ask-question feedbackBlockPlace" data-source="/feedback/getFeedbackBlock/">
					<?=$this->getController('Feedback')->getFeedbackBlock()?>
				</section>
				<!--Конец контента-->
			</section>
			<!--Конец блоков вкладок-->

			<?$seriaObjects = $this->getOtherGoodsOfSeria($object)?>
			<?$secondSeriaObjects = $this->getGoodsOfSecondSeria($object)?>
			<?if($seriaObjects->count()  ||  $secondSeriaObjects->count()):?>
			<section class="interestingly">
				<h3>ВСЕ ТОВАРЫ СЕРИИ "<?=$object->getSeriaObject()->getValue()?>" на ваш выбор:</h3>
				<ul>
					<?if($seriaObjects->count()):?>
						<?foreach($seriaObjects as $item):?>
						<li>











                            <?$this->setContent('object', $item)->includeTemplate('catalog/bands/bandBlock')?>











							<a href="<?=$item->getPath()?>" class="linck-block" title="<?=$item->getName()?>">
								<img src="<?=$item->getFirstPrimaryImage()->getUserImage('231x176', 'watermarkPng')?>">
								<strong></strong>
								<span><?=$item->getName()?></span>
							</a>

							<?if(!$item->isBlocked()):?>
							<span class="add-to-cart-2 addToShopcart" data-objectId="<?=$item->id?>" data-objectClass="<?=$item->getClass()?>">
								Купить
							</span>
							<?if($item->getOffer()):?>
							<span class="price-mini">
								<div class="offer_only">Только в период акции!</div>
	<!--							<span class="old-price-action"><?=number_format( $item->getShowOldPrice(), 0, ',', ' ')?><strong>a</strong></span>-->
								<span class="price-action"><?=number_format( $item->getShowPrice(), 0, ',', ' ' )?><strong>a</strong></span>
							</span>
							<?else:?>
							<span class="price-mini">
	<!--							<span class="old-price-action"><strong>a</strong></span>-->
								<span class="price-action"><?=number_format( $item->getShowPrice(), 0, ',', ' ' )?><strong>a</strong></span>
							</span>
							<?endif?>
							<?else:?>
							<span class="price-mini">
								<span class="price-action-empty">товар снят с продажи</span>
							</span>
							<?endif?>

							<a href="<?=$item->getPath()?>" class="more-product">
								подробнее
							</a>
							<div class="clear"></div>
						</li>
						<?endforeach?>
					<?endif?>

					<?if($secondSeriaObjects->count()):?>
						<?foreach($secondSeriaObjects as $item):?>
						<li>

                            <?$this->setContent('object', $item)->includeTemplate('catalog/bands/bandBlock')?>

							<a href="<?=$item->getPath()?>" class="linck-block" title="<?=$item->getName()?>">
								<img src="<?=$item->getFirstPrimaryImage()->getUserImage('231x176', 'watermarkPng')?>">
								<strong></strong>
								<span><?=$item->getName()?></span>
							</a>

							<?if(!$item->isBlocked()):?>
							<span class="add-to-cart-2 addToShopcart" data-objectId="<?=$item->id?>" data-objectClass="<?=$item->getClass()?>" >
								Купить
							</span>
							<?if($item->getOffer()):?>
							<span class="price-mini">
								<div class="offer_only">Только в период акции!</div>
	<!--							<span class="old-price-action"><?=number_format( $item->getShowOldPrice(), 0, ',', ' ')?><strong>a</strong></span>-->
								<span class="price-action"><?=number_format( $item->getShowPrice(), 0, ',', ' ' )?><strong>a</strong></span>
							</span>
							<?else:?>
							<span class="price-mini">
	<!--							<span class="old-price-action"><strong>a</strong></span>-->
								<span class="price-action"><?=number_format( $item->getShowPrice(), 0, ',', ' ' )?><strong>a</strong></span>
							</span>
							<?endif?>
							<?endif?>

							<a href="<?=$item->getPath()?>" class="more-product">
								подробнее
							</a>
							<div class="clear"></div>
						</li>
						<?endforeach?>
					<?endif?>
				</ul>
				<div class="clear"></div>
			</section>
			<?else:?>
			<br /><br /><br />
			<?endif?>

			<div class="clear"></div>

			<section class="banner-gatanty">
				<div class="text-position">Гарантия <span>2 года</span> <strong>на весь товар</strong></div>
				<div class="uslovia">Условия гарантии</div>
				<div class="v1">сохраненные документы</div>
				<div class="v2">бирка</div>
				<div class="v3">отсутствие мех. повреждений</div>
			</section>

		</section>
	</article>
	<!--Конец основного контента-->
<?$this->includeTemplate('footer')?>
