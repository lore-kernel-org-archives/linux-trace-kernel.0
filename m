Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6E4EAF6;
	Thu,  6 Jun 2024 02:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717639783; cv=none; b=c8oiD95XaCY90c9Nwf+OquDRoiorQQyXtzX1mPyeXtEGJvCG6KJO+7JLV5tcdy/0Rbj/LzBGrZidLjj4nGMm23VKsOF2MKl4uJ5+n9wtt55NPq9KML9SHa35+nYFg9wKuo0U6JO0Fq4Zib5+NkTRzfkx6rgRnNqgVtOCthnnfhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717639783; c=relaxed/simple;
	bh=kvFKwEjwsMglvH5LYuLMbranGAg4QoEU0KohPNvi1ts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SI+tEodqc3XSNdiaAlCwZK/fJrYPvyTYG2WGczthHBPKcNrL0kFj7kSEaE0/0BABtcC92WJFH0DzTcEdVdpULeZyMKV9wgNMoaAkGF7OPBZ1fE84ZjiD8zGMHsvolSlHGD1WjAXMjYn2K02LSn7kESqO2SM6EYpgPccQkMDmRec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42523C2BD11;
	Thu,  6 Jun 2024 02:09:42 +0000 (UTC)
Date: Wed, 5 Jun 2024 22:09:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: MarileneGarcia <marilene.agarcia@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: adding the missing parameter descriptions of
 unregister_ftrace_direct
Message-ID: <20240605220945.63178ce1@gandalf.local.home>
In-Reply-To: <20240528005046.3778431-1-marilene.agarcia@gmail.com>
References: <20240528005046.3778431-1-marilene.agarcia@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 May 2024 21:50:46 -0300
MarileneGarcia <marilene.agarcia@gmail.com> wrote:

The subject for the tracing subsystem should start with a capital letter,
but it is a bit confusing anyway. Should be:

   ftrace: Add missing kerneldoc parameters to unregister_ftrace_direct()


> Adding the description of the parameters addr and free_filters
> of the function unregister_ftrace_direct.

s/Adding/Add/  s/of the/to the/

> 
> Signed-off-by: MarileneGarcia <marilene.agarcia@gmail.com>
> ---
> Hello, 
> These changes fix the following compiler warnings of the function
> unregister_ftrace_direct.
> 
> The warnings happen using GCC compiler, enabling the ftrace related 
> configs and using the command 'make W=1'.
> 
> kernel/trace/ftrace.c:5489: warning: Function parameter or struct member
> 'addr' not described in 'unregister_ftrace_direct'
> 
> kernel/trace/ftrace.c:5489: warning: Function parameter or struct member 
> 'free_filters' not described in 'unregister_ftrace_direct'
> 
>  kernel/trace/ftrace.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 65208d3b5ed9..6062e4ce1957 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5475,6 +5475,8 @@ EXPORT_SYMBOL_GPL(register_ftrace_direct);
>   * unregister_ftrace_direct - Remove calls to custom trampoline
>   * previously registered by register_ftrace_direct for @ops object.
>   * @ops: The address of the struct ftrace_ops object
> + * @addr: The address of the trampoline to call at @ops functions

This is the unregister function. The above sounds like it will be called
instead of no longer being called.

 @addr: The address of the direct function that are called by the @ops functions

> + * @free_filters: non zero to remove all filters for the ftrace_ops

It's a boolean value, there is no zero.

>   *
>   * This is used to remove a direct calls to @addr from the nop locations
>   * of the functions registered in @ops (with by ftrace_set_filter_ip


-- Steve
