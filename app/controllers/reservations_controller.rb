class ReservationsController < ApplicationController
	before_action :authenticate_user!, except: [:notify]

	def preload
		property = Property.find(params[:property_id])
		today = Date.today
		reservations = property.reservations.where("start_date >= ? OR end_date >= ?", today, today)

		render json: reservations
	end

	def preview
		start_date = Date.parse(params[:start_date])
		end_date = Date.parse(params[:end_date])

		output = {
			conflict: is_conflict(start_date, end_date)
		}

		render json: output
	end

	def create
		@reservation = current_user.reservations.create(reservation_params)

		if @reservation

			base_url = 'https://microsites.nbg.gr/api.gateway/sandbox/obppayment/headers/v1.2.1/obp/banks/DB173089-A8FE-43F1-8947-F1B2A8699829/accounts/b2a17d70-1e14-4120-9799-ae2ee246bbaa/'

			response = HTTParty.post(base_url + 'owner/transaction-request-types/card/transaction-requests/',
															body: {
																'extensions' => { beneficiaryName: "My counterparty",
																											challengeExpiration: "integer",
																											challengeText: "string",
																											challengeType: "string"},
																						'to' => { creditCardNumber: "4917910017457593",
																											bankCode: "string"},
																						'value' => { currency: "EUR",
																												 amount: @reservation.total }
			  },
			  headers: {
					"Client-Id"  => "E0D4E8DB-D6D4-45D8-82C3-94F8ACFB69ED",
					"request_id"  => "E0D4E8DB-D6D4-45D8-82C3-94F8ACFB69ED",
					"application_id"  => "E0D4E8DB-D6D4-45D8-82C3-94F8ACFB69ED",
					"provider_id"  => "nbg.gr",
					"provider_username"  => "zacharias",
					"sandbox_id"  => "E0D4E8DB-D6D4-45D8-82C3-94F8ACFB69ED",
					"provider" => "NBG"
			  })
			payload = response.parsed_response
			case response.code
			when 201
				base_url = 'https://microsites.nbg.gr/api.gateway/sandbox/obppayment/headers/v1.2.1/obp/banks/DB173089-A8FE-43F1-8947-F1B2A8699829/accounts/b2a17d70-1e14-4120-9799-ae2ee246bbaa/'
				response2 = HTTParty.post(base_url + 'owner/transaction-request-types/card/transaction-requests/' + payload["id"] + '/challenge',
																 body: { id: "",
																					answer: "integer"
																						},
																					  headers: {
																							"Client-Id"  => "E0D4E8DB-D6D4-45D8-82C3-94F8ACFB69ED",
																							"request_id"  => "E0D4E8DB-D6D4-45D8-82C3-94F8ACFB69ED",
																							"application_id"  => "E0D4E8DB-D6D4-45D8-82C3-94F8ACFB69ED",
																							"provider_id"  => "nbg.gr",
																							"provider_username"  => "zacharias",
																							"sandbox_id"  => "E0D4E8DB-D6D4-45D8-82C3-94F8ACFB69ED",
																							"provider" => "NBG"
																					  })
				payload2 = response2.parsed_response

					case response2.code
					when 201
						@reservation.update_attributes status: true
					 redirect_to "/your_bookings", notice: "Success"
					end

			when 400...499
				flash[:alert] = response.body
				redirect_to :back
			when 500...600
				flash[:alert] = 'Generic server error on the other side.'
				redirect_to :back
			end
		else
			redirect_to @reservation.property, alert: "Card declined."
		end
	end

	protect_from_forgery except: [:notify]
	def notify
		params.permit!
		status = params[:payment_status]

		reservation = Reservation.find(params[:item_number])

		if status = "Completed"
			reservation.update_attributes status: true
		else
			reservation.destroy
		end

		render nothing: true
	end

	protect_from_forgery except: [:your_trips]
	def your_trips
		@trips = current_user.reservations.where("status = ?", true)
	end

	def your_reservations
		@properties = current_user.properties
	end

	private
		def is_conflict(start_date, end_date)
			property = Property.find(params[:property_id])

			check = property.reservations.where("? < start_date AND end_date < ?", start_date, end_date)
			check.size > 0? true : false
		end

		def reservation_params
			params.require(:reservation).permit(:start_date, :end_date, :price, :total, :property_id)
		end
end
