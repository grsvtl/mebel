<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

    <section id="catalog">
        <div class="container">
            <h1 class="text-center"><?=$h1?></h1>
            <br>
            <?if(count($objects)):?>
            <div class="product-catalog">
                <div class="row products">
                    <?foreach($objects as $object):?>

                    <?$this->setContent('object', $object)->includeTemplate('catalog/catalogListItem')?>

                    <?endforeach?>

                </div>
            </div>
            <?endif?>
        </div>
    </section>
</main>

<?$this->includeTemplate('footer')?>