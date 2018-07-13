class UsuarioMailer < ApplicationMailer

  def bienvenidos_email
    @usuario = params[:usuario]
    @url = 'http://example.com/login'

    attachments['imagen.png'] = File.read('../blog/app/to/MangekyouSharingan.png', mode: "rb")
    mail(to: @usuario.email, subject: 'Bienvenido')
  end

end
