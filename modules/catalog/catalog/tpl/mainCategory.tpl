<script type="text/javascript" src="/admin/js/base/system/tabs.js"></script>
<form class="form<?=($object->id)?'Edit':'AddCategory'?>" action="/admin/catalog/category<?=($object->id)?'Edit':'Add'?>/" method="post" data-post-action="/admin/catalog/categories/">
	<div id="tabs">
		<div class="tab_page">
			<ul>
			<?foreach ($tabs as $tab=>$tabName):?>
				<li>
					<a href="#<?=$tab?>"><?=$tabName?></a>
				</li>
			<?endforeach?>
			</ul>
		</div>
		<?foreach ($tabs as $tab=>$tabName):?>
			<div id="<?=$tab?>">
				<?$this->includeTemplate($tab); ?>
			</div>
		<?endforeach?>
	</div>
</form>