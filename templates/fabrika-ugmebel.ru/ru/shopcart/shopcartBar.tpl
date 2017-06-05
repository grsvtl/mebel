<div class="shopcartBar">
    <?if($this->getController('Shopcart')->getShopcart()->count()):?>
    <a href="/shopcart/" type="button" class="btn btn-primary btn-md btn-basket">
        <span class="text-uppercase hidden-sm hidden-xs">Корзина — </span><b id="productsCount" class="products-count"><?=$shopcartCount?></b>
        <span class="text-lowercase hidden-sm hidden-xs">тов.</span>
    </a>
    <?endif?>
</div>