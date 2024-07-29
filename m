Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AA413C9A7;
	Mon, 29 Jul 2024 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722266817; cv=none; b=EbAl4pBz1fTFlRVDSoNT50lOYfsfCksoeF5ZbMZXutBMOlHnphJy10m8vyym1ReXL6ySYeDia5CAPIWoY+VNJbHw4W8UJEY5rFSfaYkqwnBUKTGobg2IR7ax+7qX866FdFCI7uXvOvqGgOJJPrsS3j5LDm5RWvFIhP57j/gcYKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722266817; c=relaxed/simple;
	bh=fWRF1RGdH0gOjkUP1BoWXNgHqu1iX8P9YeKjqBIpmaw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBQtqtK1KNoEde0uw6woRrmeZoPYs6foC5aQFl8l1FeH3ififYeyi/90f+e1v2O+vTcHEn59Nkej2NCgY9JLMzMPPOozSJNxs4VwmVhHaMO0qSUStDLa6gu/9yccP9yKsrDD6HMkMPW/Vl3WnQZjY28m1jlz6lyFpPqJ/ZYw8Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FABCC32786;
	Mon, 29 Jul 2024 15:26:56 +0000 (UTC)
Date: Mon, 29 Jul 2024 11:26:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: ftrace-uses: Change pt_regs to
 ftrace_regs
Message-ID: <20240729112653.7994aeac@rorschach.local.home>
In-Reply-To: <20240727-ftrace-docs-cb-args-v1-1-e37141235c8e@suse.com>
References: <20240727-ftrace-docs-cb-args-v1-1-e37141235c8e@suse.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jul 2024 19:45:54 -0300
Marcos Paulo de Souza <mpdesouza@suse.com> wrote:

> Since commit d19ad0775dcd ("ftrace: Have the callbacks receive a struct
> ftrace_regs instead of pt_regs") the callback function receives a
> ftrace_regs argument, and not a pt_regs anymore. Change the
> documentation to reflect the reality.
> 

Thanks, but this should probably add how to use ftrace_regs as well.

For example, if you need the pt_regs() you use ftrace_get_regs(fregs).
That is, if you have a callback:

  void callback_func(unsigned long ip, unsigned long parent_ip,
                      struct ftrace_ops *op, struct ftrace_regs *fregs)
  {
	struct pt_regs *regs = ftrace_regs(fregs);

then if the function was passed a full set of regs, then regs would be
the pt_regs, like usual. But if the function does not have it, then
regs would be NULL. So it is safe to do:

	if (!regs)
		return;

	// safely play with real regs

There should also be a mention of how if HAVE_DYNAMIC_FTRACE_WITH_ARGS
is set, you can then get to the arguments of the function (or at least
the words of the arguments) with ftrace_regs_get_argument(). Basically,
if we are updating this doc to reflect the changes for using
ftrace_regs, it should be fully changed, not partially.

-- Steve


> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  Documentation/trace/ftrace-uses.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/trace/ftrace-uses.rst b/Documentation/trace/ftrace-uses.rst
> index e198854ace79..05620714d99f 100644
> --- a/Documentation/trace/ftrace-uses.rst
> +++ b/Documentation/trace/ftrace-uses.rst
> @@ -87,7 +87,7 @@ The prototype of the callback function is as follows (as of v4.14):
>  .. code-block:: c
>  
>     void callback_func(unsigned long ip, unsigned long parent_ip,
> -                      struct ftrace_ops *op, struct pt_regs *regs);
> +                      struct ftrace_ops *op, struct ftrace_regs *regs);
>  
>  @ip
>  	 This is the instruction pointer of the function that is being traced.
> @@ -104,7 +104,7 @@ The prototype of the callback function is as follows (as of v4.14):
>  @regs
>  	If the FTRACE_OPS_FL_SAVE_REGS or FTRACE_OPS_FL_SAVE_REGS_IF_SUPPORTED
>  	flags are set in the ftrace_ops structure, then this will be pointing
> -	to the pt_regs structure like it would be if an breakpoint was placed
> +	to the ftrace_regs structure like it would be if an breakpoint was placed
>  	at the start of the function where ftrace was tracing. Otherwise it
>  	either contains garbage, or NULL.
>  
> @@ -169,10 +169,10 @@ Some of the flags are used for internal infrastructure of ftrace, but the
>  ones that users should be aware of are the following:
>  
>  FTRACE_OPS_FL_SAVE_REGS
> -	If the callback requires reading or modifying the pt_regs
> +	If the callback requires reading or modifying the ftrace_regs
>  	passed to the callback, then it must set this flag. Registering
>  	a ftrace_ops with this flag set on an architecture that does not
> -	support passing of pt_regs to the callback will fail.
> +	support passing of ftrace_regs to the callback will fail.
>  
>  FTRACE_OPS_FL_SAVE_REGS_IF_SUPPORTED
>  	Similar to SAVE_REGS but the registering of a
> @@ -199,7 +199,7 @@ FTRACE_OPS_FL_IPMODIFY
>  	Requires FTRACE_OPS_FL_SAVE_REGS set. If the callback is to "hijack"
>  	the traced function (have another function called instead of the
>  	traced function), it requires setting this flag. This is what live
> -	kernel patches uses. Without this flag the pt_regs->ip can not be
> +	kernel patches uses. Without this flag the ftrace_regs->ip can not be
>  	modified.
>  
>  	Note, only one ftrace_ops with FTRACE_OPS_FL_IPMODIFY set may be
> 
> ---
> base-commit: 256abd8e550ce977b728be79a74e1729438b4948
> change-id: 20240727-ftrace-docs-cb-args-963ef5676a81
> 
> Best regards,

