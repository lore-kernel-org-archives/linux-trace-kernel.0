Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011061.outbound.protection.outlook.com [52.101.70.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC973112B2;
	Thu, 27 Aug 2026 07:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787815455; cv=fail; b=E28W2rssAGJmdqMdrlFi2/OlQSChPnd2LtouHW24j45LPHgSfAcOQiaOrFc7lcgp2j/pEthRYC531sDTwIZXu9tPiOjKZ6snERqfJom08N3+aH8KdWVmye3QuWVexwPrPimKy07hNcUDT8+z/06u+V2+3gsotgMebCVSI6V9rsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787815455; c=relaxed/simple;
	bh=SQf//+CY+Y6kst3vr4zV8f/awMBLDKOPiG8k1gnvbME=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AeBJR491SRiCWCEhkb3rBX/UH/IXgoU72wbEIzG2ctzF2KWu7KtImij6CYX9xbN3VqTeIcaW+9Wz/sZQQqjp8Xe3SGaMzh1ViC+I1CkXPvxb6UQUAwwASJ3Ym9JsaNgrC7ZV2wJNL2nWDu8Ay+B08hp8xSRFKsclsXfHoVjjrmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=FE9VFrsg; arc=fail smtp.client-ip=52.101.70.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="FE9VFrsg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jzFg6TlFYXtLk92fQIL85qC4rPhzezs9EIwOkVC6oPV4jPPVlEpnIeFnzN5D66dnBvds3xEOG0tvp4WdDRITUiu3rWpwZbxVHtQrd9mVgDFztJV90ARo9EGjOzcL3Eljb+5k4BNQrgeVWczQCZkf/RMH6en4/n16KUzKZKA8NWY2MBEg6ujLpNr9lENVJiUYHoHgmUod4J5TIzkrc21/3kyir502iNyY+A8Mqz54VjOqPG3k+eQxuu0iUo7uuOxWCpJRwUMKstiIfSSIkJEyOkdDU+qsF4J9C77+F/V6saPBSBrb8k04yuNgUwLJ21GzJs5ZLTqRCKOWbZGpb47B4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAgZ2eApBqO+yzARqjo1g7OlLuIkoYxMtHkw7H12ueA=;
 b=LaRYzd22kMMoR/r9eGkHnsO1LKcmmjAv2h9ftv5dPvkYSjx6zJbQIFyxXaCeqsxCCSncq15w3Jx8MslB0WyOBgD3oVnp/Ez0Fz4vF4dm0dMZ3oHIgfrkOL8V1wRJW2ZcCQvcDgjoTDb70hj+8/WLKAfhib40zbJMMnCTAMv7aa6WZOvyjlRrxqNXIEr3Hyg1fXqp8XNhDYY0mKIDzIIDO5QgFPFf88IRua8GAXQ+CksPglxfH8iWFBXF6LxHcS/t7ayMYIgiJFfDdA5F/f9lrXcSQFOLZSy+44Mh0qZwyvTgCW3spb+MvrJ/7+aOduzx0JdXW2/8d5eRABqfquzsxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAgZ2eApBqO+yzARqjo1g7OlLuIkoYxMtHkw7H12ueA=;
 b=FE9VFrsgEyKWWZva0m86lFeqXbAYKwCJIHx3LzrkmBooHD5GvdVaWwMnmLedYrMdMJ2h+xTRBs9rXG6tVo7OOW3OSxb5RAN3O5iTbauhr5z+v1fGF4LYVbwHz/Wg/zswF2xb9Ust8ww0CDLMzu15unxE+4oiyasZuzfcSuv/VHR/Tltg2HO+9g/YMIXVMkTFDgSKmAb+twizUMnxm6fXN+Qrn9d6JrpFWbyufansB0CQR1Cq8j84FVNqEJHR48J8rVF0dX9wWGzW77vVX/vABgBJKTHjxhwS72IQF/ZC3lAPS4MnVNisSjnzVV227d5G6x6XU0lJdbHN6c6/IQ4rhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GV1PR10MB8608.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 07:24:08 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0339.008; Thu, 27 Aug 2026
 07:24:08 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Philippe Gerum <rpm@xenomai.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [RFC 0/3] rv: per-edge dwell-time statistics for per-cpu monitors
Date: Thu, 27 Aug 2026 09:23:57 +0200
Message-ID: <20260827072400.45734-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::7) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|GV1PR10MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: d13f968a-7ebc-4cbb-74b2-08df040c2e98
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|10070799003|366016|6133799003|10067099003|56012099006|11063799006|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5CNFsZbpS4+qITvqjUkKGjRbcPDO1iVPzOIqiBkEbXnJ06b3MVg6V/JF4/nG5b/Hq3OlGmEAO6xDbZCmiOsTFoCkbWQ9VPyW1nq9d7xSxDEoe3RtOJGI+NqfqF9P6dHH7JdWSGt9B5DRG5zU3fwvC+Z28L+s9WbQGZsVZjePEWgVB8/UXgg5TSRPeT5L2BjdKfTARU+35Hz+3FbZ+csrHGgNqKyEWsbgYQN9iM4T7msC1+8GDQGnB+3HCASjBX/OItCk2u3LJKL9cP9NSNmPjq3+RyT9rTWg4aBi7M5NayyWEGeaWhvtbSJWE+1k8GFgIJjx5MsxZK1hi0kvukti/9GkXPy/QwR08i9sv6/wCgiC3VbAp1WWHXaRBBxb0B6EAsq8uANQ6iHzQOOzOboXpv8zPEXb9w1CsCtAgULCemub0ncAf07cYvRmLZG8WLkclj2vre6zJDBl+l87XkgkdtrdGG48sO4Yx9E/kYAkHS3wMP6m+BfTs5a1k+i6b9UwuZnc4JJ0QENDH9w5JXF7nKSm1V7p3NPSNKFobuVjqPbZlBToiqgeDboxK5qISYyShD4vvra3RNkFj77adiR4V8wUteKIJ6Icx8kmzkdOm+ZWh6S9HfPQXnnUTNTnq3UwuZEB+iossPeb8GLDShJj/L8PudKbdb8YoLgMahzT0+0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(10070799003)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tjsrj4Qaoiq2ALd/tl4gZwlqosukmEvjNg07r9nbHk4yeSNaWVqUEEC8o4uk?=
 =?us-ascii?Q?xfEnl8GCJAKs4kzy5w+BDjmEKaJgqh7HcL1hi6mZ5dWLvWVQEi3cyepg9Ujq?=
 =?us-ascii?Q?3iaaELx4npjl8EFJMviPYdC9r21NV4dpBAXR7TVf0SjiYI9/3qc8TfNoVqrI?=
 =?us-ascii?Q?uj+cMrTgLi0GlC95lVbCaKMDFX6X84AAF4+I+43fOFSNEDGfYEaOfbYPuLcc?=
 =?us-ascii?Q?esemS3cHKPGFuvC+kaCrwx5swyQnibRpqllnjpxat0cZrdDSM69E95j9WaT7?=
 =?us-ascii?Q?A/3Drx1LViA8o6f3ukOzMNZme30xQysI8KkcnAD9D1zTptpW3aBhnFy52hBa?=
 =?us-ascii?Q?n9Plugn+/RDsOb3Lewf7mYs6YY64QVAMrmmm715Rci1lK45zthj165ntqw58?=
 =?us-ascii?Q?F32lz2aoeMCD1SgBRo6fr+yWQkBTvx2DLgkK+zszHUvFIMhqXbsCKLmEPV5A?=
 =?us-ascii?Q?adncSCzBJDSXq20NMNiehQi9fJnCmSaIAZvBPyYw/Svcz478motB4yiVqot2?=
 =?us-ascii?Q?7Y/kORYnZKmLLBX+k5WUyanu8D5VrdQY+OYez7KUk7ZUWMiTqyHglrVuXCtu?=
 =?us-ascii?Q?f4SFc57EYjkREJdrlghWV0NEOIxkNZuv1S/a3/qhY37FPDrxEagTOxCZ08FM?=
 =?us-ascii?Q?QiEWvl8bkydubZVdGpvQ6AmzwrKtTRGfPJ3bouEi/F9tF2Ce6vRBDI4p8LCU?=
 =?us-ascii?Q?JxpeUpCDqP2OA2236Y9MlVnWOFD2s5WDGGVbiyz3hUaAGi70EgfVYq/0Kz+d?=
 =?us-ascii?Q?Q+5l2QPPj/NLxF2Np849xQ9qSgYH23B7T7eH/8NH0xF/llXAPJGD82sUiXj1?=
 =?us-ascii?Q?JaXRBJFjMSl1WvKnt1kHiXd3g1br7BSMxPHa7zJxGStQ20h/AvbCrYK7YpW4?=
 =?us-ascii?Q?eLK4FgkmqUusowM7zj5cxJplZQv+r76Ih9tZu+VFeJJn+RJ5aFmfQhS5m498?=
 =?us-ascii?Q?5rw0M9VS9MJ7d5uuOm9cEoVbwIB+SzAdv0Npj2s4G9rrsvtRh2RIVnS+crr9?=
 =?us-ascii?Q?YXQ+fSnk4Cz3OknpsKfdro/lbHNGIDxVPC9mSusrHpjXF75fllyQ12uWYz9Q?=
 =?us-ascii?Q?F5ZM+k6UUh8QzcUVqyNT8fsjgS001+LaUBR1zgKvedrWqP7yftFCXVtdFg94?=
 =?us-ascii?Q?uJzQ3Yeu54UvZmTpadBW5pux/9ULtPIwGY1SrukqwcJP87Hz9y3FRcDsZ71Y?=
 =?us-ascii?Q?ASEXiuU1QyLGRsksAZnYjJjYPd2kfDpr1ls3spXFc+O5/ztgk40L22OaS9n2?=
 =?us-ascii?Q?RzZJfoO0+m0Gu6gmSGwLB0AtH/vatb478XzVWf1Cekx/RSNPrRFqYxJ+zhjq?=
 =?us-ascii?Q?yk73DTr5s91POEyyoK13+FWnkrkyL+mQKJsJN/GM8+FrMgLgwdkvr8uZhqWk?=
 =?us-ascii?Q?xUEacE7BE6ktADluFIpz0u4Me+viU2kAro57PyaVdYOBgYTMzbQ1HTbf7CJk?=
 =?us-ascii?Q?XBZ/VEsdmER7lao9hn0K3ZRFBIpAIAiyin2IILYJurVrxrrFxLkzYdSjz4/I?=
 =?us-ascii?Q?3YrUV4gxR60LnPDwxkrHlprQYa0+XCd67U8H3sHBBsajsjcEAYIL5ZByFsLj?=
 =?us-ascii?Q?YMSmzxo9qeGJYwvpFq/S1OUEOfMsmgfbFQleRJtza0Zvtm//FXgwMtLHvK/M?=
 =?us-ascii?Q?OjgaWs2GI+oTKr3Tmh8RA8TEQMxnTX8QzjD4VkD0au8nvy+u/2JIhMTvy2vi?=
 =?us-ascii?Q?C+qJCFQRRnmWqQK4LpK2KaOK6w03Ti31nE7F/M5JAkGuo4wXCnBY6pDtwCcM?=
 =?us-ascii?Q?hPSAXtk9WTM7+/k1VfL0VLkXGD5mDWL2SYeHPferVtyBNJA/kYsSmk6V2Zk6?=
X-MS-Exchange-AntiSpam-MessageData-1: kMHqePU/ptG9BZbgcL0XlR1nSmne9GUA2iE=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13f968a-7ebc-4cbb-74b2-08df040c2e98
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:24:08.0713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bHqYqxpMnXaux8jFERhw8wfXjbJXzQntkpucsbt6p4T9pc3GB4HYOON01Fs8LBJUa4Jx6mM0LDCOSdG+SbEtJc9hg5zD9fp+WbkbIoBMoUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8608

Hi Steven, Gabriele,

I am using the RV system for a downstream project called EVL (aka Xenomai4).
It is a small co-kernel system, small enough that I can model the whole
co-kernel with RV instead of just a fragment of it.

The patches in this series add a per-monitor "stats" file that exposes how
often an edge has been visited and the dwell time in the prior state for
per-cpu monitors.

This allows me to not only check if the model is correct but also to see if
all paths are exercised by my stress tooling and to decompose the latency of
the co-kernel's wakeup path.

I think that some of the upstream monitors like e.g. the sts monitor could also
profit from this.

As an example, here is the sts monitor on a StarFive VisionFive2 running an rt
kernel (isolcpus=2-3), after enabling it and generating some scheduler load.
Only the edges the automaton actually takes are non-zero:

  # cat monitors/sched/sts/stats
  # cpu edge label count max_ns sum_ns
  0 0 can_sched:irq_disable 367732 3998500 14773091250
  0 4 can_sched:schedule_entry 40282 398750 45510750
  0 7 cant_sched:irq_enable 367732 32500 532791750
  0 8 cant_sched:irq_entry 26188 6250 38357250
  0 13 disable_to_switch:irq_enable 4933 12500 12275000
  0 14 disable_to_switch:irq_entry 31 2250 35250
  0 15 disable_to_switch:sched_switch 35373 26750 111615750
  0 18 enable_to_exit:irq_disable 373 3250 649750
  0 19 enable_to_exit:irq_enable 373 20000 1676250
  0 20 enable_to_exit:irq_entry 309 4750 420000
  0 23 enable_to_exit:schedule_exit 40298 3000 37335000
  0 25 in_irq:irq_enable 31 12250 140750
  0 30 scheduling:irq_disable 40337 18000 45449500
  0 37 switching:irq_enable 35373 9250 72471000
  [ cpus 1-2 omitted ]
  3 0 can_sched:irq_disable 567 3983750 300860250
  3 4 can_sched:schedule_entry 150 1500 171000
  3 7 cant_sched:irq_enable 567 21500 1777500
  3 8 cant_sched:irq_entry 76 6500 164750
  3 15 disable_to_switch:sched_switch 150 4250 413750
  3 23 enable_to_exit:schedule_exit 150 1500 147750
  3 30 scheduling:irq_disable 150 1500 166000
  3 37 switching:irq_enable 150 3750 277000

The sts model splits the schedule->switch path into separate states, so the
per-edge dwell decomposes the scheduler's interrupts-off window: on cpu0 the
prep phase (disable_to_switch, irqs off until the switch) tops out at 26.8us
and the switch itself (switching:irq_enable) at 9.3us, over 35k switches. The
counts also line up with the model, e.g. every irq_disable in can_sched has a
matching irq_enable in cant_sched (367732 == 367732). The isolated cpus 2-3
take almost no switches (150 on cpu3, versus 35k on cpu0) and their worst case
is tighter still (~4us), so the same file also makes the effect of cpu
isolation visible per cpu.

The changes are gated by CONFIG_RV_EDGE_STAT and dormant until a monitor is
enabled, so existing setups are unaffected. When enabled, each accepted
transition adds one local_clock() and a few lock-free local64_t updates. With
the config off there is no code on the hot path at all.

I focused on per-cpu monitors as a first step. Per-task and per-object
monitors would have to aggregate entities that share a cpu, which is harder
to get right, so I left them out for now.

What is your opinion on this? Do you think this is worth getting upstreamed?

Thanks for taking a look,
Tobias

Tobias Schaffner (3):
  rv: add per-edge dwell-time statistics primitive
  rv: add per-monitor edge-stat facility and stats file
  rv: collect per-edge dwell time for per-cpu DA/HA monitors

 .../trace/rv/runtime-verification.rst         |  24 ++++
 MAINTAINERS                                   |   1 +
 include/linux/rv.h                            |  18 +++
 include/linux/rv_edge_stat.h                  |  60 +++++++++
 include/rv/da_monitor.h                       |  53 ++++++++
 kernel/trace/rv/Kconfig                       |  11 ++
 kernel/trace/rv/rv.c                          | 116 +++++++++++++++++-
 tools/testing/selftests/verification/config   |   1 +
 .../verification/test.d/rv_edge_stats.tc      |  32 +++++
 9 files changed, 315 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/rv_edge_stat.h
 create mode 100644 tools/testing/selftests/verification/test.d/rv_edge_stats.tc

-- 
2.43.0

