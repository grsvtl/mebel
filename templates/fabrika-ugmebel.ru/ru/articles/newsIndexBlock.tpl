<?if($news->count()):?>
<section id="news">
    <div class="container">
        <h2 class="text-center">Новости фабрики</h2>
        <div class="row news">
            <?foreach ($news as $object):?>
            <div class="col-sm-6">
                <div class="row">
                    <div class="col-lg-5 col-md-4">
                        <?if(!$this->isNoop($object->getFirstPrimaryImage())):?>
                        <a href="<?=$object->getPath()?>" class="img-cover" style="background-image: url(<?=$object->getFirstPrimaryImage()->getImage('213x120')?>);"></a>
                        <?endif;?>
                    </div>
                    <div class="col-lg-7 col-md-8">
                        <a href="<?=$object->getPath()?>"><h5><?=$object->getName()?></h5></a>
                        <time><?=$object->date?></time>
                        <?=$object->getDescription()?>
                    </div>
                </div>
            </div>
            <?endforeach;?>
        </div>
        <br>
        <div class="text-center">
            <a href="/news_ug/" class="btn btn-default btn-lg">Архив новостей</a>
        </div>
    </div>
</section>
<?endif;?>