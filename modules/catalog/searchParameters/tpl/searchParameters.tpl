<?include(TEMPLATES_ADMIN.'top.tpl');?>
<script type="text/javascript" src="/admin/js/base/system/sorting.js"></script>
<script type="text/javascript" src="/admin/js/base/system/groupActions.js"></script>
<div class="main single">
    <div class="max_width">
        <div class="action_buts">
            <a class="filters pointer"><img src="/admin/images/buttons/search.png" alt="" /> Фильтрация</a>
        </div>
        <p class="speedbar"><a href="/admin/">Главная</a>     <span>></span>
            Фильтрация по корпусу
        </p>
        <div class="clear"></div>
        <!-- Start: Filetrs Block -->
        <div id="filter-form"  style="<?=(isset($_REQUEST['form_in_use'])?'display:block;':'display:none;')?>">
            <form id="search" action="" method="get">
                <input type="hidden" name="form_in_use" value="true" />
                <table>
                    <tr>
                        <td class="right">Статус:</td>
                        <td>
                            <select class="filterInput" name="statusId">
                                <option value="">&nbsp;</option>
                                <?php foreach ($objects->getStatuses() as $status):?>
                                <option value="<?=$status->id?>" <?=($this->getGET()['statusId']==$status->id)?'selected':''?>><?=$status->name?></option>
                                <?php endforeach;?>
                            </select>
                        </td>
                        <td class="right">Значение:</td>
                        <td><input class="filterInput" type="text" name="value" value="<?=$this->getGET()['value']?>" /></td>
                    </tr>
                    <tr>
                        <td colspan="8">
                            <div class="action_buts">
                                <a class="pointer" onclick="$('#search').submit()"><img src="/admin/images/buttons/search.png" /> Поиск</a>
                                <a class="resetFilters" href="/admin/<?=$_REQUEST['controller']?>/"><img src="/admin/images/buttons/delete.png" /> Сбросить фильтры</a>
                            </div>
                        </td>
                    <tr>
                </table>
            </form>
        </div>
        <!-- End: Filters Block -->
        <div class="table_edit">
            <?if(empty($objects)): echo 'No Data'; else:?>
            <table  id="objects-tbl" data-sortUrlAction="/admin/searchParameters/changePriority/?" width="100%">
                <tr>
                    <th colspan="2" class="first">id</th>
                    <th style="width: 400px;">Название</th>
                    <th style="width: 300px;">Статус</th>
                    <th class="last" colspan="4">Приоритет</th>
                </tr>
                <?foreach ($objects as $object):?>
                <tr id="id<?=$object->id?>" class="dblclick" data-url="/admin/searchParameters/searchParameter/<?= $object->id?>" data-id="<?= $object->id?>" data-priority="<?= $object->priority?>">
                    <td><input type="checkbox" class="groupElements" /></td>
                    <td><?=$object->id?></td>
                    <td><p class="alias" style="text-align: center;"><a href="/admin/searchParameters/searchParameter/<?=$object->id?>/"><?=$this->mb_ucfirst($object->getParameterValue()->value)?></a></p></td>
                    <td><p class="status" style="text-align: center;"><font color="<?=$object->getStatus()->color?>"><?=$object->getStatus()->name?></font></p></td>
                    <td class="td_bord sortHandle header"><?= $object->priority?></td>
                    <td><a href="/admin/searchParameters/searchParameter/<?=$object->id?>/" class="pen"></a></td>
                    <td><a class="del pointer button confirm" data-confirm="Remove the item?" data-action="/admin/searchParameters/remove/<?=$object->id?>/" data-callback="postRemoveArticle"></a></td>
                </tr>
                <?endforeach?>
            </table>
            <?endif?>
        </div>

        <?$this->printPager($pager, 'pager')?>
    </div>
</div><!--main-->
<div class="vote"></div>
</div><!--root-->
<?include(TEMPLATES_ADMIN.'footer.tpl');?>
