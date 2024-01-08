Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C6E5644F;
	Mon,  8 Jan 2024 21:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="map9tqWE"
Received: from CPC-beaub-VBQ1L. (unknown [4.155.48.124])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1BC1520B3CC1;
	Mon,  8 Jan 2024 13:47:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1BC1520B3CC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1704750469;
	bh=Kj6+QzNwkDHsrznrwFSPMTSSLEkn1Iq05bk+KRJ9TOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=map9tqWEDTTjoa0HZzvLuz4qkRBHCRe3n9aLhLjYzBq8h0VwLliAMDttvbw+zepAS
	 lzKtfqZaJs2b4QCG8POdEQrOGpzpFzFJD5NPmjVf2rjzUBUyw+KRn1S92sciVKa8dm
	 b7Nvih4/KTxewJUzEfjie+h4a8gH5u5CgF5l9SpE=
Date: Mon, 8 Jan 2024 21:47:44 +0000
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing user_events: Simplify user_event_parse_field()
 parsing
Message-ID: <20240108214744.GA100-beaub@linux.microsoft.com>
References: <20240108133723.031cf322@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108133723.031cf322@gandalf.local.home>

On Mon, Jan 08, 2024 at 01:37:23PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Instead of having a bunch of if statements with:
> 
>        len = str_has_prefix(field, "__data_loc unsigned ");
>        if (len)
>                goto skip_next;
> 
>        len = str_has_prefix(field, "__data_loc ");
>        if (len)
>                goto skip_next;
> 
>        len = str_has_prefix(field, "__rel_loc unsigned ");
>        if (len)
>                goto skip_next;
> 
>        len = str_has_prefix(field, "__rel_loc ");
>        if (len)
>                goto skip_next;
> 
> 	goto parse;
> 
>  skip_next:
> 
> Consolidate it into a negative check and jump to parse if all the
> str_has_prefix() calls fail. If one succeeds, it will just continue with
> len equal to the proper string:
> 
>        if (!(len = str_has_prefix(field, "__data_loc unsigned ")) &&
>            !(len = str_has_prefix(field, "__data_loc ")) &&
>            !(len = str_has_prefix(field, "__rel_loc unsigned ")) &&
>            !(len = str_has_prefix(field, "__rel_loc "))) {
>                goto parse;
>        }
> 
>  skip_next:
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_user.c | 22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 9365ce407426..ce0c5f1ded48 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -1175,23 +1175,13 @@ static int user_event_parse_field(char *field, struct user_event *user,
>  		goto skip_next;
>  	}
>  
> -	len = str_has_prefix(field, "__data_loc unsigned ");
> -	if (len)
> -		goto skip_next;
> -
> -	len = str_has_prefix(field, "__data_loc ");
> -	if (len)
> -		goto skip_next;
> -
> -	len = str_has_prefix(field, "__rel_loc unsigned ");
> -	if (len)
> -		goto skip_next;
> -
> -	len = str_has_prefix(field, "__rel_loc ");
> -	if (len)
> -		goto skip_next;
> +	if (!(len = str_has_prefix(field, "__data_loc unsigned ")) &&
> +	    !(len = str_has_prefix(field, "__data_loc ")) &&
> +	    !(len = str_has_prefix(field, "__rel_loc unsigned ")) &&
> +	    !(len = str_has_prefix(field, "__rel_loc "))) {
> +		goto parse;
> +	}

This now triggers a checkpatch error:
ERROR: do not use assignment in if condition
#1184: FILE: kernel/trace/trace_events_user.c:1184:
+       if (!(len = str_has_prefix(field, "__data_loc unsigned ")) &&

I personally prefer to keep these files fully checkpatch clean.
However, I did test these changes under the self-tests and it passed.

Do they bug you that much? :)

Thanks,
-Beau

>  
> -	goto parse;
>  skip_next:
>  	type = field;
>  	field = strpbrk(field + len, " ");
> -- 
> 2.43.0
