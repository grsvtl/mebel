<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

	<article class="article">


		<section class="main">
			<h1 class="fabric-h1"><?=$fabricator->getH1()?></h1>
			<div class="top-info-block">
				<div class="left-info-block">
					<div class="logo-fabric">
						<?if( $this->isNoop($fabricator->getFirstPrimaryImage()) ):?>
						<p>Производитель</p>
						<?else:?>
						<img src="<?=$fabricator->getFirstPrimaryImage()->getFocusImage('0x94')?>">
						<?endif?>
					</div>
					<div class="info-fabrick">
						<ul class="list-info">
						<li>
							<div class="right-ch"><?=$fabricator->name?></div>
							<div class="left-ch">Название:</div>
							<div class="clear"></div>
						</li>
						<?if($fabricator->foundDate):?>
						<li>
							<div class="right-ch"><?=$fabricator->foundDate?></div>
							<div class="left-ch">Дата основания:</div>
							<div class="clear"></div>
						</li>
						<?endif?>
						<li>
							<div class="right-ch"><?=$fabricator->getCategory()->getName()?></div>
							<div class="left-ch">Страна:</div>
							<div class="clear"></div>
						</li>
						</ul>
					</div>
					<div class="clear"></div>
				</div>
				<div class="right-info-block">
					<?=$fabricator->text?>
				</div>
				<div class="clear"></div>
			</div>

			<?
				$series = $this->getController('Catalog')->getSeriesByFabricator($fabricator);
				$count = 0;
				foreach($series as $seria)
					if($this->getController('Catalog')->getObjectsByFabricatorAndSeria($fabricator->id, $seria->getValue())->count())
						$count++;
			?>
			<?if($count):?>
			<div class="category-fabric">
				<h2>Серии продукции фабрики (<?=$count?>)</h2>
				<ul>
				<?foreach($series as $seria):?>
					<?
						$objects = $this->getController('Catalog')->getObjectsByFabricatorAndSeria($fabricator->id, $seria->getValue());
						$objectsCount = $objects->count();
						if($objectsCount):
					?>
					<li>
						<a href="/search/?fabricator[]=<?=$fabricator->id?>&seria[]=<?=$seria->getValue()?>">
							<img src="<?=
								$seria->description ?
								$seria->description :
								$objects->current()->getFirstPrimaryImage()->getFocusImage('232x147', 'watermarkPng')
								?>" width="232" height="147" />
						</a>
						<div class="name-product-fabric">
							<a href="/search/?fabricator[]=<?=$fabricator->id?>&seria[]=<?=$seria->getValue()?>"><?=$seria->getValue()?></a>
							<span><?=$objectsCount?></span>
						</div>
					</li>
					<?endif?>
				<?endforeach?>
				</ul>
			<div class="clear"></div>
			</div>
			<?endif?>

			<?$categories = $this->getController('Catalog')->getCategoriesByFabricatorId($fabricator->id)?>
			<?if(count($categories)):?>
			<div class="category-fabric two">
				<h2>Категории продукции фабрики (<?=count($categories)?>)</h2>
				<?foreach($categories as $category):?>
				<?$objects = $this->getController('Catalog')->getObjectsByCategory($category)?>
				<?$count = $this->getController('Catalog')->countItemsByCategoryIdAndFabricatorId($category->id, $fabricator->id);?>
				<?//if($count):?>
				<div class="category-list">
					<a href="<?=$category->getPath()?>?fabricator=<?=$fabricator->id?>">
						<?=$category->getName()?> (<?=$count?>)
					</a>
				</div>
				<?//endif?>
				<?endforeach?>
				<div class="clear"></div>
			</div>
			<?endif?>


<!--			<div class="category-fabric two">
				<h2>Категории продукции фабрики (2)</h2>
				<ul>
					<li>
						<a href="#">
							<img src="/images/bg/FABRIK-—-2_07.jpg" alt="">
						</a>
						<div class="name-product-fabric">
							<a href="">Спальни</a>
						</div>
					</li>
					<li>
						<a href="#">
							<img src="/images/bg/FABRIK-—-2_07.jpg" alt="">
						</a>
						<div class="name-product-fabric">
							<a href="">Спальни</a>
						</div>
					</li>
					<li>
						<a href="#">
							<img src="/images/bg/FABRIK-—-2_07.jpg" alt="">
						</a>
						<div class="name-product-fabric">
							<a href="">Спальни</a>
						</div>
					</li>
				</ul>
				<div class="clear"></div>
			</div>-->
			<?$topObjects = $this->getController('Catalog')->getItemsByFabricatorId($fabricator->id, 8);?>
			<?if($topObjects->count()):?>
			<div class="top-fabric-product">
				<h2>Топ продукции</h2>
				<div class="product-place tile">
					<?foreach($topObjects as $object):?>
						<?$this->getController('Catalog')->getCatalogListContentItemBlock($object)?>
					<?endforeach?>
					<div class="clear"></div>
				</div>
			</div>
			<?endif?>
			<div class="clear"></div>
		</section>

	</article>
<?$this->includeTemplate('footer')?>