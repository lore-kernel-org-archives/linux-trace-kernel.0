Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ABA175A91;
	Thu, 18 Jun 2026 23:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781826235; cv=none; b=bXCGBbwdHkWjl3KPSf5mR3zfl5aPQZxd8Mg1paC82zzoWSBium8WPYYngNmhW92zkrhjP2VMdTSOyKqzps2VdC1wSrNu6nkLs2VyCCPnT4X9iNK5MTrJYnE1ndHirurOKBpW6UWRjHkt8DV0PsuM+the9mv0Kln1eCxMdU4qSyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781826235; c=relaxed/simple;
	bh=U2hMAZ+ZZqOWr3/aVB0sPzMFxo/eyFRPYKvRD5e7HlY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BZj469cgW7GVrpwn+M9ks55AR0WvLMDDLqSEhbe8JUoDpqcc3iMKpzYiXknEZP28IjxqKDoE65T5VPzaH6i1jnxYyKapcDVCiiLHR7WPvE7mzSftFkBP+w3pzdBgoJE0KMdDFWEw4VMlr/E8gYFmyYUmZzewxE7yMKce/Fz+v7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJYLCsjq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJYLCsjq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBD21F00A3F;
	Thu, 18 Jun 2026 23:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781826234;
	bh=WwF4EyBiMz6+7PGUIBHpQhncWI58+N0AhQ3NTJFsdIM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TJYLCsjqnkPRuaDP3pZSXVr37F5iJHJSxAqlo4hX66ibKiSCR+hkVB4zc+4pIP2as
	 gxIJeBiu3qrEQ8+JEeDRMHdgz7XPgjDvWchLE4d7mhduIWTOMSMCqkz/Tzo6q450Kh
	 i5pgRHHMSZ7cEtnO4uN0RThSvVfz6Oayo1Tm34zhV3wTd+jtf1K5NjZJ9+3LVBlE3m
	 MwTEY/fq978tPzjzqG1BQe5O0Mz3qYEajZRsy8yIv38JFjpdvcUFOa5HuCe1cEfnwQ
	 SsYL2QDWk2qcrSU/yyjWvA+R7eqJwvn74Jsm26aPH+l/wJylvlYlGOKX7aoe9tbAWx
	 9CMQj3pe0jXvA==
Date: Fri, 19 Jun 2026 08:43:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] tracing: trace_fprobe: fix typo in function name
Message-Id: <20260619084351.5aa9ca3be9d0e9deb971f10a@kernel.org>
In-Reply-To: <20260507081041.885781-5-martin@kaiser.cx>
References: <20260507081041.885781-1-martin@kaiser.cx>
	<20260507081041.885781-5-martin@kaiser.cx>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 May 2026 10:09:09 +0200
Martin Kaiser <martin@kaiser.cx> wrote:

> The function name should be __register_tracepoint_fprobe.
> 

This looks good to me. Let me pick it.

Thanks,

> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  kernel/trace/trace_fprobe.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> index 9f5f08c0e7c2..4d1abbf66229 100644
> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> @@ -764,7 +764,7 @@ static int unregister_fprobe_event(struct trace_fprobe *tf)
>  	return trace_probe_unregister_event_call(&tf->tp);
>  }
>  
> -static int __regsiter_tracepoint_fprobe(struct trace_fprobe *tf)
> +static int __register_tracepoint_fprobe(struct trace_fprobe *tf)
>  {
>  	struct tracepoint_user *tuser __free(tuser_put) = NULL;
>  	struct module *mod __free(module_put) = NULL;
> @@ -836,7 +836,7 @@ static int __register_trace_fprobe(struct trace_fprobe *tf)
>  	tf->fp.flags &= ~FPROBE_FL_DISABLED;
>  
>  	if (trace_fprobe_is_tracepoint(tf))
> -		return __regsiter_tracepoint_fprobe(tf);
> +		return __register_tracepoint_fprobe(tf);
>  
>  	/* TODO: handle filter, nofilter or symbol list */
>  	return register_fprobe(&tf->fp, tf->symbol, NULL);
> -- 
> 2.43.7
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
