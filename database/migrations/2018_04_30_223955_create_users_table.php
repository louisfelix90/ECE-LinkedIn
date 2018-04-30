<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateUsersTable extends Migration {

	public function up()
	{
		Schema::create('users', function(Blueprint $table) {
			$table->increments('user_id');
			$table->string('name');
			$table->string('surname');
			$table->string('username');
			$table->string('email');
			$table->enum('role', array('ADMIN', 'AUTHOR'));
			$table->datetime('birth_date');
			$table->string('title')->nullable();
			$table->string('cv_url')->nullable();
			$table->bigInteger('photo_id')->unsigned()->nullable();
			$table->bigInteger('cover_id')->unsigned()->nullable();
            $table->rememberToken();
			$table->timestamps();

            $table->unique([DB::raw('username(191)'), DB::raw('email(191)')]);
		});
	}

	public function down()
	{
		Schema::drop('users');
	}
}