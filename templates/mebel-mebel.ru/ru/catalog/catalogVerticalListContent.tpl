<?if( isset($this->getGet()['fabricator']) && !isset($this->getGet()['minPrice']) ):?>
<div class="fabricator-notice">
	Выбраны товары
	<?if( isset($this->getGet()['seria']) && !isset($this->getGet()['minPrice']) ):?>
	 серии "<?= is_array($this->getGet()['seria']) ? $this->getGet()['seria'][0] : $this->getGet()['seria']?>"
	<?endif?>
	производителя "<?= is_array($this->getGet()['fabricator']) ? $this->getFabricatorById($this->getGet()['fabricator'][0])->getName() : $this->getFabricatorById($this->getGet()['fabricator'])->getName() ?>"	:
</div>
<?endif?>

<?include('sortingBlock.tpl')?>

<script type="text/javascript" src="/admin/js/jquery/touch/touchslider.js"></script>
<script type="text/javascript" src="/js/plugins/gallery/gallery.js"></script>
<script type="text/javascript" src="/js/catalog/catalogObject.js"></script>

<div class="product-place">
	<?foreach($objects as $object):?>

    <?include('bands/bandVerticalBlock.tpl')?>

	<div class="product-block">

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
				<img class="cardCatalogListVertical" src="/images/bg/visaMc.png" />
			<?endif?>

			<div class="clear"></div>

			<ul>
				<li>
					<div class="img-offers touchslider" title="<?=$object->getName()?>">
						<?$images = $object->getImagesByCategoryAndStatus('1,2', 1);?>
						<div class="touchslider-viewport"><div>
							<div class="touchslider-item">
								<a href="<?=$object->getPath()?>">
									<img src="<?=$object->getFirstPrimaryImage()->getUserImage('314x230', 'watermarkPng')?>">
								</a>
							</div>
							<? foreach($images as $image ): ?>
								<div class="touchslider-item">
									<a href="<?=$object->getPath()?>">
										<img src="<?=$image->getUserImage('314x230', 'watermarkPng')?>">
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
			<span class="factory"><?=$object->getFabricator()->name?></span>
			<div class="price-block">
				<?if($object->getOffer()):?>
				<div class="offer_only">Только в период акции!</div>
				<div class="price-left">
					<span class="old-price-2">
						<?=number_format( $object->getShowOldPrice(), 0, ',', ' ' )?>
						<strong>a</strong>
					</span>
					<span class="new-price-2">
						<?=number_format( $object->getShowPrice(), 0, ',', ' ' )?>
						<strong>c</strong>
					</span>
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
				</div>
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

			<?$parameters = $this->getObjectPropertiesListByAlias('sizesAndWeight', $object, 4);?>
			<?if($parameters):?>
			<div class="characteristics-2">
				<ul class="list-info">
					<?foreach($parameters as $parameter):?>
					<li>
						<div class="right-ch"><?=$parameter['name']?> <?=$parameter['measure']?></div>
						<div class="left-ch"><?=$parameter['value']?>:</div>
						<div class="clear"></div>
					</li>
					<?endforeach?>
				</ul>
			</div>
			<?endif?>

		</div>
		<div class="clear"></div>
	</div>
	<?endforeach?>
</div>

<?include('paginator.tpl')?>