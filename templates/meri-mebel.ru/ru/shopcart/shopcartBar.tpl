<div class="shopcartBar">
    <?if($this->getController('Shopcart')->getShopcart()->count()):?>
    <a href="/shopcart/" type="button" class="btn btn-primary btn-md btn-basket">
        <img src="/images/meriMebel/bg/shoppingbasket.png" alt="">
        <span class="text-uppercase hidden-sm hidden-xs">В корзине — </span><b id="productsCount" class="products-count"><?=$shopcartCount?></b>
        <span class="text-lowercase hidden-sm hidden-xs">т.</span>
    </a>
    <?endif?>
</div>
