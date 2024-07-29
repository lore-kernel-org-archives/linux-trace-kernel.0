Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CC81534EC;
	Mon, 29 Jul 2024 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722264569; cv=none; b=C/uk+6skNvHXcfJ/PUhcUaliiZM50I4QOTNeXG0j5alie3DyQnZM3ZN5vJ1T5SaNV3RxB/F6rIsEfqwqwxOVxnJNH2SXmB+sX1PHoIoTlegoAMlD3KUQY536zxh6U9/W87QceGYTp1XZyBi3rfqIBRTFt33lwbs7JXrLjYoaPRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722264569; c=relaxed/simple;
	bh=o9d+uKlTPe2mDv83pCJEl1+vFwvuCqNcuo1JM8/jn60=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=r0tbbCxlHugv9UXs+//2zo8llLE+toEx+6kdbSZktS0LJSFfTLp58OBot0UlXpsl2v5ZAoQyEkpC7AEVcmbXu9UDJfR/ydfTowQ8fQZTdwjvnkCoHHc60SyD/awQqEBP/RIiHtJMwuwz+5mAahmDqYlDcy9WrbYHTk+UuUMmqm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hajshv5z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hajshv5z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D21C32786;
	Mon, 29 Jul 2024 14:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722264568;
	bh=o9d+uKlTPe2mDv83pCJEl1+vFwvuCqNcuo1JM8/jn60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hajshv5zY4N7pSkiuJIXOSJTFrEIgJSnCCwtiDYTK2fgY5FWXbqu1svgCDZs63+rB
	 YoRXpN7tXqsWNKuChT5X1jWd4KnBtScjh797QoNDbk5+LimfLmpOpRf6OczOzSO4IN
	 aNsrjQxs8huVA4lWOqKvqIpWkFB8vpfRavsmiKz9dvgqY88Nop1j4C2lDuNgo0ZpJM
	 OhsLQz0stPAXTF+jB/zq/YEYCWKK8Pe/QJJOB/LfWdhEm+Pc0ehKYz6OsBPIRgVoy3
	 xP+NEyOXzCHeE3bZvha9O8vREDpPijLjefnpApSa+g/YCJwl/Mpj72dronKCQDuoyg
	 26IYn5bXgLg0Q==
Date: Mon, 29 Jul 2024 23:49:24 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Use refcount for trace_event_file reference
 counter
Message-Id: <20240729234924.6accc2e6216e3b7be1a97e61@kernel.org>
In-Reply-To: <20240726144208.687cce24@rorschach.local.home>
References: <20240726144208.687cce24@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jul 2024 14:42:08 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Instead of using an atomic counter for the trace_event_file reference
> counter, use the refcount interface. It has various checks to make sure
> the reference counting is correct, and will warn if it detects an error
> (like refcount_inc() on '0').
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Looks good to me.

Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
>  include/linux/trace_events.h | 2 +-
>  kernel/trace/trace_events.c  | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 9df3e2973626..fed58e54f15e 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -680,7 +680,7 @@ struct trace_event_file {
>  	 * caching and such. Which is mostly OK ;-)
>  	 */
>  	unsigned long		flags;
> -	atomic_t		ref;	/* ref count for opened files */
> +	refcount_t		ref;	/* ref count for opened files */
>  	atomic_t		sm_ref;	/* soft-mode reference counter */
>  	atomic_t		tm_ref;	/* trigger-mode reference counter */
>  };
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 852643d957de..81ade9ddcbe5 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -992,18 +992,18 @@ static void remove_subsystem(struct trace_subsystem_dir *dir)
>  
>  void event_file_get(struct trace_event_file *file)
>  {
> -	atomic_inc(&file->ref);
> +	refcount_inc(&file->ref);
>  }
>  
>  void event_file_put(struct trace_event_file *file)
>  {
> -	if (WARN_ON_ONCE(!atomic_read(&file->ref))) {
> +	if (WARN_ON_ONCE(!refcount_read(&file->ref))) {
>  		if (file->flags & EVENT_FILE_FL_FREED)
>  			kmem_cache_free(file_cachep, file);
>  		return;
>  	}
>  
> -	if (atomic_dec_and_test(&file->ref)) {
> +	if (refcount_dec_and_test(&file->ref)) {
>  		/* Count should only go to zero when it is freed */
>  		if (WARN_ON_ONCE(!(file->flags & EVENT_FILE_FL_FREED)))
>  			return;
> @@ -2999,7 +2999,7 @@ trace_create_new_event(struct trace_event_call *call,
>  	atomic_set(&file->tm_ref, 0);
>  	INIT_LIST_HEAD(&file->triggers);
>  	list_add(&file->list, &tr->events);
> -	event_file_get(file);
> +	refcount_set(&file->ref, 1);
>  
>  	return file;
>  }
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
