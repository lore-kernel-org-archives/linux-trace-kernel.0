Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8EF2749DC;
	Fri, 18 Sep 2026 01:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789693965; cv=none; b=hHPec4Z4Jjt2o8RrdYFRT/N1uyAO3NmKLpnGjX9hXb1gegTP02/4WAyNrK3vD2tLpwHGOPc3xaeSWeKGw324GzswulGx/wfA/c4xVKR9om1P2Fs4pgXFsZPPWmVxLKeWs2j25ao3mfeZArwrNwwmW6Rheha6x0p1w+fVw7W1q9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789693965; c=relaxed/simple;
	bh=u6p9v/sQpbAvDgX6JM9uTM03Yy7+MS4LqF7SpSntSW8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=POhXJbIVHMM/PAdWEAjwiPxoUZI4oUXNB6z2GeLNtguIU/jjj3U3U0yaMnDQujvPQZm2ikfeKhH3S98NMKVH/mb2tjsJFPGb0X4h7HLo3BAFe8aVfwmgcdZXQD0vbxJ9ME+hdSzjz9QQZaoR8y3Q/4KOIrVzX+4fTRh1UIpNV/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWPITrmm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWPITrmm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535D71F000FF;
	Fri, 18 Sep 2026 01:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789693963;
	bh=F/YlIWDvAo1XjVKHwEMXxvDrzwtCtsm1MWgy0h+IsGo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mWPITrmmTzETtVKysrDIuRf9zsa3ilEIob2YbzSHsXyA7WH906ymUXY4sUCzEu2A5
	 ksKouLF+OPo9KYnwHzd8kYd+rENhyGNPAUa5f8w8gOr/eguiZaIZ4nEL6JTfpIl02T
	 fgwiZU7m6vsW8uvCvv4JXpfB3KV2otl1mo4mJJ/UpCha0Kb3QfGQgYFPEtMoaxUrT1
	 eDGqWnyiH8DtLZkPXefWXchabKZrJ38og3DRP84TUqGrR/OhII1O/eFk5P4N8Ed2xG
	 WzDMyAXwEXyLqglGox+HxULYf3WHHh5kIYqyKb/KMGbrVmI5rRBZiAHYLAQbsmWKLB
	 ySYWUwjZdaZlQ==
Date: Fri, 18 Sep 2026 10:12:38 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Kees Cook
 <kees+treewide@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] tracing/probes: Add const to new_argv allocation type
Message-Id: <20260918101238.62bc61f7a4c55bcc1ab83ab8@kernel.org>
In-Reply-To: <20260917211022.i.677-kees@kernel.org>
References: <20260917211022.i.677-kees@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 14:10:23 -0700
Kees Cook <kees@kernel.org> wrote:

> From: Kees Cook <kees+treewide@kernel.org>
> 
> In preparation for converting the kmalloc family of allocators to the
> type-aware kmalloc_obj family, we need to make sure that the returned
> type from the allocation matches the type of the variable being
> assigned. (The kmalloc family returns "void *", which can be implicitly
> cast to any pointer type.)
> 
> The assigned type is "const char **", but the converted allocation type
> would be "char **", which is the same type without the const qualifier.
> As there is no general way to safely add const qualifiers, take the size
> from the assignment target instead. No change in allocation size
> results.

This looks good to me. Let me pick it for-next.

Thanks!

> 
> Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
> kernel/trace/trace_probe.o
> 
> Assisted-by: LLM coccinelle
> Signed-off-by: Kees Cook <kees+treewide@kernel.org>
> ---
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: <linux-trace-kernel@vger.kernel.org>
> ---
>  kernel/trace/trace_probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 804442b2f7d2..cfb710095f65 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -2316,7 +2316,7 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
>  	else
>  		*new_argc = argc;
>  
> -	new_argv = kcalloc(*new_argc, sizeof(char *), GFP_KERNEL);
> +	new_argv = kcalloc(*new_argc, sizeof(*new_argv), GFP_KERNEL);
>  	if (!new_argv)
>  		return ERR_PTR(-ENOMEM);
>  
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
