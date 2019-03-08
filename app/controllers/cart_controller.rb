  class CartController < ApplicationController

  def show
    @cart = current_cart
  end

  def edit
    @cart = current_cart
    @cart.build_address if @cart.address.blank?
  end


  def update
    @cart = current_cart
    if @cart.update_attributes(cart_atrributes)
      @cart.update_attribute(:shipping_cost, @cart.shipping_type.cost)
      redirect_to confirmation_cart_path
    else
      render action: :edit

    end
 end

  def confirmation
  end

  def add_product
    order = current_cart_or_create
    product = Product.find(params[:product_id])

    if item = order.line_items.where(product: product).first
      item.quantity += 1
      item.save
    else
      order.line_items.create(product: product, unit_price: product.price, quantity: 1, item_name: product.name)
    end

    flash[:notice] = "Dodano do koszyka"
    redirect_back(fallback_location: root_path)

  end


  def remove_product
    order = current_cart
    product = Product.find(params[:product_id])
    item = order.line_items.where(product: product).first
    if item
      item.destroy
    end
    flash[:notice] = "Usunięto z koszyka"
    redirect_back(fallback_location: root_path)
  end


  private

  def cart_atrributes
    params.require(:order).permit(
      :shipping_type_id,
      :comment,
      :address_attributes => [
        :first_name,
        :last_name,
        :city,
        :zip_code,
        :street,
        :email
      ]
    )

  end

end
