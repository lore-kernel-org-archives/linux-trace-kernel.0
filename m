Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2458728D8ED
	for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Mar 2026 01:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774056811; cv=none; b=tbGQXx6Dys2icu9sdBiWnyaIwqtPlbvn0bTb8FnDb0k3/fikFuhd7LyILZPAoODzMqqEm+1MNcwQaA6lhe4k8FnbHYjT74CidS6IyZz0KXeBSWz+2a20/YTFOK/IWwHmB8PF/hOeNQlypmkpGtwMeEAZz/G0VKTtCz0pEe+0C5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774056811; c=relaxed/simple;
	bh=Y8JXVimRLZ64Bwl2u705Jy2oz3lBqjy5Q2qRrh/SeFk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=DHiI+qLwVWbUfV99qQ7U7QWhQUSWQSuSVZVrEXHm8WjJ1DH23A5ozgcMBB858zTMq5XUc13tAY13mgLg4wUhzjcpZNNLnA1o4qqivRF6druFPtDMR6fpDEO59cB03K7lyDvU9yHLNUFvalfZcshiFyi10NLd9mvsbSc7mL1ZH9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2whrGk8; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2whrGk8"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-829781b2b01so1500477b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Mar 2026 18:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774056809; x=1774661609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vqCvjJm0bWKZTBGX1/5T2XI0o4s04odjPkD7DfRdD1M=;
        b=B2whrGk84Mx1wVQ1VLTKN2wcbVlbRyNGOWKZ42JJGoyk57lwoaMI409FECee8ihgxD
         JTxRPqBBts8PKoBc/xXVUKujaVCDDMXwW3wKjsU8vQdQ3UORunZukXfWo1EjX2rdpZYi
         yeN2iI2so5FSPNNMHsZGlvbmSh6zlCLTWUVKV/dLqxHygrp67rLIse8zQVthIaqUsoTT
         B2ZLQel05ZonfTm88rzSUoS5MCOt009sBDUFBAQy3RFlzdvgcVVDZ8ZycRZlsgJyhph9
         he8euxAjXsEUIq+wfcBlR8mVtHxok0n1FPKrET6g+oIXQ48/gXxWQ4K1bB6fgCFxoVSB
         nENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774056809; x=1774661609;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vqCvjJm0bWKZTBGX1/5T2XI0o4s04odjPkD7DfRdD1M=;
        b=mZCrqJPP3z7XH4losVlgurvhHiLiFEYiOJTfCj5Jpl7U4A+E/KXCNooKrTAGWnPHRL
         pdVI0icSyLMi2aIOkmMDoJX8dWtvGjYXBfsrW4vOpTrH2cZCGtzbV/zTLzgXtsp14/56
         TTmPSiPW/1GW/uduZzi7yfq8yg+5pUpSQv3pU6QSJN5aTKmQ4eWbfM8FGVhKITV6Dtgb
         W/SwvazAH1vgnrL9BXM7CqJJNjvA2DGPMqZ6+bZ0FMR5Fx1nkBOAhDIDppqyllcvLAU2
         dbMp+d46k4Yn6PxlkcG8RNpsE01LTy5EU17P6ha9mmz0VRtMWxxMx9wrcEx1zf2+Gbwg
         Gc7A==
X-Forwarded-Encrypted: i=1; AJvYcCUeJk7QpRTL4HuhOsD/bhry84jvGP+NKSafZ5QEF0RhRwbxpDhjRnBlPK5yVzZASnZyPv3G6ysEvljc617FAu1g26w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAxyt/UIli03vV6tli9Pk14p94pqPxK5D2jklpOsYwKeiLDWZs
	4xiELlhEchjdsxxJPoe6gM3bcprwm+WimjmL2aIUXQ6DA7N+Ah237dTW
X-Gm-Gg: ATEYQzyoi5ZtcM4m7UYQwIvGzJzXcdmysSgD2qsEzh7DAX/c+FX3oe3Av1pihRK7HpX
	1Fshq0/val7xwdD6KM4Zn2SAYBOVPORuVU7xTXU2SyjPJflx5lV5wlbPzizIAox6GCNlkFClC9G
	Gaa8a/trofN6QVFEGuPP9mT1I7kch4YFU+jOaX3YwZyS4bUjXtbARMVPEGp60HfK4jLpnaBQIyn
	OIewvMCWK7xfYf3S5vf2vCH+0QMcxQbRcjnXWBJM73gcHRMyJG++n+OY5aTttFBcEL/k6/kB2j2
	Wx5TSQuov+rd1W/eHFGXgJLIiWMcGkfl8bRamP6nqDBpb5URsW538CeuWgCPP1FxftVlgUdC8sq
	WTLRuDGigVf2jYof9l2j4nsTPVL1+G7IyRAeaW05fjyV3FttqC4RZh8FYa2g/tiFbCtPn1AG2kX
	VtZJNBPwbQ+eAOhIvWATs5Sg==
X-Received: by 2002:a05:6a00:1397:b0:824:3bd9:aac6 with SMTP id d2e1a72fcca58-82a8c25fa6cmr4148762b3a.16.1774056809329;
        Fri, 20 Mar 2026 18:33:29 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03aa9fc6sm3253724b3a.7.2026.03.20.18.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 18:33:28 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Harry Yoo (Oracle)" <harry@kernel.org>, linuxppc-dev@lists.ozlabs.org
Cc: Harry Yoo <harry.yoo@oracle.com>, Nathan Chancellor <nathan@kernel.org>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Michal
 Clapinski <mclapinski@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Srikar Dronamraju <srikar@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com> 
Subject: Re: NULL pointer dereference when booting ppc64_guest_defconfig in QEMU on -next
In-Reply-To: <7a8faee8-0eb5-4e58-a6d5-ef711791e3f4@efficios.com>
Date: Sat, 21 Mar 2026 06:42:41 +0530
Message-ID: <h5qax9x2.ritesh.list@gmail.com>
References: <20260319233745.GA769346@ax162> <abzKcGiRSR_E8lLN@hyeyoo> <7780a471-9d99-40a7-ade7-0c4594ac36c7@efficios.com> <ab1J9ODkX5iChu-C@hyeyoo> <7458d8fd-5922-4e0b-9cd5-91880282aaa3@efficios.com> <7a8faee8-0eb5-4e58-a6d5-ef711791e3f4@efficios.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


++ linuxppc-dev

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:

> On 2026-03-20 09:31, Mathieu Desnoyers wrote:
>> On 2026-03-20 09:21, Harry Yoo (Oracle) wrote:
>>> On Fri, Mar 20, 2026 at 08:35:46AM -0400, Mathieu Desnoyers wrote:
>>>> On 2026-03-20 00:17, Harry Yoo wrote:
>>>> [...]
>>>>>> [1]: https://lore.kernel.org/20260227153730.1556542-4- 
>>>>>> mathieu.desnoyers@efficios.com/
>>>>>
>>>>> @Mathieu: In patch 1/3 description,
>>>>>> Changes since v7:
>>>>>> - Explicitly initialize the subsystem from start_kernel() right
>>>>>>     after mm_core_init() so it is up and running before the 
>>>>>> creation of
>>>>>>     the first mm at boot.
>>>>>
>>>>> But how does this work when someone calls mm_cpumask() on init_mm 
>>>>> early?
>>>>> Looks like it will behave incorrectly because get_rss_stat_items_size()
>>>>> returns zero?
>>>>
>>>> It doesn't work as expected at all. I missed that all users of 
>>>> mm_cpumask()
>>>> end up relying on get_rss_stat_items_size(), which now calls
>>>> percpu_counter_tree_items_size(), which depends on initialization from
>>>> percpu_counter_tree_subsystem_init().
>>>>
>>>> If you add a call to percpu_counter_tree_subsystem_init in
>>>> arch/powerpc/kernel/setup_arch() just before:

Even though powerpc is showing the warning because of VM_WARN_ON_ONCE(),
but this looks more of a generic problem, where use of mm_cpumask()
before and after percpu_counter_tree_items_size() could lead to
different results (as you also pointed above).

Looks like this is causing regressions in linux-next with warnings
similar to what Harry also pointed out. Do we have any solution for
this, or are we planning to hold on to this patch[1] and maybe even
remove it temporarily from linux-next, until this is fixed?

[1]: https://lore.kernel.org/all/20260227153730.1556542-1-mathieu.desnoyers@efficios.com/

[    0.000000] WARNING: arch/powerpc/mm/mmu_context.c:106 at switch_mm_irqs_off+0x1a0/0x1d0, CPU#2: swapper/0
[    0.000000] Modules linked in:
[    0.000000] CPU: 2 UID: 0 PID: 0 Comm: swapper Not tainted 7.0.0-rc4-next-20260317-00008-g5585e414f073 #4 PREEMPTLAZY
[    0.000000] Hardware name: IBM PowerNV (emulated by qemu) POWER10 0x801200 opal:v7.1 PowerNV
[    0.000000] NIP:  c00000000008f3b0 LR: c00000000008f330 CTR: c000000000090e20
[    0.000000] REGS: c000000003cb79b0 TRAP: 0700   Not tainted  (7.0.0-rc4-next-20260317-00008-g5585e414f073)
[    0.000000] MSR:  9000000002021033 <SF,HV,VEC,ME,IR,DR,RI,LE>  CR:24022224  XER: 00000000
<...>
[    0.000000] NIP [c00000000008f3b0] switch_mm_irqs_off+0x1a0/0x1d0
[    0.000000] LR [c00000000008f330] switch_mm_irqs_off+0x120/0x1d0
[    0.000000] Call Trace:
[    0.000000] [c000000003cb7c50] [0500210400000080] 0x500210400000080 (unreliable)
[    0.000000] [c000000003cb7cb0] [c0000000000ad850] start_using_temp_mm+0x34/0xb0
[    0.000000] [c000000003cb7cf0] [c0000000000ae8b8] patch_mem+0x110/0x530
[    0.000000] [c000000003cb7d70] [c000000000077f30] ftrace_modify_code+0x114/0x154
[    0.000000] [c000000003cb7dd0] [c00000000036a690] ftrace_process_locs+0x408/0x810
[    0.000000] [c000000003cb7ec0] [c0000000030584ec] ftrace_init+0x68/0x1c4
[    0.000000] [c000000003cb7f30] [c00000000300d3b8] start_kernel+0x680/0xc44
[    0.000000] [c000000003cb7fe0] [c00000000000e99c] start_here_common+0x1c/0x20

-ritesh
