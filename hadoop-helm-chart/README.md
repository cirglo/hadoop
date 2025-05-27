# Hadoop Helm Chart

This Helm chart deploys Hadoop HDFS and YARN resources on a Kubernetes cluster. It provides a scalable and manageable way to run Hadoop services in a cloud-native environment.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.x
- Access to a Kubernetes cluster

## Installation

To install the chart, use the following command:

```bash
helm install <release-name> ./hadoop-helm-chart
```

Replace `<release-name>` with your desired name for the release.

## Configuration

You can customize the deployment by modifying the `values.yaml` file. This file contains default configuration values for HDFS and YARN.

## Components

This chart currently deploys the following components:

- **HDFS**
  - NameNode
  - DataNode
- **YARN**
  - ResourceManager
  - NodeManager

## Future Enhancements

In the future, this chart will support additional Hadoop projects such as Hive, Oozie, and HBase.

## Uninstallation

To uninstall the chart, use the following command:

```bash
helm uninstall <release-name>
```

Replace `<release-name>` with the name of your release.

## License

This project is licensed under the MIT License. See the LICENSE file for details.