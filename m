Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010022.outbound.protection.outlook.com [52.101.61.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1611F257AEC;
	Tue, 16 Dec 2025 11:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765883643; cv=fail; b=pl3AWWRVluZTWAWUkCmyQnZ3WxWQoQtysUXZpelFnszGgqT1Y6fiGng1gx3a0v1XSoU1bpg4jSK/i2FQdwgqbZhkbXx/0gzQIi4yHcZdqEKayCPA6/B/8hx3REJiX0pFNI1jQhp/xepCh+g1yESbyrZITPuwyDX1Ws3cGh9rnNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765883643; c=relaxed/simple;
	bh=PrT65p5ANXPdQXfpWnt9Aprce7YHfoHo7U4/fEzvm6k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SfWbxXexyx+wS1y5VhNFK0GirZD7pFFz5RGJh09SC0SrJTLdPN0r/7sWTxpxcFvjkMLXGfjzPgUQLLPWR9QbdOJhG+A1HaiYFOm9i2qrfmNMoyIMIZ32EcEk/PSOmie+J6VHC+gw8CECleucaRVRJIgtnFrcBkZPYaHR7+e0Fc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DpLWYHXW; arc=fail smtp.client-ip=52.101.61.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DpLWYHXW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ub7zHSewrP3SjIKPIlWY8dIt9sjCDEz+Juq7WvYl/8I/EeMJ9TR/IWKEXyESR5I7zYvS5dPipzeZAVesyFsqUrksDUQ1Lrk+zUv69wjCTP4QfmI8c2aMBKLPcpbqCubfWAntRLYjrc18ME/N6FFzZ0X86Nm9SltSkcOjjK0G50Ayvt5i2UA5n7O6hswQL6Wg79aWTG28b+CosFOSduLIuzCwtxay2EFIc7v0oWpaIDgBRNoAXeFmKIPcwfbrKJjyxp3B510z37zK0cBcESXJ+b/Fml2sFsd6YM6ZUgunUJT/t1VDro5ssp+qEMYGaMm6z6W/h5LYJ2s574tmbUmdtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dHan+tf4DxlEM0zQA9TfunRb8Efi/ACTCURVXGAzNA=;
 b=cVRO82+c2E7ByINMRjYsxVn7lo3i4AxdrIGp5S9sdeXiPu6/0nLsSsLknSgF3lTTOa2vHaQJddOUKdL8lYuVstSUCx5POHMDi1Wq3TeUAqtNtX50mvoWnW2pLjzA7WwT1qc5NSat0prfgLaiafmMxVBfwiqXQsiGm31nliEi1/yQQpD/8jDJSZkoCCcr+JLyZqiM+VAon3Qq+iEJZnqtAr4j9nRc4CyfXvVGKglSXbkSjsCLp/TXuc51juQCE1Xnpgv922mBkbTdfaSBqP/oAn1c38PceOhr5jmfHBtXRGtd/FujFeGp9IV9Ffkk02IWM2mIwaDksc7meX0/avq1Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dHan+tf4DxlEM0zQA9TfunRb8Efi/ACTCURVXGAzNA=;
 b=DpLWYHXWylOEei4nDfR9/QK+E+Sj4wHTxtXpra1n8XZNWEF6X5GC9d+8QEhkk3P7dFSXcQ/XTycxIZFXdQvjj6WrVRA+KyfB5tOn9Yvq8o4+k1ynXro3vorBDevEdht8mNwkX/gjQN2joC2d56zao9WY/INdWjtK2EiyVgYCXtI=
Received: from MW3PR05CA0022.namprd05.prod.outlook.com (2603:10b6:303:2b::27)
 by IA4PR12MB9761.namprd12.prod.outlook.com (2603:10b6:208:550::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 11:13:59 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:303:2b:cafe::47) by MW3PR05CA0022.outlook.office365.com
 (2603:10b6:303:2b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 11:13:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 11:13:58 +0000
Received: from kaveri.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 05:13:54 -0600
From: Shivank Garg <shivankg@amd.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
	<baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<shivankg@amd.com>
Subject: [PATCH 3/3] mm/khugepaged: make khugepaged_collapse_control static
Date: Tue, 16 Dec 2025 11:11:42 +0000
Message-ID: <20251216111139.95438-8-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251216111139.95438-2-shivankg@amd.com>
References: <20251216111139.95438-2-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|IA4PR12MB9761:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a63c901-f0b9-4a91-455b-08de3c9435da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sLPll4SIUGsatpwDwNk2YtpAfj7q2ndn8+dm8VjjrYTMY5WMcvly4xx1qM/t?=
 =?us-ascii?Q?HCL8BXL8BEDToZa9joIr/2UJ2psI7qLFxHEz1vD3vH4/5QeyEVEo4uknoTiy?=
 =?us-ascii?Q?Zc7f6v7tkgfff4iiTXyPrEUqLezoi4jQnpt6M0+e7ovEadD9gDdFlXzZVF4r?=
 =?us-ascii?Q?dm3LdGhcTdT8fPIOvw2gwvUWlJoZoPU6shinvgXulgdGkz/TqZVwprRpWVMD?=
 =?us-ascii?Q?AgBbnzbuJuLQHOo6+Z+N7VRgjwsSF1iEbvqGzlI1Zyy8TSU4rhYn4XlrRI6D?=
 =?us-ascii?Q?Dk7AkikNBJ701kv3E1BGnM1UGDiCWgoE0r5BRARJHqJpbsPR/Hlbp5c7OxhF?=
 =?us-ascii?Q?Grbw9BmqwpZCaGR6elhPi4EVLAS8Si1oYrYo9gqsnFu9vOZQc94qZS50J+j2?=
 =?us-ascii?Q?k6TdqZie3Hh9or8lQg0VCX2YuR8kFZzlbO79gSeM/HdjMIchWKeYNTyF7uzP?=
 =?us-ascii?Q?16QfzRQsVwkZr3qk8EAiOGQGdCsIEJLFBIYDx0m8zoDCJTJx05XIBv7Sc5X/?=
 =?us-ascii?Q?tG7oKu1fDqtRXmlEKr2gEGkBDG1gcTU60YO9G/i205t3ItMz2ihtWKXDh+hY?=
 =?us-ascii?Q?ADHxc1+kryYZCVP21+MGDU223JhM0E/0P97gUty+3bDx8ezQsaf9DBqeSziu?=
 =?us-ascii?Q?FoehTv0UPko+Ic9uhnDvt+3MIs6w5+qks5FceeiHBK2qQRip1sBfFHYuiJmh?=
 =?us-ascii?Q?7Iq/W1bvT83dDCI8VlM2b2DD2dywuYh59EuQrKEi956sVRj5prT8CjoIwUXb?=
 =?us-ascii?Q?AAyN6zC1O3lVpw2eSD+bOyCJnjCarvIFJ9Bq9Z10WDOgcW7w8bt2YOAOztnA?=
 =?us-ascii?Q?UHRrcWkQDVV/VDDGX4ab4XoR5IrHqRsC/pDjsYp14uBo+/yNnK/TeqpRS4b9?=
 =?us-ascii?Q?AwsTJHa/eQZB/Alhz+4Vcql6oMvdy1hN0inTZ1sAw6l4/bSRjdNSRJeYaTWK?=
 =?us-ascii?Q?xucKUp6aYzq2dW7OcDBjhmLqgfkVN/h34bTTTUJTvrBTJ80iLNK9EjSzxZIM?=
 =?us-ascii?Q?CPiUoDXW0TEUkstkzqWE7phx0BBSwAUaPLYcuzicVSiltnTZypP8yimXq0Xl?=
 =?us-ascii?Q?wrqjX7sV+r6DT9pcEyQM3Mdmx46ZABbEjhborbo03Yl1xCcuybn78TS3Kp1r?=
 =?us-ascii?Q?0vCR+9X8VmsvvMKMyeEtUJHis6f7T53vg62PIO8kMfW4UPLrJlTNgacuDy0x?=
 =?us-ascii?Q?wydKvkVcXaWOzSpd6T/lHzWifq43iUTlMM7lqHzDMWCyVcTM1zPLP/YbZW0i?=
 =?us-ascii?Q?nzeR+SisMzLN/00Wt+QvSCpRGj26lNyoRDUAo4Eil+6y9PUwkjOdDiEMepbW?=
 =?us-ascii?Q?ENJxrEhdkLtNn2k6zWZATxP3lZm/icWk82dCatO2CMOmOQkYKVCiPUgkK1k6?=
 =?us-ascii?Q?JAaAcJtwWbiNp0/xjseL4XcGC6LsWAaoOoW1aSa4EmrVN1X5tKhWkNHN3Q4k?=
 =?us-ascii?Q?X2VpyiogYE4uinZNSRUTbf267DoFTjmhqxh3nD9HrYV8Url9nqSLBuPrnGfM?=
 =?us-ascii?Q?bCFLWfeBSpxEcFK9/ejd8LD8H+ezvAoe41Ha4Ie18vcf1qfjs0AQJ66loqqi?=
 =?us-ascii?Q?lTQBKeSEUDUpukCrKIw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 11:13:58.8176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a63c901-f0b9-4a91-455b-08de3c9435da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9761

The global variable 'khugepaged_collapse_control' is not used outside of
mm/khugepaged.c. Make it static to limit its scope.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 65b1b778378a..d130357a2d88 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -829,7 +829,7 @@ static void khugepaged_alloc_sleep(void)
 	remove_wait_queue(&khugepaged_wait, &wait);
 }
 
-struct collapse_control khugepaged_collapse_control = {
+static struct collapse_control khugepaged_collapse_control = {
 	.is_khugepaged = true,
 };
 
-- 
2.43.0

