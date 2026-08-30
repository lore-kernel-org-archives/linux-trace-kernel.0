Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010048.outbound.protection.outlook.com [52.101.56.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D309332629;
	Sun, 30 Aug 2026 22:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788128867; cv=fail; b=nu2P+E1b+F6uQzyJO15eXXqBrILw+vkv5+Zjc5eD/qnIbgMc9PtB+ThQUyAl3Z8iVEmcvr5N3SWcta5UokBwv9zJ1RsNUmINzh+A9lUesdCg0k2L79kV2zbbimzl8R4TXfLNV7j/oVRDm7B11V8LgB3LiZeXJWcGR6ast1Upu9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788128867; c=relaxed/simple;
	bh=rl6+J+43cE6zlIHrnO2V8EFovYOAtm5Y/lLnvu/HeGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D3PbZHy6JF5oI0pJ5DUsEqaXC4Q3B7ZoiaGG0rd3saBL5iRUcK5QD3jAHVNkCWCIYWBE9IQ2PhWWe2avUqS1whlGD3FVGpYkg5p1LYt+DokhlR5+Ou5RDGCt1a+mySqSUauwPWfsVgnOBSL0KkAiimBkIGdR4MAI5+fqZtliueU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bLeu4yMF; arc=fail smtp.client-ip=52.101.56.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bLeu4yMF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PamCkblXp1AfSvGlPomk/fwWCD7EBda+pbS97236Gxx7B155z8pchhgIdQovM5Q8+kho684wBaJTEhTTPDMi1nEyZLamy6laYcMTnUxPmOt+Qy9U0x1Qh2GHflCCu7uK4736Ht4lfS7JDS9u3RmCpmbwmeHrMx96uJ781U5/eiVeKz8noF0MFKCRgBc5AXFeru2d0Eh/sPrD19DDgJyX+AoIzhi9AV0K/+pnyqjGGaAwtH+kIQvhR9leJkGSGr4ZKOElEuaGGQJ+Y6EfIWMnZWlKCHcaUjdSZ2aE4ReWA2uohFHpnCM98fOR7t8v9j1Re18a+qUThEq2eJlKsmWuow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozKXI1If6Zch9ZeDP6AYVlnFj36hIpd77KUljEX4qSE=;
 b=AxPvhHoIQzeuAGH/XpdPJC1fSWvQ+77Mj2TxiO7Q8sDPaFC5UACxMusGvnmn7d9V3cmZVCJMjxPjcFHL/ang2OWiUbd3l85+u7dbToLig5/zqzyQgynEP9oVf+sNx7g2DBnwnS2XOiLDpZ1gupjXiW4NvrZHBTO+rO1SfGuvdog57NzkcoWwa3AgLAIsrkoXeLNYJhjuqAbok1bMc4PxfinhgyYc6+YPazwQTNsKcYu3Y0RISgJenddLVE3amFrYMn8zTJGQJrdX4yk7R7OXvcxAL/3n/e4jBktZ6sB8fhGtQfOLgOv2wdOVWnINf+vWaNTMFVBRpfYCGl/oCIoRrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozKXI1If6Zch9ZeDP6AYVlnFj36hIpd77KUljEX4qSE=;
 b=bLeu4yMFA2PZGBjD1Vf5DburlyQi1h52fY+1BdROIriFMIvRe01CoRxumFaRAVZnMIcuujhvZYbTyhPBSCtrKA8Ylb0iWXRNcB68dxavajTaHKhcVHC+z1gqiwXvsU9TnXcYlxwk2Ecf2OCR32jkyCar/iz/B5xpLnuxG48leZHRQbkrw8E2L8yEpiJ+QNIpxcYopX36VZtyPwDIzAjLnyXXvud5oP4GB4wbL3pLjXTCOBNBNO1ghzdh4HDgrAhcuJ5XDMQ2HAM5UYPn/+vAGbKT59WYZnv8HkCuSguqRr1++le1qGqZk6tby/T0OFt/rTUrz037Oh6lL3WtQ/wXpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 22:27:41 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0360.008; Sun, 30 Aug 2026
 22:27:41 +0000
Date: Sun, 30 Aug 2026 18:27:38 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Julia Lawall <julia.lawall@inria.fr>,
	Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH v3 0/2] tracing: Remove trace_printk.h from kernel.h
Message-ID: <apSuTRfEmAkzpuiq@yury>
References: <20260624081806.120105649@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624081806.120105649@kernel.org>
X-ClientProxiedBy: CH5P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::16) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|DM4PR12MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: f768f03c-f551-4831-99d7-08df06e5e7da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|23010399003|376014|7416014|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	ETMfLIe8qbc3HUIShLc+b9/RJdasX7cUyzcV+AeNclGdD8HRigt4XQHVwCwmOWzyjLcOZasdsSSRLXv/pJ+2PMp9eh/N+4mjpzUj1dB/hTtwgJ+aDNHwz4g+GB1UNwbsMKl6uMcEEx2X2XF+k8ju5gSRaHR0X05sENUNqkInHmSl28qI44QLwPM7lknRRyobhrRn7dFkhdeHQ7GW81f6xzIq7z9Wvy6xO98uF/siEDyqww3RKeiLcvCsZi0lJIOcmoPKrajAciJr5HFyG0bcGgaxGN14grhRmKj+S1r5MSM3B5cT2hSWRlq5go9PXvsr/J3qFI/8f0Nq7cPCL5fWnjuMjMFtFAbE0S3orPEWXeh8t7ewS/Mv42hxywrjSh9TbxcujjZQDE98YLabaQ+uNXwNyo55wS2N5pOrve11jfqCiwgy/aEyFevUOF0lCyrQGwCl2raQwjQHrRZiEp3cIFE+w375HpduQzQTJa7Tv7WXfPBpA7tUzFhOXDZu1qVfNH89sJKk0figFA7f72E2b/a6uxsf18yy1exk/reJLZQlDeAl3N6qCYseShATGXcoXyBZXZeZXPyG92fV7evanCocOM1PkgT54mbabSi+pirIBbz5uZ0UYXTTvVLMYKnkMGDLHSvtoaGzBZq0ZoMS9FBjV0DOpeNipEngE77pZe8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?miY+0Ud9dZf3wCb3Fzg2XRszITrYPo9olEpZLEe7pd9A/zTB2WJM7wrCpnFt?=
 =?us-ascii?Q?12XO5GV5ROGloiChnAVWtQxyoUOmDibPxGFHntiHjaCVr66kulNj3+Otj/OA?=
 =?us-ascii?Q?+3mFp6SNR27/LLStE4Gwy7lEGifpXFXlngSeVkMCtsM+UmQmovlPg559F3oj?=
 =?us-ascii?Q?+b0TmQH/9x2eLgcQaS/8x08q8tjjJiS8MK3TS08Mg+WS4GUvyrTMb3JCe0o5?=
 =?us-ascii?Q?i8QW93KH4GZ7/RM0HBE7Wp3KJMqZfEQMg9ia8RuT+5Lm3fhBp7sFqh/ckc0e?=
 =?us-ascii?Q?qhklnM/EWO2G6bwMy4RAnUHv1QNu4ZvNzJSHVTAvQm49fZ1pBO0/+bSPe7yQ?=
 =?us-ascii?Q?JLCnzZAtY3r1G6DHyPt5WhAKYZqng/P4IO92Hdgy83XPhLRUxkRgtROMNltV?=
 =?us-ascii?Q?MHHz91QrI+xdZHpBjKJtkqNwhQxh5KuLUBqVs7MbsoUDBcb4aqwnaLJzx3pp?=
 =?us-ascii?Q?biM0EB38xzDIMvlklB+gEcNJmtUKNZjsaick8fIN4zbqrh/AYuIARnsawCqt?=
 =?us-ascii?Q?nCtV58AcVocUB4CDibBKi8mk/gQVuCOhH9C81AfmWZYhzeMsIndMIDffi4Cx?=
 =?us-ascii?Q?hHtYSq6zJDu/bahp7UWNFz4tmFT6+g7qH9JXEvcIDR8wg8eJXTHLX7mAW+RM?=
 =?us-ascii?Q?KQL7q0Bl3CyCgWfBUyHkK0Yv5MyUd21oWWwhmwFe06FuldeL41TWJgZYjptr?=
 =?us-ascii?Q?Mrj6m1Dmoq1NGBd0vSxjK2RMFN88mgdvMX8FBar7fTCEHGyjwHOLmLlW821B?=
 =?us-ascii?Q?9A3xyjP3/i0Fi8mAImJAZ+utGhA0GYfeoABeRCNt9oACwO/3U6HjE4QQeaSZ?=
 =?us-ascii?Q?3NdBhE7k1Klp8qdfzLD6Z/Ff7J3G8j0ZGo6+0im9Nc4hcAWhBWeZwsZ9H+1l?=
 =?us-ascii?Q?Iw4LnwejDTkCVgi7GGyNp9kd72j0pTCQpOixxw+Bok62qR0z54xbWBej0+B0?=
 =?us-ascii?Q?fEYaIfHDzejfe7LwJmfDsjJPExGhxE7Q49cuST5wZ0lmY6sZBEOswFwwlAIL?=
 =?us-ascii?Q?Lm0JMcH4FIOi26tjGGFmBN2wWiCoP5uCPTIlw+FRDORvd4wCYdBlEg74cKG8?=
 =?us-ascii?Q?gcTQnYa9KdAEoUOAfwkubyGzerd7OiuZ7HU+1LcTZhq4Lp/+fD3prZQcwSRL?=
 =?us-ascii?Q?p84MEYTna7iRRADUIVonL4Gu5VkVfUKCW4++f8AxP8IpQzwvbc1gd1a9eL29?=
 =?us-ascii?Q?NNE0r4U35GWVlPGKChG0iFC9TeDtLtMXKWvr1aY9cojev4ixa4smSBAakAGv?=
 =?us-ascii?Q?udhaTJiY6vjSvycE4dSk6p1ABPcVgYjx5O/jo75jbNVAGGDv87zKLEBY5q3i?=
 =?us-ascii?Q?XaZcRswDzPMNAV7c2ILDa3pj9gCj1xs+x+r7gOOobNWlMCRcK9PdRWOVSiuV?=
 =?us-ascii?Q?9C19XEUBGHqlhw1REqE0BZVadsEv09UEm+2f/lizMw/FNnklWTK7Fq7KSTIh?=
 =?us-ascii?Q?a9aKytz8GcYHga/noOb3ucomFC/mOVPTPVk+p+6XEtXA8Fm1E8oRP5/YUsqX?=
 =?us-ascii?Q?GfM4hEDdH0j/VNEuHnTDBJsUS8tPiBs6q7cSeyxoN2C1OcTY85U9OenM4TNc?=
 =?us-ascii?Q?kI+1xgN8XnqrstNywTqsswNvLHaq7xe5TkfSljwPNlsb/kG2DAnPBpxOKclo?=
 =?us-ascii?Q?pGCyI3FoABTDhH3i94nJ20jxbwiwjpL/Z1YtCpoH/Epo1vBEKLeHsJMVWkQd?=
 =?us-ascii?Q?YcpopZ4637+CtVH1UYDRYeY+43RTmvdqs4U/ADSoSro/vfYxfVn4VjVuDdZC?=
 =?us-ascii?Q?6YaaxPP3oKDeOo6b/Xibg6gXwV0mjn+oZ5wFyp8F+m+O31MK1LRg9WZTqoM9?=
X-MS-Exchange-AntiSpam-MessageData-1: FIpWaReRB18m/A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f768f03c-f551-4831-99d7-08df06e5e7da
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 22:27:41.8647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2k0i5O4v5O3JTEwOLKFhhI1vom5D/fEiVoYq7OmZVBbP9A9JNgsJlmaEyVUP4BZ4CT8dDsK+iwq5x8N3Cym6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6374

Hi Steven,

Any progress on it? I still see linux/trace_printk.h in 7.3-rc1.

Thanks,
Yury

On Wed, Jun 24, 2026 at 04:18:06AM -0400, Steven Rostedt wrote:
> Remove trace_printk.h by creating a trace_controls.h for those places that
> need access to tracing prototypes like tracing_off() and for the places that
> need trace_printk() directly, to have it included directly.
> 
> Changse since v2: https://lore.kernel.org/all/20260622130739.375198646@kernel.org/
> 
> - Update change log in patch 1
> 
> - Remove #ifdef DEBUG and always include trace_printk.h in patch 2.
> 
> Steven Rostedt (2):
>       tracing: Move non-trace_printk prototypes into trace_controls.h
>       tracing: Remove trace_printk.h from kernel.h
> 
> ----
>  arch/powerpc/kvm/book3s_xics.c         |  1 +
>  arch/powerpc/xmon/xmon.c               |  1 +
>  arch/s390/kernel/ipl.c                 |  1 +
>  arch/s390/kernel/machine_kexec.c       |  1 +
>  drivers/gpu/drm/i915/gt/intel_gtt.h    |  1 +
>  drivers/gpu/drm/i915/i915_gem.h        |  2 ++
>  drivers/hwtracing/stm/dummy_stm.c      |  1 +
>  drivers/infiniband/hw/hfi1/trace_dbg.h |  1 +
>  drivers/tty/sysrq.c                    |  1 +
>  drivers/usb/early/xhci-dbc.c           |  1 +
>  fs/ext4/inline.c                       |  1 +
>  include/linux/ftrace.h                 |  2 ++
>  include/linux/kernel.h                 |  1 -
>  include/linux/sunrpc/debug.h           |  1 +
>  include/linux/trace_controls.h         | 54 ++++++++++++++++++++++++++++++++
>  include/linux/trace_printk.h           | 56 ++--------------------------------
>  kernel/debug/debug_core.c              |  1 +
>  kernel/panic.c                         |  1 +
>  kernel/rcu/rcu.h                       |  2 ++
>  kernel/rcu/rcutorture.c                |  1 +
>  kernel/trace/ring_buffer_benchmark.c   |  1 +
>  kernel/trace/trace.h                   |  1 +
>  kernel/trace/trace_benchmark.c         |  1 +
>  lib/sys_info.c                         |  1 +
>  samples/fprobe/fprobe_example.c        |  1 +
>  samples/ftrace/ftrace-direct-too.c     |  1 -
>  samples/trace_printk/trace-printk.c    |  1 +
>  27 files changed, 83 insertions(+), 55 deletions(-)
>  create mode 100644 include/linux/trace_controls.h
