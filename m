Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC77E3DF001;
	Tue, 30 Jun 2026 19:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782846578; cv=none; b=bjSOLRLwSugy7ck0MdnLfPpqKT3qwoYsCL0FkNo7wzwnjv1n7NLrFdA6kQXVXqNdQopU4sLUNDNQimx21OAsrL9dGCVoOZmL02OxbpazhDzU1uEP2bMqn/4FdV9O8iCnRkQvn3FLvEX2Q3+Bl9NCbH8HIJukYn2FpaehgKMTBpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782846578; c=relaxed/simple;
	bh=LF5PJQlB6qZEExlxiMfWm3arqOg8bLxTJCexfzF38LE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uxgQM5k0HGyn2htFFXj6S55oei7a6qJuoGwpiX+F8TnP783e07DQAxni4OdqGE+pIPylDQH/wIP8n9Mi8qFh2PV4rQhoZ977xTPm7LFjVltSr8Y1rhCBWYu/Wbs0pFO/nEXNpV3KFcu5O8HYS362bpbY7u6ZL6ZIhSgB83ORqBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 16A81A0611;
	Tue, 30 Jun 2026 19:03:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 17DC120032;
	Tue, 30 Jun 2026 19:03:48 +0000 (UTC)
Date: Tue, 30 Jun 2026 15:03:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Michal =?UTF-8?B?S291dG7DvQ==?=
 <mkoutny@suse.com>
Subject: Re: [PATCH 2/2] tracing: Keep pid and comm[] in the same structure
Message-ID: <20260630150348.149e318c@gandalf.local.home>
In-Reply-To: <20260630110156.5314e2e6@pumpkin>
References: <20260626212356.64150-1-david.laight.linux@gmail.com>
	<20260626212356.64150-3-david.laight.linux@gmail.com>
	<20260629164912.4c1c2855@robin>
	<20260630110156.5314e2e6@pumpkin>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 17DC120032
X-Stat-Signature: st9b3p3o3d3fy6394gxtejbi4srqdm97
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/9BnfD/fcgGcfTAjl19cT7bg+YR0F+ZIQ=
X-HE-Tag: 1782846228-192631
X-HE-Meta: U2FsdGVkX18+NoY+1914X8Y77pMqyXJyPBQU7X3aYnKX8IbqWegc5sgnOeWWIPh5uNT2P8eYeE0kv4ZWNYCmvZsmlQ8WHFgPhaQZbMgRUBDWdoYPWMh+xswa8crM0oEVvwTqVcPwIx/IHCcgWdKoQ2DjuNp+WAINh8JyMJP/YKM4OthGcHCRyzK9YobSPO3xrNHHDxDWtaRO0/SUxzSWoLHQrNvxUSwBCubvj34sntv1VrYZSoYHoSJ6CFNAX8sO32vGj6mkPL62mydSaU7dF/0I2XHou/rXlhde/V+dj/5oHGZjvSwgVy0ApEPSPFChaCli39ng+IHY2FW04pHhAciHvrT4I9HwmBERKADXvDrhtD5LidS0KbiNduoCFL5C

On Tue, 30 Jun 2026 11:01:56 +0100
David Laight <david.laight.linux@gmail.com> wrote:

> > It's been a long time since I worked on this, but IIRC, it was to keep
> > the pressure down on the TLB when tracing. It updates at every
> > sched_switch that has a trace event occurring so, I likely used normal
> > pages which are part of the huge pages the kernel sets up and doesn't
> > affect the TLB as much. vmalloc does have impact on the TLB pressure,
> > and tracing should always try to avoid that.  
> 
> Isn't this a cache so that the pid numbers can be converted to strings
> when the trace is read out after the actual process has exited?
> That does mean that cache doesn't need to be updated on every trace
> request - it might be enough to just save on process exit and lookup the
> pid itself for running processes (the whole thing relies on pids not
> being reused).

Yes it's a cache but it only gets filled when needed. That is, after a
trace event occurred. Tracing is very commonly used with filtering, where
events can be seldom triggered. What is in the saved_cmdlines file should
only be tasks that were running when a trace occurred.

Now what we could do is add a flag to the task struct and only set that
when tracing happens. Only tasks that exit would be saved in this array.
The other tasks could be queried via iterating the tasks and reporting any
task with this bit set.

> 
> >   
> > > map_pid_to_cmdline[] is 64k*sizeof(int) so the whole structure
> > > expands to 512k with about 64k/20 (about 3200) pid entries even
> > > though the default is 128.    
> > 
> > That's because it is not dynamic. That array needs to be able to hold
> > most PIDs. The default is 128 but it will expand to how much it can
> > hold to allocate the full map_pid_to_cmdline. The real default for 4098
> > page sized architectures is 6552 entries.  
> 
> That is double my 'quick calculation' - but both are a lot of entries.

I got the number by looking at saved_cmdlines_size after boot ;-)

> 
> > > AFAICT there is only one copy of the data - so it could be static.
> > > Perhaps with pointers to map_pid_cmdline[] and (after this patch)
> > > pid_comm[], both of which could be separately resized.    
> > 
> > map_pid_t_cmdline[] is to hold the PID_MAX_DEFAULT amount of PIDs to
> > avoid collisions. I wouldn't resize it.  
> 
> If comm[] is only saved on process exit you'd likely get away with far
> fewer entries - getting collisions for processes that have exited is
> rather unlikely.
> (I wonder if I could make that work.)
> 
> Does that memory get allocated at boot time?
> 512k is a lot to allocated for a feature that won't usually be used.
> OTOH you won't reliably get that much contiguous memory later on.
> Deferring to a later time (maybe as late as the first tracing_on())
> might be more reasonable - but that would have to use vmalloc().
> 
> I'm also not sure about the code that lets you trace from boot.
> That must be able to initialise early - but I'm not sure how early.

Well tracing can start before init, so pretty early.

-- Steve
