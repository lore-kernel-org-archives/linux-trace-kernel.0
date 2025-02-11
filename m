Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3523250BF9;
	Tue, 11 Feb 2025 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739285847; cv=none; b=et3UJyqsO+9wk4/Leu2qoB3ZtMGfRHfdIjW1jMYuJuKmP2mkRgpftWPYYdIkJ623kNLprsS/XTav9CC11q/H/U5gW+hJvgIXJvYHFiInAIQQjZOUW+8hGzqAv/E/Vq9C1X4JYZCJeE3rsOQ3D508RUwr75Cf+zPB/MlAQjH6iuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739285847; c=relaxed/simple;
	bh=VFfK5lB5RTyODMoJOz9ZlokSyeYl5XB6lSatbci/5+E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZuSG6k78vtC4tkGejmb832nSqobMQ7BYaWtRX9ccpqnDeu57555fT2yGcE0RcVMIO4RwglxT9+kghXQMbiQoIiKlvJ0YR/IU3VULD33EvOPW6lt3WVDAh+S2Bg6R/qKyzeHhy1QTnRccZVMCEz9T/6sJrUNacfNHAgnv6u4Qs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494F2C4CEDD;
	Tue, 11 Feb 2025 14:57:26 +0000 (UTC)
Date: Tue, 11 Feb 2025 09:57:31 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Subject: Re: [RFC PATCH v2 3/3] tracing: Freeable reserved ring buffer
Message-ID: <20250211095731.66b6771f@gandalf.local.home>
In-Reply-To: <20250211104122.8ce39b7d4be222318d6c010b@kernel.org>
References: <173920222697.826592.3726270716809214055.stgit@devnote2>
	<173920225773.826592.6428338529686044470.stgit@devnote2>
	<20250210191350.79dfa2a2@gandalf.local.home>
	<20250211104122.8ce39b7d4be222318d6c010b@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 10:41:22 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Mon, 10 Feb 2025 19:13:50 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Tue, 11 Feb 2025 00:44:17 +0900
> > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> >   
> > > @@ -9857,8 +9861,10 @@ static int __remove_instance(struct trace_array *tr)
> > >  	int i;
> > >  
> > >  	/* Reference counter for a newly created trace array = 1. */
> > > -	if (tr->ref > 1 || (tr->current_trace && tr->trace_ref))
> > > +	if (tr->ref > 1 || (tr->current_trace && tr->trace_ref)) {
> > > +		pr_info("Instance is busy: ref %d trace_ref %d\n", tr->ref, tr->trace_ref);  
> > 
> > I don't think we need the print. The function will error with -EBUSY
> > letting the user know that it is busy. This is a very common error, where I
> > found that I had a program that didn't completely die, and still had a file
> > descriptor open on an instance, and when I go to remove it, I get:
> > 
> >   # cd /sys/kernel/tracing/
> >   # mkdir instances/foo
> >   # bash 5< instances/foo/events/enable
> >   # rmdir instances/foo
> >   rmdir: failed to remove 'instances/foo': Device or resource busy
> >   # exit
> >   # rmdir instances/foo
> >   #
> > 
> > If you only have it for debugging that is fine, but we should remove it
> > before we accept it.  
> 
> Oops, that is my debug code. I missed to remove that! Sorry for confusion.

Heh, that's why I use "printk()" and not the "pr_*()" functions. Since I
don't usually have "printk()" in the normal code but use the "pr_*()"
functions there, it makes it easy for me to find the debug statements I put
into my code while I develop it.

-- Steve
