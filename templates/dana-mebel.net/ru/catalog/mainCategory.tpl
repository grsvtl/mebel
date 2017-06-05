<?$this->includeTemplate('meta')?>
<?$this->includeTemplate('header')?>

<div class="mainContent">
		<div class="buttonMenu">
			<span>Каталог</span>
		</div>
		<div class="bgGrayMenu"></div>
		<div class="leftMenu">

			<?=$this->getController('Catalog')->getCatalogLeftMenu()?>

		</div>
		<div class="rightContent">

			<?$this->includeBreadcrumbs()?>

			<h1><?=$h1?></h1>

            <?if(isset($series)):?>
			    <?$this->getSeriaBlock($series)?>
            <?else:?>

                <?
                $categories = $this->getCategoriesByFabricatorId( $this->getDanaFabricatorId() );
                if(count($categories)):
                ?>
                    <div class="compositiomMebel">
                        <?foreach ($categories as $category):?>
                        <?$objects = $this->getController('Catalog')->getObjectsByCategory($category, $this->getDanaFabricatorId());?>
                        <li>
                            <a
                                href="<?=$category->getPath()?>" class="imgComposition"
                                style="background-image: url(<?=$objects->current()->getFirstPrimaryImage()->getFocusImage('272x166')?>)"
                            >
                                <span class="nameComposition"><?=$category->getName()?></span>
                            </a>
                        </li>
                        <?endforeach?>
                        <div class="clear"></div>
                    </div>
                <?endif?>

            <?endif?>

		</div>
		<div class="clear"></div>
	</div>

<?$this->includeTemplate('footer')?>