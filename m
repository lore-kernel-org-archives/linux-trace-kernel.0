Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECD93515C3;
	Wed,  2 Sep 2026 01:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788312992; cv=none; b=GLq8LdvoJKSY5cb80nPmlxFwRw1mU2od6FV0Z7Tb8nXBipHQlTmG9PolsXNe3sTzWKTynPiXy/RhWK0bzFLNg+sX1QEf4ljcZqlZE8AcFtgMQKQlpCeR2JWb8tY0jrUGBVqYKTpkrLoxSigk0BZ1kgXH3NJjCKEVrsMiQxrrEdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788312992; c=relaxed/simple;
	bh=MVEG7XRRMYDaG6aOgvQKWoJgI85kW5rvMKXNTYu1g04=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Z8+gu8gH1wMzQ5fRU2YXDsrfknbDK1wTPjPG/Stj6hNHBaP2doSWWmuZs7BkRMavT1LQZB80D+9iTP+ERzzVxstqFJXu5jlCsd0VDsoskOz1RRZkknJN0jGljX37G8mkacyizm4ft4WGtKjcmIFQMALfz9qNt5VrNMCxsa//fNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gytBBDZv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gytBBDZv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8831F000E9;
	Wed,  2 Sep 2026 01:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788312987;
	bh=V2A9DcvibJ4LYtEdrEaVp71tySeCc+8smZNz9SIgM3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gytBBDZvD6sSH2gYkgWVZj+XNwnojGUJkl38ItKR04V8KtnO2nnyftogkrkcEYBDD
	 tslCyoeBoltNuJ5jj2Bwmb0MCaCAWsUuaMVo4K+OTT/6CXVnqjyaruWO5aaQ3GgjHV
	 IaApnfrZ2lsrIuwI8n+yuu59hzln2Si+2wfllS9oGN8zotRy2Pn24iMmpOXoWJg2nc
	 l5n1WzwxBqvp7W/tENn3/ycfKwulL2q6iMTKvyaenl0zxe44gniY/npJzxXRAfnIkN
	 ygGoaGZRPj6gcjiAPQH3E0kQ5p+/l+zPhMwRNMLlwzNqMt/oxb5d1r8m54882ITalK
	 EgRJQjwLfCI4Q==
Date: Wed, 2 Sep 2026 10:36:23 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ella Ma <alansnape3058@gmail.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 julia.lawall@inria.fr
Subject: Re: [PATCH RESEND] tracing: uprobes: Fix incorrect __free function
 that frees an error value in __trace_uprobe_create()
Message-Id: <20260902103623.9c757ec76374c20d7d59fcd4@kernel.org>
In-Reply-To: <20260817083014.999612-1-alansnape3058@gmail.com>
References: <20260817083014.999612-1-alansnape3058@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 10:30:14 +0200
Ella Ma <alansnape3058@gmail.com> wrote:

> Before applying the __free annotation, the original version goes to
> label `fail_address_parse`, and does not call function
> `free_trace_uprobe` on pointer `tu`. However, after the change, the
> function will be called whenever the function returns. This makes the
> error value returned by `alloc_trace_uprobe` get freed.
> 
> This patch fixes this issue by adding the check for error value in the
> __free function definition.
> 
> Found by Clang Static Analyzer (my own development fork
> https://github.com/Snape3058/llvm-patch-revision/tree/cleanup).
> 
> 	warning: Argument to 'kfree()' is a constant address
> 	(18446744073709551604), which is not memory allocated by
> 	'malloc()' [unix.Malloc]
> 

Ah, thanks for the patch. Actually Andi sent the similar fix.

https://lore.kernel.org/all/20260831150651.1134594-2-ak@kernel.org/

which is more optimized one (remove redundant NULL check and
allow passing ERRPTR to free_trace_uprobe().)

Thanks,

> Fixes: 8b658df20658 ("tracing: uprobes: Cleanup __trace_uprobe_create() with __free()")
> Signed-off-by: Ella Ma <alansnape3058@gmail.com>
> ---
>  kernel/trace/trace_uprobe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index c274346853d1..ccbdc96e5578 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -533,7 +533,7 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
>  	return ret;
>  }
>  
> -DEFINE_FREE(free_trace_uprobe, struct trace_uprobe *, if (_T) free_trace_uprobe(_T))
> +DEFINE_FREE(free_trace_uprobe, struct trace_uprobe *, if (!IS_ERR_OR_NULL(_T)) free_trace_uprobe(_T))
>  
>  /*
>   * Argument syntax:
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
