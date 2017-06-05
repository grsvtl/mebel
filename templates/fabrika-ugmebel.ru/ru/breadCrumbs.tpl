<section id="navigation">
    <div class="container">
        <ol class="breadcrumb">
            <li>
                <a href="/">Главная</a>
            </li>
            <? $count=0; foreach($breadcrumbs as $breadcrumb): $count++;?>
                <? if (empty($breadcrumb['url'])): ?>
                    <li class="active"><?=$breadcrumb['name']?></li>
                <? else: ?>
                    <li><a href="<?=$breadcrumb['url']?>"><?=$breadcrumb['name']?></a></li>
                <? endif; ?>
            <? endforeach; ?>
        </ol>
    </div>
</section>