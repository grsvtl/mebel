<?if (!$this->isIndex()):?>
<!--noindex-->
<div class="b-c-line">
    <a href="/">Главная</a>
    <span>-</span>
    <? $count=0; foreach($breadcrumbs as $breadcrumb): $count++;?>
    <? if (empty($breadcrumb['url'])): ?>
    <span class="here"><?=$breadcrumb['name']?></span>
    <? else: ?>
    <a href="<?=$breadcrumb['url']?>"><?=$breadcrumb['name']?></a>
    <? endif; ?>
    <? if($count < sizeof($breadcrumbs)): ?>
    <span>-</span>
    <? endif; ?>
    <? endforeach; ?>
</div>
<!--/noindex-->
<?endif?>