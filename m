Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3853F3783D4
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Aug 2026 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787940205; cv=none; b=hH1IZhFD5gOeGiyhsCtp1jC3/PjPVumR4UyNTdQz53KA4qXpnBVdrhH7/YXoS6CVQ2Z/fnIeeSK/wURWFUQnj90UwuANi4NczmFyYI/Ji+f4z/ApRSZwoSIemmp46vBN9bTxmhKih37XbzVanBllw33kDv5x/W5a+AUl14B6MGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787940205; c=relaxed/simple;
	bh=NEoW4M2m66oazI3K+NqY6eHiPONCRAdxUC+QZioUgAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJw/Dj3Nygp3s8G/fgziuX1BeIuCz9ZnrVAXsAPPpAQQ2Hn55lvYpcyARkvApkusZekh5s3AuUUPJKV49MRhufpJ5sn95XhiAhPVJomUCp+8AA7ju5lJBOZBRnGNTOhsCixURgSFjrV7A3YlRfelUC4FnCEbV+24jMp0pghLXog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=ND4QpNVu; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="ND4QpNVu"
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id E60E31C18A9;
	Fri, 28 Aug 2026 18:03:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 5D10B17;
	Fri, 28 Aug 2026 18:03:21 +0000 (UTC)
Date: Fri, 28 Aug 2026 14:04:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Breno Leitao <leitao@debian.org>
Cc: mark.rutland@arm.com, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: ftrace: UAF in ftrace_regex_open() on a removed tracing
 instance
Message-ID: <20260828140411.14108739@gandalf.local.home>
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
X-Stat-Signature: g333a8tgko8jfgnfgaf5iu3h6nii4ro4
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 5D10B17
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18KSkDNHBaWiS0kxqvWgGGzl0+4Lj2ORlE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=AsN26t+++SRg3GFrPT12qF8sku+3xGSjuN56lg3xLLY=; b=ND4QpNVuYscP7VIP0jnKL37/QsN9FeoaALy3hCbZrBCrblDYyRhsV7AW2HJ3utZaG3EuWwNmYxEGZoLxg8d00PcyhDZukWumULHZdEQGLg3H/v/vU5HokpDdeohlZa3N7Pq7gF+Tdl5/cXF2QEoR4/PpEdTNhTMFiA0FW47ls+o=
X-HE-Tag: 1787940201-837571
X-HE-Meta: U2FsdGVkX18OTSXEZTmTzCQzuSw8HvBRKe3slFDll+Vv1bX8abgtEBWIyn2VR6M0hL3l7A+iXo4dI4ONVZatpH5isnZpBH1ec15yDRT80YymQedL5Ctwd8X8+ZIr81Bt2dW74rAIEotx1pavOuDYP7KievmQWRnj5C0LWcp+KqUza5f9AOfP+BC0drp8sBquLijxA2dp4TZCAlkYudbCk8tK8SgNBUENrUHiaJrx3+JzygVI/qgXvOm2drUk7bU/alSBbFVk6TNmUzNKsq86PX/eIA9debiwmjxD9dg0aVkUUIeFCqc/Pj1ElIltzI4IOJK2eNPbEHti5uq0E9yXru8gJQb94Exy

On Fri, 28 Aug 2026 08:59:39 -0700
Breno Leitao <leitao@debian.org> wrote:

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

Hmm, I just noticed this part (from reviewing my own code first, and then
looking at what your AI did).

I guess the issue is that the ops may be freed before you get access to the
trace array. Anyway more needs to be changed. I may remove the extra
reference. No need to do it twice. Also since trace_stack may have the
issue too.

-- Steve


> +	trace_array_put(tr);
> +	return ret;
>  }
