Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526AD346A14
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Aug 2026 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787934848; cv=none; b=jJu0biyfNTSXi6v6Fjipex4mnWFQOM/ykaM8HvmkHcQFF3vFsWCnohvMOuWAAv1w0zWpl0mW5HHs9IYzLjNSCcgVe3Yv6IBxVQ+tg/Imb+eX0Qsu44Syo0fvGJa/NiKnb5CfeKirVjPv/BC0+1Qgi0f0cP+H5JC7MwNJ9OBmBoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787934848; c=relaxed/simple;
	bh=SMBK2Yy7EbjA2SEaIooljoEXmFpi0vgTfw4WNzbXxM8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YRlyeEfdd8y3IMAej9wQc73MjPVxHUIMAmXfkgiZnPZIaNyj1HiiRCaigw2RdabcdKRJ7cI/incc4jJ5lrZg2N2U1ZaN18RgbAJyjhc33OCwTGaqx7v7xOeDK6Pse36DH1iB2g2wp7e0MAvyP9J1Uzyksgr5xRoaPGEw7+cLLkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=onZ96OnV; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="onZ96OnV"
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 5EF30A0477;
	Fri, 28 Aug 2026 16:34:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id B4D1720027;
	Fri, 28 Aug 2026 16:34:02 +0000 (UTC)
Date: Fri, 28 Aug 2026 12:34:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Breno Leitao <leitao@debian.org>
Cc: mark.rutland@arm.com, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: ftrace: UAF in ftrace_regex_open() on a removed tracing
 instance
Message-ID: <20260828123430.22d43b44@gandalf.local.home>
In-Reply-To: <apGwPEj65dcbZFxS@gmail.com>
References: <apGORjltZgAiAYHT@gmail.com>
	<20260828104201.21aa9d08@gandalf.local.home>
	<apGwPEj65dcbZFxS@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 5yi85nyoky7kbqynbo4y16nzwkw185oi
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: B4D1720027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+D+plsFRN12ivv4iCA5vfIigbWuXeHlsQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=VUWdWiE20cmNutD4YDHUMmXMGw9dsti+jXOrsvFJPwk=; b=onZ96OnVa+Wcrm50/yBkJtbu955pWQ2k0ou2ciTtd679XPdLUlm0cQnOwJxqyydePcAT0kU7+tMyGHAOLbbKbfqpI94IxBrqtPjGwKXKSmfqdEB/RJe/7zogImgn85g3PQ5//UdsuC9JsC+Eyu5PSphcZN3FasNWfkI7+qUzYkQ=
X-HE-Tag: 1787934842-838244
X-HE-Meta: U2FsdGVkX18xNdSOMMjpAy+Gc4O7vwkHvNidlHSx7URjm5N2GatyaFBEcMqwmJo1ICiMCpNMpC2tjpGYcKrbv7NJhjeSQhvUVQEA1cCcrtgdX/0gkSRMhmxdlzOBZ4Cm7ruP2OvhJs08eXLwJ3DXsiNh6LW7sW88mB5V9d6OkCwElUxRQ/4O7dBoFghatrVhh7gPAzQYxyWBwHYI3biBQXNeFKjrzZ/cvLE5mksy38bCz/jqBuqYgWzo2xx0c2c2zprmRAlm6JkWMdRh8nqPE4/zs7zdScTeMPe8HJ4X3drtcVJzSosKf0iusO9wUBMYkRwWqC6uozrAXaj7HVCswmPYAusVjRM7
Message-ID: <20260828163452.FSU7ejbJe9onK4amKMjmoCOJqemfXwQZjCrHsdy33eY@z>

On Fri, 28 Aug 2026 08:59:39 -0700
Breno Leitao <leitao@debian.org> wrote:

> 
> My LLM came up with something like the following, and it doesn't
> reproduce the problem anymore. Very similar to your code above:

I know the solution but there's subtle things I want to make sure that
works.

> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index f9d80c7bd9f16..37845399fe5cf 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -4788,22 +4788,37 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
>  static int
>  ftrace_filter_open(struct inode *inode, struct file *file)
>  {
> -	struct ftrace_ops *ops = inode->i_private;
> +	struct trace_array *tr = inode->i_private;
> +	int ret;
>  
> -	/* Checks for tracefs lockdown */
> -	return ftrace_regex_open(ops,
> -			FTRACE_ITER_FILTER | FTRACE_ITER_DO_PROBES,
> -			inode, file);
> +	/* Checks for tracefs lockdown, and that the instance is still alive */
> +	ret = tracing_check_open_get_tr(tr);
> +	if (ret)
> +		return ret;
> +
> +	ret = ftrace_regex_open(tr->ops,
> +				FTRACE_ITER_FILTER | FTRACE_ITER_DO_PROBES,
> +				inode, file);
> +	/* ftrace_regex_open() holds its own reference on success */
> +	trace_array_put(tr);
> +	return ret;
>  }
>  
>  static int
>  ftrace_notrace_open(struct inode *inode, struct file *file)
>  {
> -	struct ftrace_ops *ops = inode->i_private;
> +	struct trace_array *tr = inode->i_private;
> +	int ret;
> +
> +	/* Checks for tracefs lockdown, and that the instance is still alive */
> +	ret = tracing_check_open_get_tr(tr);
> +	if (ret)
> +		return ret;
>  
> -	/* Checks for tracefs lockdown */
> -	return ftrace_regex_open(ops, FTRACE_ITER_NOTRACE,
> -				 inode, file);
> +	ret = ftrace_regex_open(tr->ops, FTRACE_ITER_NOTRACE, inode, file);
> +	/* ftrace_regex_open() holds its own reference on success */
> +	trace_array_put(tr);
> +	return ret;
>  }
>  
>  /* Type for quick search ftrace basic regexes (globs) from filter_parse_regex */
> @@ -7496,11 +7511,15 @@ void ftrace_create_filter_files(struct ftrace_ops *ops,
>  				struct dentry *parent)
>  {
>  
> +	/*
> +	 * Pass the trace array and not @ops, as @ops is freed when the
> +	 * instance is removed, but the trace array can still be validated.
> +	 */

I hate these comments. It's really pointless to state this. It's a "no shit" comment ;-)


>  	trace_create_file("set_ftrace_filter", TRACE_MODE_WRITE, parent,
> -			  ops, &ftrace_filter_fops);
> +			  ops->private, &ftrace_filter_fops);

But this also assumes that ops->private is always a trace_array. Which may
someday change and we will get a hidden bug if it does.

This is the exact reason I want to look deeper at it.

-- Steve


>  
>  	trace_create_file("set_ftrace_notrace", TRACE_MODE_WRITE, parent,
> -			  ops, &ftrace_notrace_fops);
> +			  ops->private, &ftrace_notrace_fops);
>  }
>  
>  /*

