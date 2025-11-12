Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1632212F98;
	Wed, 12 Nov 2025 07:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762931420; cv=none; b=c9VYHvHSGYgkW9TUtb7l0eW5qkMLYpzWH++eXUOOi+fzwQH/gbm0gFdIwHZH1qGQcUULRfsKdBRGrtcHePVkGxYuFKD8vPcMt2CIzbwJvZXc3ERMJcu5s7vBdvTqfWnSFEbWzfC9VZIoVMlyltoq44RYY0bkP0lb/9IP/KLuIUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762931420; c=relaxed/simple;
	bh=mMGFa7L88rZ0X2DOZUW3H1j30NK7n2T2amoWGXziV+M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EuapaDq8PFHRpXNrLf8aVrO/2oPEJBje9T4vZebIP4oqsng7XZgVx/F1poyeAXNlsx6xR0MO9oPjzmNvbaVhdhQWeDIzoQDK/vpD2wVo82uGg0bH//fJ0LnUOncTHQpYYWkTmgGGddfq0RBNtcySTcsXFXpg6h2qY1iducxl7po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVaYGYAq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVaYGYAq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7237C2BC86;
	Wed, 12 Nov 2025 07:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762931419;
	bh=mMGFa7L88rZ0X2DOZUW3H1j30NK7n2T2amoWGXziV+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GVaYGYAqqRt832U97Nw7M2eEDBrRt/APQxbKUEFHZ19Yp2rjyKzYgZpCf9jxcaHPg
	 r1h9ATrPmFAmP6AKP80vOtKst5c2nwjuceTmUnU7fUVH7Ih+S2U4JzY8OiOEjfMgWF
	 /YGVt3bCNGr023T9hHEYYtrM9NCOTInT/xgweF2OchcLQ2yzwjdplDau01KxoKisWg
	 PYOzi36mURLLtTQxfy4lyc7P9LQycE6P0ZGYmP+705UC4OOWnbK95s+0I5CM03t/o0
	 Gk+A5yM86FKjp8dCLLCXEW6y5gdOwogLruC5L/9w4fkcKygmZLn508bfTRq2NdlwL1
	 0tRN3GIrZuAmg==
Date: Wed, 12 Nov 2025 16:10:17 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Donglin Peng <pengdonglin@xiaomi.com>, Sven
 Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v3 RESEND] function_graph: Enable funcgraph-args and
 funcgraph-retaddr to work simultaneously
Message-Id: <20251112161017.d9da54e462817cc9053688f6@kernel.org>
In-Reply-To: <CAErzpmsHNRzB2pBFVSAG4ii=VN98NEtehEbnYNQY-4TBWgM3ag@mail.gmail.com>
References: <20251112034333.2901601-1-dolinux.peng@gmail.com>
	<20251112141705.a7f2f79f6d7b058201307e89@kernel.org>
	<CAErzpmsHNRzB2pBFVSAG4ii=VN98NEtehEbnYNQY-4TBWgM3ag@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 12 Nov 2025 14:03:30 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> On Wed, Nov 12, 2025 at 1:17 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Wed, 12 Nov 2025 11:43:33 +0800
> > Donglin Peng <dolinux.peng@gmail.com> wrote:
> >
> > > From: Donglin Peng <pengdonglin@xiaomi.com>
> > >
> > > Currently, the funcgraph-args and funcgraph-retaddr features are mutually exclusive.
> > > This patch resolves this limitation by modifying funcgraph-retaddr to adopt the same
> > > implementation approach as funcgraph-args, specifically by storing the return address
> > > in the first entry of the args array.

Ah, if you can update the patch, please keep each line shorter than
70-75 characters.

> > >
> > > As a result, both features now coexist seamlessly and function as intended.
> > >
> > > To verify the change, use perf to trace vfs_write with both options enabled:
> > >
> > > Before:
> > >  # perf ftrace -G vfs_write --graph-opts args,retaddr
> > >  ......
> > >  0)               |  down_read() { /* <-n_tty_write+0xa3/0x540 */
> > >  0)   0.075 us    |    __cond_resched(); /* <-down_read+0x12/0x160 */
> > >  0)   0.079 us    |    preempt_count_add(); /* <-down_read+0x3b/0x160 */
> > >  0)   0.077 us    |    preempt_count_sub(); /* <-down_read+0x8b/0x160 */
> > >  0)   0.754 us    |  }
> > >
> > > After:
> > >  # perf ftrace -G vfs_write --graph-opts args,retaddr
> > >  ......
> > >  0)               |  down_read(sem=0xffff8880100bea78) { /* <-n_tty_write+0xa3/0x540 */
> > >  0)   0.075 us    |    __cond_resched(); /* <-down_read+0x12/0x160 */
> > >  0)   0.079 us    |    preempt_count_add(val=1); /* <-down_read+0x3b/0x160 */
> > >  0)   0.077 us    |    preempt_count_sub(val=1); /* <-down_read+0x8b/0x160 */
> > >  0)   0.754 us    |  }
> > >
> > > Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> > > Cc: Sven Schnelle <svens@linux.ibm.com>
> > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> >
> > Looks good to me except for a few nits, but it's a style issue.
> >
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Thank you for ack.
> 
> >
> > Thank you,
> >
> > > ---
> > > v3:
> > > - Replace min() with min_t() to improve type safety and maintainability
> > > - Keep only one Signed-off-by for cleaner attribution
> > > - Code refactoring for improved readability
> > >
> > > v2:
> > > - Preserve retaddr event functionality (suggested by Steven)
> > > - Store the retaddr in args[0] (suggested by Steven)
> > > - Refactor implementation logic and commit message clarity
> > > ---
> > >  include/linux/ftrace.h               |  11 --
> > >  kernel/trace/trace.h                 |   4 -
> > >  kernel/trace/trace_entries.h         |   6 +-
> > >  kernel/trace/trace_functions_graph.c | 145 ++++++++++++---------------
> > >  4 files changed, 69 insertions(+), 97 deletions(-)
> > >
> > > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > > index 7ded7df6e9b5..88cb54d73bdb 100644
> > > --- a/include/linux/ftrace.h
> > > +++ b/include/linux/ftrace.h
> > > @@ -1129,17 +1129,6 @@ struct ftrace_graph_ent {
> > >       int depth;
> > >  } __packed;
> > >
> > > -/*
> > > - * Structure that defines an entry function trace with retaddr.
> > > - * It's already packed but the attribute "packed" is needed
> > > - * to remove extra padding at the end.
> > > - */
> > > -struct fgraph_retaddr_ent {
> > > -     unsigned long func; /* Current function */
> > > -     int depth;
> > > -     unsigned long retaddr;  /* Return address */
> > > -} __packed;
> > > -
> > >  /*
> > >   * Structure that defines a return function trace.
> > >   * It's already packed but the attribute "packed" is needed
> > > diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> > > index 85eabb454bee..9fac291b913a 100644
> > > --- a/kernel/trace/trace.h
> > > +++ b/kernel/trace/trace.h
> > > @@ -955,10 +955,6 @@ extern void graph_trace_close(struct trace_iterator *iter);
> > >  extern int __trace_graph_entry(struct trace_array *tr,
> > >                              struct ftrace_graph_ent *trace,
> > >                              unsigned int trace_ctx);
> > > -extern int __trace_graph_retaddr_entry(struct trace_array *tr,
> > > -                             struct ftrace_graph_ent *trace,
> > > -                             unsigned int trace_ctx,
> > > -                             unsigned long retaddr);
> > >  extern void __trace_graph_return(struct trace_array *tr,
> > >                                struct ftrace_graph_ret *trace,
> > >                                unsigned int trace_ctx,
> > > diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> > > index de294ae2c5c5..593a74663c65 100644
> > > --- a/kernel/trace/trace_entries.h
> > > +++ b/kernel/trace/trace_entries.h
> > > @@ -95,14 +95,14 @@ FTRACE_ENTRY_PACKED(fgraph_retaddr_entry, fgraph_retaddr_ent_entry,
> > >       TRACE_GRAPH_RETADDR_ENT,
> > >
> > >       F_STRUCT(
> > > -             __field_struct( struct fgraph_retaddr_ent,      graph_ent       )
> > > +             __field_struct( struct ftrace_graph_ent,        graph_ent       )
> > >               __field_packed( unsigned long,  graph_ent,      func            )
> > >               __field_packed( unsigned int,   graph_ent,      depth           )
> > > -             __field_packed( unsigned long,  graph_ent,      retaddr         )
> > > +             __dynamic_array(unsigned long,  args                            )
> > >       ),
> > >
> > >       F_printk("--> %ps (%u) <- %ps", (void *)__entry->func, __entry->depth,
> > > -             (void *)__entry->retaddr)
> > > +             (void *)__entry->args[0])
> > >  );
> > >
> > >  #else
> > > diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
> > > index a7f4b9a47a71..f31eeeffbb2d 100644
> > > --- a/kernel/trace/trace_functions_graph.c
> > > +++ b/kernel/trace/trace_functions_graph.c
> > > @@ -16,6 +16,15 @@
> > >  #include "trace.h"
> > >  #include "trace_output.h"
> > >
> > > +#ifdef CONFIG_FUNCTION_GRAPH_RETADDR
> > > +#define HAVE_RETADDR 1
> > > +#define ARGS_OFFS(args_size) \
> > > +     ((args_size) > FTRACE_REGS_MAX_ARGS * sizeof(long) ? 1 : 0)
> > > +#else
> > > +#define HAVE_RETADDR 0
> > > +#define ARGS_OFFS(args_size) 0
> > > +#endif
> > > +
> > >  /* When set, irq functions will be ignored */
> > >  static int ftrace_graph_skip_irqs;
> > >
> > > @@ -27,21 +36,25 @@ struct fgraph_cpu_data {
> > >       unsigned long   enter_funcs[FTRACE_RETFUNC_DEPTH];
> > >  };
> > >
> > > +/*
> > > + * fgraph_retaddr_ent_entry and ftrace_graph_ent_entry share layout, ent
> > > + * member repurposed for storage
> > > + */
> > >  struct fgraph_ent_args {
> > >       struct ftrace_graph_ent_entry   ent;
> > > -     /* Force the sizeof of args[] to have FTRACE_REGS_MAX_ARGS entries */
> > > -     unsigned long                   args[FTRACE_REGS_MAX_ARGS];
> > > +     /*
> > > +      * Force the sizeof of args[] to have (FTRACE_REGS_MAX_ARGS + HAVE_RETADDR)
> > > +      * entries with the first entry storing the return address for
> > > +      * TRACE_GRAPH_RETADDR_ENT.
> > > +      */
> > > +     unsigned long           args[FTRACE_REGS_MAX_ARGS + HAVE_RETADDR];
> > >  };
> > >
> > >  struct fgraph_data {
> > >       struct fgraph_cpu_data __percpu *cpu_data;
> > >
> > >       /* Place to preserve last processed entry. */
> > > -     union {
> > > -             struct fgraph_ent_args          ent;
> > > -             /* TODO allow retaddr to have args */
> > > -             struct fgraph_retaddr_ent_entry rent;
> > > -     };
> > > +     struct fgraph_ent_args          ent;
> > >       struct ftrace_graph_ret_entry   ret;
> > >       int                             failed;
> > >       int                             cpu;
> > > @@ -127,22 +140,43 @@ static int __graph_entry(struct trace_array *tr, struct ftrace_graph_ent *trace,
> > >       struct ring_buffer_event *event;
> > >       struct trace_buffer *buffer = tr->array_buffer.buffer;
> > >       struct ftrace_graph_ent_entry *entry;
> > > -     int size;
> > > +     unsigned long retaddr = 0;
> > > +     int size = sizeof(*entry);
> > > +     int type = TRACE_GRAPH_ENT;
> > > +     bool store_args = false;
> > > +     int nr_args = 0, args_offs = 0;
> > > +
> > > +     if (tracer_flags_is_set(TRACE_GRAPH_PRINT_RETADDR)) {
> > > +             retaddr = ftrace_graph_top_ret_addr(current);
> > > +             type = TRACE_GRAPH_RETADDR_ENT;
> > > +             nr_args += 1;
> > > +     }
> > >
> > >       /* If fregs is defined, add FTRACE_REGS_MAX_ARGS long size words */
> > > -     size = sizeof(*entry) + (FTRACE_REGS_MAX_ARGS * !!fregs * sizeof(long));
> > > +     if (tracer_flags_is_set(TRACE_GRAPH_ARGS)) {
> > > +             store_args = !!fregs;
> > > +             if (store_args)
> > > +                     nr_args += FTRACE_REGS_MAX_ARGS;
> > > +     }
> > >
> > > -     event = trace_buffer_lock_reserve(buffer, TRACE_GRAPH_ENT, size, trace_ctx);
> > > +     size += nr_args * sizeof(long);
> > > +     event = trace_buffer_lock_reserve(buffer, type, size, trace_ctx);
> > >       if (!event)
> > >               return 0;
> > >
> > >       entry = ring_buffer_event_data(event);
> > >       entry->graph_ent = *trace;
> > >
> > > +     /* Store the retaddr in args[0] */
> > > +     if (type == TRACE_GRAPH_RETADDR_ENT) {
> > > +             entry->args[0] = retaddr;
> > > +             args_offs += 1;
> > > +     }
> > > +
> > >  #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
> > > -     if (fregs) {
> > > +     if (store_args) {
> > >               for (int i = 0; i < FTRACE_REGS_MAX_ARGS; i++)
> > > -                     entry->args[i] = ftrace_regs_get_argument(fregs, i);
> > > +                     entry->args[i + args_offs] = ftrace_regs_get_argument(fregs, i);
> > >       }
> > >  #endif
> > >
> > > @@ -158,38 +192,6 @@ int __trace_graph_entry(struct trace_array *tr,
> > >       return __graph_entry(tr, trace, trace_ctx, NULL);
> > >  }
> > >
> > > -#ifdef CONFIG_FUNCTION_GRAPH_RETADDR
> > > -int __trace_graph_retaddr_entry(struct trace_array *tr,
> > > -                             struct ftrace_graph_ent *trace,
> > > -                             unsigned int trace_ctx,
> > > -                             unsigned long retaddr)
> > > -{
> > > -     struct ring_buffer_event *event;
> > > -     struct trace_buffer *buffer = tr->array_buffer.buffer;
> > > -     struct fgraph_retaddr_ent_entry *entry;
> > > -
> > > -     event = trace_buffer_lock_reserve(buffer, TRACE_GRAPH_RETADDR_ENT,
> > > -                                       sizeof(*entry), trace_ctx);
> > > -     if (!event)
> > > -             return 0;
> > > -     entry   = ring_buffer_event_data(event);
> > > -     entry->graph_ent.func = trace->func;
> > > -     entry->graph_ent.depth = trace->depth;
> > > -     entry->graph_ent.retaddr = retaddr;
> > > -     trace_buffer_unlock_commit_nostack(buffer, event);
> > > -
> > > -     return 1;
> > > -}
> > > -#else
> > > -int __trace_graph_retaddr_entry(struct trace_array *tr,
> > > -                             struct ftrace_graph_ent *trace,
> > > -                             unsigned int trace_ctx,
> > > -                             unsigned long retaddr)
> > > -{
> > > -     return 1;
> > > -}
> > > -#endif
> > > -
> > >  static inline int ftrace_graph_ignore_irqs(void)
> > >  {
> > >       if (!ftrace_graph_skip_irqs || trace_recursion_test(TRACE_IRQ_BIT))
> > > @@ -211,7 +213,6 @@ static int graph_entry(struct ftrace_graph_ent *trace,
> > >       struct trace_array *tr = gops->private;
> > >       struct fgraph_times *ftimes;
> > >       unsigned int trace_ctx;
> > > -     int ret = 0;
> > >
> > >       if (*task_var & TRACE_GRAPH_NOTRACE)
> > >               return 0;
> > > @@ -262,15 +263,7 @@ static int graph_entry(struct ftrace_graph_ent *trace,
> > >               return 1;
> > >
> > >       trace_ctx = tracing_gen_ctx();
> > > -     if (IS_ENABLED(CONFIG_FUNCTION_GRAPH_RETADDR) &&
> > > -         tracer_flags_is_set(TRACE_GRAPH_PRINT_RETADDR)) {
> > > -             unsigned long retaddr = ftrace_graph_top_ret_addr(current);
> > > -             ret = __trace_graph_retaddr_entry(tr, trace, trace_ctx, retaddr);
> > > -     } else {
> > > -             ret = __graph_entry(tr, trace, trace_ctx, fregs);
> > > -     }
> > > -
> > > -     return ret;
> > > +     return __graph_entry(tr, trace, trace_ctx, fregs);
> > >  }
> > >
> > >  int trace_graph_entry(struct ftrace_graph_ent *trace,
> > > @@ -634,13 +627,9 @@ get_return_for_leaf(struct trace_iterator *iter,
> > >                        * Save current and next entries for later reference
> > >                        * if the output fails.
> > >                        */
> > > -                     if (unlikely(curr->ent.type == TRACE_GRAPH_RETADDR_ENT)) {
> > > -                             data->rent = *(struct fgraph_retaddr_ent_entry *)curr;
> > > -                     } else {
> > > -                             int size = min((int)sizeof(data->ent), (int)iter->ent_size);
> > > +                     int size = min_t(int, sizeof(data->ent), iter->ent_size);
> > >
> > > -                             memcpy(&data->ent, curr, size);
> > > -                     }
> > > +                     memcpy(&data->ent, curr, size);
> > >                       /*
> > >                        * If the next event is not a return type, then
> > >                        * we only care about what type it is. Otherwise we can
> > > @@ -811,21 +800,21 @@ print_graph_duration(struct trace_array *tr, unsigned long long duration,
> > >
> > >  #ifdef CONFIG_FUNCTION_GRAPH_RETADDR
> > >  #define __TRACE_GRAPH_PRINT_RETADDR TRACE_GRAPH_PRINT_RETADDR
> > > -static void print_graph_retaddr(struct trace_seq *s, struct fgraph_retaddr_ent_entry *entry,
> > > -                             u32 trace_flags, bool comment)
> > > +static void print_graph_retaddr(struct trace_seq *s, unsigned long retaddr, u32 trace_flags,
> > > +                             bool comment)
> > >  {
> > >       if (comment)
> > >               trace_seq_puts(s, " /*");
> > >
> > >       trace_seq_puts(s, " <-");
> > > -     seq_print_ip_sym(s, entry->graph_ent.retaddr, trace_flags | TRACE_ITER_SYM_OFFSET);
> > > +     seq_print_ip_sym(s, retaddr, trace_flags | TRACE_ITER_SYM_OFFSET);
> > >
> > >       if (comment)
> > >               trace_seq_puts(s, " */");
> > >  }
> > >  #else
> > >  #define __TRACE_GRAPH_PRINT_RETADDR 0
> > > -#define print_graph_retaddr(_seq, _entry, _tflags, _comment)         do { } while (0)
> > > +#define print_graph_retaddr(_seq, _retaddr, _tflags, _comment)               do { } while (0)
> > >  #endif
> > >
> > >  #if defined(CONFIG_FUNCTION_GRAPH_RETVAL) || defined(CONFIG_FUNCTION_GRAPH_RETADDR)
> > > @@ -869,10 +858,12 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
> > >               trace_seq_printf(s, "%ps", func);
> > >
> > >               if (args_size >= FTRACE_REGS_MAX_ARGS * sizeof(long)) {
> > > -                     print_function_args(s, entry->args, (unsigned long)func);
> > > +                     print_function_args(s, entry->args + ARGS_OFFS(args_size),
> > > +                                         (unsigned long)func);
> > >                       trace_seq_putc(s, ';');
> > > -             } else
> > > +             } else {
> >
> > nit: you don't need to add braces for a single line block.
> 
> Thanks. I added the else braces for consistency with the
> multi-statement if branch,
> per coding-style.rst. Happy to remove if you prefer the
> single-statement exception.

Ah, OK. I also checked this passed checkpatch.pl. (some other
macros are warned but those are false positive.)

Thanks,

> 
> https://elixir.bootlin.com/linux/v6.18-rc5/source/Documentation/process/coding-style.rst#L213
> 
> Do not unnecessarily use braces where a single statement will do.
> 
> .. code-block:: c
> 
> if (condition)
> action();
> 
> and
> 
> .. code-block:: c
> 
> if (condition)
> do_this();
> else
> do_that();
> 
> This does not apply if only one branch of a conditional statement is a single
> statement; in the latter case use braces in both branches:
> 
> .. code-block:: c
> 
> if (condition) {
> do_this();
> do_that();
> } else {
> otherwise();
> }
> 
> >
> > >                       trace_seq_puts(s, "();");
> > > +             }
> > >
> > >               if (print_retval || print_retaddr)
> > >                       trace_seq_puts(s, " /*");
> > > @@ -882,8 +873,7 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
> > >       }
> > >
> > >       if (print_retaddr)
> > > -             print_graph_retaddr(s, (struct fgraph_retaddr_ent_entry *)entry,
> > > -                                 trace_flags, false);
> > > +             print_graph_retaddr(s, entry->args[0], trace_flags, false);
> > >
> > >       if (print_retval) {
> > >               if (hex_format || (err_code == 0))
> > > @@ -964,10 +954,12 @@ print_graph_entry_leaf(struct trace_iterator *iter,
> > >               trace_seq_printf(s, "%ps", (void *)ret_func);
> > >
> > >               if (args_size >= FTRACE_REGS_MAX_ARGS * sizeof(long)) {
> > > -                     print_function_args(s, entry->args, ret_func);
> > > +                     print_function_args(s, entry->args + ARGS_OFFS(args_size),
> > > +                                         ret_func);
> > >                       trace_seq_putc(s, ';');
> > > -             } else
> > > +             } else {
> >
> > Ditto.
> >
> > >                       trace_seq_puts(s, "();");
> > > +             }
> > >       }
> > >       trace_seq_putc(s, '\n');
> > >
> > > @@ -1016,7 +1008,7 @@ print_graph_entry_nested(struct trace_iterator *iter,
> > >       args_size = iter->ent_size - offsetof(struct ftrace_graph_ent_entry, args);
> > >
> > >       if (args_size >= FTRACE_REGS_MAX_ARGS * sizeof(long))
> > > -             print_function_args(s, entry->args, func);
> > > +             print_function_args(s, entry->args + ARGS_OFFS(args_size), func);
> > >       else
> > >               trace_seq_puts(s, "()");
> > >
> > > @@ -1024,8 +1016,7 @@ print_graph_entry_nested(struct trace_iterator *iter,
> > >
> > >       if (flags & __TRACE_GRAPH_PRINT_RETADDR  &&
> > >               entry->ent.type == TRACE_GRAPH_RETADDR_ENT)
> > > -             print_graph_retaddr(s, (struct fgraph_retaddr_ent_entry *)entry,
> > > -                     tr->trace_flags, true);
> > > +             print_graph_retaddr(s, entry->args[0], tr->trace_flags, true);
> > >       trace_seq_putc(s, '\n');
> > >
> > >       if (trace_seq_has_overflowed(s))
> > > @@ -1202,7 +1193,7 @@ print_graph_entry(struct ftrace_graph_ent_entry *field, struct trace_seq *s,
> > >        * it can be safely saved at the stack.
> > >        */
> > >       struct ftrace_graph_ent_entry *entry;
> > > -     u8 save_buf[sizeof(*entry) + FTRACE_REGS_MAX_ARGS * sizeof(long)];
> > > +     u8 save_buf[sizeof(*entry) + (FTRACE_REGS_MAX_ARGS + HAVE_RETADDR) * sizeof(long)];
> > >
> > >       /* The ent_size is expected to be as big as the entry */
> > >       if (iter->ent_size > sizeof(save_buf))
> > > @@ -1429,16 +1420,12 @@ print_graph_function_flags(struct trace_iterator *iter, u32 flags)
> > >               trace_assign_type(field, entry);
> > >               return print_graph_entry(field, s, iter, flags);
> > >       }
> > > -#ifdef CONFIG_FUNCTION_GRAPH_RETADDR
> > >       case TRACE_GRAPH_RETADDR_ENT: {
> > > -             struct fgraph_retaddr_ent_entry saved;
> > >               struct fgraph_retaddr_ent_entry *rfield;
> > >
> > >               trace_assign_type(rfield, entry);
> > > -             saved = *rfield;
> > > -             return print_graph_entry((struct ftrace_graph_ent_entry *)&saved, s, iter, flags);
> > > +             return print_graph_entry((typeof(field))rfield, s, iter, flags);
> > >       }
> > > -#endif
> > >       case TRACE_GRAPH_RET: {
> > >               struct ftrace_graph_ret_entry *field;
> > >               trace_assign_type(field, entry);
> > > --
> > > 2.34.1
> > >
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
