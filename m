Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D339CC8E1
	for <linux-trace-kernel@vger.kernel.org>; Sun, 10 Dec 2023 16:37:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CE1C433C7;
	Sun, 10 Dec 2023 16:37:52 +0000 (UTC)
Date: Sun, 10 Dec 2023 11:38:29 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] tracing: Allow for max buffer data size trace_marker
 writes
Message-ID: <20231210113829.780c7097@gandalf.local.home>
In-Reply-To: <a684a5f8-9a60-4e16-93f5-747117d08371@efficios.com>
References: <20231209175003.63db40ab@gandalf.local.home>
	<2683467e-cadb-4bb8-8c50-87ef052edacb@efficios.com>
	<20231210103009.29010d00@gandalf.local.home>
	<a684a5f8-9a60-4e16-93f5-747117d08371@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Dec 2023 11:07:22 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > It just allows more to be written in one go.
> > 
> > I don't see why the tests need to cover this or detect this change.  
> 
> If the purpose of this change is to ensure that the entire
> trace marker payload is shown within a single event, then
> there should be a test which exercises this, and which
> validates that the end result is that the entire payload
> is indeed shown within a single event record.

No, the purpose of the change is not to do that, because there can always
be a bigger trace marker write than a single event can hold. This is the
way it has always worked. This is an optimization or "enhancement". The 1KB
restriction was actually because of a previous implementation years ago
(before selftests even existed) that wrote into a temp buffer before
copying into the ring buffer. But since we now can copy directly into the
ring buffer, there's no reason not to use the maximum that the ring buffer
can accept.

> 
> Otherwise there is no permanent validation that this change
> indeed does what it is intended to do, so it can regress
> at any time without any test noticing it.

What regress? The amount of a trace_marker write that can make it into a
the buffer in one go? Now, I agree that we should have a test to make sure
that all of the trace marker write gets into the buffer. But it's always
been allowed to break up that write however it wanted to.

Note, because different architectures have different page sizes, how much
that can make it in one go is architecture dependent. So you can have a
"regression" by simply running your application on a different architecture.

Again, it's not a requirement, it's just an enhancement.

-- Steve
