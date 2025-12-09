import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nortus/src/presentation/blocs/user/user_bloc.dart';
import 'package:nortus/src/presentation/blocs/user/user_event.dart';
import 'package:nortus/src/presentation/blocs/user/user_state.dart';
import 'package:nortus/src/presentation/pages/user/widgets/build_update_dropdown.dart';
import 'package:nortus/src/presentation/pages/user/widgets/build_update_text_field.dart';
import 'package:nortus/src/presentation/themes/app_colors.dart';

class UpdateUserPage extends StatefulWidget {
  const UpdateUserPage({super.key});

  @override
  State<UpdateUserPage> createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _complementController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _neighborhoodController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();

  String? _selectedLanguage;
  String? _selectedDateFormat;
  String? _selectedTimezone;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {

          if (state.status == UserStatus.loading) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }
    
          return SafeArea(
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
                    _buildUpdateForm(size, state),
                  
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: size.height * 0.07,
                            child: ElevatedButton(
                              onPressed: () {
                                context.pop();
                              },
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
                              child: Text(
                                'Cancelar',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: SizedBox(
                            height: size.height * 0.07,
                            child: ElevatedButton(
                              onPressed: () => _onSaveUser(),
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: AppColors.secondary,
                                foregroundColor: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: Text(
                                'Salvar',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
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
          );
        }
      ),
    );
  }

  void _onSaveUser() {
    final currentUser = context.read<UserBloc>().state.user;

    final updatedUser = currentUser!.copyWith(
      name: _valueToSave(_nameController, currentUser.name),
      email: _valueToSave(_emailController, currentUser.email),
      language: _selectedLanguage,
      dateFormat: _selectedDateFormat,
      timezone: _selectedTimezone,
      address: currentUser.address.copyWith(
        zipCode: _valueToSave(_zipCodeController, currentUser.address.zipCode),
        country: _valueToSave(_countryController, currentUser.address.country),
        street: _valueToSave(_streetController, currentUser.address.street),
        number: _valueToSave(_numberController, currentUser.address.number),
        complement: _valueToSave(_complementController, currentUser.address.complement),
        neighborhood: _valueToSave(_neighborhoodController, currentUser.address.neighborhood),
        city: _valueToSave(_cityController, currentUser.address.city),
        state: _valueToSave(_stateController, currentUser.address.state),
      ),
    );

    context.read<UserBloc>().add(UpdateUserEvent(updatedUser: updatedUser));
    context.pop();
  }

  String _valueToSave(
    TextEditingController controller, 
    String oldValue,
  ) {
    return controller.text.isNotEmpty ? controller.text : oldValue;
  }

  Widget _buildUpdateForm(Size size, UserState state) {
    if (state.user == null) return const SizedBox.shrink();
    final user = state.user!;

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
            options: ['pt-BR', 'en-US', 'es-ES', 'fr-FR'],
            value: _selectedLanguage ?? user.language,
            title: 'Idioma',
            hintText: user.language,
            onChanged: (value) {
              setState(() => _selectedLanguage = value);
            },
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Flexible(
                flex: 2,
                child: BuildUpdateDropdown(
                  options: ['DD/MM/AA', 'AA/MM/DD'],
                  value: _selectedDateFormat ?? user.dateFormat,
                  title: 'Formatação de data',
                  hintText: user.dateFormat,
                  onChanged: (value) {
                    setState(() => _selectedDateFormat = value);
                  },
                ),
              ),
              SizedBox(width: 16),
              Flexible(
                flex: 3,
                child: BuildUpdateDropdown(
                  options: ['America/Sao_Paulo', 'America/Mexico', 'America/Buenos_Aires'],
                  value: _selectedTimezone ?? user.timezone,
                  title: 'Fuso horário',
                  hintText: user.timezone,
                  onChanged: (value) {
                    setState(() => _selectedTimezone = value);
                  },
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
            controller: _nameController,
            hintText: user.name,
          ),
          SizedBox(height: 20),
          BuildUpdateTextField(
            controller: _emailController,
            hintText: user.email,
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
                  controller: _zipCodeController,
                  hintText: user.address.zipCode,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: BuildUpdateTextField(
                  controller: _countryController,
                  hintText: user.address.country,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          BuildUpdateTextField(
            controller: _streetController,
            hintText: user.address.street,
          ),
          SizedBox(height: 16),
          BuildUpdateTextField(
            controller: _complementController,
            hintText: user.address.complement,
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: BuildUpdateTextField(
                  controller: _numberController,
                  hintText: user.address.number,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: BuildUpdateTextField(
                  controller: _neighborhoodController,
                  hintText: user.address.neighborhood,
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
                  controller: _cityController,
                  hintText: user.address.city,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                flex: 1,
                child: BuildUpdateTextField(
                  controller: _stateController,
                  hintText: user.address.state,
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