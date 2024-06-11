Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C4E803;
	Tue, 11 Jun 2024 00:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718065085; cv=none; b=TdXBZkYPziEDQX9wpQOPP8zG/F/iD+bWlc7XFvOvRM9Ln980nGjiprV9UES6pyH01p9zF6kIa7g83RJTqGRlpZvqY7wv5X2H8pTz7hvh6Awnt9HyIOLHMfleheJ8ISyalXr6VAG0kW7liYq8y+IjoI4FJUEqT1WPgVsUtZXrZgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718065085; c=relaxed/simple;
	bh=GyghYEv0X82cGi7Oik5zQ6/zwcOSNDNjHdgQcuZoQpk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZI8MATrS3pSpw1YdxKNVjleZFA8pQD9bTm9ddlg2jn7J5lWFV3HpTeglpRXZMb6IE2aANv1h5hxBaWKWWZ/DlLBVpHyQv7cR1gFx7jbiEk+oHeIpTMXLpB5OfTThY5Y5aBS0Pib4Gkhx26hYa5o6SwbW3g4rdb+S1cAG8ly/Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F12C2BBFC;
	Tue, 11 Jun 2024 00:18:02 +0000 (UTC)
Date: Mon, 10 Jun 2024 20:18:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 2/3] tracing/kprobe: Remove unneeded WARN_ON_ONCE() in
 selftests
Message-ID: <20240610201813.319d6500@gandalf.local.home>
In-Reply-To: <171805480405.52471.13982671291270977479.stgit@devnote2>
References: <171805478534.52471.6269290579314514778.stgit@devnote2>
	<171805480405.52471.13982671291270977479.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 06:26:44 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since the kprobe-events selftest shows OK or NG with the reason, the
> WARN_ON_ONCE()s for each place are redundant. Let's remove it.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_kprobe.c |   26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 16383247bdbf..4abed36544d0 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -2023,18 +2023,18 @@ static __init int kprobe_trace_self_tests_init(void)
>  	pr_info("Testing kprobe tracing: ");
>  
>  	ret = create_or_delete_trace_kprobe("p:testprobe kprobe_trace_selftest_target $stack $stack0 +0($stack)");
> -	if (WARN_ON_ONCE(ret)) {
> +	if (ret) {
>  		pr_warn("error on probing function entry.\n");

Actually, you can consolidate this to:

	if (WARN_ONCE(ret, "error on probing function entry."))

>  		warn++;
>  	} else {
>  		/* Enable trace point */
>  		tk = find_trace_kprobe("testprobe", KPROBE_EVENT_SYSTEM);
> -		if (WARN_ON_ONCE(tk == NULL)) {
> +		if (tk == NULL) {
>  			pr_warn("error on getting new probe.\n");

And this to:

		if (WARN_ONCE(tk == NULL, "error on getting new probe."))

end so on.

-- Steve

>  			warn++;
>  		} else {
>  			file = find_trace_probe_file(tk, top_trace_array());
> -			if (WARN_ON_ONCE(file == NULL)) {
> +			if (file == NULL) {
>  				pr_warn("error on getting probe file.\n");
>  				warn++;
>  			} else
> @@ -2044,18 +2044,18 @@ static __init int kprobe_trace_self_tests_init(void)
>  	}
>  
>  	ret = create_or_delete_trace_kprobe("r:testprobe2 kprobe_trace_selftest_target $retval");
> -	if (WARN_ON_ONCE(ret)) {
> +	if (ret) {
>  		pr_warn("error on probing function return.\n");
>  		warn++;
>  	} else {
>  		/* Enable trace point */
>  		tk = find_trace_kprobe("testprobe2", KPROBE_EVENT_SYSTEM);
> -		if (WARN_ON_ONCE(tk == NULL)) {
> +		if (tk == NULL) {
>  			pr_warn("error on getting 2nd new probe.\n");
>  			warn++;
>  		} else {
>  			file = find_trace_probe_file(tk, top_trace_array());
> -			if (WARN_ON_ONCE(file == NULL)) {
> +			if (file == NULL) {
>  				pr_warn("error on getting probe file.\n");
>  				warn++;
>  			} else
> @@ -2079,7 +2079,7 @@ static __init int kprobe_trace_self_tests_init(void)
>  
>  	/* Disable trace points before removing it */
>  	tk = find_trace_kprobe("testprobe", KPROBE_EVENT_SYSTEM);
> -	if (WARN_ON_ONCE(tk == NULL)) {
> +	if (tk == NULL) {
>  		pr_warn("error on getting test probe.\n");
>  		warn++;
>  	} else {
> @@ -2089,7 +2089,7 @@ static __init int kprobe_trace_self_tests_init(void)
>  		}
>  
>  		file = find_trace_probe_file(tk, top_trace_array());
> -		if (WARN_ON_ONCE(file == NULL)) {
> +		if (file == NULL) {
>  			pr_warn("error on getting probe file.\n");
>  			warn++;
>  		} else
> @@ -2098,7 +2098,7 @@ static __init int kprobe_trace_self_tests_init(void)
>  	}
>  
>  	tk = find_trace_kprobe("testprobe2", KPROBE_EVENT_SYSTEM);
> -	if (WARN_ON_ONCE(tk == NULL)) {
> +	if (tk == NULL) {
>  		pr_warn("error on getting 2nd test probe.\n");
>  		warn++;
>  	} else {
> @@ -2108,7 +2108,7 @@ static __init int kprobe_trace_self_tests_init(void)
>  		}
>  
>  		file = find_trace_probe_file(tk, top_trace_array());
> -		if (WARN_ON_ONCE(file == NULL)) {
> +		if (file == NULL) {
>  			pr_warn("error on getting probe file.\n");
>  			warn++;
>  		} else
> @@ -2117,20 +2117,20 @@ static __init int kprobe_trace_self_tests_init(void)
>  	}
>  
>  	ret = create_or_delete_trace_kprobe("-:testprobe");
> -	if (WARN_ON_ONCE(ret)) {
> +	if (ret) {
>  		pr_warn("error on deleting a probe.\n");
>  		warn++;
>  	}
>  
>  	ret = create_or_delete_trace_kprobe("-:testprobe2");
> -	if (WARN_ON_ONCE(ret)) {
> +	if (ret) {
>  		pr_warn("error on deleting a probe.\n");
>  		warn++;
>  	}
>  
>  end:
>  	ret = dyn_events_release_all(&trace_kprobe_ops);
> -	if (WARN_ON_ONCE(ret)) {
> +	if (ret) {
>  		pr_warn("error on cleaning up probes.\n");
>  		warn++;
>  	}

