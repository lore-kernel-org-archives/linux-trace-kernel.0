Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4B7279918;
	Tue, 25 Nov 2025 18:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764093873; cv=none; b=m9rHtu/yO6kcZdvGvis+/C7KXePLXDKAJtq5Cr9I3OCl5OFQM+gofUhpVlFFDhc5D7e/zC7Nw0HDVvKeC/EFtmtj0Q7YIP+7BV66c/CYJxX3/fDVpKAILfx5gF/ZrOWd5FTkrpRr86KPvcwTgLwvZ9K1TC4QERO2YFv+YeAN+tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764093873; c=relaxed/simple;
	bh=UHU9GcUWmtJxeODXxWsd8u+6gA9u18gLizKa8jUq56M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CX0vaQmqdesnhRD6ASpdSkbmayOMmi3EMii+IB1X9gsDDGgsCzptpgdhJD7UaQDU/2wkBMiplYiZ/f04VeC8OLYElf9dci1D+Q3EF5FBOrQoHhjBLt5/qH7fNVz/gmnievKnxN3lC4curqeOK2YxzT26aKeh8IAEwCRJIG478iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id CCA2F130D24;
	Tue, 25 Nov 2025 18:04:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id ABE8420028;
	Tue, 25 Nov 2025 18:04:20 +0000 (UTC)
Date: Tue, 25 Nov 2025 13:05:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: <wang.yaxin@zte.com.cn>
Cc: <mhiramat@kernel.org>, <mark.rutland@arm.com>,
 <mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <hu.shengming@zte.com.cn>,
 <hang.run@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: Re: [PATCH linux-next] fgraph: Fix and tighten PID filtering
 support
Message-ID: <20251125130504.6f1b442f@gandalf.local.home>
In-Reply-To: <20251113135627439rGwzvG7JzdmnN8VMHAfMs@zte.com.cn>
References: <20251113135627439rGwzvG7JzdmnN8VMHAfMs@zte.com.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: 5uc5xjzrxegsjywyab5nswipkx9g44g1
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: ABE8420028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX184/6ae8PDAXH53yVU30+NPWVqUpZ33Gw4=
X-HE-Tag: 1764093860-540626
X-HE-Meta: U2FsdGVkX189rM0hgDEU2WaHZS8JzjreQcL/utwdrtrOz843NBoKBGKOe61xILA0lWyBd2TGwH9+QVHN7j94yR7QrbrMqqy4mLg3luo3cLTAVf0EK5KtWnTRfYx235dL+9Pc0ktKgmKEif4MZtiY6f+6cDbcTjA8UyrkkMNWfTcK1OqpE8X/BGFqQNodk8LWgR6WwqP1judfWdZcV2SBFjZbIrfIadCPyHCnfPdiBdAk8z/7XeJg8AkGIsX7oDuiRQN6yKvvmeY8uPvkOWuRQluwV9Ttjm3D3Pk0+bD2GOlIrdR1vYBdMaU/pORSpKLvRjIWhvJa/LV4We/M+w9s2jCUI1eV7hkCzE+uf0qtXkqVjHnVPYOW9hn4u/MiFgmR

On Thu, 13 Nov 2025 13:56:27 +0800 (CST)
<wang.yaxin@zte.com.cn> wrote:

> From: Shengming Hu <hu.shengming@zte.com.cn>
>=20
> Function graph tracing did not honor set_ftrace_pid() rules properly.
>=20
> The root cause is that for fgraph_ops, the underlying ftrace_ops->private
> was left uninitialized. As a result, ftrace_pids_enabled(op) always
> returned false, effectively disabling PID filtering in the function graph
> tracer.
>=20
> PID filtering seemed to "work" only because graph_entry() performed an
> extra coarse-grained check via ftrace_trace_task(). Specifically,
> ftrace_ignore_pid is updated by ftrace_filter_pid_sched_switch_probe
> during sched_switch events. Under the original logic, when the intent
> is to trace only PID A, a context switch from task B to A sets=20
> ftrace_ignore_pid to A=E2=80=99s PID. However, there remains a window
> where B=E2=80=99s functions are still captured by the function-graph trac=
er.=20
> The following trace demonstrates this leakage
> (B =3D haveged-213, A =3D test.sh-385):

Thanks for the patch.


> Fix this by:

The below should really be three different patches.

>   1. Properly initializing gops->ops->private so that
>      ftrace_pids_enabled() works as expected.
>   2. Removing the imprecise fallback check in graph_entry().
>   3. Updating register_ftrace_graph() to set gops->entryfunc =3D
>      fgraph_pid_func whenever PID filtering is active, so the correct
>      per-task filtering is enforced at entry time.
>=20
> With this change, function graph tracing will respect the configured
> PID filter list consistently, and the redundant coarse check is no
> longer needed.
>=20
> Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
> ---
>  kernel/trace/fgraph.c                | 9 +++++++--
>  kernel/trace/trace.h                 | 9 ---------
>  kernel/trace/trace_functions_graph.c | 3 ---
>  3 files changed, 7 insertions(+), 14 deletions(-)
>=20
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 484ad7a18..00df3d4ac 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -1019,6 +1019,7 @@ void fgraph_init_ops(struct ftrace_ops *dst_ops,
>  		mutex_init(&dst_ops->local_hash.regex_lock);
>  		INIT_LIST_HEAD(&dst_ops->subop_list);
>  		dst_ops->flags |=3D FTRACE_OPS_FL_INITIALIZED;
> +		dst_ops->private =3D src_ops->private;
>  	}
>  #endif
>  }
> @@ -1375,6 +1376,12 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>  	gops->idx =3D i;
>=20
>  	ftrace_graph_active++;

Please keep a space here.

> +	/* Always save the function, and reset at unregistering */
> +	gops->saved_func =3D gops->entryfunc;
> +#ifdef CONFIG_DYNAMIC_FTRACE
> +	if (ftrace_pids_enabled(&gops->ops))
> +		gops->entryfunc =3D fgraph_pid_func;
> +#endif

Thanks,

-- Steve

>=20
>  	if (ftrace_graph_active =3D=3D 2)
>  		ftrace_graph_disable_direct(true);
> @@ -1395,8 +1402,6 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>  	} else {
>  		init_task_vars(gops->idx);
>  	}
> -	/* Always save the function, and reset at unregistering */
> -	gops->saved_func =3D gops->entryfunc;
>=20
>  	gops->ops.flags |=3D FTRACE_OPS_FL_GRAPH;
>=20
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index a3a15cfab..048a53282 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1162,11 +1162,6 @@ struct ftrace_func_command {
>  					char *params, int enable);
>  };
>  extern bool ftrace_filter_param __initdata;
> -static inline int ftrace_trace_task(struct trace_array *tr)
> -{
> -	return this_cpu_read(tr->array_buffer.data->ftrace_ignore_pid) !=3D
> -		FTRACE_PID_IGNORE;
> -}
>  extern int ftrace_is_dead(void);
>  int ftrace_create_function_files(struct trace_array *tr,
>  				 struct dentry *parent);
> @@ -1184,10 +1179,6 @@ void ftrace_clear_pids(struct trace_array *tr);
>  int init_function_trace(void);
>  void ftrace_pid_follow_fork(struct trace_array *tr, bool enable);
>  #else
> -static inline int ftrace_trace_task(struct trace_array *tr)
> -{
> -	return 1;
> -}
>  static inline int ftrace_is_dead(void) { return 0; }
>  static inline int
>  ftrace_create_function_files(struct trace_array *tr,
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_fu=
nctions_graph.c
> index fe9607edc..0efe831e4 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -232,9 +232,6 @@ static int graph_entry(struct ftrace_graph_ent *trace,
>  		return 1;
>  	}
>=20
> -	if (!ftrace_trace_task(tr))
> -		return 0;
> -
>  	if (ftrace_graph_ignore_func(gops, trace))
>  		return 0;
>=20

