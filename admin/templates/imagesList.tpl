		<?if($object->getImagesCategories()) foreach($object->getImagesCategories() as $item): ?>
		<?if( $object->getImagesByCategory($item->id)->current() ): ?>
			<p><b><?=$item->name?></b></p>
		<?endif?>
		    <? foreach ( $object->getImagesByCategory($item->id) as $image ): ?>
		    <div id="image<?=$image->id?>" class="image active">
			    <div class="fileHeader hide editImage"
				    data-action="/admin/<?=$_REQUEST['controller']?>/getTemplateToEditImage/<?=$image->id?>/<?=$object->id?>/"
			    >
				    <div class="fileMenu">
					    <ul>
						    <li>
							    <a
								    href="#primary"
								    class="setPrimary<?=($image->isPrimary()) ? ' hide' : '' ?> editPrimary"
								    data-action="/admin/<?=$_REQUEST['controller']?>/setPrimary/<?=$image->id?>/"
							    >
								    primary
							    </a>
							    <a
								    href="#resetPrimary"
								    class="resetPrimary<?=($image->isPrimary()) ? '' : ' hide' ?> editPrimary"
								    data-action="/admin/<?=$_REQUEST['controller']?>/resetPrimary/<?=$image->id?>/"
							    >
								    to list
							    </a>
						    </li>
						    <li>
							    <a
								    href="#block"
								    class="setBlock<?=($image->isBlocked()) ? ' hide' : '' ?> editBlocking"
								    data-action="/admin/<?=$_REQUEST['controller']?>/setBlock/<?=$image->id?>/"
							    >
								    block
							    </a>
							    <a
								    href="#unblock"
								    class="resetBlock<?=($image->isBlocked()) ? '' : ' hide' ?> editBlocking"
								    data-action="/admin/<?=$_REQUEST['controller']?>/resetBlock/<?=$image->id?>/"
							    >
								    unblock
							    </a>
						    </li>
						    <li>
							    <a
								    href="#edit"
								    class="editImage"
								    data-action="/admin/<?=$_REQUEST['controller']?>/getTemplateToEditImage/<?=$image->id?>/<?=$object->id?>/"
							    >
								    edit
							    </a>
						    </li>
						    <li>
							    <a
								    href="#remove"
								    class="removeImage confirm"
								    data-confirm     = "Remove image?"
								    data-action      = "/admin/<?=$_REQUEST['controller']?>/removeImage/<?=$image->id?>/"
							    >
								    remove
							    </a>
						    </li>
					    </ul>
				    </div>
				    <span class="fileTitle"><?=$image->name?></span>
				    <span class="fileDescription"><?=$image->description?></span>
			    </div>
			    <a href="<?=$image->getImage('800x600')?>" class="lightbox">
				    <img src="<?=$image->getImage('240x180')?>" />
			    </a>
			    <p>Приоритет - <?= $image->priority?></p>
			    <p>ID - <?= $image->id?></p>
			    <p><?=  str_replace(DIR, '/', $image->getPath())?></p>
		    </div>
		    <? endforeach; ?>
			<div class="clear"></div>
			<br /><br /><br />
		<?endforeach;?>