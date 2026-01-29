Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013D754739;
	Thu, 29 Jan 2026 02:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769653748; cv=none; b=X7pXD2qSMshg5HPnbM1E50B13W3fWl+v00MOdNvuObpa13Z6MaKBDgfInO0GdWwGrpfIbSF+FOkA6NGliOCjsEDvcGJBqEVTQb0/hvKo03g5H50viAzPtGShrXLcWsaS6po6d1j0F7ehNYJg0/HP3vf5obMX3ogFdBTkIfmnquc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769653748; c=relaxed/simple;
	bh=NlqoF0p5y1/JVA761gJTp7v/dDnCEG7N4kJuwNu/wls=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mu9noigEkTyE2KdWlQvRDfPbjEhZPYxUe8NvwWtaJfXx1MsUwxZhn/MacR7Aby+8yG0n0jfeTRsbXONj+02rcHXyF0GxCo2Ks/eUYrvnwK8ACNnXe48/S84aNHJl0G+d4xxB4gWx00Otgne0DadnLE0fZ8mV6RNF9+/+HXIKuYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDoQ/L1r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDoQ/L1r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9BEC4CEF1;
	Thu, 29 Jan 2026 02:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769653747;
	bh=NlqoF0p5y1/JVA761gJTp7v/dDnCEG7N4kJuwNu/wls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cDoQ/L1rLJXr08uM3tx4LwR4l+SuJofz8+M8I6xk3pPRdVDuL75ZcwQ5QDWiCUgmq
	 bHuR5eq2dy4lkmGGD2rKNxoPtMM7WjqOtKCDVitCXlz0hMLdYpeyOookzXOZejQi6T
	 Lvno7llKA2Hm0ndiHca6895fLkpwgjkfvEv0irLu5s+lKh/VMk8WOjHHWBT72Q+j0E
	 7hyppyo5kAEoFaainNg4mFtXc0O1LaoZSPv9BvnWqiJxS6uGpL/z2tSy1Fww16oKQ/
	 0faA+Wt/+NBap2JjZKig9WB4iHzVV1+LsXeRnkdHgPOy914LcJbPGZGxwl/bwsJX8f
	 rY9hVQjy5nzTg==
Date: Thu, 29 Jan 2026 11:29:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Haoyang LIU <tttturtleruss@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org (open
 list:TRACING), linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: Re: [PATCH] tracing: Fix indentation of return statement in
 print_trace_fmt()
Message-Id: <20260129112905.5840a45972274dd0048e36f3@kernel.org>
In-Reply-To: <20260129013954.5325-1-tttturtleruss@gmail.com>
References: <20260129013954.5325-1-tttturtleruss@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jan 2026 09:39:54 +0800
Haoyang LIU <tttturtleruss@gmail.com> wrote:

> The return statement inside the nested if block in print_trace_fmt()
> is not properly indented, making the code structure unclear. This was
> flagged by smatch as a warning.
> 
> Add proper indentation to the return statement to match the kernel
> coding style and improve readability.
> 
> Signed-off-by: Haoyang LIU <tttturtleruss@gmail.com>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
>  kernel/trace/trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 8bd4ec08fb36..bf0ce2aac177 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4286,7 +4286,7 @@ static enum print_line_t print_trace_fmt(struct trace_iterator *iter)
>  			/* ftrace and system call events are still OK */
>  			if ((event->type > __TRACE_LAST_TYPE) &&
>  			    !is_syscall_event(event))
> -			return print_event_fields(iter, event);
> +				return print_event_fields(iter, event);
>  		}
>  		return event->funcs->trace(iter, sym_flags, event);
>  	}
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
