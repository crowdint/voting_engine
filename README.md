#Voting App

## Installation
___

Gemfile

    gem 'voting_app'

Bundle

    bundle install

Copy migrations

    rake voting_app:install:migrations

Run them

    rake db:migrate

Mount

    #
    # routes.rb
    #

    mount VotingApp::Engine => '/voting_app'
    
##Accepting Submissions
___
By default a submission is accepted when it reaches 10 upvotes, but you can change it by setting the VOTES_LIMIT environment variable
   
## API
___
- ###Get a list of submissions

    - ##### Definition
	
			GET /submissions
 			
 	- ##### Response example
			
			[
				{
					id: 1
					description: 'lorem ipsum ...',
					created_at: '2011-07-14 19:43:37 +0100',
					accepted_at: null,
					votes: 10
				},
				{
					id: 2
					description: 'lorem ipsum ...',
					created_at: '2011-07-14 19:43:37 +0100',
					accepted_at: null,
					votes: 10
				}
			]
			
- ### Show a submission in detail
	
	- ##### Definition
			
			GET /submissions/:id
			
	- ##### Response example
	
			{
				id: 1
				description: 'lorem ipsum ...',
				created_at: '',
				accepted_at: '',
				votes: 10
			}
- ### Create a new submission

	- ##### Definition
			
			POST /submissions
			
	- ##### Response example
	
			{
				id: 1
				description: 'lorem ipsum ...',
				created_at: '',
				accepted_at: '',
				votes: 10
			}

- ### Delete a submission
	- ##### Definition
			
			DELETE /submissions/:id

			
	- ##### Response example
	
			{
				id: 1
				description: 'lorem ipsum ...',
				created_at: '',
				accepted_at: '',
				votes: 10
			} 
- ### Edit a submission
	- ##### Definition
			
			PUT /submissions/:id
			
	- ##### Response example
	
			{
				id: 1
				description: 'lorem ipsum ...',
				created_at: '',
				accepted_at: '',
				votes: 10
			}
- ### Vote for a submission
	- ##### Definition
			
			POST /submissions/:id/votes
			
	- ##### Response example
	
			{
				votes: 10
			}
- ### Get a list of accepted submissions
	- ##### Definition
			
			GET /accepted
			
	- ##### Response example
	
			[
				{
					id: 1
					description: 'lorem ipsum ...',
					created_at: '2011-07-14 19:43:37 +0100',
					accepted_at: '2011-08-24 19:43:37 +0100',
					votes: 10
				},
				{
					id: 2
					description: 'lorem ipsum ...',
					created_at: '2011-07-14 19:43:37 +0100',
					accepted_at: '2011-07-24 19:43:37 +0100',
					votes: 10
				}
			]


## License

MIT License. Copyright 2011, Crowd Interactive http://www.crowdint.com

[Crowd Interactive](http://www.crowdint.com) is a leading Ruby and Rails consultancy
firm based in Mexico currently doing business with startups in the United States.
We specialize in building and growing your existing development team, by adding
engineers onsite or offsite. We pick our clients carefully, as we only work with
companies we believe in. Find out more about us on our [website](http://www.crowdint.com).

