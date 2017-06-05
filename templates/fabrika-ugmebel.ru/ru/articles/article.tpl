<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

    <section id="catalog">
        <div class="container">
            <h1 class="text-center"><?=$article->getH1()?></h1>
<!--            <div class="row">-->
                <?=$article->getText()?>
<!--            </div>-->
        </div>
    </section>
</main>

<?$this->includeTemplate('footer')?>