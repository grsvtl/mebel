<?php
namespace core\traits\validators;
trait Capcha
{
	protected function _validCorrectCapcha($data)
	{
		$capcha = new \core\capcha\CapchaString();
		if (!$capcha->checkCapcha($data)) {
			$this->errors['capcha'] = $this->errorsList['capcha'];
			return 'error_add';
		}
		return true;
	}
}