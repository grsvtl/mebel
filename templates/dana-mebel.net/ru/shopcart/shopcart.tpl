<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

<link href="/templates/node_modules/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="/templates/node_modules/bootstrap/dist/js/bootstrap.min.js"></script>
<link href="/css/<?=$this->getCurrentDomainAlias()?>/shopcart/theme.css" rel="stylesheet">

<article>
	<section class="main">
		<?=$content?>
        <div class="successBlockHybrid">Спасибо. Ваш заказ принят. Мы перезвоним Вам в ближайшее время.</div>
	</section>
</article>

<?$this->includeTemplate('footer')?>