Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5914B7FD;
	Wed, 29 Jan 2025 00:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738109651; cv=none; b=MN3veys9omkcvRCWA67veQHnMh3Ba7s1XGAOrqUJ01xq+8vs+UWNJsAMZHkwznuyFutfWAQudfva8yM9edNkfKyXr50gbACOjLWVw5j0DbVt/42B6NzxsEII0H7+Efrvzk5aKGhprEFQ74SfO+nTpGdNJwV9+DNmZnMDA2akkhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738109651; c=relaxed/simple;
	bh=OMFJc0JoBQ8IgFwPGAsl7WSzObXZ/0rzZ211wDUhOYQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hL7LYY5j/Y8AeRWkM5BUNQ4f//v5nnyN7zUpXMAtLFIqk+jk7/a7kdldtB4cyrRPoexL+9PtLFa7fIc0NK79aBAl+Q0UNjfifQ1k3Z2B2+eNMnqcIoydv9CQTkzqqhaQdfmpQnvsjtA9CSsbZPuw3ZqfLEeLtIFkKGxi5a1DDq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReIz/VrD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReIz/VrD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C442C4CED3;
	Wed, 29 Jan 2025 00:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738109650;
	bh=OMFJc0JoBQ8IgFwPGAsl7WSzObXZ/0rzZ211wDUhOYQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ReIz/VrDzk8E5pTA01lmaQFR9x+gIZBmib5bTe61wEhdLcB55KI9gJJ5l/ui0iqya
	 gv++mPuACKRBkqBy2hpxH9jXdOymlX3RnyrPvWsG3tP3hO5DtnyXdYzxDj+akJ1siS
	 2DIdaCrfCBb9sZ1jx7iGDWR9anyEiGYeVQ9hDtDyQClHM0nDG/giT0xFLZwm24WZGO
	 ygM2Ds1sAJXGoEjFQwz9B3oayzJwhmyGImED6aMty02XkWXW91h65eCbVTe1CKiVis
	 3lcSEzNmPxESHw6DHzy/VvPQqHoIwh/lq15f05/Os9lqkoxWftvMesH25Gmita3Pfk
	 1Hi/1iwujPQNw==
Date: Wed, 29 Jan 2025 09:14:06 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] tracing: Introduce "rel_stack" option
Message-Id: <20250129091406.a086021e0633c488e5c22ae3@kernel.org>
In-Reply-To: <20250128110700.741e68cd@gandalf.local.home>
References: <173807861687.1525539.15082309716909038251.stgit@mhiramat.roam.corp.google.com>
	<173807863557.1525539.14465198884840039000.stgit@mhiramat.roam.corp.google.com>
	<20250128110700.741e68cd@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 11:07:00 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 29 Jan 2025 00:37:15 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Since the relative offset stacktrace requires a special module loading
> > events to decode binary, it should be an optional for normal use case.
> > User can enable this feature via `options/relative-stacktrace`.
> > 
> 
> Let's make this an entirely new event and not based on an option. Reason
> being, there's no way for libtraceevent to know which this is. We could
> even have a mixture of these in the trace.
> 
> Instead of an option, we can add a new trigger: stacktrace_rel that will do
> a relative stack trace. And the event can be kernel_stack_rel
> 
> Then it can be enabled via:
> 
>   echo 'stacktrace_rel if prev_state & 3' > events/sched/sched_switch/trigger

Oh, I thought this was another feature, adding a new trigger action.
Can't we do this with the event defined by FTRACE_ENTRY_DUP()?

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
