<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use App\Models\Listing;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run()
    {
        \App\Models\User::factory(10)->create();

        Listing::create([
            'title' => 'Divemaster',
            'tags' => 'divemaster, instructor',
            'company' => 'Thresher Divers',
            'location' => 'Malapascua, Phillipines',
            'email' => 'thresherdivers@email.com',
            'website' => 'www.thresherdivers.com',
            'description' => 'This is a position for a divemaster
            to instruct classes for PADI open water students and
            to guide groups of certified divers in sites in Monad
            Shoal and Gato Island'
        ]);
    }
        // \App\Models\User::factory()->create([
        //     'name' => 'Test User',
        //     'email' => 'test@example.com',
        // ]);
    }

