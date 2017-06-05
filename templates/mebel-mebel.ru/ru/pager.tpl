<?if (!empty($pager)):?>
<p class="page_navi">
<?if($pager->getFirstPage()):?>
	<a href="<?=$pager->getFirstPage()->getLink()?>">&lt; &lt;</a>
<?endif?>
<?if($pager->getPrevPage()):?>
	<a href="<?=$pager->getPrevPage()->getLink()?>"> &lt;</a>
<?endif?>
<?foreach ( $pager as $page):?>
	<?if($page->isCurrentPage()):?>
		<span><?=$page->getPage()?></span>
	<?else:?>
		<a href="<?=$page->getLink()?>"><?=$page->getPage()?></a>
	<?endif?>
<?  endforeach;?>
<?if($pager->getNextPage()):?>
	<a href="<?=$pager->getNextPage()->getLink()?>">&gt; </a>
<?endif?>
<?if($pager->getLastPage()):?>
	<a href="<?=$pager->getLastPage()->getLink()?>">&gt; &gt;</a>
<?endif?>
</p>
<?endif;?>