Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011043.outbound.protection.outlook.com [40.107.130.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0837C45FFDD;
	Fri, 11 Sep 2026 12:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130107; cv=fail; b=B2aslBYroWKPx11p6txGGBKMAyw318GPchzJf/8WBr3F5NCO66XgUT0b933kDBVAPX2Krl+Y0FAuuDGE4SL4l0aTM9VnoBHmH6SkE48u4nQLoGKa6ISOXJWlxty6y22nzjXKAvwJAeBuci3TdMbTlOzYZ8mkI3tbS6K2olIo060=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130107; c=relaxed/simple;
	bh=1nrqhf15GUhq97uUC2srZJdWeYhJNVitELA8iHOfnkk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=S2uz35mlgmm7QnAAYLW8G7IXaINEqtTfPsfV0Y6V0vg/l14d43kJd1hdW59nLJNBP1jt9Rlf5NkXTSoALmK0MTaRkV13pq0ENaaJ4TxbYjnRxqC9tQESkQNC4Yk0ShFK+KN6aLCYraEtHRf8MrZktU11HHyYWmHigqO6wnhhbY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=WhYBOQ25; arc=fail smtp.client-ip=40.107.130.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="WhYBOQ25"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vuYONNC0zJg8CxqHXGQfrtm+ANTwr0oU/RmlyV88gEPg0uafk+Ah2haMJoro/raitRx8G7942kUvzZ3yTSGkI4lOL5LYbq4LKmEoGRcbHwElTi4JxvojUtAwaovfPVoZVgZYS3FMdSVSosyOqIGsvqAZ/npwH9q7HWozqxuWdzBR3D69vGw+30/7iGRJuhaRTDJkL9d28VAr1CIfdyx/ViUdUyVmwym9QYsX+QvanzXbGInBPckgarKzKauaVefnwBWxQJ6T3E0iOKcG8IJB4P7INx6w6xGUrYr+dVA55SunHvfN/IDjqltyI+38pgWukB2yY380wA25Hzv8opgcKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwJJUpyB/CTfZQa7QsFxXt3YA1i1GaNftl7O1PBiHqY=;
 b=ybAbKxvd/Vb0gdDeTzIvVi5B90o4s+5+XKfcdBHZd7rsPNdUVoD2vkdMfqNLXI6WpZOnlNMlGamAwfSDJgMK1GANjYZlzy+oHPlztfbcNnWWYWqir/Rbtquo15Pl+s0WWUfJLrmSS1q9lg34Yf1cM/MwQegKYlkq0+QPFrSOB55CMS4lDIIaVkzBvmRUelnRR6qAO9ekWmf9DPvV4XbQfFcpNE/RyI8Bi5ziUde92aBySEsUsBuUpD+hxpu5OrTAKjGAWQKVZ5/2CJ/JhT6JJwMK+xfJRwaCILMnDJCuEMn2Tkx8siKdJZyKzhme9cLERxSZdM6EDlBGK0gvQkuVWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwJJUpyB/CTfZQa7QsFxXt3YA1i1GaNftl7O1PBiHqY=;
 b=WhYBOQ25c27BAyFCSe7dpTmvp5XdlaKil4TH4a6vO5cMsp0OP9PHA2TyzAUolPV7WmFsyJCWYKMNVjyJoq8dWVriX4WJXE59bHQPlCvGOjoRO8G8OZTZOwi1gW14tcglJal++42rKNwYQuiKmN84Wru90kW+lFkPQBl7yI+BuPHkvRjsnzwDChIzLb2RP3OokMC305Xb3hSyWl1qX8QYSUup7xKg9irD1KKz+YB1m74Fxdp4h7ILhBjXbuYyVSM075hEAmLHu8dEKJojMDKEYBmCdBYqVqXqTZaptSso0r+sglIkQV5wWnm9ratK9/Tc1/eYtnGc4sYk3i6A2wBR+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PA2PR10MB8602.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:421::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 12:34:59 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 12:34:59 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH v2 0/3] rv: per-edge dwell-time statistics for per-cpu monitors
Date: Fri, 11 Sep 2026 14:34:35 +0200
Message-ID: <20260911123439.463052-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JN3P275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:71::15)
 To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PA2PR10MB8602:EE_
X-MS-Office365-Filtering-Correlation-Id: c4d5ed0d-0f1a-44f4-0b90-08df1001177b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|10070799003|6133799003|10067099003|11063799006|18002099003|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	YBUNivj/QyN8HzB38uRqMhlWPFjzKIv+hlv9WM89rDSZlrUEWL9o+HaI/2BlNBmVdTx4MUCaq6bKn6rN/ZN+B6+G0KITB5bMoXL0YoH+1x9WIly/JqiJFoHAOtN46UctwcJrwyUns4sucaFxlCpypwQjIC8X6rwsjleOzPZwI+GmbzkjgtFFT1IwGpujXnuxyf8wy10HUZ0NeZcVuo+Fl5XNxAfpo5PYGRqRTwMqWMnFfKkeB3y0x+SNbC4gcnnv4fiku5Y+A5oN8OMFB2a6xLZphxKH1dloeLQnysVoZDHOl1ndV3sxQpuMYanRqPM+/9cCOOJpgZ+z+kekZiw4cOBRdn/NL9xwiuBSBSmNxeCj6aQfNBSOkGIUhC20T5/F84AX99qIfgY+ffrJ538QxODcOtfrD24xvUhY3oj5pCBZq1qfOLt4JqUZacfPRki5dhEvu4voJIKmOgNCPhg6c84giUN+qHr/zZ611rIbndwrnoPvLvGc7ZxuxmkIMlvMmGterQU63tUHAO6ZofrkchLoFQc+8Hz6K4al6I2NW5uwZ4a5GGxK2XaV4FTpeL/sLw0v8eJLXP7Wc7n4d2E2Q5/LgdRDcmj2BCQBOZJLfUATHgqD+ql37nackTt4ZNhp8Rhm4NhItbIKYyPAeHSdCSHkbElm1wYd/rpNoMv68II=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(10070799003)(6133799003)(10067099003)(11063799006)(18002099003)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n8JyRpYLYtcr3Kao4sQlPzSOWDAJm5WUtTTKAafKwUy3B+tnTEHDfExRzjZl?=
 =?us-ascii?Q?QuGFtctEdmAhqkDDImBs8gFZwNQZAGNY6Y/VXqWjpvV/V55/X+urJzGRAkDc?=
 =?us-ascii?Q?41db0rxzhfCD+EOsy3IQcYdDMYuHLMBHhWU/XoEeEXkRBUFsBGhcNud57eDQ?=
 =?us-ascii?Q?haV1n5CWqpdABalgsWYYKqUjxHJlsi+YaLpRjWGCOiKYuKckTRHZ7ACljHWT?=
 =?us-ascii?Q?Xtb9hE6mt8Ct2Q7YUwmtank+AS1k4/DLTZXW1yqBUSNNc1ogXiojvJe3fKoU?=
 =?us-ascii?Q?2a1Uo3pQ0YtOU1r6Jg01yHzB+yp0P8F7DbOEc1ZEQ0BQtOPqEmNpbBJkbeYt?=
 =?us-ascii?Q?ZWs49Hc7a3QuHJ/X+FRVAuU7rKeuRS/mIKebpcD/smfzQai2rRpfCHQ8wofM?=
 =?us-ascii?Q?zJeEhsGu0rKLTCylrPzh3ZeezkUHpPHtRJbwtZsysTRwCzV4HDZIpmJLUXTR?=
 =?us-ascii?Q?Pwy3A8W3FAHvFfwEIe9cych2vdwRbLz5a+UOVDJS0uezrE3MnHuElZcOXVYY?=
 =?us-ascii?Q?cw36z7S/Qwr5/qNg0Ojhxw+ppuSjHoa2rOegOtB+6Vy18/e99HILEHGi4MFl?=
 =?us-ascii?Q?wNXcK8FHsit6YZq/ldeCdsDZUVanujt5Bqg/t49gWhP6WzEfIoo7Sqx3/2Kt?=
 =?us-ascii?Q?sWoZl5IVA9du5HF5UK9GxpTB781ddAm8IY1BCTSNMGUzDJVdxlFp73mFqTJw?=
 =?us-ascii?Q?0qpYrGXQxVq2SpAiRh2ZG0PmJ16UPWQm+EMqvQOie4OsmXKraWhhl6ZwTsWh?=
 =?us-ascii?Q?a2Afy6oo9DPvP08ntN2F5Lj8JElJ7YoBfviQvoQJYA1E1l2ZUFV0fMVbYgz5?=
 =?us-ascii?Q?W/gM8INa/Qsi9llmi6fxv+DZk4SQBGd/zW61mr2JWTSC2uHgYjJ2IlYR7FoF?=
 =?us-ascii?Q?1UpeknfpxHU5+2AzpmQ1E+NOWxd4JXwr13ATm46AbY2nvUXv1MPEVgUDC7s/?=
 =?us-ascii?Q?UfzzTkACZT9SDG6RBHO7so4KpJfwKa54lPw3T7qj0KxIXyRez0aXGS5uSKCj?=
 =?us-ascii?Q?1BXwf+pUWzLdjkdOYq2sSyby99KJll9rm+ZjowJFOdZOQM02JGMkCUruNWpT?=
 =?us-ascii?Q?X9MyhAjC3A+ydVGE9T/tlivf9VALjcrFKI55IKegrQdGFEjZvC4EENUtFIwb?=
 =?us-ascii?Q?oNjxmJcgaNrZsu/P4zfpkz49FNJWXUSXRp9Ks6Rvtnq9h5HNI9jllRdUoj4q?=
 =?us-ascii?Q?drwrrXHaODrsfQyIbQKO+6HJlluKjPY95rOkl0vlfWe6tI2lRPevGd/LQcg4?=
 =?us-ascii?Q?wC/PU5cAvTdlzqU/vYr34b8tXO6LGInJwebjc7cr0Aaopu/ZBgkU0k6JI3un?=
 =?us-ascii?Q?qlE3BypgcF0gNMq4cytckMKk2ytut+ELxGZo+rGP28L2Iv5zZgfEe4rHoV7U?=
 =?us-ascii?Q?6Um1UE/jxsecQyRLp7pyETrrqncody0Tltw2G9DSVEVwfJfzXUHIxGQSc1rX?=
 =?us-ascii?Q?XbukjaKgjVYhb4AfHBAOz+RmGdCfKDrB/GwsrqvO7aUy4ueFSkx8BrdpS+9Z?=
 =?us-ascii?Q?kzGWJOqHNbWmXNT5CHVLPqE33wrOilLhGcS3fJHnviOlxJiPj3JRJgat3ezO?=
 =?us-ascii?Q?MWMR3a2QtvmGgEPVujoTGxw2venKEYVGll0g81yOD5xPU0NtVIvddKUG8r8w?=
 =?us-ascii?Q?V6GJ5aXRRj9viXtQrgIgp2gkUMkn1abKccfU2BuCLK9Z4M2/kiDlN7iqxWcA?=
 =?us-ascii?Q?XKXnz4bhV7e8zLUmJ53dSzqC5Axa03Pr6yJiooE2MvRn40ygy9fym+kLeiMx?=
 =?us-ascii?Q?3s/8jZlMXE2ywTDpGkqyN0vsoSbfGkp0Qe3A/WKuKgf4i29MyH5HoXMpUema?=
X-MS-Exchange-AntiSpam-MessageData-1: qZAw+MtNms47qJ2XBBWYTuVnnJtXOT82F+s=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d5ed0d-0f1a-44f4-0b90-08df1001177b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 12:34:59.2314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guPN338mRSYa5ydCfjazo01ltXnhXdHjkLkvUUrwNk+bgx8tnzx0CZU0ZRMpmEGVzvVN0B6BCaKtrtgmSykzkZ8nun7FYS0OmPx0rW5J9fw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8602

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

---

Changes since v1:
 - Packed the state and its entry timestamp into one word, so one cmpxchg
   commits both and a nested IRQ can no longer charge a dwell to the
   wrong edge. Hope this approach is fine.
 - Moved the header to include/rv/edge_stat.h (Gabriele).
 - Implemented it all in the da_monitor layer so that rv.c is untouched
   and the file is created from da_monitor_init() (Gabriele). I did not
   create a matrix living in struct da_monitor though. I think that this
   would need a fixed upper bound as rv.h does not know how many states
   and events the monitor will have. But this would lead to a large array
   in any monitor including per-task monitors.
 - Used local64_try_cmpxchg(), bound the loop at
   MAX_DA_RETRY_RACING_EVENTS and warn now if it is hit (Gabriele).
 - Static per-cpu matrix instead of alloc_percpu() (sashiko).
 - depend on 64BIT, so GENERIC_ATOMIC64 is unreachable and the 32-bit
   NMI deadlock cannot happen at all (sashiko).
 - Reset and report for_each_possible_cpu(), and reset before the
   tracepoints are registered (sashiko).
 - stats file is 0440 now, and a failed create is propagated.
 - Columns are now count sum_ns max_ns.

Tobias Schaffner (3):
  rv: add per-edge dwell-time statistics primitive
  rv: add per-monitor edge-stat facility and stats file
  rv: collect per-edge dwell time for per-cpu DA/HA monitors

 .../trace/rv/runtime-verification.rst         |  26 +++
 include/linux/rv.h                            |   9 +-
 include/rv/da_monitor.h                       |  16 +-
 include/rv/edge_stat.h                        | 204 ++++++++++++++++++
 include/rv/ha_monitor.h                       |   2 +-
 kernel/trace/rv/Kconfig                       |  12 ++
 tools/testing/selftests/verification/config   |   3 +
 .../verification/test.d/rv_edge_stats.tc      |  33 +++
 8 files changed, 300 insertions(+), 5 deletions(-)
 create mode 100644 include/rv/edge_stat.h
 create mode 100644 tools/testing/selftests/verification/test.d/rv_edge_stats.tc

-- 
2.43.0

