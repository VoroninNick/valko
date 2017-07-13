class TestimonialController < ApplicationController

  def list
    @main_testimonial = Testimonial.main_testimonial.first
    @testimonials = Testimonial.list_testimonial
  end

end
