<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

<link rel="stylesheet" type="text/css" href="/css/vn-mebel.ru/content/articles/index.css" />
<script type="text/javascript" src="/admin/js/jquery/touch/touchslider.js"></script>
<link rel="stylesheet" type="text/css" href="/admin/js/jquery/touch/touchslider.css" />
<script>
	$(document).ready(function(){
		$(".touchslider-demo").touchSlider({
				mouseTouch: true,
				autoplay: true
		});
	});
</script>

<section class="banner">
	<section class="center-banner">
		<div class="b1">
			<a href="/gostinnye/modulnyie_gostinyie/valensiya-4/">
				<img src="/images/content/articles/index/b1.png">
			</a>
		</div>
		<div class="b2">
			<a href="/detskie/krovati_dvuhyarusnie/milana-1/">
				<img src="/images/content/articles/index/b2.png">
			</a>
		</div>
		<div class="b3">
			<a href="/kabinet/kompozicii_dlya_kobineta/mont_comp1/">
				<img src="/images/content/articles/index/b4.png">
			</a>
		</div>
		<div class="b4">
			<a href="/prihojii/podtovaryi_dlya_prihojey/diana-comp1/">
				<img src="/images/content/articles/index/b5.png">
			</a>
		</div>
		<div class="main-banner">
			<div class="touchslider-padding">
				<div class="touchslider touchslider-demo">
					<div class="touchslider-viewport" style="width:646px; overflow:hidden; position: relative; height: 429px;">
						<div class="touchslider-item">
							<a href="/detskie/modulnyie_detskie/turbo-comp5/">
								<img src="/images/content/articles/index/b3.png">
							</a>
						</div>
						<div class="touchslider-item">
							<a href="/spalni/modulnyie_spalni/diana_comp4/">
								<img src="/images/content/articles/index/b33.png">
							</a>
						</div>
					</div>
					<div class="touchslider-nav">
						<span class="touchslider-nav-item touchslider-nav-item-current"></span>
						<span class="touchslider-nav-item"></span>
					</div>
				</div>
			</div>
		</div>
	</section>
</section>

<?$fabricators = $this->getObject('\modules\fabricators\lib\Fabricators')->getActiveFabricators()?>

<section class="filter">
	<section class="center-filter">
			<select class="fabricator">
				<option value>-- все фабрики --</option>
				<?foreach($fabricators as $fabricator):?>
				<option value="<?=$fabricator->id?>"><?=$fabricator->name?></option>
				<?endforeach?>
			</select>
			<select class="mainCategory">
				<option value>-- все типы мебели --</option>
				<?foreach ($this->getController('Catalog')->getMainCategoriesWhichHasChildren() as $mainCategory):?>
				<option value="<?=$mainCategory->id?>"><?=$mainCategory->name?></option>
				<?endforeach?>
			</select>
			<span>Цена от</span>
			<input class="minPrice" value="<?=$this->getController('Catalog')->getMinPrice()?>">
			<strong></strong>
			<span>До</span>
			<input class="maxPrice" value="<?=$this->getController('Catalog')->getMaxPrice()?>">
			<button class="indexSearchButton">искать товар</button>
			<div class="clear"></div>
	</section>
</section>
<!--Начало основного контента-->
<article>
	<section class="main">
		<div class="factory">
			<h2>У нас товары мебельных фабрик:</h2>
			<?foreach ($fabricators as $fabricator):?>
				<div class="fabricatorBlock"><a href="<?=$fabricator->getPath()?>"><?=$fabricator->name?></a></div>
			<?endforeach?>
			<div class="clear"></div>
		</div>
		<div class="rubrics">
			<h2>Популярные рубрики:</h2>
			<div class="d1">
				<a href="/spalni/modulnyie_spalni/">
					<img src="/images/content/articles/index/spalny.jpg">
				</a>
				<a href="/spalni/modulnyie_spalni/">
					Комплекты для спальни
					<span>предложений - <?=$this->getQuantityByCategoryAlias('modulnyie_spalni')?></span>
				</a>
			</div>
			<div class="d2">
				<a href="/detskie/modulnyie_detskie/">
					<img src="/images/content/articles/index/detskaya.jpg">
				</a>
				<a href="/detskie/modulnyie_detskie/">
					Детские композиции
					<span>предложений - <?=$this->getQuantityByCategoryAlias('modulnyie_detskie')?></span>
				</a>
			</div>
			<div class="d3">
				<a href="/gostinnye/modulnyie_gostinyie/">
					<img src="/images/content/articles/index/gostynica.jpg">
				</a>
				<a href="/gostinnye/modulnyie_gostinyie/">
					Композиции для гостиной
					<?if($this->getQuantityByCategoryAlias('modulnyie_gostinyie')):?>
					<span>предложений - <?=$this->getQuantityByCategoryAlias('modulnyie_gostinyie')?></span>
					<?endif?>
				</a>
			</div>
			<div class="d4">
				<a href="/kabinet/kompozicii_dlya_kobineta/">
					<img src="/images/content/articles/index/biblioteka.jpg">
				</a>
				<a href="/kabinet/kompozicii_dlya_kobineta/">
					Мебель для кабинета
					<?if($this->getQuantityByCategoryAlias('kompozicii_dlya_kobineta')):?>
					<span>предложений - <?=$this->getQuantityByCategoryAlias('kompozicii_dlya_kobineta')?></span>
					<?endif?>
				</a>
			</div>
			<div class="d5">
				<a href="/prihojii/podtovaryi_dlya_prihojey/">
					<img src="/images/content/articles/index/prih.png">
				</a>
				<a href="/prihojii/podtovaryi_dlya_prihojey/">
					Прихожии
					<?if($this->getQuantityByCategoryAlias('podtovaryi_dlya_prihojey')):?>
					<span>предложений - <?=$this->getQuantityByCategoryAlias('podtovaryi_dlya_prihojey')?></span>
					<?endif?>
				</a>
			</div>
			<div class="d6">
				<a href="/myagkaya_mebel/">
					<img src="/images/content/articles/index/matrasy.jpg">
				</a>
				<a href="/myagkaya_mebel/">
					Мягкая мебель
					<?if($this->getQuantityByCategoryAlias('myagkaya_mebel')):?>
					<span>предложений - <?=$this->getQuantityByCategoryAlias('myagkaya_mebel')?></span>
					<?endif?>
				</a>
			</div>
			<div class="d7">
				<a href="/spalni/shkafi_dlya_spalni/">
					<img src="/images/content/articles/index/closets.png">
				</a>
				<a href="/spalni/shkafi_dlya_spalni/">
					Шкафы
					<?if($this->getQuantityByCategoryAlias('shkafi_dlya_spalni')):?>
					<span>предложений - <?=$this->getQuantityByCategoryAlias('shkafi_dlya_spalni')?></span>
					<?endif?>
				</a>
			</div>
			<div class="d8">
				<a href="/spalni/krovati/">
					<img src="/images/content/articles/index/krovaty.jpg">
				</a>
				<a href="/spalni/krovati/">
					Кровати
					<?if($this->getQuantityByCategoryAlias('krovati')):?>
					<span>предложений - <?=$this->getQuantityByCategoryAlias('krovati')?></span>
					<?endif?>
				</a>
			</div>
		</div>
<!--		<a href="#" class="mini-baner">
			<img src="/images/content/articles/index/banner.png">
		</a>-->
<!--		<section class="interestingly">
			<h3>Новые поступления:</h3>
			<ul>
				<li>
					<img src="/images/bg/PROD_01_03.jpg">
					<a href="#" class="linck-block">
						<strong></strong>
						<span>Стенка Парма-Люкс </span>
					</a>
					<span class="add-to-cart-2">Купить</span>
					<span class="price-mini">
						<span class="old-price-action">9 300<strong>a</strong></span>
						<span class="price-action">60 216<strong>a</strong></span>
					</span>
					<a href="#" class="more-product">
						подробнее
					</a>
					<div class="clear"></div>
				</li>
				<li>
					<img src="/images/bg/PROD_01_08.jpg">
					<a href="#" class="linck-block">
						<strong></strong>
						<span>Стенка Парма-Люкс </span>
					</a>
					<span class="add-to-cart-2">Купить</span>
					<span class="price-mini">
						<span class="old-price-action">9 300<strong>a</strong></span>
						<span class="price-action">60 216<strong>a</strong></span>
					</span>
					<a href="#" class="more-product">
						подробнее
					</a>
					<div class="clear"></div>
				</li>
				<li>
					<a href="#">
						<img src="/images/bg/PROD_01_10.jpg">
					</a>
					<a href="#" class="linck-block">
						<strong></strong>
						<span>Стенка Парма-Люкс </span>
					</a>
					<span class="add-to-cart-2">Купить</span>
					<span class="price-mini">
						<span class="old-price-action">9 300<strong>a</strong></span>
						<span class="price-action">60 216<strong>a</strong></span>
					</span>
					<a href="#" class="more-product">
						подробнее
					</a>
					<div class="clear"></div>
				</li>
				<li>
					<img src="/images/bg/PROD_01_03.jpg">
					<a href="#" class="linck-block">
						<strong></strong>
						<span>Стенка Парма-Люкс </span>
					</a>
					<span class="add-to-cart-2">Купить</span>
					<span class="price-mini">
						<span class="old-price-action">9 300<strong>a</strong></span>
						<span class="price-action">60 216<strong>a</strong></span>
					</span>
					<a href="#" class="more-product">
						подробнее
					</a>
					<div class="clear"></div>
				</li>
				<li>
					<img src="/images/bg/PROD_01_03.jpg">
					<a href="#" class="linck-block">
						<strong></strong>
						<span>Стенка Парма-Люкс </span>
					</a>
					<span class="add-to-cart-2">Купить</span>
					<span class="price-mini">
						<span class="old-price-action">9 300<strong>a</strong></span>
						<span class="price-action">60 216<strong>a</strong></span>
					</span>
					<a href="#" class="more-product">
						подробнее
					</a>
					<div class="clear"></div>
				</li>
				<li>
					<img src="/images/bg/PROD_01_08.jpg">
					<a href="#" class="linck-block">
						<strong></strong>
						<span>Стенка Парма-Люкс </span>
					</a>
					<span class="add-to-cart-2">Купить</span>
					<span class="price-mini">
						<span class="old-price-action">9 300<strong>a</strong></span>
						<span class="price-action">60 216<strong>a</strong></span>
					</span>
					<a href="#" class="more-product">
						подробнее
					</a>
					<div class="clear"></div>
				</li>
				<li>
					<a href="#">
						<img src="/images/bg/PROD_01_10.jpg">
					</a>
					<a href="#" class="linck-block">
						<strong></strong>
						<span>Стенка Парма-Люкс </span>
					</a>
					<span class="add-to-cart-2">Купить</span>
					<span class="price-mini">
						<span class="old-price-action">9 300<strong>a</strong></span>
						<span class="price-action">60 216<strong>a</strong></span>
					</span>
					<a href="#" class="more-product">
						подробнее
					</a>
					<div class="clear"></div>
				</li>
				<li>
					<img src="/images/bg/PROD_01_03.jpg">
					<a href="#" class="linck-block">
						<strong></strong>
						<span>Стенка Парма-Люкс </span>
					</a>
					<span class="add-to-cart-2">Купить</span>
					<span class="price-mini">
						<span class="old-price-action">9 300<strong>a</strong></span>
						<span class="price-action">60 216<strong>a</strong></span>
					</span>
					<a href="#" class="more-product">
						подробнее
					</a>
					<div class="clear"></div>
				</li>
			</ul>
			<div class="clear"></div>
		</section>-->
		<section class="info-block">
<?//$this->includeTemplate('news')?>
<?//$this->includeTemplate('information')?>
			<div class="clear"></div>
		</section>
	</section>
</article>

<?$this->includeTemplate('footer')?>