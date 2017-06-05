<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>
    <main id="main">
        <div class="container">
            <br>
            <?$this->includeBreadcrumbs()?>
            <article>
                <h1><?=$article->getH1()?></h1>
                <?=$article->getText()?>
            </article>
            <br>
            <br>
        </div>
    </main>
<?$this->includeTemplate('footer')?>