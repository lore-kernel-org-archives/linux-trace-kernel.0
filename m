Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A6B2E265A;
	Thu,  2 Apr 2026 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775135987; cv=none; b=Mh+34YMDWAg1FzScJU1PjCY4oAN6iKE38Cc1XmM7Nk4LNgB6gbeX3Y/IdXne1ZOfYNH4gqBDVKKGEXIzrtBiqmNASkRJ00Y5F7NEyPxPAZEipUcwxQAfzOxQKd+rtd0PuynJxFOda3VfW+KOGsJVznltWAFz1AEPZ4XfVTXiBBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775135987; c=relaxed/simple;
	bh=9j8WRvIb56UiDFwzaCgefEwr2gDtvnU1wDBFvYi1QGo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FhbA+rH7AoCmH4rIzZ4PObgwF7exEeKye4Vyj1ePuea+794G6nfSb5NmJ0BRSXB46466pZcj5unQD0I6Wm7bAFg/AlrtbEH9GtzUJcCn+pO9u7GQos5shXd9cucVXfz8VcLPOdfM4ul95oUXJ8dZIds08x12bYwJ0aiXFv5Kko4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6tRQbwU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6tRQbwU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3446C116C6;
	Thu,  2 Apr 2026 13:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775135987;
	bh=9j8WRvIb56UiDFwzaCgefEwr2gDtvnU1wDBFvYi1QGo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H6tRQbwUi8L33S+E8ee1VsyhIKK8REdiQPB0n9pL2JYni6bk6UFEc9QPOBNyobV9r
	 RvjC1UXp5reE8AHuUmpcmykkXuyJ+EW3yCijxzpg3miw+4YquAFAXoMsvprDr8gfRq
	 qeV+zlLtJjpzd6sgHzYTMMvY10wICq8SmheC4e1Zr0cG0ItBZG1QJWabgTVrdZqIWi
	 nDE6RvouUENrg4+s7V3IhuiJTNIrDoRjDzRaFmtaAWVT9b7v+AQtDjcfohT5PTcGdX
	 Szt6o8c6jwEzFV17pEk/FVWA/2rc/8tAtQmV6kFiu2LhRQAOH8nBmQXktBCtkvDYFn
	 0+BJtRXm5ywNA==
Date: Thu, 2 Apr 2026 22:19:43 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/3] tracing: Remove the backup instance
 automatically after read
Message-Id: <20260402221943.e0ba663a6a223f7f857adaf1@kernel.org>
In-Reply-To: <20260401104001.5461c5f0@gandalf.local.home>
References: <177497473558.569199.6527680985537865638.stgit@mhiramat.tok.corp.google.com>
	<177497475349.569199.11513916633426967730.stgit@mhiramat.tok.corp.google.com>
	<20260331171936.6f84e357@gandalf.local.home>
	<20260401121957.2665d454390aff97593bb996@kernel.org>
	<20260401104001.5461c5f0@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Apr 2026 10:40:01 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 1 Apr 2026 12:19:57 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > 
> > >   CPU 0							CPU 1
> > >   -----							-----
> > >   open(trace_pipe);
> > >   read(..);
> > >   close(trace_pipe);
> > >      kick the work queue to delete it....
> > > 						rmdir();
> > > 							[instance deleted]  
> > 
> > I thought this requires trace_types_lock, and after kicked the queue,
> > can rmdir() gets the tr? (__trace_array_get() return error if
> > tr->free_on_close is set)
> 
> rmdir() doesn't use __trace_array_get(), it uses trace_array_find() which
> we shouldn't need to modify.
> 
> static int instance_rmdir(const char *name)
> {
> 	struct trace_array *tr;
> 
> 	guard(mutex)(&event_mutex);
> 	guard(mutex)(&trace_types_lock);
> 
> 	tr = trace_array_find(name);
> 	if (!tr)
> 		return -ENODEV;
> 
> 	return __remove_instance(tr);
> }

Oops, OK it must be updated too.

Thanks,

> 
> > 
> > > 
> > >   __remove_instance();
> > > 
> > >    [ now the tr is freed, and the remove will crash!]
> > > 
> > > 
> > > What would prevent this is this is to use trace_array_destroy() that checks
> > > this and also adds the proper locking:
> > > 
> > > static void trace_array_autoremove(struct work_struct *work)
> > > {
> > > 	struct trace_array *tr = container_of(work, struct trace_array, autoremove_work);
> > > 
> > > 	trace_array_destroy(tr);
> > > }  
> > 
> > OK, let's use it.
> 
> Yes, by using trace_array_destroy(), it will fix this.
> 
> Thanks,
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
