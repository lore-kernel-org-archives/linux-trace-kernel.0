Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DE04C9010;
	Wed, 13 May 2026 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690027; cv=none; b=p1VAnFiQCg1LoNNDZY19z0pO+ET/tSDXdqbDpniz3ZZtLdTes5U9bvECwUObUOK0lYJ9Y2TTQkoGc+ejyEFqZkAcxjs0mRxqWInHE0rpF8Zvt0/UCnoo9f+qsOmcoKf7aWHipUw1jB2GubxM7Wmkg9owb0rgA8WZlqrKO7tx+V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690027; c=relaxed/simple;
	bh=cTKxd5349hwmNXevB0MD8pp+RnEGsmYmx0OQf06OOrM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FIqPLHIrAl0pPDfu//k50WcxMS9VzhizvsWFSR6KQV8zmsGHrQqV/bl7pQlDVkSPlb3rR3Rw/l/txFLsGEYkXsFsRjgNKjP6Xmwzk9r/QU1UMpgiddv4SskjZuLbUxDGAQ7vpazuGOwV+VDRpIClkQEesOHImjvUxtboowaIMxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 0309B1C0E19;
	Wed, 13 May 2026 16:33:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 0107B20025;
	Wed, 13 May 2026 16:33:41 +0000 (UTC)
Date: Wed, 13 May 2026 12:33:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Rik van Riel <riel@surriel.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] perf/ftrace: Fix WARNING in
 __unregister_ftrace_function
Message-ID: <20260513123344.05b6bcfe@gandalf.local.home>
In-Reply-To: <20260513121607.14eab1f6@fangorn>
References: <20260513121607.14eab1f6@fangorn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0107B20025
X-Rspamd-Server: rspamout06
X-Stat-Signature: bjej6xff9gjptjwfusjn464tuu6eoqky
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18oxvKOnzneY0W1jBt9V2HR695X2q7WMXc=
X-HE-Tag: 1778690021-544956
X-HE-Meta: U2FsdGVkX19k56GGkglFqBzPLiFeVLA0JjUMUEGXyZ2X9Mp3mn9EhKGrTcO71a76/22bfHl231jN/IvUFIbkl70fw/naV1qjDwQJRGq/mAbKL0uvT0A496qFHk/QeHkRKEwlZ9R5WGJxXRXwH3uXi3xpSp4vnOpi2kTk8ZVmihjFe2lI4DtLPLfk0+M3za+u9BasefT77HaeN7wXVZcmLPcyG5BV+QkEP14mvKoIQc3/vyMLjIt/CyDAV51j0DnNAkEhIRI+qiE3wn4pwhINRImaK/hdR4s4lrTWz+dwTMhnodHD8QEqTrd/BrphKV2FjbvExeTAf+z2EyPJ9TreVpNJRkjxDyNSJAn1cwhmj6L8WCNfBu4ufUeteuzAw18dgi4TntFUIHDEgM+1SYBxJQ==

On Wed, 13 May 2026 12:16:07 -0400
Rik van Riel <riel@surriel.com> wrote:

> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
> index a6bb7577e8c5..b9e33ae24867 100644
> --- a/kernel/trace/trace_event_perf.c
> +++ b/kernel/trace/trace_event_perf.c
> @@ -497,7 +497,14 @@ static int perf_ftrace_function_register(struct perf_event *event)
>  static int perf_ftrace_function_unregister(struct perf_event *event)
>  {
>  	struct ftrace_ops *ops = &event->ftrace_ops;
> -	int ret = unregister_ftrace_function(ops);
> +	int ret;
> +
> +	if (!(ops->flags & FTRACE_OPS_FL_ENABLED)) {
> +		ftrace_free_filter(ops);
> +		return 0;
> +	}
> +
> +	ret = unregister_ftrace_function(ops);
>  	ftrace_free_filter(ops);
>  	return ret;
>  }
> -- 

Instead of duplicating code, what about doing:

static int perf_ftrace_function_unregister(struct perf_event *event)
{
	struct ftrace_ops *ops = &event->ftrace_ops;
	int ret = 0;

	if (ops->flags & FTRACE_OPS_FL_ENABLED)
		ret = unregister_ftrace_function(ops);

	ftrace_free_filter(ops);
	return ret;
}


?

-- Steve
