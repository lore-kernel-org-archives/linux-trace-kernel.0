Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C252FE06F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762938026; cv=none; b=pofxbnMB3EjMmA/OoJRsr1e223hRt78yrK65m8nUjWj4EET20OObDraKqf1zQH5stVB3PnYLKwiFiMKWvE/lmkx7M2jIY+Xf1P1CkMQyDKbB9rdUtkPpLtkPqqUdBaVxXW9p0dz2u2CeR6VNEkrIRzSj17vlikuGssGjfVMWRd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762938026; c=relaxed/simple;
	bh=R1hewu85qlbkPiU7PP4BTzIMfmo5zBd6Xy/n/M3FoWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAf+Qv6kz2IWMBc6ZT9722meuSQe2j5IilJ1GQleGdyuze3eye6M9n/FhKQF2xFUHGcewsZrESrdLnnMoephe6nSSPqASEEA61oq27uNvfg8awBOVOP+r5SWpSbrFqz9IsdbiTr3i8/7TfHXDhqJz9zSzvY98uke7htd6+dTZlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAdX53NK; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAdX53NK"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b72dc0c15abso107670066b.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762938023; x=1763542823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wUzZ1J4QUUkfnTt6No5p+0Nur0E9IIYtv9QpuK6/h8=;
        b=MAdX53NKOzOuLJBum3uFwj94QwjhCoF4fKmX75St+hMuHZS10lQ90rmdEvHEvsFglA
         aKPBcFWZOCEhCMO92ZMqiVkGJf/Z5c1O6vurdzz5KTVUAXxyGfhVSvt3fyezWN03O1Q4
         lzepS2AZF1PU/2pOnoOWUsVMEzagBA0GOwvP484e86Lw6masvSaPtwFS6UYXxtfED8gp
         Lr25GegPScXlKTxE7MptWo70GXlsWdEcCUeQFG8qCEHNAKdYdWMtQWsDqeDu5BDn9dnu
         YHuVwfup6waD7XC5cYe+A+WYXtUaxzHTQbKZjbzNOE/PBjPLjAjPBVrNQ3WWPZsaq0u1
         e+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762938023; x=1763542823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8wUzZ1J4QUUkfnTt6No5p+0Nur0E9IIYtv9QpuK6/h8=;
        b=AJbN2G2wqDtr3N+FDQnk6IRPvZx/fxzncU/JXsCAgcDqPNkCrV7FeH8yhKoCXGcmDL
         qnU1ZlemFKV8PHkJQ5cDoDLLs6kItBzOayB3XT/wU/kjc4QB9cL8zFjCyMgeL2LB7uiU
         ZH0Vkpb17bpdc5Dlg5EujZCkbQXuAiSxXi1XfEqNiCzvJ75P4EC/rsmADE9puu4hb6/D
         uQ3sbNs3/jWFCyp/28HMyhCvgRmdxHmRt/PTlgyOHKUJc6PfkH3YPtaJ+AyNmhbMlQBx
         VRDdygRrC8FP9Rs9iNpXV/rguFCJ6OGiu6x8V1yxQIHe5sJm1KpL3r0+nmr3K/VsulFY
         n+cA==
X-Gm-Message-State: AOJu0Yw/WmtL/wWZFJlTBfi+cUfeS6K4wVM2ZRWeJmCQ/aKdvvYSbZ4f
	ncMmRqYDZZlP0yo7CFwNVupcgLRPMDnO4zmCCruJ1WVDXyuSnDPvLZVphwMH8bSxwjYz5pQTvAp
	vfTiDp3SnZ1qUu8HZ3wLsjolNGOWh1pM=
X-Gm-Gg: ASbGncs2/Q4catPoarP889/orBfO6l+OpxeGPO7YyPg2LsXo0SB9pbusXXO7Ahic0D/
	USBYMHIt7aJNEwpbskmfHf2njRVPjBUVsIZLWeEJ6iY4ObDkGD0GmkUAT0KryJ+xZMYnSIVC9Ty
	6G4Qq7sfh73RfPoF30tBH+RWATsNtIQRZiBHZvG7NA14t15V6XlXDCCv9q/fDQNOEVlagklBKj8
	CAVxuMoia0ntSgiyJL8Q+wWe4v+8KubG/A6G2HwrcZjZNpXIDc/FvXiFmwgUdYpIIKzb9gl
X-Google-Smtp-Source: AGHT+IFKTHqG2erxhNaW1o6eidaIAyv17IEVmWyodUDhkSj5SvFo6hPScvi9VeDctAQbXaduAVVgfHCLU5MHLZplfoc=
X-Received: by 2002:a17:907:7b8c:b0:b72:ad95:c1c2 with SMTP id
 a640c23a62f3a-b7331960ccamr243260266b.11.1762938022371; Wed, 12 Nov 2025
 01:00:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112034333.2901601-1-dolinux.peng@gmail.com>
In-Reply-To: <20251112034333.2901601-1-dolinux.peng@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 12 Nov 2025 17:00:10 +0800
X-Gm-Features: AWmQ_bleyD4lFjHUTlYI5gBNqL7IhTLpdeow3W6KJ-3wh7aJ4AO_-Y1GjDL7gfo
Message-ID: <CAErzpms8oRkqJhxk1R6LMUq1GeZT3TqkPOm2yRAfY1ph_F2YNw@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] function_graph: Enable funcgraph-args and
 funcgraph-retaddr to work simultaneously
To: rostedt@goodmis.org, Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 11:46=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.c=
om> wrote:
>
> From: Donglin Peng <pengdonglin@xiaomi.com>
>
> Currently, the funcgraph-args and funcgraph-retaddr features are mutually=
 exclusive.
> This patch resolves this limitation by modifying funcgraph-retaddr to ado=
pt the same
> implementation approach as funcgraph-args, specifically by storing the re=
turn address
> in the first entry of the args array.
>
> As a result, both features now coexist seamlessly and function as intende=
d.
>
> To verify the change, use perf to trace vfs_write with both options enabl=
ed:
>
> Before:
>  # perf ftrace -G vfs_write --graph-opts args,retaddr
>  ......
>  0)               |  down_read() { /* <-n_tty_write+0xa3/0x540 */
>  0)   0.075 us    |    __cond_resched(); /* <-down_read+0x12/0x160 */
>  0)   0.079 us    |    preempt_count_add(); /* <-down_read+0x3b/0x160 */
>  0)   0.077 us    |    preempt_count_sub(); /* <-down_read+0x8b/0x160 */
>  0)   0.754 us    |  }
>
> After:
>  # perf ftrace -G vfs_write --graph-opts args,retaddr
>  ......
>  0)               |  down_read(sem=3D0xffff8880100bea78) { /* <-n_tty_wri=
te+0xa3/0x540 */
>  0)   0.075 us    |    __cond_resched(); /* <-down_read+0x12/0x160 */
>  0)   0.079 us    |    preempt_count_add(val=3D1); /* <-down_read+0x3b/0x=
160 */
>  0)   0.077 us    |    preempt_count_sub(val=3D1); /* <-down_read+0x8b/0x=
160 */
>  0)   0.754 us    |  }
>
> Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> ---
> v3:
> - Replace min() with min_t() to improve type safety and maintainability
> - Keep only one Signed-off-by for cleaner attribution
> - Code refactoring for improved readability
>
> v2:
> - Preserve retaddr event functionality (suggested by Steven)
> - Store the retaddr in args[0] (suggested by Steven)
> - Refactor implementation logic and commit message clarity
> ---
>  include/linux/ftrace.h               |  11 --
>  kernel/trace/trace.h                 |   4 -
>  kernel/trace/trace_entries.h         |   6 +-
>  kernel/trace/trace_functions_graph.c | 145 ++++++++++++---------------
>  4 files changed, 69 insertions(+), 97 deletions(-)
>
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 7ded7df6e9b5..88cb54d73bdb 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -1129,17 +1129,6 @@ struct ftrace_graph_ent {
>         int depth;
>  } __packed;
>
> -/*
> - * Structure that defines an entry function trace with retaddr.
> - * It's already packed but the attribute "packed" is needed
> - * to remove extra padding at the end.
> - */
> -struct fgraph_retaddr_ent {
> -       unsigned long func; /* Current function */
> -       int depth;
> -       unsigned long retaddr;  /* Return address */
> -} __packed;
> -
>  /*
>   * Structure that defines a return function trace.
>   * It's already packed but the attribute "packed" is needed
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 85eabb454bee..9fac291b913a 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -955,10 +955,6 @@ extern void graph_trace_close(struct trace_iterator =
*iter);
>  extern int __trace_graph_entry(struct trace_array *tr,
>                                struct ftrace_graph_ent *trace,
>                                unsigned int trace_ctx);
> -extern int __trace_graph_retaddr_entry(struct trace_array *tr,
> -                               struct ftrace_graph_ent *trace,
> -                               unsigned int trace_ctx,
> -                               unsigned long retaddr);
>  extern void __trace_graph_return(struct trace_array *tr,
>                                  struct ftrace_graph_ret *trace,
>                                  unsigned int trace_ctx,
> diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> index de294ae2c5c5..593a74663c65 100644
> --- a/kernel/trace/trace_entries.h
> +++ b/kernel/trace/trace_entries.h
> @@ -95,14 +95,14 @@ FTRACE_ENTRY_PACKED(fgraph_retaddr_entry, fgraph_reta=
ddr_ent_entry,
>         TRACE_GRAPH_RETADDR_ENT,
>
>         F_STRUCT(
> -               __field_struct( struct fgraph_retaddr_ent,      graph_ent=
       )
> +               __field_struct( struct ftrace_graph_ent,        graph_ent=
       )
>                 __field_packed( unsigned long,  graph_ent,      func     =
       )
>                 __field_packed( unsigned int,   graph_ent,      depth    =
       )
> -               __field_packed( unsigned long,  graph_ent,      retaddr  =
       )
> +               __dynamic_array(unsigned long,  args                     =
       )
>         ),
>
>         F_printk("--> %ps (%u) <- %ps", (void *)__entry->func, __entry->d=
epth,
> -               (void *)__entry->retaddr)
> +               (void *)__entry->args[0])
>  );
>
>  #else
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_fu=
nctions_graph.c
> index a7f4b9a47a71..f31eeeffbb2d 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -16,6 +16,15 @@
>  #include "trace.h"
>  #include "trace_output.h"
>
> +#ifdef CONFIG_FUNCTION_GRAPH_RETADDR
> +#define HAVE_RETADDR   1
> +#define ARGS_OFFS(args_size) \
> +       ((args_size) > FTRACE_REGS_MAX_ARGS * sizeof(long) ? 1 : 0)
> +#else
> +#define HAVE_RETADDR   0
> +#define ARGS_OFFS(args_size)   0
> +#endif
> +
>  /* When set, irq functions will be ignored */
>  static int ftrace_graph_skip_irqs;
>
> @@ -27,21 +36,25 @@ struct fgraph_cpu_data {
>         unsigned long   enter_funcs[FTRACE_RETFUNC_DEPTH];
>  };
>
> +/*
> + * fgraph_retaddr_ent_entry and ftrace_graph_ent_entry share layout, ent
> + * member repurposed for storage
> + */
>  struct fgraph_ent_args {
>         struct ftrace_graph_ent_entry   ent;
> -       /* Force the sizeof of args[] to have FTRACE_REGS_MAX_ARGS entrie=
s */
> -       unsigned long                   args[FTRACE_REGS_MAX_ARGS];
> +       /*
> +        * Force the sizeof of args[] to have (FTRACE_REGS_MAX_ARGS + HAV=
E_RETADDR)
> +        * entries with the first entry storing the return address for
> +        * TRACE_GRAPH_RETADDR_ENT.
> +        */
> +       unsigned long           args[FTRACE_REGS_MAX_ARGS + HAVE_RETADDR]=
;
>  };
>
>  struct fgraph_data {
>         struct fgraph_cpu_data __percpu *cpu_data;
>
>         /* Place to preserve last processed entry. */
> -       union {
> -               struct fgraph_ent_args          ent;
> -               /* TODO allow retaddr to have args */
> -               struct fgraph_retaddr_ent_entry rent;
> -       };
> +       struct fgraph_ent_args          ent;
>         struct ftrace_graph_ret_entry   ret;
>         int                             failed;
>         int                             cpu;
> @@ -127,22 +140,43 @@ static int __graph_entry(struct trace_array *tr, st=
ruct ftrace_graph_ent *trace,
>         struct ring_buffer_event *event;
>         struct trace_buffer *buffer =3D tr->array_buffer.buffer;
>         struct ftrace_graph_ent_entry *entry;
> -       int size;
> +       unsigned long retaddr =3D 0;
> +       int size =3D sizeof(*entry);
> +       int type =3D TRACE_GRAPH_ENT;
> +       bool store_args =3D false;
> +       int nr_args =3D 0, args_offs =3D 0;
> +
> +       if (tracer_flags_is_set(TRACE_GRAPH_PRINT_RETADDR)) {
> +               retaddr =3D ftrace_graph_top_ret_addr(current);
> +               type =3D TRACE_GRAPH_RETADDR_ENT;
> +               nr_args +=3D 1;
> +       }
>
>         /* If fregs is defined, add FTRACE_REGS_MAX_ARGS long size words =
*/
> -       size =3D sizeof(*entry) + (FTRACE_REGS_MAX_ARGS * !!fregs * sizeo=
f(long));
> +       if (tracer_flags_is_set(TRACE_GRAPH_ARGS)) {
> +               store_args =3D !!fregs;
> +               if (store_args)
> +                       nr_args +=3D FTRACE_REGS_MAX_ARGS;
> +       }
>
> -       event =3D trace_buffer_lock_reserve(buffer, TRACE_GRAPH_ENT, size=
, trace_ctx);
> +       size +=3D nr_args * sizeof(long);
> +       event =3D trace_buffer_lock_reserve(buffer, type, size, trace_ctx=
);
>         if (!event)
>                 return 0;
>
>         entry =3D ring_buffer_event_data(event);
>         entry->graph_ent =3D *trace;
>
> +       /* Store the retaddr in args[0] */
> +       if (type =3D=3D TRACE_GRAPH_RETADDR_ENT) {
> +               entry->args[0] =3D retaddr;
> +               args_offs +=3D 1;
> +       }
> +
>  #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
> -       if (fregs) {
> +       if (store_args) {
>                 for (int i =3D 0; i < FTRACE_REGS_MAX_ARGS; i++)
> -                       entry->args[i] =3D ftrace_regs_get_argument(fregs=
, i);
> +                       entry->args[i + args_offs] =3D ftrace_regs_get_ar=
gument(fregs, i);
>         }
>  #endif
>
> @@ -158,38 +192,6 @@ int __trace_graph_entry(struct trace_array *tr,
>         return __graph_entry(tr, trace, trace_ctx, NULL);
>  }
>
> -#ifdef CONFIG_FUNCTION_GRAPH_RETADDR
> -int __trace_graph_retaddr_entry(struct trace_array *tr,
> -                               struct ftrace_graph_ent *trace,
> -                               unsigned int trace_ctx,
> -                               unsigned long retaddr)
> -{
> -       struct ring_buffer_event *event;
> -       struct trace_buffer *buffer =3D tr->array_buffer.buffer;
> -       struct fgraph_retaddr_ent_entry *entry;
> -
> -       event =3D trace_buffer_lock_reserve(buffer, TRACE_GRAPH_RETADDR_E=
NT,
> -                                         sizeof(*entry), trace_ctx);
> -       if (!event)
> -               return 0;
> -       entry   =3D ring_buffer_event_data(event);
> -       entry->graph_ent.func =3D trace->func;
> -       entry->graph_ent.depth =3D trace->depth;
> -       entry->graph_ent.retaddr =3D retaddr;
> -       trace_buffer_unlock_commit_nostack(buffer, event);
> -
> -       return 1;
> -}
> -#else
> -int __trace_graph_retaddr_entry(struct trace_array *tr,
> -                               struct ftrace_graph_ent *trace,
> -                               unsigned int trace_ctx,
> -                               unsigned long retaddr)
> -{
> -       return 1;
> -}
> -#endif
> -
>  static inline int ftrace_graph_ignore_irqs(void)
>  {
>         if (!ftrace_graph_skip_irqs || trace_recursion_test(TRACE_IRQ_BIT=
))
> @@ -211,7 +213,6 @@ static int graph_entry(struct ftrace_graph_ent *trace=
,
>         struct trace_array *tr =3D gops->private;
>         struct fgraph_times *ftimes;
>         unsigned int trace_ctx;
> -       int ret =3D 0;
>
>         if (*task_var & TRACE_GRAPH_NOTRACE)
>                 return 0;
> @@ -262,15 +263,7 @@ static int graph_entry(struct ftrace_graph_ent *trac=
e,
>                 return 1;
>
>         trace_ctx =3D tracing_gen_ctx();
> -       if (IS_ENABLED(CONFIG_FUNCTION_GRAPH_RETADDR) &&
> -           tracer_flags_is_set(TRACE_GRAPH_PRINT_RETADDR)) {
> -               unsigned long retaddr =3D ftrace_graph_top_ret_addr(curre=
nt);
> -               ret =3D __trace_graph_retaddr_entry(tr, trace, trace_ctx,=
 retaddr);
> -       } else {
> -               ret =3D __graph_entry(tr, trace, trace_ctx, fregs);
> -       }
> -
> -       return ret;
> +       return __graph_entry(tr, trace, trace_ctx, fregs);
>  }
>
>  int trace_graph_entry(struct ftrace_graph_ent *trace,
> @@ -634,13 +627,9 @@ get_return_for_leaf(struct trace_iterator *iter,
>                          * Save current and next entries for later refere=
nce
>                          * if the output fails.
>                          */
> -                       if (unlikely(curr->ent.type =3D=3D TRACE_GRAPH_RE=
TADDR_ENT)) {
> -                               data->rent =3D *(struct fgraph_retaddr_en=
t_entry *)curr;
> -                       } else {
> -                               int size =3D min((int)sizeof(data->ent), =
(int)iter->ent_size);
> +                       int size =3D min_t(int, sizeof(data->ent), iter->=
ent_size);
>
> -                               memcpy(&data->ent, curr, size);
> -                       }
> +                       memcpy(&data->ent, curr, size);
>                         /*
>                          * If the next event is not a return type, then
>                          * we only care about what type it is. Otherwise =
we can
> @@ -811,21 +800,21 @@ print_graph_duration(struct trace_array *tr, unsign=
ed long long duration,
>
>  #ifdef CONFIG_FUNCTION_GRAPH_RETADDR
>  #define __TRACE_GRAPH_PRINT_RETADDR TRACE_GRAPH_PRINT_RETADDR
> -static void print_graph_retaddr(struct trace_seq *s, struct fgraph_retad=
dr_ent_entry *entry,
> -                               u32 trace_flags, bool comment)
> +static void print_graph_retaddr(struct trace_seq *s, unsigned long retad=
dr, u32 trace_flags,
> +                               bool comment)
>  {
>         if (comment)
>                 trace_seq_puts(s, " /*");
>
>         trace_seq_puts(s, " <-");
> -       seq_print_ip_sym(s, entry->graph_ent.retaddr, trace_flags | TRACE=
_ITER_SYM_OFFSET);
> +       seq_print_ip_sym(s, retaddr, trace_flags | TRACE_ITER_SYM_OFFSET)=
;
>
>         if (comment)
>                 trace_seq_puts(s, " */");
>  }
>  #else
>  #define __TRACE_GRAPH_PRINT_RETADDR 0
> -#define print_graph_retaddr(_seq, _entry, _tflags, _comment)           d=
o { } while (0)
> +#define print_graph_retaddr(_seq, _retaddr, _tflags, _comment)         d=
o { } while (0)
>  #endif
>
>  #if defined(CONFIG_FUNCTION_GRAPH_RETVAL) || defined(CONFIG_FUNCTION_GRA=
PH_RETADDR)
> @@ -869,10 +858,12 @@ static void print_graph_retval(struct trace_seq *s,=
 struct ftrace_graph_ent_entr
>                 trace_seq_printf(s, "%ps", func);
>
>                 if (args_size >=3D FTRACE_REGS_MAX_ARGS * sizeof(long)) {

 Hi Team,

I have a question regarding the behavior of the funcgraph-args option.

Currently, when the funcgraph-args flag is set, the function arguments
are saved.
However, when the flag is cleared, the trace output still displays the func=
tion
arguments unconditionally.

I expected that the flag would control both saving and displaying the argum=
ents.
But it seems that the current design only controls the saving. This
behavior seems
inconsistent.

I think we should add a check for the flag in the display part,
specifically before
calling print_function_args, to ensure that the arguments are only
displayed when
the flag is set.

What are your thoughts?

Thanks,
Donglin

> -                       print_function_args(s, entry->args, (unsigned lon=
g)func);
> +                       print_function_args(s, entry->args + ARGS_OFFS(ar=
gs_size),
> +                                           (unsigned long)func);
>                         trace_seq_putc(s, ';');
> -               } else
> +               } else {
>                         trace_seq_puts(s, "();");
> +               }
>
>                 if (print_retval || print_retaddr)
>                         trace_seq_puts(s, " /*");
> @@ -882,8 +873,7 @@ static void print_graph_retval(struct trace_seq *s, s=
truct ftrace_graph_ent_entr
>         }
>
>         if (print_retaddr)
> -               print_graph_retaddr(s, (struct fgraph_retaddr_ent_entry *=
)entry,
> -                                   trace_flags, false);
> +               print_graph_retaddr(s, entry->args[0], trace_flags, false=
);
>
>         if (print_retval) {
>                 if (hex_format || (err_code =3D=3D 0))
> @@ -964,10 +954,12 @@ print_graph_entry_leaf(struct trace_iterator *iter,
>                 trace_seq_printf(s, "%ps", (void *)ret_func);
>
>                 if (args_size >=3D FTRACE_REGS_MAX_ARGS * sizeof(long)) {
> -                       print_function_args(s, entry->args, ret_func);
> +                       print_function_args(s, entry->args + ARGS_OFFS(ar=
gs_size),
> +                                           ret_func);
>                         trace_seq_putc(s, ';');
> -               } else
> +               } else {
>                         trace_seq_puts(s, "();");
> +               }
>         }
>         trace_seq_putc(s, '\n');
>
> @@ -1016,7 +1008,7 @@ print_graph_entry_nested(struct trace_iterator *ite=
r,
>         args_size =3D iter->ent_size - offsetof(struct ftrace_graph_ent_e=
ntry, args);
>
>         if (args_size >=3D FTRACE_REGS_MAX_ARGS * sizeof(long))
> -               print_function_args(s, entry->args, func);
> +               print_function_args(s, entry->args + ARGS_OFFS(args_size)=
, func);
>         else
>                 trace_seq_puts(s, "()");
>
> @@ -1024,8 +1016,7 @@ print_graph_entry_nested(struct trace_iterator *ite=
r,
>
>         if (flags & __TRACE_GRAPH_PRINT_RETADDR  &&
>                 entry->ent.type =3D=3D TRACE_GRAPH_RETADDR_ENT)
> -               print_graph_retaddr(s, (struct fgraph_retaddr_ent_entry *=
)entry,
> -                       tr->trace_flags, true);
> +               print_graph_retaddr(s, entry->args[0], tr->trace_flags, t=
rue);
>         trace_seq_putc(s, '\n');
>
>         if (trace_seq_has_overflowed(s))
> @@ -1202,7 +1193,7 @@ print_graph_entry(struct ftrace_graph_ent_entry *fi=
eld, struct trace_seq *s,
>          * it can be safely saved at the stack.
>          */
>         struct ftrace_graph_ent_entry *entry;
> -       u8 save_buf[sizeof(*entry) + FTRACE_REGS_MAX_ARGS * sizeof(long)]=
;
> +       u8 save_buf[sizeof(*entry) + (FTRACE_REGS_MAX_ARGS + HAVE_RETADDR=
) * sizeof(long)];
>
>         /* The ent_size is expected to be as big as the entry */
>         if (iter->ent_size > sizeof(save_buf))
> @@ -1429,16 +1420,12 @@ print_graph_function_flags(struct trace_iterator =
*iter, u32 flags)
>                 trace_assign_type(field, entry);
>                 return print_graph_entry(field, s, iter, flags);
>         }
> -#ifdef CONFIG_FUNCTION_GRAPH_RETADDR
>         case TRACE_GRAPH_RETADDR_ENT: {
> -               struct fgraph_retaddr_ent_entry saved;
>                 struct fgraph_retaddr_ent_entry *rfield;
>
>                 trace_assign_type(rfield, entry);
> -               saved =3D *rfield;
> -               return print_graph_entry((struct ftrace_graph_ent_entry *=
)&saved, s, iter, flags);
> +               return print_graph_entry((typeof(field))rfield, s, iter, =
flags);
>         }
> -#endif
>         case TRACE_GRAPH_RET: {
>                 struct ftrace_graph_ret_entry *field;
>                 trace_assign_type(field, entry);
> --
> 2.34.1
>
