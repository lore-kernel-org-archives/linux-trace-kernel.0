Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8BD341AD
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Nov 2023 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F7CC433C7;
	Mon, 27 Nov 2023 17:57:54 +0000 (UTC)
Date: Mon, 27 Nov 2023 12:58:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 zhengyejian1@huawei.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing: Disable events in reverse order of their
 enable operation
Message-ID: <20231127125815.4a4d06c6@gandalf.local.home>
In-Reply-To: <20231127151248.7232-3-petr.pavlu@suse.com>
References: <20231127151248.7232-1-petr.pavlu@suse.com>
	<20231127151248.7232-3-petr.pavlu@suse.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Nov 2023 16:12:48 +0100
Petr Pavlu <petr.pavlu@suse.com> wrote:

> Make the disable operation in __ftrace_event_enable_disable() use the
> reverse order of the respective enable operation.
> 
> This has two minor benefits:
> * Disabling of buffered events via trace_buffered_event_disable() is
>   done after unregistering the trace event. It closes a small window
>   where an event would be still registered and could be hit, but would
>   unnecessarily go directly to a ring buffer.

There's little benefit to the above. Going to the ring buffer and reverting
it is just a bit more expensive, but should not be an issue with this small
window.

> * The SOFT_DISABLED flag is now consistently set only when SOFT_MODE is
>   also set.

This code is a bit fragile, and I rather not change the logic. There's a
lot of corner cases.

I'm not saying that this is a bad change, I just don't want to add it and
find out later it broke one of the corner cases. To add this would require
an analysis that every input produces the same output with and without this
change.

If you want to make a table showing all inputs between soft_disable and the
flags, and show that the result produces the same updates, I'll then
reconsidered applying this.

Thanks!

-- Steve


> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  kernel/trace/trace_events.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index f29e815ca5b2..5f14d68a0ced 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -633,9 +633,6 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
>  			if (atomic_dec_return(&file->sm_ref) > 0)
>  				break;
>  			disable = file->flags & EVENT_FILE_FL_SOFT_DISABLED;
> -			clear_bit(EVENT_FILE_FL_SOFT_MODE_BIT, &file->flags);
> -			/* Disable use of trace_buffered_event */
> -			trace_buffered_event_disable();
>  		} else
>  			disable = !(file->flags & EVENT_FILE_FL_SOFT_MODE);
>  
> @@ -653,11 +650,17 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
>  
>  			call->class->reg(call, TRACE_REG_UNREGISTER, file);
>  		}
> -		/* If in SOFT_MODE, just set the SOFT_DISABLE_BIT, else clear it */
> -		if (file->flags & EVENT_FILE_FL_SOFT_MODE)
> -			set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags);
> -		else
> +
> +		if (soft_disable) {
> +			/* Complete going out of SOFT_MODE */
>  			clear_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags);
> +			clear_bit(EVENT_FILE_FL_SOFT_MODE_BIT, &file->flags);
> +			/* Disable use of trace_buffered_event */
> +			trace_buffered_event_disable();
> +		} else if (file->flags & EVENT_FILE_FL_SOFT_MODE) {
> +			/* If in SOFT_MODE, just set the SOFT_DISABLE_BIT */
> +			set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags);
> +		}
>  		break;
>  	case 1:
>  		/*

