<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

    <section id="catalog">
        <div class="container">
            <h1 class="text-center">Новости</h1>
            <div class="row">
                <?if($news->count()): foreach ($news as $object):?>
                <a href="<?=$object->getPath()?>" class="aRecall">
                    <div class="recallBlock">
                        <div class="nameAndDateRecall">
                            <div class="nameRecall"><?=$object->getName()?></div>
                            <div class="dateRecall"><?=$object->date?></div>
                            <div class="clear"></div>
                        </div>
                        <?=$object->getDescription()?>
                    </div>
                </a>
                <?endforeach; endif;?>
            </div>
        </div>
    </section>
    </main>

<?$this->includeTemplate('footer')?>