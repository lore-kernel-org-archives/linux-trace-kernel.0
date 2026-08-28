Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2845125B08D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Aug 2026 16:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787934829; cv=none; b=iVDRpNiLrGiOWS+ZvtTGNEvnkuTSL0PAJJ4mNV8IQBlHWySWsdRX3zxq2ICF8sEX1o8uwIY+rRTQQMa/uLuUe7IB4HfsGj7HQsxzS3psoJ411s1y7WAasfBI+8F/2PKxvUlyoPJKFRTlFeIod8zWs2jOCqfiGCm84hgTg5A2sT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787934829; c=relaxed/simple;
	bh=9HSRueymnHQnumlP71WqP6C9CeR414LuTtFYONZ46K0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MEqy3YWUdy2tCjymxYC8wS1IX3cEbx8ImgIVgGk7zFW6ZVjjL51/mtYo9Uokk0roK/O5/h/1Lcl2eUBtiS/DNazQ8Udb9nAGjIyRE3EQGHrwMeBwoQtvZksJD8+JVWDz8Sz/3AmNWkMaurfdu8WPYupXIICThxR7I3ODGRmwqEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=5KmBiQoY; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="5KmBiQoY"
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id BFBFFC046C;
	Fri, 28 Aug 2026 16:33:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 1215F80012;
	Fri, 28 Aug 2026 16:33:40 +0000 (UTC)
Date: Fri, 28 Aug 2026 12:34:30 -0400
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
X-Rspamd-Queue-Id: 1215F80012
X-Stat-Signature: dd9yjheigdjgcxoa7cs94h7ksem8fjfc
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19ilEJ0sPgTXV3zdQZWVvo4cNFXGrg1yaA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=3a4s3Zj8VMrkmsYP6OiMSzG3EOe0UYRfujTzuOKdAqQ=; b=5KmBiQoY3pJc0pcJFD45K/fmT+ApIneFQLVrtoyT1w9+bGsOt4C9ZiQzchsKyHLzIZyKGMbPaFb3PmBMCHMcal+ll3NeWQuJi81oZEaliimpz6ZFjHASmRt4dfr675h7Li7vMB/pxzHQTI5bMB+uXRN0a/GQmkjLZuh1M/Aubf0=
X-HE-Tag: 1787934820-738212
X-HE-Meta: U2FsdGVkX1/C1JSNPQeNeDT8DPFkgEjw6mP66+v/BcrHZVwL+eM+nvKAm6cckN88Icn/tjq1FeABat3gzQXvQWL0vSXayNmnzibAV4N0arBt3x8vzGifZErrg/Zzv9lUcSvickEx5gaN7JQZ7KNXKjildNRLuY9AEFzJmv7CPHM5h/D1VNHf49QE3qJYh255mTvBvwYuvntoxjZRpwJF2rlNXzFIqo2fP5r+qDNtKef55lOMg5iMCkJLIEdXi/ZEs0LkuW86uHGF9PT2ZCsycB1yxNUv4p7BZPj9y2qUfGNMDCkLYUDymI9SwIpPy9+/ltLxWlmoH1+jbytIRoJtEHIndn+mif//

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

-- Steve


>  
>  	trace_create_file("set_ftrace_notrace", TRACE_MODE_WRITE, parent,
> -			  ops, &ftrace_notrace_fops);
> +			  ops->private, &ftrace_notrace_fops);
>  }
>  
>  /*

