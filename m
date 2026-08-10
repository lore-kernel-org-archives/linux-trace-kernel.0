Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F22E3DE438;
	Mon, 10 Aug 2026 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373829; cv=none; b=EiNsJiMwl1btleZ/TBbAulEkmIQsxp7RjdRsQaFrfr3zQf8SnX/0JD/j90ih7rCcZ43yyUR9veinXORi8xNR1sRuBwJ2V7yx9wysVONTz54Huvggyp/yA6iqw550zvj/1M0WGV/4vYFT5j5bqG7ALAIStK8x0VXzl35WKokTkiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373829; c=relaxed/simple;
	bh=hNFrUjI5ISLAuyosKCwwDLKKgPIyxzjxr2tCxIRo2+s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OzRG6yzm2sAcnVMv97TPUue05DFM3CgU0IjL4+2H3MDec4zIajVtfUdfjB29URSiivCOD5cy9J7ibeOi5PuHeKRpo6oF6EUg3BwrR1gY4OwkUvHOwdHaDa4E7D0x1ako/q178ZcMJStvhrdkFp+vOUHl2VOt9TD7NwZDiKzh3SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 7B644401DB;
	Mon, 10 Aug 2026 14:57:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 187EA2002D;
	Mon, 10 Aug 2026 14:57:01 +0000 (UTC)
Date: Mon, 10 Aug 2026 10:57:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Xiang Gao
 <gxxa03070307@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, liam@infradead.org, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Xiang Gao
 <gaoxiang17@xiaomi.com>
Subject: Re: [PATCH] tracing: report buffer memory in /proc/meminfo
Message-ID: <20260810105710.6ee5e493@gandalf.local.home>
In-Reply-To: <anm0SMuVpBz7wLac@lucifer>
References: <20260810094025.136705-1-gaoxiang17@xiaomi.com>
	<69df3080-a719-4131-a247-62bf47bda8a6@kernel.org>
	<anm0SMuVpBz7wLac@lucifer>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 5jywzf45yw4bun8sqydd5xakunud61nb
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 187EA2002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18eSPQyM+UAYA64F5aCSKfWzLW/KGo8Kqs=
X-HE-Tag: 1786373821-994234
X-HE-Meta: U2FsdGVkX18h8BsaxnBZAiAxJA8VX0jouYReEtmoXZzeqYdC7OsE9ErsPr+uP7COKi2SKYjalSNBz6c5GD5lNsjnnZ7rOAFkQ3BESknYuLHfrLiQ5ob+FjhOeeRFKVsmae5DWFY+VgGWXlPqXTp6/KD101g8Dtn35p7rqVg+D0Ll6lrBgAmjYd42OjtfrPYAW/HY++mYOQhb9DrXrLLvsAwjEVO4/HggwQPlqoa+tUDg5Qm2aNldOy+/R3Th+msxwWtDEkDCjq6gibDnBsRw0VD7FBw4Pu3H+vJesyPbzeBfwrjaXneAgKUfu8YXsEPTteeQz+xDHBqsVR+O302VavjgRUO3nW8M

On Mon, 10 Aug 2026 12:22:43 +0100
"Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> On Mon, Aug 10, 2026 at 12:52:38PM +0200, David Hildenbrand (Arm) wrote:
> > On 8/10/26 11:40, Xiang Gao wrote:  
> > > Report the data capacity of all ftrace ring buffers through a new Ftrace
> > > field in /proc/meminfo. Include the main and snapshot buffers of the
> > > global trace array and all tracing instances, while leaving ring-buffer
> > > metadata accounted for by Slab.  
> >
> > why? :)
> >
> > To report a handful of KiB as in your example below? Doesn't sound super helpful
> > TBH.  
> 
> Yeah I think we need to stop with all the proposed additions to /proc/meminfo :)
> 
> Also something like this where you are making a change in output that it is just
> your opinion that it is useful should be an RFC to see what the community thinks
> first.

Agreed. This doesn't belong in the meminfo. If you want memory statistics
for tracing, I may be OK if you add a "total_memory_kb" file in the
/sys/kernel/tracing/trace_stats/ directory.

And break it up for memory used. Ring buffers, events, etc.

Perhaps even add one per CPU as well.

I'm always conscience about how much memory tracing is taking up in the
system.

-- Steve
