Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117BF1D14FF;
	Mon, 13 Jan 2025 21:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736803009; cv=none; b=HpUMbnerMV/Ii5u1lgoM80TdlZJAwTEv/ExRpFVzqP65WnNbaw3R1dL4//vC8h/nyFs6olCANf0NeiOOSDvA4qrukYzCsqqzyZDlNoQ8G0EDonRZoCuOFHdUV8laRU5jN3lqCC/FYbjbfDXfuNVieqFY7VWlyCq01UqGwNmWMfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736803009; c=relaxed/simple;
	bh=wVWBI3y/Cw1H07zqeAt1JIIaSLKxqRtw5Zhg36eNv+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zvytf0hzUujFH9Dt5OTHnmeDwasd8I4rZMajzuNfevk3wTu1sm5uHXwMot02NYL5rmgUA6xaDR1W5pBdV2BTdN95ESj6Q6mblEaw60eXRj93bi6bUdwOEWW6b6xJqmbFe80/c0kjiLyrPgDKvfod1uFR4aGfdygQCneswhgYND4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3E4C4CED6;
	Mon, 13 Jan 2025 21:16:47 +0000 (UTC)
Date: Mon, 13 Jan 2025 16:16:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: fix trace.h kernel-doc func/struct/enum
 members
Message-ID: <20250113161646.6889e310@gandalf.local.home>
In-Reply-To: <20250111063210.910922-1-rdunlap@infradead.org>
References: <20250111063210.910922-1-rdunlap@infradead.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jan 2025 22:32:10 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> @@ -1947,7 +1949,7 @@ struct event_command {
>  /**
>   * enum event_command_flags - flags for struct event_command
>   *
> - * @POST_TRIGGER: A flag that says whether or not this command needs
> + * @EVENT_CMD_FL_POST_TRIGGER: Indicates whether or not this command needs
>   *	to have its action delayed until after the current event has
>   *	been closed.  Some triggers need to avoid being invoked while
>   *	an event is currently in the process of being logged, since
> @@ -1966,7 +1968,7 @@ struct event_command {
>   *	itself logs to the trace buffer, this flag should be set,
>   *	otherwise it can be left unspecified.
>   *
> - * @NEEDS_REC: A flag that says whether or not this command needs
> + * @EVENT_CMD_FL_NEEDS_REC: Indicates whether or not this command needs
>   *	access to the trace record in order to perform its function,
>   *	regardless of whether or not it has a filter associated with
>   *	it (filters make a trigger require access to the trace record

I really wish tools would handle the above and accept it as is. I hate
adding duplication as it makes it harder to see the difference between
events.

/**
 * enum event_command_flags - flags for struct event_command
 *
 * @POST_TRIGGER: A flag that says whether or not this command needs
 *	to have its action delayed until after the current event has
 *	been closed.  Some triggers need to avoid being invoked while
 *	an event is currently in the process of being logged, since
 *	the trigger may itself log data into the trace buffer.  Thus
 *	we make sure the current event is committed before invoking
 *	those triggers.  To do that, the trigger invocation is split
 *	in two - the first part checks the filter using the current
 *	trace record; if a command has the @post_trigger flag set, it
 *	sets a bit for itself in the return value, otherwise it
 *	directly invokes the trigger.  Once all commands have been
 *	either invoked or set their return flag, the current record is
 *	either committed or discarded.  At that point, if any commands
 *	have deferred their triggers, those commands are finally
 *	invoked following the close of the current event.  In other
 *	words, if the event_trigger_ops @func() probe implementation
 *	itself logs to the trace buffer, this flag should be set,
 *	otherwise it can be left unspecified.
 *
 * @NEEDS_REC: A flag that says whether or not this command needs
 *	access to the trace record in order to perform its function,
 *	regardless of whether or not it has a filter associated with
 *	it (filters make a trigger require access to the trace record
 *	but are not always present).
 */
enum event_command_flags {
	EVENT_CMD_FL_POST_TRIGGER	= 1,
	EVENT_CMD_FL_NEEDS_REC		= 2,
};

Looks much easier to see what is what than:

/**
 * enum event_command_flags - flags for struct event_command
 *
 * @EVENT_CMD_FL_POST_TRIGGER: A flag that says whether or not this command needs
 *	to have its action delayed until after the current event has
 *	been closed.  Some triggers need to avoid being invoked while
 *	an event is currently in the process of being logged, since
 *	the trigger may itself log data into the trace buffer.  Thus
 *	we make sure the current event is committed before invoking
 *	those triggers.  To do that, the trigger invocation is split
 *	in two - the first part checks the filter using the current
 *	trace record; if a command has the @post_trigger flag set, it
 *	sets a bit for itself in the return value, otherwise it
 *	directly invokes the trigger.  Once all commands have been
 *	either invoked or set their return flag, the current record is
 *	either committed or discarded.  At that point, if any commands
 *	have deferred their triggers, those commands are finally
 *	invoked following the close of the current event.  In other
 *	words, if the event_trigger_ops @func() probe implementation
 *	itself logs to the trace buffer, this flag should be set,
 *	otherwise it can be left unspecified.
 *
 * @EVENT_CMD_FL_NEEDS_REC: A flag that says whether or not this command needs
 *	access to the trace record in order to perform its function,
 *	regardless of whether or not it has a filter associated with
 *	it (filters make a trigger require access to the trace record
 *	but are not always present).
 */
enum event_command_flags {
	EVENT_CMD_FL_POST_TRIGGER	= 1,
	EVENT_CMD_FL_NEEDS_REC		= 2,
};


If tooling can't handle it, I'd rather replace the /** with /* as I find
the above much harder to read than the original.

It shouldn't be too hard. The tooling should accept the kerneldoc if all
the enums start with the same text, then the descriptions only need to show
the part that is different.

-- Steve
