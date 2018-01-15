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

			<?if($this->getController('Authorization')->isAdminAuthorizated()):?>
				<a class="adminShow" href="<?=$object->getAdminPath()?>" target="_blank" title="Эта ссылка видна только авторизованному в админской части пользователю">
					Редактировать [id = <?=$object->id?>]
				</a>
			<?endif?>

			<div class="imgBlock">

                <?include ('bands/bandBigBlock.tpl')?>



                <?$images = $object->getImagesByCategoryAndStatus('1,2', 1);?>
                <link rel="stylesheet" type="text/css" href="/js/extensions/slick/slick.css"/>
                <link rel="stylesheet" type="text/css" href="/js/extensions/slick/slick-theme.css"/>
                <script src="/js/extensions/slick/slick.js" type="text/javascript" charset="utf-8"></script>
                <script src="/js/slick/catalogObjectSlick.js" type="text/javascript" charset="utf-8"></script>
                <script type="text/javascript" src="/js/plugins/gallery/gallery.js"></script>
                <input type="hidden" value="4" class="slick-slidesToShow">
                <div class="slider slider-for">
                    <div class="item">
                        <a data-href="<?=$object->getFirstPrimaryImage()->getImage('0x0')?>" class="bigImage">
                            <img src="<?=$object->getFirstPrimaryImage()->getImage('600x331')?>">
                        </a>
                    </div>
                    <?foreach($images as $image ): ?>
                        <div class="item">
                            <a data-href="<?=$image->getImage('0x0')?>" class="bigImage">
                                <img src="<?=$image->getImage('600x331')?>">
                            </a>
                        </div>
                    <? endforeach; ?>
                </div>




			</div>
			<div class="priceBlock">

                <?if($object->getOffer()):?>
                    <div class="price-left">
                        <div class="offer_only">Только в период акции!</div>
                        <div class="priceInset old-price">
					        <?=number_format( $object->getShowOldPrice(), 0, ',', ' ' )?>
                            <span>c</span>
				        </div>
                        <div class="priceInset">
                            <?=number_format( $object->getShowPrice(), 0, ',', ' ' )?>
                            <span>c</span>
                        </div>
                        <div class="clear"></div>
                    </div>
                <?else:?>
                    <div class="priceInset">
                        <?=number_format( $object->getShowPrice(), 0, ',', ' ' )?> <span>c</span>
                    </div>
                <?endif?>

				<span class="addToCart addToShopcart" data-objectId="<?=$object->id?>" data-objectClass="<?=$object->getClass()?>">
					В корзину
				</span>

				<span class="oneClick orderOneClickModalShow"
					data-objectId="<?=$object->id?>"
					title="<?=$object->getName()?> - купить в 1 клик"
				>
					Купить за 1 клик
				</span>

			</div>
			<div class="clear"></div>
		</div>



        <div class="slider slider-nav">
            <div class="item-small">
                <img src="<?=$object->getFirstPrimaryImage()->getUserImage('167x90')?>">
            </div>
            <?foreach($images as $image ): ?>
                <div class="item-small">
                    <img src="<?=$image->getUserImage('167x90')?>">
                </div>
            <? endforeach; ?>
        </div>




		<div class="characteristicsBlock">
			<h2>
				<span>Характеристики</span>
			</h2>
			<ul>

				<? foreach( $sizesAndWeight as $size ): ?>
				<? if($object->getPropertyValueById($size->id)->value): ?>
				<li>
					<span><?=$object->getPropertyValueById($size->id)->value?> <?=$object->getPropertyValueById($size->id)->getMeasure()->shortName?></span>
					<strong><?=$size->getValue()?>:</strong>
					<div class="clear"></div>
				</li>
				<? endif; ?>
				<? endforeach; ?>
				<li>
					<span><?=$object->getSeriaObject()->getValue()?></span>
					<strong>Серия:</strong>
					<div class="clear"></div>
				</li>
				<?if($materialArray):?>
				<li>
					<span>
						<?$i=1; foreach($materialArray as $material):?>
							<?=$material['name']?><?= $i==count($materialArray) ? '' : ', '?>
						<?$i++; endforeach?>
					</span>
					<strong>Материал:</strong>
					<div class="clear"></div>
				</li>
				<?endif?>
				<?if($corpusArray):?>
				<li>
					<span>
						<?$i=1; foreach($corpusArray as $corpus):?>
							<?//=$corpus['name']?><?//= $i==count($corpusArray) ? '' : ', '?>
							<? if (file_exists(DIR.'/images/colors/'.$corpus['description'].'.png') ): ?>
							<img src="/images/colors/<?=$corpus['description']?>.png" title="<?=$corpus['name']?>" width="54" height="54">
							<?elseif(file_exists(DIR.'/images/colors/'.$corpus['description'].'.jpg')):?>
							<img src="/images/colors/<?=$corpus['description']?>.jpg" title="<?=$corpus['name']?>"  width="54" height="54">
							<?elseif(file_exists(DIR.'/images/colors/'.$corpus['description'].'.gif')):?>
							<img src="/images/colors/<?=$corpus['description']?>.gif" title="<?=$corpus['name']?>"  width="54" height="54">
							<?else:?>
								<?=$corpus['name'].($i==count($corpusArray) ? '' : ', ')?>
							<? endif; ?>
						<?$i++; endforeach?>
					</span>
					<strong>Корпус:</strong>
					<div class="clear"></div>
				</li>
				<?endif?>
				<?if($fasadArray):?>
				<li>
					<span>
						<?$i=1; foreach($fasadArray as $fasad):?>
							<?//=$fasad['name']?><?//= $i==count($fasadArray) ? '' : ', '?>
							<? if (file_exists(DIR.'/images/colors/'.$fasad['description'].'.png') ): ?>
							<img src="/images/colors/<?=$fasad['description']?>.png" title="<?=$fasad['name']?>" width="54" height="54">
							<?elseif(file_exists(DIR.'/images/colors/'.$fasad['description'].'.jpg')):?>
							<img src="/images/colors/<?=$fasad['description']?>.jpg" title="<?=$fasad['name']?>"  width="54" height="54">
							<?elseif(file_exists(DIR.'/images/colors/'.$fasad['description'].'.gif')):?>
							<img src="/images/colors/<?=$fasad['description']?>.gif" title="<?=$fasad['name']?>"  width="54" height="54">
							<?else:?>
								<?=$fasad['name'].($i==count($fasadArray) ? '' : ', ')?>
							<? endif; ?>
						<?$i++; endforeach?>
					</span>
					<strong>Фасад:</strong>
					<div class="clear"></div>
				</li>
				<?endif?>
			</ul>
		</div>

		<?if($object->getInfo()->description):?>
		<div class="textAboutOffer">
			<h2><span>Описание</span></h2>
			<?=$object->getInfo()->description?>
		</div>
		<?endif?>

		<?if($otherGoodsOfSeriaAndCategory->count()):?>
		<div class="listOffers">
			<h2><span>Другие товары коллекции <?=$object->getSeriaObject()->getValue()?></span></h2>

			<?$this->getCatalogObjectBlock($otherGoodsOfSeriaAndCategory)?>

			<div class="clear"></div>
		</div>
		<?endif?>

	</div>
	<div class="clear"></div>
</div>

<?$this->includeTemplate('footer')?>