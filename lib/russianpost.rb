require 'savon'

class RussianPost
  SOAP_API = 'http://voh.russianpost.ru:8080/niips-operationhistory-web/OperationHistory?wsdl'


  def initialize(tracking_number, options = {})
    @tracking_number = tracking_number
  end

  def get_history
    api_request[:operation_history_data][:history_record]
  end

  private
  
  def api_request
    client = Savon.client wsdl: SOAP_API, log_level: :debug
    client.call(:get_operation_history, xml: build_xml).to_hash
  end

  def build_xml
<<-XML
    <env:Envelope xmlns:env="http://schemas.xmlsoap.org/soap/envelope/">
       <env:Header/>
       <env:Body xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
           <OperationHistoryRequest xmlns="http://russianpost.org/operationhistory/data">
               <Barcode>#{@tracking_number}</Barcode>
               <MessageType>0</MessageType>
           </OperationHistoryRequest>
       </env:Body>
    </env:Envelope>
XML
  end
end