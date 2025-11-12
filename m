Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67D41E3DCD
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762927427; cv=none; b=dkNgQuxNiauZRAvt5YMiODM3axaHMHpvBuaArkIc+JTgNV+fIsDqbx0773Ty7z+AM7PORW+AMw+abXe8Kgts5XpbvBR9RFG3WsZ/7ssVnBr6aQA38gB8E1wfV+hfO5xsHpTKARLN5r6E94RnvVbGGGpNy0RLsQVKp0jkXyO7eVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762927427; c=relaxed/simple;
	bh=y6nkNUmEZ/AVV/mjdHesn9kd7C4EqoIrMS9+yEKVQno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qs6OZ3Fbf+1S5RGMP1O5eqCWUzzN0HBq1m55eHymgL2PPTwOoMvUKEsu7H2eGFAx9qneGUKrIm0r9uHMbcTK9s1A0QjF11XgN43ms+7n4iJn1AlmE15AUgKYlc4rjtTPzS+NVUAQNoppfmvONgIHJIU96zVJE084OgaX2N83lW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdXKv64V; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdXKv64V"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b72134a5125so73558166b.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762927423; x=1763532223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEbKE/w68+CKyUzqPpaRs64jkS2Y533jKnFD34BCDeM=;
        b=hdXKv64VX3k1Jr6GLqOGnBPuzzbMtImzEEFichUWJQljN/Ti4YGiwxBF8keEzdSVcm
         85hvT7PVRQob28hj9AqayMn2F8+Ggo41HiRlfCucsz/tFjORjIF9INAhnNG6H2Y9d2fx
         72Qnp14gFy25RDzgcXhX07OI2GlLel/Sc2su7oqEL1vWVR5RKrAa5DC1FiZT/UYDGILw
         fu3dO2IOSvwZ6VCRFzYGmVN+yLRyMTGok68+BYbh2+BDTebYPZLDrTvXTHQsXLm7aNkW
         ErqPG6zB/B66kFeeVFQvkjNzqmmNujeta6At89z6B1gi47bECvqzQHLcDrYRosDrJpG+
         TTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762927423; x=1763532223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PEbKE/w68+CKyUzqPpaRs64jkS2Y533jKnFD34BCDeM=;
        b=HCTDdtAUMyjByrqQ21xeWKRai/EMBtZ6biqRLvQtVlEVVgAFZmLrMovY2CM00rQOph
         QJz0UBVXKj0zKuC3H6h5+KhW/SX/s0bISPPPD0d0zfnKfdkktVVWQFUeR4I0YVW6Ed6Y
         pkXVUsbdZidcwyLSKmTnvJZaCB+kGFjT87j0/h32hoeDFfWAmGxtcsojGze4Tt/ppHp8
         tsZtGTjjQyXBt7PwcoOAuj2sOUjsDga/yLOQfTRw2ErWkd1oVmQeJnILDB6Dk02jMv21
         6gCmrAMF3cjv0plxfSU5YQK1QJxrBdB4LrOUKN/4ViQAbf6mhuFQb/5GyC0Ye8SDB95o
         VPRw==
X-Forwarded-Encrypted: i=1; AJvYcCV/m3hNsTwmR5vjBYNLpVTV2SVitAyX53H+FXxCXgWhtb/y0GRsdvV7u0Ml9BdzjpXu57Gl6RAWE4KXRkbGFmDBdPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWaWs8S6L0G3BPwdLG3/7LT063ZVzzdxp30m5AxOgOL4aS+odE
	zlBGQzwPK/g1GGtxsOahHSqEHWkSbE0bWxo0wc+V6+WaweZDEPhSIdF5H5ntwfAiiTt/eE6tteh
	1IEgAh7OZU3q2Wk6arEKc4u2e8b3UGds=
X-Gm-Gg: ASbGncsnb1FwtQiL8VvScoT1lOmbFkx+LxBu7MpclQaFXjcGHZzSoxxFDh+DGfAD3Ii
	z5DF52WOzgVPqXxmh7ymGyPP8TU/+DKVAMdmlJtY3UAmB5NKiqqsPsl/DiNQk8nFh3VuZ3wWKU+
	N6srh9IvlxrtCmLV+L9Rm4DqaGR9Fg8zsT/nQU5AdlKYDg354ifUa7j6fdOgA7LfmcdhmtEHYlg
	qE2ofBDVk/xtuA++IpuUlZuIg+H4rdNaF0/BUUNfSSi6uvdUmofQ8tDHK7cbQ==
X-Google-Smtp-Source: AGHT+IH0bjJk6eNMBSkAw+kMY9WytTdF9VBfBlVMm2Fn5JLPLJPV2kCiNjifYs0LqEJa8b+upRWr+cte+NUF/KmQi9k=
X-Received: by 2002:a17:906:d554:b0:b1d:285c:e0ef with SMTP id
 a640c23a62f3a-b733197ee63mr188626866b.26.1762927422954; Tue, 11 Nov 2025
 22:03:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112034333.2901601-1-dolinux.peng@gmail.com> <20251112141705.a7f2f79f6d7b058201307e89@kernel.org>
In-Reply-To: <20251112141705.a7f2f79f6d7b058201307e89@kernel.org>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 12 Nov 2025 14:03:30 +0800
X-Gm-Features: AWmQ_blqb1_MPJKmnuWZojHSnkUWb5-DmI2kcKy9ZZjFGm2p5RfAbbf1kLkFNjU
Message-ID: <CAErzpmsHNRzB2pBFVSAG4ii=VN98NEtehEbnYNQY-4TBWgM3ag@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] function_graph: Enable funcgraph-args and
 funcgraph-retaddr to work simultaneously
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Donglin Peng <pengdonglin@xiaomi.com>, 
	Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 1:17=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Wed, 12 Nov 2025 11:43:33 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
>
> > From: Donglin Peng <pengdonglin@xiaomi.com>
> >
> > Currently, the funcgraph-args and funcgraph-retaddr features are mutual=
ly exclusive.
> > This patch resolves this limitation by modifying funcgraph-retaddr to a=
dopt the same
> > implementation approach as funcgraph-args, specifically by storing the =
return address
> > in the first entry of the args array.
> >
> > As a result, both features now coexist seamlessly and function as inten=
ded.
> >
> > To verify the change, use perf to trace vfs_write with both options ena=
bled:
> >
> > Before:
> >  # perf ftrace -G vfs_write --graph-opts args,retaddr
> >  ......
> >  0)               |  down_read() { /* <-n_tty_write+0xa3/0x540 */
> >  0)   0.075 us    |    __cond_resched(); /* <-down_read+0x12/0x160 */
> >  0)   0.079 us    |    preempt_count_add(); /* <-down_read+0x3b/0x160 *=
/
> >  0)   0.077 us    |    preempt_count_sub(); /* <-down_read+0x8b/0x160 *=
/
> >  0)   0.754 us    |  }
> >
> > After:
> >  # perf ftrace -G vfs_write --graph-opts args,retaddr
> >  ......
> >  0)               |  down_read(sem=3D0xffff8880100bea78) { /* <-n_tty_w=
rite+0xa3/0x540 */
> >  0)   0.075 us    |    __cond_resched(); /* <-down_read+0x12/0x160 */
> >  0)   0.079 us    |    preempt_count_add(val=3D1); /* <-down_read+0x3b/=
0x160 */
> >  0)   0.077 us    |    preempt_count_sub(val=3D1); /* <-down_read+0x8b/=
0x160 */
> >  0)   0.754 us    |  }
> >
> > Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> > Cc: Sven Schnelle <svens@linux.ibm.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
>
> Looks good to me except for a few nits, but it's a style issue.
>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you for ack.

>
> Thank you,
>
> > ---
> > v3:
> > - Replace min() with min_t() to improve type safety and maintainability
> > - Keep only one Signed-off-by for cleaner attribution
> > - Code refactoring for improved readability
> >
> > v2:
> > - Preserve retaddr event functionality (suggested by Steven)
> > - Store the retaddr in args[0] (suggested by Steven)
> > - Refactor implementation logic and commit message clarity
> > ---
> >  include/linux/ftrace.h               |  11 --
> >  kernel/trace/trace.h                 |   4 -
> >  kernel/trace/trace_entries.h         |   6 +-
> >  kernel/trace/trace_functions_graph.c | 145 ++++++++++++---------------
> >  4 files changed, 69 insertions(+), 97 deletions(-)
> >
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index 7ded7df6e9b5..88cb54d73bdb 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -1129,17 +1129,6 @@ struct ftrace_graph_ent {
> >       int depth;
> >  } __packed;
> >
> > -/*
> > - * Structure that defines an entry function trace with retaddr.
> > - * It's already packed but the attribute "packed" is needed
> > - * to remove extra padding at the end.
> > - */
> > -struct fgraph_retaddr_ent {
> > -     unsigned long func; /* Current function */
> > -     int depth;
> > -     unsigned long retaddr;  /* Return address */
> > -} __packed;
> > -
> >  /*
> >   * Structure that defines a return function trace.
> >   * It's already packed but the attribute "packed" is needed
> > diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> > index 85eabb454bee..9fac291b913a 100644
> > --- a/kernel/trace/trace.h
> > +++ b/kernel/trace/trace.h
> > @@ -955,10 +955,6 @@ extern void graph_trace_close(struct trace_iterato=
r *iter);
> >  extern int __trace_graph_entry(struct trace_array *tr,
> >                              struct ftrace_graph_ent *trace,
> >                              unsigned int trace_ctx);
> > -extern int __trace_graph_retaddr_entry(struct trace_array *tr,
> > -                             struct ftrace_graph_ent *trace,
> > -                             unsigned int trace_ctx,
> > -                             unsigned long retaddr);
> >  extern void __trace_graph_return(struct trace_array *tr,
> >                                struct ftrace_graph_ret *trace,
> >                                unsigned int trace_ctx,
> > diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.=
h
> > index de294ae2c5c5..593a74663c65 100644
> > --- a/kernel/trace/trace_entries.h
> > +++ b/kernel/trace/trace_entries.h
> > @@ -95,14 +95,14 @@ FTRACE_ENTRY_PACKED(fgraph_retaddr_entry, fgraph_re=
taddr_ent_entry,
> >       TRACE_GRAPH_RETADDR_ENT,
> >
> >       F_STRUCT(
> > -             __field_struct( struct fgraph_retaddr_ent,      graph_ent=
       )
> > +             __field_struct( struct ftrace_graph_ent,        graph_ent=
       )
> >               __field_packed( unsigned long,  graph_ent,      func     =
       )
> >               __field_packed( unsigned int,   graph_ent,      depth    =
       )
> > -             __field_packed( unsigned long,  graph_ent,      retaddr  =
       )
> > +             __dynamic_array(unsigned long,  args                     =
       )
> >       ),
> >
> >       F_printk("--> %ps (%u) <- %ps", (void *)__entry->func, __entry->d=
epth,
> > -             (void *)__entry->retaddr)
> > +             (void *)__entry->args[0])
> >  );
> >
> >  #else
> > diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_=
functions_graph.c
> > index a7f4b9a47a71..f31eeeffbb2d 100644
> > --- a/kernel/trace/trace_functions_graph.c
> > +++ b/kernel/trace/trace_functions_graph.c
> > @@ -16,6 +16,15 @@
> >  #include "trace.h"
> >  #include "trace_output.h"
> >
> > +#ifdef CONFIG_FUNCTION_GRAPH_RETADDR
> > +#define HAVE_RETADDR 1
> > +#define ARGS_OFFS(args_size) \
> > +     ((args_size) > FTRACE_REGS_MAX_ARGS * sizeof(long) ? 1 : 0)
> > +#else
> > +#define HAVE_RETADDR 0
> > +#define ARGS_OFFS(args_size) 0
> > +#endif
> > +
> >  /* When set, irq functions will be ignored */
> >  static int ftrace_graph_skip_irqs;
> >
> > @@ -27,21 +36,25 @@ struct fgraph_cpu_data {
> >       unsigned long   enter_funcs[FTRACE_RETFUNC_DEPTH];
> >  };
> >
> > +/*
> > + * fgraph_retaddr_ent_entry and ftrace_graph_ent_entry share layout, e=
nt
> > + * member repurposed for storage
> > + */
> >  struct fgraph_ent_args {
> >       struct ftrace_graph_ent_entry   ent;
> > -     /* Force the sizeof of args[] to have FTRACE_REGS_MAX_ARGS entrie=
s */
> > -     unsigned long                   args[FTRACE_REGS_MAX_ARGS];
> > +     /*
> > +      * Force the sizeof of args[] to have (FTRACE_REGS_MAX_ARGS + HAV=
E_RETADDR)
> > +      * entries with the first entry storing the return address for
> > +      * TRACE_GRAPH_RETADDR_ENT.
> > +      */
> > +     unsigned long           args[FTRACE_REGS_MAX_ARGS + HAVE_RETADDR]=
;
> >  };
> >
> >  struct fgraph_data {
> >       struct fgraph_cpu_data __percpu *cpu_data;
> >
> >       /* Place to preserve last processed entry. */
> > -     union {
> > -             struct fgraph_ent_args          ent;
> > -             /* TODO allow retaddr to have args */
> > -             struct fgraph_retaddr_ent_entry rent;
> > -     };
> > +     struct fgraph_ent_args          ent;
> >       struct ftrace_graph_ret_entry   ret;
> >       int                             failed;
> >       int                             cpu;
> > @@ -127,22 +140,43 @@ static int __graph_entry(struct trace_array *tr, =
struct ftrace_graph_ent *trace,
> >       struct ring_buffer_event *event;
> >       struct trace_buffer *buffer =3D tr->array_buffer.buffer;
> >       struct ftrace_graph_ent_entry *entry;
> > -     int size;
> > +     unsigned long retaddr =3D 0;
> > +     int size =3D sizeof(*entry);
> > +     int type =3D TRACE_GRAPH_ENT;
> > +     bool store_args =3D false;
> > +     int nr_args =3D 0, args_offs =3D 0;
> > +
> > +     if (tracer_flags_is_set(TRACE_GRAPH_PRINT_RETADDR)) {
> > +             retaddr =3D ftrace_graph_top_ret_addr(current);
> > +             type =3D TRACE_GRAPH_RETADDR_ENT;
> > +             nr_args +=3D 1;
> > +     }
> >
> >       /* If fregs is defined, add FTRACE_REGS_MAX_ARGS long size words =
*/
> > -     size =3D sizeof(*entry) + (FTRACE_REGS_MAX_ARGS * !!fregs * sizeo=
f(long));
> > +     if (tracer_flags_is_set(TRACE_GRAPH_ARGS)) {
> > +             store_args =3D !!fregs;
> > +             if (store_args)
> > +                     nr_args +=3D FTRACE_REGS_MAX_ARGS;
> > +     }
> >
> > -     event =3D trace_buffer_lock_reserve(buffer, TRACE_GRAPH_ENT, size=
, trace_ctx);
> > +     size +=3D nr_args * sizeof(long);
> > +     event =3D trace_buffer_lock_reserve(buffer, type, size, trace_ctx=
);
> >       if (!event)
> >               return 0;
> >
> >       entry =3D ring_buffer_event_data(event);
> >       entry->graph_ent =3D *trace;
> >
> > +     /* Store the retaddr in args[0] */
> > +     if (type =3D=3D TRACE_GRAPH_RETADDR_ENT) {
> > +             entry->args[0] =3D retaddr;
> > +             args_offs +=3D 1;
> > +     }
> > +
> >  #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
> > -     if (fregs) {
> > +     if (store_args) {
> >               for (int i =3D 0; i < FTRACE_REGS_MAX_ARGS; i++)
> > -                     entry->args[i] =3D ftrace_regs_get_argument(fregs=
, i);
> > +                     entry->args[i + args_offs] =3D ftrace_regs_get_ar=
gument(fregs, i);
> >       }
> >  #endif
> >
> > @@ -158,38 +192,6 @@ int __trace_graph_entry(struct trace_array *tr,
> >       return __graph_entry(tr, trace, trace_ctx, NULL);
> >  }
> >
> > -#ifdef CONFIG_FUNCTION_GRAPH_RETADDR
> > -int __trace_graph_retaddr_entry(struct trace_array *tr,
> > -                             struct ftrace_graph_ent *trace,
> > -                             unsigned int trace_ctx,
> > -                             unsigned long retaddr)
> > -{
> > -     struct ring_buffer_event *event;
> > -     struct trace_buffer *buffer =3D tr->array_buffer.buffer;
> > -     struct fgraph_retaddr_ent_entry *entry;
> > -
> > -     event =3D trace_buffer_lock_reserve(buffer, TRACE_GRAPH_RETADDR_E=
NT,
> > -                                       sizeof(*entry), trace_ctx);
> > -     if (!event)
> > -             return 0;
> > -     entry   =3D ring_buffer_event_data(event);
> > -     entry->graph_ent.func =3D trace->func;
> > -     entry->graph_ent.depth =3D trace->depth;
> > -     entry->graph_ent.retaddr =3D retaddr;
> > -     trace_buffer_unlock_commit_nostack(buffer, event);
> > -
> > -     return 1;
> > -}
> > -#else
> > -int __trace_graph_retaddr_entry(struct trace_array *tr,
> > -                             struct ftrace_graph_ent *trace,
> > -                             unsigned int trace_ctx,
> > -                             unsigned long retaddr)
> > -{
> > -     return 1;
> > -}
> > -#endif
> > -
> >  static inline int ftrace_graph_ignore_irqs(void)
> >  {
> >       if (!ftrace_graph_skip_irqs || trace_recursion_test(TRACE_IRQ_BIT=
))
> > @@ -211,7 +213,6 @@ static int graph_entry(struct ftrace_graph_ent *tra=
ce,
> >       struct trace_array *tr =3D gops->private;
> >       struct fgraph_times *ftimes;
> >       unsigned int trace_ctx;
> > -     int ret =3D 0;
> >
> >       if (*task_var & TRACE_GRAPH_NOTRACE)
> >               return 0;
> > @@ -262,15 +263,7 @@ static int graph_entry(struct ftrace_graph_ent *tr=
ace,
> >               return 1;
> >
> >       trace_ctx =3D tracing_gen_ctx();
> > -     if (IS_ENABLED(CONFIG_FUNCTION_GRAPH_RETADDR) &&
> > -         tracer_flags_is_set(TRACE_GRAPH_PRINT_RETADDR)) {
> > -             unsigned long retaddr =3D ftrace_graph_top_ret_addr(curre=
nt);
> > -             ret =3D __trace_graph_retaddr_entry(tr, trace, trace_ctx,=
 retaddr);
> > -     } else {
> > -             ret =3D __graph_entry(tr, trace, trace_ctx, fregs);
> > -     }
> > -
> > -     return ret;
> > +     return __graph_entry(tr, trace, trace_ctx, fregs);
> >  }
> >
> >  int trace_graph_entry(struct ftrace_graph_ent *trace,
> > @@ -634,13 +627,9 @@ get_return_for_leaf(struct trace_iterator *iter,
> >                        * Save current and next entries for later refere=
nce
> >                        * if the output fails.
> >                        */
> > -                     if (unlikely(curr->ent.type =3D=3D TRACE_GRAPH_RE=
TADDR_ENT)) {
> > -                             data->rent =3D *(struct fgraph_retaddr_en=
t_entry *)curr;
> > -                     } else {
> > -                             int size =3D min((int)sizeof(data->ent), =
(int)iter->ent_size);
> > +                     int size =3D min_t(int, sizeof(data->ent), iter->=
ent_size);
> >
> > -                             memcpy(&data->ent, curr, size);
> > -                     }
> > +                     memcpy(&data->ent, curr, size);
> >                       /*
> >                        * If the next event is not a return type, then
> >                        * we only care about what type it is. Otherwise =
we can
> > @@ -811,21 +800,21 @@ print_graph_duration(struct trace_array *tr, unsi=
gned long long duration,
> >
> >  #ifdef CONFIG_FUNCTION_GRAPH_RETADDR
> >  #define __TRACE_GRAPH_PRINT_RETADDR TRACE_GRAPH_PRINT_RETADDR
> > -static void print_graph_retaddr(struct trace_seq *s, struct fgraph_ret=
addr_ent_entry *entry,
> > -                             u32 trace_flags, bool comment)
> > +static void print_graph_retaddr(struct trace_seq *s, unsigned long ret=
addr, u32 trace_flags,
> > +                             bool comment)
> >  {
> >       if (comment)
> >               trace_seq_puts(s, " /*");
> >
> >       trace_seq_puts(s, " <-");
> > -     seq_print_ip_sym(s, entry->graph_ent.retaddr, trace_flags | TRACE=
_ITER_SYM_OFFSET);
> > +     seq_print_ip_sym(s, retaddr, trace_flags | TRACE_ITER_SYM_OFFSET)=
;
> >
> >       if (comment)
> >               trace_seq_puts(s, " */");
> >  }
> >  #else
> >  #define __TRACE_GRAPH_PRINT_RETADDR 0
> > -#define print_graph_retaddr(_seq, _entry, _tflags, _comment)         d=
o { } while (0)
> > +#define print_graph_retaddr(_seq, _retaddr, _tflags, _comment)        =
       do { } while (0)
> >  #endif
> >
> >  #if defined(CONFIG_FUNCTION_GRAPH_RETVAL) || defined(CONFIG_FUNCTION_G=
RAPH_RETADDR)
> > @@ -869,10 +858,12 @@ static void print_graph_retval(struct trace_seq *=
s, struct ftrace_graph_ent_entr
> >               trace_seq_printf(s, "%ps", func);
> >
> >               if (args_size >=3D FTRACE_REGS_MAX_ARGS * sizeof(long)) {
> > -                     print_function_args(s, entry->args, (unsigned lon=
g)func);
> > +                     print_function_args(s, entry->args + ARGS_OFFS(ar=
gs_size),
> > +                                         (unsigned long)func);
> >                       trace_seq_putc(s, ';');
> > -             } else
> > +             } else {
>
> nit: you don't need to add braces for a single line block.

Thanks. I added the else braces for consistency with the
multi-statement if branch,
per coding-style.rst. Happy to remove if you prefer the
single-statement exception.

https://elixir.bootlin.com/linux/v6.18-rc5/source/Documentation/process/cod=
ing-style.rst#L213

Do not unnecessarily use braces where a single statement will do.

.. code-block:: c

if (condition)
action();

and

.. code-block:: c

if (condition)
do_this();
else
do_that();

This does not apply if only one branch of a conditional statement is a sing=
le
statement; in the latter case use braces in both branches:

.. code-block:: c

if (condition) {
do_this();
do_that();
} else {
otherwise();
}

>
> >                       trace_seq_puts(s, "();");
> > +             }
> >
> >               if (print_retval || print_retaddr)
> >                       trace_seq_puts(s, " /*");
> > @@ -882,8 +873,7 @@ static void print_graph_retval(struct trace_seq *s,=
 struct ftrace_graph_ent_entr
> >       }
> >
> >       if (print_retaddr)
> > -             print_graph_retaddr(s, (struct fgraph_retaddr_ent_entry *=
)entry,
> > -                                 trace_flags, false);
> > +             print_graph_retaddr(s, entry->args[0], trace_flags, false=
);
> >
> >       if (print_retval) {
> >               if (hex_format || (err_code =3D=3D 0))
> > @@ -964,10 +954,12 @@ print_graph_entry_leaf(struct trace_iterator *ite=
r,
> >               trace_seq_printf(s, "%ps", (void *)ret_func);
> >
> >               if (args_size >=3D FTRACE_REGS_MAX_ARGS * sizeof(long)) {
> > -                     print_function_args(s, entry->args, ret_func);
> > +                     print_function_args(s, entry->args + ARGS_OFFS(ar=
gs_size),
> > +                                         ret_func);
> >                       trace_seq_putc(s, ';');
> > -             } else
> > +             } else {
>
> Ditto.
>
> >                       trace_seq_puts(s, "();");
> > +             }
> >       }
> >       trace_seq_putc(s, '\n');
> >
> > @@ -1016,7 +1008,7 @@ print_graph_entry_nested(struct trace_iterator *i=
ter,
> >       args_size =3D iter->ent_size - offsetof(struct ftrace_graph_ent_e=
ntry, args);
> >
> >       if (args_size >=3D FTRACE_REGS_MAX_ARGS * sizeof(long))
> > -             print_function_args(s, entry->args, func);
> > +             print_function_args(s, entry->args + ARGS_OFFS(args_size)=
, func);
> >       else
> >               trace_seq_puts(s, "()");
> >
> > @@ -1024,8 +1016,7 @@ print_graph_entry_nested(struct trace_iterator *i=
ter,
> >
> >       if (flags & __TRACE_GRAPH_PRINT_RETADDR  &&
> >               entry->ent.type =3D=3D TRACE_GRAPH_RETADDR_ENT)
> > -             print_graph_retaddr(s, (struct fgraph_retaddr_ent_entry *=
)entry,
> > -                     tr->trace_flags, true);
> > +             print_graph_retaddr(s, entry->args[0], tr->trace_flags, t=
rue);
> >       trace_seq_putc(s, '\n');
> >
> >       if (trace_seq_has_overflowed(s))
> > @@ -1202,7 +1193,7 @@ print_graph_entry(struct ftrace_graph_ent_entry *=
field, struct trace_seq *s,
> >        * it can be safely saved at the stack.
> >        */
> >       struct ftrace_graph_ent_entry *entry;
> > -     u8 save_buf[sizeof(*entry) + FTRACE_REGS_MAX_ARGS * sizeof(long)]=
;
> > +     u8 save_buf[sizeof(*entry) + (FTRACE_REGS_MAX_ARGS + HAVE_RETADDR=
) * sizeof(long)];
> >
> >       /* The ent_size is expected to be as big as the entry */
> >       if (iter->ent_size > sizeof(save_buf))
> > @@ -1429,16 +1420,12 @@ print_graph_function_flags(struct trace_iterato=
r *iter, u32 flags)
> >               trace_assign_type(field, entry);
> >               return print_graph_entry(field, s, iter, flags);
> >       }
> > -#ifdef CONFIG_FUNCTION_GRAPH_RETADDR
> >       case TRACE_GRAPH_RETADDR_ENT: {
> > -             struct fgraph_retaddr_ent_entry saved;
> >               struct fgraph_retaddr_ent_entry *rfield;
> >
> >               trace_assign_type(rfield, entry);
> > -             saved =3D *rfield;
> > -             return print_graph_entry((struct ftrace_graph_ent_entry *=
)&saved, s, iter, flags);
> > +             return print_graph_entry((typeof(field))rfield, s, iter, =
flags);
> >       }
> > -#endif
> >       case TRACE_GRAPH_RET: {
> >               struct ftrace_graph_ret_entry *field;
> >               trace_assign_type(field, entry);
> > --
> > 2.34.1
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
