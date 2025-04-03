Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A822253F26;
	Thu,  3 Apr 2025 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743708947; cv=none; b=Ib1AH+84P61AVadT+n6+OpCrX1g1ZH7CKI6T8RCA9rTf+tDKjErJ5ATnfC/F6+SkoMQLrIO2jk8Vzq+VkCEuXFNDPO71JLOFPBkNTeCmxnNPAVNpB0Cn9uRo5K18SESBHTffrXY3pGuOoQtTzHcTGV45zfwN4CiLZGdEZVijnAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743708947; c=relaxed/simple;
	bh=SfudcGVvgUwCu02nkG9Exu6y8ntGP9LdeWrTt3lMa5A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D6z8B36xHcElE6oJ/Z90XdW56h/K/1oY9Da0eaP9WLVET/Fv4BUDQCw1uDZfWQHeKWzvnx4AydnglUqFwWvuA+e66TEsqHE9sIB/RvIkjBcvluIydo4+vapqArou/062bXSRAhn6OQK5KdRF/zL6rdGQQ0n9j7DWYxo2D5NXskQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9956C4CEE3;
	Thu,  3 Apr 2025 19:35:45 +0000 (UTC)
Date: Thu, 3 Apr 2025 15:36:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Devaansh Kumar <devaanshk840@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] tracing: Replace deprecated strncpy() with memcpy() for
 stack_trace_filter_buf
Message-ID: <20250403153651.1188135b@gandalf.local.home>
In-Reply-To: <20250403191342.1244863-1-devaanshk840@gmail.com>
References: <20250403191342.1244863-1-devaanshk840@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Apr 2025 00:43:40 +0530
Devaansh Kumar <devaanshk840@gmail.com> wrote:

> @@ -537,14 +538,16 @@ stack_trace_sysctl(struct ctl_table *table, int write, void *buffer,
>  	return ret;
>  }
>  
> -static char stack_trace_filter_buf[COMMAND_LINE_SIZE+1] __initdata;
> +static char stack_trace_filter_buf[COMMAND_LINE_SIZE+1] __initdata __nonstring;
>  
>  static __init int enable_stacktrace(char *str)
>  {
>  	int len;
>  
> -	if ((len = str_has_prefix(str, "_filter=")))
> -		strncpy(stack_trace_filter_buf, str + len, COMMAND_LINE_SIZE);
> +	len = str_has_prefix(str, "_filter=");
> +
> +	if (len)
> +		memcpy(stack_trace_filter_buf, str + len, sizeof(stack_trace_filter_buf));

Hmm, this location looks like it can just use strscpy().

-- Steve


>  
>  	stack_tracer_enabled = 1;
>  	return 1;
> -- 
