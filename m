Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF75B1D14F8;
	Sun,  1 Dec 2024 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733067598; cv=fail; b=fPOowkckeCwyODisCB1Mk2njGFNZq4EHUCJlUSGPaJRPNJWTUwVVYfTVmucrsjtyQc+DTsdUdspaU0rHLCrba58yn2A5o8Jz4h7I5S5ZxaoSi7/lBBWAWVSlqbXt37LKQCWnFMhY+XjN6/MO1VwtemGmjAqnpSnXDlZJcHwKOt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733067598; c=relaxed/simple;
	bh=YwcOx3T4/8+NAeC2q7ZMYcYRWS5D9+R0Dl4TsSBTe6Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WBA2Vrg2JvJViw9s7lh5LKZ3rSNxoQ2zFqenll4xPpO7ApU9TvGnSEdaPv/RYnWiYdOBnUah8fWKnUMjQpoQ470V/jffZMnSEEila6y7njLb8w67Qwb/79vY6XGL7iTj3kgib9aQsP6OWhUf9V2cIJmBGpgrrzSQjGZRM80kt+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oqfYKGdo; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oqfYKGdo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gs3A/GjIq+t/gBe+rLFC452vxst1bSaalYMr+nLu76FAWcZcYkzPuPxNzUldfO81J7tBXm+I9G2PHd8F4EthS8TgiHDS3qyy6AhxlKD2oLap+ZWsh9JM2H5mCsCXrhIJ3/JSSwckfwb/up8PriShdmGDh4hCeCFaWA8wojPTWHIcerjhfoYlgREIDz5N0lGRYzRj3qWpQgEGb2kSpYnhG7RlnRle3BN/liHKKPaWFdAuGrjD5JTEIvMt40aSHx7DHpa7Gv5rzEyUtOWRzF7Ss1XkghJ8b/N7GR+FMDdgYN2F11Fap6Txjecf33jJ1yRzxAlyBq5kP0sXTFB6tb0gSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rBTqNeMywA3YqEk7Nh/vZKAp1YDQTBwl5ueiIClenY=;
 b=FJgBb0B0HKeaxKwrumhX8e+x8nMIEC3/zlb+cffXj25sr7/IbOcD15eskBZYoCWGz8ze8e+y0mnPjCNbRg4/3qJEBaMR2+JZd6SIsLKOX4+yxzRsaeTDcEJ2WnOhsXudcR0xqnhjtHawMJCBBK1gbVcH8ojjfFC/C3fgy19jJGwcIUZ1txI/HeXMuKlW8kGX6oTEzt/+YJQs7veCblYX8KE9D/Xb3JP7HIgJiWCL7EogYPansw9eLhxXDZLEXUy8vQO1R+oki2qdI3/hj5oJkoNY8ruFgxtzrVnA+RuYXeu2qiQF3ark+y8zDsAHJJUuFd9Dd9iKfX5RNdqV7tE7YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kvack.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rBTqNeMywA3YqEk7Nh/vZKAp1YDQTBwl5ueiIClenY=;
 b=oqfYKGdoZGnakZH5ik3/RuuVhWyIo8vAj6DnrGbzR3XFevAFv1TXtylOc4NuP3T6wUHidQBk6ZTmp7Qv4PSf+/XCzTVyqKkBs+s2Otc7HrHyElxFinBYt0szqE13TikYjmWM186VAdFuEV2gSIooxEiZl6eFyAqYmMBNbdvzrwk=
Received: from CH2PR11CA0017.namprd11.prod.outlook.com (2603:10b6:610:54::27)
 by PH0PR12MB8821.namprd12.prod.outlook.com (2603:10b6:510:28d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sun, 1 Dec
 2024 15:39:49 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::19) by CH2PR11CA0017.outlook.office365.com
 (2603:10b6:610:54::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Sun,
 1 Dec 2024 15:39:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sun, 1 Dec 2024 15:39:49 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 09:39:41 -0600
From: Raghavendra K T <raghavendra.kt@amd.com>
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <gourry@gourry.net>,
	<nehagholkar@meta.com>, <abhishekd@meta.com>, <david@redhat.com>,
	<ying.huang@intel.com>, <nphamcs@gmail.com>, <akpm@linux-foundation.org>,
	<hannes@cmpxchg.org>, <feng.tang@intel.com>, <kbusch@meta.com>,
	<bharata@amd.com>, <Hasan.Maruf@amd.com>, <sj@kernel.org>
CC: <willy@infradead.org>, <kirill.shutemov@linux.intel.com>,
	<mgorman@techsingularity.net>, <vbabka@suse.cz>, <hughd@google.com>,
	<rientjes@google.com>, <shy828301@gmail.com>, <Liam.Howlett@Oracle.com>,
	<peterz@infradead.org>, <mingo@redhat.com>, Raghavendra K T
	<raghavendra.kt@amd.com>, Steven Rostedt <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: [RFC PATCH V0 09/10] trace/kmmscand: Add tracing of scanning and migration
Date: Sun, 1 Dec 2024 15:38:17 +0000
Message-ID: <20241201153818.2633616-10-raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241201153818.2633616-1-raghavendra.kt@amd.com>
References: <20241201153818.2633616-1-raghavendra.kt@amd.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|PH0PR12MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: c18a81a7-b413-4120-3fb7-08dd121e63f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+S4vgTk4HYFyPkj3jl3MLxi3ijH2yDRrLPPvtmCALRco9zr0x7ISsDI7V6uV?=
 =?us-ascii?Q?Mcfz1+BLMZtNE+J+xRg/P/oTU2Wmks0q995FiWOBLy/KQJcXEAEXXmfZ5GIn?=
 =?us-ascii?Q?YtKTJ3Lz3sxW3OM0qGtRAu8Wjyzvkjw8YFKrfrD2tu82ZD4jfC8e3Cv+bhwo?=
 =?us-ascii?Q?jJDgahPPVtzFYzQKg8r8XsBVf+7HPweTZC+qm4/GmCevoNGE2iWMq7oficJ0?=
 =?us-ascii?Q?tZX8fh6eQGU1FzAXa6WFknI65peVW5nA1byj8H8nLAWni//Iyuk9HWSWBpdC?=
 =?us-ascii?Q?e1LWzajAXv0NhJ/Vm3JQxGb3G4vS8MUpWKf9VUgcAkTrJXZt0CFRBPc6Bval?=
 =?us-ascii?Q?iYjxq7/gd5hnzObMmfK9Z54ZAc5nOQB3SKBO/B4owgVZ0w9QVMNnOzo373Lg?=
 =?us-ascii?Q?3OzM0Tr0Y1FoHx7w0pGuiRLTeX1Joo9II4cniBzA/OdEV7Be5332oTmyn/ak?=
 =?us-ascii?Q?mEM0DWH0feAW/NnArCfUCdpI2cxfFCpauk5eZI9j2b+MJZ2n4+EIiMDjdZVD?=
 =?us-ascii?Q?rr2OX8vPds95axd6Q5fdNudecNJCWAxTb8lbnaq4oAb3pVAOzs33YyIVYdFp?=
 =?us-ascii?Q?AgP4g154l2hXml7IVxsQ8iwGyGdbNnRayWyqa+SPr29nm5lzW3MjNFQXC5VS?=
 =?us-ascii?Q?m6Rwb3/fZblU+x9J7gdulB2tCyaxhQRgf5hCdQNGRhpYX3PfuCZ5gQUE8DIV?=
 =?us-ascii?Q?3S3k5HlsRwe+zHvaSmwFmk7PZi1CZDW05yXKTqU969hdMebQmM6tCH62PGJr?=
 =?us-ascii?Q?+BNtlazISEhadjZYoDSNVpXJFHu7sqMerkelTf4ZXtjwxlZcDSVl3+Xtnony?=
 =?us-ascii?Q?ozjxJ6iuWwJHirXeLjTppZTcjDxZS2y7VbaNw5rSmbzSrpAIQCQgbDxm5t5P?=
 =?us-ascii?Q?VTCXf6kqS+8hzEkRpI3/QHnev6+OryrDsubtdZTa0dza+5vbLfrB9H2dEfmn?=
 =?us-ascii?Q?U2tBfIVIKsveYedT9X80rfbWOXf3MnUpnWIT7TRtaWma1ncRiis+JwZtOODX?=
 =?us-ascii?Q?SoR1sSdkxPqIuX55N8Whp17jrafFsGSJDIXhz9cBwTqC/Bc0U7oau+Qr2Wg8?=
 =?us-ascii?Q?J44pVZvCcc+Gnvqj1jf7xnxnIFSnF4c3KWUctaOExxhgakTlBkG79FlF8LIk?=
 =?us-ascii?Q?9vSKtopL7aeEDvn+4ZKVJmrJmr9fLpmNChIsWSyA77zidD6jhUE16r0Vj+Wc?=
 =?us-ascii?Q?CNUigX7p4Mf56MMs4SX9/wmw8ffqV8GqOQgtOFTGiCOi/8V0vd3BAENIdDDo?=
 =?us-ascii?Q?vN4uSiuzekeMDyr+x5p5Hk/K/mb2YU5qBH9JPF19QFt+qF+18GCqdT/ReDXg?=
 =?us-ascii?Q?6Cev3Te36ujI3bD8uVVWX4kHXHWvvEJBbfkgFHPRjdtywBwrUTK4g4dpsQQV?=
 =?us-ascii?Q?hWB4OXBMLafgfr1gAEbo7IPy1EijSEEo0TB06Mc1Y96sch+0haEFBXiBrPiC?=
 =?us-ascii?Q?qqbMk49ROYOJbfXskLzdx9gD4r8R6Ju7Xd0u64murEVMkuVHzmeiWg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2024 15:39:49.1542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c18a81a7-b413-4120-3fb7-08dd121e63f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8821

Add tracing support to track
 - start and end of scanning.
 - migration.

CC: Steven Rostedt <rostedt@goodmis.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>
CC: linux-trace-kernel@vger.kernel.org

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 include/trace/events/kmem.h | 99 +++++++++++++++++++++++++++++++++++++
 mm/kmmscand.c               | 12 ++++-
 2 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index b37eb0a7060f..80978d85300d 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -9,6 +9,105 @@
 #include <linux/tracepoint.h>
 #include <trace/events/mmflags.h>
 
+TRACE_EVENT(kmem_mm_enter,
+
+	TP_PROTO(struct task_struct *t,
+		 struct mm_struct *mm),
+
+	TP_ARGS(t, mm),
+
+	TP_STRUCT__entry(
+		__array(	char, comm, TASK_COMM_LEN	)
+		__field(	struct mm_struct *, mm		)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->comm, t->comm, TASK_COMM_LEN);
+		__entry->mm = mm;
+	),
+
+	TP_printk("kmmscand: mm_enter comm =%s mm=%p", __entry->comm, __entry->mm)
+);
+
+TRACE_EVENT(kmem_scan_mm_start,
+
+	TP_PROTO(struct task_struct *t,
+		 struct mm_struct *mm),
+
+	TP_ARGS(t, mm),
+
+	TP_STRUCT__entry(
+		__array(	char, comm, TASK_COMM_LEN	)
+		__field(	struct mm_struct *, mm		)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->comm, t->comm, TASK_COMM_LEN);
+		__entry->mm = mm;
+	),
+
+	TP_printk("kmmscand: scan_mm_start comm =%s mm=%p", __entry->comm, __entry->mm)
+);
+
+TRACE_EVENT(kmem_scan_mm_end,
+
+	TP_PROTO(struct task_struct *t,
+		 struct mm_struct *mm,
+		 unsigned long start,
+		 unsigned long total,
+		 unsigned long scan_size,
+		 unsigned long scan_period),
+
+	TP_ARGS(t, mm, start, total, scan_period, scan_size),
+
+	TP_STRUCT__entry(
+		__array(	char, comm, TASK_COMM_LEN	)
+		__field(	struct mm_struct *, mm		)
+		__field(	unsigned long,   start		)
+		__field(	unsigned long,   total		)
+		__field(	unsigned long,   scan_period	)
+		__field(	unsigned long,   scan_size	)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->comm, t->comm, TASK_COMM_LEN);
+		__entry->mm = mm;
+		__entry->start = start;
+		__entry->total = total;
+		__entry->scan_period = scan_period;
+		__entry->scan_size = scan_size;
+	),
+
+	TP_printk("kmmscand: scan_mm_end comm =%s mm=%p, start = %ld, total = %ld, scan_period = %ld, scan_size = %ld",
+			__entry->comm, __entry->mm, __entry->start,
+			__entry->total, __entry->scan_period, __entry->scan_size)
+);
+
+TRACE_EVENT(kmem_scan_mm_migrate,
+
+	TP_PROTO(struct task_struct *t,
+		 struct mm_struct *mm,
+		 int rc),
+
+	TP_ARGS(t, mm, rc),
+
+	TP_STRUCT__entry(
+		__array(	char, comm, TASK_COMM_LEN	)
+		__field(	struct mm_struct *, mm		)
+		__field(	int,   rc			)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->comm, t->comm, TASK_COMM_LEN);
+		__entry->mm = mm;
+		__entry->rc = rc;
+	),
+
+	TP_printk("kmmscand: scan_mm_migrate comm =%s mm=%p rc=%d", __entry->comm,
+			__entry->mm, __entry->rc)
+);
+
+
 TRACE_EVENT(kmem_cache_alloc,
 
 	TP_PROTO(unsigned long call_site,
diff --git a/mm/kmmscand.c b/mm/kmmscand.c
index 682c0523c0b4..70f588a210dd 100644
--- a/mm/kmmscand.c
+++ b/mm/kmmscand.c
@@ -668,8 +668,10 @@ static void kmmscand_migrate_folio(void)
 			WRITE_ONCE(kmmscand_cur_migrate_mm, info->mm);
 			spin_unlock(&kmmscand_migrate_lock);
 
-			if (info->mm)
+			if (info->mm) {
 				ret = kmmscand_promote_folio(info);
+				trace_kmem_scan_mm_migrate(info->mm->owner, info->mm, ret);
+			}
 
 			/* TBD: encode migrated count here, currently assume folio_nr_pages */
 			if (!ret)
@@ -828,6 +830,9 @@ static unsigned long kmmscand_scan_mm_slot(void)
 		goto outerloop;
 	}
 
+	if (mm->owner)
+		trace_kmem_scan_mm_start(mm->owner, mm);
+
 	now = jiffies;
 	/*
 	 * Dont scan if :
@@ -868,6 +873,10 @@ static unsigned long kmmscand_scan_mm_slot(void)
 
 	update_mmslot_info = true;
 
+	if (mm->owner)
+		trace_kmem_scan_mm_end(mm->owner, mm, address, total,
+					mm_slot_scan_period, mm_slot_scan_size);
+
 	count_kmmscand_mm_scans();
 
 outerloop:
@@ -1020,6 +1029,7 @@ void __kmmscand_enter(struct mm_struct *mm)
 	spin_unlock(&kmmscand_mm_lock);
 
 	mmgrab(mm);
+	trace_kmem_mm_enter(mm->owner, mm);
 	if (wakeup)
 		wake_up_interruptible(&kmmscand_wait);
 }
-- 
2.39.3

