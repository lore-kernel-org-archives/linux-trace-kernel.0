Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A495745F4;
	Mon, 10 Jun 2024 22:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718057879; cv=none; b=umvBEozLAFY2ZqAccIpi0/zT6uIIuKJ7zKk0i7D+3j3NJi4GVYfNvTbFB20GdQZ33Uvh7obdOf+6f6R1VUZf4Gq/cs5edHUaNwwrMNSKp8xwlZohBNEBXygNDzSyR+f9acONir5HjnfVJadr+/84zACNje6DMbcUE6bQFDrjc/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718057879; c=relaxed/simple;
	bh=xAm0zC+c8eBB0futdEsmXsTImAyWWr6d67t/vHVqASo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=COcHRo8X7BFQnB7v8RWifbgQZcx5TgomJGdcJmlQh5gLpYbQARFIRA/pQZ/ufGfx3NLBUmIcI4uMoiZ4bNxS2kJAuGsvpe1URNVufv3BrSPJLs52NDdPqxKtmj31vG1f+9G0nBshXrZCDWLRoPHmZZm2I3g4m1xk6YR8kugGMqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C570DC2BBFC;
	Mon, 10 Jun 2024 22:17:57 +0000 (UTC)
Date: Mon, 10 Jun 2024 18:18:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next 2/2] ftrace: Add kernel-doc comments for
 unregister_ftrace_direct() function
Message-ID: <20240610181808.50e86e8c@gandalf.local.home>
In-Reply-To: <20240607084957.64715-2-yang.lee@linux.alibaba.com>
References: <20240607084957.64715-1-yang.lee@linux.alibaba.com>
	<20240607084957.64715-2-yang.lee@linux.alibaba.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Jun 2024 16:49:57 +0800
Yang Li <yang.lee@linux.alibaba.com> wrote:

> Added kernel-doc comments for the unregister_ftrace_direct() function to
> improve code documentation and readability.
> 

Someone else beat you to this.

-- Steve

> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9300
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  kernel/trace/ftrace.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 4aeb1183ea9f..3b0dbd55cc05 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5988,6 +5988,8 @@ EXPORT_SYMBOL_GPL(register_ftrace_direct);
>   * unregister_ftrace_direct - Remove calls to custom trampoline
>   * previously registered by register_ftrace_direct for @ops object.
>   * @ops: The address of the struct ftrace_ops object
> + * @addr: The address of the direct call to remove
> + * @free_filters: Boolean indicating whether to free the filters
>   *
>   * This is used to remove a direct calls to @addr from the nop locations
>   * of the functions registered in @ops (with by ftrace_set_filter_ip

