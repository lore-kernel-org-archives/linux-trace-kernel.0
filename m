Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F2829ACE5
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762932154; cv=none; b=AuBuTD3dl38OdNK+phIXnUaPchLl8jn2b3tvCj/6P5oDYF9/XvQcPjhDW5xuPBbcVm478ElyEgbvJZBosrMzRrZN1XIL2qN1yyuc/ceAsKepcVVdW3/akGOX91QYsn6NjKLpJfuETjLondwXWi6Zl6SQja1zvX7IxoLAgHFyi60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762932154; c=relaxed/simple;
	bh=d2y2J7FLtv3rMZ++iSlAFE1+aNJqWa/d5+nXbCEKhnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9TxFvW/yuCI1oT94fvOOCSkkffe0sCfPOyDnddSL8nN/sRXZ/fsDNTKfyGfAKRQyESrKX4yB3q/RjkQD2ct5KrD5ug3/0ZDaQOB3C44tndbX7L+Rcn4WWCjucj33IDcLM3yzOYR0uw6s1ssM5CZL6JLWkKaSbEyYYnxcgsRkEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yxhk8FQO; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yxhk8FQO"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b73301e6ab5so94445666b.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762932151; x=1763536951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3oHE1KfX4aQ+1xvWJhv972OfKgV4zsSVAGGgJpfkqM=;
        b=Yxhk8FQOZfmx5vVYyYgEJShediUuCzv7VMtR51DrMvC5Rz/brdraLtRLLxw5iTlSck
         13POno6QwMY4kcYK7xETBbXaLlJaSa4kTw1D65O9SftkvvNhEREoPPklZN0RJtR7XJIf
         GesY3ijv/1jXHk1Z4nBjx7i3cmbgOgIvW6VtiFSEGnumpGwnQ7rqQceSEqY1cmiC11sQ
         Ro//HBq/McYOfEJqvW94Tkk9bJNNMBYYw3rKGBx/KT1VyqLtcnn/giH8F0VEBbaJN+ax
         1zQYqaHgioHHysMceSTWVOk5k2il74QrKP682IEL31vX8AjLg+YzwOAXsMydWDltjsin
         kV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762932151; x=1763536951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n3oHE1KfX4aQ+1xvWJhv972OfKgV4zsSVAGGgJpfkqM=;
        b=EPB3v/jqUJsGKt5hVnFCV7TgSYRxvC01Fz/8s52J9w9AHOjPaAb8Vvf1cbr+u7k4yH
         HUz6UxL3GaxDnrA31aAYLnL06jjdGxiSeqxFR4SDpY5X2pBOpSfQ+hjbTdksOvfEZgmW
         7Gp5BFbmRwrgU4LUOl3cFv+3OkSBrd3s4MuXh141GdHrgSUDUZJfe5/vhLPgFHd3s61B
         mGHivgG8GEh/mmw1cE3pxlkNay2EcJWDBZPBOxjgWd25AOR8BPIb85ORTeuW3FEkvwXF
         VdJ7H3v9MHQA9yufjexZiN4z982z0GZdZXrgnRwdvbcdD7aHXCbS3nqQWXz9G9Pw1W7+
         4MIw==
X-Forwarded-Encrypted: i=1; AJvYcCUjUhHNWSY5ryPOQ+ftVAdgcaw57tlgCDDjjkHE0AX9/jbWoh5htlTofXJWiogthVMgfyLr0B760nxGMqNio4aHQH4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6JwKpCRCRcRESxFpaSss/lLEptDzU9m48JlM8tTjVxdCc6geT
	xBOzV7BVXiKw73zZlv/Uij//g5xWQT04i5iLnBwFwKJLFh29IIxURPWTGRwstMv824K1O59Io5x
	incW368yGj9fp5u1cBpywLUjKX4biywk=
X-Gm-Gg: ASbGncuN6MEwLdyQ3S+qkbRPwwuKunlCGcIo1tdUShn9l0eF2Ox1fnqaDYLt1B/SzN4
	Bl3ef1wpqjtQoqGWMeiroIXsV2cpF/o9nDKKD60dEvV+MVE50GhFr7nxJun5qo03BgtINyhZvwO
	/Zi2MhsM4uKgv1iyrRA1gqYOKipMMPDGzVkDeK07V4c60LIJqzwDCFXlwNsS10+fDH8Z5D/y2+o
	y+nvUcw9CYWGe4Zw79nJSQwPYYAsFVXvff64O8NbccG4lxBhZ9sd24KFmDOig==
X-Google-Smtp-Source: AGHT+IEonFZmYAOCOTGDIORxfN7vIurZgYl3tDJ8pJOdJvbPAPPZnlBT5TbXn5wiBKbtPNKFAWARW9O4N32F3d6I980=
X-Received: by 2002:a17:907:6092:b0:b65:b9fb:e4a7 with SMTP id
 a640c23a62f3a-b7331a02050mr176045566b.9.1762932150273; Tue, 11 Nov 2025
 23:22:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112034333.2901601-1-dolinux.peng@gmail.com>
 <20251112141705.a7f2f79f6d7b058201307e89@kernel.org> <CAErzpmsHNRzB2pBFVSAG4ii=VN98NEtehEbnYNQY-4TBWgM3ag@mail.gmail.com>
 <20251112161017.d9da54e462817cc9053688f6@kernel.org>
In-Reply-To: <20251112161017.d9da54e462817cc9053688f6@kernel.org>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 12 Nov 2025 15:22:18 +0800
X-Gm-Features: AWmQ_bkdkr3hyKR3VxyIixB4buBO0tjZwv-exkykO_34Bm739UP7upVP_sXijeU
Message-ID: <CAErzpmt-uEz_oRE3JEEap-Xr1sFDa6xSmUZxqTLrP5cXOdBLbw@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] function_graph: Enable funcgraph-args and
 funcgraph-retaddr to work simultaneously
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Donglin Peng <pengdonglin@xiaomi.com>, 
	Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 3:10=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Wed, 12 Nov 2025 14:03:30 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
>
> > On Wed, Nov 12, 2025 at 1:17=E2=80=AFPM Masami Hiramatsu <mhiramat@kern=
el.org> wrote:
> > >
> > > On Wed, 12 Nov 2025 11:43:33 +0800
> > > Donglin Peng <dolinux.peng@gmail.com> wrote:
> > >
> > > > From: Donglin Peng <pengdonglin@xiaomi.com>
> > > >
> > > > Currently, the funcgraph-args and funcgraph-retaddr features are mu=
tually exclusive.
> > > > This patch resolves this limitation by modifying funcgraph-retaddr =
to adopt the same
> > > > implementation approach as funcgraph-args, specifically by storing =
the return address
> > > > in the first entry of the args array.
>
> Ah, if you can update the patch, please keep each line shorter than
> 70-75 characters.

Thanks, I will fix it in the next version.

>
> > > >
> > > > As a result, both features now coexist seamlessly and function as i=
ntended.
> > > >
> > > > To verify the change, use perf to trace vfs_write with both options=
 enabled:
> > > >
> > > > Before:
> > > >  # perf ftrace -G vfs_write --graph-opts args,retaddr
> > > >  ......
> > > >  0)               |  down_read() { /* <-n_tty_write+0xa3/0x540 */
> > > >  0)   0.075 us    |    __cond_resched(); /* <-down_read+0x12/0x160 =
*/
> > > >  0)   0.079 us    |    preempt_count_add(); /* <-down_read+0x3b/0x1=
60 */
> > > >  0)   0.077 us    |    preempt_count_sub(); /* <-down_read+0x8b/0x1=
60 */
> > > >  0)   0.754 us    |  }
> > > >
> > > > After:
> > > >  # perf ftrace -G vfs_write --graph-opts args,retaddr
> > > >  ......
> > > >  0)               |  down_read(sem=3D0xffff8880100bea78) { /* <-n_t=
ty_write+0xa3/0x540 */
> > > >  0)   0.075 us    |    __cond_resched(); /* <-down_read+0x12/0x160 =
*/
> > > >  0)   0.079 us    |    preempt_count_add(val=3D1); /* <-down_read+0=
x3b/0x160 */
> > > >  0)   0.077 us    |    preempt_count_sub(val=3D1); /* <-down_read+0=
x8b/0x160 */
> > > >  0)   0.754 us    |  }
> > > >
> > > > Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> > > > Cc: Sven Schnelle <svens@linux.ibm.com>
> > > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > > Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> > >
> > > Looks good to me except for a few nits, but it's a style issue.
> > >
> > > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > Thank you for ack.
> >
> > >
> > > Thank you,
> > >
> > > > ---
> > > > v3:
> > > > - Replace min() with min_t() to improve type safety and maintainabi=
lity
> > > > - Keep only one Signed-off-by for cleaner attribution
> > > > - Code refactoring for improved readability
> > > >
> > > > v2:
> > > > - Preserve retaddr event functionality (suggested by Steven)
> > > > - Store the retaddr in args[0] (suggested by Steven)
> > > > - Refactor implementation logic and commit message clarity
> > > > ---
> > > >  include/linux/ftrace.h               |  11 --
> > > >  kernel/trace/trace.h                 |   4 -
> > > >  kernel/trace/trace_entries.h         |   6 +-
> > > >  kernel/trace/trace_functions_graph.c | 145 ++++++++++++-----------=
----
> > > >  4 files changed, 69 insertions(+), 97 deletions(-)
> > > >
> > > > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > > > index 7ded7df6e9b5..88cb54d73bdb 100644
> > > > --- a/include/linux/ftrace.h
> > > > +++ b/include/linux/ftrace.h
> > > > @@ -1129,17 +1129,6 @@ struct ftrace_graph_ent {
> > > >       int depth;
> > > >  } __packed;
> > > >
> > > > -/*
> > > > - * Structure that defines an entry function trace with retaddr.
> > > > - * It's already packed but the attribute "packed" is needed
> > > > - * to remove extra padding at the end.
> > > > - */
> > > > -struct fgraph_retaddr_ent {
> > > > -     unsigned long func; /* Current function */
> > > > -     int depth;
> > > > -     unsigned long retaddr;  /* Return address */
> > > > -} __packed;
> > > > -
> > > >  /*
> > > >   * Structure that defines a return function trace.
> > > >   * It's already packed but the attribute "packed" is needed
> > > > diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> > > > index 85eabb454bee..9fac291b913a 100644
> > > > --- a/kernel/trace/trace.h
> > > > +++ b/kernel/trace/trace.h
> > > > @@ -955,10 +955,6 @@ extern void graph_trace_close(struct trace_ite=
rator *iter);
> > > >  extern int __trace_graph_entry(struct trace_array *tr,
> > > >                              struct ftrace_graph_ent *trace,
> > > >                              unsigned int trace_ctx);
> > > > -extern int __trace_graph_retaddr_entry(struct trace_array *tr,
> > > > -                             struct ftrace_graph_ent *trace,
> > > > -                             unsigned int trace_ctx,
> > > > -                             unsigned long retaddr);
> > > >  extern void __trace_graph_return(struct trace_array *tr,
> > > >                                struct ftrace_graph_ret *trace,
> > > >                                unsigned int trace_ctx,
> > > > diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entr=
ies.h
> > > > index de294ae2c5c5..593a74663c65 100644
> > > > --- a/kernel/trace/trace_entries.h
> > > > +++ b/kernel/trace/trace_entries.h
> > > > @@ -95,14 +95,14 @@ FTRACE_ENTRY_PACKED(fgraph_retaddr_entry, fgrap=
h_retaddr_ent_entry,
> > > >       TRACE_GRAPH_RETADDR_ENT,
> > > >
> > > >       F_STRUCT(
> > > > -             __field_struct( struct fgraph_retaddr_ent,      graph=
_ent       )
> > > > +             __field_struct( struct ftrace_graph_ent,        graph=
_ent       )
> > > >               __field_packed( unsigned long,  graph_ent,      func =
           )
> > > >               __field_packed( unsigned int,   graph_ent,      depth=
           )
> > > > -             __field_packed( unsigned long,  graph_ent,      retad=
dr         )
> > > > +             __dynamic_array(unsigned long,  args                 =
           )
> > > >       ),
> > > >
> > > >       F_printk("--> %ps (%u) <- %ps", (void *)__entry->func, __entr=
y->depth,
> > > > -             (void *)__entry->retaddr)
> > > > +             (void *)__entry->args[0])
> > > >  );
> > > >
> > > >  #else
> > > > diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/tr=
ace_functions_graph.c
> > > > index a7f4b9a47a71..f31eeeffbb2d 100644
> > > > --- a/kernel/trace/trace_functions_graph.c
> > > > +++ b/kernel/trace/trace_functions_graph.c
> > > > @@ -16,6 +16,15 @@
> > > >  #include "trace.h"
> > > >  #include "trace_output.h"
> > > >
> > > > +#ifdef CONFIG_FUNCTION_GRAPH_RETADDR
> > > > +#define HAVE_RETADDR 1
> > > > +#define ARGS_OFFS(args_size) \
> > > > +     ((args_size) > FTRACE_REGS_MAX_ARGS * sizeof(long) ? 1 : 0)
> > > > +#else
> > > > +#define HAVE_RETADDR 0
> > > > +#define ARGS_OFFS(args_size) 0
> > > > +#endif
> > > > +
> > > >  /* When set, irq functions will be ignored */
> > > >  static int ftrace_graph_skip_irqs;
> > > >
> > > > @@ -27,21 +36,25 @@ struct fgraph_cpu_data {
> > > >       unsigned long   enter_funcs[FTRACE_RETFUNC_DEPTH];
> > > >  };
> > > >
> > > > +/*
> > > > + * fgraph_retaddr_ent_entry and ftrace_graph_ent_entry share layou=
t, ent
> > > > + * member repurposed for storage
> > > > + */
> > > >  struct fgraph_ent_args {
> > > >       struct ftrace_graph_ent_entry   ent;
> > > > -     /* Force the sizeof of args[] to have FTRACE_REGS_MAX_ARGS en=
tries */
> > > > -     unsigned long                   args[FTRACE_REGS_MAX_ARGS];
> > > > +     /*
> > > > +      * Force the sizeof of args[] to have (FTRACE_REGS_MAX_ARGS +=
 HAVE_RETADDR)
> > > > +      * entries with the first entry storing the return address fo=
r
> > > > +      * TRACE_GRAPH_RETADDR_ENT.
> > > > +      */
> > > > +     unsigned long           args[FTRACE_REGS_MAX_ARGS + HAVE_RETA=
DDR];
> > > >  };
> > > >
> > > >  struct fgraph_data {
> > > >       struct fgraph_cpu_data __percpu *cpu_data;
> > > >
> > > >       /* Place to preserve last processed entry. */
> > > > -     union {
> > > > -             struct fgraph_ent_args          ent;
> > > > -             /* TODO allow retaddr to have args */
> > > > -             struct fgraph_retaddr_ent_entry rent;
> > > > -     };
> > > > +     struct fgraph_ent_args          ent;
> > > >       struct ftrace_graph_ret_entry   ret;
> > > >       int                             failed;
> > > >       int                             cpu;
> > > > @@ -127,22 +140,43 @@ static int __graph_entry(struct trace_array *=
tr, struct ftrace_graph_ent *trace,
> > > >       struct ring_buffer_event *event;
> > > >       struct trace_buffer *buffer =3D tr->array_buffer.buffer;
> > > >       struct ftrace_graph_ent_entry *entry;
> > > > -     int size;
> > > > +     unsigned long retaddr =3D 0;
> > > > +     int size =3D sizeof(*entry);
> > > > +     int type =3D TRACE_GRAPH_ENT;
> > > > +     bool store_args =3D false;
> > > > +     int nr_args =3D 0, args_offs =3D 0;
> > > > +
> > > > +     if (tracer_flags_is_set(TRACE_GRAPH_PRINT_RETADDR)) {
> > > > +             retaddr =3D ftrace_graph_top_ret_addr(current);
> > > > +             type =3D TRACE_GRAPH_RETADDR_ENT;
> > > > +             nr_args +=3D 1;
> > > > +     }
> > > >
> > > >       /* If fregs is defined, add FTRACE_REGS_MAX_ARGS long size wo=
rds */
> > > > -     size =3D sizeof(*entry) + (FTRACE_REGS_MAX_ARGS * !!fregs * s=
izeof(long));
> > > > +     if (tracer_flags_is_set(TRACE_GRAPH_ARGS)) {
> > > > +             store_args =3D !!fregs;
> > > > +             if (store_args)
> > > > +                     nr_args +=3D FTRACE_REGS_MAX_ARGS;
> > > > +     }
> > > >
> > > > -     event =3D trace_buffer_lock_reserve(buffer, TRACE_GRAPH_ENT, =
size, trace_ctx);
> > > > +     size +=3D nr_args * sizeof(long);
> > > > +     event =3D trace_buffer_lock_reserve(buffer, type, size, trace=
_ctx);
> > > >       if (!event)
> > > >               return 0;
> > > >
> > > >       entry =3D ring_buffer_event_data(event);
> > > >       entry->graph_ent =3D *trace;
> > > >
> > > > +     /* Store the retaddr in args[0] */
> > > > +     if (type =3D=3D TRACE_GRAPH_RETADDR_ENT) {
> > > > +             entry->args[0] =3D retaddr;
> > > > +             args_offs +=3D 1;
> > > > +     }
> > > > +
> > > >  #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
> > > > -     if (fregs) {
> > > > +     if (store_args) {
> > > >               for (int i =3D 0; i < FTRACE_REGS_MAX_ARGS; i++)
> > > > -                     entry->args[i] =3D ftrace_regs_get_argument(f=
regs, i);
> > > > +                     entry->args[i + args_offs] =3D ftrace_regs_ge=
t_argument(fregs, i);
> > > >       }
> > > >  #endif
> > > >
> > > > @@ -158,38 +192,6 @@ int __trace_graph_entry(struct trace_array *tr=
,
> > > >       return __graph_entry(tr, trace, trace_ctx, NULL);
> > > >  }
> > > >
> > > > -#ifdef CONFIG_FUNCTION_GRAPH_RETADDR
> > > > -int __trace_graph_retaddr_entry(struct trace_array *tr,
> > > > -                             struct ftrace_graph_ent *trace,
> > > > -                             unsigned int trace_ctx,
> > > > -                             unsigned long retaddr)
> > > > -{
> > > > -     struct ring_buffer_event *event;
> > > > -     struct trace_buffer *buffer =3D tr->array_buffer.buffer;
> > > > -     struct fgraph_retaddr_ent_entry *entry;
> > > > -
> > > > -     event =3D trace_buffer_lock_reserve(buffer, TRACE_GRAPH_RETAD=
DR_ENT,
> > > > -                                       sizeof(*entry), trace_ctx);
> > > > -     if (!event)
> > > > -             return 0;
> > > > -     entry   =3D ring_buffer_event_data(event);
> > > > -     entry->graph_ent.func =3D trace->func;
> > > > -     entry->graph_ent.depth =3D trace->depth;
> > > > -     entry->graph_ent.retaddr =3D retaddr;
> > > > -     trace_buffer_unlock_commit_nostack(buffer, event);
> > > > -
> > > > -     return 1;
> > > > -}
> > > > -#else
> > > > -int __trace_graph_retaddr_entry(struct trace_array *tr,
> > > > -                             struct ftrace_graph_ent *trace,
> > > > -                             unsigned int trace_ctx,
> > > > -                             unsigned long retaddr)
> > > > -{
> > > > -     return 1;
> > > > -}
> > > > -#endif
> > > > -
> > > >  static inline int ftrace_graph_ignore_irqs(void)
> > > >  {
> > > >       if (!ftrace_graph_skip_irqs || trace_recursion_test(TRACE_IRQ=
_BIT))
> > > > @@ -211,7 +213,6 @@ static int graph_entry(struct ftrace_graph_ent =
*trace,
> > > >       struct trace_array *tr =3D gops->private;
> > > >       struct fgraph_times *ftimes;
> > > >       unsigned int trace_ctx;
> > > > -     int ret =3D 0;
> > > >
> > > >       if (*task_var & TRACE_GRAPH_NOTRACE)
> > > >               return 0;
> > > > @@ -262,15 +263,7 @@ static int graph_entry(struct ftrace_graph_ent=
 *trace,
> > > >               return 1;
> > > >
> > > >       trace_ctx =3D tracing_gen_ctx();
> > > > -     if (IS_ENABLED(CONFIG_FUNCTION_GRAPH_RETADDR) &&
> > > > -         tracer_flags_is_set(TRACE_GRAPH_PRINT_RETADDR)) {
> > > > -             unsigned long retaddr =3D ftrace_graph_top_ret_addr(c=
urrent);
> > > > -             ret =3D __trace_graph_retaddr_entry(tr, trace, trace_=
ctx, retaddr);
> > > > -     } else {
> > > > -             ret =3D __graph_entry(tr, trace, trace_ctx, fregs);
> > > > -     }
> > > > -
> > > > -     return ret;
> > > > +     return __graph_entry(tr, trace, trace_ctx, fregs);
> > > >  }
> > > >
> > > >  int trace_graph_entry(struct ftrace_graph_ent *trace,
> > > > @@ -634,13 +627,9 @@ get_return_for_leaf(struct trace_iterator *ite=
r,
> > > >                        * Save current and next entries for later re=
ference
> > > >                        * if the output fails.
> > > >                        */
> > > > -                     if (unlikely(curr->ent.type =3D=3D TRACE_GRAP=
H_RETADDR_ENT)) {
> > > > -                             data->rent =3D *(struct fgraph_retadd=
r_ent_entry *)curr;
> > > > -                     } else {
> > > > -                             int size =3D min((int)sizeof(data->en=
t), (int)iter->ent_size);
> > > > +                     int size =3D min_t(int, sizeof(data->ent), it=
er->ent_size);
> > > >
> > > > -                             memcpy(&data->ent, curr, size);
> > > > -                     }
> > > > +                     memcpy(&data->ent, curr, size);
> > > >                       /*
> > > >                        * If the next event is not a return type, th=
en
> > > >                        * we only care about what type it is. Otherw=
ise we can
> > > > @@ -811,21 +800,21 @@ print_graph_duration(struct trace_array *tr, =
unsigned long long duration,
> > > >
> > > >  #ifdef CONFIG_FUNCTION_GRAPH_RETADDR
> > > >  #define __TRACE_GRAPH_PRINT_RETADDR TRACE_GRAPH_PRINT_RETADDR
> > > > -static void print_graph_retaddr(struct trace_seq *s, struct fgraph=
_retaddr_ent_entry *entry,
> > > > -                             u32 trace_flags, bool comment)
> > > > +static void print_graph_retaddr(struct trace_seq *s, unsigned long=
 retaddr, u32 trace_flags,
> > > > +                             bool comment)
> > > >  {
> > > >       if (comment)
> > > >               trace_seq_puts(s, " /*");
> > > >
> > > >       trace_seq_puts(s, " <-");
> > > > -     seq_print_ip_sym(s, entry->graph_ent.retaddr, trace_flags | T=
RACE_ITER_SYM_OFFSET);
> > > > +     seq_print_ip_sym(s, retaddr, trace_flags | TRACE_ITER_SYM_OFF=
SET);
> > > >
> > > >       if (comment)
> > > >               trace_seq_puts(s, " */");
> > > >  }
> > > >  #else
> > > >  #define __TRACE_GRAPH_PRINT_RETADDR 0
> > > > -#define print_graph_retaddr(_seq, _entry, _tflags, _comment)      =
   do { } while (0)
> > > > +#define print_graph_retaddr(_seq, _retaddr, _tflags, _comment)    =
           do { } while (0)
> > > >  #endif
> > > >
> > > >  #if defined(CONFIG_FUNCTION_GRAPH_RETVAL) || defined(CONFIG_FUNCTI=
ON_GRAPH_RETADDR)
> > > > @@ -869,10 +858,12 @@ static void print_graph_retval(struct trace_s=
eq *s, struct ftrace_graph_ent_entr
> > > >               trace_seq_printf(s, "%ps", func);
> > > >
> > > >               if (args_size >=3D FTRACE_REGS_MAX_ARGS * sizeof(long=
)) {
> > > > -                     print_function_args(s, entry->args, (unsigned=
 long)func);
> > > > +                     print_function_args(s, entry->args + ARGS_OFF=
S(args_size),
> > > > +                                         (unsigned long)func);
> > > >                       trace_seq_putc(s, ';');
> > > > -             } else
> > > > +             } else {
> > >
> > > nit: you don't need to add braces for a single line block.
> >
> > Thanks. I added the else braces for consistency with the
> > multi-statement if branch,
> > per coding-style.rst. Happy to remove if you prefer the
> > single-statement exception.
>
> Ah, OK. I also checked this passed checkpatch.pl. (some other
> macros are warned but those are false positive.)

Thanks.

>
> Thanks,
>
> >
> > https://elixir.bootlin.com/linux/v6.18-rc5/source/Documentation/process=
/coding-style.rst#L213
> >
> > Do not unnecessarily use braces where a single statement will do.
> >
> > .. code-block:: c
> >
> > if (condition)
> > action();
> >
> > and
> >
> > .. code-block:: c
> >
> > if (condition)
> > do_this();
> > else
> > do_that();
> >
> > This does not apply if only one branch of a conditional statement is a =
single
> > statement; in the latter case use braces in both branches:
> >
> > .. code-block:: c
> >
> > if (condition) {
> > do_this();
> > do_that();
> > } else {
> > otherwise();
> > }
> >
> > >
> > > >                       trace_seq_puts(s, "();");
> > > > +             }
> > > >
> > > >               if (print_retval || print_retaddr)
> > > >                       trace_seq_puts(s, " /*");
> > > > @@ -882,8 +873,7 @@ static void print_graph_retval(struct trace_seq=
 *s, struct ftrace_graph_ent_entr
> > > >       }
> > > >
> > > >       if (print_retaddr)
> > > > -             print_graph_retaddr(s, (struct fgraph_retaddr_ent_ent=
ry *)entry,
> > > > -                                 trace_flags, false);
> > > > +             print_graph_retaddr(s, entry->args[0], trace_flags, f=
alse);
> > > >
> > > >       if (print_retval) {
> > > >               if (hex_format || (err_code =3D=3D 0))
> > > > @@ -964,10 +954,12 @@ print_graph_entry_leaf(struct trace_iterator =
*iter,
> > > >               trace_seq_printf(s, "%ps", (void *)ret_func);
> > > >
> > > >               if (args_size >=3D FTRACE_REGS_MAX_ARGS * sizeof(long=
)) {
> > > > -                     print_function_args(s, entry->args, ret_func)=
;
> > > > +                     print_function_args(s, entry->args + ARGS_OFF=
S(args_size),
> > > > +                                         ret_func);
> > > >                       trace_seq_putc(s, ';');
> > > > -             } else
> > > > +             } else {
> > >
> > > Ditto.
> > >
> > > >                       trace_seq_puts(s, "();");
> > > > +             }
> > > >       }
> > > >       trace_seq_putc(s, '\n');
> > > >
> > > > @@ -1016,7 +1008,7 @@ print_graph_entry_nested(struct trace_iterato=
r *iter,
> > > >       args_size =3D iter->ent_size - offsetof(struct ftrace_graph_e=
nt_entry, args);
> > > >
> > > >       if (args_size >=3D FTRACE_REGS_MAX_ARGS * sizeof(long))
> > > > -             print_function_args(s, entry->args, func);
> > > > +             print_function_args(s, entry->args + ARGS_OFFS(args_s=
ize), func);
> > > >       else
> > > >               trace_seq_puts(s, "()");
> > > >
> > > > @@ -1024,8 +1016,7 @@ print_graph_entry_nested(struct trace_iterato=
r *iter,
> > > >
> > > >       if (flags & __TRACE_GRAPH_PRINT_RETADDR  &&
> > > >               entry->ent.type =3D=3D TRACE_GRAPH_RETADDR_ENT)
> > > > -             print_graph_retaddr(s, (struct fgraph_retaddr_ent_ent=
ry *)entry,
> > > > -                     tr->trace_flags, true);
> > > > +             print_graph_retaddr(s, entry->args[0], tr->trace_flag=
s, true);
> > > >       trace_seq_putc(s, '\n');
> > > >
> > > >       if (trace_seq_has_overflowed(s))
> > > > @@ -1202,7 +1193,7 @@ print_graph_entry(struct ftrace_graph_ent_ent=
ry *field, struct trace_seq *s,
> > > >        * it can be safely saved at the stack.
> > > >        */
> > > >       struct ftrace_graph_ent_entry *entry;
> > > > -     u8 save_buf[sizeof(*entry) + FTRACE_REGS_MAX_ARGS * sizeof(lo=
ng)];
> > > > +     u8 save_buf[sizeof(*entry) + (FTRACE_REGS_MAX_ARGS + HAVE_RET=
ADDR) * sizeof(long)];
> > > >
> > > >       /* The ent_size is expected to be as big as the entry */
> > > >       if (iter->ent_size > sizeof(save_buf))
> > > > @@ -1429,16 +1420,12 @@ print_graph_function_flags(struct trace_ite=
rator *iter, u32 flags)
> > > >               trace_assign_type(field, entry);
> > > >               return print_graph_entry(field, s, iter, flags);
> > > >       }
> > > > -#ifdef CONFIG_FUNCTION_GRAPH_RETADDR
> > > >       case TRACE_GRAPH_RETADDR_ENT: {
> > > > -             struct fgraph_retaddr_ent_entry saved;
> > > >               struct fgraph_retaddr_ent_entry *rfield;
> > > >
> > > >               trace_assign_type(rfield, entry);
> > > > -             saved =3D *rfield;
> > > > -             return print_graph_entry((struct ftrace_graph_ent_ent=
ry *)&saved, s, iter, flags);
> > > > +             return print_graph_entry((typeof(field))rfield, s, it=
er, flags);
> > > >       }
> > > > -#endif
> > > >       case TRACE_GRAPH_RET: {
> > > >               struct ftrace_graph_ret_entry *field;
> > > >               trace_assign_type(field, entry);
> > > > --
> > > > 2.34.1
> > > >
> > >
> > >
> > > --
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
