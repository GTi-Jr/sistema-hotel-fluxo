class Admin::EmployeesController < Admin::BaseController
  before_action :set_admin_employee, only: [:show, :edit, :update, :destroy]

  # GET /admin/employees
  # GET /admin/employees.json
  def index
    @admin_employees = Employee.all
  end


  # GET /admin/employees/1
  # GET /admin/employees/1.json
  def show
  end

  # GET /admin/employees/new
  def new
    @admin_employee = Employee.new
  end

  # GET /admin/employees/1/edit
  def edit
  end

  # POST /admin/employees
  # POST /admin/employees.json
  def create
    @admin_employee = Employee.new(admin_employee_params)

    respond_to do |format|
      if @admin_employee.save
        format.html { redirect_to admin_employees_path, notice: 'Funcionário foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @admin_employee }
      else
        format.html { render :new }
        format.json { render json: @admin_employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/employees/1
  # PATCH/PUT /admin/employees/1.json
  def update
    respond_to do |format|
      if @admin_employee.update(admin_employee_params)
        format.html { redirect_to admin_employees_path, notice: 'Funcionário foi editado com sucesso.' }
      else
        format.html { render :edit }
        format.json { render json: @admin_employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/employees/1
  # DELETE /admin/employees/1.json
  def destroy
    @admin_employee.destroy
    respond_to do |format|
      format.html { redirect_to [:admin, @admin_employee], notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_employee
      @admin_employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_employee_params
      params.require(:employee).permit(:name, :email, :password, :code, :sector_id, :department_id)
    end
end
