Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D22529A9C3;
	Tue, 24 Jun 2025 19:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750793493; cv=none; b=WCUeQWZZi9tY18hhV4R4yox6s/Rsrt0fqpDiQSSCBELMhyU0w4mg6v5bKv2BDEzS+8aoB2nqyPNXFnngVRAYqD/t18tBosFyKxCEfn+cIF5dgtHzV69IYerr8eqSOqUKwvM5Fujy7SJ1ltYLv9UoZ2uG0qYXlLXJvBytY87b0ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750793493; c=relaxed/simple;
	bh=gANlxRF2zdP1sktj1/IctJiz1DtjRXxYfySJYboqpfI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OrTBLvW/vTOSz7TarSNO/6LJbZXD1Pbk+i1t267D5xwTLTv8B+l/pmBcPxWxKSizXNtaW+Fr69TWFhfzO1HRnoTDB3xrjRpt0ASON32MYds8B0yLDAWNKBJswO0jQ62esltdaPpXhw5FzYlToJ9coQj90UagWmChfWbuC9YrXe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 22750809C3;
	Tue, 24 Jun 2025 19:31:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id B26872000E;
	Tue, 24 Jun 2025 19:31:26 +0000 (UTC)
Date: Tue, 24 Jun 2025 15:31:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tomas Glozar
 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
 john.ogness@linutronix.de
Subject: Re: [RFC PATCH v2 09/12] rv: Replace tss monitor with more complete
 sts
Message-ID: <20250624153125.56eab22a@batman.local.home>
In-Reply-To: <20250624155053.wOoDw8ff@linutronix.de>
References: <20250514084314.57976-1-gmonaco@redhat.com>
	<20250514084314.57976-10-gmonaco@redhat.com>
	<20250624073609.OA9Q1V4g@linutronix.de>
	<e2b2e78a9c66973d90a9dbeea83b88b97182c36e.camel@redhat.com>
	<20250624155053.wOoDw8ff@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B26872000E
X-Rspamd-Server: rspamout08
X-Stat-Signature: cdk5t6dxj7s4h9hnmwxmiguqxgs4kmkr
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19xx8Qq6pIitKLQlSLGjZW19IMlUGEbQ1g=
X-HE-Tag: 1750793486-273157
X-HE-Meta: U2FsdGVkX1+cxL1G8r9Css4NkKaN4UGBNh6NjBEhfGXBFHGvLXob/QbsmCDysyoHkmBOyfFsbsw4dmsD1tR69OVfx+BTlGCNAPrA1Od+cy+oVsTbkUN6TFcFAwuPkl8hkjCJ7YwBRxcjzLkV1U54PJp7OKOFGPFM0ut2VXA2HZqV53DgjzJKn7g5cxgUXzvfKrQX5sWBVFwj3hr/hwCtUAcn8wjVqgcpXLcNgETcmpq5sq0pPhu03GmAp3SRoRTkEDJcw6bSf6Za4uzKBPJTcfAmMWfA5nsJpRkAu3STHGIKwLq+2jut/INlHOI7cLWHMTmbkebrn+vdIheFY/o+SK4Ub5QMp3rsvWKYUkFQmBz/X7srUtpkqTvO4+nQKQOhdJmJcLBSa9+LP54VJNuYqQ==

On Tue, 24 Jun 2025 17:50:53 +0200
Nam Cao <namcao@linutronix.de> wrote:

> I would like that. Ideally, the userspace tools only use tracepoints based
> on available_monitors.
> 
> However, people may not do that, and just use tracepoints directly.
> 
> You could argue that those tools are not correctly designed. Therefore it
> is their fault that the tools are broken after updating kernel.
> 
> On the other hand, there is this sentiment that we must never break
> userspace.
> 
> I don't know enough to judge this. Maybe @Steven has something to add?

So WRT tracepoints, it's the same as a tree falling in the woods[1].

If a user space ABI "breaks" but no user space tooling notices, did it
really break?

The answer is "No".

As for tracepoints, its fine to change them until it's not ;-)

We had only one case that a tracepoint change broke user space where
Linus reverted that change [2]. That was because powertop hard coded
the addresses to the tracepoint field offsets and didn't use the format
files (what libtraceevent gives you). And I removed an unused common
field, which shifted everything and broke powertop.

But I converted powertop to use libtraceevent, waited a few year until
all the major distros provided the new powertop, and then I removed the
field. Guess what? Nobody noticed. (And old powertop would still break).

BPF taps into most tracepoints that change all the time. I'm cleaning
up unused tracepoints which included a couple that were left around to
"not break old BPF programs". I replied, if an old BPF program relies on
that tracepoint, keeping it around (but not used) is *worse* than
having that BPF program break. That's because that BPF program is
still broken (it's expecting that unused tracepoint to fire) but now
it's getting garbage for output (that being no output!). It's worse
because it's "silently failing" and the user may be relying on
something they don't know is broken.

So yeah, change the tracepoint when the code its tracing changes. That
way any tooling depending on it, knows that it can no longer depend on
it.

Anything using tracepoints are pretty much tied to the kernel anyway,
and when the kernel updates, the tooling that is relying on it also
needs to be updated otherwise it's not getting the information it is
expecting. That most definitely includes monitors.


-- Steve


[1] https://en.wikipedia.org/wiki/If_a_tree_falls_in_a_forest_and_no_one_is_around_to_hear_it,_does_it_make_a_sound%3F
[2] https://lwn.net/Articles/442113/
