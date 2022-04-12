defmodule WeatherXmlParser do
  def parse(xml_string) do
    xml_string
    |> XmlNode.from_string()
    |> XmlNode.first('/current_observation')
    |> format_as_internal_representation()
  end

  @attributes_to_fetch [:location, :weather, :temp_c]

  defp format_as_internal_representation(xml) do
    Enum.map(@attributes_to_fetch, &fetch_attribute_from_xml(&1, xml))
  end

  defp fetch_attribute_from_xml(attribute, xml) do
    {attribute, parse_element(attribute, xml)}
  end

  defp parse_element(attribute, xml) do
    xml
    |> XmlNode.first(attribute)
    |> XmlNode.text()
  end
end
