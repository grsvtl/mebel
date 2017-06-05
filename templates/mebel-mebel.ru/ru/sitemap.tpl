<?php $this->includeTemplate('meta');?>
<?php $this->includeTemplate('header');?>			
			<div class="main">
				<div class="left_col">
					<div class="col_in">
					<?$this->includeTemplate('crumbs')?>
					<?$this->includeTemplate('quickOrder')?>
					<?$this->includeTemplate('statusOrder')?>
					</div>
				</div><!--left_col-->
				
				<div class="right_col">
					<div class="col_in">
						<div class="page">
							<p class="page_title">Карта сайта</p>
							<div class="content">
								<ul>
								<?foreach ($mainArticles as $mainArticle): ?>									
									<li><a href="<?=$mainArticle->alias?>"><?=$mainArticle->name?></a></li>
										<?if ($mainArticle->alias == 'news'): foreach ($news as $new): ?>
										<li>&nbsp;&nbsp;&nbsp;&nbsp;<a href="<?=$new->alias?>"><?=$new->name?></a></li>
										<?endforeach; endif;?>									
								<?endforeach; ?>
								</ul>
							</div>
						</div><!--page-->
					</div>
				</div><!--right_col-->
			
				<div class="clear"></div>				
			</div><!--main-->
			
		</div>
		<div class="vote"></div>
	</div>
<?php $this->includeTemplate('footer');