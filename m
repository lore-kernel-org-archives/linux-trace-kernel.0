Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011038.outbound.protection.outlook.com [40.107.208.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE633074AF;
	Mon, 10 Nov 2025 11:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774491; cv=fail; b=uyQmDBq6Xdf8cNR+uTN+2WjtOa4daqAC6oM0cENsHKObxPHz+9qdFYuMtVcgsTvVDSNBw6bAEituTbuz656ViWsYy+IUl+NFeaIqVQkbNwmXaLHisczAn6912OeXV+z5Y+z1+Labe7q708cH5jT18rPaTeupAdHwamsRId0VCD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774491; c=relaxed/simple;
	bh=uX3aUlbrOk3KSm5IdvECN0mv//sFvyjmFPFXdOeyxFM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qg0ErA0PSkvJHnpjH8WanE+uygZIdXgWT783VcoNZS6BQ/KKWXijcuEpSXvOyPFydbJfhAzgdFyh1xKIpIg5kM5+0dGaaqDiikcSbL8HbQWKhKvtqSB5UAhnoxdescpDN1IUfsPMwM5AwOQXvRMnuw7sXk7J82kYuji6qE7fU8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ih0Jnw1P; arc=fail smtp.client-ip=40.107.208.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ih0Jnw1P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJs+Nr2JRmFUHr1Yu+zQQwke8qyPEXE7ytAa/jZ1gIjNTLiywKABVvJU6bSf6pdnEC3rEY5QuDqugdvv1oNK+5DVhhncbBJHX49thCGYb3D6YDu28Uqhpg2TpMNi497+j3xDCSVCTZdjHVhYO/IQuTRlYdjYdsT3G5bzxqleCdJMxUzDTLbEuiOdzADKoXdZnX9rIh6NfSw7Ye/qEVgb+Oan5l8Z60i5JjB4WvsF5qmokIkT2CpgqntjqXvy1v8cktSjhe5NouD/bVUs3ru2YVzto3PQIkphykcB2XSnyG6hdpdzcOnj39Tuxmjv/PT2UkS6V21kC2oPHeXp0PMYnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dJqsW4oL7zIurwANnFL9gmDdj9ynjRvYH6Tbqbietw=;
 b=mt4btE7YkrDzgUWYAajwbFsvemXv7tjsok91UtvuPJ+iKu7twg0cRIlAv60JOWYPNYGf04E3+4ai/xfsLW3tNfUQA1wsl717ztk+ejpFLq/QagElwxcBucJAl83numsln0nS8FMZJ9I+DBjXe/E5gBbSoN+0HH9uRMyw98R3M93g0Kbegw4r/hg/IUjrIBSWf/YakX2Jce0lrAfoOJhvR1yUBvMlP87iOstN8hM1+hYbGHuDaXiKV7ASlsO/hojgxC0DorDd7L7xtuTnVoBc/mx16iTGf1SFVHRlDd3PgO8H+ym1SDdQ/GBfGnxt+xAjyBjvA6aTbMW7Tpl2cxdjJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dJqsW4oL7zIurwANnFL9gmDdj9ynjRvYH6Tbqbietw=;
 b=ih0Jnw1PrGEAYTzRLdTtCq89HZe5W6okXwa9dZbcpGUXP19fIKKg6IITM8NkohM4w+xV3i3hjXuAG7pb6GSFNKiPkC0qxJsYXf61j983lM4KwwOYcQqCRRp3Rg+5QgUbzhhbLkgldUsbNG90n+9i3VdII3G56k+MHpWv6viJHAU=
Received: from DS7PR03CA0013.namprd03.prod.outlook.com (2603:10b6:5:3b8::18)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 11:34:46 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3b8:cafe::58) by DS7PR03CA0013.outlook.office365.com
 (2603:10b6:5:3b8::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.15 via Frontend Transport; Mon,
 10 Nov 2025 11:34:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 11:34:45 +0000
Received: from kaveri.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 03:34:40 -0800
From: Shivank Garg <shivankg@amd.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
	<baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Steven Rostedt
	<rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, Zach O'Keefe
	<zokeefe@google.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <shivankg@amd.com>
Subject: [PATCH 2/2] mm/khugepaged: return EAGAIN for transient dirty pages in MADV_COLLAPSE
Date: Mon, 10 Nov 2025 11:32:55 +0000
Message-ID: <20251110113254.77822-3-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110113254.77822-1-shivankg@amd.com>
References: <20251110113254.77822-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|CH2PR12MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c7e635-b7ae-4fb6-8dbd-08de204d2638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ahbb49LFFpEfRAzUEx/AOVHlRQuHwOcxeYBCZVIUMNmPGD1dMzmkIGYh0yf8?=
 =?us-ascii?Q?g/1z1TuC2+7I1RzZ3EUOEct9zXaPavD3WvaEWNl7fmoBZ85xiRPTrWel2sa/?=
 =?us-ascii?Q?RaAmLbcafOCA9pfy5IJPUfOGCCstBVhHiU08oYCxn5KwuPsSTDreXOkxCysj?=
 =?us-ascii?Q?7XMjQ/r056t4LnqRXQRxnfw4l2YqajUcy2g+i34FeKyMMHFQvihq/3wYhT5o?=
 =?us-ascii?Q?r02/GSU/xgso+lhJKlOspum7ikL9WWq/2SW6UcOxjFcTf9YwbHcwXb8pA0E2?=
 =?us-ascii?Q?Ty08ENkpKUkWef423HLCDHkXwkIQ87d5cyPNXt+TNO43h55H2vVa7ukgH1jb?=
 =?us-ascii?Q?GDPmkxnGm6PkT6fdUjihu9cvqony6QTE2AjuEqxpZFlbbhkpinfIETPSGWnW?=
 =?us-ascii?Q?KuvqVdLRHxBsuygjRU8wJ/pDtBXwMlq80tjHvHo3lAS3qI3paU8YigyYcE1v?=
 =?us-ascii?Q?INTiJ/V4rhQEb18niGJ43ni6dgQJ/QIDQro87cJF9a2lwgLOQR6WQtv6H6Zs?=
 =?us-ascii?Q?ljVgNtbkOGY7Nt4gaCgql3q9c6fx3cLwa6vreMgwlmRVGqiX6DXga1kGN87b?=
 =?us-ascii?Q?AU4NrRL541WJRlvJCjpVWOpuaqjpcaZxr7oPJQoKSIptzRxwWSSwsn1ryXgE?=
 =?us-ascii?Q?8cHi5IIqHxuM7tNzWx/dAmEBa+S9nCjMAh7Yk8BELqavtHuy9KfAKAuujNOd?=
 =?us-ascii?Q?i60RjpWbVNxRYZHiicAzyJ2lwM2qsrgyt6u37vb12hvt9S9IaMIUkZirhhkT?=
 =?us-ascii?Q?s45f9TllRJ4SnnTo+398BjPJlQPBj843xmqalYc/io0V79qMWCjSU6nkBpXg?=
 =?us-ascii?Q?+USKRCluu5I2NLs+YJQDu99kGMG8G4ZlAwiip6aSVBglKwiD/ad5bBJEdAsF?=
 =?us-ascii?Q?NSfg43winks60HdU2ueH4Adp3vwXusJ+bXH5RdPVWXXOoEdNQdEmUwv4fIBO?=
 =?us-ascii?Q?rj2WEeKlDqOBUHVeT0+BB6YH25hO9NSTUVWC3u6UKCBNGAKE6RAOcZBILWKP?=
 =?us-ascii?Q?XGPrafa79PqoOXhvhjS6IJbFyVzL36fBLSAPtmvd2NV6OSnuVOckJoTmmxIt?=
 =?us-ascii?Q?//SKX5dUDEsx4Y4lX5QBlKDIsK34L3EXJAAfjG1jCVPCSwUQfpHTZYM+Sg9w?=
 =?us-ascii?Q?ypv18d0aL23uk6tzRA2MN7uO9aoHUcQkZ5znYuWAo4VEV5LnCwvpbjWxL878?=
 =?us-ascii?Q?MEMwCycqJsyQdJJiBT+ZmbkAbmsvPDJmms/IbgisOUNOInR9zmhan5C4huZB?=
 =?us-ascii?Q?OC0IadjXUFXCeex1QIzmS2ZmilVF/ce74RooLXjekmkbS1l5fbTNp7XzN7jG?=
 =?us-ascii?Q?69QxYlx14+a/GVff2j/bWK+u8VN8KUAyek7ePXwkQ7y+GqPo99TKom7nAwVB?=
 =?us-ascii?Q?4ZkgEMrjeQP1OhoaDOTG2odewINRaRorhA98rV8VRPzaKzVg7n/clqxHWLiN?=
 =?us-ascii?Q?aDda6K0GQy03CapOEZODTWCmhbrT7SuS62KGORfl5es9G7n+tcTPR5vTDQiF?=
 =?us-ascii?Q?qhyw8H6Mdp4VOdDNHuIb2pcinbFkMxbF9HYjuYXIznVFlEM7UrHUd1Zliacy?=
 =?us-ascii?Q?ILq5tLXE+MnJUnUomtI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 11:34:45.8194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c7e635-b7ae-4fb6-8dbd-08de204d2638
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085

When MADV_COLLAPSE encounters dirty file-backed pages, it currently
returns -EINVAL, this is misleading as EINVAL suggests invalid arguments,
whereas dirty pages are a transient condition that may resolve on retry.

Introduce SCAN_PAGE_DIRTY and map it to -EAGAIN. For khugepaged, this
is harmless as it will revisit the range after async writeback completes.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 include/trace/events/huge_memory.h | 3 ++-
 mm/khugepaged.c                    | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index dd94d14a2427..9014a9bbe64c 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -38,7 +38,8 @@
 	EM( SCAN_PAGE_HAS_PRIVATE,	"page_has_private")		\
 	EM( SCAN_STORE_FAILED,		"store_failed")			\
 	EM( SCAN_COPY_MC,		"copy_poisoned_page")		\
-	EMe(SCAN_PAGE_FILLED,		"page_filled")
+	EM(SCAN_PAGE_FILLED,		"page_filled")			\
+	EMe(SCAN_PAGE_DIRTY,		"page_dirty")
 
 #undef EM
 #undef EMe
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index d08ed6eb9ce1..7df329c9c87d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -60,6 +60,7 @@ enum scan_result {
 	SCAN_STORE_FAILED,
 	SCAN_COPY_MC,
 	SCAN_PAGE_FILLED,
+	SCAN_PAGE_DIRTY,
 };
 
 #define CREATE_TRACE_POINTS
@@ -1967,7 +1968,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 				 */
 				xas_unlock_irq(&xas);
 				filemap_flush(mapping);
-				result = SCAN_FAIL;
+				result = SCAN_PAGE_DIRTY;
 				goto xa_unlocked;
 			} else if (folio_test_writeback(folio)) {
 				xas_unlock_irq(&xas);
@@ -2747,6 +2748,7 @@ static int madvise_collapse_errno(enum scan_result r)
 	case SCAN_PAGE_LRU:
 	case SCAN_DEL_PAGE_LRU:
 	case SCAN_PAGE_FILLED:
+	case SCAN_PAGE_DIRTY:
 		return -EAGAIN;
 	/*
 	 * Other: Trying again likely not to succeed / error intrinsic to
-- 
2.43.0

