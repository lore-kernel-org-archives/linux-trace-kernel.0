Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010030.outbound.protection.outlook.com [52.101.46.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188503328E1;
	Mon, 15 Dec 2025 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765788636; cv=fail; b=jhnklkWPRb/Vu0/Llpv6yNz1QM4J6OFnAJHEIhrQT1GQimGT5Nm6+wyd9/KYt8TAD9kitBvPxdlTU4eYjVQweGwIn1RO12MivYkzgGChwz1UVXWMcDQe5V+0xJ66mF6Fu6E1wS1J10SQPIEdxFWCYFPgoaBQ0IBKe3CPIgVluig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765788636; c=relaxed/simple;
	bh=5HVYJHyaOJ0IHZkbpMwVoCXv/OE0mObEK6E+ouvWHWY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FllIDpXs6MttodiAs1fGj/HEi4u8F5AUOr9/wAiglxTbdT3Fspy3x4vBjRn8XEVxBcMsGwkPHmpTeT6MAwEOr3bakd9wJCdJfcElpn6JuoIsHcN9mNoZ58361ZSfRfDwGuS3xXBtLxVJF4tEdpiH7gU/T8oYRC4GDWyhQPeQolA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EoXkeA0k; arc=fail smtp.client-ip=52.101.46.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EoXkeA0k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSg8NaZTKwyF5QADiVLf4p6p4NwjBfgFRJHcB+Y7fPsThaqn0RPlUA0e880+dxc0BvDj+328qF/Fs0aHRadJi81rr/ric5NA2kgeLzd06VMh7IVOGyZ1bXD2QdjVYBDpLAYOzb9jus4TtMwW3schX0pEcVnmnA0B+ruQ0flay2J6G+M7att9FKSVNHloEsfSeuPRQ13OOc+DUH1NAxs8BG9keVFMRyRlgwEbPGLkctO8EmVmDRmQb22G7tXedTEW06L7Fyj+TcZyGRdFPYYtEmBrIKNA57R5gXfRj30WD0Xyum3proQNPyupbmIL+AsnREXXAcYJMTQ4P61haq/wGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95aXhXK168YJQ3T98bSDL2tnXRBYy0o0eONLNvVAD90=;
 b=qx0wqE8d+WcSTQpxynl/3WW+VA+T5PnxCa0h/1EqwIKabZnQc53OTja+A61slOlLpGoYtjZOJ0AkqSbHJ8QapiJXCtUEb9KaYaX/BgV1GJ330/NHLcCiGYT4Jtvh68mF4dUneZ2B4SK9ArKD36MNWaxMqUxdPinhFN/zbXy6obpsIAIYyUDcsV/07ZgnvkZet/oKhIbC5zTBGSFZSPBaGWyRractNkoj0NVuEL3idu/HNdcC1QFq2ywz9sI7lrKj8uAs1JDj3s62qCd0xVli1UgRFx07+QnCrvThZeTDTN6kDRxoncBjwODLGVqpIv1JKnJqzlrAK4hIpGBOAX16gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95aXhXK168YJQ3T98bSDL2tnXRBYy0o0eONLNvVAD90=;
 b=EoXkeA0kk1vr3A4e/fPhjEtqtmsHjmlbfokY6knN2rmJ+srb9D3M0Nv0sTq4ZHUzGhETJaJOdkkRwLUL6tAoGYWGFUQkFmxh1IL0Qw64DghzPv1pKyaynve5aBFzyhvAlm4yLFSju9ezI69fbR+mAs9zlswx6uQN/8EuOttmYWo=
Received: from BYAPR05CA0088.namprd05.prod.outlook.com (2603:10b6:a03:e0::29)
 by DS0PR12MB999103.namprd12.prod.outlook.com (2603:10b6:8:2fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 08:50:32 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::4f) by BYAPR05CA0088.outlook.office365.com
 (2603:10b6:a03:e0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Mon,
 15 Dec 2025 08:50:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 08:50:32 +0000
Received: from kaveri.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 02:50:26 -0600
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
	<linux-trace-kernel@vger.kernel.org>, <shivankg@amd.com>, Branden Moore
	<Branden.Moore@amd.com>
Subject: [PATCH V4 2/2] mm/khugepaged: retry with sync writeback for MADV_COLLAPSE
Date: Mon, 15 Dec 2025 08:46:19 +0000
Message-ID: <20251215084615.5283-7-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215084615.5283-3-shivankg@amd.com>
References: <20251215084615.5283-3-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|DS0PR12MB999103:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b92a53c-75ee-448a-1db5-08de3bb70168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IXEfMqsK9SY62b7mjGlrIpHLHuY0YlhMULvm1BHtpq8wgy2b8k+oL0ZXdv5P?=
 =?us-ascii?Q?c9lPe2o8S4GVhlfsyZnk+YVo3Uo9ILRONH6LoyiJXup8DFhPPQ+sDgpm3+yt?=
 =?us-ascii?Q?HjUzxsOcH7kNSKfwu0Y07l6BWAdptbr4/OqYiDn5kj8KgFZ+HDgLVDb3ymHa?=
 =?us-ascii?Q?v7/5ETpOad+bNi2n84afC2I6m4icSt+R5GvQA7jozEMkpMUtJgxSO0vHbp0Y?=
 =?us-ascii?Q?G0NSeVrhX+Fu3/ugB/tan8uBb6OCVb1Th5KH16EAZY2u8MKkSKOkUygzy9q4?=
 =?us-ascii?Q?R0ADEXKxRnftEIfqstmU2aJtKjWupEfJ+SGOYtUa2gMU0pDPtDMCwihyBFT2?=
 =?us-ascii?Q?qlMsaiivEhmCtpsPmJTVSR4/2OBtxG6a5DPKeqwmqDE7n5yTDVo3oFFumql1?=
 =?us-ascii?Q?pTLQxd/IZftGA9SaIcNVC5W9dW4+JNbkWE4BOQv7tjXJUS0t+B8r26YX5zrB?=
 =?us-ascii?Q?ONmdbBOYfkOwC9IUlwpvLhrdYnAR8l26xnMt+I3mJ0uqFY/+OvJzNTiQocPH?=
 =?us-ascii?Q?skrXBExVLMeFXJp9wUiUKXzAJ2R4GYm1po7mhUp3CQgSHU10LImioIxPHAOt?=
 =?us-ascii?Q?j8ksXpzbEuPzXhYXuknLUgJsYMskOz24etkAzEc+d9pEKGFo3OcW8P9pCqYT?=
 =?us-ascii?Q?fZAuVB0MnqrfVm03ZwVKvyxc24FOzl3DW4IPuhGYdlLIACm+EXhj9ba7OO9O?=
 =?us-ascii?Q?IrHnYqREi1DhuahJdIcFcKNESeRFp0OjTqCMRJ0IBIL+KRrDIK8vNqB7CG+p?=
 =?us-ascii?Q?2SbrehmhWMfWVjPNFJKD+Fo3giiHbblQjw8GnO8bBuStxymU8BlFbLoSs2Kr?=
 =?us-ascii?Q?NkJWhNYOE8yCnvq3jX509DWhr8TfjNkMO5sPb4i2H6LBtC2jW3a96ARzS0eW?=
 =?us-ascii?Q?4L9qaU3QTh4HLKhJqb9Wl4hPxWvf9UjxbeVywcAuESb9pzFfQMQG/3HzsThF?=
 =?us-ascii?Q?hm9NBW6ARLbVN5Ps/sZ5YsOjwyq+MQYyclXD5XWhygaanfk6Cokr7OisCCBL?=
 =?us-ascii?Q?M6V3DMVfoRwEHnExK2Htx/nogcX2OWbg3kQ3EosG3WcBWAtc4aaZegJtxNYj?=
 =?us-ascii?Q?KJ2PkCCFH+NjJ3U+ewu47U/ldtMmT9UegyXkyB686hBBWYU1fgDg9kQDnk44?=
 =?us-ascii?Q?sBJpN+5rUBEk5cVguvZcvVWL1/PHfzcQYQWUP7/MuRNdz3zgfcf75U7YQtEU?=
 =?us-ascii?Q?X9l4Kd0eM8KM8t3ZHTlJn6vOtBe/gp+zbBysG0SKswgYscCl0eEwOpVUIqWR?=
 =?us-ascii?Q?6sHN++GkelKrOnX922ASELJFpt2z8L5PuSqukjFnwPgz/XY7uFqbvr07gSFN?=
 =?us-ascii?Q?OUl8PBoeDmkCWEIB+AbG3ZcHatkt8CcZQL8Vn6yJrVPYCAIu6XF2DZyqycxF?=
 =?us-ascii?Q?asYxLoUyPc7HGRd6D/QdviF9LoFGdQjeZtDvZn6KTa7wbqRRlpqHw7emulWX?=
 =?us-ascii?Q?8PV+8R2NnRpdepf8MPOG7PWDXCWOf1EP2s2uP1gawkKTvLSRjzorCz79GWK4?=
 =?us-ascii?Q?4E+OWmelh4insfd92EaBAXr2l2Li5BDoJ0nYIlfmTuit8X1+zgsUMRX6RGv8?=
 =?us-ascii?Q?pa9YtYu+UD/tDT6ccp0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 08:50:32.0482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b92a53c-75ee-448a-1db5-08de3bb70168
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999103

When MADV_COLLAPSE is called on file-backed mappings (e.g., executable
text sections), the pages may still be dirty from recent writes.
collapse_file() will trigger async writeback and fail with
SCAN_PAGE_DIRTY_OR_WRITEBACK (-EAGAIN).

MADV_COLLAPSE is a synchronous operation where userspace expects
immediate results. If the collapse fails due to dirty pages, perform
synchronous writeback on the specific range and retry once.

This avoids spurious failures for freshly written executables while
avoiding unnecessary synchronous I/O for mappings that are already clean.

Reported-by: Branden Moore <Branden.Moore@amd.com>
Closes: https://lore.kernel.org/all/4e26fe5e-7374-467c-a333-9dd48f85d7cc@amd.com
Fixes: 34488399fa08 ("mm/madvise: add file and shmem support to MADV_COLLAPSE")
Suggested-by: David Hildenbrand <david@kernel.org>
Tested-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 mm/khugepaged.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 219dfa2e523c..6c8c35d3e0c9 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -22,6 +22,7 @@
 #include <linux/dax.h>
 #include <linux/ksm.h>
 #include <linux/pgalloc.h>
+#include <linux/backing-dev.h>
 
 #include <asm/tlb.h>
 #include "internal.h"
@@ -2787,9 +2788,11 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
 	hend = end & HPAGE_PMD_MASK;
 
 	for (addr = hstart; addr < hend; addr += HPAGE_PMD_SIZE) {
+		bool retried = false;
 		int result = SCAN_FAIL;
 
 		if (!mmap_locked) {
+retry:
 			cond_resched();
 			mmap_read_lock(mm);
 			mmap_locked = true;
@@ -2819,6 +2822,43 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
 		if (!mmap_locked)
 			*lock_dropped = true;
 
+		/*
+		 * If the file-backed VMA has dirty pages, the scan triggers
+		 * async writeback and returns SCAN_PAGE_DIRTY_OR_WRITEBACK.
+		 * Since MADV_COLLAPSE is sync, we force sync writeback and
+		 * retry once.
+		 */
+		if (result == SCAN_PAGE_DIRTY_OR_WRITEBACK && !retried) {
+			/*
+			 * File scan drops the lock. We must re-acquire it to
+			 * safely inspect the VMA and hold the file reference.
+			 */
+			if (!mmap_locked) {
+				cond_resched();
+				mmap_read_lock(mm);
+				mmap_locked = true;
+				result = hugepage_vma_revalidate(mm, addr, false, &vma, cc);
+				if (result != SCAN_SUCCEED)
+					goto handle_result;
+			}
+
+			if (!vma_is_anonymous(vma) && vma->vm_file &&
+			    mapping_can_writeback(vma->vm_file->f_mapping)) {
+				struct file *file = get_file(vma->vm_file);
+				pgoff_t pgoff = linear_page_index(vma, addr);
+				loff_t lstart = (loff_t)pgoff << PAGE_SHIFT;
+				loff_t lend = lstart + HPAGE_PMD_SIZE - 1;
+
+				mmap_read_unlock(mm);
+				mmap_locked = false;
+				*lock_dropped = true;
+				filemap_write_and_wait_range(file->f_mapping, lstart, lend);
+				fput(file);
+				retried = true;
+				goto retry;
+			}
+		}
+
 handle_result:
 		switch (result) {
 		case SCAN_SUCCEED:
-- 
2.43.0

