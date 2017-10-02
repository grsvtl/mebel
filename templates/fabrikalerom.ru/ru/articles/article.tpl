<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

<!--body-->
<main>
    <div class="container main-content text-page">
        <?$this->includeBreadcrumbs()?>
        <h1><?=$article->getH1()?></h1>
        <?=$article->getText()?>
    </div>
</main>

<!--body end-->

<?$this->includeTemplate('footer')?>