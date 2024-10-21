Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219591FA245;
	Mon, 21 Oct 2024 14:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729522739; cv=none; b=lN8VJ3gNkCiXlq1Oacu6+3LM4w8jF51f7Tetiwq5WZ4EQE8mHDglxGo/7uO4+k5Zo3kUhOHmehEkT+n6VBWuqNDqjJymBC0doXT3DDakkYN9E0IxiPSUnL0U4jgXiHQ5sDYiotDoYDwYbcIi+bfnpMnPqNztXpxBGWQDPMhLYyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729522739; c=relaxed/simple;
	bh=YZVFt6Fiq3Uw/uK9i5TolLo/2N8dCMVm8nklxxHdVSk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=P7DZplQtjzCZIq7jgTAHMQDE/7Bf32mBiKAe9e8Vp3NOwHmmSNQA2AuojRTthGKg/cwXxKyfQVnC1bZivxbiLEEDfrqk6jObcl5vM0sNpYze7C8FXfDHW2c8VmvrDU/PAfrY0qMsFcYgcu7PjmlK2dq66ekDr4sQXoxGMvKKY3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUcsqbhj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUcsqbhj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60A4C4CECD;
	Mon, 21 Oct 2024 14:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729522738;
	bh=YZVFt6Fiq3Uw/uK9i5TolLo/2N8dCMVm8nklxxHdVSk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rUcsqbhjNMYRkQhi9IaLVRmqeZBOtm8RBVcgBKhELkrrMB8bJGsA2bYDCGkxgITty
	 lp9o/8LZo7BG0RXZXYJLgh+muhFAKxeibcxuqVfG3JcLRP/vaTOWnsQD+6eCou7iQ4
	 KIo7pX0L1vjulzn7Vd0srSt4T+Jt+FPkRFzFtm980iT6lPkpoXhoRj+EVrPMshfElv
	 cqBEB2nZ0D59Aw8BTfrtITTkfDSQUR42eICVwBkvvij5rTEGo46xrLnx3zk9dblBQH
	 0eXvnb7LQnG5K19XINvYXmY3NvGv8IPCy3Zv4DBS22PACtfbeBRNLHSozp4PHU+z9V
	 dehnd5OvjlMDg==
Date: Mon, 21 Oct 2024 23:58:54 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Ryan Roberts
 <ryan.roberts@arm.com>
Subject: Re: [PATCH] fgraph: Separate size of ret_stack from PAGE_SIZE
Message-Id: <20241021235854.8d287463ee68d4c4c2846b29@kernel.org>
In-Reply-To: <20241019152951.053f9646@rorschach.local.home>
References: <20241019152951.053f9646@rorschach.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Oct 2024 15:29:51 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The ret_stack (shadow stack used by function graph infrastructure) is
> currently defined as PAGE_SIZE. But some architectures which have 64K
> PAGE_SIZE, this is way overkill. Also there's an effort to allow the
> PAGE_SIZE to be defined at boot up.
> 
> Hard code it for now to 4096. In the future, this size may change and even
> be dependent on specific architectures.
> 
> Link: https://lore.kernel.org/all/e5067bb8-0fcd-4739-9bca-0e872037d5a1@arm.com/
>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!
 
> Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/fgraph.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index ee829d65f301..51e81b299a0d 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -153,7 +153,7 @@ enum {
>   * SHADOW_STACK_OFFSET:	The size in long words of the shadow stack
>   * SHADOW_STACK_MAX_OFFSET: The max offset of the stack for a new frame to be added
>   */
> -#define SHADOW_STACK_SIZE	(PAGE_SIZE)
> +#define SHADOW_STACK_SIZE	(4096)
>  #define SHADOW_STACK_OFFSET	(SHADOW_STACK_SIZE / sizeof(long))
>  /* Leave on a buffer at the end */
>  #define SHADOW_STACK_MAX_OFFSET				\
> -- 
> 2.45.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
