Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EC8BE57;
	Thu, 10 Oct 2024 02:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728528023; cv=none; b=tddR9zyDQkQTj4CzZLwQtTcStatnXV9TlaglRIXdQeyvKfF4xPq407FapfM8qH6zIpN9EUR+i/436Vuyiainb8WjpzeqN15N5Wtvz8SXkql309bLI5WqtUXmfTQYH092SByB9qBsEdaqoQRSTcqsC8dx/66VzB38RKkKb7Mv//o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728528023; c=relaxed/simple;
	bh=rGAH/Wrse2jTqvtDE174W2OmsmcUmjiZ3HfAAx00wvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hiNHQUwK1IVDF0/Nkhy586u2tD1p0OifogN11MkhkQrsos6zZz3W5u/zbb4hpz1M2PIyc+bZLfqWXEbB2Jzmv81qxjY2HvBOohtjeKOoDX226H4mnmKW65aR7KzSRrv7+Ivpkoohox1LImKA+31i9Nk2c0ZDpW4YvnFHKHzsy0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EoOHvbh/; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoOHvbh/"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a994c322aefso283209066b.1;
        Wed, 09 Oct 2024 19:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728528018; x=1729132818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMg9krN3yzkEltID3K4x9aNk7g8NYyZZa5q5H5Su3V4=;
        b=EoOHvbh/lLrCIdBc4gj7FKjK9dcq2mWwm9QFtBLcny0KmMkVkeWzxOcCpT1jULTwcv
         8DH5GRcEbkDC55unjFAwepycpDS3kARGlnd0WIeu+msp8Z4LFbv2Uvis+uomsv8jcL1s
         Gom4p4QaK3hWTAnSKTNLTDHbjUxP+PnHjyFItk1Y7ubAnu3d10+9YsJdaOJlzpO8j3EL
         5MIP7ss3RRy36j3DH9Ux1QyV8kfqhsEKCInf1/ol8dnupgycTb9VEoUtBa9BGYLbbqLY
         lB1ZBG3WdkKoXODfcxR1Oczq1e+iSD18qLz9UItbQRqFSF9Rv/cjffTTLiB4PU5mZ2nQ
         OsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728528018; x=1729132818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMg9krN3yzkEltID3K4x9aNk7g8NYyZZa5q5H5Su3V4=;
        b=pwk3aDKE5lzXZg6MZhvLIWpca8kTp22Y2bhWvwui/VHYJ1/RYgbuLWbN2dXVsy+gMo
         q4nehEB48MsL22XK0UxBoDhtAm7VcUUBxXAxBolyoNqqJtIv0UaO/VyvkxZloq15eFoZ
         cuPkGXkHDEXiXKncrKEG140BjeNiJLlxRFL9LVSaZ+wtxW3+CrX9TnamBb588xeDD3DG
         5WtBZUdOP5NlVprzL1+RzHkMxWNPjzbxlb1j2vZ8xA/h1FjvAcUCaJGUt4wQEoUpZ8rB
         LNYTDTr6i0TvbKO4gxylRVDfEmM9k/xvwh2EndQGW/P4qwYeLHRbwwopwcZ+Fjs3zbCs
         cu2g==
X-Forwarded-Encrypted: i=1; AJvYcCVsI5pZAF95yCa2qHZmfKbgOq2vDo+ytasgKtDt5BWAKck/g0dCnIOzVjWEcpxx7ezgqoR7KCa5T4o0SO72sEXISrTR@vger.kernel.org, AJvYcCXnu1557GsVrZyZyB5PHYxfeM9e2mLlUjH+pkCwnaKD7Zk2FlsT4WCl34vcxXHGXFXHtBNTFtZGX7tblrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLmnDHLoiKCnaSccFPpnk35x+UPYm1UThsWUPqPlouGwrn3xGt
	ETXaiXQrYnHL7NL5ivMbSzxQRUyp9g/vPj/PcMBc9No+uGzS5IKTwPQDInsWM63Rok8fNWQNtar
	bDPWu6Muy3l92FlP/P5r4/sqwPGDqYpXcfeI=
X-Google-Smtp-Source: AGHT+IG4kJplsnkKi+Upx9qk5F0Cji2epKf5IGbeB5JOcTzyo6AA2MnQZcP+TWq7ox4dkC09CbytEduXpTiArqexFyA=
X-Received: by 2002:a17:907:2dab:b0:a99:4ad2:acb7 with SMTP id
 a640c23a62f3a-a99a110927fmr141871866b.18.1728528018150; Wed, 09 Oct 2024
 19:40:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172851694646.226680.6609563595100451829.stgit@devnote2>
In-Reply-To: <172851694646.226680.6609563595100451829.stgit@devnote2>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Thu, 10 Oct 2024 10:40:02 +0800
Message-ID: <CAErzpmtyA9hh611jGS=FHT9K4YyfsRv5=9mg6YLD2m5XQS8dyw@mail.gmail.com>
Subject: Re: [PATCH] tracing/fgraph: Simplify return address printing in
 function graph tracer
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com, 
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 7:35=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Simplify return address printing in the function graph tracer by removing
> fgraph_extras. Since this feature is only used by the function graph
> tracer and the feature flags can directly accessible from the function
> graph tracer, fgraph_extras can be removed from the fgraph callback.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  include/linux/ftrace.h               |   16 ++++--------
>  kernel/trace/fgraph.c                |   45 ++++++++++++++++++++++------=
------
>  kernel/trace/ftrace.c                |    3 +-
>  kernel/trace/trace.h                 |    3 +-
>  kernel/trace/trace_functions_graph.c |   14 +++++------
>  kernel/trace/trace_irqsoff.c         |    3 +-
>  kernel/trace/trace_sched_wakeup.c    |    3 +-
>  kernel/trace/trace_selftest.c        |    8 ++----
>  8 files changed, 48 insertions(+), 47 deletions(-)
>
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 2ac3b3b53cd0..997e1f0335b6 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -1068,29 +1068,20 @@ struct ftrace_graph_ret {
>         unsigned long long rettime;
>  } __packed;
>
> -struct fgraph_extras;
>  struct fgraph_ops;
>
>  /* Type of the callback handlers for tracing function graph*/
>  typedef void (*trace_func_graph_ret_t)(struct ftrace_graph_ret *,
>                                        struct fgraph_ops *); /* return */
>  typedef int (*trace_func_graph_ent_t)(struct ftrace_graph_ent *,
> -                                     struct fgraph_ops *,
> -                                     struct fgraph_extras *); /* entry *=
/
> +                                     struct fgraph_ops *); /* entry */
>
>  extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace,
> -                                  struct fgraph_ops *gops,
> -                                  struct fgraph_extras *extras);
> +                                  struct fgraph_ops *gops);
>  bool ftrace_pids_enabled(struct ftrace_ops *ops);
>
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>
> -/* Used to convey some extra datas when creating a graph entry */
> -struct fgraph_extras {
> -       u32 flags;
> -       unsigned long retaddr;
> -};
> -
>  struct fgraph_ops {
>         trace_func_graph_ent_t          entryfunc;
>         trace_func_graph_ret_t          retfunc;
> @@ -1131,12 +1122,15 @@ function_graph_enter(unsigned long ret, unsigned =
long func,
>
>  struct ftrace_ret_stack *
>  ftrace_graph_get_ret_stack(struct task_struct *task, int skip);
> +unsigned long ftrace_graph_top_ret_addr(struct task_struct *task);
>
>  unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
>                                     unsigned long ret, unsigned long *ret=
p);
>  unsigned long *fgraph_get_task_var(struct fgraph_ops *gops);
>
>  u32 graph_tracer_flags_get(u32 flags);
> +#define graph_tracer_flags_is_set(flags)       \
> +       (graph_tracer_flags_get(flags) =3D=3D (flags))

Do we need to retain the function graph_tracer_flags_get? it will be
only invoked in the
file trace_functions_graph.c, so we may access the tracer_flags
variable directly.

>
>  /*
>   * Sometimes we don't want to trace a function with the function
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 27e523f01ed2..ee829d65f301 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -290,8 +290,7 @@ static inline unsigned long make_data_type_val(int id=
x, int size, int offset)
>  }
>
>  /* ftrace_graph_entry set to this to tell some archs to run function gra=
ph */
> -static int entry_run(struct ftrace_graph_ent *trace, struct fgraph_ops *=
ops,
> -                    struct fgraph_extras *extras)
> +static int entry_run(struct ftrace_graph_ent *trace, struct fgraph_ops *=
ops)
>  {
>         return 0;
>  }
> @@ -519,8 +518,7 @@ int __weak ftrace_disable_ftrace_graph_caller(void)
>  #endif
>
>  int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace,
> -                           struct fgraph_ops *gops,
> -                           struct fgraph_extras *extras)
> +                           struct fgraph_ops *gops)
>  {
>         return 0;
>  }
> @@ -648,20 +646,13 @@ int function_graph_enter(unsigned long ret, unsigne=
d long func,
>                          unsigned long frame_pointer, unsigned long *retp=
)
>  {
>         struct ftrace_graph_ent trace;
> -       struct fgraph_extras extras;
>         unsigned long bitmap =3D 0;
>         int offset;
>         int i;
> -       int idx =3D 0;
>
>         trace.func =3D func;
>         trace.depth =3D ++current->curr_ret_depth;
>
> -       extras.flags =3D graph_tracer_flags_get(TRACE_GRAPH_PRINT_RETADDR=
);
> -       if (IS_ENABLED(CONFIG_FUNCTION_GRAPH_RETADDR)
> -               && extras.flags & TRACE_GRAPH_PRINT_RETADDR)
> -               extras.retaddr =3D ftrace_graph_ret_addr(current, &idx, r=
et, retp);
> -
>         offset =3D ftrace_push_return_trace(ret, func, frame_pointer, ret=
p, 0);
>         if (offset < 0)
>                 goto out;
> @@ -670,7 +661,7 @@ int function_graph_enter(unsigned long ret, unsigned =
long func,
>         if (static_branch_likely(&fgraph_do_direct)) {
>                 int save_curr_ret_stack =3D current->curr_ret_stack;
>
> -               if (static_call(fgraph_func)(&trace, fgraph_direct_gops, =
&extras))
> +               if (static_call(fgraph_func)(&trace, fgraph_direct_gops))
>                         bitmap |=3D BIT(fgraph_direct_gops->idx);
>                 else
>                         /* Clear out any saved storage */
> @@ -688,7 +679,7 @@ int function_graph_enter(unsigned long ret, unsigned =
long func,
>
>                         save_curr_ret_stack =3D current->curr_ret_stack;
>                         if (ftrace_ops_test(&gops->ops, func, NULL) &&
> -                           gops->entryfunc(&trace, gops, &extras))
> +                           gops->entryfunc(&trace, gops))
>                                 bitmap |=3D BIT(i);
>                         else
>                                 /* Clear out any saved storage */
> @@ -905,6 +896,29 @@ ftrace_graph_get_ret_stack(struct task_struct *task,=
 int idx)
>         return ret_stack;
>  }
>
> +/**
> + * ftrace_graph_top_ret_addr - return the top return address in the shad=
ow stack
> + * @task: The task to read the shadow stack from.
> + *
> + * Return the first return address on the shadow stack of the @task, whi=
ch is
> + * not the fgraph's return_to_handler.
> + */
> +unsigned long ftrace_graph_top_ret_addr(struct task_struct *task)
> +{
> +       unsigned long return_handler =3D (unsigned long)dereference_kerne=
l_function_descriptor(return_to_handler);
> +       struct ftrace_ret_stack *ret_stack =3D NULL;
> +       int offset =3D task->curr_ret_stack;
> +
> +       if (offset < 0)
> +               return 0;
> +
> +       do {
> +               ret_stack =3D get_ret_stack(task, offset, &offset);
> +       } while (ret_stack && ret_stack->ret =3D=3D return_handler);
> +
> +       return ret_stack ? ret_stack->ret : 0;
> +}
> +
>  /**
>   * ftrace_graph_ret_addr - return the original value of the return addre=
ss
>   * @task: The task the unwinder is being executed on
> @@ -1145,8 +1159,7 @@ void ftrace_graph_exit_task(struct task_struct *t)
>
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  static int fgraph_pid_func(struct ftrace_graph_ent *trace,
> -                          struct fgraph_ops *gops,
> -                          struct fgraph_extras *extras)
> +                          struct fgraph_ops *gops)
>  {
>         struct trace_array *tr =3D gops->ops.private;
>         int pid;
> @@ -1160,7 +1173,7 @@ static int fgraph_pid_func(struct ftrace_graph_ent =
*trace,
>                         return 0;
>         }
>
> -       return gops->saved_func(trace, gops, NULL);
> +       return gops->saved_func(trace, gops);
>  }
>
>  void fgraph_update_pid_func(void)
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 5d87dac83b80..cae388122ca8 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -827,8 +827,7 @@ struct profile_fgraph_data {
>  };
>
>  static int profile_graph_entry(struct ftrace_graph_ent *trace,
> -                              struct fgraph_ops *gops,
> -                              struct fgraph_extras *extras)
> +                              struct fgraph_ops *gops)
>  {
>         struct profile_fgraph_data *profile_data;
>
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 13f08f257c0b..6adf48ef4312 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -695,8 +695,7 @@ void trace_default_header(struct seq_file *m);
>  void print_trace_header(struct seq_file *m, struct trace_iterator *iter)=
;
>
>  void trace_graph_return(struct ftrace_graph_ret *trace, struct fgraph_op=
s *gops);
> -int trace_graph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops =
*gops,
> -                     struct fgraph_extras *extras);
> +int trace_graph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops =
*gops);
>
>  void tracing_start_cmdline_record(void);
>  void tracing_stop_cmdline_record(void);
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_fu=
nctions_graph.c
> index 3dd63ae2afe8..e3cda79653ee 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -179,8 +179,7 @@ struct fgraph_times {
>  };
>
>  int trace_graph_entry(struct ftrace_graph_ent *trace,
> -                     struct fgraph_ops *gops,
> -                     struct fgraph_extras *extras)
> +                     struct fgraph_ops *gops)
>  {
>         unsigned long *task_var =3D fgraph_get_task_var(gops);
>         struct trace_array *tr =3D gops->private;
> @@ -246,11 +245,12 @@ int trace_graph_entry(struct ftrace_graph_ent *trac=
e,
>         disabled =3D atomic_inc_return(&data->disabled);
>         if (likely(disabled =3D=3D 1)) {
>                 trace_ctx =3D tracing_gen_ctx_flags(flags);
> -               if (unlikely(IS_ENABLED(CONFIG_FUNCTION_GRAPH_RETADDR) &&=
 extras
> -                               && (extras->flags & TRACE_GRAPH_PRINT_RET=
ADDR)))
> -                       ret =3D __trace_graph_retaddr_entry(tr, trace, tr=
ace_ctx,
> -                                                         extras->retaddr=
);
> -               else
> +               if (unlikely(IS_ENABLED(CONFIG_FUNCTION_GRAPH_RETADDR) &&
> +                       graph_tracer_flags_is_set(TRACE_GRAPH_PRINT_RETAD=
DR))) {
> +                       unsigned long retaddr =3D ftrace_graph_top_ret_ad=
dr(current);
> +
> +                       ret =3D __trace_graph_retaddr_entry(tr, trace, tr=
ace_ctx, retaddr);
> +               } else
>                         ret =3D __trace_graph_entry(tr, trace, trace_ctx)=
;
>         } else {
>                 ret =3D 0;
> diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
> index eb3aa36cf10f..fce064e20570 100644
> --- a/kernel/trace/trace_irqsoff.c
> +++ b/kernel/trace/trace_irqsoff.c
> @@ -176,8 +176,7 @@ static int irqsoff_display_graph(struct trace_array *=
tr, int set)
>  }
>
>  static int irqsoff_graph_entry(struct ftrace_graph_ent *trace,
> -                              struct fgraph_ops *gops,
> -                              struct fgraph_extras *extras)
> +                              struct fgraph_ops *gops)
>  {
>         struct trace_array *tr =3D irqsoff_trace;
>         struct trace_array_cpu *data;
> diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched=
_wakeup.c
> index 155de2551507..ae2ace5e515a 100644
> --- a/kernel/trace/trace_sched_wakeup.c
> +++ b/kernel/trace/trace_sched_wakeup.c
> @@ -113,8 +113,7 @@ static int wakeup_display_graph(struct trace_array *t=
r, int set)
>  }
>
>  static int wakeup_graph_entry(struct ftrace_graph_ent *trace,
> -                             struct fgraph_ops *gops,
> -                             struct fgraph_extras *extras)
> +                             struct fgraph_ops *gops)
>  {
>         struct trace_array *tr =3D wakeup_trace;
>         struct trace_array_cpu *data;
> diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.=
c
> index fbb99f8c8062..d3a14ae47e26 100644
> --- a/kernel/trace/trace_selftest.c
> +++ b/kernel/trace/trace_selftest.c
> @@ -774,8 +774,7 @@ struct fgraph_fixture {
>  };
>
>  static __init int store_entry(struct ftrace_graph_ent *trace,
> -                             struct fgraph_ops *gops,
> -                             struct fgraph_extras *extras)
> +                             struct fgraph_ops *gops)
>  {
>         struct fgraph_fixture *fixture =3D container_of(gops, struct fgra=
ph_fixture, gops);
>         const char *type =3D fixture->store_type_name;
> @@ -1026,8 +1025,7 @@ static unsigned int graph_hang_thresh;
>
>  /* Wrap the real function entry probe to avoid possible hanging */
>  static int trace_graph_entry_watchdog(struct ftrace_graph_ent *trace,
> -                                     struct fgraph_ops *gops,
> -                                     struct fgraph_extras *extras)
> +                                     struct fgraph_ops *gops)
>  {
>         /* This is harmlessly racy, we want to approximately detect a han=
g */
>         if (unlikely(++graph_hang_thresh > GRAPH_MAX_FUNC_TEST)) {
> @@ -1041,7 +1039,7 @@ static int trace_graph_entry_watchdog(struct ftrace=
_graph_ent *trace,
>                 return 0;
>         }
>
> -       return trace_graph_entry(trace, gops, NULL);
> +       return trace_graph_entry(trace, gops);
>  }
>
>  static struct fgraph_ops fgraph_ops __initdata  =3D {
>
