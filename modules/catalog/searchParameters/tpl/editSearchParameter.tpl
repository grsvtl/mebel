<div class="main_edit">
    <input type='hidden' class='objectId' value='<?=$searchParameter->id?>'>
    <div class="main_param">
        <div class="col_in">
            <p class="title">Основные параметры:</p>
            <table width="100%">
                <tr>
                    <td class="first">Имя:</td>
                    <td><input type="text" value="<?=$this->mb_ucfirst($searchParameter->getParameterValue()->value)?>" disabled/></td>
                </tr>
            </table>
        </div>
    </div><!--main_param-->
    <div class="dop_param">
        <div class="col_in">
            <p class="title">Дополнительные параметры:</p>
            <table width="100%">
                <tr>
                    <td class="first">Status:</td>
                    <td>
                        <input type="hidden" name="id" value="<?=$searchParameter->id?>" />
                        <select name="statusId" style="width:150px;">
                            <?if ($statuses): foreach($statuses as $status):?>
                            <option value="<?=$status->id?>" <?= $status->id==$searchParameter->statusId ? 'selected' : ''?>><?=$status->name?></option>
                            <?endforeach; endif?>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="first">Приоритет:</td>
                    <td><input name="priority" value="<?=$searchParameter->priority; ?>" /></td>
                </tr>
            </table>

        </div>
    </div><!--dop_param-->

    <div class="clear"></div>
</div><!--main_edit-->