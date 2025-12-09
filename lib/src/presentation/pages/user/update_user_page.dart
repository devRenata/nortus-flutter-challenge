import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nortus/src/presentation/pages/user/widgets/build_update_dropdown.dart';
import 'package:nortus/src/presentation/pages/user/widgets/build_update_text_field.dart';
import 'package:nortus/src/presentation/themes/app_colors.dart';

class UpdateUserPage extends StatelessWidget {
  const UpdateUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildReturnButton(context),
                _buildHeader(),
                _buildUpdateForm(size),

                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: size.height * 0.07,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: AppColors.white,
                            foregroundColor: AppColors.textBlack,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: const BorderSide(
                                color: AppColors.textBlack,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Text('Cancelar'),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: SizedBox(
                        height: size.height * 0.07,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: AppColors.secondary,
                            foregroundColor: AppColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: Text('Salvar'),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUpdateForm(Size size) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Language, date and time
          Text(
            'Ajustes de Idioma, Fuso Horário e Data',
            style: TextStyle(
              color: AppColors.textBlack,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 30),
          BuildUpdateDropdown(
            options: [
              'Português - BR',
              'Espanhol',
              'Inglês',
            ],
            title: 'Idioma',
            hintText: 'Português - BR',
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Flexible(
                flex: 2,
                child: BuildUpdateDropdown(
                  options: ['portugues', 'espanhol'],
                  title: 'Formatação de data',
                  hintText: 'dd/mm/aa',
                ),
              ),
              SizedBox(width: 16),
              Flexible(
                flex: 3,
                child: BuildUpdateDropdown(
                  options: ['A', 'B'],
                  title: 'Fuso horário',
                  hintText: 'Brasília - DF (GMT-3)',
                ),
              ),
            ],
          ),

          // User information
          SizedBox(height: 30),
          Text(
            'Informações básicas',
            style: TextStyle(
              color: AppColors.textBlack,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Dados pessoais',
            style: TextStyle(
              color: AppColors.textBlack,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          BuildUpdateTextField(
            hintText: 'Pedro Silva',
          ),
          SizedBox(height: 20),
          BuildUpdateTextField(
            hintText: 'pedrosilvas@gmail.com',
          ),

          // Address
          SizedBox(height: 30),
          Text(
            'Endereço',
            style: TextStyle(
              color: AppColors.textBlack,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: BuildUpdateTextField(
                  hintText: '55781-000',
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: BuildUpdateTextField(
                  hintText: 'Brasil',
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          BuildUpdateTextField(
            hintText: 'Avenida São João Domingues Terceiro',
          ),
          SizedBox(height: 16),
          BuildUpdateTextField(
            hintText: 'Casa de número 412, Em frente ao supermercado',
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: BuildUpdateTextField(
                  hintText: '316',
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: BuildUpdateTextField(
                  hintText: 'Osasco',
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: BuildUpdateTextField(
                  hintText: 'São Paulo',
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                flex: 1,
                child: BuildUpdateTextField(
                  hintText: 'SP',
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Configurações de usuário',
          style: TextStyle(
            color: AppColors.textBlack,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }

  Widget _buildReturnButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 30,
      ),
      child: GestureDetector(
        onTap: () => context.pop(),
        child: Row(
          children: [
            Icon(
              Icons.arrow_back_rounded,
              color: AppColors.primary,
            ),
            SizedBox(width: 10),
            Text(
              'Voltar',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}