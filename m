Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D1D3AE1B3;
	Tue,  3 Mar 2026 14:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548765; cv=none; b=chfZMsm0jo0U1H4Oda/LJpm03LAh5lxGNqPKPslk/UdBNqTcZmcJ9aMoHYMJS6wz4fGNamlRfSMwLy8y2Slpu+lwdYyqV/ySiVDWQxySuWYs420rcLVORC8tocf3fFUDdmG+lKair88JCr259rrqaxVKlX1b8re63gXyzcAdS7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548765; c=relaxed/simple;
	bh=XX/jeSAHW+x8CraKzwl1hAiIEVR6XQ0VdZ7DGmrbUm4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JBnoc7LXd1k9lhEp7xWSetn36pBrxjmEw6Tz1ZihCLXMNDr/fG2a4ssw0vRL0NtkET6J/rVVSrz98PpNDlMqHucUPymZ0rTWw2J+3wIkCjrRUW41RQ/QiCccJfADZL4nHRv6szQtgVBR/IaLRF32g37YT2p/D+YkWT1TmRjbsQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 81076139CB2;
	Tue,  3 Mar 2026 14:39:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id C84E31A;
	Tue,  3 Mar 2026 14:39:15 +0000 (UTC)
Date: Tue, 3 Mar 2026 09:39:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ftrace: Disable preemption in the tracepoint callbacks
 handling filtered pids
Message-ID: <20260303093949.4210e854@gandalf.local.home>
In-Reply-To: <20260303131706.96057f61a48a34c43ce1e396@kernel.org>
References: <20260302213546.156e3e4f@gandalf.local.home>
	<20260303131706.96057f61a48a34c43ce1e396@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: C84E31A
X-Stat-Signature: asqcdgd4b5jef4eunm1ao1ccjazab8rd
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1900ssTXeWjtDy6aCP6YXGn83v9cf9+x8I=
X-HE-Tag: 1772548755-182353
X-HE-Meta: U2FsdGVkX1/wakUKghtGO/+OILHD17KFVpd6L/kyt4C2ohJI5YejYthHK8bal8DUdWsJQZ14LI1zJQ9P5VgiQN2CXqDs1ISdKwZc4/wX+7ud2frtj63WEVDyzV6RBIwoWrHTTAroBVs/TGe2KF0pJzgLfbCuFbipBaPUmzZKOeU1SEnxjmnLFyRkyjwcyop7zHhmNuyFgZ42LWNDF4e7YpC8BZUnvw6I/tFzPYJkp/zxE0LDxlhXVMzBeTCycpHHW6N2CtOOc1xybL8m9UQTpjNb4ONtN1qM4PUIZvT5CAHg5Xdi2NvtSy4oHRHcN+V+SRbB9/f7sW46kGL2rlUiOKNpvQZhl4ND

On Tue, 3 Mar 2026 13:17:06 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 9928da636c9d..3b3aaf4831e9 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -1039,6 +1039,7 @@ event_filter_pid_sched_process_exit(void *data, struct task_struct *task)
>  	struct trace_pid_list *pid_list;
>  	struct trace_array *tr = data;
>  
> +	guard(preempt)();
>  	pid_list = rcu_dereference_raw(tr->filtered_pids);
>  	trace_filter_add_remove_task(pid_list, NULL, task);
>  
> @@ -1054,6 +1055,7 @@ event_filter_pid_sched_process_fork(void *data,
>  	struct trace_pid_list *pid_list;
>  	struct trace_array *tr = data;
>  
> +	guard(preempt)();
>  	pid_list = rcu_dereference_sched(tr->filtered_pids);
>  	trace_filter_add_remove_task(pid_list, self, task);
>  

Yep. I can make them two different patches. Do you want me to take this as
your patch? I'll need a SoB from you then.

-- Steve
