Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE87840C4
	for <linux-trace-kernel@vger.kernel.org>; Thu,  7 Dec 2023 22:27:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4245C433C8;
	Thu,  7 Dec 2023 22:27:21 +0000 (UTC)
Date: Thu, 7 Dec 2023 17:27:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ring-buffer: Add offset of events in dump on mismatch
Message-ID: <20231207172752.01ec634c@gandalf.local.home>
In-Reply-To: <866d40a8-4e0c-465c-ab8c-b5d864c1a668@efficios.com>
References: <20231207171613.0592087d@gandalf.local.home>
	<866d40a8-4e0c-465c-ab8c-b5d864c1a668@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Dec 2023 17:19:24 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2023-12-07 17:16, Steven Rostedt wrote:
> 
> [...]
> 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 8d2a4f00eca9..b10deb8a5647 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -3424,23 +3424,27 @@ static void dump_buffer_page(struct buffer_data_page *bpage,
> >   		case RINGBUF_TYPE_TIME_EXTEND:
> >   			delta = rb_event_time_stamp(event);
> >   			ts += delta;
> > -			pr_warn("  [%lld] delta:%lld TIME EXTEND\n", ts, delta);
> > +			pr_warn(" %x: [%lld] delta:%lld TIME EXTEND\n",  
> 
> Please prefix hex values with "0x", as in:
> 
> pr_warn(" 0x%x: [%lld] delta:%lld TIME EXTEND\n"
> 
> Otherwise it can be confusing.
> 

Heh, sure. I'm so use to looking at hex for the ring buffer offsets, that I
seldom add the 0x in my debug anymore. But as this is permanent, and not
just a one off print, I'll make the update and post a v2.

Thanks,

-- Steve

