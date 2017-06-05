<?if ($pager  &&  $pager->getTotalPages() > 1):?>
<div class="paginator pagerElement">
<?if($pager->getPrevPage()):?>
	<a href="<?=$pager->getPrevPage()->getLink()?>"> Пред.</a>
<?endif?>
<?foreach ( $pager as $page):?>
	<?if($page->isCurrentPage()):?>
		<span><?=$page->getPage()?></span>
	<?else:?>
		<a href="<?=$page->getLink('showFirstPageLink')?>"><?=$page->getPage()?></a>
	<?endif?>
<?  endforeach;?>
<?if($pager->getNextPage()):?>
	<a href="<?=$pager->getNextPage()->getLink()?>">След. </a>
<?endif?>
</div>
<?endif;?>