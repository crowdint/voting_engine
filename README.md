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

##Promoted Submissions
___
By default a submission gets promoted when it reaches 10 upvotes, but you can change it by setting the VOTES_LIMIT environment variable

##Promoted Submissions Actions
---
Once a submission has been promoted an admin user will be able to perform actions on it, such as:

- Accept
- Reject
- Complete
   
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
					promoted_at: null,
					done_at: null,
					rejected_at: null,
					accepted_at: null,
					votes: 10
				},
				{
					id: 2
					description: 'lorem ipsum ...',
					created_at: '2011-07-14 19:43:37 +0100',
					promoted_at: null,
					done_at: null,
					rejected_at: null,
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
				created_at: '2011-07-14 19:43:37 +0100',
				promoted_at: null,
				done_at: null,
				rejected_at: null,
				accepted_at: null,
				votes: 10
			}
- ### Create a new submission

	- ##### Definition
			
			POST /submissions
			
	- ##### Response example
	
			{
				id: 1
				description: 'lorem ipsum ...',
				created_at: '2011-07-14 19:43:37 +0100',
				promoted_at: null,
				done_at: null,
				rejected_at: null,
				accepted_at: null,
				votes: 10
			}
			
- ### Voting for a submission
	- ##### Definition
			
				POST /submissions/:id/vote
			
	- ##### Response example
	
				{
					votes: 10
				}
			
- ###Accepting Submissions
  - ##### Definition
			
			POST /submissions/:id/accept
			
  - ##### Response example
	
			{
				votes: 10
			}
- ###Rejecting Submissions
  - ##### Definition
			
			POST /submissions/:id/reject
			
  - ##### Response example
	
			{
				votes: 10
			}
- ###Completing Submissions
  A submission can only be marked as done after being accepted
  - ##### Definition
			
			POST /submissions/:id/complete
			
  - ##### Response example
	
			{
				votes: 10
			}

- ### Get a list of promoted submissions
	- ##### Definition
			
			GET /submissions/promoted
			
	- ##### Response example
	
			[
				{
					id: 1
					description: 'lorem ipsum ...',
					created_at: '2011-07-14 19:43:37 +0100',
					promoted_at: '2011-07-24 19:43:37 +0100',
					done_at: null,
					rejected_at: null,
					accepted_at: null,
					votes: 10
				},
				{
					id: 2
					description: 'lorem ipsum ...',
					created_at: '2011-07-14 19:43:37 +0100',
					promoted_at: '2011-07-24 19:43:37 +0100',
					done_at: null,
					rejected_at: null,
					accepted_at: null,
					votes: 10
				}
			]

- ### Get a list of accepted submissions
	- ##### Definition
			
			GET /submissions/accepted
			
	- ##### Response example
	
			[
				{
					id: 1
					description: 'lorem ipsum ...',
					created_at: '2011-07-14 19:43:37 +0100',
					promoted_at: '2011-07-24 19:43:37 +0100',
					done_at: null,
					rejected_at: null,
					accepted_at: '2011-07-24 20:43:37 +0100',
					votes: 10
				},
				{
					id: 2
					description: 'lorem ipsum ...',
					created_at: '2011-07-14 19:43:37 +0100',
					promoted_at: '2011-07-24 19:43:37 +0100',
					done_at: null,
					rejected_at: null,
					accepted_at: '2011-07-24 20:43:37 +0100',
					votes: 10
				}
			]

- ### Get a list of rejected submissions
	- ##### Definition
			
			GET /submissions/rejected
			
	- ##### Response example
	
			[
				{
					id: 1
					description: 'lorem ipsum ...',
					created_at: '2011-07-14 19:43:37 +0100',
					promoted_at: '2011-07-24 19:43:37 +0100',
					done_at: null,
					rejected_at: '2011-07-24 20:43:37 +0100',
					accepted_at: null,
					votes: 10
				},
				{
					id: 2
					description: 'lorem ipsum ...',
					created_at: '2011-07-14 19:43:37 +0100',
					promoted_at: '2011-07-24 19:43:37 +0100',
					done_at: null,
					rejected_at: '2011-07-24 20:43:37 +0100',
					accepted_at: null,
					votes: 10
				}
			]

- ### Get a list of completed submissions
	- ##### Definition
			
			GET /submissions/done
			
	- ##### Response example
	
			[
				{
					id: 1
					description: 'lorem ipsum ...',
					created_at: '2011-07-14 19:43:37 +0100',
					promoted_at: '2011-07-24 19:43:37 +0100',
					done_at: '2011-07-24 22:43:37 +0100',
					rejected_at: null,
					accepted_at: '2011-07-24 20:43:37 +0100',
					votes: 10
				},
				{
					id: 2
					description: 'lorem ipsum ...',
					created_at: '2011-07-14 19:43:37 +0100',
					promoted_at: '2011-07-24 19:43:37 +0100',
					done_at: '2011-07-24 22:43:37 +0100',
					rejected_at: null,
					accepted_at: '2011-07-24 20:43:37 +0100',
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

