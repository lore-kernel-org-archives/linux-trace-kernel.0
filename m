Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70781D5175;
	Wed, 19 Feb 2025 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981090; cv=none; b=NKddf4gM4w3bwZRn4ldTXN0h6a63PCUbGDBqbL5Gt0QiSdzmb18nBFYwhWwidbcUYWXE0mP5SsFISW3BtNEEu4DXcQFN8gMb0MOc2Y0DZl0fhgH0TrdALNojNl/bKH6rFS4GSDKRL0TELBVFBoXz0BB9KJsfu5kviKVYpKVzIJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981090; c=relaxed/simple;
	bh=B6tNR6GbD+61MJSAH/O6MezZ2nxTCMTeXiF4BtSmYPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbDpdCiyY28QIW0Pbz0j2xtXGGAphFrSehZW2OWeF+A7C1UNMaleyeot+EyAH9watRWZNFXwApqZdaucN3KlURdSmMOBV/GYb6lQuxek/Enw+F3ITz+lvjTzUoS1663x1bB0k0BxP8vKOc3X/Nahpj/kq5d5m/4EVhDmvfurFFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5042AC4CED1;
	Wed, 19 Feb 2025 16:04:49 +0000 (UTC)
Date: Wed, 19 Feb 2025 11:05:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Adrian Huang <ahuang12@lenovo.com>
Subject: Re: [PATCH 1/1] tracing: Fix memory leak when reading set_event
 file
Message-ID: <20250219110513.12411861@gandalf.local.home>
In-Reply-To: <20250219104230.12000-1-ahuang12@lenovo.com>
References: <20250219104230.12000-1-ahuang12@lenovo.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 18:42:30 +0800
Adrian Huang <adrianhuang0701@gmail.com> wrote:


> The root cause is that s_next() returns NULL when nothing is found.
> This results in s_stop() attempting to free a NULL pointer because its
> parameter p is NULL.
> 
> Fix the issue by freeing the memory appropriately when s_next() fails
> to find anything.
> 
> Fixes: b355247df104 ("tracing: Cache ":mod:" events for modules not loaded yet")
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
> ---
>  kernel/trace/trace_events.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 4cb275316e51..c76353ad0a4e 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -1591,6 +1591,7 @@ s_next(struct seq_file *m, void *v, loff_t *pos)
>  		return iter;
>  #endif
>  
> +	kfree(iter);
>  	return NULL;
>  }
>  

This most definitely needs a comment, as it will look like a bug otherwise.
Please add:

	/*
	 * The iter is allocated in s_start() and passed via the 'v'
	 * parameter. To stop the iterator, NULL must be returned. But
	 * the return value is what the 'v' parameter in s_stop() receives
	 * and frees. Free iter here as it will no longer be used.
	 */
	kfree(iter);

I would also change the variable 'p' in s_stop() to 'v' to be consistent.

Thanks,

-- Steve
