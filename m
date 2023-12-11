Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DD84F205
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 Dec 2023 18:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E92C433C8;
	Mon, 11 Dec 2023 18:06:39 +0000 (UTC)
Date: Mon, 11 Dec 2023 13:07:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2] ring-buffer: Add offset of events in dump on
 mismatch
Message-ID: <20231211130719.771cb5ed@gandalf.local.home>
In-Reply-To: <20231211130614.43ff4462@gandalf.local.home>
References: <20231211130614.43ff4462@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 13:06:14 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

>  
>  		case RINGBUF_TYPE_DATA:
>  			ts += event->time_delta;
> -			pr_warn("  [%lld] delta:%d\n", ts, event->time_delta);
> +			pr_warn(" 0x%x:  [%lld] delta:%d\n",
> +				e, ts, event->time_delta);
>  			break;
>  
>  		default:
>  			break;
>  		}
>  	}
> +	pr_warn("expected end:%ld last event actually ended at:%d\n", tail, e);
>  }
>  

Bah, all offsets were in hex, the above was supposed to be in hex too. I
sent out the wrong version.

Will send a v3 with that update.

-- Steve
