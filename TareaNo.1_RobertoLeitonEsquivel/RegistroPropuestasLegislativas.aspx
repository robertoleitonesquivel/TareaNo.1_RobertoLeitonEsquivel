<%@ Page Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="RegistroPropuestasLegislativas.aspx.cs"
    Inherits="TareaNo._1_RobertoLeitonEsquivel.RegistroPropuestasLegislativas" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="title">
        <div class="row">
            <div class="col-lg-6 mb-3">
                <asp:Label runat="server">Tipo de indetificación</asp:Label>
                <asp:DropDownList runat="server" ID="tyeIdentification" CssClass="form-control">
                    <asp:ListItem Text="--Seleccione--" Value="" />
                    <asp:ListItem Text="Cédula Nacional" Value="1" />
                    <asp:ListItem Text="Residencia" Value="2" />
                </asp:DropDownList>
            </div>
            <div class="col-lg-6 mb-3">
                <asp:Label runat="server">Indetificación</asp:Label>
                <asp:TextBox runat="server" ID="identificacion" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="col-lg-6 mb-3">
                <asp:Label runat="server">Nombre</asp:Label>
                <asp:TextBox runat="server" ID="nombre" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="col-lg-6 mb-3">
                <asp:Label runat="server">Apellidos</asp:Label>
                <asp:TextBox runat="server" ID="apellidos" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="col-lg-6 mb-3">
                <asp:Label runat="server">Teléfono</asp:Label>
                <asp:TextBox runat="server" ID="telefono" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="col-lg-6 mb-3">
                <asp:Label runat="server">Email</asp:Label>
                <asp:TextBox runat="server" ID="email" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="col-lg-6 mb-3">
                <asp:Label runat="server">Provincia</asp:Label>
                <asp:DropDownList runat="server" ID="provincia" CssClass="form-control">
                    <asp:ListItem Text="--Seleccione--" Value="" />
                </asp:DropDownList>
            </div>
            <div class="col-lg-6 mb-3">
                <asp:Label runat="server">Cantón</asp:Label>
                <asp:DropDownList CssClass="form-control" runat="server" ID="canton">
                </asp:DropDownList>
            </div>

            <div class="col-lg-12 mb-3">
                <asp:Label runat="server">Propuesta</asp:Label>
                <asp:TextBox runat="server" ID="propuesta" TextMode="MultiLine" Rows="4" Columns="50" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="col-lg-6 mb-3">
                <asp:Button runat="server" ID="btnRegistrar" CssClass="btn btn-success" Text="Guardar" />
            </div>
             <div class="col-lg-6 mb-3">
                <asp:Button runat="server" ID="btnLimpiar" CssClass="btn btn-danger" Text="Limpiar" />
            </div>
            <div class="hide-alert alert alert-danger mb-3" id="messageError">
            </div>
            <div class="hide-alert-success alert alert-success mb-3" id="messageSucess">
            </div>
        </div>


    </main>

    <script>


        document.addEventListener('DOMContentLoaded', function () {
            document.querySelector('#<%= btnRegistrar.ClientID %>').addEventListener('click', function (e) {
                e.preventDefault();

                if (ValidateFields()) {
                    HideAlert();
                    let data = GetData();
                    Save(data);
                } else {
                    ShowAlert();
                }

            });
        });

        document.addEventListener('DOMContentLoaded', function () {
            document.querySelector('#<%= btnLimpiar.ClientID %>').addEventListener('click', function (e) {
                e.preventDefault();
                Reset();
            });
        });

        document.addEventListener('DOMContentLoaded', function () {
            document.querySelector('#<%= provincia.ClientID %>').addEventListener('change', function (e) {
                e.preventDefault();

                let provinciaId = $('#<%= provincia.ClientID %>').val();

                if (provinciaId !== '') {
                    GetCantones(provinciaId);
                } else {
                    $('#<%= canton.ClientID %>').empty();
                        $('#<%= canton.ClientID %>').append($('<option></option>').val('').text('--Seleccione--'));
                }

            });
        });

        function Save(data) {
            $.ajax({
                url: 'RegistroPropuestasLegislativas.aspx/Save',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ propuestas: data }),
                success: function (res) {
                    SuccessAlert(res.d);
                    Reset();
                },
                error: function (err) {
                    console.log(err)
                }
            });
        }

        function Reset() {
            $('#<%= tyeIdentification.ClientID %>').val('');
            $('#<%= identificacion.ClientID %>').val('');
            $('#<%= nombre.ClientID %>').val('');
            $('#<%= apellidos.ClientID %>').val('');
            $('#<%= telefono.ClientID %>').val('');
            $('#<%= email.ClientID %>').val('');
            $('#<%= provincia.ClientID %>').val('');
            $('#<%= canton.ClientID %>').val('');
            $('#<%= propuesta.ClientID %>').val('');
        }

        function GetCantones(provinciaId) {

            $.ajax({
                url: 'RegistroPropuestasLegislativas.aspx/GetCantones',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                data: JSON.stringify({ IdProvincia: provinciaId }),
                success: function (data) {

                    let cantonDropdown = $('#<%= canton.ClientID %>');
                    cantonDropdown.empty();

                    cantonDropdown.append($('<option></option>').val('').text('--Seleccione--'));

                    $.each(data.d, function (key, value) {

                        cantonDropdown.append($('<option></option>').val(value.Value).text(value.Text));
                    });


                },
                error: function (err) {
                    console.log(err)
                }
            });
        }

        function GetData() {
            return {
                TypeIdentificacion: $('#<%= tyeIdentification.ClientID %>').val(),
                Identificacion: $('#<%= identificacion.ClientID %>').val(),
                Nombre: $('#<%= nombre.ClientID %>').val(),
                Apellidos: $('#<%= apellidos.ClientID %>').val(),
                Telefono: $('#<%= telefono.ClientID %>').val(),
                Email: $('#<%= email.ClientID %>').val(),
                Provincia: $('#<%= provincia.ClientID %>').val(),
                Canton: $('#<%= canton.ClientID %>').val(),
                Propuesta: $('#<%= propuesta.ClientID %>').val(),
            }
        }

        function ValidateFields() {
            let data = GetData();

            if (data.TypeIdentificacion === '' ||
                data.Identificacion === '' ||
                data.Nombre === '' ||
                data.Apellidos === '' ||
                data.Telefono === '' ||
                data.Email === '' ||
                data.Provincia === '' ||
                data.Canton === '' ||
                data.Propuesta === '') {

                $('#messageError').text('Todos los campos son requeridos.');

                return false;
            }

            if (data.TypeIdentificacion === '' ||
                data.Identificacion === '' ||
                data.Nombre === '' ||
                data.Apellidos === '' ||
                data.Telefono === '' ||
                data.Email === '' ||
                data.Provincia === '' ||
                data.Canton === '' ||
                data.Propuesta === '') {

                $('#messageError').text('Todos los campos son requeridos.');

                return false;
            }

            const regexCI = /^\d{9}$/;
            const regexCR = /^\d{7}-\d$/;

            if (data.TypeIdentificacion === '1' && !regexCI.test(data.Identificacion)) {

                $('#messageError').text('Ingrese una cédula nacional válida.');

                return false;
            }

            if (data.TypeIdentificacion === '2' && !regexCR.test(data.Identificacion)) {

                $('#messageError').text('Ingrese una cédula residencia válida.');

                return false;
            }

            return true;
        }

        function HideAlert() {
            $('#messageError').addClass('hide-alert');
        }

        function ShowAlert() {
            $('#messageError').removeClass('hide-alert');
        }


        function SuccessAlert(message) {
            $('#messageSucess').text(message);
            $('#messageSucess').removeClass('hide-alert-success');
            setTimeout(() => {
                $('#messageSucess').addClass('hide-alert-success');
            }, 3000);
        }



    </script>
</asp:Content>
