Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3561855
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Nov 2023 02:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83546C433C8;
	Thu,  2 Nov 2023 02:32:59 +0000 (UTC)
Date: Wed, 1 Nov 2023 22:32:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Beau Belgrave <beaub@linux.microsoft.com>
Subject: Re: [PATCH] tracing: Have trace_event_file have ref counters
Message-ID: <20231101223254.7ec2a1e2@gandalf.local.home>
In-Reply-To: <20231102111433.5330cbb98cf204b4063924c0@kernel.org>
References: <20231031122453.7a48b923@gandalf.local.home>
	<20231102111433.5330cbb98cf204b4063924c0@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Nov 2023 11:14:33 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > 
> > What happens here is that the kprobe event creates a trace_event_file
> > "file" descriptor that represents the file in tracefs to the event. It
> > maintains state of the event (is it enabled for the given instance?).
> > Opening the "enable" file gets a reference to the event "file" descriptor
> > via the open file descriptor. When the kprobe event is deleted, the file is
> > also deleted from the tracefs system which also frees the event "file"
> > descriptor.  
> 
> Ouch! I thought the file descriptor has been hold by the opened process.

Well, the struct *filp is, but not the filp->private that points to the
struct trace_event_file *file.

> 
> > 
> > But as the tracefs file is still opened by user space, it will not be
> > totally removed until the final dput() is called on it. But this is not
> > true with the event "file" descriptor that is already freed. If the user
> > does a write to or simply closes the file descriptor it will reference the
> > event "file" descriptor that was just freed, causing a use-after-free bug.
> > 
> > To solve this, add a ref count to the event "file" descriptor as well as a
> > new flag called "FREED". The "file" will not be freed until the last
> > reference is released. But the FREE flag will be set when the event is
> > removed to prevent any more modifications to that event from happening,
> > even if there's still a reference to the event "file" descriptor.
> > 
> > Link: https://lore.kernel.org/linux-trace-kernel/20231031000031.1e705592@gandalf.local.home/
> >   
> 
> Looks good to me.
> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> BTW, can we add some tracefs selftests to ftracetest or independent test?

Yes, I was thinking about this, but that will have to wait till after this
gets in mainline. I'm already way behind schedule.

Thanks,

-- Steve
