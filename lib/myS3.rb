module MyS3

# Method to convert a codified number to ENV (prod, qa, etc)

  def MyS3.convert(env_number)
    if env_number=="0"
      env_string="qa"
    elsif env_number=="3"
      env_string="prod"
    elsif env_number=="2"
      env_string="preprod"
    elsif env_number=="4"
      env_string="demo"
    elsif env_number=="1"
      env_string="beta"
    elsif env_number=="6"
      env_string="fix"
    elsif env_number=="7"
      env_string="ALL"
    elsif env_number=="8"
     env_string="cint"
    elsif env_number=="5"
     env_string="bench"
    else
     env_string="NOT_DEFINED"
    end
    return env_string
  end
end
