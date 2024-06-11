Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD1317D894;
	Tue, 11 Jun 2024 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718115886; cv=none; b=AGOF0MD+GiJ2XDtp6VOUvRk4jwVcrDkdsMKolS3/fEjcH4vwRlC+/0kUo8wXMRLufquri/aUZhY/hKtRTypoMW5nNTxBln7Ey6Ijmj6+QPbpVFbOjQPg1zOA1JvGpMQCkBwuNKQsoTtg6yw3AU71pe5xe6YoW/YKeG1MUMkLlKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718115886; c=relaxed/simple;
	bh=1CKuk9B0FuPJf1djCoC4PuFEIJtP/VlYB88UvPspDbU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E3OiIV6DQJ789LVbyYldL4HsCC2gFKGFtAxs2eU0BNSbvI8aZxUtTCAzdEpKP39BFClrzhXU8Hhpr1t+mwhdi5D6lnP+rdGsPQIKjioZPpSl9QoJmaNz+dzMt28ygq8tFaRN3h1EKsFa83Cq/m7Ck4DXob4vCCqjo0TyiLs6lRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7AAC2BD10;
	Tue, 11 Jun 2024 14:24:45 +0000 (UTC)
Date: Tue, 11 Jun 2024 10:25:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v3 3/3] tracing/kprobe: Remove cleanup code unrelated to
 selftest
Message-ID: <20240611102500.27493dd2@gandalf.local.home>
In-Reply-To: <171811265627.85078.16897867213512435822.stgit@devnote2>
References: <171811262833.85078.12421348187962271050.stgit@devnote2>
	<171811265627.85078.16897867213512435822.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 22:30:56 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> This cleanup all kprobe events code is not related to the selftest
> itself, and it can fail by the reason unrelated to this test.
> If the test is successful, the generated events are cleaned up.
> And if not, we cannot guarantee that the kprobe events will work
> correctly. So, anyway, there is no need to clean it up.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  kernel/trace/trace_kprobe.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 8c5816c04bd2..7fd0f8576e4c 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -2114,10 +2114,6 @@ static __init int kprobe_trace_self_tests_init(void)
>  
>  
>  end:
> -	ret = dyn_events_release_all(&trace_kprobe_ops);
> -	if (WARN_ONCE(ret, "error on cleaning up probes."))
> -		warn++;
> -
>  	/*
>  	 * Wait for the optimizer work to finish. Otherwise it might fiddle
>  	 * with probes in already freed __init text.

