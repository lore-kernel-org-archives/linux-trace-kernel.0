Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E751E0083;
	Mon, 10 Nov 2025 11:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774430; cv=fail; b=jAb2fNh8OvY7JbJ/hk5VZcIcx/EV0zdIvQUAA5TRELnplsOHB9plzMII80JbqaOLw+7ShODCV77hwB5EwZ7Lo8QAc8OMauxT32hA8ZTjMH0TCg7eOfLs4WOA4d3rRJE0g+fKfB5aOuoJ7Sqe7GlMk2sFk4h/tF8775DyeRkw7jE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774430; c=relaxed/simple;
	bh=1XY1pDtjxMYB1Mp02DAv1qYLZ48wFC3WzryHtqdQjUE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bmisU9vRx6gNcdzKuNGsg3SG7dXCowLW//gYAaodNwTHFFxFM6H4gXFdq7nGgs6ZNf5XWlfwGpgmT7uIP1R6Q/DCGMhOHWnjoB4eJwQIoEdAQ3lJY1gV2gxt9k5XuaugLwruvrxVdALM9as54I42V/d5l1l2IHJdPNKrQTZScIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SHLSqNUz; arc=fail smtp.client-ip=52.101.53.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SHLSqNUz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZ+dzPa0fdcQfzlxPHKi0NzsBDRfdOSauRdV9MB8VEaPqkxbZQsLEG9BcRH3I0ouYNNUEhIClllnrCLF0xbeJNG1ccT9eMW7YyuJPHDkmm2FfZrZn5oJ39WfXzMczH2qnPAQm1euaN9rP+eDQOT4yMhwvP5AkuEKedCCQT2e9OETiMvZvrV3MhDijsPb2RIFArYvZ0qRilzY6IOHrY5t5DiOXt5Kx13M5PCaHPpAZsn8FdfrQaSEbZfuN3GyTXvasO6Va2CqMg3nZwipXu+3AQrXBxdHVxEP0oVRh3YxGE34FV8+7EXAfFMR5Kraf/VBiG23VX4Ab1CHsAWK9Bz3mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5w/ANerXOQHdNYV2b4/3czO7wHX1+QlP5USmGpuqec=;
 b=XZPQxF8T8iedS0VM9RTsJyAvHUTl0L4jd4lKfiY7M7EOC+YIAdoA93jKS7ztbKXXPcwx2AIO87Tk6ReapnLpnMNusJ1KnrvQ2VNl+qd9HqSbLsCX0wWa+zj6jqsaInOnk0/km9AgN0+nJAq/BcPzlMph9di66wQ2dVMXxsrEsJZLDVsVpuvxPRMj4hAS8oCl5VnI59nFAlUi+W4NgK6O0ivkWXMtLcB1HbN9b78/52JaxgmvRnUfHw1/hSLZfUCLzqyKoxH8ZURpkewtvL96Sup44AzWMzpmkOTTayicL5GFmH0WMoR+syjsygsOfE3y7bMZxIxMD8+dEPMzadc5sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5w/ANerXOQHdNYV2b4/3czO7wHX1+QlP5USmGpuqec=;
 b=SHLSqNUzgliyhDjbJvMr7cPbGsjrY8g7ny+zl/WISDHL8Uo2Xl+uxLP0FhlxMSzRVsVCZoFQBzmbwKnUqhtxs32zuytbilBOt1IHzXWYaxD0ziGy1SMNqp3WJTYkt+oOiUITksPShtJqFbSHQqxNNjxtl1+W3N0tBac2kGz9pwk=
Received: from DS7PR05CA0077.namprd05.prod.outlook.com (2603:10b6:8:57::17) by
 CH1PR12MB9694.namprd12.prod.outlook.com (2603:10b6:610:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 11:33:41 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::28) by DS7PR05CA0077.outlook.office365.com
 (2603:10b6:8:57::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Mon,
 10 Nov 2025 11:33:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 11:33:41 +0000
Received: from kaveri.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 03:33:36 -0800
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
	<linux-trace-kernel@vger.kernel.org>, <shivankg@amd.com>, Branden Moore
	<Branden.Moore@amd.com>
Subject: [PATCH 1/2] mm/khugepaged: do synchronous writeback for MADV_COLLAPSE
Date: Mon, 10 Nov 2025 11:32:53 +0000
Message-ID: <20251110113254.77822-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|CH1PR12MB9694:EE_
X-MS-Office365-Filtering-Correlation-Id: d5ab4f9c-8ce5-4f92-f5cb-08de204cfffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?neWzWBjfL8GJbIKWGr1RmKTM5ELFFTwtsGF5MEkO7QKz/K6NA3UMllZ8zKXf?=
 =?us-ascii?Q?UZ64RXRkDUf9CCmKC6mpfTfkYFOzLn8sv3aJnb4+wcH5lk87SO5F1+8WVnMO?=
 =?us-ascii?Q?ZHLavHiKwYZl4NocDuSko9xrpbVF+s1BHpO+vlkDxilRAmgnSsPQqKa7Ix5o?=
 =?us-ascii?Q?H7ENYnA8bNPsH6cA47zfnnlgdzkRV0NAeS4qFw/9SRTFEOpUQxjQTAsyiqj4?=
 =?us-ascii?Q?LyJprAOkG36oEa8RC3IbBqwtxTps0X70hl98I+2aKOOlW97ayAAux3jItnQf?=
 =?us-ascii?Q?SOt8E4dVgwdoslfqYbtqxGAUa7Vlf2VP615RWK8WdVONhOcg/bGTE04R9tv8?=
 =?us-ascii?Q?FBbnwYd9rU9fWyxIE23M1BgS1I85XInHwaIyvF/pvkaVfQPCpps67h2m7T9O?=
 =?us-ascii?Q?+2tSkuI7xPkzWUr3MwW5nHP4Bjv++kpVyE0GWm1Db6pnNy98gpYgXhWAYjgc?=
 =?us-ascii?Q?KL/ZVRhGhf8dXSonBKOII/5eljXoON9JNzcAKhrT8VeNRGuyPGSr6iFvU0R3?=
 =?us-ascii?Q?KTo3U4Balxik4j0cgTawe/hq/T9yGnttGL7S5l23ZgPsbsX/tTLTQovpzmTy?=
 =?us-ascii?Q?hi9YBtDJ7KaHjijkgjctCEUoG47ZMM97/TM5IOgFv23QPNbcQ8fbxHDy0Pkf?=
 =?us-ascii?Q?B4QEtOhkarnKElicJ12Qh/rwW/GFMIZQAvgdp5tASQlBbkp4GuEqWmo8qBCt?=
 =?us-ascii?Q?virc+jCzmeKWhIPKIs0mQZM3oLs2Vbge8W3HWitRXTAbyliM+oa+TPVvDDX5?=
 =?us-ascii?Q?h0/AhRReojANLEFGc6f8DHfhXdaUNGmIoLc66Q1dGQhvIt+dKEj4cJwFvDF6?=
 =?us-ascii?Q?NgA+CoRQSSM6rReZJX+/lYZnotmG3+Tt3kh82WRN4RUjj+w9tayK28Q01u0W?=
 =?us-ascii?Q?BXvXeshe4KP7viIxeU9j/mXvtoWrt5SlSYC40uQAsuDTwIguug0jfjihsZVH?=
 =?us-ascii?Q?ku5Ko8PPWpEWXHQ1azxIw72Mk4c0foJ40WoeTGGLREVfpE0bNeiVFsCAZ0JM?=
 =?us-ascii?Q?sAnMeuLzVaLkaT/VRYI0BYt30LsOfphocBI92+LOrldtePi/PjS2fvmGnoAp?=
 =?us-ascii?Q?KP3qkzL7Ocfr46txs1HEujYpMJZdN778R4eaObbdNejzRNMV4MsJmeWhhaVf?=
 =?us-ascii?Q?e5kuoPAIi9ewGPSJW10zTrYcRdjiuEmpqU8jcq+edpweiP9VJcxuGieXDBLl?=
 =?us-ascii?Q?KXNJjb7oUaeDTuNTZC0XiehBd/yKzNO+qn07HcqNGjbOy02J/5O2OiL6e3i1?=
 =?us-ascii?Q?zvI65rfX5YgtRiekL4kxrGN/4q9mUKBomYdGUOCZBb/5ApRNVccf77ZHnxzs?=
 =?us-ascii?Q?qb5pGilWZmR12vtg0KvueWdzxfn0SPyjUYmhMfkkcA7MYjn7WBmYrhGq9YVg?=
 =?us-ascii?Q?XVCSDRAj8gCVu36UK3GYKMG/Yz+drONbXpVJKvwusGI7zje+5AOnbKRtWnZC?=
 =?us-ascii?Q?yTArrugp8WKsZT1P/8VwkAWvjlkQT2GfzzFo8Q4KND/CKVKW0dZNwq6eiGRT?=
 =?us-ascii?Q?/BN6fF0qlBqhANt1JtxmSSdoN+uoXFeaKBrZ8T+X6W6lPtQi+dBC8MkUjmxS?=
 =?us-ascii?Q?8OiknDySiHS/O2yrDNkY+NrebiylT9FwTysAf/Un?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 11:33:41.6773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ab4f9c-8ce5-4f92-f5cb-08de204cfffc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9694

When MADV_COLLAPSE is called on file-backed mappings (e.g., executable
text sections), the pages may still be dirty from recent writes. The
current code triggers an async flush via filemap_flush() and returns
SCAN_FAIL, requiring userspace to retry the operation.

This is problematic for userspace that wants to collapse text pages into
THPs to reduce ITLB pressure. The first madvise() call always fails with
EINVAL, and only subsequent calls succeed after writeback completes.

For direct MADV_COLLAPSE calls (!cc->is_khugepaged), perform a synchronous
writeback using filemap_write_and_wait_range() before scanning the folios.
This ensures that folios are clean on the first attempt.

Reported-by: Branden Moore <Branden.Moore@amd.com>
Closes: https://lore.kernel.org/all/4e26fe5e-7374-467c-a333-9dd48f85d7cc@amd.com
Fixes: 34488399fa08 ("mm/madvise: add file and shmem support to MADV_COLLAPSE")
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
Applies cleanly on:
6.18-rc5
mm-stable:e9a6fb0bc


 mm/khugepaged.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index abe54f0043c7..d08ed6eb9ce1 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -21,6 +21,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/dax.h>
 #include <linux/ksm.h>
+#include <linux/backing-dev.h>
 
 #include <asm/tlb.h>
 #include <asm/pgalloc.h>
@@ -1845,6 +1846,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	struct page *dst;
 	struct folio *folio, *tmp, *new_folio;
 	pgoff_t index = 0, end = start + HPAGE_PMD_NR;
+	loff_t range_start, range_end;
 	LIST_HEAD(pagelist);
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
 	int nr_none = 0, result = SCAN_SUCCEED;
@@ -1853,6 +1855,21 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
 	VM_BUG_ON(start & (HPAGE_PMD_NR - 1));
 
+	/*
+	 * For MADV_COLLAPSE on regular files, do a synchronous writeback
+	 * to ensure dirty folios are flushed before we attempt collapse.
+	 * This is a best-effort approach to avoid failing on the first
+	 * attempt when freshly-written executable text is still dirty.
+	 */
+	if (!is_shmem && cc && !cc->is_khugepaged && mapping_can_writeback(mapping)) {
+		range_start = (loff_t)start << PAGE_SHIFT;
+		range_end = ((loff_t)end << PAGE_SHIFT) - 1;
+		if (filemap_write_and_wait_range(mapping, range_start, range_end)) {
+			result = SCAN_FAIL;
+			goto out;
+		}
+	}
+
 	result = alloc_charge_folio(&new_folio, mm, cc);
 	if (result != SCAN_SUCCEED)
 		goto out;

base-commit: e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c
-- 
2.43.0

