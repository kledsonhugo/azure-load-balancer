# staticsite-lb-azure

Este repositório gerencia a infraestrutura de uma aplicação estática no Azure utilizando Terraform. A configuração atual inclui os seguintes recursos:

## Recursos Azure Gerenciados

- **Resource Group**: Um grupo de recursos chamado `rg-appstaticsitelb` localizado na região `eastus2`.
- **Virtual Network (VNet)**: Uma rede virtual chamada `vnet` com o espaço de endereçamento `10.0.0.0/16`.
- **Subnets**: Uma sub-rede chamada `subnet` com o prefixo de endereço `10.0.1.0/24`.
- **Network Security Group (NSG)**: Um NSG configurado para permitir tráfego HTTP (porta 80) e SSH (porta 22).
- **Public IPs**: Endereços IP públicos para duas máquinas virtuais (`vm01` e `vm02`).
- **Network Interfaces (NICs)**: Interfaces de rede associadas às máquinas virtuais.
- **Availability Set**: Um conjunto de disponibilidade para as máquinas virtuais.
- **Virtual Machines (VMs)**: Duas máquinas virtuais (`vm01` e `vm02`) baseadas no Ubuntu 24.04 LTS, configuradas com um script de inicialização para instalar pacotes e implantar uma aplicação PHP.

## Como Contribuir

1. **Clone o Repositório**:
   
   ```bash
   git clone https://github.com/kledsonhugo/app-staticsite-lb-azure.git
   cd app-staticsite-lb-azure
   ```

2. **Configure o Ambiente**:

   Certifique-se de ter o Terraform instalado na versão especificada no pipeline (1.11.3). Versões posteriores podem ser compatíveis, mas não foram testadas e não são garantidas.
   Configure as credenciais do Azure como variáveis de ambiente:

   ```bash
   export ARM_CLIENT_ID=<seu-client-id>
   export ARM_CLIENT_SECRET=<seu-client-secret>
   export ARM_SUBSCRIPTION_ID=<seu-subscription-id>
   export ARM_TENANT_ID=<seu-tenant-id>
   ```

3. **Teste as Alterações**:

   Execute os comandos abaixo para validar as alterações:

   ```bash
   terraform -chdir=./terraform/azure init
   terraform -chdir=./terraform/azure validate
   terraform -chdir=./terraform/azure plan
   ```

4. **Submeta um Pull Request**:

   Crie um branch para suas alterações:

   ```bash
   git checkout -b feature/sua-melhoria
   ```

## Melhorias Futuras

- Implementar um Load Balancer para distribuir o tráfego entre as máquinas virtuais. Um Load Balancer ajuda a distribuir o tráfego de rede de forma equilibrada entre várias máquinas virtuais, aumentando a disponibilidade e a resiliência da aplicação. Consulte a [documentação oficial do Azure Load Balancer](https://learn.microsoft.com/azure/load-balancer/load-balancer-overview) para mais informações sobre como configurá-lo.
- Configurar outputs no Terraform para expor informações úteis, como o endereço IP público das VMs.
- Adicionar testes automatizados para validar a infraestrutura.

Contribuições são bem-vindas! Siga as instruções acima para colaborar.

## Colaborações

- Este projeto é aberto a contribuições de todos. Se você deseja colaborar, siga as instruções na seção "Como Contribuir" acima.
- Agradecemos todas as contribuições, desde melhorias na documentação até a implementação de novos recursos.