Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2954431;
	Fri, 11 Oct 2024 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728655284; cv=none; b=fOGp4gQJHMq+KBVxVidIs/H/ppbzzojXktwBJkFhGC05H2qXQD3PmhUHZGU1GmEVE4JxWUQRbuF9LX/wCdPQY15AwFklpr2yT0KToJG1S4XeHWGW9QPbyZpRnJMhTvguT00FtXfve0CvF9TlyzNHDE8vkc8CDp3wlh18c3p7Q1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728655284; c=relaxed/simple;
	bh=Iwpl98h1V5EgQRGx6yjRbC4ERp0lCtfsNEnt5QdUewM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZzOfpeQZnt78rZ2jtgUv0QXTSy96R10T14CfqwY+mpOwVbBcrdbkHZ0aeFvUIfG62Z5uNUdM5ZwNk/73yaLzcS+shp5Ycn8bQyNQWHlGQxXbHLb77rez2ie6Y4jIWZ8daWTvIjdPTnC9u5CTSyc3PQIUjTqJzVsfPr35SLIuLl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C6CC4CEC3;
	Fri, 11 Oct 2024 14:01:23 +0000 (UTC)
Date: Fri, 11 Oct 2024 10:01:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer: Have the buffer update counter be atomic
Message-ID: <20241011100132.456f903a@gandalf.local.home>
In-Reply-To: <1924e096-916a-4311-a3d5-07d3813f50da@suse.com>
References: <20241010195849.2f77cc3f@gandalf.local.home>
	<1924e096-916a-4311-a3d5-07d3813f50da@suse.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 10:05:51 +0200
Petr Pavlu <petr.pavlu@suse.com> wrote:

> On 10/11/24 01:58, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > In order to prevent any subtle races with the buffer update counter,
> > change it to an atomic_t. Also, since atomic_t is 32 bits, move its
> > location in the ring_buffer_per_cpu structure next to "current_context" as
> > that too is only 32 bits (making 64 bit alignment).
> > 
> > The counter is only used to detect that the buffer has been updated when
> > the buffer verifier check is being done. It's not really that important
> > that it's atomic or not. But since the updates to the counter are never in
> > the fast path, having it be consistent isn't a bad thing.
> > 
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> > Note, this is based on top of:
> > 
> >   https://lore.kernel.org/linux-trace-kernel/20240715145141.5528-1-petr.pavlu@suse.com/  
> 
> Sorry for not replying to your last comment on my patch, I was ill.
> 
> The member ring_buffer_per_cpu.cnt is intended to be accessed under the
> reader_lock, same as the pages pointer which it is tied to, so this
> change shouldn't be strictly needed.
> 

Right, but there was one location that the cnt was updated outside the
lock. The one I commented on. But instead of adding a lock around it, I
decided to just make it an atomic. Then there would be no need for the
lock. Hmm, it still needs a memory barrier though. At least a
smp_mb__after_atomic().

-- Steve
