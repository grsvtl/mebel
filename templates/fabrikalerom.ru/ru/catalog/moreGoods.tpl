<?foreach ($objects as $object):?>
<div class="col-md-4 col-sm-6 col-xs-6 productItemSingle" style="display: none;">
    <?$this->getController('Catalog')->getCatalogListContentItemBlock($object)?>
</div>
<?endforeach?>