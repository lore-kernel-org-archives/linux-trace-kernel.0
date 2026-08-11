Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ED0442B0E;
	Tue, 11 Aug 2026 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786453181; cv=none; b=SJBVqGdy5uxw/E1qsYizwtNUkmNPvJC/PQmTGxaIOWaF/IGp74yiIldoGT4jbhyJTyHvrbdjD78G38fkPPUFLV4C6B5he9cgffix6gNyzQYFYgRyJgi4Qb/wU9nbrQAVVX03pDDJzqnecwFHhr8mKGKjqXjQQySWq10CAFaxyc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786453181; c=relaxed/simple;
	bh=YhegpYGBXvlvtMvotKz9BJxKuckrE8lrS5jmWk80gMo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t4XtyugasfFoTLLatONSRRqqYVAWIK+YKbwbhG+nfhHGtnxHwlv1qY8QL69Jw8YkHPmSSdbYbSdJxXl+Bhd1UwE7ZDvZ3J38YIFABrJOZSHLL5torgaYvAixMU2azfNa9t3gty8IZAId78EKf9vjOHmFrYPIYw/i0acw1Bx+Too=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id BC4F9C03D7;
	Tue, 11 Aug 2026 12:44:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 4C25530;
	Tue, 11 Aug 2026 12:44:45 +0000 (UTC)
Date: Tue, 11 Aug 2026 08:44:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: gao xu <gaoxu2@honor.com>, "David Hildenbrand (Arm)" <david@kernel.org>,
 Xiang Gao <gxxa03070307@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "liam@infradead.org"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, "linux-trace-kernel@vger.kernel.org"
 <linux-trace-kernel@vger.kernel.org>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Xiang Gao <gaoxiang17@xiaomi.com>
Subject: Re: [PATCH] tracing: report buffer memory in /proc/meminfo
Message-ID: <20260811084456.4699daf8@gandalf.local.home>
In-Reply-To: <anrPJN-V8K4fhGzZ@lucifer>
References: <20260810094025.136705-1-gaoxiang17@xiaomi.com>
	<69df3080-a719-4131-a247-62bf47bda8a6@kernel.org>
	<anm0SMuVpBz7wLac@lucifer>
	<20260810105710.6ee5e493@gandalf.local.home>
	<9bd98f51abd44d81a569d95e907070c6@honor.com>
	<anrPJN-V8K4fhGzZ@lucifer>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: wokwckj86gfnu3ccfwaiatu7kxoxoetd
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 4C25530
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19HxeI945sFhSHFXG6kqaLmhtmw1vOhsII=
X-HE-Tag: 1786452285-923997
X-HE-Meta: U2FsdGVkX1/QjJUC/xnbXiOaV/S1Xe/nUTI/+y2jkEBo7+9ZhQxZh0f+Ysv2BBzu+vo7p+MSGyQwxfM006wwHKxG+1O4q65prgZZpDF2KqMTVadlOnu4ZjfkyTTIPY0U8uEsw2lPcpQ1bV8bPeyqrfCTrG+jj/EdbXoMsPh1MOYvCRaslHcG/WJC8MY0nztbI4pRAVrWT8i6DgrcC/yobtfcd4fHvTeFy2MMVcCyi8KAgTi9fnyB4/6DJatcF/7hrYHaTg+V2K5jmJR77kgPiCDaFDyIjePLuB/rNEz8/NZDZkFUgPy82Q6Fs598C/6R/iSLMOSmCBkukzUK5n7kijLObhY1x3eQ

On Tue, 11 Aug 2026 08:34:13 +0100
"Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:


> > > Agreed. This doesn't belong in the meminfo. If you want memory statistics for
> > > tracing, I may be OK if you add a "total_memory_kb" file in the
> > > /sys/kernel/tracing/trace_stats/ directory.  
> > Would it be possible to include this info in show_mem()?
> > This would be helpful for analyzing low-memory and OOM issues.  
> 
> You have to back up requests with reasons, it's not a case of 'please add X to
> Y' and then we deign to do it or not.
> 
> Justifications are required. We could add endless crap to show_mem() until the
> CoWs come home, maybe even list the number of emojis used since last boot
> obviously.
> 
> So - why are you asking for this? Is it only a handful of KiB used for tracing?
> Is it GiB? If so maybe it's because you're doing something crazy? Why does a
> kernelfs file not suffice, etc.?

Well, it can be gigabytes. When you boot up, the ring buffer is set to the
minimal amount which is two pages per CPU. On a 4K page machine with 32
CPUs, that works out to be around 128K.

You can see the minimal size by looking at the buffer_size_kb:

 ~# cat /sys/kernel/tracing/buffer_size_kb 
 7 (expanded: 1408)

(it's 7K of data storage rounded down after subtracting the meta data per page:
  4096 - 16 = 4080; 4080 * 2 / 1024 = 7 )

Notice that "expanded: 1408"? That means when tracing starts (enabling an
event or function tracing) it will expand to 1408K of data storage.

That means on that same 32 CPU machine, if tracing is started, the buffers
will expand to 45M. That's without the user increasing the size of the ring
buffer (by writing a bigger number into that buffer_size_kb file).

Now I do know of some companies that make the per CPU ring buffer 1 GB
each. On a 128 CPU machine, that is 128G of memory used for the ring buffer.

> 
> You need to engage with the discussion and back things up rather just asking
> like you were typing into an LLM prompt...
> 
> But in general, no, it makes absolutely no sense to randomly output some trace
> information there, unless you're about to offer up the most compelling argument
> since the invention of marmite and butter on toast.
> 
> show_mem() is for critical memory information displayed at the point of OOM or
> sysrq-please-help-me, not random stats.

I wonder if it would be useful to show the tracing buffer if it is over
some watermark. That is, if the ring buffer is more than 10% of the memory
in the system, perhaps it would be good to show that?

-- Steve
