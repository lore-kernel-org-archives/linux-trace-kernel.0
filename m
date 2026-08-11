Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E03A35AC07;
	Tue, 11 Aug 2026 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786433675; cv=none; b=fFd2r+GRzC6t12bIjCwtxrgmY8kxetZt7xAilGLZc60Ubmvt7dwDR0j9hr5Yp+vVeMnvJ2mK+QsTRQatTo0i3AP69xa3IEVwV8AkfPFW754GjytXptjVyV8NcelBQC+h84Vl4ArpVQ7UuHkQOCqtvQWKi/U609uPza8tP8X+jvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786433675; c=relaxed/simple;
	bh=PH6cZGx9LYOHeKQhFjEwx6tN9N1GG4fsvAMNHfcjr+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcLzJc0d7TpBiRgJB3p6RQvVQxho9w+nyeVWutK9dKRxZBPe2C+BaFONo29QRa4nfbVl3Fr+JKsz5ZwHrC58mtTMZhswxN6EKIPRNi+sXufFAlZybEyctDjQebgHJmIY19dOlppryniVoB/zFjrD9iwozaXkvuQ09SGBfZU3Mgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYJgr4Uj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYJgr4Uj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D727C1F000E9;
	Tue, 11 Aug 2026 07:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786433673;
	bh=PH6cZGx9LYOHeKQhFjEwx6tN9N1GG4fsvAMNHfcjr+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hYJgr4UjkDDJmyBrHtvX7sMiaB1LfpYKkoqma4LEDLxn2vAxGmcG8HDbfm0OcPpxO
	 /PoguVv425iXNK1y+28ugx44Olws6TLU6cVlLpWCRA4qYDbC48QiYt0ue9yMu7yDPM
	 hrgSU/23qphxumPAw638uBx+m5KQpLwy+pcczNPXpwAbPpHWu1r2/MQlKqDMuShDXC
	 Ar6BiBaeawo3AAzB/piLKYsbf3BGkLDLEIet4ooFD7eH9tpOi/maVnpldU1wkj82qL
	 fHHl5ygVUwlgIugjSD7Wr4SAmC0pX/fLfjhcGI+SdWugSlHhbNrwQBI1bbUzURAnYF
	 +DX/gNrlHxk9w==
Date: Tue, 11 Aug 2026 08:34:13 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: gao xu <gaoxu2@honor.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Xiang Gao <gxxa03070307@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "liam@infradead.org" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Xiang Gao <gaoxiang17@xiaomi.com>
Subject: Re: [PATCH] tracing: report buffer memory in /proc/meminfo
Message-ID: <anrPJN-V8K4fhGzZ@lucifer>
References: <20260810094025.136705-1-gaoxiang17@xiaomi.com>
 <69df3080-a719-4131-a247-62bf47bda8a6@kernel.org>
 <anm0SMuVpBz7wLac@lucifer>
 <20260810105710.6ee5e493@gandalf.local.home>
 <9bd98f51abd44d81a569d95e907070c6@honor.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bd98f51abd44d81a569d95e907070c6@honor.com>

On Tue, Aug 11, 2026 at 06:22:58AM +0000, gao xu wrote:
> > On Mon, 10 Aug 2026 12:22:43 +0100
> > "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:
> >
> > > On Mon, Aug 10, 2026 at 12:52:38PM +0200, David Hildenbrand (Arm) wrote:
> > > > On 8/10/26 11:40, Xiang Gao wrote:
> > > > > Report the data capacity of all ftrace ring buffers through a new
> > > > > Ftrace field in /proc/meminfo. Include the main and snapshot
> > > > > buffers of the global trace array and all tracing instances, while
> > > > > leaving ring-buffer metadata accounted for by Slab.
> > > >
> > > > why? :)
> > > >
> > > > To report a handful of KiB as in your example below? Doesn't sound
> > > > super helpful TBH.
> > >
> > > Yeah I think we need to stop with all the proposed additions to
> > > /proc/meminfo :)
> > >
> > > Also something like this where you are making a change in output that
> > > it is just your opinion that it is useful should be an RFC to see what
> > > the community thinks first.
> >
> > Agreed. This doesn't belong in the meminfo. If you want memory statistics for
> > tracing, I may be OK if you add a "total_memory_kb" file in the
> > /sys/kernel/tracing/trace_stats/ directory.
> Would it be possible to include this info in show_mem()?
> This would be helpful for analyzing low-memory and OOM issues.

You have to back up requests with reasons, it's not a case of 'please add X to
Y' and then we deign to do it or not.

Justifications are required. We could add endless crap to show_mem() until the
CoWs come home, maybe even list the number of emojis used since last boot
obviously.

So - why are you asking for this? Is it only a handful of KiB used for tracing?
Is it GiB? If so maybe it's because you're doing something crazy? Why does a
kernelfs file not suffice, etc.?

You need to engage with the discussion and back things up rather just asking
like you were typing into an LLM prompt...

But in general, no, it makes absolutely no sense to randomly output some trace
information there, unless you're about to offer up the most compelling argument
since the invention of marmite and butter on toast.

show_mem() is for critical memory information displayed at the point of OOM or
sysrq-please-help-me, not random stats.

> >
> > And break it up for memory used. Ring buffers, events, etc.
> >
> > Perhaps even add one per CPU as well.
> >
> > I'm always conscience about how much memory tracing is taking up in the
> > system.
> >
> > -- Steve
>

--
Cheers, Lorenzo
