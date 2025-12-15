Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011050.outbound.protection.outlook.com [52.101.52.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C9C331235;
	Mon, 15 Dec 2025 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765788445; cv=fail; b=scAufjujZ9Vc7Ch2+rlwWJWwJpTSkvMKGLuRz9V+Gtre/YypABlGQBvnVYt852+uz8/taITv4d6RPYA1tVimdYnyL0kyGRlkzTbOcwxHIJ0UVWPmGtBeVyhuP5iV6YERt+bugXaac8XA5UB9ZSa65spJzBK5OO6g+ddwdv2mdE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765788445; c=relaxed/simple;
	bh=W6VxbWTNrZoxoQYjFEOtTYsum6WtwqEhC4Zz5C/nJ9A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C1ANvSA+4XVljb9ZZJH1B1HJiN6i8OqbO+lfrAg6PUNt81IfBbIWVS80RnTxeQKfBP3M/AMOirATeOYVrg8yT9K91k03+v97pY/gQcQESokjAkZE41v64T9DVnRXShYgVP+yHEZCVd9afi3C18G5Kqc3ga15mHHXFzGy9fYbigM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TariI9ek; arc=fail smtp.client-ip=52.101.52.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TariI9ek"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXNneNRz6RVZiNTEMYF+NnljNQuWLVFq8qVGWWpy2HKGF6sBy0Gl3d+zZbSao3WKPeOflz3oQQ9FsRulVHbPyUeGKUp6C96Ktt1jLGzeWNfT1f3AWEqL42bKc91OEcxApUPWjVW+5IrAtzv+8FMzatXoXZrh0sdh7tQZjQX+VcBfTYPeCTzOxWMer5V/XjowrALE4YfzP5/DPV84Ma8uLmlmUyqXzZl0WAW0EZ83gQlha2Jnm9thNR7cY2hpU03seE45pd3avCUdK+xa3UGbag5h9TBnCa1uuO9Ych2/QEwm2SDOeHL/xnM62g2eBp1r/yahEg/Gokb5bO7chM+OBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvJvyZpKzWgSapZy/mDwanRSyVEqfh2pWtEoiEGZwq0=;
 b=Rp0WSLaGJ9D8zlMQOVUeoorVDcXxkotx75L6udK2m3SP/zfwYa4FL0/2bndxwaDKeCaQXJEa6dCvISu5WhJzj/UbQZ5xO5SP3l4WLoAthBCI1FGXnB78HMslXC8O78Rhk4TcXGBH4reLleqvaapgPp9NGupuq7F8KPlhUfjTDrivht096VvSlE8CtCd6TZR1Di5CT5FB65wqiBGW4HGrwsUlDjKaCwd5hJCLjqSOeYXR//Hq+K7L3kyAuAvyJEzdeY/V/Fu3yJT8rDZxBnzUujdqO8fJxZuw0gatG5mx01p486YVerMr33GqxYPG7q6tGDKZav5GYiGaeOotvv7fDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvJvyZpKzWgSapZy/mDwanRSyVEqfh2pWtEoiEGZwq0=;
 b=TariI9ek7TY7QmcUAyRB8nX2shavZRoWwrIgq7AfMUuoyzH5nnnxE1ooyen7f2dLRr4LjT6DxYpj0mNelOSrT7vQ6kBTWViEzInhWjcDE4bb9bc/W2yH0u8ItLHCzXt4j+ykItTUa3KXJqcq1FFM6BdYgqR03hTjqaptR79TxpA=
Received: from BY5PR04CA0018.namprd04.prod.outlook.com (2603:10b6:a03:1d0::28)
 by SN7PR12MB7955.namprd12.prod.outlook.com (2603:10b6:806:34d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 08:47:19 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::8) by BY5PR04CA0018.outlook.office365.com
 (2603:10b6:a03:1d0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 08:47:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 08:47:18 +0000
Received: from kaveri.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 02:47:13 -0600
From: Shivank Garg <shivankg@amd.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
	<baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Steven Rostedt
	<rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, Zach O'Keefe
	<zokeefe@google.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <shivankg@amd.com>
Subject: [PATCH V4 0/2] mm/khugepaged: fix dirty page handling for MADV_COLLAPSE
Date: Mon, 15 Dec 2025 08:46:15 +0000
Message-ID: <20251215084615.5283-3-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|SN7PR12MB7955:EE_
X-MS-Office365-Filtering-Correlation-Id: 5043660f-133f-4d13-1e20-08de3bb68e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zAK31v2/bD77uuaMHyHqTlBVOy6+fq0vTelV1Jl0x7JNNdJdIGi0AlIkIkAF?=
 =?us-ascii?Q?EcWC/zsTtjaaeoFizDaUpo0Jfwy86R9fN0DpazPB5vgWz33gLavDNO9HYqGP?=
 =?us-ascii?Q?85XyuIufaVbOIj1LlzxZy/zwIjq9kZQg+SO+u0C9qw5e+7lyAEkf4txwDIrw?=
 =?us-ascii?Q?A9IG6fNtbK74m/Y59IzMP+gUrrNLSmkDsfaztaIPfreb4YueQNtssJWqRLdS?=
 =?us-ascii?Q?EjQk8r6gUbDBwzCMBGW+dJ66bouSKtc6P5WvJ4cy+8cRxvZ2dwZ+lhs/90rL?=
 =?us-ascii?Q?BTMfVEWcFx461inaVFcJxr/DbHATgGdmH8xOYiNE5zvAjjypyzFka0nRg9Ks?=
 =?us-ascii?Q?Nbm9Hsx9Nrc9LGPBEf1SDKL4XnAs/Oh+hJMEBdshcxf+GDtFQ+e/bEh9Mj/v?=
 =?us-ascii?Q?IZgSPfTuQp5rgo1jQ6+DQFrhFHUh5/ZOcpzMbfwcMOFXVnk7ybP4ZsL6rufl?=
 =?us-ascii?Q?ZCsCYOO+OeLWgLV/lAGo7V3HE7l4I1SdtPDh5muYSBKJH5WnAvDTCh/9lhm5?=
 =?us-ascii?Q?UAcwjcXh4a3SHEJxYHGGooDJ7uZ11W2+IXfUUYvc/dt6Mei9ztpup5iixyDH?=
 =?us-ascii?Q?dhrxJ8JsokkIxl4DEVmdz+TTYWoVJxVWJIAb0DFFufIGT35OGNAY5RmKX3/Y?=
 =?us-ascii?Q?DbKe9SFHkHVyKA1q8rlXe4W2H0xqwgmoDPibXXxkjan69vvq7xJkE9q1+XMH?=
 =?us-ascii?Q?dhLlD28Fvv8HpJLfBSqDjDCjDJD3dAOxyJNDOvDj4R7F6HOPw87HkZB7VSrz?=
 =?us-ascii?Q?Hl4hquxKGiKE+xq1ELQmYljM1Dec0rUuaWlBXDVqF+hhtYadGQGhg0ob563n?=
 =?us-ascii?Q?YwJWJttGx2+njBe4gubwPfk5nAEIKvktmvCBJA1W6te29KZgaHOj7EELGphu?=
 =?us-ascii?Q?xAw6ah1kVGf42nXLhT/2/oSh7v76ok4m/U3UqaRWxivmi9eS6M+bNJNFK7NO?=
 =?us-ascii?Q?LzDmBsYQiYIP5ewzHC/Emma6NO5asswlUy3r1ye+H0+VNXVmhCDWo7SgWQ2M?=
 =?us-ascii?Q?v/2XEs5rfMNsbluvxtiH6IaROtiRb9bCq7iof63eFsJDIJlRleZlhzGkBSo9?=
 =?us-ascii?Q?zOfzV94quv5UtDv6Pm+6TSuI5z9EmuZDEq3Y/XmVyn+DbHtqczjgX0naT23R?=
 =?us-ascii?Q?MMmjesKOEb6TKZqkNcinF8hF0Kda+9fPU/1mk3f4ZFz9VupiGKeklsamXvrD?=
 =?us-ascii?Q?I0P5ifVqgjWJKZ3g7aAZVYq02p/ft6+z7QPKLetBSDjnbl0NXby9WgOgq0N2?=
 =?us-ascii?Q?bs66L0TOdQg4Z8gWux5k3fTNY7xeWsazu9pO20vFn7W1eNZKsVGdq1JXgLfU?=
 =?us-ascii?Q?2iKvorWQ9Nxk17LJR3wM9aSsX29jJq6qAssUptaoapBDeRlQJ2LBUq1kN5qS?=
 =?us-ascii?Q?SCOy6K8mKDPqw1z9QJrsvIr/VS4uh3oIGMVljdYs1hvmdAxqd+c8t7MJHqe/?=
 =?us-ascii?Q?aPmov7XeLPX3DRK3vB6k/lg+nEAgRgE30X1x2Ed4nl4ve4Z1IYrsekaoioV1?=
 =?us-ascii?Q?PCr4ZM3YGywmiTiFAmLbgzwDqs08LOw0cbvfEqEe68Un4ym0Vbunf6nQy7uH?=
 =?us-ascii?Q?cXjhvOM3MpRLLmDg0pM9JcRs9PkvgHJ4vCtgrWGw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 08:47:18.7586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5043660f-133f-4d13-1e20-08de3bb68e32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7955

MADV_COLLAPSE on file-backed mappings fails with -EINVAL when TEXT pages
are dirty. This affects scenarios like package/container updates or
executing binaries immediately after writing them, etc.

The issue is that collapse_file() triggers async writeback and returns
SCAN_FAIL (maps to -EINVAL), expecting khugepaged to revisit later. But
MADV_COLLAPSE is synchronous and userspace expects immediate success or
a clear retry signal.

Reproduction:
 - Compile or copy 2MB-aligned executable to XFS/ext4 FS
 - Call MADV_COLLAPSE on .text section
 - First call fails with -EINVAL (text pages dirty from copy)
 - Second call succeeds (async writeback completed)

Issue Report:
https://lore.kernel.org/all/4e26fe5e-7374-467c-a333-9dd48f85d7cc@amd.com

Patch applies cleanly on mm-new (https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/?h=mm-new)

Changelog:
V4:
- Rebase on mm-new
- Fix spurious blank line (Lance)

V3:
- https://lore.kernel.org/all/20251201185604.210634-6-shivankg@amd.com
- Reordered patches: Enum definition comes first as the retry logic depends on it
- Renamed SCAN_PAGE_NOT_CLEAN to SCAN_PAGE_DIRTY_OR_WRITEBACK (Dev, Lance, David)
- Changed writeback logic: Only trigger synchronous writeback and retry if the
  initial collapse attempt failed specifically due to dirty/writeback pages,
  rather than blindly flushing all file-backed VMAs (David)
- Added proper file reference counting (get_file/fput) around the unlock window
  to prevent UAF (Lance)

V2:
- https://lore.kernel.org/all/20251120065043.41738-6-shivankg@amd.com
- Move writeback to madvise_collapse() (better abstraction, proper
  mmap_lock handling and does VMA revalidation after I/O) (Lorenzo)
- Rename to SCAN_PAGE_DIRTY to SCAN_PAGE_NOT_CLEAN and extend its use
  for all dirty/writeback folio cases that previously returned incorrect
  results (Dev) 

V1: https://lore.kernel.org/all/20251110113254.77822-1-shivankg@amd.com

Thanks,

Shivank Garg (2):
  mm/khugepaged: map dirty/writeback pages failures to EAGAIN
  mm/khugepaged: retry with sync writeback for MADV_COLLAPSE

 include/trace/events/huge_memory.h |  3 +-
 mm/khugepaged.c                    | 48 ++++++++++++++++++++++++++++--
 2 files changed, 47 insertions(+), 4 deletions(-)


base-commit: d0a24447990a9d8212bfb3a692d59efa74ce9f86
-- 
2.43.0

