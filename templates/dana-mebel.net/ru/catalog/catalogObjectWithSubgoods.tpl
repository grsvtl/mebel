<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

<div class="mainContent">
	<div class="buttonMenu">
		<span>Каталог</span>
	</div>
	<div class="bgGrayMenu"></div>
	<div class="leftMenu">

		<?=$this->getController('Catalog')->getCatalogLeftMenu()?>

	</div>
	<div class="rightContent">

		<?$this->includeBreadcrumbs()?>

		<h1><?=$object->getName()?></h1>

		<div class="mainImgcomposition">

            <?include ('bands/bandBigBlock.tpl')?>

			<?if($this->getController('Authorization')->isAdminAuthorizated()):?>
				<a class="adminShow" href="<?=$object->getAdminPath()?>" target="_blank" title="Эта ссылка видна только авторизованному в админской части пользователю">
					Редактировать [id = <?=$object->id?>]
				</a>
			<?endif?>

			<div class="imgBlock">
				<img src="<?=$object->getFirstPrimaryImage()->getImage('600x331')?>" alt="">
			</div>
			<div class="priceBlock">
				<div class="priceInset">
					<?=number_format( $object->getShowPrice(), 0, ',', ' ' )?> <span>c</span>
				</div>
				<span class="addToCart addToShopcart" data-objectId="<?=$object->id?>" data-objectClass="<?=$object->getClass()?>">
					В корзину
				</span>

				<span class="oneClick orderOneClickModalShow"
					data-objectId="<?=$object->id?>"
					title="<?=$object->getName()?> - купить в 1 клик"
				>
					Купить за 1 клик
				</span>

				<div class="clear"></div>

				<? foreach( $sizesAndWeight as $size ): ?>
				<? if($object->getPropertyValueById($size->id)->value): ?>
				<span class="infoAboutProduct">
					<?=$size->getValue()?>:
					<strong>
						<?=$object->getPropertyValueById($size->id)->value?> <?=$object->getPropertyValueById($size->id)->getMeasure()->shortName?>
					</strong>
				</span>
				<? endif; ?>
				<? endforeach; ?>

				<span class="infoAboutProduct">
					Серия: <strong><?=$object->getSeriaObject()->getValue()?></strong>
				</span>


				<?if($materialArray):?>
				<span class="infoAboutProduct">
					Материал:
					<strong>
						<?$i=1; foreach($materialArray as $material):?>
							<?=$material['name']?><?= $i==count($materialArray) ? '' : ', '?>
						<?$i++; endforeach?>
					</strong>
				</span>
				<?endif?>

			</div>
			<div class="clear"></div>
		</div>

		<?if($object->getSubgoods()->count()):?>
		<div class="listOffers">
			<h2>
				<span>
					В композицию входит
				</span>
			</h2>
			<ul class="listOffersInset">
				<?foreach($object->getSubgoods() as $subgood):?>
				<li>
					<div class="borderBlock">

                        <?include ('bands/bandBlock.tpl')?>

						<?if($this->getController('Authorization')->isAdminAuthorizated()):?>
							<a class="adminShow" href="<?=$subgood->getGood()->getAdminPath()?>" target="_blank" title="Эта ссылка видна только авторизованному в админской части пользователю">
								Редактировать [id = <?=$subgood->getGood()->id?>]
							</a>
						<?endif?>

						<a href="<?=$subgood->getGood()->getPath()?>">
							<img src="<?=$subgood->getGood()->getFirstPrimaryImage()->getImage('270x187')?>" alt="">
						</a>
						<a href="<?=$subgood->getGood()->getPath()?>" class="titleOffer">
							<span><?=$subgood->getGood()->getName()?></span>
						</a>


						<?
							$sizesAndWeightArray = array();
							$i = 1;
							foreach( $sizesAndWeight as $size ){
								if($subgood->getGood()->getPropertyValueById($size->id)->value){
									$sizesAndWeightArray[] = ($i>1 ? 'x' : '').$subgood->getGood()->getPropertyValueById($size->id)->value;
									$measureName = $subgood->getGood()->getPropertyValueById($size->id)->getMeasure()->shortName;
								}
								$i++;
							}
						?>
						<?if(!empty($sizesAndWeightArray)):?>
						<span class="parametrs">
							Размеры:
							<br>
							<? foreach( $sizesAndWeightArray as $item ): ?>
							<?=$item?>
							<? endforeach; ?>
							(<?=$measureName?>)
						</span>
						<?endif?>


						<div class="priceOffer"><?=number_format( $subgood->getGood()->getShowPrice(), 0, ',', ' ' )?><span>c</span></div>
						<div class="addCard addToShopcart" data-objectId="<?=$subgood->getGood()->id?>" data-objectClass="<?=$subgood->getGood()->getClass()?>">
							В корзину
						</div>
					</div>
				</li>
				<?endforeach?>
			</ul>
			<div class="clear"></div>
		</div>
		<?endif?>

		<div class="textAboutOffer">
			<h2><span>Описание</span></h2>
			<?=$object->getInfo()->description?>

		</div>

	</div>
	<div class="clear"></div>
</div>

<?$this->includeTemplate('footer')?>