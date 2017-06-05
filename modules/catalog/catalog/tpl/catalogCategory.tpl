<?include(TEMPLATES_ADMIN.'top.tpl');?>

		<script type="text/javascript" src="/admin/js/base/system/tabs.js"></script>
		<script type="text/javascript" src="/modules/catalog/categories/domainsInfo/js/domainsInfoHandler.js"></script>
		<script type="text/javascript" src="/modules/catalog/categories/domainsInfo/js/domainsInfo.class.js"></script>
		<script type="text/javascript" src="/js/ajaxLoader.class.js"></script>

		<input type="hidden" name="objectId" value="<?=$object->id?>" id="objectId"/>
		
		<div class="main single">
			<div class="max_width">
				<div class="action_buts">
					<a class="form<?=($object->id)?'Edit':'AddCategory'?>Submit pointer" ><img src="/admin/images/buttons/save_object.png" alt="" /> Сохранить</a>
					<? if ($object->id):?>
						<a class="button confirm pointer" data-confirm= "Remove the item?" data-action="/admin/catalog/remove/<?=$object->id?>/"
							data-callback="postRemoveFromDetails" data-post-action="/admin/catalog/catalogItem/" >
							<img src="/admin/images/buttons/delete.png" alt="" /> Удалить
						</a>
					<? endif;?>
					<a href="/admin/catalog/categories/"><img src="/admin/images/buttons/back.png" alt="" /> Вернуться</a>
				</div>
				<p class="speedbar"><a href="/admin/">Главная</a>     <span>></span>
					<a href="/admin/catalog/">Каталог</a>    <span>></span>
					<a href="/admin/catalog/categories/">Категории</a>    <span>></span>
					<?= $object->id ? $object->name: 'Добавление'?>
				</p>
				<div class="clear"></div>

				<div class="sitebar">
					<?if( ! $this->isAuthorisatedUserAnManager()):?>
                    <a class="pointer domainInfoLink active" data-domainalias="main" data-controller="catalog">Общая информация</a>
					<?if ($object->id):?>
					<?foreach ($this->getController('ModulesDomain')->getDomainsByModuleAlias('catalog') as $key => $value):?>
                    <a class="pointer domainInfoLink" data-domainalias="<?=$value?>"><?=$value?></a>
					<?endforeach;?>
					<?endif;?>
					<?endif?>
                    <div class="clear"></div><!--end clear-->
                </div><!--end sitebar-->

				<div id="contentBlock">
					<?$this->getMainContentCategoryBlock($object->id)?>
				</div>

			</div>
		</div><!--main-->
		<div class="vote"></div>
	</div><!--root-->
    <?include(TEMPLATES_ADMIN.'footer.tpl');?>
