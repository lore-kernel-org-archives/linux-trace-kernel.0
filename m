Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0927628E6
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 Dec 2023 16:35:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80B0C433C7;
	Tue, 12 Dec 2023 16:35:04 +0000 (UTC)
Date: Tue, 12 Dec 2023 11:35:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Zheng Yejian <zhengyejian1@huawei.com>
Cc: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <yeweihua4@huawei.com>
Subject: Re: [PATCH] tracing: Fix uaf issue when open the hist or hist_debug
 file
Message-ID: <20231212113546.6a51d359@gandalf.local.home>
In-Reply-To: <20231212113317.4159890-1-zhengyejian1@huawei.com>
References: <20231212113317.4159890-1-zhengyejian1@huawei.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 19:33:17 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 1abc07fba1b9..00447ea7dabd 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -5623,10 +5623,12 @@ static int event_hist_open(struct inode *inode, struct file *file)
>  {
>  	int ret;
>  
> -	ret = security_locked_down(LOCKDOWN_TRACEFS);
> +	ret = tracing_open_file_tr(inode, file);
>  	if (ret)
>  		return ret;
>  
> +	/* Clear private_data to avoid warning in single_open */
> +	file->private_data = NULL;
>  	return single_open(file, hist_show, file);
>  }
>  
> @@ -5634,7 +5636,7 @@ const struct file_operations event_hist_fops = {
>  	.open = event_hist_open,
>  	.read = seq_read,
>  	.llseek = seq_lseek,
> -	.release = single_release,
> +	.release = tracing_release_file_tr,

single_release() still needs to be called. This can't simply be replaced
with tracing_release_file_tr().

>  };
>  
>  #ifdef CONFIG_HIST_TRIGGERS_DEBUG
> @@ -5900,10 +5902,12 @@ static int event_hist_debug_open(struct inode *inode, struct file *file)
>  {
>  	int ret;
>  
> -	ret = security_locked_down(LOCKDOWN_TRACEFS);
> +	ret = tracing_open_file_tr(inode, file);
>  	if (ret)
>  		return ret;
>  
> +	/* Clear private_data to avoid warning in single_open */
> +	file->private_data = NULL;
>  	return single_open(file, hist_debug_show, file);
>  }
>  
> @@ -5911,7 +5915,7 @@ const struct file_operations event_hist_debug_fops = {
>  	.open = event_hist_debug_open,
>  	.read = seq_read,
>  	.llseek = seq_lseek,
> -	.release = single_release,
> +	.release = tracing_release_file_tr,

Same here. This just causes a leak of the single resources.

What needs to be done is to add a:

tracing_single_release_file_tr()

That does both:

int tracing_single_release_file_tr(struct inode *inode, struct file *filp)
{
	struct trace_event_file *file = inode->i_private;

	trace_array_put(file->tr);
	event_file_put(file);

	return single_release(inode, filp);
}

-- Steve

>  };
>  #endif
>  

