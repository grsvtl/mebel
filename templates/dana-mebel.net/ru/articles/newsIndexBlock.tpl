<?if($news->count()):?>
<div class="newsBlock">
		<div class="h2">
			<span>Новости фабрики</span>
		</div>
		<ul>
			<?foreach($news as $new):?>
			<li>
				<?if($this->isNotNoop($new->getFirstPrimaryImage())):?>
				<a href="<?=$new->getPath()?>"><img src="<?=$new->getFirstPrimaryImage()->getImage('273x141')?>" alt=""></a>
				<?endif?>
				<span class="redDate"><?=str_replace('-', '.', $new->date)?></span>
				<a href="<?=$new->getPath()?>" class="titleNews"><?=$new->getName()?></a>
				<?=$new->getDescription()?>
			</li>
			<?endforeach?>
		</ul>
		<div class="clear"></div>
		<a href="/news/" class="allNews">Все новости</a>
	</div>
<?endif?>