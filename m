Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671C1353A84;
	Mon, 13 Jul 2026 19:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971397; cv=none; b=AwRHwkxf8JFMGojbUvcYx1A7xpBdjQj9s7qzaCfcMcxQeEfMKc/6R/oJszHEv3WFBOSvG687/2H5a6iPHrG85I9GHO1oJeFwnmHBloZP5Xg+Ns8cgaJZJJSVJHV1f1VGPTb3VmXO787rZtD+dITu4pKKVU7Lb4GLPNu76qhxv58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971397; c=relaxed/simple;
	bh=MKxzhcRbqf0CzYJHw0h06Hayxkh/4d/3VgKHnMOEJUA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UzvL42t6szPNFL02GO4GVmvS3OFbpSbphXW7w0ZenHRnQLMvqYkeuSTTaslAI5n+ALm3DoYa+CurtmVyfBhJQ6P0SdoJKU3GY1D3j5vySBMXNG455phTveb4gth7kk2Nx1iRmrxfu7OkH4zOLl2kP5wwKv7nQIh4i60tkBFO5r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id A7A5916013C;
	Mon, 13 Jul 2026 19:36:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id BF09E20014;
	Mon, 13 Jul 2026 19:36:25 +0000 (UTC)
Date: Mon, 13 Jul 2026 15:36:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Add mutex to trace_parser to fix concurrent
 write races
Message-ID: <20260713153624.48fc4be4@robin>
In-Reply-To: <20260713134640.708323-1-wutengda@huaweicloud.com>
References: <20260713134640.708323-1-wutengda@huaweicloud.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BF09E20014
X-Stat-Signature: h4dezhr6a3a1z6wmiiqru7p6c99xtha3
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19BEx2XOzfKBi47hNiYhp8Y0jQy951kWls=
X-HE-Tag: 1783971385-36165
X-HE-Meta: U2FsdGVkX1+ZXTx38Fu9M9bLcae2fY0NfEyIlbkSn/FeovjJk9MY7Ann1lQkU7dBdvE2VZeSOl/cim/NrH1oNSY+ZIXeyiqRk7G1DdFJ1oRV1R5UsbWrYdQjZNSLxxlAbBQv9NLcoVEWSqb24/1sRRB8mZRJyfv/CsxkLImEbmVtnzUmFjhe5HNTswP9qgSLQJnEaC5ZTybPQa9L5/41lJm7zzZo0hX1Iv1C5NwPOOu2jhbMqtRb67d3LKe2sslJJo1WT9ZVBSS0ZA1BbDTBD60v/bwlTea8rTfm3OfZhtKqtCJAqX5LFU/mOvVZuafoy8f84+6Dv9piagra/kxa20Wr8eFjcO9BS+r40xtfm9D1gw7TRkJefg==

On Mon, 13 Jul 2026 13:46:40 +0000
Tengda Wu <wutengda@huaweicloud.com> wrote:

> The trace_parser structure is allocated and initialized when a trace
> file is opened, and is subsequently used in the write handler to parse
> user input. If userspace opens a trace file descriptor and shares it
> across multiple threads, concurrent write calls will race on the
> parser's internal state, specifically the idx, cont, and buffer fields,
> leading to corrupted input or undefined behavior.
> 
> Fix this by embedding a mutex directly in struct trace_parser. The mutex
> is initialized in trace_parser_get_init() and destroyed in
> trace_parser_put(). All write-side users that access parser state
> (trace_get_user() followed by checking trace_parser_loaded() /
> trace_parser_cont() against the buffer) now hold the mutex across the
> full critical section, avoiding any TOCTOU gap between the parse and the
> subsequent consumption of parser->buffer.
> 
> Affected write paths:
>   - ftrace_graph_write / ftrace_graph_release
>   - ftrace_regex_write / ftrace_regex_release
> 
> Fixes: e704eff3ff51 ("ftrace: Have set_graph_function handle multiple functions in one write")
> Fixes: 689fd8b65d66 ("tracing: trace parser support for function and graph")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  kernel/trace/ftrace.c | 7 +++++++
>  kernel/trace/trace.c  | 2 ++
>  kernel/trace/trace.h  | 1 +
>  3 files changed, 10 insertions(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index f93e34dd2328..ef47e5659283 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5842,6 +5842,8 @@ ftrace_regex_write(struct file *file, const char __user *ubuf,
>  	/* iter->hash is a local copy, so we don't need regex_lock */
>  
>  	parser = &iter->parser;
> +
> +	guard(mutex)(&parser->lock);
>  	read = trace_get_user(parser, ubuf, cnt, ppos);

Why are the other users of trace_get_user() not a problem? If
anything, trace_get_user() should have a lockdep assert to make sure
the lock is held.

I think we need to add a lockdep assertion in all the callers that use
the parser and we need to make sure it's taken by every user.

-- Steve
