require 'json'
require_relative 'rally-tools.rb'

blob = %q!
[ { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-sdvi", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "dci-uat-onramp-transcode-us-east-1", "createdAt": null, "endpointUrl": null, "implicitAssetAssociation": false, "kmsKeyId": "", "mediaFileExtList": [], "metadataFileExtList": [], "name": "Transcode", "prefix": null, "updatedAt": null }, "id": 41, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/41/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/41" }, "relationships": { "mediaWorkflowRule": { "data": null }, "metadataWorkflowRule": { "data": null }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": null, "awsRoleId": null, "bucketName": "sdvi-rekognition-temp", "createdAt": 1518200843082, "endpointUrl": null, "implicitAssetAssociation": true, "kmsKeyId": null, "mediaFileExtList": [], "metadataFileExtList": [], "name": "SDVI Rekognition Temp", "prefix": null, "updatedAt": 1518460083970 }, "id": 43, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/43/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/43" }, "relationships": { "mediaWorkflowRule": { "data": { "id": "326", "type": "workflowRules" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/workflowRules/326" } }, "metadataWorkflowRule": { "data": { "id": "326", "type": "workflowRules" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/workflowRules/326" } }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-iam-SDVIRole-2PUNQW-ExternalAccountRole-WBN6BMYJAD4U", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "discovery.com.uat.onramp.usukopdeliv.us-east-1", "createdAt": null, "endpointUrl": null, "implicitAssetAssociation": false, "kmsKeyId": null, "mediaFileExtList": [], "metadataFileExtList": [], "name": "LMC On Prem", "prefix": null, "updatedAt": 1520450322538 }, "id": 16, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/16/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/16" }, "relationships": { "mediaWorkflowRule": { "data": null }, "metadataWorkflowRule": { "data": null }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-iam-SDVIRole-2PUNQW-ExternalAccountRole-WBN6BMYJAD4U", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "dci-uat-onramp-usknoxopdeliv-us-east-1", "createdAt": 1524609923176, "endpointUrl": null, "implicitAssetAssociation": false, "kmsKeyId": "", "mediaFileExtList": [], "metadataFileExtList": [], "name": "DKNOX On Prem", "prefix": null, "updatedAt": 1524609923176 }, "id": 44, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/44/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/44" }, "relationships": { "mediaWorkflowRule": { "data": null }, "metadataWorkflowRule": { "data": null }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-iam-SDVIRole-2PUNQW-ExternalAccountRole-WBN6BMYJAD4U", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "dci-uat-onramp-uknoxcopsupply-us-east-1", "createdAt": 1524610027851, "endpointUrl": null, "implicitAssetAssociation": false, "kmsKeyId": "", "mediaFileExtList": [], "metadataFileExtList": [], "name": "DKNOX Internal Upload", "prefix": null, "updatedAt": 1524610027851 }, "id": 45, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/45/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/45" }, "relationships": { "mediaWorkflowRule": { "data": null }, "metadataWorkflowRule": { "data": null }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-iam-SDVIRole-2PUNQW-ExternalAccountRole-WBN6BMYJAD4U", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "discovery.com.uat.onramp.producerportal.us-east-1", "createdAt": 1525199696902, "endpointUrl": null, "implicitAssetAssociation": false, "kmsKeyId": "", "mediaFileExtList": [], "metadataFileExtList": [], "name": "Producer's Portal TBMD", "prefix": "tbmd/", "updatedAt": 1525199696902 }, "id": 46, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/46/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/46" }, "relationships": { "mediaWorkflowRule": { "data": null }, "metadataWorkflowRule": { "data": null }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-iam-SDVIRole-2PUNQW-ExternalAccountRole-WBN6BMYJAD4U", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "dci-uat-onramp-usknoxopdeliv-us-east-1", "createdAt": 1527273625303, "endpointUrl": null, "implicitAssetAssociation": false, "kmsKeyId": "", "mediaFileExtList": [], "metadataFileExtList": [], "name": "DKNOX On Prem QC Proxy", "prefix": "QCProxy/", "updatedAt": 1527273625303 }, "id": 48, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/48/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/48" }, "relationships": { "mediaWorkflowRule": { "data": null }, "metadataWorkflowRule": { "data": null }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-iam-SDVIRole-2PUNQW-ExternalAccountRole-WBN6BMYJAD4U", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "discovery.com.uat.onramp.archive.us-east-1", "createdAt": null, "endpointUrl": null, "implicitAssetAssociation": false, "kmsKeyId": null, "mediaFileExtList": [], "metadataFileExtList": [], "name": "Archive", "prefix": null, "updatedAt": 1528737164607 }, "id": 17, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/17/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/17" }, "relationships": { "mediaWorkflowRule": { "data": null }, "metadataWorkflowRule": { "data": null }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-iam-SDVIRole-2PUNQW-ExternalAccountRole-WBN6BMYJAD4U", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "discovery.com.uat.onramp.producerportal.us-east-1", "createdAt": null, "endpointUrl": null, "implicitAssetAssociation": true, "kmsKeyId": null, "mediaFileExtList": [ ".mov", ".mxf", ".gxf", ".wav", ".zip" ], "metadataFileExtList": [], "name": "Producers Portal", "prefix": null, "updatedAt": 1530288273381 }, "id": 10, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/10/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/10" }, "relationships": { "mediaWorkflowRule": { "data": { "id": "226", "type": "workflowRules" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/workflowRules/226" } }, "metadataWorkflowRule": { "data": { "id": "226", "type": "workflowRules" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/workflowRules/226" } }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-iam-SDVIRole-2PUNQW-ExternalAccountRole-WBN6BMYJAD4U", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "discovery.com.uat.onramp.filesniffrejct.us-east-1", "createdAt": null, "endpointUrl": null, "implicitAssetAssociation": false, "kmsKeyId": null, "mediaFileExtList": [], "metadataFileExtList": [], "name": "File Sniff Rejections", "prefix": null, "updatedAt": null }, "id": 12, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/12/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/12" }, "relationships": { "mediaWorkflowRule": { "data": null }, "metadataWorkflowRule": { "data": null }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-iam-SDVIRole-2PUNQW-ExternalAccountRole-WBN6BMYJAD4U", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "discovery.com.uat.onramp.usdctcopdeliv.us-east-1", "createdAt": null, "endpointUrl": null, "implicitAssetAssociation": false, "kmsKeyId": null, "mediaFileExtList": [], "metadataFileExtList": [], "name": "DCTC On Prem QC Proxy", "prefix": "QCProxy/", "updatedAt": null }, "id": 19, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/19/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/19" }, "relationships": { "mediaWorkflowRule": { "data": null }, "metadataWorkflowRule": { "data": null }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-iam-SDVIRole-2PUNQW-ExternalAccountRole-WBN6BMYJAD4U", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "discovery.com.uat.onramp.auat1.us-east-1", "createdAt": null, "endpointUrl": null, "implicitAssetAssociation": false, "kmsKeyId": null, "mediaFileExtList": [], "metadataFileExtList": [], "name": "AUAT Source", "prefix": null, "updatedAt": null }, "id": 23, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/23/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/23" }, "relationships": { "mediaWorkflowRule": { "data": null }, "metadataWorkflowRule": { "data": null }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-iam-SDVIRole-2PUNQW-ExternalAccountRole-WBN6BMYJAD4U", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "discovery.com.uat.onramp.metrics.us-east-1", "createdAt": null, "endpointUrl": null, "implicitAssetAssociation": false, "kmsKeyId": null, "mediaFileExtList": [], "metadataFileExtList": [], "name": "Metrics", "prefix": null, "updatedAt": null }, "id": 26, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/26/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/26" }, "relationships": { "mediaWorkflowRule": { "data": null }, "metadataWorkflowRule": { "data": null }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-iam-SDVIRole-2PUNQW-ExternalAccountRole-WBN6BMYJAD4U", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "discovery.com.uat.onramp.producerportal.us-east-1", "createdAt": null, "endpointUrl": null, "implicitAssetAssociation": false, "kmsKeyId": null, "mediaFileExtList": [ ".mov", ".mxf", ".gxf", ".wav", ".zip" ], "metadataFileExtList": [], "name": "Producers Portal Auto QC Reports", "prefix": "AutoQC/", "updatedAt": null }, "id": 29, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/29/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/29" }, "relationships": { "mediaWorkflowRule": { "data": null }, "metadataWorkflowRule": { "data": null }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-iam-SDVIRole-2PUNQW-ExternalAccountRole-WBN6BMYJAD4U", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "discovery.com.uat.onramp.auat2.us-east-1", "createdAt": null, "endpointUrl": null, "implicitAssetAssociation": false, "kmsKeyId": null, "mediaFileExtList": [], "metadataFileExtList": [], "name": "AUAT Delivery", "prefix": null, "updatedAt": null }, "id": 24, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/24/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/24" }, "relationships": { "mediaWorkflowRule": { "data": null }, "metadataWorkflowRule": { "data": null }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-iam-SDVIRole-2PUNQW-ExternalAccountRole-WBN6BMYJAD4U", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "discovery.com.uat.onramp.usdctcopdeliv.us-east-1", "createdAt": null, "endpointUrl": null, "implicitAssetAssociation": false, "kmsKeyId": null, "mediaFileExtList": [], "metadataFileExtList": [], "name": "DCTC On Prem", "prefix": null, "updatedAt": null }, "id": 13, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/13/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/13" }, "relationships": { "mediaWorkflowRule": { "data": null }, "metadataWorkflowRule": { "data": null }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-iam-SDVIRole-2PUNQW-ExternalAccountRole-WBN6BMYJAD4U", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "discovery.com.uat.onramp.usdnapopdeliv.us-east-1", "createdAt": null, "endpointUrl": null, "implicitAssetAssociation": false, "kmsKeyId": null, "mediaFileExtList": [], "metadataFileExtList": [], "name": "DNAP On Prem", "prefix": null, "updatedAt": null }, "id": 14, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/14/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/14" }, "relationships": { "mediaWorkflowRule": { "data": null }, "metadataWorkflowRule": { "data": null }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-iam-SDVIRole-2PUNQW-ExternalAccountRole-WBN6BMYJAD4U", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "discovery.com.uat.onramp.ext-delivery.us-east-1", "createdAt": null, "endpointUrl": null, "implicitAssetAssociation": false, "kmsKeyId": null, "mediaFileExtList": [], "metadataFileExtList": [], "name": "External", "prefix": null, "updatedAt": null }, "id": 11, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/11/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/11" }, "relationships": { "mediaWorkflowRule": { "data": null }, "metadataWorkflowRule": { "data": null }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-iam-SDVIRole-2PUNQW-ExternalAccountRole-WBN6BMYJAD4U", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "discovery.com.uat.onramp.usitalydeliv.us-east-1", "createdAt": null, "endpointUrl": null, "implicitAssetAssociation": false, "kmsKeyId": null, "mediaFileExtList": [], "metadataFileExtList": [], "name": "Italy Delivery", "prefix": null, "updatedAt": null }, "id": 25, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/25/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/25" }, "relationships": { "mediaWorkflowRule": { "data": null }, "metadataWorkflowRule": { "data": null }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-iam-SDVIRole-2PUNQW-ExternalAccountRole-WBN6BMYJAD4U", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "discovery.com.uat.onramp.usukopdeliv.us-east-1", "createdAt": null, "endpointUrl": null, "implicitAssetAssociation": false, "kmsKeyId": null, "mediaFileExtList": [], "metadataFileExtList": [], "name": "LMC On Prem QC Proxy", "prefix": "QCProxy/", "updatedAt": null }, "id": 22, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/22/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/22" }, "relationships": { "mediaWorkflowRule": { "data": null }, "metadataWorkflowRule": { "data": null }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-iam-SDVIRole-2PUNQW-ExternalAccountRole-WBN6BMYJAD4U", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "discovery.com.uat.onramp.usmiamiopdeliv.us-east-1", "createdAt": null, "endpointUrl": null, "implicitAssetAssociation": false, "kmsKeyId": null, "mediaFileExtList": [], "metadataFileExtList": [], "name": "Miami On Prem", "prefix": null, "updatedAt": null }, "id": 15, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/15/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/15" }, "relationships": { "mediaWorkflowRule": { "data": null }, "metadataWorkflowRule": { "data": null }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-iam-SDVIRole-2PUNQW-ExternalAccountRole-WBN6BMYJAD4U", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "discovery.com.uat.onramp.usownopdeliv.us-east-1", "createdAt": null, "endpointUrl": null, "implicitAssetAssociation": false, "kmsKeyId": null, "mediaFileExtList": [], "metadataFileExtList": [], "name": "OWN On Prem", "prefix": null, "updatedAt": null }, "id": 27, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/27/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/27" }, "relationships": { "mediaWorkflowRule": { "data": null }, "metadataWorkflowRule": { "data": null }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-iam-SDVIRole-2PUNQW-ExternalAccountRole-WBN6BMYJAD4U", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "discovery.com.uat.onramp.usmiamiopdeliv.us-east-1", "createdAt": null, "endpointUrl": null, "implicitAssetAssociation": false, "kmsKeyId": null, "mediaFileExtList": [], "metadataFileExtList": [], "name": "Miami On Prem QC Proxy", "prefix": "QCProxy/", "updatedAt": null }, "id": 21, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/21/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/21" }, "relationships": { "mediaWorkflowRule": { "data": null }, "metadataWorkflowRule": { "data": null }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-iam-SDVIRole-2PUNQW-ExternalAccountRole-WBN6BMYJAD4U", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "discovery.com.uat.onramp.usownopdeliv.us-east-1", "createdAt": null, "endpointUrl": null, "implicitAssetAssociation": false, "kmsKeyId": null, "mediaFileExtList": [], "metadataFileExtList": [], "name": "OWN On Prem OWNLA", "prefix": "OWNLA/", "updatedAt": null }, "id": 30, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/30/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/30" }, "relationships": { "mediaWorkflowRule": { "data": null }, "metadataWorkflowRule": { "data": null }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-iam-SDVIRole-2PUNQW-ExternalAccountRole-WBN6BMYJAD4U", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "discovery.com.uat.onramp.usdnapopdeliv.us-east-1", "createdAt": null, "endpointUrl": null, "implicitAssetAssociation": false, "kmsKeyId": null, "mediaFileExtList": [], "metadataFileExtList": [], "name": "DNAP On Prem QC Proxy", "prefix": "QCProxy/", "updatedAt": null }, "id": 20, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/20/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/20" }, "relationships": { "mediaWorkflowRule": { "data": null }, "metadataWorkflowRule": { "data": null }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-iam-SDVIRole-2PUNQW-ExternalAccountRole-WBN6BMYJAD4U", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "discovery.com.uat.onramp.producerportal.us-east-1", "createdAt": null, "endpointUrl": null, "implicitAssetAssociation": true, "kmsKeyId": null, "mediaFileExtList": [ ".mov", ".mxf", ".gxf", ".wav", ".zip" ], "metadataFileExtList": [], "name": "Original Producers Portal", "prefix": "ORIGINAL/", "updatedAt": null }, "id": 28, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/28/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/28" }, "relationships": { "mediaWorkflowRule": { "data": { "id": "144", "type": "workflowRules" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/workflowRules/144" } }, "metadataWorkflowRule": { "data": { "id": "144", "type": "workflowRules" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/workflowRules/144" } }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-iam-SDVIRole-2PUNQW-ExternalAccountRole-WBN6BMYJAD4U", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "discovery.com.uat.onramp.ext-deliv-proc.us-east-1", "createdAt": null, "endpointUrl": null, "implicitAssetAssociation": true, "kmsKeyId": null, "mediaFileExtList": [], "metadataFileExtList": [], "name": "External Inprocess", "prefix": null, "updatedAt": null }, "id": 18, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/18/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/18" }, "relationships": { "mediaWorkflowRule": { "data": { "id": "58", "type": "workflowRules" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/workflowRules/58" } }, "metadataWorkflowRule": { "data": { "id": "58", "type": "workflowRules" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/workflowRules/58" } }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-iam-SDVIRole-2PUNQW-ExternalAccountRole-WBN6BMYJAD4U", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "discovery.com.uat.onramp.usukopdeliv.us-east-1", "createdAt": null, "endpointUrl": null, "implicitAssetAssociation": false, "kmsKeyId": null, "mediaFileExtList": [], "metadataFileExtList": [], "name": "ITALY On Prem", "prefix": "ITALY/", "updatedAt": null }, "id": 32, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/32/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/32" }, "relationships": { "mediaWorkflowRule": { "data": null }, "metadataWorkflowRule": { "data": null }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-iam-SDVIRole-2PUNQW-ExternalAccountRole-WBN6BMYJAD4U", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "discovery.com.uat.onramp.usmiamiopdeliv.us-east-1", "createdAt": null, "endpointUrl": null, "implicitAssetAssociation": false, "kmsKeyId": null, "mediaFileExtList": [], "metadataFileExtList": [], "name": "Miami On Prem (DCTC)", "prefix": "DCTC/", "updatedAt": null }, "id": 31, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/31/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/31" }, "relationships": { "mediaWorkflowRule": { "data": null }, "metadataWorkflowRule": { "data": null }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-sdvi", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "dci-uat-onramp-usukopsupply-us-east-1", "createdAt": null, "endpointUrl": null, "implicitAssetAssociation": false, "kmsKeyId": null, "mediaFileExtList": [], "metadataFileExtList": [], "name": "LMC Internal Upload", "prefix": null, "updatedAt": null }, "id": 35, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/35/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/35" }, "relationships": { "mediaWorkflowRule": { "data": null }, "metadataWorkflowRule": { "data": null }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-sdvi", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "dci-uat-onramp-usdctcopsupply-us-east-1", "createdAt": null, "endpointUrl": null, "implicitAssetAssociation": false, "kmsKeyId": null, "mediaFileExtList": [], "metadataFileExtList": [], "name": "DCTC Internal Upload", "prefix": null, "updatedAt": null }, "id": 36, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/36/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/36" }, "relationships": { "mediaWorkflowRule": { "data": null }, "metadataWorkflowRule": { "data": null }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-sdvi", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "dci-uat-onramp-usmiamiopsupply-us-east-1", "createdAt": null, "endpointUrl": null, "implicitAssetAssociation": false, "kmsKeyId": null, "mediaFileExtList": [], "metadataFileExtList": [], "name": "MIAMI Internal Upload", "prefix": null, "updatedAt": null }, "id": 37, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/37/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/37" }, "relationships": { "mediaWorkflowRule": { "data": null }, "metadataWorkflowRule": { "data": null }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-east-1", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-sdvi", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "dci-uat-onramp-usdnapopsupply-us-east-1", "createdAt": null, "endpointUrl": null, "implicitAssetAssociation": false, "kmsKeyId": null, "mediaFileExtList": [], "metadataFileExtList": [], "name": "DNAP Internal Upload", "prefix": null, "updatedAt": null }, "id": 38, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/38/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/38" }, "relationships": { "mediaWorkflowRule": { "data": null }, "metadataWorkflowRule": { "data": null }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" }, { "attributes": { "awsRegion": "us-west-2", "awsRole": "arn:aws:iam::519409131842:role/uat-onramp-iam-SDVIRole-2PUNQW-ExternalAccountRole-WBN6BMYJAD4U", "awsRoleId": "e69bb5cb-0fcf-4675-b222-af21f9988234", "bucketName": "dci-uat-onramp-hawkeye-us-west-2", "createdAt": null, "endpointUrl": null, "implicitAssetAssociation": false, "kmsKeyId": "", "mediaFileExtList": [], "metadataFileExtList": [], "name": "Hawkeye", "prefix": null, "updatedAt": null }, "id": 39, "links": { "files": "https://discovery-uat.sdvi.com/api/v2/storageLocations/39/files", "self": "https://discovery-uat.sdvi.com/api/v2/s3StorageLocations/39" }, "relationships": { "mediaWorkflowRule": { "data": null }, "metadataWorkflowRule": { "data": null }, "organization": { "data": { "id": "1", "type": "organizations" }, "links": { "self": "https://discovery-uat.sdvi.com/api/v2/organizations/1" } } }, "type": "s3StorageLocations" } ]
!

has = JSON.parse blob
has.each do |data|
  post_data = data["attributes"]
  post_data.delete("createdAt")
  post_data.delete("updatedAt")

  puts "="*30
  puts post_data["bucketName"]
  puts "="*30
  payload = {
    "data" => {
      "attributes" => post_data,
      "type": "s3StorageLocations",
    }
  }

  post_data["bucketName"].sub! "uat", "dev"
  puts JSON.pretty_generate payload
  puts "="*30

  response = $stdin.gets.chomp
  next if response != "y"

  begin
    RallyTools.make_api_request("/s3StorageLocations", :DEV, payload: payload)
  rescue RuntimeError => e
    p e
  end
end