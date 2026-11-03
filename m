Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.113
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793673902;
	b=vpSdYaM8q8r2eyjG527BgEVxGgdISuinBFRlM4TCqEI+norl7Kya0BiBqhbuwqUSIzYo
	 phvoCpDQ0Yp/IAWdKMTvN3QKR81IolZJT3+drSD6mye1eZARveWWw78XFbB1ZtC5pmRYi
	 eh/OG7AwXIeq6+qNwN1DlitDK6jfoeUPwU1478LtUYQp6V82ah2kZYOwUhws6QGLU9foK
	 HbCFzcRj4Uo8XwsIywXCDG4vH4m4RdYM1kghnFNmmJHUIhb1oJ0EI5d3KMOsqwtrbWr49
	 fG0uSd3IPAsZsob2pMX/Eg70symzuqNz/ZdROGJicMoPIVxtbhnqfaIiX4ZS2XC1YrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793673902;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=PasfR8oWRxIWO6bhP8LVJP213oGmqY14zGIXgd+JWBY=;
	b=G9JhYZzZ901S8v8YW8UzF5Pe+Ek6FLUSaP30LDTXFHDVCxf5N0ZJP6KzenpNYbZP+Avh
	 qXJ7g1l9DA0xiCFGGUZtEUchbCk/EN6/oIB1ZiFr9rx6FMM1mu2ZqaGAeC302ZFgVbku9
	 6SplpMMo+iv2NVoIlYJeQxGMQHMBh8cJHccQbwd3bjR8IlOPm5bEQEqHatRdGkMCnKbLQ
	 5OV0i6NvPU4DTNX05nYJx+DdOVN6/tMkMmauK/cqjY7nQbm8CF93aquhrCbCyt7e97sDi
	 /RnhfBrlBQjHr9Ny2E2Bw6/OOca+M92se/KXOamCL6Q+cLE64hBDelDjhdz2F3m9WsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.113
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021113.outbound.protection.outlook.com [52.101.95.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEFE606A32F;
	Tue,  3 Nov 2026 02:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDEFE606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyRD3jwXv1mWnfa5FIniXUqJcmKMXv1zfoY/pDhBtT4Z6LUU21cl66Ptr4+pLE54sGdJAYRthNIvO8hVQZeNYC7jb/ihnT57FZpubr1hBnnp6/9Q7Iu1UeVoKGDdbp9rim95sTT7shU+GStTCQL/H5BE9DL1335FIhJd6SWt/RPXInWHIirlFLIUW5IzomFrQtI6SDrAt66b7MfFIWtO5giZoOPAMy0hhLwvkmjiX2edSNsVng51Q/vIYq7LlAUE3BMqlhIeq/nhjAysZDe7VM9j5jiecOAhciuDeget2Aexzr/KAIaTZC3c9RTBXe6lGE0mlGZ1h8hy3AtidQBASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=PasfR8oWRxIWO6bhP8LVJP213oGmqY14zGIXgd+JWBY=;
 b=EAOOjLUb/tVEj8M4XHAP1zljsBOZd9bPx/3xenejEZM+o5XKDKZwzKFuPv0Tl20dGgIFzhqqyPg54A87cCrh5eqRLCFAYQ7Nu685c3a2o1OLxrPqtoWcBzGax4TBWdCaSWYAOLGcjseumYYAQXqmfjBAwZUSwE6KezpYh3IuCu5NxfYA2qy5addhKb0QJhcJ2ys4J5T4xwVT+5yD4x4BRX+lOhWIBy35C5iPDh+NqYXhgS9DTMe67MdZcNo7wOwEofH28Y8MlKfkQDoLNdrqwd/7xlqJZABbOCoaas8clc+vHdocypL+6xrGfAjaYArV1nT/++1WVHGdpvGmWoubUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by LO2P123MB6972.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:31d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 02:44:57 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 02:44:57 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: pmladek@suse.com,
	john.ogness@linutronix.de,
	rostedt@goodmis.org,
	senozhatsky@chromium.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	akpm@linux-foundation.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kees@kernel.org,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@kernel.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org
Cc: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [RFC PATCH v2 0/5] panic, crash_core, sys_info: Introduce crash_kexec_in_memory_sys_info
Date: Mon,  2 Nov 2026 21:44:48 -0500
Message-ID: <20261103024453.922373-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0449.namprd03.prod.outlook.com
 (2603:10b6:408:113::34) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:163::8)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|LO2P123MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5320ae-248e-44f9-8ec0-08df39547276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|6133799003|10067099003|261102123227099003|18002099003|3023799007|261102130727099003|921020|56012099006|5023799004|261026140227099003|261022105027099003|261021121427099003|261009221227099003|261021123027099003|261022075727099003|261026121527099003|261009223027099003|261028144727099003|261021135927099003;
X-Microsoft-Antispam-Message-Info:
	U0WZ+jUnRXc/rHYiiDDTJtTfZEp3+4ooVXUTY+8/uoS/T949hrlsvlykyEJXBgC4rw6MXhB79PrEl5vviq5++3bsfsYrF3lRS7mJv+fNoO0JI2qarc2d8MwWKsYzCf8oZ73TMr7KDEI11ebOiBVMhReXgLSGDh+aMaymbxmNxHoTul/VPHnWwI66VB8l51PmqQMHVc79Ll+ZVsk4JVm4a2VK3DLpkYnj5Ygj9G9l8OSMM1xyvBRARNWiuAbUV4B8fWGvZ7FLq2mQk/A+lKLtUReEvIxjkG+qM4DipUsSlVrM7eAh+N7L5Wy0pef3kHFRoPOQkU5tmqfSTucsEaUym5qB5xpG3jo6pOEvZt91L3UMf+pzGLEWcvJrPGY6a594wGlF3t9Xqe1Y9JKwGi+iZ5yjg2GB+yQD3E5rbVE9RbmQHetN7iLekl3lvpZODBIx1fQLuIyBGYmeQ0I3cVUkbhJ5m2CH+CC6ID0w5kK2MwvBZ/qZ0PYa9ZE2SOIlk8juzohZrq3gyfCeQ7ZAi+DrsXY8m/1al2vv0S5SS5jr/x9UO5b8lFLKbEPq+IQFw2pYaJXTsaP2mj+4bG9AE/ZDLcKcG6LMTJrpEljvpHCQGPDyaTRPDtGuzPse83XE9ksxCIxyKSwaEOArgu/2j2UOedoTQWPocxm3mNIuS8qqt98=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(10067099003)(261102123227099003)(18002099003)(3023799007)(261102130727099003)(921020)(56012099006)(5023799004)(261026140227099003)(261022105027099003)(261021121427099003)(261009221227099003)(261021123027099003)(261022075727099003)(261026121527099003)(261009223027099003)(261028144727099003)(261021135927099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cw1ikrewJbIK5ulxhJLMFqJOJfG11ydNgAmIS9v/sXNYHRzHswqB86iafjhK?=
 =?us-ascii?Q?bdeTrmsnCKmNDXN59zjdbvR3+bMWXsg8QAun4lzaOVZGkxVJZ646tjR/XCMl?=
 =?us-ascii?Q?N7FFu81K+y1HFM9h7H9GVURQODD6IOQa6wkXE2umFnraY7ZMluH3cNj/sAkc?=
 =?us-ascii?Q?Hi/T55oXb13chAfbjBX6/RdNkPmivki3LopIVZbr2ygJpx5uUiWqgfRz6hTZ?=
 =?us-ascii?Q?zfRy72UxMaeXp0TxXtLoWndui6eVt9Ou+ueITfLWyg/niJDGWrO1GeAXKzQh?=
 =?us-ascii?Q?dGoI49Np2CSxTK+NmBp8wKtoY7qFpxcxXkYsmZ8uiSWmoMWqLt/bEIfo17LQ?=
 =?us-ascii?Q?ImmS1VkX7+b7ZrY0oOkOie9LEFG12sty2zXAQ4++wKwAV3xOQoyUcSSCOKP5?=
 =?us-ascii?Q?ZVVsF3P8W1bSzQl/nl71DbzHg3PzVflM9ClIBbynj86omFwn4db/aga8fZb4?=
 =?us-ascii?Q?J147JYkDXzzwaZgBghBBg/seDvbl9QdsHva6fX0Np3mM3iwTonj9x3Sl0uQa?=
 =?us-ascii?Q?zckQtIZW/x8aq8J/qEHx1sGu1heD5YDHAKEMacqa7bEJQtSE41rm2zX1sgvE?=
 =?us-ascii?Q?+s1VzEp7/tO1zUkqe8rh/GONzmJyxDK4aD7FCf0rnonB8qhL6QCR+2HtZsch?=
 =?us-ascii?Q?fRHfoIhuLtmNG6VeSrWI7bN46PjdJ4Mv47+irK19hXdW3fzZmzwgzru1tXss?=
 =?us-ascii?Q?0DMlg4Hr7Kg1ammKFBQtxzVpOwKDpcXWqYKJ9LOtPFsWSlm6dux0QqUk6oyc?=
 =?us-ascii?Q?D+3byleDEkLx3QlGSev0FRjGjQUhK6opns6ahwiDD8HbMvSz7WGgnE6ydbUd?=
 =?us-ascii?Q?LVtzKD62XFt8XCIFZhOrv1EBU0LfxhsD0xIxA4xO/I3EUZQVb35uyDuC6xTD?=
 =?us-ascii?Q?7E7eYTs38WYS4/6nqwIUtPi2xDJ+zaBXYFixxtFsl056j5K8IYG4hdWKIqSw?=
 =?us-ascii?Q?ud+Lo+edvVSho/Ozru9DNc9U9BfZm+2GpK401Wiq5tVshgXiUFvqZCw665OS?=
 =?us-ascii?Q?U7/Wj97+4D9S5K3hdbzHPpVoADF8/1Q5II/NLDfqRZCRS2fn6uyOcVXakpMo?=
 =?us-ascii?Q?Gh5TIlAAQFukIT6vpDb3WDCJ7mttNtLNZ7jFlpY1tGC/eMaSqq3HnGywdOKY?=
 =?us-ascii?Q?kHotYzL5uDKZLEge+h07Lo+CT1c1wkQERbErrSMIRf91Oh3IpgnUQw/Mj4UT?=
 =?us-ascii?Q?yMtq5w+9A+isxiKk4/fbyuBR4tFJE4y/paWPTZevkQqej5JWSKXpLecvlY0L?=
 =?us-ascii?Q?lE3iH6iI+ay5Joy2IoUV4VRavehWkp/mxSAKfgRft9B8qGhu6EisOQwmjE51?=
 =?us-ascii?Q?5/7SeqR09Yh+oBRONrLc9Ac2RhLZrHjo+4NbvvJ7u/UmUA2SBBosbk9hRSvn?=
 =?us-ascii?Q?3wUDAkSSmsiXAHsO2KptyKUIibgGM4KZmekk/6PCdfHHUlrtdD25xx3sn1rs?=
 =?us-ascii?Q?bQXn222Vw2x7dQk3yjHup5g0q8AWDJIp9Ha3MslitNQK3oE0yNpnEiDuWrVM?=
 =?us-ascii?Q?jzWKbSNCT5/DGfyyyWLtxRwwNvKCvcf5zbFZrfqYigFA0xpxOs6KvjuH7Cxg?=
 =?us-ascii?Q?7uE3wp+ZUafgDMKd4JRIDXbyTNb/jnJksGjX+w4AgXjlJPCHCDskq4Ivofds?=
 =?us-ascii?Q?iKmEBx7tG9Il26K6T1ARgNmmYjVOipqS+XHSP/Vh1Ff3r/89Xb5PQQPryA4G?=
 =?us-ascii?Q?l9W1J4vPmG7B8HnbE7PmVDca5uX8yW0nA+xMct3LNTYQU4nU6UqTr+6oxU0z?=
 =?us-ascii?Q?7hi0jNOE9w=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5320ae-248e-44f9-8ec0-08df39547276
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 02:44:57.2299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uM45Gkal7ZRggI3yDaOVTm0IgXlR6bWjZWf0BbF7i0sLZae5Uvukw+MYUBvvGxLOoxuhhGxogjCFfY/tBv2mhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB6972

In modern fleet environments, capturing a full multi-gigabyte vmcore via
kdump can occasionally fail or be intentionally skipped due to storage,
network, or encryption constraints. In these scenarios, the extracted
dmesg buffer (e.g. vmcore-dmesg.txt) is often the sole artefact
available for post-mortem triage.

Currently, appending supplemental system state (such as memory usage, held
locks, active timers, task states, or ftrace buffers) via panic_print prior
to kdump requires enabling crash_kexec_post_notifiers. Doing so exposes the
crash path to registered panic notifiers (vastly increasing the risk of
hanging or deadlocking) and forces panic_print output to be flushed
synchronously to physical consoles. On a slow serial console or IPMI
Serial-over-LAN (e.g. 115200 baud), flushing comprehensive sys_info()
output (e.g. tasks or stacktraces) can exceed 10 seconds, allowing the
hardware timer to expire and reset the system before kdump can initialise.
Furthermore, on large systems, high-volume telemetry can wrap the printk
ring buffer and overwrite the initial Oops, BUG, or panic stack trace.

This series introduces the "crash_kexec_in_memory_sys_info" kernel
command-line parameter to decouple in-memory telemetry collection from
both panic notifiers and physical console flushing when kdump is active:

    1.  Fixes duplicate and dropped all-CPU backtraces when SYS_INFO_ALL_BT
        is configured in panic_print across early SMP shutdown and
        __sys_info().

    2.  Avoids spinning indefinitely on zone->lock in show_free_areas()
        during NMI, Oops, or panic contexts by falling back to non-blocking
        trylock acquisitions and skipping contended zones.

    3.  Avoids blocking on timekeeping seqcounts and hrtimer_cpu_base locks
        in sysrq_timer_list_show() and print_active_timers() during NMI,
        Oops, or panic contexts.

    4.  Adds printk console flush suppression across nbcon, legacy
        consoles, and klogd, alongside ring buffer tail pinning so
        pre-crash records can still be recycled while protecting the
        initial crash output from being overwritten by subsequent telemetry
        or ftrace dumps.

    5.  Introduces crash_kexec_in_memory_sys_info and invokes
        panic_in_memory_sys_info() from __crash_kexec() prior to
        machine_crash_shutdown() when crash_kexec_post_notifiers is not
        enabled. It also marks the start of crash diagnostics across
        bust_spinlocks(), __report_bug(), oops_enter(), and vpanic(), and
        reorders __sys_info() so compact, high-signal dumps (SYS_INFO_MEM,
        SYS_INFO_LOCKS, SYS_INFO_TIMERS, SYS_INFO_BLOCKED_TASKS) execute
        before high-volume dumps (SYS_INFO_ALL_BT, SYS_INFO_TASKS,
        SYS_INFO_FTRACE).

Changes since v1:

    - Split the single patch into a 5-patch series separating prerequisite
      panic all-CPU backtrace fixes, crash-time lock safety in show_mem()
      and timer_list, printk/tracing infrastructure, and the crash_kexec
      integration

    - Moved in-memory sys_info() collection from vpanic() into
      __crash_kexec() via panic_in_memory_sys_info() with local interrupts
      disabled so all crash_kexec() entry points (including direct Oops/die
      paths prior to vpanic()) are covered, and kept console flush
      suppression and tail pinning active through machine_crash_shutdown()
      and machine_kexec() unless machine_kexec() returns

    - Replaced unconditional ring buffer tail freezing with crash-start
      sequence pinning (printk_mark_panic_start(),
      printk_clear_panic_start(), and printk_is_tail_full()), allowing
      pre-crash records to be recycled while preserving the initial
      Oops/panic trace, finalising the last record when full, and stopping
      ftrace_dump_one() before consuming unprinted trace entries

    - Extended printk_suppress_console_flush() to cover nbcon atomic
      flushes and kthreads, legacy console_flush_one_record() and kthreads,
      and wake_up_klogd(), and dropped unnecessary EXPORT_SYMBOL_GPL
      exports

    - Added crash-context trylock and NMI-safe timekeeping handling in
      show_free_areas(), sysrq_timer_list_show(), and
      print_active_timers(), and fixed duplicate/dropped all-CPU backtraces
      when SYS_INFO_ALL_BT is used during panic

 - Link to v1: https://lore.kernel.org/lkml/20260916201546.661384-1-atomlin@atomlin.com/

Aaron Tomlin (5):
  panic, sys_info: Fix duplicate and dropped all-CPU backtraces in panic
  mm/show_mem: Avoid blocking on zone->lock during Oops or panic
  timers: Avoid blocking on hrtimer_cpu_base lock during Oops or panic
  printk, tracing: Support console flush suppression and tail pinning
  panic, crash_core, sys_info: Introduce crash_kexec_in_memory_sys_info

 .../admin-guide/kernel-parameters.txt         |  11 ++
 include/linux/panic.h                         |   2 +
 include/linux/printk.h                        |  27 +++
 include/linux/sched.h                         |   3 +
 include/linux/sys_info.h                      |   4 +
 kernel/crash_core.c                           |   6 +
 kernel/exit.c                                 |  10 ++
 kernel/fork.c                                 |   3 +
 kernel/panic.c                                |  87 ++++++++-
 kernel/printk/internal.h                      |   4 +
 kernel/printk/nbcon.c                         |  11 +-
 kernel/printk/printk.c                        |  29 ++-
 kernel/printk/printk_ringbuffer.c             | 168 +++++++++++++++++-
 kernel/time/timer_list.c                      |  13 +-
 kernel/trace/trace.c                          |  20 ++-
 lib/bug.c                                     |  18 +-
 lib/bust_spinlocks.c                          |  22 ++-
 lib/sys_info.c                                |  33 ++--
 mm/show_mem.c                                 |  15 +-
 19 files changed, 447 insertions(+), 39 deletions(-)

-- 
2.55.0

