FROM debian:bookworm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    wget \
    unzip \
    ca-certificates \
    gnupg \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js (useful for some Azure tools)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
RUN apt-get install -y nodejs

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install Bicep
RUN apt-get update && apt-get install -y libicu72 \
    && rm -rf /var/lib/apt/lists/*

# Make sure ~/.azure/bin is in PATH for root
ENV PATH="/root/.azure/bin:${PATH}"

# Install Bicep via Azure CLI
RUN az bicep install

# Install additional useful Azure tools
RUN az extension add --name azure-devops
RUN az extension add --name resource-graph
RUN az extension add --name costmanagement

# # Install Terraform (optional but commonly used with Azure)
# RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
# RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
# RUN apt-get update && apt-get install -y terraform

# # Install kubectl for AKS management
# RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
# RUN chmod +x kubectl && mv kubectl /usr/local/bin/

# Set up working directory
WORKDIR /workspace

# Set default shell
CMD ["/bin/bash"]