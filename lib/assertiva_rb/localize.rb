module AssertivaRb
  module Localize
    extend self

    def by_name(str)
      AssertivaRb::Client.fetch(
        product: 'localize',
        http_method: :post,
        params: {
          data_type: 'name',
          data: { nome: str.strip }
        }
      )
    end

    def by_address(str, uf)
      AssertivaRb::Client.fetch(
        product: 'localize',
        http_method: :post,
        params: {
          data_type: 'address',
          data: { endereco: str.strip, uf: uf.downcase.strip }
        }
      )
    end

    def by_cpf_cnpj(doc)
      require 'cpf_cnpj'

      raise DataClassError unless doc.is_a?(String)
      [
        /\D/, # removes anything that is not a number
        /\A[[:space:]]+|[[:space:]]+\z/ # removes start and end blank spaces
      ].each { |regex| doc = doc.gsub(regex, '') }
      raise BlankDataError if doc == ''
      raise InvalidDataError unless CPF.valid?(doc) || CNPJ.valid?(doc)

      doc_name = doc.length == 11 ? 'cpf' : 'cnpj'
      params = {
        data_type: doc_name,
        data: { doc_name => doc }
      }

      AssertivaRb::Client.fetch(
        product: 'localize',
        http_method: :post,
        params: params
      )
    end
  end
end
