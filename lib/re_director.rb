require 'roda'
require 'uri'

class ReDirector < Roda
  plugin :unescape_path
  plugin :middleware

  route do |r|
    base       = opts[:contenido]
    categories = %w(educación inmigración salud finanzas trabajo impuestos noticias farmasep)

    # / -> #{contenido}
    r.root { r.redirect base } if opts[:mode] == :independent

    # /education -> #{contenido}/education
    categories.each do |category|
      r.on %r(#{Regexp.escape(category)})i do
        r.is do
          r.redirect "#{base}/#{URI.escape(category)}"
        end
      end
    end

    # /preguntas                        -> #{contenido}/preguntas
    # /preguntas/salud                  -> #{contenido}/preguntas/salud
    # /articulos/inmigracion            -> #{contenido}/inmigracion
    # /articulos/education/article-slug -> #{contenido}/education/article-slug
    %w(articulos preguntas ofertas).each do |section|
      r.on section do
        r.is do
          r.redirect "#{base}/preguntas" if section == 'preguntas'
        end
        categories.each do |category|
          cat = URI.escape(category)
          r.on %r(#{Regexp.escape(category)})i do
            r.is String do |slug|
              r.redirect "#{base}/#{section}/#{cat}/#{slug}"
            end
            r.is do
              r.redirect section == 'articulos' ?  "#{base}/#{cat}" : "#{base}/#{section}/#{cat}"
            end
          end
        end
      end
    end

    # The rest of the requests
    if opts[:mode] == :independent
      r.is String do
        r.redirect opts[:sep]
      end
    end
  end
end
