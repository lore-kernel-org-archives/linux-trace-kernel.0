Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010052.outbound.protection.outlook.com [52.101.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4774D227B94;
	Mon,  1 Dec 2025 19:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764615813; cv=fail; b=r+NRbgfLic9i7WY6b9sgfpEAM6EjaZYGyLCzDKVyWSP+f+98uwWxkmnjqlSje52NDN7Eu9IMCG+DrOLQpkbhwkHAtOCnv2SB1PZpAwU/RDFzr0Vqd4VJHCuGl1Ao6DzPBJYPHXDrLZKT6C6HBJSezGJ3iIqJW/098v2DvzDLq0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764615813; c=relaxed/simple;
	bh=6opJGglt4WoPLMIwCcKfvdF+0BlpZhS49RKHysQ62es=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pAUoivO8jlw6mq5ujy1lYpuRiwCzqaY4Mk+j4ddfSQNL6PHSJQixUzBDqYD3TKdrRT4cQ4xTm3XW6wMqcOh8v4+evSvq3trjfJwFI2HopMfHvw41LzzgsDdQ3S2R0YNyRsX1UbMPR+8IWbJ/V7c1TJlfRjGfBmvyeNgLnTtX6OY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tjoMuj4E; arc=fail smtp.client-ip=52.101.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tjoMuj4E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erc8TbcD2PHsUN4iVDHMSEWojIBlf/h6GLb6Abe1NTm9pa4yMdsQQOBPKYx4fi95kCNoLbTTotBH0ISlugaXOLLTy+4f+pAJOxry4UX7zW2P8rEj7MMryNLSh+2OTg6UUG9jzDAXTvbNMG6WM7JVSMgxQ5J2JFNSr6kfP+Sc/09ZqbF3H/juv8LH9OldfgxN/r12YVmS5628vXEgSHleTy4mhwYAElwLzqRVThGdt/XqbkE4Jp0oIKOPQP0tf7AU8yrjwnAp3EkmtEf0eFIaNtvW6f6CdC8IzxGUzKxX1GFosPdazDVJxY88Xa/H9eFDH0ff1W4zzSR7NEPoCoYFbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHrUmI6Hu3JrofipYLXEZhVviunHimjhthv1xf1htvk=;
 b=bs3M4kb8hokTzsO7fn33TIQRWKkep8RuTM5Cuq3r7J9sBXgI2ewYZP+fFmDvsrm8XzjYYB6wRJT2coViwVAt0Im9PKIyfhxEH50P5p1aWGGkfYhOmBSW9cx60zEg4jJdeTBYpNUkgVsYEvhgjHDs2Ifry0dKCgyXVHtjL9HwMlHkU9lN75mus2iDDYB8RuOauMwfpjhIAqx4u3BcZuSEB2KB7yR0Jt+m2Nw4X71No6Oy95ONG3JKG0ad25nBL4k+aVQg4OdplJiRC9eMmpitAH0nkRFLQNWBtizeSXfrkfl21Z+enn651Uq4mcVbskI+dvuBGJu1eyEFVP52MF7y5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHrUmI6Hu3JrofipYLXEZhVviunHimjhthv1xf1htvk=;
 b=tjoMuj4E4htwG3bM8pXDzgmfCc9VMEel1A26apkClHYk4ELGkSdxXxj9Hsar6fvJXdoniNOJxtYtyiJ5FCtCaYG95SbQx/UlBdsDMTfkzVL8y9XiJ+7zvvEPp3wF8N/sZEq93ymHfn+h6pad+Q+kp8TEO5Oa7enw1WXBpXgAm18=
Received: from DS7PR05CA0096.namprd05.prod.outlook.com (2603:10b6:8:56::28) by
 BN7PPFD3499E3E3.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 19:03:27 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:8:56:cafe::c) by DS7PR05CA0096.outlook.office365.com
 (2603:10b6:8:56::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Mon, 1
 Dec 2025 19:03:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 19:03:26 +0000
Received: from kaveri.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 13:03:18 -0600
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
Subject: [PATCH V3 2/2] mm/khugepaged: retry with sync writeback for MADV_COLLAPSE
Date: Mon, 1 Dec 2025 18:56:11 +0000
Message-ID: <20251201185604.210634-10-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251201185604.210634-6-shivankg@amd.com>
References: <20251201185604.210634-6-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|BN7PPFD3499E3E3:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b8dfb9-0545-4ebc-8463-08de310c4f10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nNYnCBrvYsYY9nPUA8wieq0EwAFQCjGpUQKMaWVlxDUl3yilNhLMI2d1XVEA?=
 =?us-ascii?Q?Yj/TG43x2PgZ0iYwHrdy7G4+oACCDWe0cCVFsA8r00lnF9HZkqJJ7zs6VbIl?=
 =?us-ascii?Q?Q9NOHiIlHDSz8zTUckZlcenskMx0taICGmnYmzTalN3HZFiT8aWNpuIDDocR?=
 =?us-ascii?Q?vU+cuJvaXzUbyz3ZTQqaPh7ChSMnnG3DDLeq3JVztL34tP0uSj/Y6Ig8OyO7?=
 =?us-ascii?Q?kCMVnCTZIqudnUJMwWxNY2ttnXGhUjb/LAcoPHJOqOoKPaDi9fXLd53M2xKv?=
 =?us-ascii?Q?A0EJ8gPt43iY2oxFrKPhaJVBOC7pMZNNhJflqcM8gyIXMIRH7gDdrB2ZFrvg?=
 =?us-ascii?Q?F5F30QRnsw8xJv3YOyx0D2hIEjie+c3hP8mPjs73sHFb7HC7AqZjMdLg/ajl?=
 =?us-ascii?Q?FYiUGE1qNo07GztSWbP7juG3X8fjoh0tjvJ17aTxVqKDIJ7lkFsFjip4q9zp?=
 =?us-ascii?Q?e4qOXIYnbsVPPR86ETqQ/nk7APCKZF0qw/XjDL0Uf6H+kXQFf6jWLUvSDZt9?=
 =?us-ascii?Q?/NRtHunYESo8O+4403YroMBIjV8FSb+y5hOBxVuRkiuDLjsW/6DzeyymdDqS?=
 =?us-ascii?Q?URdjl7LCielm7pMCNEQrLj3SBmzj+OogbuFTJjfaiNe6ZRCsq1ldbam5rsfj?=
 =?us-ascii?Q?PC94xnUTMYgmteLSn5899VNl3pV24Cq8jubXjU7MrNOpoH5XM41LYujsAyxm?=
 =?us-ascii?Q?Z0238o1tUUjCRXlXO2RA7m6sjhFKsZuSzI562lqArZtlSk9GyZVYwbjEDC4j?=
 =?us-ascii?Q?3lVJ3r8H8rbJDFGjSGqVixL1JGAGBqFsHpHfkAUm5SywlvKDQVcwjExxFPII?=
 =?us-ascii?Q?J2xOUx3gQZUrT6MJ/po/Al3fbjoQwsuiLIPFHfOSkNMO/mPz7BKI1t7qCsyQ?=
 =?us-ascii?Q?bz6x0XYBPoZ6RABAdmzTUsrUB/7E72R7TUWzoUtQKmadfQ/r+GEuP2NcSh/3?=
 =?us-ascii?Q?f6Ln2kwbWTw5XJNYTWJKJthx2IbspA+j2yezgaev+U8qqiC/mBZVUCUYfRgD?=
 =?us-ascii?Q?DYc/beukW5MhG7xqVFmYfJeL8j4gEG4tT5Xok7vjqYrlsnwUtircZbWgBV4d?=
 =?us-ascii?Q?/8Zn89pQpWIGmZiEyff1BLEpD8hipBx+lxN/GqSxu+oAmyK0IoIQ5WZrUKoh?=
 =?us-ascii?Q?i3a/gxbB6N1ms/PQOHI0TNO/Vdw9aT7qXmU3hrXNvkusZXcdM2E3KDGJ3J6W?=
 =?us-ascii?Q?bVPew1LBvrXz0+nm+APQDp929a9Ot8/KuuFuGcNai/IHDMJiMw39aHvlN16g?=
 =?us-ascii?Q?qhUvYEn+yZUWxSoPdUJvDpv+L3d56KK1/k2RjJFQMkD2huJAmGxbNaR24Z0+?=
 =?us-ascii?Q?NBuLZ+HiwZeee9iZ1pa7ycgqOtJKXhCCSSvpMLrncGzmu6WQEShSEK+PK424?=
 =?us-ascii?Q?sOOJEsoG4ZHDt4MtoSkxbyVlTnODqMFAU1ahQcxY9n7zo6hkqflXKW8vVLIQ?=
 =?us-ascii?Q?ENwjsP2Cpofu64A6FVANhHku0zBpAYZ3Ft9719rahnJqAbX7fW1KYKh7E8qY?=
 =?us-ascii?Q?bVlxkpN+0Lb3DwfWiPzaUjNfqOQ9P/4MFqqM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 19:03:26.8180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b8dfb9-0545-4ebc-8463-08de310c4f10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFD3499E3E3

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
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 mm/khugepaged.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 219dfa2e523c..7a12e9ef30b4 100644
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
@@ -2819,6 +2822,44 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
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
+
 handle_result:
 		switch (result) {
 		case SCAN_SUCCEED:
-- 
2.43.0

