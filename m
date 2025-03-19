Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3228D2101A0;
	Wed, 19 Mar 2025 09:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742375605; cv=none; b=Ty05Z255AtEUyvAlm/MhG7YhlQe6rcn0DAMuug0zAu1Jq3el+h8ilzc/lg1VtAAxCQHLphwpsB6rrP320JxNGZQ0ZZQlDr3q5fGmbGhsUQYlnmxFHQnh9HPdq8+t4MGCFiheZUTlOio/esw7oEMrGeLpI4HllZGd3/n/ShTkrCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742375605; c=relaxed/simple;
	bh=p/y2kAho1NtiurpN2xmsF0i016akloEgfaDZO1HNXHs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1DS4hWIg3YrLTidKDTKkt0UuVum34y0GToiYHhDAGHPq03OJwo0fmbxZiA9ek7NEdvt3mpFXO/ZgSfqME8QXPlKbBFFCEHyQELrbPHVv9//0aJYhgbovuhlxn1iuh5QFmDLIU3dJ0tDIeEssmC0JF3p6GU6zCLbz9O5wWjc5Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8F3C4CEE9;
	Wed, 19 Mar 2025 09:13:22 +0000 (UTC)
Date: Wed, 19 Mar 2025 05:13:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Gabriele Paoloni <gpaoloni@redhat.com>, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tracing: fix return value in
 __ftrace_event_enable_disable for TRACE_REG_UNREGISTER
Message-ID: <20250319051317.670ba86c@batman.local.home>
In-Reply-To: <20250318110700.510f05df7e113180503fc036@kernel.org>
References: <20250314125725.6425-1-gpaoloni@redhat.com>
	<20250318110700.510f05df7e113180503fc036@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Mar 2025 11:07:00 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > --- a/kernel/trace/trace_events.c
> > +++ b/kernel/trace/trace_events.c
> > @@ -790,7 +790,7 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
> >  				clear_bit(EVENT_FILE_FL_RECORDED_TGID_BIT, &file->flags);
> >  			}
> >  
> > -			call->class->reg(call, TRACE_REG_UNREGISTER, file);
> > +			ret = call->class->reg(call, TRACE_REG_UNREGISTER, file);  
> 
> This is not enough. As same as enable failure, this function needs to handle
> this error to report it and break.

Perhaps all we should do here is:

			WARN_ON_ONCE(ret);

-- Steve
