Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082B63009D4;
	Wed, 26 Nov 2025 09:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764150646; cv=none; b=aBLX5fLHucxGau4DQYs+PO9HXGVFj9xCQifNDdJWOAd4eiUYbB5RrvumLIFVFdbN7jgRovhvrJOp+/o2K+TqUdr4iu88Z13uii1rGrP571Cufqkfp1p2hdkRl0ukcv68kq66useseHzaO7eMDc4ct3JYqq1VUf+oBW6pAp/IULo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764150646; c=relaxed/simple;
	bh=/sr34a6bhva5Frv8OpMqPO5lc+u22TGpmo9lNI2iQnY=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=m46UPaUt2jJ6OznTAr3Q2j20dPCbqq2OINYDPfvn7hemeCsjbPNonq+9+AtUVYSX29t0Eb6rTjKNJGRxV7kkU2HuV3iYtv7QJskJrRP840z1FW7/gQbOgxLXzt82TEziFxi2VbJzvBWI1xX0PakE5BAvSfs/fmBhAJYUo2WTDDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4dGZYs4tR2z8Xs6w;
	Wed, 26 Nov 2025 17:50:41 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4dGZYl40npz501bC;
	Wed, 26 Nov 2025 17:50:35 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 5AQ9oKGe040006;
	Wed, 26 Nov 2025 17:50:20 +0800 (+08)
	(envelope-from wang.yaxin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 26 Nov 2025 17:50:23 +0800 (CST)
Date: Wed, 26 Nov 2025 17:50:23 +0800 (CST)
X-Zmail-TransId: 2afb6926cd5f63a-03b50
X-Mailer: Zmail v1.0
Message-ID: <20251126175023244jyTDtV6Yu_0K1kYFvGcKQ@zte.com.cn>
In-Reply-To: <20251125130504.6f1b442f@gandalf.local.home>
References: 20251113135627439rGwzvG7JzdmnN8VMHAfMs@zte.com.cn,20251125130504.6f1b442f@gandalf.local.home
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yaxin@zte.com.cn>
To: <rostedt@goodmis.org>
Cc: <mhiramat@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <hu.shengming@zte.com.cn>,
        <hang.run@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eC1uZXh0XSBmZ3JhcGg6IEZpeCBhbmQgdGlnaHRlbiBQSUQgZmlsdGVyaW5nIHN1cHBvcnQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 5AQ9oKGe040006
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yaxin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 192.168.251.13 unknown Wed, 26 Nov 2025 17:50:41 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6926CD71.000/4dGZYs4tR2z8Xs6w

On Wed, 26 Nov 2025 02:04:00
Steve wrote:

> On Thu, 13 Nov 2025 13:56:27 +0800 (CST)
> <wang.yaxin@zte.com.cn> wrote:
> 
> > From: Shengming Hu <hu.shengming@zte.com.cn>
> > 
> > Function graph tracing did not honor set_ftrace_pid() rules properly.
> > 
> > The root cause is that for fgraph_ops, the underlying ftrace_ops->private
> > was left uninitialized. As a result, ftrace_pids_enabled(op) always
> > returned false, effectively disabling PID filtering in the function graph
> > tracer.
> > 
> > PID filtering seemed to "work" only because graph_entry() performed an
> > extra coarse-grained check via ftrace_trace_task(). Specifically,
> > ftrace_ignore_pid is updated by ftrace_filter_pid_sched_switch_probe
> > during sched_switch events. Under the original logic, when the intent
> > is to trace only PID A, a context switch from task B to A sets 
> > ftrace_ignore_pid to A’s PID. However, there remains a window
> > where B’s functions are still captured by the function-graph tracer. 
> > The following trace demonstrates this leakage
> > (B = haveged-213, A = test.sh-385):
> 
> Thanks for the patch.
> 
> 
> > Fix this by:
> 
> The below should really be three different patches.
> 

Hi Steve
Sorry, there were some formatting issues when I sent the series of v2 patches initially,
so I have resent them. Please refer to the latest sending for accuracy.

It has been divided into 3 different patches in v2：
https://lore.kernel.org/linux-trace-kernel/20251126172445319I7DWJm-KEEuCmqtLupteE@zte.com.cn/T/#t

> >   1. Properly initializing gops->ops->private so that
> >      ftrace_pids_enabled() works as expected.
> >   2. Removing the imprecise fallback check in graph_entry().
> >   3. Updating register_ftrace_graph() to set gops->entryfunc =
> >      fgraph_pid_func whenever PID filtering is active, so the correct
> >      per-task filtering is enforced at entry time.
> > 
> > With this change, function graph tracing will respect the configured
> > PID filter list consistently, and the redundant coarse check is no
> > longer needed.
> > 
> > Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
> > ---
> >  kernel/trace/fgraph.c                | 9 +++++++--
> >  kernel/trace/trace.h                 | 9 ---------
> >  kernel/trace/trace_functions_graph.c | 3 ---
> >  3 files changed, 7 insertions(+), 14 deletions(-)
> > 
> > diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> > index 484ad7a18..00df3d4ac 100644
> > --- a/kernel/trace/fgraph.c
> > +++ b/kernel/trace/fgraph.c
> > @@ -1019,6 +1019,7 @@ void fgraph_init_ops(struct ftrace_ops *dst_ops,
> >          mutex_init(&dst_ops->local_hash.regex_lock);
> >          INIT_LIST_HEAD(&dst_ops->subop_list);
> >          dst_ops->flags |= FTRACE_OPS_FL_INITIALIZED;
> > +        dst_ops->private = src_ops->private;
> >      }
> >  #endif
> >  }
> > @@ -1375,6 +1376,12 @@ int register_ftrace_graph(struct fgraph_ops *gops)
> >      gops->idx = i;
> > 
> >      ftrace_graph_active++;
> 
> Please keep a space here.
> 

Space has been added in v2：
https://lore.kernel.org/linux-trace-kernel/20251126172445319I7DWJm-KEEuCmqtLupteE@zte.com.cn/T/#t

> > +    /* Always save the function, and reset at unregistering */
> > +    gops->saved_func = gops->entryfunc;
> > +#ifdef CONFIG_DYNAMIC_FTRACE
> > +    if (ftrace_pids_enabled(&gops->ops))
> > +        gops->entryfunc = fgraph_pid_func;
> > +#endif
> 
> Thanks,
> 
> -- Steve
> 

Thank you for your valuable review feedback, Steve!
I have addressed all the comments you raised, and the complete v2 patch
series ([PATCH v2 0/3] to [PATCH v2 3/3]):
https://lore.kernel.org/linux-trace-kernel/20251126172445319I7DWJm-KEEuCmqtLupteE@zte.com.cn/T/#t

--
With Best Regards,
Shengming

> > 
> >      if (ftrace_graph_active == 2)
> >          ftrace_graph_disable_direct(true);
> > @@ -1395,8 +1402,6 @@ int register_ftrace_graph(struct fgraph_ops *gops)
> >      } else {
> >          init_task_vars(gops->idx);
> >      }
> > -    /* Always save the function, and reset at unregistering */
> > -    gops->saved_func = gops->entryfunc;
> > 
> >      gops->ops.flags |= FTRACE_OPS_FL_GRAPH;
> > 
> > diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> > index a3a15cfab..048a53282 100644
> > --- a/kernel/trace/trace.h
> > +++ b/kernel/trace/trace.h
> > @@ -1162,11 +1162,6 @@ struct ftrace_func_command {
> >                      char *params, int enable);
> >  };
> >  extern bool ftrace_filter_param __initdata;
> > -static inline int ftrace_trace_task(struct trace_array *tr)
> > -{
> > -    return this_cpu_read(tr->array_buffer.data->ftrace_ignore_pid) !=
> > -        FTRACE_PID_IGNORE;
> > -}
> >  extern int ftrace_is_dead(void);
> >  int ftrace_create_function_files(struct trace_array *tr,
> >                   struct dentry *parent);
> > @@ -1184,10 +1179,6 @@ void ftrace_clear_pids(struct trace_array *tr);
> >  int init_function_trace(void);
> >  void ftrace_pid_follow_fork(struct trace_array *tr, bool enable);
> >  #else
> > -static inline int ftrace_trace_task(struct trace_array *tr)
> > -{
> > -    return 1;
> > -}
> >  static inline int ftrace_is_dead(void) { return 0; }
> >  static inline int
> >  ftrace_create_function_files(struct trace_array *tr,
> > diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
> > index fe9607edc..0efe831e4 100644
> > --- a/kernel/trace/trace_functions_graph.c
> > +++ b/kernel/trace/trace_functions_graph.c
> > @@ -232,9 +232,6 @@ static int graph_entry(struct ftrace_graph_ent *trace,
> >          return 1;
> >      }
> > 
> > -    if (!ftrace_trace_task(tr))
> > -        return 0;
> > -
> >      if (ftrace_graph_ignore_func(gops, trace))
> >          return 0;
> >
