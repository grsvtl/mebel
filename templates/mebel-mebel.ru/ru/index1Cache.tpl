<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

<link rel="stylesheet" type="text/css" href="/css/vn-mebel.ru/content/articles/index.css" property="stylesheet" />
<script type="text/javascript" src="/js/plugins/gallery/gallery.js"></script>
<script type="text/javascript" src="/admin/js/jquery/touch/touchslider.js"></script>
<link rel="stylesheet" type="text/css" href="/admin/js/jquery/touch/touchslider.css" property="stylesheet" />
<script type="text/javascript" src="/js/catalog/catalogObject.js"></script>
<script>
	$(document).ready(function(){
		$(".touchslider-demo").touchSlider({
				mouseTouch: true,
				autoplay: true
		});
	});
</script>

<!--<section class="banner">
	<section class="center-banner">-->
<div class="banner">
	<div class="center-banner">

        <?$smallImages = $this->getController('Article')->getMainSmallImagesArticle()->getImagesByCategoryAndStatus('1,2', 1)?>
        <?if($smallImages->count()): $i=1; foreach( $smallImages as $image ):?>
        <div class="b<?=$i?>">
            <a href="<?=$image->description?>">
                <img src="<?=str_replace(DIR, '/', $image->getPath())?>" alt="photo" />
            </a>
        </div>
        <?$i++; endforeach; endif?>

        <?$bigImages = $this->getController('Article')->getMainBigImagesArticle()->getImagesByCategoryAndStatus('1,2', 1)?>
        <?if($bigImages->count()):?>
		<div class="main-banner">
			<div class="touchslider-padding">
				<div class="touchslider touchslider-demo">
					<div class="touchslider-viewport" style="width:646px; overflow:hidden; position: relative; height: 429px;">
                        <?foreach( $bigImages as $image ):?>
                        <div class="touchslider-item">
                            <a href="<?=$image->description?>">
                                <img src="<?=str_replace(DIR, '/', $image->getPath())?>" alt="photo" />
                            </a>
                        </div>
                        <?endforeach;?>
					</div>
					<div class="touchslider-nav">
                        <?$i=1; foreach( $bigImages as $image ):?>
                            <span class="touchslider-nav-item <?= $i==1 ? 'touchslider-nav-item-current' : ''?>"></span>
                        <?$i++; endforeach;?>
					</div>
				</div>
			</div>
		</div>
        <?endif?>
<!--	</section>
</section>-->
	</div>
</div>

<div class="title">
	<h1>Интернет-магазин мебели для дома</h1>
</div>

<?//$fabricators = $this->getObject('\modules\fabricators\lib\Fabricators')->getActiveFabricators()?>

<!--<section class="filter">
	<section class="center-filter">-->
<div class="filter">
	<div class="center-filter">

<!--			<select class="fabricator">
				<option value>-- все фабрики --</option>
				<?//foreach($fabricators as $fabricator):?>
				<option value="<?//=$fabricator->id?>"><?//=$fabricator->name?></option>
				<?//endforeach?>
			</select>-->
			<select class="mainCategory">
				<option value>-- все типы мебели --</option>
				<?foreach ($this->getController('Catalog')->getMainCategoriesWhichHasChildren() as $mainCategory):?>
				<option value="<?=$mainCategory->id?>"><?=$mainCategory->name?></option>
				<?endforeach?>
			</select>
			<span>Цена от</span>
			<input class="minPrice" value="<?=$this->getController('Catalog')->getMinPrice()?>">
			<div class="strongArrow"></div>
			<span>До</span>
			<input class="maxPrice" value="<?=$this->getController('Catalog')->getMaxPrice()?>">
			<button class="indexSearchButton">искать товар</button>
			<div class="clear"></div>
<!--	</section>
</section>-->
	</div>
</div>
<!--Начало основного контента-->
<!--<article>-->
<div>
	<section class="main">