Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021113.outbound.protection.outlook.com [52.101.95.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925E43FC5D1;
	Sat, 29 Aug 2026 23:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788044729; cv=fail; b=R9tgSffGeQmHak7qDvens5NVxibOvlxy+Ad4h3h25NJHuEbIh77k4qXe2WR2QlE6GGTgbvw12e/IbqVZkL1ncEE02lXKSm91Wmar2h2I6HVqBwHGIGIfrx2Qvd6SkBrMrS9gogxKnV8tB80pS1kMyGs+wLp3bJBF8xLvRF1n/TA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788044729; c=relaxed/simple;
	bh=LHvmAtCX0//c2Wnv4/O43M6AZ2dHWxWFMpGrKGwekvE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=i4csfGWmVeo9UDvfi0t4Fl+wsZo5hhhJO7QAM3Hy8c77M6Yw6ZRA5UDHaEh5JlS+ha8vJldT7nGcKCcmXiBHn3qHM++VXTG7dz6qJmxmuCUZwaShE6KATglyCWLqlY/9kI307pZ4jEAVfAjAKT6drSSm7LEO6QDt7i/2wo/2uzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CiYtGie7uSxJ7dyk3cOj2BsTOznsoCVbLlODimKvsg87wfFj8w9xKGbZO8ba5vRDiLerybJtc00zfGqtIkQ6+UaEIQ/YlFCtkOD69hKjHc9NVGV4yTtWkEYC3CcXUglIVemxfURTfW1IO5wW/SlpC/LwAuBzwvM5gD6YaC4HofQtHrC8EIoRvMXAV5FnEilYCR3mutEyoRooXNxm15cK85NRwebYEn7Vil9IRi6bnwQGRfOyXWHFT6M6KF3EPj7jS3P9PhcIMTiOZR6S07Lk7qH6T7Ev3cXOTsj65/2NAreEv0rwxu9DbUIApbLyuPWDK0phN+lpA24KHKQoX1wc4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=V5kuxSBt/VMAEKHC+ZgKZ2GcMbaS8f6o2/NmxJ8Gk90=;
 b=bjVORX34GlpO0+B6zH4b7ZheSusHq2AFafYHavVO7mNctHG5SWKqvxk3x5MCoXfInM8v+8nSuzCyCNnszy/3ipoB96MKivJRUKPLQzrA5aI7cG75A3Rg2Bfd/B16envUHFDtnmyz01IuZ+JDIO9RMHWicLcXbfQhKDg43nDVGSInKBxSdZCnd7nQhoh6b4Kr06Qkoxp4aBv1r3LrJPebfIeSiNRUgLFFjmQDXR9gTjqBHQ9UXUm8HpuZxB7bHPwSgkxOxOpqnOutDZkMWd14R42H5uKjewhBUWmtVqVNgYS/vYx31qTuk98EOI4nfMUOW2Tk7urIM536jtDQQooF/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWYP123MB9008.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:288::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sat, 29 Aug
 2026 23:05:23 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 23:05:22 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: tj@kernel.org
Cc: jianshanlai@mail.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	osandov@osandov.com,
	atomlin@atomlin.com,
	neelx@suse.com,
	sean@ashe.io,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/3] workqueue: Add telemetry tracepoints for CPU hogs, distress, and BH budget yields
Date: Sat, 29 Aug 2026 19:05:14 -0400
Message-ID: <20260829230517.42468-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P223CA0015.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::20) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWYP123MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e52c797-36bc-42c6-34bb-08df06220084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|10067099003|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	r03Q8RkJiHZR1bpRfvoL7mTwVwkhL3uDieuIeq7qU9diagvmgiyzObOD5Xi6MnyMZukSBex2FuQfT7dG4EPZG6fsZdnXqEHh8vwXJeWRoIsQKiCTDiT/QauS75S4pMX5NbwfeBRWC0ZNSceRfDeaxnG4TaC5dkBY3KhjXN59d8Hs1SgAaCDwg3f8+gXrWfVuRa/Eu77tnjRZDqy8n3cZL0KGPlLGDesNqCj+nXvmfHKPqU+ALtXTHWYSvDyME44DzR6NXquhWV066VyMRbam6m0h7vFrynUp4/sJEX8wWUwEJPyVDnt3Yd6W+0naB52eGGbQCP1sSrvNN6p/9ZOCWCkGLzi9/GnmYtAGltPZEA4PTT3YGZlYVIgAo57DEw48doksY73N3aSXlJPrgFlrj3WJsfZt2nINZBanQxGrv1yIsVSt6HrgKLlep6MVJeFowOsB51zlNQCZYuyTZGT8zLlppq/TALuRNmva9rafip/UKad9IRFYKQst+rUOiA2/Pg+ocu7ifvx1Z2WwgAuLMZFsXWLh+jZ4DvHFK3EImx540xgyvzcRd0YOVidnvCbSwXB9Ad8Rko+keSFWcvGblFh7f/gUWQlt15upplZLyI0CqRprugJn9BkMsstesIhbQZ7vndHSWVh7dvXLIIG87n5olixtiDEo/3sMThpwZg4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5e5BtvVlu6IDPgDqetJs4xoZkm4yuC6gCTmVJ2XugS3utObKfK8T7pzNBKeV?=
 =?us-ascii?Q?KGauIqdZy7RiB73N/h5TiblddiL4bqdTUP+2efV75/ThD69OX+r4s4JzbvJz?=
 =?us-ascii?Q?EiKrlaiqP6SOtmTpn6vIEuFdgH+nTfsxQhtTFyb/HBoj3hN7U2misbB46ENN?=
 =?us-ascii?Q?lPNG3MizCYUSfCOl6k79HX5IIYUmTrf50FAhk2aEvvTmy/WNxEloGkwa3F3w?=
 =?us-ascii?Q?+db87xDUlnLBfkOuH2FQq1+C2mgn2kAStRx/To7/0VbnPzeqAK0Ghj8cTpjW?=
 =?us-ascii?Q?B3aAIILWa7U6vqfXn25lYZm9mn5rCQ61oavosF9EbGae6uDpYUicC7BPvJYc?=
 =?us-ascii?Q?pGlkp5pd9xAW8qK4iAcsxWi+rPcdbsqBngtR5cUc6/S3lgKcTPpFWkXX8rHC?=
 =?us-ascii?Q?qCEqzDnDAxx4lYtvPusfu9MrA7TTrVQEJdIEStWk4KFvCio0t+acptFNl0PA?=
 =?us-ascii?Q?iFgQvwIpYaB2eOeuZr4GZoZK+NORAjP4A5+9J4aRzz/YEvcxD0NJAtNJHMjs?=
 =?us-ascii?Q?vMBr5Zk25O2nFNHOtbugO1Rieiy8g479dWR57tPB+DESJM6mgNwH4KvE78wD?=
 =?us-ascii?Q?GNkAox6tJUCTZG64+7giG4OgkTUZskqpwws3VCBkOSFN6L8uGIQ9qNrLURDG?=
 =?us-ascii?Q?vkBsdA+GZYmUD3o6Z7mZ0zJ930gTYa6MlXQDghiO2ala0N05zSDrNKeEn5ZA?=
 =?us-ascii?Q?KSjOJmECSn/i91DZ0encqtnwSPnwZKpM4UxbEI+dfeh5lhrxpwmnSaLAAPcD?=
 =?us-ascii?Q?AEYwXyzgtCxaINRfWxngA2O7YrmLXKaf64mVhLR8Ll3AqF6Ov+9L2YJ1Ktan?=
 =?us-ascii?Q?RI9e7lDcvfhlbQ/cmQkFT+bgE9/2lUw6oArPrxVTcfeQ68nXFZRcM8UjPNIL?=
 =?us-ascii?Q?p55yPmRLKxeCLcNZHXKCpgAezRM+WKsXBXcMwwuRYn7mFHzJecNDuLUKaCCX?=
 =?us-ascii?Q?unrjxNoDPK7YvX+wvHA7JzW8AqHKx0VpJfnxxO8OVJ87WN1Avs5VwKxoV8u9?=
 =?us-ascii?Q?MTV0kCXHxnq2aYwCBNr2wXk17+vslWVQP719XyIzBKUoXgXd0wuGeB6VGep/?=
 =?us-ascii?Q?0GTkp/vo9uym9XCwZ8eVRNKxBQyplv8SCuYCPPJR3R8I3sLUsRhy+aPV4kwf?=
 =?us-ascii?Q?8odiMuurPqQEXEFN0kKpVZslu2gWWlhJRMfFCF8gZHHLKi1XTitA6OZlfSSd?=
 =?us-ascii?Q?kSz8q/or2uoc5yVWAI0a6wdcRTW557QRldp5I+wXJeKf67tw3WSvJPqiqMw7?=
 =?us-ascii?Q?YBFc0W/HpKumGQJmgaM1IzzexVolk7EHPop0FdXKPFQ20ZZ8QyvPFkeIcYPR?=
 =?us-ascii?Q?U8hpxbilqt+vgrEuVUDh05e95aaD+md3l8KHFePglh5winHOOqMDlKNOkawU?=
 =?us-ascii?Q?89cH019ln5h3Vw42By6iIYbEyzSklXYP6R8KRmcYws/Kx8tsgm5xoqChOsSr?=
 =?us-ascii?Q?AU2Njbk4Z5qPGUvTsYq2nLfdQe5MkfHCu4KjNMg5RIaLfUTXt54BbzpPt/v0?=
 =?us-ascii?Q?R4kaNC51Ed1epegU3BuLYO2f1/jJIaASXK1IaGf5P/XP2enrTdUQkpl+XxhP?=
 =?us-ascii?Q?Vbt1g7LtbCyP8qKrVZI9JqDkm2BEj67JOpKuxVII7a2FavArXB5+UICuemeG?=
 =?us-ascii?Q?2/YHo4IiquUUpXPWV4O7c5wI5ke1ouNYojrNrnVV9nJqpUa4VNG1Ra6mqYuJ?=
 =?us-ascii?Q?DSYl2hsKQ8Plc0Jr4ZiOk+U1AWaPqlYXRpQVO1x3yaogCEhsm9IV/hcpE0FU?=
 =?us-ascii?Q?ldedF2xr/g=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e52c797-36bc-42c6-34bb-08df06220084
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 23:05:21.9664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUrbbou2a4S8HrO5Wid6c8vsiNcIxvQGDP7dEXwlMSIEBGa92dGIMaVjYJXw57X+mUGSANU0+t1AHVEluWPKag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWYP123MB9008

Hi Tejun, Lai,

While the workqueue subsystem maintains rich internal telemetry via
pwq->stats[], wq_cpu_intensive_thresh_us, and distress mechanisms, several
critical state transitions and execution anomalies currently lack real-time
event notifications.

Across production fleets and low-latency networking workloads, polling
pwq->stats[] or running drgn scripts is impractical for detecting
intermittent stalls. Tail-latency spikes and packet drops often stem from
softirq overruns or latency-critical work items queueing behind CPU-bound
tasks. These event-driven tracepoints allow zero-overhead eBPF tools and
latency profilers to capture stack traces and kernel context at the exact
moment a starvation event or softirq budget exhaustion occurs.

This patch series introduces lightweight tracepoints for these key
operational boundaries:

Patch 1 adds workqueue_cpu_intensive tracepoint. When a concurrency-managed
worker runs for longer than wq_cpu_intensive_thresh_us without sleeping,
wq_worker_tick() marks it as WORKER_CPU_INTENSIVE and kicks the pool to
prevent queue starvation. The tracepoint will capture the offending work
function, workqueue name, CPU, and elapsed duration.

Patch 2 adds workqueue_mayday and workqueue_rescued tracepoints. One when
worker allocation stalls trigger mayday distress, and another when pending
work items are handed off to the rescuer thread to ensure forward progress.

Patch 3 adds workqueue_bh_budget_yield tracepoint. Bottom-Half (BH)
workqueues enforce execution limits in softirq context (BH_WORKER_JIFFIES
and BH_WORKER_RESTARTS). When a BH worker hits these limits while pending
work remains, it yields and re-raises the softirq. The tracepoint can be
used to identify softirq budget saturation and track whether yielding
occurred due to time slice expiration or restart counts.

Aaron Tomlin (3):
  workqueue: Add workqueue_cpu_intensive tracepoint
  workqueue: Add workqueue_mayday and workqueue_rescued tracepoints
  workqueue: Add workqueue_bh_budget_yield tracepoint

 include/trace/events/workqueue.h | 146 +++++++++++++++++++++++++++++++
 kernel/workqueue.c               |  24 ++++-
 2 files changed, 168 insertions(+), 2 deletions(-)

-- 
2.55.0

