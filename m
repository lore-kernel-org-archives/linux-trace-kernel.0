Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023100.outbound.protection.outlook.com [40.107.44.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40CB39CCFC;
	Wed, 29 Jul 2026 08:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785312688; cv=fail; b=dsRsVwqqOndz0YDhcMLxgXvtGnfwpS1hrAIh/z5jsSgLCUUYbRR0oe0+V9QNRKi9+GwD6Z0vdLa9wICRHP3yMvF1+9dAN2iPutMcCFHTdbxWnJDMOmz8/r3uyTtIrjjgBQostwPgXQyxHqtfboS77b5LBPHqZz3l1P/uEIoz1Ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785312688; c=relaxed/simple;
	bh=0zbJqKOuO8pqVxwH/ksG2GomkHHbmDld0LcP1vG6Ibk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Te/hg/IHJfKdDQpYqDHTpPaEI4bqubu7aGUj5cVC+E/WdZumHmkczITCd1PiYmHOd4lmNsPVl6f1Pz6juNnH8cohKAN4WhsBTq2Ky+It2CinOq1cQ2p16vb4TZenV/M8vni1bLDfJVMu9GDVa6QAiUbRyOhYjW+l8hlsOHBYc/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=processmission.com; spf=pass smtp.mailfrom=processmission.com; dkim=pass (2048-bit key) header.d=processmission.com header.i=@processmission.com header.b=l6ytPsMC; arc=fail smtp.client-ip=40.107.44.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=processmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=processmission.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=processmission.com header.i=@processmission.com header.b="l6ytPsMC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHLjCoyOuK/dwwUby8NCjTfYps2SRgRcLavz7wcTcm+9HQ/lHxjCMqN8+5YmsTXc9oKliuFFDavxAwWE/D5OTmqh1mJGET/6G0I9SkPMTkCwU1TWBsLr3T4PJ886318ZQI6KPBIRPKK6KohQlc7bHodXIRSIrTNDNzrKmqS94EmrE+8SWTz/XbOjbZDrzbnOSxUEN4XAORW2dX5WEDsDcOCVYs6PV3mGEtDvlucZ6/Mw7SbFSMWjG0dHSO7jjuuFSlrcRx5mJATdTJlxdMltmBoBeLgoEJZ81fpanxoUYATeQHKNIq6DoSURYhoBQJpHid9pIPPXlj1rbdGrd2fuoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvX5iOIRz29ihp3mVd0KyixpDhT2ndQZeY8YdOoVs/U=;
 b=LQ2AOTApXETvnblaXEKMHgkCJsiZPkim7Wt6D6l9RNQ37ItmbTDbVuGQnVXQLGuoFAcUtxMmGHUUO0U4i/dZf/uwAlFP4ib+zWMH1v0gFyN2LTpA4NwU8b4XTNoa51lDoluEshioDyqdIP+tv5qsmOzHMfE90ZnZkCaur74exd3Zqw+w3XrH8e9wo6/jOJY+zvTzxo5lW5q+W5zQe3Oz+D9xZNFADTLpl81x0dCO3R7Nji+nIm5bo2clFQFIS4l0rAXDJZ8q182ahb/pSgOJsx0Dl/lNOCs5kWd97ef0JUSlEbdIU7DzivQMtNXQdnYFrPdJP25uCljqu8aF/z+W6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvX5iOIRz29ihp3mVd0KyixpDhT2ndQZeY8YdOoVs/U=;
 b=l6ytPsMCaZJQ34+vfiV+Sky3ec0mAdq6qAGPCc6EIRdkiSViIoHxFG2j4CcSxlIZjNmMmSvOC8iIW8KNS47kzAqSwBWWHrzoWc2KXX8MfmZ4oyeMKNav09bgMWGUxjXY5AV38vDEYirXvB24Qu2uVy3kBWwZflwYQMSLBpIlC4pvUT2+H51qduJ4WO+CLBrD5jhRiMETAyIxG/oSz0d5jVq5CaloV2wCJ9WXJ1mwxDkF8KshQgRly7zYEsBqJh6Nrwruc3JGCfgSWWLiPfkyWyYjNx3Gqqlu2rx8SY9r8sVoFC+WGdKn/5kzsNvR1fY5kmyL+BNx6GnBAj9N9Mhrag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SEYPR02MB5701.apcprd02.prod.outlook.com (2603:1096:101:59::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 08:11:22 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0245.012; Wed, 29 Jul 2026
 08:11:22 +0000
From: Chao Liu <chao.liu@processmission.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: zhouzhouyi@gmail.com,
	lianux.mm@gmail.com,
	lianux.wang@processmission.com,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chao Liu <chao.liu@processmission.com>
Subject: [RFC PATCH v2] Documentation/rv: Explain epoll and aborted sleeps
Date: Wed, 29 Jul 2026 16:11:02 +0800
Message-ID: <20260729081102.73138-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:254::26) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SEYPR02MB5701:EE_
X-MS-Office365-Filtering-Correlation-Id: 974ae310-ae9e-437b-29fa-08deed48f9e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34096008|366016|1800799024|23010399003|376014|5023799004|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	85v25ivZ9RoGSQV8w4pMz6l8FEv4rHCAsqafIatY8ZqmH7qDJf9ZxLvrijLCaWxONt3dLwLn9dXMMO3lu2sSPQLfY+5h26yupoDekJ4gCDmJ/bTymkbZPbJt9kYT+Fr4R2PT/Zr3aPtBKvLxikjCRgPMgtjRU2kDWBPsjp3xnP9IA5Emldi1NnCh65A0Yt+t9VGV8wtNCqHJU/OIi452HD3akBlcqYQT/T3flJlNv+Z2xHPv8s/00BwsTstFU6hB+WLpiebCEFfwA7H7p6bKJo6I6BbckytoH05aD1csHxN05JM9jx7J+g7xdZEgFy/LYJ4GmU6MwuISbG0OmpDLdXgg52EJ2fCfW7f6I8cmdu5rLHuum+4hd4PHREw8wNB7UCGPtJjW6r2F71evUlCRMgb9/JY9QGRdmFrluUQf+3rv59P7csaU+fuIfibBiAt2QlNTgiwGrUzxyvCY+2CU5K3RZfByKoys5ImPSLYwmx5volHNBBZOjZhQJB5ZAwHPWXQcifAxX6/WZayggeOOo4dU8u4k4p4iFg2Wfx1Cm4WNoCJxdoDayRlX/FqCDvo30k9vNJP0yId4QUifaEN8Oyq62dXznLaPWaMYQrtM2mKc6VNo42ABC8+FHceAPvCQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYNPR02MB9351.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(34096008)(366016)(1800799024)(23010399003)(376014)(5023799004)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eHdfJBB59vCRaF90D6SjFtECDBexLugBb0SqxR1J/Ly1GDOPGm+VSbKKEVpq?=
 =?us-ascii?Q?f8BlRKHQ/VhWBFUqTQCtHHi4Hz9nYrqiUaGwCzLFvJ2uWdd97zK+OTB3sTWV?=
 =?us-ascii?Q?0nuY1i/Ef5qHgF2JtM76Rck7DLL8kpGehLBIC39hk6xcHC24BuWAGkIe//vk?=
 =?us-ascii?Q?37ZyCpHUfaAklHkAJiXVNvMui0ICtZJQ5imaRBpXCr0qovCTpSaWeGte+mrs?=
 =?us-ascii?Q?t12+fuQXflojaHhsUHP0uvynw44tFl0IPxvAMAnyGzWuGGa1X9O9KSUESPpK?=
 =?us-ascii?Q?bYjfK+YbMckMRSnMSlAubf7/Xqzymk8/HidOTJNIqxbRoOcSXEdQIJws+vlg?=
 =?us-ascii?Q?pQhECDvNYRifVtbx5drYxIsJUA/e0c9k1jgXG9hB6J0VpSeae0W+2jvNGSKo?=
 =?us-ascii?Q?gG1wf448yT6tterjam9IJ5LTkOiffshVTc0HgfAemNxq/9xBlNgXpSlgWdBd?=
 =?us-ascii?Q?aIlspRiZ+GYALgsIcrQnb6o9wNbHwkymbb4+0lYwRcmx/4bXhr7SirUM/oz+?=
 =?us-ascii?Q?mmVfwam2YcMNGJ/ZIY6DRfFKMP2ClLztR1XeBEWbVzu5K39y8p1gRXxYV+Q4?=
 =?us-ascii?Q?TXZ9N+pyj3S5oWYETQER8ltX+o/tTgPISElxeS6GtlJYgo/N6dyo44EQNOyK?=
 =?us-ascii?Q?wQq9tCxdwr8+uCE5pmuq6pmJpzKezx3zngoZCQROL2vrTW1Hma9XHMYYlKHK?=
 =?us-ascii?Q?ogwNtSX2O10oKpXW85ykH83e74Mo8arhiWFV9mI0eyiljuwgRs3APUfLUoA0?=
 =?us-ascii?Q?PygTLtTM+Zgog+JN8JVTHwpog7ObYmMNVabBWLmRxfe9Ky2SRb0ffsrnPc2m?=
 =?us-ascii?Q?OMKh1bjv9KviESOTS9zMF3jRA2gjM8Y+tWs7vDXEHNn1AWBhCX4Nrfflin9S?=
 =?us-ascii?Q?pbR0z7YNBmrjusAgogKwRuQZCe0b1Tqyf6OwGhWawI7NXjot79cd0r2rDTHl?=
 =?us-ascii?Q?Tkd+O6kjDYKlZDR9oEI9JdksbTkgB6lm5i9E6RAjYInnDkbZL+4fEUo2h9hl?=
 =?us-ascii?Q?B1nc8Ldz5peS2pSRf5MxD+nv2TvL+rpzHWB5OozosabxMpYEt4IvkEeSR2oU?=
 =?us-ascii?Q?Qb5Y03+qYxgQRn0j41QjLrAtxRLbXqW8/haoq4n3YmrRrPTz5wOjBtwYNjlZ?=
 =?us-ascii?Q?COXw31gtEHTLDMGrhUw4VT9TddMFtg/kR7htFqLLEdaBg9Z4iAnM59AWIdMo?=
 =?us-ascii?Q?RZhG8aos/xkWrMNcmeG2TDDAiK1ChKMMRoc+p6ElAl92NMFdNtoCzMFplGIN?=
 =?us-ascii?Q?4Ru1Bi/pAr1UAbtiOH/3jm3x2URzEC7LmV9AC9dOEjX6UBJ92D6sYxS43cS0?=
 =?us-ascii?Q?mvJ+cxcLox6YydptrULFK5EpiiNdkOx9U8c5lAWBUP42yPVe23avgckcVBKs?=
 =?us-ascii?Q?lK1+D4H9NF2ozMhxncmmKOTnbVsnmxw26ujGG02JapIYqUyOAGPpzjcuYsLO?=
 =?us-ascii?Q?disMW619C2RlUXIUNGS35jvOFLYDh+3muFMsiFci0/GhWU+I2bI438ZYmG7i?=
 =?us-ascii?Q?jenuaxFuD0V+6spt3mZsYsgkKl/NVzzCwkMgbyhucMJ5OXwv3Kl4+okSRJej?=
 =?us-ascii?Q?0Si91NTDZRGwl55RgwpL/yamybIefNdPhG+cPsQpQtple2XY9aniWnNJfkXH?=
 =?us-ascii?Q?SRy4vGfyt6eUaawiRXvNOIMFJGtOKmdjWQ7FA9MB94w4s0uR1nOuCc6Tf+mJ?=
 =?us-ascii?Q?xyfBxboZv+HQ2u4ECKoW1TLER26pow8gOvMgkTmmSru9n8j/fJf2ED7vgN+U?=
 =?us-ascii?Q?4IAEzc/cx+cz4at3J9sdn9S0hG+p+Lo=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 974ae310-ae9e-437b-29fa-08deed48f9e1
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 08:11:22.0689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJw8Gd80BuGt1xj3LvylqqrzBcyGV8qGeQwW7J3Y4IWNuq1lUaWlre0YGFOMVMZI8eiDh6oBi6upTCJGbYMkiHIvLus7//5zgRztF7pEKCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB5701

epoll_wait() is a valid sleeping reason for real-time tasks because it
uses PI-aware locking, but the rtapp sleep monitor documentation only
discusses clock_nanosleep() and futexes. Document it.

ABORT_SLEEP represents a task restoring TASK_RUNNING before entering
the scheduler. Since the task does not actually block, it becomes
runnable again without a wakeup sequence unsafe for real-time. Document
this behavior.

This RFC is based on Nam Cao's pending "rv: rtapp monitor update" v2
series:

https://lore.kernel.org/r/cover.1781852967.git.namcao@linutronix.de

Signed-off-by: Chao Liu <chao.liu@processmission.com>
---
Changes in v2:
- Explain why epoll_wait() is RT-safe in terms of PI-aware locking.
- Explain that ABORT_SLEEP does not require an RT-unsafe wakeup sequence.
- Update the commit message accordingly.

Link to v1:
https://lore.kernel.org/linux-trace-kernel/20260722045706.85633-1-chao.liu@processmission.com/

 Documentation/trace/rv/monitor_rtapp.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/trace/rv/monitor_rtapp.rst b/Documentation/trace/rv/monitor_rtapp.rst
index 238b59395ff5..b95994ade14a 100644
--- a/Documentation/trace/rv/monitor_rtapp.rst
+++ b/Documentation/trace/rv/monitor_rtapp.rst
@@ -67,6 +67,8 @@ thread to sleep for one of the following reasons:
     variables as safe for real-time. As an alternative, the librtpi library
     exists to provide a conditional variable implementation that is correct for
     real-time applications in Linux.
+  - Real-time thread waiting for events using `epoll_wait`, which is a
+    real-time-safe syscall for sleeping as it uses PI-aware locking.
 
 Beside the reason for sleeping, the eventual waker should also be
 real-time-safe. Namely, one of:
@@ -114,6 +116,10 @@ The monitor's specification is::
   ALLOWLIST = BLOCK_ON_RT_MUTEX
            or FUTEX_LOCK_PI
 
+`ABORT_SLEEP` represents a task restoring its state to `TASK_RUNNING` before
+entering the scheduler. In this case, the task does not actually block, so the
+task is back to runnable without any wakeup sequence unsafe for real-time.
+
 Beside the scenarios described above, this specification also defines an allow list
 to handle some special cases:
 

base-commit: 248951ddc14de84de3910f9b13f51491a8cd91df
prerequisite-patch-id: d8b6c952a954662852e6b0684e0a3386eaab7f41
prerequisite-patch-id: 940f7637aeabe4ba15a09c048c6f48138406f332
prerequisite-patch-id: b99812692691f76d825778e01a2e771e058febd6
prerequisite-patch-id: 512c300dce2cb74ac9cc007f9234aa507ef5c008
-- 
2.54.0
