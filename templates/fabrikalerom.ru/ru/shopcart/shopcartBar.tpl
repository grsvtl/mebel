<div class="shopcartBar">
    <a href="/shopcart/">
        <div class="card-block">
            <p>Товаров в корзине - <strong><?if($this->getController('Shopcart')->getShopcart()->count()):?><?=$shopcartCount?><?else:?>0<?endif?></strong></p>
        </div>
    </a>
</div>