<?if( isset($this->getGet()['fabricator']) && !isset($this->getGet()['minPrice']) ):?>
<div class="fabricator-notice">
	Выбраны товары
	<?if( isset($this->getGet()['seria']) && !isset($this->getGet()['minPrice']) ):?>
	 серии "<?= is_array($this->getGet()['seria']) ? $this->getGet()['seria'][0] : $this->getGet()['seria']?>"
	<?endif?>
	производителя "<?= is_array($this->getGet()['fabricator']) ? $this->getFabricatorById($this->getGet()['fabricator'][0])->getName() : $this->getFabricatorById($this->getGet()['fabricator'])->getName() ?>"	:
</div>
<?endif?>

<?include('sortingBlock.tpl')?>

<script type="text/javascript" src="/admin/js/jquery/touch/touchslider.js"></script>
<script type="text/javascript" src="/js/plugins/gallery/gallery.js"></script>
<script type="text/javascript" src="/js/catalog/catalogObject.js"></script>

<div class="product-place tile">
	<?foreach($objects as $object):?>
		<?$this->getCatalogListContentItemBlock($object)?>
	<?endforeach?>
	<div class="clear"></div>
</div>

<?include('paginator.tpl')?>