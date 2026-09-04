Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021141.outbound.protection.outlook.com [52.101.95.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FB34FC8C0;
	Fri,  4 Sep 2026 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788550496; cv=fail; b=bQ5znW5NO85qWuGKeVO5kH5I9qmAEUysMSj16vCLYDSnAnxXUolcq8bf+bikaLBgFl+HLW28fDhaALh1L/gSJyw2vGhNVrBI6vZApZNW96devi/hDoxVoJxK81OiJ7mPcM4V1HwfbDfZXFNVmzlVYrTH3tgz6kTwNaYXYX3gKjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788550496; c=relaxed/simple;
	bh=GWt3JWN7AdWjxH5CwmcpkwiRRLbeV3em5FaXMZqXkjE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=j48vduDh+xAkgs/JrQCCIYi5vqnZ/MUNMNe+Apb01vzsxyLUAhO9EMEsGSUIEL28uH7hKjqVh4dtefZVHylj4l+zpc6n7rtBChTdtymW8gvCY4TFxxSiAZ3FPcK1q+3ykAf+bWr+xe23CVhlz+RIkLZcBukejZE9JoEMnO/8vx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBMgayhUTrvXsV2YQsomm8ae0NPhki/Ne9jXaLKejJk8c2YUyNZCGvXUYa0cmQQdViKjBZUD+yNm3FQ0HXpBQxq++7fnfPN19PIh03GrqX5cOwmQ8I3WzGvEZpRYCBDHXr2Lr29pawtAJAd6BppNL/NL+lzriXc9G7ePsB814s5FK15pi+6MnQDS6rfZaimFjYmKSJq5PzYKsZVwrAVq9ZOyEfAK1bZGmeu1QzUbTqx5ChMvZYofr4/fgBvGmPgjhXBcY1BDSQFfoCfhsvg/+nxgxscrBLBpai79q9yLwNxi3W9JzZK77p/mcsbCUZdBnU2CCkFpMN/NfLeowSQ2ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=UdmfwxvEvdPZcVlH9RzPiwfRailq9Z6kpBF9xW5gJ7s=;
 b=JanJe+1DaMOC5wXhT1rFx9bNDHpB+hABr4qyuNtFOHPdRq1m7Ch4xO+vzWLtC7vV0B1BLqKrCCed0byYgeCulgkQbqGWTOMP1mtGS7+klFtrO3urmQFg4wN5c+2YtoZ7jReL+C4yMyJp+McGXTNB8s1bQp8Rk3Z1vXTEN+0TF4GV7j7QE5xp4M4+AXFrbh0jY8+Jy7XI1p9V6+7LZwzsWRXPqFo5K4ZqDe7K+MQBSRcgUQF0Hj6fKo+lFhs81GRmG2EzHPjoZIuMO7cJTpQFG7Cf7MGJeW9GbBN26fOCtdi5CuhwhF/S4HeXKZ+8tZKGTXz/DQWlDOchgZNtNt+Okg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO4P123MB6609.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:27e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 19:34:50 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 19:34:50 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: tj@kernel.org
Cc: jiangshanlai@gmail.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	osandov@osandov.com,
	atomlin@atomlin.com,
	neelx@suse.com,
	sean@ashe.io,
	marco.crivellari@suse.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Add telemetry tracepoints for CPU hogs, distress, and BH budget yields
Date: Fri,  4 Sep 2026 15:34:44 -0400
Message-ID: <20260904193447.247502-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::23) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO4P123MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 67dbe7f0-0c1d-4c79-5dd2-08df0abb962f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|6133799003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	R1IoxnPoKStcgRCsqYcTfkifPFsI1waaSHb7Fh4tjidfVekdfkuSqk9cid2eZad6tOG1GSHn1UO/u6+OpBt0lI1ma4MTRpIM+PLfW4FcYdw2lkGKloClxhOMMDYvBxapZ/SaTRXdShvDIADI4US8jDiHMybL74pMySHx2aPzmmu8KUMW1JcbfNJhWN2A3LExH/+TXS7MCRSJ0TRKe7JXyNVHVHGipwYsMV7BuGsjzu/cjdASWenpbXts5uv669ebdD5QdPoZTMlYAnkqN+ErbP/P5fvGFhsjHdCiq8AzWGPe4QxYr4shpUMxOY/Gnq4sqKlQJmH2OQ7GjZ6HS731+35pCdR9H3UbeBfZaDvc5DveeoDJWuErAyILpY/w9M8gM531QSlztjZ1MAe9ryzCYvVmwGra8sSFsD55lvWoqvq9lMEuiPpjwnewXyPyf3SiuD9bIBZTyay4NUZhc3cFwPm9Ns84uFb0tI2AdrvOj0nPjIDvSRBn6xwfTmIt/KBv6435IlJRuBxoteMYfnXVRRTalM/Z2TvO74L1Uqay9ZKry2CD7UYyIlE0VaQvrqbJElCq6rxZUPeXgW20riguHGVXPCYwn2tuk0GA5kTT4tEqZehgBnlArk4or2cpOWlVmPuEzbWiPWO6DYiMOuGDfH+PAYhkurj1+qHFwnUXWtk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(6133799003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hCUDuUeJQrY7ceDqbCIYmsJB/2DDjlg+CSBGmZJYZ/wWWF677EGY6X5aROvd?=
 =?us-ascii?Q?Qrc5YgtzIVZStn7EEjO8kIz0wWLYeHNmwzEEEtdfK4xYjvvkKbgSX1MU5qXk?=
 =?us-ascii?Q?PzS3Ahq1PAhPvgHvHxgdW0ctnUL6aY+ECf/LY8fsNZYu73m8AZtUKBctbrwY?=
 =?us-ascii?Q?YKXUsqAGA+tXBpOmqsZaRHJQ7i9ur29yESFNl9rSMRUE8falH1bVgZGkz6FZ?=
 =?us-ascii?Q?UuXAOqhn3w5KT2W5ViG/3DK+hz8pKFeb1FTBCDdYuP6kX2hPCrGcXeRJ6HLu?=
 =?us-ascii?Q?gpOTHeEeYcV58nHH2a0fvPurB9TOk3gI9/IkjfKL2XCzyK9LNvzjTT28nuVL?=
 =?us-ascii?Q?+MepiaMkr3b9+MeKjuucdm3gQQ0Gk6dsbe0H+Sme9JPZYtBYyz4E3OnSW+x7?=
 =?us-ascii?Q?p6OZvuzwKknrQTV66YumtwyrwnVFxyO1JlUl3CS46enDaWNftS5yLi56hCtx?=
 =?us-ascii?Q?Py+a7zKdrgDLeA9qLKbklgpDW2yRe0WaHp2Y42QdfPSdwI6rD16otGaoNFpZ?=
 =?us-ascii?Q?V7GlEDI7JF5DIvOBzakcZ1UybAeU8BoWALgl8vaQobLuZrYsoapn7fA9navC?=
 =?us-ascii?Q?p6baX9xBF1lDItaMvW56/zENFLLNVZxnvfCcxh4xxqsUyV+KDfuCl7Vc/73Z?=
 =?us-ascii?Q?G4gswWykv/ojAlNfBP94OGeH1SI/3mzOFWJtSclAGpmD4f8kWwHnUwVJutd2?=
 =?us-ascii?Q?Irk404QL5eji0br6UancxveunuRHnoqV2vDdkyRjCKCl8vKIW9FmuqqjrBTu?=
 =?us-ascii?Q?IDptmMMSTbTso/W+qT97O7RKiZhR4KToHkpwT3OgW2jBP3EobNyOb87EDf11?=
 =?us-ascii?Q?a1u9vWbnBZJcY3u69aor6bWGhlgHI5Bq+O/X7BDUcNTtijDS7UfcTmGoRs66?=
 =?us-ascii?Q?NQsKFvJIMM3q2jxt/lzF+hAcE+CuFAJcV56NbSbakRfkxDzvUlQhZfudVQ1+?=
 =?us-ascii?Q?ZBtMMxpU0TZ1AdK0iVxJ0Jhg4B5nWGfgmz4RGEu1KRLK5pB3tUymBkF3p8b8?=
 =?us-ascii?Q?1KsIk32Nbuj1gTWq8+bBf94ez6l/hX8fac2hhOzfoEoDKm2PpLzXSeKRafC8?=
 =?us-ascii?Q?Glwn9k0hyk2WwQcItaoU2yZi+euLsaa7MutNIXcNuVw1zFz7prQxrN3u3w1W?=
 =?us-ascii?Q?WyiHr1/5SdY4xuyLgFjA63tPx31zaiZnPpi1GV+kTR/WsUBGQfXKsRvaDwxA?=
 =?us-ascii?Q?25n1ozzyRE02Sm6mchuwVnzTu4Yj+u6nNnOQf0n0ulfdsc8kCeN4ISrdymO8?=
 =?us-ascii?Q?HDekBJYLQE3aWQEEtaAU2eOHDxzxckbozSMnN2p71NV/btk9O//fWFvKlsBQ?=
 =?us-ascii?Q?a69pl4iOcicWBAsOCD+6awQSvpc11nzAhvWflVM+rVoDwfaj6UEL81PMJ8Wb?=
 =?us-ascii?Q?4aaVxfSWesI0MnbffdRi6Brz4sUZGuRnQ+N/9Yn9Eak9+fsZn/rFZNcuyQjm?=
 =?us-ascii?Q?R3DwJfSDGiR12P4M1h9PFS3zOO2myBibtZHaMNhSpdNa1XPnwzrm4f4WzWHG?=
 =?us-ascii?Q?SzEhHotF2xHSmeCDbey9ObgiYUa8i+G4rb0vsDI8+9Yr6zEq1mVFfnDyGyy4?=
 =?us-ascii?Q?Tlf6E2xS3Vt9etuRNNDKBFN+hRoRCnUm2htmgt+KscFYjF26UcTC/lr7NThZ?=
 =?us-ascii?Q?QLWK4Sim8rF1Kq9DLA0HY7d2MdWAns7XRXWXI/KSDpravzwNvpLSuM0O5DnD?=
 =?us-ascii?Q?8vTF/TGEtrCBobSpyYRuJYneCEN41y+tM0zwu6IB7cCLBpMzPa7efRzNGbQr?=
 =?us-ascii?Q?hNYiOCwLMw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67dbe7f0-0c1d-4c79-5dd2-08df0abb962f
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 19:34:50.6787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9+MpGqlxv97hNK94PLpmtRKF1ls1WnKNCdE4lk1Q2WgM7jjaMOmAEvFl0xbES5MmJh2WUOn37+8E3J/ZTo5Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6609

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
prevent queue starvation. The tracepoint captures the offending work
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

Changes since v1:

 - Fixed 32-bit architecture build/link failures reported by including
   <linux/math64.h> and using div_u64() (Tejun Heo)

 - Kept the fast-path threshold comparison in wq_worker_tick() untouched to
   avoid performing division on every timer tick

 - Calculated elapsed duration using div_u64() on the cold path only after
   marking the worker CPU_INTENSIVE and releasing pool->lock

 - Eliminated the race where re-reading jiffies after the loop could
   misattribute an exhausted restart budget to a timeout; timeout is now
   derived directly inside the loop from the condition that actually
   terminated it (Tejun Heo)

 - Corrected restart counting. Explicitly tracked and reported the actual
   number of restarts executed rather than total loop iterations
   (Tejun Heo)

 - Link to v1: https://lore.kernel.org/lkml/20260829230517.42468-1-atomlin@atomlin.com/

Aaron Tomlin (3):
  workqueue: Add workqueue_cpu_intensive tracepoint
  workqueue: Add workqueue_mayday and workqueue_rescued tracepoints
  workqueue: Add workqueue_bh_budget_yield tracepoint

 include/trace/events/workqueue.h | 147 +++++++++++++++++++++++++++++++
 kernel/workqueue.c               |  35 +++++++-
 2 files changed, 180 insertions(+), 2 deletions(-)

-- 
2.55.0

