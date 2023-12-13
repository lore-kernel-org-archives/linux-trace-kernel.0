Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAA2396
	for <linux-trace-kernel@vger.kernel.org>; Wed, 13 Dec 2023 00:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C59C433C7;
	Wed, 13 Dec 2023 00:25:54 +0000 (UTC)
Date: Tue, 12 Dec 2023 19:26:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Have trace_marker break up by lines by size of
 trace_seq
Message-ID: <20231212192637.27e884d7@gandalf.local.home>
In-Reply-To: <20231213091933.e3c78e210683b75b9dcbf59f@kernel.org>
References: <20231212190422.1eaf224f@gandalf.local.home>
	<20231213091933.e3c78e210683b75b9dcbf59f@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Dec 2023 09:19:33 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 12 Dec 2023 19:04:22 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > If a trace_marker write is bigger than what trace_seq can hold, then it
> > will print "LINE TOO BIG" message and not what was written.
> > 
> > Instead, if check if the write is bigger than the trace_seq and break it  
> 
> Instead, check if ... ?

Ah yes, thank you.

> 
> > up by that size.
> > 
> > Ideally, we could make the trace_seq dynamic that could hold this. But
> > that's for another time.  
> 
> I think this is OK, but if possible it is better to be merged with the
> "LINE TOO BIG" patch (by updating the version).

What do you mean by "updating the version"?

Note, the LINE TOO BIG doesn't happen today. It only happens when applying
the sub buffer resize change, and then when I run the tests, it breaks when
the subbuffer is bigger than the trace_seq.

> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

-- Steve
