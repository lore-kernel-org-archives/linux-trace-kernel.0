Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36804A21;
	Tue, 13 Jan 2026 00:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768265152; cv=none; b=Pe0McwpSNwkLufy3Kv+nDzCHMW4YKKCbH50zsTAn72UDvj0FeGLIXmwElfv5TrphoIeaAiEjqI4IthK0VaNMWQ9nJuE1qGqGPS6RpM/B+PCnONLUfH34D/qO3uqYAGzj+7K5aHv//50loomY2lnI4jotk402sMhAXfjUJGZnCNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768265152; c=relaxed/simple;
	bh=rwwZvUzGTYaBVOY1HOGpV3rhx5yT6ZZ574lyVHfSVF4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mfsUVL93Qp0/RA5aASrzrJpoU6DQ9by1bByor6NUMv9c7W7vhUAitiGJbdAKXwxa8KoBw8xYkWyh3wRHZV6Jt0yr3uXjlQwFmHHHg4Q/5bBbRB0j/4X6MvCrKrJAyKevyEJrd/5w7SDYC7Z0LLAaB2u0ssPlshNvJMs67hHOhMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 822DABECC6;
	Tue, 13 Jan 2026 00:45:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id DD56432;
	Tue, 13 Jan 2026 00:45:47 +0000 (UTC)
Date: Mon, 12 Jan 2026 19:45:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tracing: Make the backup instance readonly
Message-ID: <20260112194551.2446d041@gandalf.local.home>
In-Reply-To: <20260113093100.e91c5be8b8fa5f1e64899ba4@kernel.org>
References: <176788217131.1398317.11144318616426272901.stgit@mhiramat.tok.corp.google.com>
	<176788218294.1398317.13118277798168167277.stgit@mhiramat.tok.corp.google.com>
	<20260113093100.e91c5be8b8fa5f1e64899ba4@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DD56432
X-Stat-Signature: bjejnai3kjps5wr4jwrn5rehuesgki9t
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18fBm7/khZGaT4gPBaBBKEHVrYppPG8WHU=
X-HE-Tag: 1768265147-85398
X-HE-Meta: U2FsdGVkX1/dt7PzTSAZviLjy3kVmf+y1mpoA9Xv9wY+bm5jE0Tx2/W7sNfTwcIUVixmmLbasCrbcdR77DQ7N+x/utfuRfOb1hsCdVwgNXoHmZwgxcMFOUBgu8kG1P0LCA7m7X7jEhBqfgfWfcIIo0l6zz1hDXrzcfh44mOC3IbZkZ5lle/vBnkcheNmmB8iHyLqMxRLIEYIBPRb+XxHyP4WPnmwd9wGkvaBwn0xyE+eQw/liTtJo97Wbylw6UvACZvuFGgTvMPxjQd2NSJWEPxmzt3ZK3+N6cdIZdGW1MQIDQJP57GMWEmEntbW2k7Twe/9wo2XJIy1k4e8K//0HpOFhs+8Y5es

On Tue, 13 Jan 2026 09:31:00 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > +	static struct eventfs_entry event_ro_entries[] = {
> > +		{
> > +			.name		= "format",
> > +			.callback	= event_callback,
> > +		},
> > +#ifdef CONFIG_PERF_EVENTS
> > +		{
> > +			.name		= "id",
> > +			.callback	= event_callback,
> > +		},
> > +#endif
> > +	};  
> 
> Thinking about this hack again, it would be easier to maintain if I add
> a readonly flag to each eventfs_entry and specify readonly when creating
> the eventfs top directory.
> 
> Let me update it.

Let's not add any flags to the eventfs_entry. That is created for every
event, and events are already too big in size. I don't want to increase the
size of each event for this feature.

-- Steve
