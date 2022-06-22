
MenuData = {
  apartment_check = {
    {
      title = "Apartment",
      description = "Forclose Apartment",
      key = "judge",
      children = {
          { title = "Yes", action = "np-apartments:handler", key = { forclose = true} },
          { title = "No", action = "np-apartments:handler", key = { forclose = false } },
      }
    }
  }
}
