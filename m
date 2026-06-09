Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65C23E3C50
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Jun 2026 07:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991066; cv=none; b=rBKZH3wMrMjizooRhk1vqhLLLe3dN5Juyuk77CWd96BvsK7rN5pb209sh2QaeGIrXaZt/6ygNlFDy7BjpTqlQRYfVhPCjmqMYtaZuPKcgnsvwUf6DF7J3w9WanatVfBAUt+dpj1ZwaqgxnOW1hVG+M82MihuoeOMXJtNlpjl70s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991066; c=relaxed/simple;
	bh=KMt/9yPMor0sSrdW2kpxbF2/UobDqTgWKs/d9cQJ52Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYJpWK5xS7IklpCo7CyQG/IPG0AxegwTOiwHmhV81TbfXg3woUdWTd2jjbJg0i4sVsFS8DV/nmvUBLmEM9KAew1bv89QJOflfZywi0MyqAO7K4nvHm2Ti96tq51kM/Oih+if76ZCo1WCIPbhTMniezeIrKiwHo+bbENGBQDxmkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6TCR6is; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6TCR6is"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DB01F0089A
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Jun 2026 07:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780991063;
	bh=YBycYasDaIV1c55FVXytnKgd6uGrMzPwBTTo4/YfmGc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=W6TCR6isYeRRhaBuLbcGdSB06481pxkt/XDrRlvKMCbmbCXQFdz65l6jiCBbcmMgk
	 VyS5Uztuk0v0nHwlIggl6pqV3DE3N2Z7krlX8E8vGr/FHHhtmUMYmis2NSE43lJY37
	 cUUnCnYAzekKI9/L71IUsXpcs0PcmafWyKBRk3Niu1KIeT7JODq8Vu5ggaCnNOqVZQ
	 9n7JsCUs6weT9ATOVMbOJ5MFdPKSyJdBCDeKp7q36FMzZGQFmHy60RrqqW2lHleCuY
	 /wcBFHtQsB3zE/N5z8jlQC16Q7jN/f02nPfbxwArPUN/V6gYczjLF8FrwEralkSVC3
	 7fdOeJbDFWE6A==
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-915d64fead9so173534585a.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Jun 2026 00:44:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/jETI7ZqWggEB52VENW3I5ydKz+mc2a3mqB+62Ta7HbGn2dWZvUjTsGwo8ACcPerIOLzA6Xce5mthQPOQ1tqBXsRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb4R7SfnRo0rFanyVIrENmbqw3MtoJT6NkoashCt1rmuUvJ/kr
	A74yujULkv+Z7W0+QWWtBl2/xjEPiOsqbqsC+lJIcGnDHO48KCv6a3pX+KnWpqHaqjeLLZ+d+vj
	2K27Boh0RpMdqAnk1D+YrnhICYtIM9zM=
X-Received: by 2002:a05:620a:4608:b0:8cd:9281:6be9 with SMTP id
 af79cd13be357-915ad30dda2mr2118273885a.31.1780991062278; Tue, 09 Jun 2026
 00:44:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609041156.31127-1-jp.kobryn@linux.dev>
In-Reply-To: <20260609041156.31127-1-jp.kobryn@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Tue, 9 Jun 2026 15:44:11 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4xk2Q3xTkQYMPb7rnvnvVsjp24uXRcOja5RxqSbQpdoEg@mail.gmail.com>
X-Gm-Features: AVVi8Ce7w8O4ofIUO0KMJPnSxBUad7ad-fPBfMDmsM69pgWrp7a1y6xJ_69oSVY
Message-ID: <CAGsJ_4xk2Q3xTkQYMPb7rnvnvVsjp24uXRcOja5RxqSbQpdoEg@mail.gmail.com>
Subject: Re: [PATCH] mm/lruvec: trace LRU add drains and drain-all queuing
To: JP Kobryn <jp.kobryn@linux.dev>
Cc: linux-mm@kvack.org, willy@infradead.org, shakeel.butt@linux.dev, 
	usama.arif@linux.dev, akpm@linux-foundation.org, vbabka@kernel.org, 
	mhocko@suse.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, kasong@tencent.com, qi.zheng@linux.dev, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	chrisl@kernel.org, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	baoquan.he@linux.dev, youngjun.park@lge.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 12:12=E2=80=AFPM JP Kobryn <jp.kobryn@linux.dev> wro=
te:
>
> LRU add batches can be drained before they reach capacity. This can be a
> source of LRU lock contention, but it is not currently possible to
> attribute these drains to callers with existing tracepoints.
>
> Add mm_lru_add_drain to report the CPU and lru_add batch count when an
> lru_add batch is drained. This allows tracing to distinguish full drains
> from partial drains and attribute them to the calling stack.
>
> Add mm_lru_drain_all_queue to report when lru_add_drain_all() queues
> per-CPU drain work. This captures the requester stack and target CPU for
> remote drain work. The event is named as a drain-all queue event because
> the queued work can be needed for batches other than lru_add.
>
> Signed-off-by: JP Kobryn <jp.kobryn@linux.dev>
> ---
>  include/trace/events/pagemap.h | 40 ++++++++++++++++++++++++++++++++++
>  mm/swap.c                      |  6 ++++-
>  2 files changed, 45 insertions(+), 1 deletion(-)
>
> diff --git a/include/trace/events/pagemap.h b/include/trace/events/pagema=
p.h
> index 171524d3526d..ea8fc46bedb0 100644
> --- a/include/trace/events/pagemap.h
> +++ b/include/trace/events/pagemap.h
> @@ -77,6 +77,46 @@ TRACE_EVENT(mm_lru_activate,
>         TP_printk("folio=3D%p pfn=3D0x%lx", __entry->folio, __entry->pfn)
>  );
>
> +TRACE_EVENT(mm_lru_add_drain,
> +
> +       TP_PROTO(int cpu, unsigned int nr),
> +
> +       TP_ARGS(cpu, nr),
> +
> +       TP_STRUCT__entry(
> +               __field(int,            cpu     )
> +               __field(unsigned int,   nr      )
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->cpu    =3D cpu;
> +               __entry->nr     =3D nr;
> +       ),
> +
> +       TP_printk("cpu=3D%d nr=3D%u", __entry->cpu, __entry->nr)
> +);
> +
> +TRACE_EVENT(mm_lru_drain_all_queue,
> +
> +       TP_PROTO(int target_cpu, bool force_all_cpus),
> +
> +       TP_ARGS(target_cpu, force_all_cpus),
> +
> +       TP_STRUCT__entry(
> +               __field(int,    target_cpu      )
> +               __field(bool,   force_all_cpus  )
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->target_cpu     =3D target_cpu;
> +               __entry->force_all_cpus =3D force_all_cpus;
> +       ),
> +
> +       TP_printk("target_cpu=3D%d force_all_cpus=3D%s",
> +               __entry->target_cpu,
> +               __entry->force_all_cpus ? "true" : "false")
> +);
> +
>  #endif /* _TRACE_PAGEMAP_H */
>
>  /* This part must be outside protection */
> diff --git a/mm/swap.c b/mm/swap.c
> index 588f50d8f1a8..c385b93582eb 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -694,9 +694,12 @@ void lru_add_drain_cpu(int cpu)
>  {
>         struct cpu_fbatches *fbatches =3D &per_cpu(cpu_fbatches, cpu);
>         struct folio_batch *fbatch =3D &fbatches->lru_add;
> +       unsigned int nr_folios_add =3D folio_batch_count(fbatch);
>
> -       if (folio_batch_count(fbatch))
> +       if (nr_folios_add) {
>                 folio_batch_move_lru(fbatch, lru_add);
> +               trace_mm_lru_add_drain(cpu, nr_folios_add);
> +       }
>
>         fbatch =3D &fbatches->lru_move_tail;
>         /* Disabling interrupts below acts as a compiler barrier. */
> @@ -928,6 +931,7 @@ static inline void __lru_add_drain_all(bool force_all=
_cpus)
>                 if (cpu_needs_drain(cpu)) {
>                         INIT_WORK(work, lru_add_drain_per_cpu);
>                         queue_work_on(cpu, mm_percpu_wq, work);
> +                       trace_mm_lru_drain_all_queue(cpu, force_all_cpus)=
;

Do you need tracing on each CPU individually, or is tracing the
entire __lru_add_drain_all() invocation sufficient?

Do you also need this_gen and lru_drain_gen to be traced?

By the way, I'm not sure drain_all_queue is the best name here.
Why not simply use add_drain_all()? It would match the existing
function name better.

Best Regards
Barry
