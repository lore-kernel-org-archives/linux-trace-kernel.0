Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8F42253EF;
	Sun, 18 Jan 2026 19:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768763977; cv=fail; b=mX5YRbl4MBsJwgQtG04gWNdw7HOJMI7B/2Xl2Dd27J/P4B8dLpMfSE2mkIOiGtlbzs9kDoGV1HJQUrTbEVuYk93AhiwO5d2stw7/CvlIo3NDaBn+P23Z6DkQ8TOjODFFKq6vtBnI1mNfhox5/+/zqv2geMkV26kCDh7jDwh857U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768763977; c=relaxed/simple;
	bh=nJAkWcQEiWApHKhKjQ/k2csQnn3DDXh9SDzndBLN93I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JOd0Kckr5JFj+g8pQc2t/wiqpahLjyE06MSNYhIxf9TB2+4jZroQ2GvQeijA0h+bx0p9kJNLxdCoG+RmD7ZZn2PJgHDEPfzdRh8mYzJ108HE3FfGvaxw6m26itn4yOPMkx2VU9Rhe0mx6iP9j2o8ncwwNJ5gp9P353hiewiMB8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TokEqMU7; arc=fail smtp.client-ip=40.107.209.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TokEqMU7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXVOZWnb7Q0t72WRoTumHJ2KG8BvUidizrH+9zNgTGsiK6mcU8b1XgChRxPD7IeCPjkPUnwRVJK3bwqvNbvIVadJXFU7sPVdU9H92ecTcxWaJ8oWzWPMV/xiXRQyMZuN3vkgELK9qaGUoFj5nKtYG3af4SniLRF8YmpnYEuffoSU4aZj9heS0Y5XXJSC6cMmPUuMo1tgsw2DLtsmwzvVrOx5wrCJk1BC9gHI/VgylRSfVIQNQGzABFFDY3TgC/ir3ByuOXa75IDsmWgFQCD2D5v3n8u+k4/KZ2Di7R/DQTv9B9t9zcq+//QEyiU2kK5z9rzIET95ANjlZJ/IJq1BkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0nMLNLSMZdNBKYvQk1L4gZ/l1WrQJt2MWK9xljjkZo=;
 b=B7B6HAZRQXR64MqhgsW8yxWQg0pEV9Zv2X4s/5dVETOvXJzy6U3RnCP5EnNy4Rt0WwW6CpCgbL84cUJNXhVA99n2ozAcH+X0sSVvGhhOUNAx+342EhqTg3cvUnWeyhuyk0dqN3bnHveYkvmKo7U2TdEs3Vnwj7DJ1WINNC4AjsD0Qft93wDVoOZwpttfrqO3Khf+bt5TzxobBolTS5fuaJzG23wVKcG74HE15p4HVVGbPH7cuklLPGpEVjTNQjBk1DGC5Avc54Rp8dL2SJ0l/cVxeJWNHLxMp7LSwaj3Fu4Yx1i3KMBq8WneGrB8tUf+wU4+sTLc2b/YI8XANUHopA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0nMLNLSMZdNBKYvQk1L4gZ/l1WrQJt2MWK9xljjkZo=;
 b=TokEqMU7XRXK/sH7YNQBdAtLxTjRM+xM0BbxJJuljWSNqqr9WmNvY94Zmr7+j7NZORtYqn27/TB5aZHmoQEnvrLvwGFpxiU20JuEDbz1FyW4BSgt9GVYfBKKRI+N788YtLnLI04KQs5cNJOIS8eL/kHUok2V8qWJJWRpR1BmC8E=
Received: from MN0P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::23)
 by MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Sun, 18 Jan
 2026 19:19:32 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:208:52e:cafe::8) by MN0P220CA0011.outlook.office365.com
 (2603:10b6:208:52e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.11 via Frontend Transport; Sun,
 18 Jan 2026 19:19:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Sun, 18 Jan 2026 19:19:32 +0000
Received: from kaveri.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 18 Jan
 2026 13:19:26 -0600
From: Shivank Garg <shivankg@amd.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
	<baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Masami Hiramatsu
	<mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	<linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Zach O'Keefe <zokeefe@google.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, Stephen Rothwell
	<sfr@canb.auug.org.au>, <shivankg@amd.com>, Branden Moore
	<Branden.Moore@amd.com>
Subject: [PATCH V5 2/2] mm/khugepaged: retry with sync writeback for MADV_COLLAPSE
Date: Sun, 18 Jan 2026 19:09:43 +0000
Message-ID: <20260118190939.8986-7-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118190939.8986-2-shivankg@amd.com>
References: <20260118190939.8986-2-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|MN2PR12MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ad3bdd-c9cf-48f0-bbeb-08de56c68287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1z/N1d5b8HSymvCZTDCx0QZwMETUjfEjES1zrgj+f+87goM3ElYivKmUG1c+?=
 =?us-ascii?Q?opiCilFA+MP3glcj5iXfCNABQ/2fH+LY49GPCZg5SUgahJYBcVsgTy3VK/kM?=
 =?us-ascii?Q?stFWGM79UNZkmqK2KlS30/7MMSQfE0N9Q5bGLElJRY9OhhkfYUqz4IqeymrS?=
 =?us-ascii?Q?hzbzfILpt16HxCAh5RmWFcGbg2dEAGrhEkDZUdbbJ5CdhgnvL8HmIP+OkaPu?=
 =?us-ascii?Q?pqxnwDVagIT5tYqZVVaB6iYx3DQzPVg0ELHjihpPaAtVyrrExGk4YXeB/w7Y?=
 =?us-ascii?Q?GFg/UgFby7oyS2NhjTYc/SBYs3LowWBWyQ/TLAgiqRB0qauY81MiIyXZCwIu?=
 =?us-ascii?Q?CVT4iaV+njocJHMdM7RkUl8RwKCQt0yGZEK5zuV9DEtHWJy5iKt6/434SV57?=
 =?us-ascii?Q?PdYWlIcorFNVA03HSpZvlJi2rtW2sj4CNi2f3hTTTExoUn991DE9rlQ29BE7?=
 =?us-ascii?Q?bdFp5rfQuiwfwOCf/ObmKNoU2PUkl+pY8LGDoIHA0mI0qB5YHR3G3RbOmbWD?=
 =?us-ascii?Q?dhsAlncHtuT3kXq8mTxUDRRYKLtYYGRyBXiAstsZw3e1BwzfInpnkoH2sWPF?=
 =?us-ascii?Q?b/7mRQ5riXDMfpQkJk30Cr3+p5Ie6K98eTbBy1Vn9wTzOLB0eYBl3EgsMG7e?=
 =?us-ascii?Q?BXSKIFSKRdx0NvH9hCGU9it2X4y32KmwDh2VKp1MCFE1rOijoFRIeydh3CYQ?=
 =?us-ascii?Q?3L3VUJZ8JCdaCMC9BooL1ZYBvWbVnXUn68Cgd3r0oMYJpmwdpB2npwGs+hx4?=
 =?us-ascii?Q?I9FsPjNQ77GnUxsiE2DFZQ+MZSXVzSP+57xs+ItA0vK3Rxj532V+TZfJ242J?=
 =?us-ascii?Q?hVTgFlKvfwblTdilBBix58dTCtUvMzGLHmMAnjPHpHfRXkbiBd2EBHvRYuKv?=
 =?us-ascii?Q?QyQPUkfaSx8c5S5iVb8/Ngq//7BSPRLRc6hJAgcGVtr7sBKPA46HNwDX07aU?=
 =?us-ascii?Q?h5+klMu3OrIEOauClAU4mdcqWE3I0n/buuoOEmxih/oi9Bx0jdkvWkgf0dOj?=
 =?us-ascii?Q?jLprq6MsKS1imPyM3yNvD3FPAx2MtIHBvMAE0t/voTRGYG8IsfqcOrGMVEG7?=
 =?us-ascii?Q?KmegzdZC6xnbVBcaYcTXICEpt3Y8hUV4eVI/yMsPgMWrweOJ5z+v+HckZva1?=
 =?us-ascii?Q?bJ6WRM45NjqOb9ZjUsn6wwvXBH5SV9xW46zr5B/ioWoziN9qXFUq5+TBa7Le?=
 =?us-ascii?Q?kdpV8iouVkSjoX8tKPWd+YKEV8RlaXtbFpC8Ob3QlPRgGLPxXjKyyPehng2H?=
 =?us-ascii?Q?MgQ0nHZUwLpFuH0JK3FDZQUOh6fquuRogM/4Z10igxx9DD56DiJPZhE1yp8+?=
 =?us-ascii?Q?i+iZJ4bpMi8tb5AqSpXFIjyI5ws1XNNmvRMBfVBvFFEINvBCX5eRS0df9BAa?=
 =?us-ascii?Q?UAXWW2aF136kKSA+claIwyAtr52x7W/Ei32KKGUP3ZIN6Y2msctfRiWWzPtL?=
 =?us-ascii?Q?l6pXsRzEkV5rI3Qlxv7ejzgvCB6B9iKWYBexSdXZym8UdSKVR4ZMxzSvyhXS?=
 =?us-ascii?Q?hSX1Y7NXy3Bybdgw5OslX5isgiSnGHExkvcP6547uk7jxe47vlZ9q9D8plsb?=
 =?us-ascii?Q?vALPbkBKZo8/2xmInMQcAthdPNAVcKYJy5Blm200mfD6CPFV8YDCWj6owhYv?=
 =?us-ascii?Q?aKJGytKYNEsqg1oPGUcnsco=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 19:19:32.6210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ad3bdd-c9cf-48f0-bbeb-08de56c68287
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358

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
 mm/khugepaged.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 219dfa2e523c..16582bdcb6ff 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -22,6 +22,7 @@
 #include <linux/dax.h>
 #include <linux/ksm.h>
 #include <linux/pgalloc.h>
+#include <linux/backing-dev.h>
 
 #include <asm/tlb.h>
 #include "internal.h"
@@ -2788,7 +2789,9 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
 
 	for (addr = hstart; addr < hend; addr += HPAGE_PMD_SIZE) {
 		int result = SCAN_FAIL;
+		bool triggered_wb = false;
 
+retry:
 		if (!mmap_locked) {
 			cond_resched();
 			mmap_read_lock(mm);
@@ -2809,8 +2812,20 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
 
 			mmap_read_unlock(mm);
 			mmap_locked = false;
+			*lock_dropped = true;
 			result = hpage_collapse_scan_file(mm, addr, file, pgoff,
 							  cc);
+
+			if (result == SCAN_PAGE_DIRTY_OR_WRITEBACK && !triggered_wb &&
+			    mapping_can_writeback(file->f_mapping)) {
+				loff_t lstart = (loff_t)pgoff << PAGE_SHIFT;
+				loff_t lend = lstart + HPAGE_PMD_SIZE - 1;
+
+				filemap_write_and_wait_range(file->f_mapping, lstart, lend);
+				triggered_wb = true;
+				fput(file);
+				goto retry;
+			}
 			fput(file);
 		} else {
 			result = hpage_collapse_scan_pmd(mm, vma, addr,
-- 
2.43.0

