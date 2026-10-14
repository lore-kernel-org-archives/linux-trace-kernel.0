Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559E941167C;
	Wed, 14 Oct 2026 05:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791955544; cv=none; b=p7neV5YfwHkyVJ4fAebiYA2l+TKi9NOTVCcm/+7YgbvhG6tLf14DAbD5hJa0AdpHzQ3b8sb9sllDoxk1JsqVq50xCXoxYBDtfhz9JPOCdSu4K5bBOCADxvce8cB4E+Cv9eNmghtXiY/72oFVD5/RUyMaL6tHRBOUd+RIwsaUeEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791955544; c=relaxed/simple;
	bh=8/pCrTw/Ede9+/lc8WTa2hqBMx9lC8NaiuphEoXugVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIEXhXFb7HfSZwv7Nj2fkp9IvOA+QD0vEpK6HXUX5guCm9a6orWVtG852n0yI4GfswKG9SeyZf6CwgnwjanTqUmuNcf4mwOtkTSvB35D9QH8WrftJkelP6CAh55o1VCAfPZUwxbHlfNlWzPY6xf0sZGSyL+5FRQpghZ6K1OFgYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3ahMGIe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3ahMGIe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB1B1F000FF;
	Wed, 14 Oct 2026 05:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791955542;
	bh=aXCCCDypuupGF7xcMNEIX5ucvCzlOjmFSt6AeqCLDv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S3ahMGIe/aIexyDKE8juGdi7b9fK7QTl5CVlAHvXvBPz7Hjh/tm+u0uSKKLmFL8xW
	 9nN2IJhx5PeqGj5v38IkNP1I7QNPJeNUKR/l5Eu0F4Cne7SQqnLdzrt28YtLeqzNz7
	 2w74u0Dd/RtZqB6LcLxXE4g0JfdFikIwdetYwqgQ3pvVnEEx1OjgYUtu0PxTc1AaoD
	 I06eLdl0xGE6w8Ep8+8Wywp0HNba5XW4JN+aSsYs0Gpe4pNIZkfhyy024ON5wZq/Aw
	 nF3gKpGRhAytuSugOSL7n1Q0ONeW6vgKevSCCPcu0H7lL/zvb+cXYSbEyioU4oVMmG
	 ZN2dm9XGlkBrQ==
Date: Wed, 14 Oct 2026 13:05:41 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Roman Storozhenko <romeusmeister@gmail.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: mm: Trace TLB flush path selection
Message-ID: <as8NpaT0g9Tsl6PS@xhacker>
References: <20260830-tlb_tracepoint-v2-1-e3c88c24df5b@gmail.com>
 <ar_Rathmoj2aP-H7@xhacker>
 <CALsPMBOYQbro2gZTQR=DSUowmVDs9kujH4ua2UzCoHAQrncuiw@mail.gmail.com>
 <asm95GdbmMpc81p3@xhacker>
 <CALsPMBPMHc7q-YZvqLLYDSr5RfLmDRwBSq-TFeB8Fc8bPBjQGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALsPMBPMHc7q-YZvqLLYDSr5RfLmDRwBSq-TFeB8Fc8bPBjQGg@mail.gmail.com>

On Sun, Oct 11, 2026 at 02:43:05PM +0200, Roman Storozhenko wrote:
> On Sat, Oct 10, 2026 at 6:44 AM Jisheng Zhang <jszhang@kernel.org> wrote:
> >
> > On Sat, Oct 03, 2026 at 10:54:44AM +0200, Roman Storozhenko wrote:
> > > On Fri, Oct 2, 2026 at 6:04 PM Jisheng Zhang <jszhang@kernel.org> wrote:
> > > >
> > > > On Sun, Aug 30, 2026 at 04:36:37PM +0200, Roman 'Hedin' Storozhenko wrote:
> > > > > Make RISC-V TLB flush path selection observable. Record whether Linux
> > > > > handles an invalidation locally, delegates it to SBI RFENCE, or executes
> > > > > it through a cross-CPU call, so MM activity can be correlated with the
> > > > > RISC-V, firmware, or Linux cross-CPU path carrying the request.
> > > >
> > > > I didn't see too much usefullness of the trace here. why not use kprobe
> > > > instead? can you plz show a real usage example of the trace? Which
> > > > bug/performance problem can be solved conveniently with this trace only?
> > > >
> > > > From another side, except x86, other architectures don't have the trace
> > > > in the TLB path.
> > > >
> > >
> > > Hi Jisheng,
> > >
> > > Thanks for the review. I agree that the current commit message describes
> > > the intended use rather abstractly.
> > >
> > > A kprobe can certainly be used to investigate this. My motivation
> > > for a tracepoint is not that dynamic tracing cannot obtain the
> > > information, but that doing so requires knowledge of the current
> > > implementation and reconstruction of a semantic decision made inside
> > > __flush_tlb_range() / flush_tlb_all().
> >
> > I prefer aligning with other architectures(except x86), I.E not
> > add this kind of trace. However, I would leave the decision to riscv
> > maintainers.
> >
> > FYI, you may notice that the riscv trace overhead is not trivial per
> > https://lore.kernel.org/linux-riscv/20250619190315.2603194-4-rkrcmar@ventanamicro.com/
> 
> Hi Jisheng,
> 
> Thanks for the feedback.
> 
> Regarding the comparison with other architectures, thanks to Michael
> Ellerman for pointing me to the PowerPC TLB tracing when we happened
> to discuss this at LPC 2026.
> 
> PowerPC defines the powerpc:tlbie and powerpc:tlbia trace events in
> arch/powerpc/include/asm/trace.h, and the corresponding trace calls
> are used in the PowerPC TLB invalidation paths.
> 
> These events are not identical to the proposed RISC-V event: the
> PowerPC events primarily describe architecture invalidation
> operations, whereas this patch records the path selected by Linux
> before dispatch. However, I think they provide useful precedent for
> architecture-specific TLB observability beyond x86.
> 
> Regarding kprobes, I agree that dynamic tracing can be used to investigate this.
> 
> My concern is that obtaining the same information requires knowledge
> of the current implementation and reconstruction of the decision made
> inside __flush_tlb_range() / flush_tlb_all().
> 
> For example, probing __flush_tlb_range() gives us the incoming
> request, but does not directly tell us whether Linux selected the
> local flush, SBI RFENCE, or cross-CPU-call path. A tracing tool has to
> probe and correlate implementation-specific downstream functions, or
> reproduce the selection logic itself.

Hmm, let's look at where the tracepoints added:
void __flush_tlb_range(struct mm_struct *mm,
                              const struct cpumask *cmask,
                              unsigned long start, unsigned long size,
                              unsigned long stride)
void flush_tlb_all(void)

most of the information you exported with the tracepoints are just
parameters of flush_tlb_range.
So kprobe or function trace can also get most of them, while whether
local or not needs to calcuate the cmask, but getting this info is
also easy via. adding one LoC to the kprobe routine.

The tlb invalidation is frequently executed, so we need to carefully
evaluate the convience VS maitanince offort and performance overhead when
adding permanent tracepoints, given current riscv tracepoint overhead
isn't trivial.

BTW: whether SBI RFENCE or cross-cpu-call is much easier. Just search
IPI in /proc/interrupts. No need to kprobe/function trace/tracepoint

> 
> The proposed event records this semantic decision directly at the
> point where Linux makes it. Users therefore do not need to depend on
> the current helper names, call graph, or exact implementation of the
> selection logic.
> 
> Regarding the tracepoint overhead issue, I agree that disabled-path
> overhead is important, especially in the TLB flush path.
> 
> However, I see the referenced SBI tracepoint case primarily as a
> RISC-V compiler/code-generation issue rather than as an argument
> against providing this kind of observability.
> 
> The referenced discussion itself shows that the generated code depends
> significantly on compiler behavior, and that this is an area being
> improved. The undesirable overhead is not an inherent semantic
> requirement of the tracepoint.
> 
> Even if the same code-generation problem currently affects this
> tracepoint, I don't think a temporary compiler limitation should by
> itself determine whether the tracepoint is useful or whether this
> observability belongs in the kernel.
> 
> If the compiler currently generates unacceptable disabled-path
> overhead, that is certainly something that should be improved or
> mitigated in the implementation. But I would separate that issue from
> the question of whether exposing the RISC-V TLB path-selection
> decision is useful.
> 

But we need to live with it. Per the Radim email, gcc14 can still
see the issue, given the minimum gcc version of kernel building
requirement is gcc8 now, gcc14 has a long time to bailout.

And another tricky point here is
one of your motivations of adding the tracepoint is to profile then
improve the tlb related code path performance, but adding the
tracepoint brings non-trivial overhead to tlb code path.
