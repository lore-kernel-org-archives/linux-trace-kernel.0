Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E963438AC;
	Wed,  3 Jun 2026 17:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506018; cv=none; b=dDWTXgGZmLJUlTd15MPiJyI3z+6LKWbzFm7/44sOItXpnOxOgYcnOmzea5SenDBUq1hB9Ko76MAqFLUd6L7Xd5Kvp8xiaDrkwq/MqSaxJJffwNhkcrbl6LQRx/uiJ6UdQObT9GGjLdzvT1VvlnlKmben/apd3JqHaXSi/tvPi3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506018; c=relaxed/simple;
	bh=GQ1OehzSGTD6ar+tznXfx876hEWfMs0AXszAzmzjHPg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kwhjr1bezgXt3UnsOJ2SNw7kHlg0ToTwXh+w3lmvdnAEEHkSyuWkalVnAZZlG+xlglhwwbVEbTCr2fU3oHrdIx+jWoSmoYHpNvqq74dZdL4DLhBrZ+A/X9SdSwAQiyKJ6otKh19/mNt5+T67fkns9jCnfD3reGARoz1XIV0XB7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id D262B1C1AAD;
	Wed,  3 Jun 2026 17:00:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id C376D20028;
	Wed,  3 Jun 2026 17:00:05 +0000 (UTC)
Date: Wed, 3 Jun 2026 13:00:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
 "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>, "Luck, Tony"
 <tony.luck@intel.com>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>, "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
 "xieyuanbin1@huawei.com" <xieyuanbin1@huawei.com>, "Lai, Yi1"
 <yi1.lai@intel.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
 <linux-edac@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mm/memory-failure tracepoint change breaks userspace rasdaemon
Message-ID: <20260603130006.7d2c4a62@gandalf.local.home>
In-Reply-To: <0c16bf3d-7c6d-4e28-b200-03b7d0ef714a@kernel.org>
References: <CY8PR11MB7134346A3E4BB28ECA28D6E989132@CY8PR11MB7134.namprd11.prod.outlook.com>
	<b930678d-a1ae-458c-8705-7ca9680d4cb6@kernel.org>
	<20260603121707.7eccb9fb@gandalf.local.home>
	<20260603161947.GBaiBUI7C8WWPwD84S@fat_crate.local>
	<0c16bf3d-7c6d-4e28-b200-03b7d0ef714a@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: C376D20028
X-Stat-Signature: 4jfbmuf17sywyyhjxdj6kkzd73mrxhir
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19xlonrAeS5YcJm5nHtKlz55w5G3g5ZuEc=
X-HE-Tag: 1780506005-423012
X-HE-Meta: U2FsdGVkX1+gk+gazx2eDsJ3XzzAwEhpCWaX29hVGZ6ozvgJF5ooRvX8OdRQrbwj3Pj+y4Kmjp63iMP+4/bN/rSH4JskNqfI8hywRJ6JCXHNTQ/ksJu53+4ulKQlhzwjnru54A4ZOjrZRjhzYf+FeYNHg9ds3CxPqCg1tqqTexOAgS0fqrCDkzWpTXr1Tdqja3dcKvR715SqbHHDJMQt6F7kHHyR0WNu+KmBpac6WbrAof85DRNVoTU+Bccrh5eR0yRVIKVTQMEZ2IiOJLNpZiVx90MfufblMJwFJboRzphURJMcKP9tWVS8G7KmdMFfHWGFktnMMEvwhnYRyyyom+X3Zp6wRb5H

On Wed, 3 Jun 2026 18:26:24 +0200
"David Hildenbrand (Arm)" <david@kernel.org> wrote:

> Yeah, I was fearing that when I read in [2]:
> 
> 	"It has become clear in the past that this promise extends to
> 	 tracepoints, most notably in 2011 when a tracepoint change broke
> 	 powertop and had to be reverted."

Technically the issue is with trace events and not tracepoints. The
difference is that a trace event is created via the TRACE_EVENT() macro
which defines what is to be collected from the tracepoint and exposes that
information to tracefs which applications can easily see.

A tracepoint is simply the hook in the code that you can attach to. Trace
events create a callback from that hook to extract the data from the
tracepoint to fill in the fields.

> 
> Which means that I now also fully understand
> 
> 	"Some kernel maintainers prohibit or severely restrict the addition of
> 	 tracepoints to their subsystems out of fear that a similar thing could
> 	 happen to them. "
> 
> Whatever the result of this discussion will be, I'll try to document it.

You can still create a tracepoint without creating a trace event by using
the DECLARE_TRACE() macro. The scheduler subsystem uses that quite
extensively. That creates a tracepoint without exposing it to tracefs. The
runtime verifier uses these hooks to monitor the scheduler.

But you can still connect to these tracepoints from tracefs via a tprobe. A
tprobe hooks to tracepoints that you need the source code to find (just
like a fprobe hooks to any function). Thus applications *can't* rely on
them because there's nothing there to tell you it exists or not.

For example, for the given tracepoint:

 # cd /sys/kernel/tracing
 # echo 't:rfail memory_failure_event pfn=pfn type=type result=result' > dynamic_events
 # cat events/tracepoints/rfail/format 
name: rfail
ID: 1894
format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;

	field:unsigned long __probe_ip;	offset:8;	size:8;	signed:0;
	field:u64 pfn;	offset:16;	size:8;	signed:0;
	field:s32 type;	offset:24;	size:4;	signed:1;
	field:s32 result;	offset:28;	size:4;	signed:1;

print fmt: "(%lx) pfn=%Lu type=%d result=%d", REC->__probe_ip, REC->pfn, REC->type, REC->result

It requires that BTF exists and the above doesn't annotate the result as
nicely. But you can get data directly from tracepoints this way.

-- Steve
