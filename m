Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A312DA50;
	Mon,  7 Apr 2025 01:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743987874; cv=none; b=SjIdf3tSYZQO1+NaQpGru9+nheHRLr373YQJO7KajekdKyuPfJmSGZAXsj9fCZ5YfG0ez25SlJvrld0TXuMHuP4JLTL21oVj+IHhOJn/lh39hYas7RHEm3OkO+pLNw/uWnZWheF+PIVNqK1jkmodqyTKv78AzNktBWQIUjvSwZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743987874; c=relaxed/simple;
	bh=JKMvMFObK6FIBHypWWc6gchTEsm37qqvTo8DKKDS2JI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LqCffiA/TEtMFXAsrG/hYQwMQI4fEmyogyKB4wiuxA2Zp0wxZy4U2Wx/oH6w+UYw2qEjwaonieqImF+EgIZ1rdB68IquqqYyWKkGfoXGw9mPWWCGcPN/qYkFYMN+Drbdf7fLa4VPZmNqGs8ZhcOR8JuvUcjY23GBT4IE+58t2fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Radphs9d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Radphs9d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65496C4CEE3;
	Mon,  7 Apr 2025 01:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743987873;
	bh=JKMvMFObK6FIBHypWWc6gchTEsm37qqvTo8DKKDS2JI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Radphs9d7GdMTJTlhc1VfWtIbB+R1wde9GtJABPr22OP5rYkrdpTYfHcOEh8kikPG
	 7PcdNxlFawShbp/Uy3QFpsH5uL+KN6rPmg5bdmqTnOK6jzyE31WWaPFVQtr1JgUn+J
	 lbyuJRC2kuG3Ng6V3Pbm4MytmenM512Gr3v5o2phTAAnp2JamrqM2QyQma/EiR3nHe
	 4jhpidBRuZvgJkKmLH6Wr3EpwEOZWppj3EACnAT8f6L4XkO5dh2YGtMTdm+DSR6Uqj
	 q6shFWBvFkvwYceLp9fDiowSkQYnplCdYTH5jCChdZ35G+2vbYTVxhkP3MYwxExL8b
	 O0wQH2ltGA9iw==
Date: Mon, 7 Apr 2025 10:04:30 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tom Zanussi <zanussi@kernel.org>, Kees Cook <keescook@chromium.org>,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] tracing: Always use memcpy() in histogram add_to_key()
Message-Id: <20250407100430.5fbc9d1de5eb0c4c552323d9@kernel.org>
In-Reply-To: <20250403210637.1c477d4a@gandalf.local.home>
References: <20250403210637.1c477d4a@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Apr 2025 21:06:37 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The add_to_key() function tests if the key is a string or some data. If
> it's a string it does some further calculations of the string size (still
> truncating it to the max size it can be), and calls strncpy().
> 
> If the key isn't as string it calls memcpy(). The interesting point is
> that both use the exact same parameters:
> 
>                 strncpy(compound_key + key_field->offset, (char *)key, size);
>         } else
>                 memcpy(compound_key + key_field->offset, key, size);
> 
> As strncpy() is being used simply as a memcpy() for a string, and since
> strncpy() is deprecated, just call memcpy() for both memory and string
> keys.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_hist.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index c1ea6aaac182..4258324219ca 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -5224,10 +5224,8 @@ static inline void add_to_key(char *compound_key, void *key,
>  		/* ensure NULL-termination */
>  		if (size > key_field->size - 1)
>  			size = key_field->size - 1;
> -
> -		strncpy(compound_key + key_field->offset, (char *)key, size);
> -	} else
> -		memcpy(compound_key + key_field->offset, key, size);
> +	}
> +	memcpy(compound_key + key_field->offset, key, size);
>  }
>  
>  static void
> -- 
> 2.47.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
