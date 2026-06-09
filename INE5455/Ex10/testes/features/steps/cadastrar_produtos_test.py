from behave import *
from mercado_leilao import MercadoLeilao

@given('o cadastro do usuario Ernani Cesar foi realizado')
def step_impl(context):
    context.mercado = MercadoLeilao()
    context.mercado.cadastra_usuario('Ernani Cesar', 'UFSC', 'ernani@posgrad.ufsc.br', '055.761.919-00')

@given('o nome do produto {nome}')
def step_impl(context, nome):
    context.nome_produto = nome

@given('a descricao do produto {descricao}')
def step_impl(context, descricao):
    context.descricao_produto = descricao

@given('e o lance {lance}')
def step_impl(context, lance):
    context.lance_minimo = int(lance)

@given('e o cpf do leiloador {cpf}')
def step_impl(context, cpf):
    context.cpf_leiloador = cpf

@given('sofa amarelo ja foi cadastrado')
def step_impl(context):
    context.mercado.cadastra_produto('sofa', 'amarelo', 100, '055.761.919-00', 9999)

@when('cadastrar o produto')
def step_impl(context):
    try:
        context.mercado.cadastra_produto(context.nome_produto, context.descricao_produto,
            context.lance_minimo, context.cpf_leiloador, 9999)
        context.msg = None
    except Exception as e:
        context.msg = e.__str__()

@then('o sistema cadastra com sucesso')
def step_impl(context):
    assert context.mercado.possui_produto() == True

@then('o sistema mostra a mensagem {mensagem}')
def step_impl(context, mensagem):
    assert mensagem == context.msg
