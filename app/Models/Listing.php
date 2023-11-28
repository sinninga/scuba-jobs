<?php
    namespace App\Models;

    class Listing {
        public static function all() {
            return [
                [
                    'id' => 1,
                    'title' => 'Listing One',
                    'description' => 'This is the job description
                    of the job that is being described'
                ],
                [
                    'id' => 2,
                    'title' => 'Listing Two',
                    'description' => 'This is the job description
                    of the job that is being described'
                ]
                ];
        }
    }