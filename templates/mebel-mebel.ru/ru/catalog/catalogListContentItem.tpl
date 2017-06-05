<div class="product-block">

	<?include('bands/bandBlock.tpl')?>

	<div class="product-img">
		<div class="id-product">
			ID <?=$object->id?>
		</div>

		<?if($this->getController('Authorization')->isAdminAuthorizated()):?>
			<a class="adminShow" href="<?=$object->getAdminPath()?>" target="_blank" title="Эта ссылка видна только авторизованному в админской части пользователю">
				Редактировать [id = <?=$object->id?>]
			</a>
		<?endif?>

		<?if($object->card):?>
			<img class="cardCatalogList" src="/images/bg/visaMc.png" />
		<?endif?>

		<div class="clear"></div>

		<ul>
			<li>
				<div class="img-offers touchslider" title="<?=$object->getName()?>">
					<?$images = $object->getImagesByCategoryAndStatus('1,2', 1);?>
					<div class="touchslider-viewport"><div>
						<div class="touchslider-item">
							<a href="<?=$object->getPath()?>">
								<img src="<?=$object->getFirstPrimaryImage()->getUserImage('230x168', 'watermarkPng')?>">
							</a>
						</div>
						<? foreach($images as $image ): ?>
							<div class="touchslider-item">
								<a href="<?=$object->getPath()?>">
									<img src="<?=$image->getUserImage('230x168', 'watermarkPng')?>">
								</a>
							</div>
						<? endforeach; ?>
					</div></div>
					<?if($images->count()):?>
					<a class="touchslider-prev bt-lf" title="следующее изображение"></a>
					<a class="touchslider-next bt-rg" title="предыдущее изображение"></a>
					<?endif?>
				</div>
			</li>
		</ul>
	</div>
	<div class="info-block-mini">
		<a href="<?=$object->getPath()?>" class="main-linck">
			<span class="line-big" title="<?=$object->getName()?>"><?=$object->getName()?></span>
			<span class="mask"></span>
		</a>
		<span class="factory"><?=$object->getFabricator()->name;?></span>
		<div class="price-block">
			<?if($object->getOffer()):?>
			<div class="price-left">
				<div class="offer_only">Только в период акции!</div>
				<span class="new-price-2">
					<?=number_format( $object->getShowPrice(), 0, ',', ' ' )?>
					<strong>c</strong>
				</span>

                <span class="old-price-2">
                    <?=number_format( $object->getShowOldPrice(), 0, ',', ' ' )?>
                    <strong>a</strong>
                </span>

				<div class="clear"></div>
			</div>
			<?else:?>
			<div class="price-left">
<!--					<span class="old-price-2">
					<strong>a</strong>
				</span>-->
				<span class="new-price-2">
					<?=number_format( $object->getShowPrice(), 0, ',', ' ' )?>
					<strong>c</strong>
				</span>
				<div class="clear"></div>
			</div>
			<?endif?>
			<div class="clear"></div>
			<?$parameters = $this->getController('Catalog')->getObjectPropertiesListByAlias('sizesAndWeight', $object, 3);?>
			<?if($parameters):?>
			<div class="characteristics-3">
				<strong>
					<? $dimension = ''; ?>
				<? $i=1; foreach($parameters as $parameter):?>
				<!--<?=$parameter['name']?><?= count($parameters)==$i ? ' '.$parameter['measure'] : ' x'?>-->
				<? $dimension = $dimension . $parameter['name']; ?>
				<? if (count($parameters)==$i) { $dimension = $dimension . ' '.$parameter['measure']; } else { $dimension = $dimension . ' x '; } ?>
				<? $i++; endforeach?>
				<? if (strlen($dimension) > 22) { $dimens_conv = substr($dimension,0,18) . "..."; echo $dimens_conv; } else { echo $dimension;} ?>
				</strong>
				<span>Габариты:</span>
				<div class="clear"></div>
			</div>
			<?else:?>
			<br />
			<?endif?>

			<?if(!$object->isBlocked()):?>
			<div class="button-miny">
				<span class="add-to-cart-3 addToShopcart" data-objectId="<?=$object->id?>" data-objectClass="<?=$object->getClass()?>" onclick="dataLayer.push({'event': 'event_addcart'});">
					добавить в корзину
				</span>
				<span class="info-click-2">Или</span>
				<span class="motion-click-2 orderOneClickModalShow"
					  data-objectId="<?=$object->id?>"
					  title="<?=$object->getName()?> - купить в 1 клик"
				>
					купите в 1 клик
				</span>
				<div class="clear"></div>
			</div>
			<?endif?>

			<div class="clear"></div>
		</div>
	</div>
	<div class="clear"></div>
</div>