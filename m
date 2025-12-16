Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012021.outbound.protection.outlook.com [52.101.48.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3002313E2C;
	Tue, 16 Dec 2025 11:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765883538; cv=fail; b=aqX4QgoA99WxTZuVfyZqnKuTE8vxDOUHt33PKqjYQn40zVcivywG6FYvVOHklqhh48h3mroL3zfIOt7Pz9ZpBu8Pehalmx0at4U/Ycg4XbVFmaICzGFtKgkA/IEWLlz3UYS85L+s1CeBTnEOGplJsC62qGdMPuFTRmsC4CZKsE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765883538; c=relaxed/simple;
	bh=5tlemhVMzBwSYH/u6n8kFnPF43dpqvQN+j/Twa6pVrw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gxTm44S5e0gMB9OW4A6IhPtIsEz++eXGLsnbTKsh0UJxqVjV/EWBecWU8fnqJiIPw2S/2n1BDsKUNaa0idfsZ2WUL7FKSjcA7z8mDHhwFzBXETABIMpe8++6WJiHTN4QKkexUMQGDSZNpklNz9Nk23f8AkY8wxSXrPfVjcMwgL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gobuy8df; arc=fail smtp.client-ip=52.101.48.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gobuy8df"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wp7t9/tXdF7EMlgm1ycxHiriy/FCN62wpXU14EfiRpr+jmGNe0uGVPb7ZiZdfIrhO8CFPNjlN4e44NsyZ0krXNFrVJGvrkakiShBEkbFH9cKApn4LRaXcN9hAeEwZomjeCvteSs9NZ0tx9KO2fW9CLNmOcV5XbxRzrKOsE9eEt3HFTqRuNdYvvaIxSW0cOH9VUezgVR7pSypELHQdpFTziKYL0AFfiZnqR9NjD0t46P1QTaMy8oOiqWmy8m2PdHucVQt1P4LlWVPF6afbr0WEIAI7mkdaoOe0v7rB/vXHobyIsPtfFhvAhalZBA1TN/NN2uX660hRGJ6IK0jkUU9tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QN6RuV8V+W4sF+c097o3V/jF1N50nb1n6Fo/bIeDCvI=;
 b=jqQKbtmJaVzYKmJYETllgXfZIiuGrNe3fivz+1xS+Ks89rIs9d7/C2mIhr46nGMcYJorPwnuueouysrwBnx4UWOCA8sU8tCp1fy0W/aW51vA/kp/Fnr5C/tusipeP8jMJidmq2oUddZTvNJpIV62Omvrw0kvENMH5ZdOnh55jT/VwbWTOKtkJjZy9rUTbl7But9kwBIDfDCB9ue/WGSZrPWXTpaHkz7U1TP8Phw7MCkhbzqbLHq47KPR5VS+J62JEbL55YQOfRPbRp518wEHm430ZrEfTTGKWgljQ5H6BPXyreW7n17b8LSCr/GOXZcxoFLoEKi43FFhjfJt+oNxwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QN6RuV8V+W4sF+c097o3V/jF1N50nb1n6Fo/bIeDCvI=;
 b=Gobuy8df1NiQ75BsrzVijg2ukZG90ZC9eYochA0foI1ZgIEFGp9zzm8Ez5gq34GXJW7v1H4TCUdi4rt98GY5Y0ht0hB7sRtUWbUtOFzHTU4IW0LhixAB7H0Dwiw+n9ZSB2xqHPWx4cLxpObTKla0BOExBBrYvlpaLL1qPJ8L6yk=
Received: from BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20) by
 DS0PR12MB6533.namprd12.prod.outlook.com (2603:10b6:8:c2::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.13; Tue, 16 Dec 2025 11:12:09 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:94:cafe::b7) by BYAPR01CA0043.outlook.office365.com
 (2603:10b6:a03:94::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 11:12:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 11:12:09 +0000
Received: from kaveri.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 05:12:05 -0600
From: Shivank Garg <shivankg@amd.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
	<baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<shivankg@amd.com>
Subject: [PATCH 0/3] mm/khugepaged: minor cleanups
Date: Tue, 16 Dec 2025 11:11:36 +0000
Message-ID: <20251216111139.95438-2-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|DS0PR12MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: c224c89f-7943-498c-75b8-08de3c93f4ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1MfoURxQEDZjKzCi1AEiXzZE7oaSdsUl7MDTJAJTfJI9wZgbwV6tXd6L730c?=
 =?us-ascii?Q?ea04YeeLVxa0Q23diIeWvDQA7JXyCV0QDFyQSuOwjxReEoir+ML7G00LBd4e?=
 =?us-ascii?Q?K6+JI3wARQCJzPcz7uPuGQK8suec0OD+t7kuo+bCoTWGyNHLntiJxlfHB5Op?=
 =?us-ascii?Q?plbDY/Ywks18ejaFk/IkU2IqDRQ/9ST13CMRmNFkNBff1Fl0BQe3ox+KtMZX?=
 =?us-ascii?Q?KqHGZDpK3yl2vV8JMUNHa8Gp1gG+6KnEjpSwAP4pQ4WsQXfW1Yjkcyb1ZqcK?=
 =?us-ascii?Q?1A3aRu7tWNr1ov4hTdJuXa+sc7RC3rhCx7vo1DeoUgBi41bacpORN+2NlW3e?=
 =?us-ascii?Q?rRqVxUWvorYAZ05oYhUSCiVrP/RUj+3CZdG6elgkIRe+OTRyQMHqx1Iz1QQ+?=
 =?us-ascii?Q?65IGbWHMbu20sOC7KrCmWYcq3YgPjg7vDlPTL95FHns/NrmVABbemmCdVfnD?=
 =?us-ascii?Q?FPYGoTU0esrdLCHKPmOLuTZZIbpu3ca2kY37V9dpcUU2/1rIMmubYHnkjWoZ?=
 =?us-ascii?Q?w8ZVI9lGHxKgpbogdsGy6PHLLWHXvo89Z6jQa8rg7Wk3uPKo9WTkATljtUYf?=
 =?us-ascii?Q?dWXybUhI5pFQgzyt1V23680ULJPSsbOjylk/13b7uqvz0khITEVSFzaZ2oiB?=
 =?us-ascii?Q?l+Knw80cdQoC5KF416lNKVQVWbTVNrlLNl/SispF+HncSt7CJNYl5gogQAeN?=
 =?us-ascii?Q?64Gn8epbJ/3p0SVORYh0oWiCzpMmflqBOCe9KNgXA0DyILNXFFhnIftg4Ttq?=
 =?us-ascii?Q?PxqzGPssgrpMaNA3CCpMSU4Nc+V3dLMDEZ+D7DiJpJi5fWSnPn+ggIrCIBOa?=
 =?us-ascii?Q?SlSg2nf6D/oJr76aZ793+e+QYbdZ4GcD7FxvxK5xVj6Woi08ojZ/cGcgqozm?=
 =?us-ascii?Q?aBECr/Z8OGKmtjU9FSaDG7U0KJKaQ5M/N7EVRqEhNFSAW/E5Dw7Q0ZFTeCl6?=
 =?us-ascii?Q?H/Q4pF3+TJVWc+n6OJBYZG6ftalF2NpGPGNmB+A8SWQTLOrVaJgcL1By0aWP?=
 =?us-ascii?Q?tQvIpRvX200Nr7L3y0ztNR43rRKqGeTFnRH2UF2VO+FMhlerqWwGZ89UDdLS?=
 =?us-ascii?Q?IM5IloQkl3LmaXbSeTY6NaHKe8WZAITHQDakGGN8pvwKZ8tt0LrdeYZiS+cw?=
 =?us-ascii?Q?MDUGeKP4ngaKHknS0/IUoTKuv/BJERjgf8Zq6UruExdnuUNU2P+nDhlOHvi1?=
 =?us-ascii?Q?wZ8yeaEjyIM6nvAZeTgyW8jCaq/jNNN/tPaua+yT9iEqJUa526NXBOTMNKW/?=
 =?us-ascii?Q?tbrfq7/L5+yW7wpPprGknaAWKIJ6RCOcHkPlUq2vqB5EPwrkxNWakU9geuPF?=
 =?us-ascii?Q?ev0fCE7yS4IdhbcWZPg+ZSlk84UlnEem1cyeF7YQazjhbP6fdRKc4D3bxptC?=
 =?us-ascii?Q?tOEn+26E/KVee0OggifN9TZCEyV6WEt2v2PEOOHVdt9KXtrrl8qpu3g5ijqQ?=
 =?us-ascii?Q?FOXhs6c0Fhu/+IrFaoekkxdpC2EQJnM3bLySHukZ+uh2yCDYFHlgCE06qrVG?=
 =?us-ascii?Q?4sXB49HyRV2f/six5zfBGLjSLom8qfInGeQqjd+TvcDmhaSh5DEbGr2Tz4ZL?=
 =?us-ascii?Q?EGiqrSvMcYu0krXH32A=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 11:12:09.4828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c224c89f-7943-498c-75b8-08de3c93f4ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6533

This small series contains minor cleanups in mm/khugepaged and
no functional changes are intended.

Thanks,

Shivank Garg (3):
  mm/khugepaged: remove unnecessary goto 'skip' label
  mm/khugepaged: use enum scan_result for result variables
  mm/khugepaged: make khugepaged_collapse_control static

 mm/khugepaged.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)


base-commit: c642ecda5b136882e518d8303863473c0d21ab2f
-- 
2.43.0

