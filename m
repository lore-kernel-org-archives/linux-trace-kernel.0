Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063463242B1;
	Wed, 27 May 2026 14:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779891267; cv=none; b=Bb4WQelbiVPUZw/8RaaJMndHNbM/+e1+fslp3TR3zsEqZXPWw9ZGHjU6rvyXFkk1ja5OXCr/aOblAbY5WMJBia6CnoPVUclfRIk9B4rnR3c6LqKs+hbGQ9jEWfnGJ1ZYD4lyW3CQi+ypXaRMpFOQ7MLadXMdU+Z0ES6ctCrdT5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779891267; c=relaxed/simple;
	bh=jiDi6798aYjOVspkaevvR/c1/TU7wON0gG8mxkhUfDc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TAVmX1M2gNnaq5636jmc3O0U1VaIYbnHGzDL+hHRdf6lcZr1WziOQKev5c6aF01/OzgAVMzvYDRbsFT+HLK/MmYTICCTRcqvGfVQOobaNYg9wsABOsmUtw4/UppMqdHcFGifOWEDWkTwDslr7ytSHWfb3JY+YfLTsWmHFEaq19k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 8540B1405C5;
	Wed, 27 May 2026 14:14:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id A83A920016;
	Wed, 27 May 2026 14:14:16 +0000 (UTC)
Date: Wed, 27 May 2026 10:14:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Rik van Riel <riel@surriel.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2] perf/ftrace: Fix WARNING in
 __unregister_ftrace_function
Message-ID: <20260527101450.4e5840ef@gandalf.local.home>
In-Reply-To: <20260513161916.04151502@fangorn>
References: <20260513161916.04151502@fangorn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: kxn3ycap1boa6rowbaxutgoxprzfjszh
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: A83A920016
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX183Kv9LdJW2aHsrbhNave+E5ZIMUqxTPXk=
X-HE-Tag: 1779891256-343874
X-HE-Meta: U2FsdGVkX1/RF09eX0rFHvKbDLymfNFebmPbLNkqFN5GS7A+KD89AY+IBlj/9T62t1/XcS+j63DCvTcH47a85Tl+t2lZmq83zz92Zk5hBjiCnC+e5mp1am0vtlpxVBlBAIuyLiwRgXgq1TrajJ55uChnNpfQg3E4nAunzJ27ToFfjMiT3CM8FpfCqtqj0HfMJznF5ttDCRQ5huVwkaAxpQO12eRV7+lYfLFmi1m6hNrvGC0aUtgSW387BTwPNebvCC+XC6JTsn8ETSph8JAfy4jxtIBaqEilvjfMT2NPJd/iFkuLGu6j9mpKUx26Oyvkou7jQHVQl1YIbZfGcRKVfQEbwim0d20SqLLWw3CwoJat0uExx33p1O93CUuKa43EqiIj3RxhUVPmA0zpPifqxA==

On Wed, 13 May 2026 16:19:16 -0400
Rik van Riel <riel@surriel.com> wrote:

> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
> index a6bb7577e8c5..58e1b427b576 100644
> --- a/kernel/trace/trace_event_perf.c
> +++ b/kernel/trace/trace_event_perf.c
> @@ -497,7 +497,11 @@ static int perf_ftrace_function_register(struct perf_event *event)
>  static int perf_ftrace_function_unregister(struct perf_event *event)
>  {
>  	struct ftrace_ops *ops = &event->ftrace_ops;
> -	int ret = unregister_ftrace_function(ops);
> +	int ret = 0;
> +

Because this is different than unregister_ftrace_function() where it will
not fail if the ops is not registered, it deserves a comment. Something
like:

	/*
	 * Perf will call this unconditionally even if the ops is not
	 * enabled. The unregister_ftrace_function() will warn if called
	 * when not enabled. Just bypass the unregistering if ops isn't
	 * enabled here.
	 */

Thanks,

-- Steve


> +	if (ops->flags & FTRACE_OPS_FL_ENABLED)
> +		ret = unregister_ftrace_function(ops);
> +
>  	ftrace_free_filter(ops);
>  	return ret;
>  }
