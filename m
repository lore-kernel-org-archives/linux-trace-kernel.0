Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E792690EC;
	Sun, 30 Aug 2026 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788103667; cv=none; b=ZvgOmNKgwjQHSeck/OLN0a7s3TIwKcRQJtBjux69+woKFOLyif/oyi86YsKGGDEC5LvX8QKSoy+Ehlrq1Q3wfUNtRk3mRMM/7xPMRIxvHwqxNlCeD2RVGsN6dKSpNGcyT7xtT8u469F45kTaNubwr62eICBfN2oWZdIa08xnHwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788103667; c=relaxed/simple;
	bh=I7Ge3OAJGK9JQhfcKD1K/P9hN6xI8VC1tbOgPs0s1zI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFHxMlX4Pgwdty8Yw0iZiy7jcw1dGwgTvfpnwII4iqPdUgVtEqDvQW7oCJMXJRNq2yWYUQBvXJbXcgffzBNuaSZGW9d6pFwRNsOy/1JApxoWthQhfZ8qUytqx/hD7VceLbc+NEt2rjl5sRIG4FLJS41MY7QKe5Lf+rrMegfeqWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AM7Wjfkr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AM7Wjfkr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=A3IpWgOyKaN3UdCIY6ZmmklNOhbLYQXe6zzrRcPkFWk=; b=AM7WjfkrdRPZouVvW8RNYyh+xq
	O924yClD3Gds5H9EtmO4JoZU7Bnk2KhFLGsC0/TzPQTURamNZMyK4Z6TdCC0t2YTrIsq1odUukpd4
	6RNDnIPjOPQlDXXeiM56Si7ipg/paQmcQ/WDWjdPEzve624EZrJyAPTPb7whVV/fugcqeu12OQPR7
	t59tyRF2xTzBN+8P2MPm7x8bC6tfc5MuMVJNgF7CBMTtv34FwUh3+uEAe0QBRYyiTqFUHjzWqukwZ
	xXa8ClIbGDLS0Idzhm+gVUqcOPC10LhX7Hz+KEg1qEYqFJWNkeiyTp+Q5mTM7ikcH/dPWLP0Gv78W
	9eQijlmA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0hRY-00000007rGG-0RMe;
	Sun, 30 Aug 2026 15:27:36 +0000
Message-ID: <a61aa866-f95a-42fa-86d8-86f0726e0d00@infradead.org>
Date: Sun, 30 Aug 2026 08:27:34 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/4] Documentation/ftrace: Document function comm
 filters
To: hu.shengming@zte.com.cn
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 mark.rutland@arm.com, corbet@lwn.net, skhan@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, ran.xiaokai@zte.com.cn, xu.xin16@zte.com.cn,
 zhang.run@zte.com.cn
References: <20260830191258354QN6qx13iCRbQd2Uj3Ve2s@zte.com.cn>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260830191258354QN6qx13iCRbQd2Uj3Ve2s@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/30/26 4:12 AM, hu.shengming@zte.com.cn wrote:
> From: Shengming Hu <hu.shengming@zte.com.cn>
> 
> Document set_ftrace_comm and set_ftrace_notrace_comm, including their
> write and O_TRUNC behavior, accepted comm names, interaction with PID
> filters, and when a task is rechecked after its comm changes.
> 
> Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
> ---
>  Documentation/trace/ftrace.rst | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index 7261f25f8b4b..a96fc436ec16 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -313,6 +313,37 @@ of ftrace. Here is a list of some of the key files:
>          If a PID is in both this file and "set_ftrace_pid", then this
>          file takes precedence, and the thread will not be traced.
> 
> +  set_ftrace_comm:
> +
> +	Have the function and function_graph tracers trace only threads whose
> +	task comm is listed in this file. Names are matched exactly and must
> +	contain between 1 and TASK_COMM_LEN - 1 bytes.
> +
> +	Each write adds one name. A single trailing newline is ignored, while
> +	embedded newlines are rejected. A zero-length write or a write containing
> +	only a newline adds no entry. Duplicate entries have no effect.
> +
> +	Opening the file with O_TRUNC clears the filter. Otherwise, writes add

Is there a way to clear the filter from (in) a shell script?

> +	names to the existing filter. From a shell, use >> to add a name without
> +	clearing the filter. Reading an empty filter prints `no comm`.
> +
> +	If both set_ftrace_pid and set_ftrace_comm contain entries, a thread must
> +	match both filters to be traced.
> +
> +  set_ftrace_notrace_comm:
> +
> +	Have the function and function_graph tracers ignore threads whose task
> +	comm is listed in this file. Matching and file operations have the same
> +	semantics as set_ftrace_comm.
> +
> +	A match in either set_ftrace_notrace_pid or set_ftrace_notrace_comm
> +	excludes the thread and takes precedence over all include filters.
> +
> +	Function-tracer task filters are evaluated when a task is scheduled in,
> +	and the result is cached per CPU. Changing a filter refreshes the result
> +	for currently running tasks. If a running task changes its comm, it is
> +	rechecked the next time it is scheduled in.
> +
>    set_event_pid:
> 
>  	Have the events only trace a task with a PID listed in this file.

-- 
~Randy

