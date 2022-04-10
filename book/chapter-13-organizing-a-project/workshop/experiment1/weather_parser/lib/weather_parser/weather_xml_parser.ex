defmodule WeatherXmlParser do
  require Record
  Record.defrecord(:xmlText, Record.extract(:xmlText, from_lib: "xmerl/include/xmerl.hrl"))

  def parse(xml_string) do
    xml_string
    |> parse_xml_structure()
    |> xpath('/current_observation')
    |> format_as_internal_representation()
  end

  defp parse_xml_structure(xml_string) do
    {doc, _} = xml_string |> :binary.bin_to_list() |> :xmerl_scan.string()

    doc
  end

  defp xpath(xml, path) do
    :xmerl_xpath.string(path, xml) |> hd
  end

  @attributes_to_fetch [:location, :weather, :temp_c]

  defp format_as_internal_representation(xml) do
    Enum.map(@attributes_to_fetch, &find_element_and_extract_text(&1, xml))
  end

  defp find_element_and_extract_text(attribute, xml) do
    attribute_charlist = Atom.to_charlist(attribute)

    {
      attribute,
      xml |> xpath(attribute_charlist) |> extract_text_from_element()
    }
  end

  defp extract_text_from_element(xml) do
    {:xmlElement, _, _, _, _, _, _, _, [{:xmlText, _, _, _, text, _}], _, _, _} = xml

    text |> List.to_string()
  end
end
