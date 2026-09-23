Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB12448CF6;
	Wed, 23 Sep 2026 08:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790151478; cv=none; b=dbwCPWXLu66W/2lLPjFJ8NeUcjAhbICJ/aQJpoUAdxop46tfDcCZeCKX/iYYaFpbQybsXMIoaiJDLgfiaGP6cbUCGKkaDLeb7ngRgiwE/D5Q3kdIsfIZ8V4EWTlxYEX3nKST8fIoifD3FpgYmASja/RQCY2rTmShXF1tAZmWcgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790151478; c=relaxed/simple;
	bh=DKsHVr/IcvJ4S+VywNfzLh+VzdbNQ+YARS2CIPixJS8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+AGrx1RqPlKTbwSZDwWgiCgmihB1UwK8rl/jkKnE39MwRW5j6zime5J4L+l9RjS/3y4mkFOQx96Lc/RtdwxC9PEAfAuJ+2C7vk03InKooZfzoE4YoThOvti1LXQX+GtMLBOJ6FQmrFYysMo2uA2YTSIOXNPCCXc4eQB/U5YcBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=izY3fPhE; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="izY3fPhE"
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id EB27280729;
	Wed, 23 Sep 2026 08:17:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id B78886000F;
	Wed, 23 Sep 2026 08:17:46 +0000 (UTC)
Date: Wed, 23 Sep 2026 04:17:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ring-buffer: Add a MAINTAINERS category specific for
 the tracing ring-buffer
Message-ID: <20260923041741.3f4c43ab@fedora>
In-Reply-To: <arOIjWCRhnYxkUcR@google.com>
References: <20260908094035.0b180833@gandalf.local.home>
	<arOIjWCRhnYxkUcR@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: B78886000F
X-Stat-Signature: 1wizpee9ke7zmutn3hp1estw5t3jk9hr
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1++nwASrgHCUVJYC8Gl5GAoYqpPG3lyOBE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=KzLS8QLY2z40mi4CH0QaoZSY/dG45acAj/F74i3x8wg=; b=izY3fPhEYs2w6pIw4v22PH3efDph5F0ord7XNMKrl/49BpmQtqEhE3kzKceXxUVamfPiBxXEqPOL7OlRmhlEJx/tLrDBjLKeAOFtkejbleoiwtcsb/91Hl/bEV8wSVL2P4OSM1AUBvapZT7ZT0qFCUpfQVp0dBge5R5qLRmXpi0=
X-HE-Tag: 1790151466-662672
X-HE-Meta: U2FsdGVkX1/UR7fwce7VDhn3JOhTy+N5sVjAblQbK2MOQJ0Nfo2A8XHn3ixSYaszb/vQvs0nyUUzEWbZ6jUfSWye0Txx/sjZRpNTNfipsorOeAz42osa1CXSGdQ8zTBlzOJcqdlAImw47Ge4Q4sDMChyZmojtvJkdwwUD55q1ISm+0EvKTzns/mEL+bR1n3zC8Jew3ZR6sU+uTLUMwGY0SF1RmnPgguPC7ddwJ6Z+GBwbf1V0S5zQuZusx5BrYtY4IKOSl8zXix8RFtTmok7NnxEFC39PNzMbiJ1xaJFl1KZcG0nfSmqdn5myjvfr3zS3mf7zPZDa/NSQmwdOeF/wxXzCxo2pF60lzSPfOvhcUhdgXyKrFZxoZftNWquqe0ZTTGqmyFqdKaIjF9wP/TgwhhppqSGWTGbCE4ll1ePA9d6pJLgylYTYR1lR6e4Y1QxTVcQt/a9d2lnkhnibmhf7WEhw99xQnGdIsbFG/UeHopENVV++dvhB2RUALIiToO4

On Wed, 23 Sep 2026 09:06:37 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> On Tue, Sep 08, 2026 at 09:40:35AM -0400, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > The ring buffer code in the tracing directory has always been decoupled
> > from the tracing code. It had a clean abstracted API to allow it to be
> > used by systems outside of tracing. The API even allowed the ring buffer
> > code to be drastically changed without affecting the tracing sub-system.
> > 
> > Recently, Vincent Donnefort has been contributing a lot of work to enhance
> > the ring buffer. He implemented the user space mappings and recently
> > created a version to allow pKVM hypervisors to use the code to trace
> > the hypervisor and expose the events to the user.
> > 
> > Create a separate category for maintaining the ring buffer code so that
> > Vincent can become an official maintainer of it. His work has little to do
> > with the tracing code itself. In the future, he may even be the main
> > maintainer of the ring buffer.
> > 
> > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> > ---
> >  MAINTAINERS | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3a19da74d00c..71bd2f57055d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -27778,6 +27778,22 @@ F:	kernel/trace/trace_irqsoff.c
> >  F:	kernel/trace/trace_osnoise.c
> >  F:	kernel/trace/trace_sched_wakeup.c
> >  
> > +TRACING RING BUFFER
> > +M:	Steven Rostedt <rostedt@goodmis.org>
> > +M:	Vincent Donnefort <vdonnefort@google.com>
> > +M:	Masami Hiramatsu <mhiramat@kernel.org>
> > +L:	linux-kernel@vger.kernel.org
> > +L:	linux-trace-kernel@vger.kernel.org
> > +S:	Maintained
> > +Q:	https://patchwork.kernel.org/project/linux-trace-kernel/list/
> > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
> > +F:	Documentation/trace/ring-buffer*
> > +F:	Documentation/trace/remotes.rst
> > +F:	include/linux/ring-buffer*.h
> > +F:	kernel/trace/*ring_buffer*.c  
> 
> as it relates to simple_ring_buffer.c do you want to add here undefsyms_base.c?

Sure. I can send a v2.

-- Steve

> 
> > +F:	kernel/trace/remote*.c
> > +F:	tools/testing/selftests/ring-buffer/
> > +
> >  TRADITIONAL CHINESE DOCUMENTATION
> >  M:	Chen-Yu Yeh <chenyou910331@gmail.com>
> >  M:	Weijie Yuan <wy@wyuan.org>
> > -- 
> > 2.53.0
> >   
> 

