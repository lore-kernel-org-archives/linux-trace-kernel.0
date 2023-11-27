Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FE83E490
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Nov 2023 22:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B4FC433C7;
	Mon, 27 Nov 2023 22:50:00 +0000 (UTC)
Date: Mon, 27 Nov 2023 17:50:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 dmaluka@google.com, Sean Paul <seanpaul@chromium.org>, Arun Easi
 <aeasi@marvell.com>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [RFC][PATCH] tracing: Allow creating instances with specified
 system events
Message-ID: <20231127175021.0c0edc53@gandalf.local.home>
In-Reply-To: <20231127174108.3c331c9c@gandalf.local.home>
References: <20231127174108.3c331c9c@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Nov 2023 17:41:08 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> A trace instance may only need to enable specific events. As the eventfs
> directory of an instance currently creates all events which adds overhead,
> allow internal instances to be created with just the events in systems
> that they care about. This currently only deals with systems and not
> individual events, but this should bring down the overhead of creating
> instances for specific use cases quite bit.

This change log is not very good. I didn't actually state what was done :-p

Anyway, function trace_array_get_by_name() has an added parameter "systems"
(and I forgot to update its kerneldoc). This parameter is a string of
comma, or space, or commas and spaces deliminators of event system names.
If it's not NULL, then it will only create the event system directories of
those event systems that match the systems parameter.

That is:

 trace_array_get_by_name("qla2xxx", "qla");

Will create an instance called "qla2xxx" and only have "qla" system events
in it.

Note, trace_array_printk() will still write into this instance, and it can
be read via trace-cmd with no problems.

-- Steve


> 
> The qla2xxx instance could just enable the systems it cares about, but that
> should be a separate patch.
> 
> Note that kprobes and synthetic events created after the creation of these
> instances, will be added to these instances, but those that are created
> before the creation of the instance will not be included.
> 
> Note, this may also be useful for creating instances in the eventfs, but
> I'm not sure how to do this there. I could add a deliminator:
> 
>   mkdir /sys/kernel/tracing/instances/foo::sched,timer
> 
> But if a tool already uses "::" as a deliminator, then this will break it.
> I could just have it work if all the events after the deliminator exist.
> 
>   Thoughts?
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  drivers/scsi/qla2xxx/qla_os.c       |  2 +-
>  include/linux/trace.h               |  4 ++--
>  kernel/trace/trace.c                | 22 ++++++++++++--------
>  kernel/trace/trace.h                |  3 ++-
>  kernel/trace/trace_boot.c           |  2 +-
>  kernel/trace/trace_events.c         | 31 ++++++++++++++++++++++++++---
>  samples/ftrace/sample-trace-array.c |  2 +-
>  7 files changed, 49 insertions(+), 17 deletions(-)
