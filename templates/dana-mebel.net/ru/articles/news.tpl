<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>
<div class="textPageMain">
		<div class="textPage">

			<?$this->includeBreadcrumbs()?>

			<h1>Новости</h1>

			<?foreach($news as $new):?>
			<a href="<?=$new->getPath()?>">
				<div class="recallBlock">
					<div class="nameAndDateRecall">
						<div class="nameRecall"><?=$new->getName()?></div>
						<div class="dateRecall"><?=str_replace('-', '.', $new->date)?></div>
						<div class="clear"></div>
					</div>
					<p><?=$new->getDescription()?></p>
				</div>
			</a>
			<?endforeach?>

		</div>
		<div class="clear"></div>
	</div>
<?$this->includeTemplate('footer')?>