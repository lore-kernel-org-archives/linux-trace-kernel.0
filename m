Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B713D954C;
	Fri, 31 Jul 2026 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504126; cv=none; b=ExE5+Ap/wE2WDLU5FznEosWTzq3grUJwkSXJUjAq4Mofs7keI9s7+hFghqFG2a+WxHxLxdjlachYmqDYyNgpsf5E+UiYl9Ww/AkcCh0CSxMaUh/fCYDPVT9QAS7J2wSF6unchI+cnafGUYS79nQnIEmachYE5XIdaAmzWbNViYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504126; c=relaxed/simple;
	bh=iGnvQQ2S7+ezc2CSoRdmU5disoF67aKOATob0Ym9JR8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HXNR8Px37Fy+M02ekBU8+5dxlUXkvya4XnzStUfBCY0MWEj/RdP28kzgqa+6iERBQC/aQ4SvTN3LitEvb4QqGZw54fRNNCX/VS9dVACJKI1hqcX48VuJNa3Eub6eqLLtd58aS3Xo7PQ+YDMOk8gdS3/6WXcYHEOzFL+0o6OqL9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 05551160428;
	Fri, 31 Jul 2026 13:21:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 5C8C320028;
	Fri, 31 Jul 2026 13:21:55 +0000 (UTC)
Date: Fri, 31 Jul 2026 09:22:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Wu <michael@allwinnertech.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tracing: Fix race between update_event_fields and
 event_define_fields
Message-ID: <20260731092235.4edd9dbd@gandalf.local.home>
In-Reply-To: <95efe185-35dd-18be-f08c-af4d0965b013@allwinnertech.com>
References: <95efe185-35dd-18be-f08c-af4d0965b013@allwinnertech.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5C8C320028
X-Stat-Signature: pzmm9pyyyoxcsbiphjrt3s8d18dk7q4g
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19b2OYxEYIrF8jtmut4+jQ7WKKOxG5jbPQ=
X-HE-Tag: 1785504115-613702
X-HE-Meta: U2FsdGVkX18VTcTV+UQi4CJ0GvR/FTydZ08wQhAAJ0rg3GGLUHShK9nBp7PzCnjbiw/nwj0xflmwQj+rst69gssFrJLslcghCQ9vGHxK07HLBknlF1EBKWRo4W7hRTw2RCbuTM6GmSZOy8ijudNwg6jDkRlMVStGy5akPqHclaGcvQT0z7JEBp3ZBP0Ddw7t7NZ+4GcLGrlgMY+c1g9yXv9/peDWIrobwX6tl2tmllSZEadEYAS5sgzUythv0PDcbldRZZEnz1PzZHA6W5QCdLIjBMT48F+dLhRwPKACd+Qh7LFSwd+pRWWlExd9l5wRoad09nR03C4nJUKuh1MC98oDc4R/13W9iwn1uLGkOet9pONs+rf08/4V2aIPU8eMr49MvkrRjy0F5dIz6dGb0A==

On Fri, 31 Jul 2026 11:41:02 +0800
Michael Wu <michael@allwinnertech.com> wrote:

> An alternative of placing mutex_lock inside update_event_fields() was
> considered but rejected -- it would invert the established lock
> ordering (trace_event_sem -> event_mutex) and risk ABBA deadlock.
> 
> Fixes: b3bc8547d3be ("tracing: Have TRACE_DEFINE_ENUM affect trace event 
> types as well")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Wu <michael@allwinnertech.com>
> ---
>   kernel/trace/trace_events.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 956692856fa8..9632788da5af 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -3566,6 +3566,7 @@ void trace_event_update_all(struct trace_eval_map 
> **map, int len)
>          int last_i;
>          int i;
> 
> +       mutex_lock(&event_mutex);
>          down_write(&trace_event_sem);
>          list_for_each_entry_safe(call, p, &ftrace_events, list) {
>                  /* events are usually grouped together with systems */
> @@ -3604,6 +3605,7 @@ void trace_event_update_all(struct trace_eval_map 
> **map, int len)
>                  cond_resched();
>          }
>          up_write(&trace_event_sem);
> +       mutex_unlock(&event_mutex);
>   }
> 
>   static bool event_in_systems(struct trace_event_call *call,

You need to fix your email client to not mangle the output. It replaced
tabs with spaces and wrapped text, making it so I can not apply the patch.

-- Steve

