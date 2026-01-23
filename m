Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB482EB876
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Jan 2026 12:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769170343; cv=none; b=Tx2s/pIgVeuAtaGfvdQXyP/FMLoXNuitbUohd/OWE5dHROWu7fKQrZIU5gKU+K4G/7N/q2noLVNk9pQKBLBSTK+4kHhHTBdVlbPNv6wDfjLV3AGJGP3+u7ax1bYdcXR0t38gAnPluOAS3uH+IL56c69eI0agyoL8sxc+QA/awUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769170343; c=relaxed/simple;
	bh=mJnGfSnNZnYvNd/hH7XFW2DTHO9jL/r2IVbPDgGEdck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5tlZjEfSBXmXw8Gi6Iug1EYAhu/DEAZaYBCvJGE0vz1tPh/1YMYCJ71ghF7SGHkponCgHQJ4dGLS1bs4FX81roCpL0u/fS74aI7T1hJaR6SFRK84RYeeEvump3JkKKoent7eExOiE63mf1Y2Rke90Ul32iQ5tFR72Qrnp9WC2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S06Qe1fJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S06Qe1fJ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4801c731d0aso16736915e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Jan 2026 04:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769170340; x=1769775140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mJfSzpptsvgNQ0mCpYmk8DIXrBhJMmuZV4W80Mdql0g=;
        b=S06Qe1fJRHnsJZj5Jtkq0CMISWEcQQBtc9arb8GtYxYB0N+nsUK90xgun6Kw7r9jxB
         rMSkgkqt4El/CMQi9Pmtc+pgti9tFf6xUjTzL4Q2PJhB/A0/N/Aw6qqm5CQiL32bGgeX
         JpV2H5sFB+1AyYmqgCCso4HnrVNZuwZt+ThNYf0jzXvZCdq7+VCZAPyUqWii+UXexsNR
         1btVzirWVa8QncouXcNeZa9YDfXmpd8Cz16ShcRL4zWR+80IPB5KTybTiM6VsB8MtYsz
         O/j2mqUwLLgaA1EFB71gKAaRLbuOtYxNyYKFHGeMWKi02avZpCdK1iVBP/J6Bgl7nqrU
         Riog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769170340; x=1769775140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJfSzpptsvgNQ0mCpYmk8DIXrBhJMmuZV4W80Mdql0g=;
        b=kLhWFmujSQgTrM+eIxixrEsbBTpCL4Iqc8eR7vHz7WwQR6Yrz9Kh3pv1mvREqkzgxl
         UFQb8BFhfculkDoDV18F45Z8GtMkTKuRalOFLiCZ10mSy7tTCHCEwAoK3frNeCKHVpsy
         AVUmdpgpKjs2xDynNkRexPYmKKAwZFTzZ0hqqcjy/rr/2yVL9hfZJIy3+ATTayTxShJ7
         +bqD0PtfapIFSp3A/jWtyaageHDk0esYqXAaSWLHT5U9OPJzuHoOgZ5gK2aP86YX2mxK
         WRA63nJ4MUVsO6aj5awWHmxttDjjg4eiVpZH3Zumane63gLYFa2xO+fh0uosMVcI1f21
         OHlA==
X-Forwarded-Encrypted: i=1; AJvYcCVmNrniZxKiNnDEkJb+cUK+IiwC149YsJzGK4T7fwPK+FR1YNcZ9TjaNkixfjUSS2bfDVvWdL0tPvSU24QwAfdDlg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQZSwqyrB0jQjHYMYaaTPrN+9n6gy5avqe2qXjAO/6zjp/TI+d
	1S6DV6BWfRzakJGEOUUPt9J1zwndvfDUHtdLeUCei3WmX9XJfRjIPILkZ6mYaNmFZA==
X-Gm-Gg: AZuq6aK7AMg7EQtTlHpk1GT6uwfFV0UHr0jFHfO9IwkSX5rqLMPFXNq9kiqpYaOLZJg
	Jjo85G3eO0v59LLd3lhdoqtD3f5GSYjMkUwe4/ZzkjbPMN14Z2tcdLQ+NV2oUkgtaOpqmMxV9lE
	7EOY0x8sKpDi1KYeoC1A6lUBiuSxRDfzAUFZK35SK4v3xuzCQMrnk/MGGMxTY77UNYlJOM/9s5h
	PrG+zUI6CQHqBHYgxHk47p6eQqflrtLLY9oS1gzFDvQnAaF44HUvQPFVJMIwbCecb4UIPhU4uK/
	y8SyfLf2MwuyN0FUc3awymFR/qeBctiq4ew97IVFJLGceSoeRvvkRSrkegAP6JdQcK7tQ+b6Hyi
	7q9t1QipYMlFdwpuvj1ekBP+e5Kup2mjFKgoIdyeOFFQoCc5VpYFGijO1Sk39Z5hIqyrKJBGCQE
	vydt2n6QxnniCG8rn0LRlv/APTOTmtFU9E7FyznJWDc7+r1T4Xog==
X-Received: by 2002:a05:600c:5253:b0:47a:8154:33e3 with SMTP id 5b1f17b1804b1-48051256401mr19426385e9.28.1769170339674;
        Fri, 23 Jan 2026 04:12:19 -0800 (PST)
Received: from google.com (44.145.34.34.bc.googleusercontent.com. [34.34.145.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d8a5b67sm47732645e9.10.2026.01.23.04.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 04:12:19 -0800 (PST)
Date: Fri, 23 Jan 2026 12:12:15 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jstultz@google.com,
	qperret@google.com, will@kernel.org, aneesh.kumar@kernel.org,
	kernel-team@android.com, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	"Christopher S. Hall" <christopher.s.hall@intel.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v9 25/30] KVM: arm64: Sync boot clock with the nVHE/pKVM
 hyp
Message-ID: <aXNln7dzZzf-iGGI@google.com>
References: <20251202093623.2337860-1-vdonnefort@google.com>
 <20251202093623.2337860-26-vdonnefort@google.com>
 <86bjj5mrhn.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86bjj5mrhn.wl-maz@kernel.org>

On Wed, Jan 07, 2026 at 02:23:16PM +0000, Marc Zyngier wrote:
> On Tue, 02 Dec 2025 09:36:18 +0000,
> Vincent Donnefort <vdonnefort@google.com> wrote:
> > 
> > Configure the hypervisor tracing clock with the kernel boot clock. For
> > tracing purposes, the boot clock is interesting: it doesn't stop on
> > suspend. However, it is corrected on a regular basis, which implies the
> > need to re-evaluate it every once in a while.
> > 
> > Cc: John Stultz <jstultz@google.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Christopher S. Hall <christopher.s.hall@intel.com>
> > Cc: Richard Cochran <richardcochran@gmail.com>
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > 
> > diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> > index f83650a7aad9..375607c67285 100644
> > --- a/arch/arm64/include/asm/kvm_asm.h
> > +++ b/arch/arm64/include/asm/kvm_asm.h
> > @@ -93,6 +93,7 @@ enum __kvm_host_smccc_func {
> >  	__KVM_HOST_SMCCC_FUNC___tracing_unload,
> >  	__KVM_HOST_SMCCC_FUNC___tracing_enable,
> >  	__KVM_HOST_SMCCC_FUNC___tracing_swap_reader,
> > +	__KVM_HOST_SMCCC_FUNC___tracing_update_clock,
> >  };
> >  
> >  #define DECLARE_KVM_VHE_SYM(sym)	extern char sym[]
> > diff --git a/arch/arm64/kvm/hyp/include/nvhe/trace.h b/arch/arm64/kvm/hyp/include/nvhe/trace.h
> > index 7da8788ce527..fd641e1b1c23 100644
> > --- a/arch/arm64/kvm/hyp/include/nvhe/trace.h
> > +++ b/arch/arm64/kvm/hyp/include/nvhe/trace.h
> > @@ -11,6 +11,7 @@ int __tracing_load(unsigned long desc_va, size_t desc_size);
> >  void __tracing_unload(void);
> >  int __tracing_enable(bool enable);
> >  int __tracing_swap_reader(unsigned int cpu);
> > +void __tracing_update_clock(u32 mult, u32 shift, u64 epoch_ns, u64 epoch_cyc);
> >  #else
> >  static inline void *tracing_reserve_entry(unsigned long length) { return NULL; }
> >  static inline void tracing_commit_entry(void) { }
> > @@ -19,5 +20,6 @@ static inline int __tracing_load(unsigned long desc_va, size_t desc_size) { retu
> >  static inline void __tracing_unload(void) { }
> >  static inline int __tracing_enable(bool enable) { return -ENODEV; }
> >  static inline int __tracing_swap_reader(unsigned int cpu) { return -ENODEV; }
> > +static inline void __tracing_update_clock(u32 mult, u32 shift, u64 epoch_ns, u64 epoch_cyc) { }
> >  #endif
> >  #endif
> > diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > index 8b78b29c2069..45b8f70828de 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > @@ -613,6 +613,18 @@ static void handle___tracing_swap_reader(struct kvm_cpu_context *host_ctxt)
> >  	cpu_reg(host_ctxt, 1) = __tracing_swap_reader(cpu);
> >  }
> >  
> > +static void handle___tracing_update_clock(struct kvm_cpu_context *host_ctxt)
> > +{
> > +	DECLARE_REG(u32, mult, host_ctxt, 1);
> > +	DECLARE_REG(u32, shift, host_ctxt, 2);
> > +	DECLARE_REG(u64, epoch_ns, host_ctxt, 3);
> > +	DECLARE_REG(u64, epoch_cyc, host_ctxt, 4);
> > +
> > +	__tracing_update_clock(mult, shift, epoch_ns, epoch_cyc);
> > +
> > +	cpu_reg(host_ctxt, 1) = 0;
> 
> What's the purpose of setting X1 to 0? This is a call returning void,
> so I don't immediately see the need for this.

Hum, nope nothing. And actually the same applies to __tracing_write_event() and
__tracing_unload()

> 
> > +}
> > +
> >  typedef void (*hcall_t)(struct kvm_cpu_context *);
> >  
> >  #define HANDLE_FUNC(x)	[__KVM_HOST_SMCCC_FUNC_##x] = (hcall_t)handle_##x
> > @@ -658,6 +670,7 @@ static const hcall_t host_hcall[] = {
> >  	HANDLE_FUNC(__tracing_unload),
> >  	HANDLE_FUNC(__tracing_enable),
> >  	HANDLE_FUNC(__tracing_swap_reader),
> > +	HANDLE_FUNC(__tracing_update_clock),
> >  };
> >  
> >  static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
> > diff --git a/arch/arm64/kvm/hyp/nvhe/trace.c b/arch/arm64/kvm/hyp/nvhe/trace.c
> > index df9d66fcb3c9..97e9f6c1a52c 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/trace.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/trace.c
> > @@ -271,3 +271,19 @@ int __tracing_swap_reader(unsigned int cpu)
> >  
> >  	return ret;
> >  }
> > +
> > +void __tracing_update_clock(u32 mult, u32 shift, u64 epoch_ns, u64 epoch_cyc)
> > +{
> > +	int cpu;
> > +
> > +	/* After this loop, all CPUs are observing the new bank... */
> > +	for (cpu = 0; cpu < hyp_nr_cpus; cpu++) {
> > +		struct simple_rb_per_cpu *simple_rb = per_cpu_ptr(trace_buffer.simple_rbs, cpu);
> > +
> > +		while (READ_ONCE(simple_rb->status) == SIMPLE_RB_WRITING)
> > +			;
> > +	}
> > +
> > +	/* ...we can now override the old one and swap. */
> > +	trace_clock_update(mult, shift, epoch_ns, epoch_cyc);
> > +}
> > diff --git a/arch/arm64/kvm/hyp_trace.c b/arch/arm64/kvm/hyp_trace.c
> > index 2866effe28ec..1e5fc27f0e9d 100644
> > --- a/arch/arm64/kvm/hyp_trace.c
> > +++ b/arch/arm64/kvm/hyp_trace.c
> > @@ -4,15 +4,133 @@
> >   * Author: Vincent Donnefort <vdonnefort@google.com>
> >   */
> >  
> > +#include <linux/cpumask.h>
> >  #include <linux/trace_remote.h>
> > +#include <linux/tracefs.h>
> >  #include <linux/simple_ring_buffer.h>
> >  
> > +#include <asm/arch_timer.h>
> >  #include <asm/kvm_host.h>
> >  #include <asm/kvm_hyptrace.h>
> >  #include <asm/kvm_mmu.h>
> >  
> >  #include "hyp_trace.h"
> >  
> > +/* Same 10min used by clocksource when width is more than 32-bits */
> > +#define CLOCK_MAX_CONVERSION_S	600
> > +/*
> > + * Time to give for the clock init. Long enough to get a good mult/shift
> > + * estimation. Short enough to not delay the tracing start too much.
> > + */
> > +#define CLOCK_INIT_MS		100
> > +/*
> > + * Time between clock checks. Must be small enough to catch clock deviation when
> > + * it is still tiny.
> > + */
> > +#define CLOCK_UPDATE_MS		500
> 
> If these definitions are common, can't we reuse the existing ones?
> Specially given that this isn't EL2 code.

Only the first is reused but it doesn't exist any definition for it.

> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
