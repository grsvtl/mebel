			<div class="article">
				<h3>Информация:</h3>
				<?if($this->getController('Article')->getInfoArticles(5)->count()):?>
				<?foreach($this->getController('Article')->getInfoArticles(5) as $article):?>
				<a href="<?=$article->getPath()?>"><?=$article->getName()?></a>
				<?endforeach?>
				<?endif?>
				<a href="/info/" class="more-article">Остальное</a>
				<div class="clear"></div>
			</div>