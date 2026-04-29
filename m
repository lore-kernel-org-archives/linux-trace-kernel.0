Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8A4329C66;
	Wed, 29 Apr 2026 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777478199; cv=none; b=tik2hIA/HeEX5AAJFgcaqfqE0q9F3wmC/swlhk0NdJpbbjt1ADHOjK8Qi9/XjwkbgkbTx3FAKhN8RY14zEJCgWx0Y4XCgs5tkigOtOQrotKRy9+KK8DEjmV829XJwt7M95K9SdK5oJd38oh8AVqnsKGZrW1UOZTo85b8PlgK5uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777478199; c=relaxed/simple;
	bh=pqIbsxN/EwcJBeoV9NPnm7E2TV7unU5nHJekgs7X/fM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AWesLLlBSGSI7jgGfKHnt6zYXzq2Z3aaaf3846DmONjUEGHYO21YZmWbpjVUffZG5KNcdbGHhx1CWv2l7f52e7ijOHdZjuubE3dVJuxljCihpLGJGfdOsyG9ZUppfRp3kaZQgZX1eqhJCbLbmXtjmC2JOssf9ydTu8BEQP/dU7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 2C0E61B92D6;
	Wed, 29 Apr 2026 15:56:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 0054920032;
	Wed, 29 Apr 2026 15:56:27 +0000 (UTC)
Date: Wed, 29 Apr 2026 11:56:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shijia Hu <hushijia1@uniontech.com>, naveen@kernel.org,
 davem@davemloft.net, ananth@in.ibm.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: Remove dead child probes from aggrprobe list
 on module unload
Message-ID: <20260429115645.793f15ea@gandalf.local.home>
In-Reply-To: <20260429174053.b66f3a0032408f544128afd4@kernel.org>
References: <20260429032919.208790-1-hushijia1@uniontech.com>
	<20260429174053.b66f3a0032408f544128afd4@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ahihr74x1n8k55th8a1oihcpq4x39fy3
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 0054920032
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+RdtdRScI0xd+b53wofa9S9aEogKv7eQ4=
X-HE-Tag: 1777478187-618838
X-HE-Meta: U2FsdGVkX1/XyZmBda+DuqDwrCAnPyCXkUOeJamj3seLp8Gjh03aDXvIAAJ8jh84FSAXKMCkkfj0rdsCsgWqhbUXzqaSZCM/e2SSOxf1RflzeTmI4UO/dIo/oKULmqU272Pi4H0QqXpxZlfKSFARz3Qmw3xsBOddCjCTke3W6dipvOUJoFCiIc4Wq4r7FGe6PtTfwpFlYVpXHPGm4pl5G5rlRPJsj9h7STUi0FFO1kF3M/iP86yMQ0ZOIJKqg3MElNKbBMj2I/WDh7QmtvNMsm6Ui3I9DNKi/ufDQuADr1ToyNwrk2lzhk1ck47331wTQH5MvAh4hZw/raWuE28MbgaOLznnGcvVEFC04ccojqPJGtH78m/US1aIYBlFQVWs5qEGHV3S25U0CHmdPOrhDA==

On Wed, 29 Apr 2026 17:40:53 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Shijia Hu <hushijia1@uniontech.com> wrote:
> 
> > When a kernel module that registered kprobes is unloaded without calling
> > unregister_kprobe(), kprobes_module_callback() calls kill_kprobe() to
> > mark the probe(s) GONE.  If the probe is an aggrprobe, kill_kprobe()
> > also marks all child probes GONE, but it does not remove them from
> > the aggrprobe's list.  
> 
> That sounds like a bug in the module.

Agreed.

> 
> > 
> > The problem is that child probes whose struct kprobe resides in the
> > unloading module's memory are freed along with the module, yet they
> > remain on the aggrprobe's list.  Later, when another caller registers
> > a kprobe at the same address, __get_valid_kprobe() walks that list
> > and dereferences the freed child probe, causing a use-after-free.
> > 
> > Reproduction steps:
> > 
> >     1) Load module A which registers two kprobes on the same kernel
> >        function address (e.g., do_nanosleep), causing them to be
> >        aggregated under one aggrprobe.
> > 
> >     2) Unload module A without calling unregister_kprobe().
> >        Module A's memory is freed, but its two child probes remain
> >        on the aggrprobe's list as dangling pointers.  
> 
> Would you mean "load a buggy kernel module and unload it, the kernel cause
> use-after-free."? for example:
> 
> ----
> struct kprobe my_probe = {...};
> 
> init_module() {
> 	register_kprobe(&my_probe);
> }
> exit_module() {
> 	/* do nothing */
> }
> ----
> 
> Yes, this cause UAF because that module has a bug. Please call
> unregister_kprobe().

Yes, this is one of those...

  Patient: Doctor it hurts me when I do this
  Doctor: Then don't do that

... reports.

No, the kernel isn't responsible for fixing buggy modules.

-- Steve
