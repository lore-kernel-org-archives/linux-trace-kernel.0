Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795833096;
	b=KqCi3keJbNjhC7OM/GxVKu+FcVF3SAt0gbbaGdQNqkAOZfClrp/FH0UIIRgOSlv/Y+V8
	 RqVZpmXWk95XDZtY7QtQzx65Ikae/MU4cn8fYb0L3oKbLO9URj/x8cQEsRjHXzWAZZfSY
	 hiuJ69bPakRAz4kBqttj/dDfX89u5HYZ+uC7FoDwUlifjZHZkjBTx0c6LLbI67XquWNF0
	 rtcg4bCQyiR5bEeH+Hd5CJWHV4svdEBS+0+jJvUuClauLo3mit4decWaWjxvZARQwpU+9
	 VNJ4EmtEkAReUIIxIL7PDXGY1bKClp7y/GJ6LXB8d0ej0BoYxgFw01+Dmyz0nNbpgLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795833096;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=VtFNi8cB6WM7FpUP6o6VT1D+XWcmFi3d3WO/9cxQ8vA=;
	b=1u7gy/I08cK/ITAhI3h0AYZx3Q7slumDTZY3HZx5OnC8e+oTqESoCpTPPPCdHn+Z7/i2
	 yLwRfApHnGIzEhspSEjupGIlTSOuVG/kUZpS/lqM3kwchoGgCfQH4Sn9yasANMSLMU79b
	 oE8lSmGgTn+6KAoZ6eR6hEbfqo2Ccq6aA4WkBTq3Cl9B3KmjaemJ66+2WPMdDNSkqjZO+
	 5/eaMgO7L/LBuIo9uadpV873yr+Fai5+PQOLIorBjqczNf26lyPZz71bDostBJEJl5p/k
	 16Nrf+lrXUAYyL9zWVKllXHWiM1pJ59ghJGiBePrnniDM+ut8OrMD+aJnWfqenCvWSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YKwd3ZEp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEFF606A31C;
	Sat, 28 Nov 2026 02:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YKwd3ZEp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C06A1F00893;
	Sat, 28 Nov 2026 02:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795833096;
	bh=VtFNi8cB6WM7FpUP6o6VT1D+XWcmFi3d3WO/9cxQ8vA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YKwd3ZEpRbeT+6VpV/NDRoG5l4H9yNv/hSChadINerHYzo+ZvPAmezrpqsZlRcJfc
	 fkizaDfxkgOVrUpdYUyI4UuDgsbJ4q1ibguBkOjDvQEGW7ghUrghzhITelsgHrrdRP
	 +MVjtJ9B6Wp1BWcItbv1kZ1fDP8dp9FlVxefPXToMtf00FJd1EJvg46tN6XcWTX3Sl
	 qB4IrwUnip/UzKlEdP7+yA/xBgdbWnZwncmAdTmwRgoDtbHDKN9DSpUdW+QeO0uX/X
	 2XsolnTyViw8x6CWtVaTr4UYzdpwrJVgGwm56Bygjn8iEir1zYMkHCgdmxvqQh0MNy
	 n+ouAs0fveUxQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Antoine Tenart <atenart@kernel.org>, mathieu.desnoyers@efficios.com, vmalik@redhat.com, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH] tracing/probes: fix race between probe execution and event unregistering
Date: Sat, 28 Nov 2026 11:31:32 +0900
Message-ID: <undine-1795833092601383688-d1e19625e907c2ec@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261127140616.20616c68@gandalf.local.home>
References: <20261126132830.14992-1-atenart@kernel.org> <20261127140616.20616c68@gandalf.local.home>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Fri, 27 Nov 2026 14:06:16 -0500, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Thu, 26 Nov 2026 14:28:30 +0100
> Antoine Tenart <atenart@kernel.org> wrote:
> 
> > 
> > Hi,
> > 
> > I found this while debugging another (downstream) issue, reusing the
> > same reproducer on mainline. The reproducer registers/enables and
> > disables/unregisters a kretprobe on a syscall in a loop while triggering
> > it (I can share if you're interested). It should work with other probe
> > types.
> > 
> > I'm not versed into the tracing subsystem so I went the safe way and
> > reverted back to the previous behaviour. There might be something more
> > clever to do.
> 
> I would hate having to put back the inline synchronize_rcu() as that has
> noticeable impact on removing kprobes.
> 

Agreed. This kfree_rcu() method seems better, because this is not only
kprobes, but also other trace_probe based events have the same problem.

Thank you!

> 
> > 
> > Thanks!
> > Antoine
> > 
> >  kernel/trace/trace_probe.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index cff55dcae36f..8addaf641431 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -2841,7 +2841,13 @@ int trace_probe_remove_file(struct trace_probe *tp,
> >  		return -ENOENT;
> >  
> >  	list_del_rcu(&link->list);
> > -	kvfree_rcu_mightsleep(link);
> > +
> > +	/*
> > +	 * Synchronize with probes being executed. This is not only for freeing
> > +	 * link but also for related objects (e.g. link->file).
> > +	 */
> > +	synchronize_rcu();
> > +	kvfree(link);
> >  
> >  	if (list_empty(&tp->event->files))
> >  		trace_probe_clear_flag(tp, TP_FLAG_TRACE);
> 
> Would something like this work? I haven't fully tested it though:
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index cff55dcae36f..c249256dea80 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -2812,6 +2812,7 @@ int trace_probe_add_file(struct trace_probe *tp, struct trace_event_file *file)
>  		return -ENOMEM;
>  
>  	link->file = file;
> +	event_file_get(file);
>  	INIT_LIST_HEAD(&link->list);
>  	list_add_tail_rcu(&link->list, &tp->event->files);
>  	trace_probe_set_flag(tp, TP_FLAG_TRACE);
> @@ -2831,6 +2832,14 @@ struct event_file_link *trace_probe_get_file_link(struct trace_probe *tp,
>  	return NULL;
>  }
>  
> +static void free_link_rcu(struct rcu_head *rcu)
> +{
> +	struct event_file_link *link = container_of(rcu, struct event_file_link, rcu);
> +
> +	event_file_put(link->file);
> +	kvfree(link);
> +}
> +
>  int trace_probe_remove_file(struct trace_probe *tp,
>  			    struct trace_event_file *file)
>  {
> @@ -2841,7 +2850,7 @@ int trace_probe_remove_file(struct trace_probe *tp,
>  		return -ENOENT;
>  
>  	list_del_rcu(&link->list);
> -	kvfree_rcu_mightsleep(link);
> +	call_rcu(&link->rcu, free_link_rcu);
>  
>  	if (list_empty(&tp->event->files))
>  		trace_probe_clear_flag(tp, TP_FLAG_TRACE);
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index d1fb3520700f..aecc9f24951d 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -281,6 +281,7 @@ struct trace_probe {
>  struct event_file_link {
>  	struct trace_event_file		*file;
>  	struct list_head		list;
> +	struct rcu_head			rcu;
>  };
>  
>  static inline unsigned int trace_probe_load_flag(struct trace_probe *tp)
> 
> -- Steve
> 
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
