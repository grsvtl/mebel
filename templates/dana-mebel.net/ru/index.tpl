<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

	<div class="mainContent">
		<div class="buttonMenu">
			<span>Каталог</span>
		</div>
		<div class="bgGrayMenu"></div>
		<div class="leftMenu">

			<?=$this->getController('Catalog')->getCatalogLeftMenu()?>

			<?=$this->getController('Article')->getIndexReviews()?>

		</div>
		<div class="rightContent">

			<?if($mainSliderGoods->count()):?>
			<div class="bannersBlock">
				<div class="mainBanners">
					<div class="slider">
						<ul class="slides">

							<?foreach($mainSliderGoods as $mainGood):?>
							<li class="slide">
								<div class="mainOffer" style="background-image: url(<?=$mainGood->getFirstPrimaryImage()->getImage('582x391')?>)">
									<a href="<?=$mainGood->getPath()?>" class="moreABanners">
										<span class="sliderDescription">
											<?=$mainGood->getName()?>
										</span>
									</a>
									<span class="priceBanner"><?=number_format( $mainGood->getShowPrice(), 0, ',', ' ' )?> <strong>c</strong></span>
								</div>
							</li>
							<?endforeach?>

						</ul>
					</div>
				</div>
				<div class="mediumBanner" style="background-image: url(/images/danaMebel/bg/mediumBannerImg.jpg)">
					<div class="yellowText">
						Им уже доставили мебель
					</div>
					<p>Фото наших клиентов</p>
					<a href="/photo/" class="morePhoto">
						Подробнее
					</a>
				</div>
				<div class="littleBanner" style="background-image: url(/images/danaMebel/bg/littleBannerImg.jpg)">
					<div class="yellowTextL">
						Шоу-рум
					</div>
					<p>DANA мебель</p>
					<a href="/contact/" class="morePhotoL">
						Подробнее
					</a>
				</div>
				<div class="clear"></div>
			</div>
			<?endif?>

			<?$this->getSeriaBlock($series)?>

			<?$newGoods = $this->getController('Catalog')->getNewObjects()?>
			<?if($newGoods->count()):?>
			<div class="newModels">
				<h2>
					<span>Новые модели</span>
				</h2>
				<ul>
					<?foreach($newGoods as $object):?>
					<li>

                        <?include ('catalog/bands/bandBlock.tpl')?>

						<a href="<?=$object->getPath()?>"><img src="<?=$object->getFirstPrimaryImage()->getImage('201x131')?>" alt=""></a>
						<a href="<?=$object->getPath()?>" class="titleOffer"><span><?=$object->getName()?></span></a>

						<?
							$sizesAndWeightArray = array();
							$i = 1;
							foreach( $sizesAndWeight as $size ){
								if($object->getPropertyValueById($size->id)->value){
									$sizesAndWeightArray[] = ($i>1 ? 'x' : '').$object->getPropertyValueById($size->id)->value;
									$measureName = $object->getPropertyValueById($size->id)->getMeasure()->shortName;
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

                        <?if($object->getOffer()):?>
                            <div class="price-left">
                                <div class="offer_only">Только в период акции!</div>
                                <div class="priceOffer old-price">
                                    <?=number_format( $object->getShowOldPrice(), 0, ',', ' ' )?>
                                    <span>c</span>
                                </div>
                                <div class="priceOffer">
                                    <?=number_format( $object->getShowPrice(), 0, ',', ' ' )?>
                                    <span>c</span>
                                </div>
                                <div class="clear"></div>
                            </div>
                        <?else:?>
                            <div class="priceOffer">
                                <?=number_format( $object->getShowPrice(), 0, ',', ' ' )?> <span>c</span>
                            </div>
                        <?endif?>

						<div class="addCard addToShopcart" data-objectId="<?=$object->id?>" data-objectClass="<?=$object->getClass()?>">
							В корзину
						</div>
					</li>
					<?endforeach?>
				</ul>
				<div class="clear"></div>
			</div>
			<?endif?>

			<?=$this->getController('Article')->getIndexNews()?>

			<div class="textHomePage">
				<?=$article->getText()?>
			</div>
		</div>
		<div class="clear"></div>
	</div>

<?$this->includeTemplate('footer')?>