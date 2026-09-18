Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6D852BE4D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Sep 2026 21:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766793; cv=none; b=ckMQObJvxf+1HZetJUUk04UR/rKjxq7jnSe2Yx2B6X6Z04dsMfUMvb9EvTg1/hNXFyR6yP/L6/1m+3ik/fTWxNpk32SISFoknKsSNGWGcXxctRgsMgV7i9wbhmET54P8FPvzB08glapq13DTHxuGjW3D4JZncoJRDODdRI4vBCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766793; c=relaxed/simple;
	bh=piQ/qmdh5vGrLseCH4oX99pnj7X0x5hoLNKV1iykz48=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=ZreTyyvZBSAYNVsKJdR8VKVSIMKGJXesKqtARQBMcWUfi8L+YUtLJkpiT4yd/N9skLt98eyM8oW2wLR7O9NRuIx+ErTb+LejVwkT3nhe1mRegpVBSoi5C99gJVFj1Cfrwztj+d+hjRVP7O9skPk9KN9TfGKnrpjZmr8ZC5rFFKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNTv6Alo; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNTv6Alo"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so515900a91.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Sep 2026 14:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789766791; x=1790371591; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D3SEXFUxByL8NwUA0aascO5krkdBelJ+D590uzi7yTc=;
        b=mNTv6AlosrVIQyufi0IV0pzu5f2qpw7mTvbw/ZeftIjGRqzWJwG564SNqOMJiA9Skc
         pY5EC+4gXprPKZGcqHneRSzrmRE7+VEtllgVYe8p18p+bQXz4vLWbnZU1TrszMLYmsfX
         EONOe3ElNqRi6MyIZgx+pBaKbj3a0yOBWdbS86doDISx+yoQGm0p1Tp5MqdM+FZlWzQp
         V77igpIA6SK1A89CZnbTSAnhHaRq11TJvZdMjQJiGVF36NUp8FfKonLRhMK1OMJ8w0X2
         GWpQEtG5y3o/XYUQoTBhYLGMoxM9v4DFFShUeJww4zPctYrMlmPdtBGLgTgm/IHVnuvs
         dScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789766791; x=1790371591;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D3SEXFUxByL8NwUA0aascO5krkdBelJ+D590uzi7yTc=;
        b=djjt57Ytc3Vqnz46+YBbIae+VOI6K67pRSNkYSIZdtjn+MKNHKdjzFpRZhA4wNowgq
         AOxL+SH18pq+pQyg37uJ6xCsv+mYiPJVR0eAU4jc5i6Y/XZu04hLZb8T/621xwv3UVdp
         yQWK3fjp3CpWlQhEDWx5bN6s7MQAOEqvxmCMsUa315TGrT3J7MBlWHYBkJUqKqzhl5s3
         EFYiBVYkhIkplEycuiEq5yAs+oR5V2O/5BzMx7Pp6X+mKedHvPpJb63riyeuer5O0/Ua
         hI9DsmhDhF7C61GY7GoMM7mjuLQGwhh8nOCmchIihaNKOw8CIeu1dSy4O6v0GIjVtIwN
         8jBA==
X-Forwarded-Encrypted: i=1; AKwUvBzEWYMdyIZXdD/iwh9sWKtCA/ym2Y/APWyzKqs2MgyKS62rIhGs8OrEoiYTX0ujGVfT220QzfFKFRwzTGjfP6JuQkI=@vger.kernel.org
X-Gm-Message-State: AFuF++nV6SBgxLi6eFhvk01AkHQkr2L8BvKGZ6P4nm6LnNluHgWjksx6
	wnnSlL4VsVh+n4219m3FRcF0rNYp7iEhvZsXjYrKFPfFJRP3oE5ofWCe
X-Gm-Gg: AYBFou2AFTl9Aj7yrN1A4S9GsSoIpljOS/I7Ah2l1tQAqjUjsE8V/KitPpP4SrGSQrI
	eezTyjLN/C+NRilvXrU4rt0XRF/97cIxWzZh39z2Odj95fXpxwxrFeuk7hwORnize+8gCvNxYLI
	SWidiiI9CkXQH/Mb1mxbGMc4cLtvWNMzevkLuwdE/O67Z09OnQ6vIsZ3FRBBfftZNO7S5NE4mD6
	KG58Abd4+sBeLk3vZfkUz6XILWfP9YbzYlDtmgY+XsjzPjzJHRBUdqmhh1c4v8DRJpHrXxhSEdI
	sm38cocJfXz0luAmSaBV7wlu4xv6FkaA0BCn7pxa/8W+nBJRXzqD55myxrS0qKAShZE1/8MNiL1
	zDMlRfkrcxKuu1PH/q5xYPQzM27/Ev90d2vGgxOO/fgBSRsihAEsnI/lqIMInV/7B0aw+vGPtwv
	bXbOA1LjOxXgys3qIy0r5sykQw2uN74505/ErwMYhobPAftPL/Y59UNCXaUJTA2Pi4RLEFYffFV
	Djxv8d5g2675SvCJKketHhiO99iUR+OYs7kdzjf3RnaukWaCaDyjkT7N2aRYQondO6PJfME43Z7
	dscW
X-Received: by 2002:a17:90b:2584:b0:39e:6c68:fd89 with SMTP id 98e67ed59e1d1-39e6c68feb9mr902813a91.30.1789766791008;
        Fri, 18 Sep 2026 14:26:31 -0700 (PDT)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cb427casm1165720a91.17.2026.09.18.14.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 14:26:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Sep 2026 21:26:29 +0000
Message-Id: <DLIRDKA6G2IQ.2Q62BXX7CJWIW@gmail.com>
Subject: Re: [PATCH RFC v4 07/13] bpf, x86: Take a Tasks Trace reader in the
 trampoline around its call-outs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Josef Bacik" <josef@toxicpanda.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, "Frederic Weisbecker" <frederic@kernel.org>, "Neeraj
 Upadhyay" <neeraj.upadhyay@kernel.org>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Boqun Feng" <boqun@kernel.org>, "Thomas Gleixner"
 <tglx@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>, "Jiri Olsa" <jolsa@kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 <x86@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, "Puranjay Mohan" <puranjay@kernel.org>, "Xu
 Kuohai" <xukuohai@huaweicloud.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, "Frederic Weisbecker" <frederic@kernel.org>, "Neeraj
 Upadhyay" <neeraj.upadhyay@kernel.org>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Boqun Feng" <boqun@kernel.org>, "Thomas Gleixner"
 <tglx@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>, "Jiri Olsa" <jolsa@kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 <x86@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, "Puranjay Mohan" <puranjay@kernel.org>, "Xu
 Kuohai" <xukuohai@huaweicloud.com>
Cc: "Andy Lutomirski" <luto@kernel.org>, "Josh Triplett"
 <josh@joshtriplett.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, "Lai Jiangshan"
 <jiangshanlai@gmail.com>, "Zqiang" <qiang.zhang@linux.dev>, "Juergen Gross"
 <jgross@suse.com>, "Luis Chamberlain" <mcgrof@kernel.org>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, <linux-kernel@vger.kernel.org>,
 <rcu@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <xen-devel@lists.xenproject.org>, "Andy Lutomirski" <luto@kernel.org>,
 "Josh Triplett" <josh@joshtriplett.org>, "Uladzislau Rezki"
 <urezki@gmail.com>, "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Lai Jiangshan" <jiangshanlai@gmail.com>, "Zqiang" <qiang.zhang@linux.dev>,
 "Juergen Gross" <jgross@suse.com>, "Luis Chamberlain" <mcgrof@kernel.org>,
 "Ihor Solodrai" <ihor.solodrai@linux.dev>, <linux-kernel@vger.kernel.org>,
 <rcu@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <xen-devel@lists.xenproject.org>
X-Mailer: aerc 0.17.0
References: <20260918-b4-rcu-tasks-preempt-qs-v4-0-63f0e9d69661@toxicpanda.com> <20260918-b4-rcu-tasks-preempt-qs-v4-7-63f0e9d69661@toxicpanda.com>
In-Reply-To: <20260918-b4-rcu-tasks-preempt-qs-v4-7-63f0e9d69661@toxicpanda.com>

On Fri Sep 18, 2026 at 2:49 PM UTC, Josef Bacik wrote:
> On HAVE_RCU_TRAMPOLINE_READERS kernels Tasks RCU keeps a BPF trampoline
> image allocated only while a task using it is a Tasks Trace RCU reader
> or is executing text that rcu_tasks_trampoline_text() recognises.  The
> image itself is such text, but the C glue and the programs it calls are
> not, and only sleepable programs take rcu_read_lock_trace() today.
>
> Have the x86-64 JIT open-code rcu_read_lock_trace() and
> rcu_read_unlock_trace() in the trampoline, as ftrace_64.S does for
> ftrace_caller: one reader from just after the frame is set up to just
> before the original function is called, covering __bpf_tramp_enter()
> and the fentry and fmod_ret programs, and a second one from just after
> the original function returns to just before the final register
> restore, covering the fexit programs and __bpf_tramp_exit().  The
> original function itself runs outside both, since it may run for a long
> time and the image is pinned by im->pcref across it.  Trampolines that
> do not call the original function get a single reader around all their
> programs.  The second reader is entered before ip_after_call, so the
> ip_after_call -> ip_epilogue jump that bpf_tramp_image_put() patches in
> is inside it, and the fmod_ret early-exit branch lands after that point
> still holding the first reader, so exactly one is held on every path.
>
> The sequence uses r10 and r11, which are scratch at each emission point,
> and references current_task and rcu_tasks_trace_srcu_struct by absolute
> sign-extended address, the form the JIT already relies on for
> this_cpu_off.  Sleepable programs' own rcu_read_lock_trace() simply
> nests.  Nothing is emitted on other configurations.
>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 113 ++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 113 insertions(+)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 2853e87797a7..c991f7ceacdf 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -14,6 +14,7 @@
>  #include <linux/memory.h>
>  #include <linux/sort.h>
>  #include <linux/execmem.h>
> +#include <linux/rcupdate_trace.h>
>  #include <asm/extable.h>
>  #include <asm/ftrace.h>
>  #include <asm/set_memory.h>
> @@ -722,6 +723,97 @@ static void emit_indirect_jump(u8 **pprog, int bpf_r=
eg, u8 *ip)
>  	*pprog =3D prog;
>  }
> =20
> +/*
> + * Open-coded rcu_read_lock_trace() / rcu_read_unlock_trace() for the
> + * trampoline, see CONFIG_HAVE_RCU_TRAMPOLINE_READERS and the equivalent
> + * macros in arch/x86/kernel/ftrace_64.S.  The image is not relocated, s=
o
> + * current_task and rcu_tasks_trace_srcu_struct are referenced by absolu=
te
> + * (sign-extended 32-bit) address, the form the JIT already relies on fo=
r
> + * this_cpu_off.  Uses r10 and r11, which are scratch at every emission
> + * point, and clobbers flags.
> + *
> + * lock:                                  unlock:
> + *   mov  r11, gs:[current_task]            mov  r11, gs:[current_task]
> + *   mov  r10d, [r11+nesting]               mov  r10d, [r11+nesting]
> + *   inc  dword ptr [r11+nesting]           sub  r10d, 1
> + *   test r10d, r10d                        jnz  2f
> + *   jnz  1f                                mov  r10, [r11+scp]
> + *   mov  r10, [&srcu.srcu_ctrp]            mov  dword ptr [r11+nesting]=
, 0
> + *   inc  qword ptr gs:[r10+locks]          (smp_mb)
> + *   mov  [r11+scp], r10                    inc  qword ptr gs:[r10+unloc=
ks]
> + *   (smp_mb)                               jmp  3f
> + * 1:                                     2: mov [r11+nesting], r10d
> + *                                        3:
> + */
> +static void emit_trace_rcu_reader(u8 **pprog, bool lock)
> +{
> +#ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
> +	const u32 nesting =3D offsetof(struct task_struct, trc_reader_nesting);
> +	const u32 scp =3D offsetof(struct task_struct, trc_reader_scp);

nesting_off ?
scp_off ?
Otherwise
EMIT(nesting, 4);
is a bit confusing.

> +	const bool mb =3D !IS_ENABLED(CONFIG_TASKS_TRACE_RCU_NO_MB);
> +	u8 *prog =3D *pprog;
> +
> +	BUILD_BUG_ON(IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE));
> +	BUILD_BUG_ON(offsetof(struct srcu_ctr, srcu_locks) !=3D 0);
> +	BUILD_BUG_ON(offsetof(struct srcu_ctr, srcu_unlocks) !=3D 8);

Looks too hardcoded here.
Why not to use the same approach as with offsetof() few lines above?

Overall looks ok,
but I wonder what Paul will say that rcu_read_lock_tasks_trace()
becomes baked in into JITs and will be pretty hard to change.

We also lose rcu_tt lockdep runtime checks.
So lockdep might get confused?

