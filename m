Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D9E1CCB21;
	Thu, 27 Mar 2025 21:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743111533; cv=none; b=bx2atcJtG4n+Ajkb7+akTG57Hk6s3z1JF2vKjF60lEovS0nSu7jjjMlpB/docPOfgZIaTDqidjftsAIot1ycUxZgx9BKCGn4utvGKlrDfwMe34gj6oy1+tCFEL3NvMc0zl/2aOl+I7gQIto1pjgKuhACRxcRs3Kt9jBuR5i2CvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743111533; c=relaxed/simple;
	bh=KwwlIvn4CGJviwfKhK4vVhwZ4cEFfDMs09ARBlHVKB0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NkLqlY6I/86M1GMHmny5mThjmjS/XzGIZChWZu7IEV9TOblis4u0vNhdC3jEJotfFxp6u0TOpAXeUmHzHpC8EFHFT9b/jg9NxWn+L0qH1xllImRzmquzOnhbd5y1Z+er0UECDkjJLwsCnpqdcpNky+nVMV6nhlspyNVHFOC79Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0k6he5v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0k6he5v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C397C4CEDD;
	Thu, 27 Mar 2025 21:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743111532;
	bh=KwwlIvn4CGJviwfKhK4vVhwZ4cEFfDMs09ARBlHVKB0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J0k6he5vHB0B8ms50bsKPAIQ3nWtJPjZg9pRVh3d7TFMXwlbdgiVid95WGo1FQ9ZX
	 qtFEIWbqB55KyYwJcpRlL4h6vLa02BU0GC6ZJnP3RhZd29ybN1B7IChGs37+2Bc4L1
	 0HbNjtUMXVSWnTVEmRR593gJQOnDb1ZprTSlGF5u7Z+Jyb055yVUhXyZs+zV3x7oSr
	 dLsJ9uT+m3u1NYi7CE1y63OhtBcnUyJ7I82WpAlyC9uViMddPS8hbNdqgTVJfbKyQm
	 oyW1jlyKk6g2FHEPWuokO2kyQ5mLn1QrH0KyYFmp4k2EtDMJgwESBHe2dTGIISfwWk
	 CPSd08kMj4jKw==
Date: Fri, 28 Mar 2025 06:38:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Use _text and the kernel offset in
 last_boot_info
Message-Id: <20250328063848.8d4a71fbb8e2a969c46bb27d@kernel.org>
In-Reply-To: <20250326220304.38dbedcd@gandalf.local.home>
References: <20250326220304.38dbedcd@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Mar 2025 22:03:04 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Instead of using kaslr_offset() just record the location of "_text". This
> makes it possible for user space to use either the System.map or
> /proc/kallsyms as what to map all addresses to functions with.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,


> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 85128ef96246..3b8f5e3313e0 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -51,7 +51,7 @@
>  #include <linux/workqueue.h>
>  #include <linux/sort.h>
>  
> -#include <asm/setup.h> /* COMMAND_LINE_SIZE and kaslr_offset() */
> +#include <asm/setup.h> /* COMMAND_LINE_SIZE */
>  
>  #include "trace.h"
>  #include "trace_output.h"
> @@ -5995,7 +5995,7 @@ struct trace_mod_entry {
>  };
>  
>  struct trace_scratch {
> -	unsigned long		kaslr_addr;
> +	unsigned long		text_addr;
>  	unsigned long		nr_entries;
>  	struct trace_mod_entry	entries[];
>  };
> @@ -6137,11 +6137,7 @@ static void update_last_data(struct trace_array *tr)
>  	kfree_rcu(module_delta, rcu);
>  
>  	/* Set the persistent ring buffer meta data to this address */
> -#ifdef CONFIG_RANDOMIZE_BASE
> -	tscratch->kaslr_addr = kaslr_offset();
> -#else
> -	tscratch->kaslr_addr = 0;
> -#endif
> +	tscratch->text_addr = (unsigned long)_text;
>  }
>  
>  /**
> @@ -7000,7 +6996,7 @@ static void show_last_boot_header(struct seq_file *m, struct trace_array *tr)
>  	 * should not be the same as the current boot.
>  	 */
>  	if (tscratch && (tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
> -		seq_printf(m, "%lx\t[kernel]\n", tscratch->kaslr_addr);
> +		seq_printf(m, "%lx\t[kernel]\n", tscratch->text_addr);
>  	else
>  		seq_puts(m, "# Current\n");
>  }
> @@ -9465,10 +9461,8 @@ static void setup_trace_scratch(struct trace_array *tr,
>  	tr->scratch = tscratch;
>  	tr->scratch_size = size;
>  
> -#ifdef CONFIG_RANDOMIZE_BASE
> -	if (tscratch->kaslr_addr)
> -		tr->text_delta = kaslr_offset() - tscratch->kaslr_addr;
> -#endif
> +	if (tscratch->text_addr)
> +		tr->text_delta = (unsigned long)_text - tscratch->text_addr;
>  
>  	if (struct_size(tscratch, entries, tscratch->nr_entries) > size)
>  		goto reset;
> -- 
> 2.47.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
