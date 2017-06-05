			<div class="news">
				<h3>Новости:</h3>
				<ul>
					<?if($this->getController('Article')->getNewsArticles(3)->count()):?>
					<?foreach($this->getController('Article')->getNewsArticles(3) as $new):?>
					<li>
						<a href="<?=$new->getPath()?>"><?=$new->getName()?></a>
						<span><?=$new->date?></span>
						<?=$new->description?>
						<div class="clear"></div>
					</li>
					<?endforeach?>
					<?endif?>
				</ul>
				<a href="/news/" class="more-news">Архив новостей</a>
				<div class="clear"></div>
			</div>