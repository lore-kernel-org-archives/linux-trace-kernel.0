Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2349223A562;
	Tue, 30 Sep 2025 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246673; cv=none; b=DKsWgfof4QZmh5XEPAw6x5NdAGCGQO59dWM+73bBsuOG+DcPXTolhtscNo4Qw+HU4NHmu3lNwgNt8ZEwroNUhgrnFDi0jehMG4CBYPOMTnlIQPPdzrdSmUzA5+LG0icQZQ23PSeDE87iCM0OD+sIUzYriSfyg1PNyfCkgUdujas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246673; c=relaxed/simple;
	bh=YEfqHcG7rtOg5roYLPENQHhUVqQRuHQbD+L94SwyPPs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hL4haRsoFR9IKeCmLCPIZW3C+nkCA4KEeYYcOBnY6bgV7JB4AK3BmhfSHP3W9K1OBoYXhu/C8xlUHH38/sdZ8PwoQPooteqSnpUUY4b9vb7MuXxDiVj15ItRfXdjb+3hQSv/4t7ORkDBb+/9vpEr8W3UM+HZyXBAooPQ7R1jSD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhMVZTD5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhMVZTD5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38960C4CEF0;
	Tue, 30 Sep 2025 15:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759246672;
	bh=YEfqHcG7rtOg5roYLPENQHhUVqQRuHQbD+L94SwyPPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hhMVZTD5fTFi2NNwHKU0GYrvfN9kk/QGy2P7l15gxwZAyA8MJTNqCfsgAWFeYwkB7
	 riEHjfLvFcUTESCvmX7x/2j2oUdxc+IUo7zxe7d/igeK810y+RLsJZv9u8uasN2O8/
	 q7J7vSin7WLJcYZJkctjrmeerw3RlHYHDyz2LIZw0EsPFg64QtQbHARfTCXmlPtOFK
	 aZWVy3RoT3R90ZwIflUBSbK9FPFDT/uiFVW7F0MiQE6C7gP2IJCWRdhO4okeBNbJ7c
	 9uy9/w7KTu3mKtxktVO6OJwnQtjrcyqg6Cz+8ZNrHjGY025PocGsi7sdys7TJKNO4e
	 V2tRL+XCZM83w==
Date: Wed, 1 Oct 2025 00:37:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: John Ogness <john.ogness@linutronix.de>, Steven Rostedt
 <rostedt@goodmis.org>, chenyuan_fl@163.com, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Yuan Chen
 <chenyuan@kylinos.cn>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] tracing: Fix race condition in kprobe initialization
 causing NULL pointer dereference
Message-Id: <20251001003747.7e987dd73076a01e9e0eb172@kernel.org>
In-Reply-To: <20250930101052.GL3245006@noisy.programming.kicks-ass.net>
References: <20250929143916.5984441b32e6f84618b4deb8@kernel.org>
	<20250929065731.1351028-1-chenyuan_fl@163.com>
	<20250929044836.7169d5be@batman.local.home>
	<84seg5d2p3.fsf@jogness.linutronix.de>
	<20250929101259.GE3245006@noisy.programming.kicks-ass.net>
	<20250930175826.52b58b7a502b215e3d226f9b@kernel.org>
	<20250930101052.GL3245006@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Sep 2025 12:10:52 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Sep 30, 2025 at 05:58:26PM +0900, Masami Hiramatsu wrote:
> > On Mon, 29 Sep 2025 12:12:59 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Mon, Sep 29, 2025 at 11:38:08AM +0206, John Ogness wrote:
> > > 
> > > > >> Problem:
> > > > >> 1. CPU0 executes (1) assigning tp_event->perf_events = list
> > > > 
> > > > smp_wmb()
> > > > 
> > > > >> 2. CPU0 executes (2) enabling kprobe functionality via class->reg()
> > > > >> 3. CPU1 triggers and reaches kprobe_dispatcher
> > > > >> 4. CPU1 checks TP_FLAG_PROFILE - condition passes (step 2 completed)
> > > > 
> > > > smp_rmb()
> > > > 
> > > > >> 5. CPU1 calls kprobe_perf_func() and crashes at (3) because
> > > > >>    call->perf_events is still NULL
> > > > >> 
> > > > >> The issue: Assignment in step 1 may not be visible to CPU1 due to
> > > > >> missing memory barriers before step 2 sets TP_FLAG_PROFILE flag.
> > > > 
> > > > A better explanation of the issue would be: CPU1 sees that kprobe
> > > > functionality is enabled but does not see that perf_events has been
> > > > assigned.
> > > > 
> > > > Add pairing read and write memory barriers to guarantee that if CPU1
> > > > sees that kprobe functionality is enabled, it must also see that
> > > > perf_events has been assigned.
> > > > 
> > > > Note that this could also be done more efficiently using a store_release
> > > > when setting the flag (in step 2) and a load_acquire when loading the
> > > > flag (in step 4).
> > > 
> > > The RELEASE+ACQUIRE is a better pattern for these cases. 
> > > 
> > > And I'll argue the barrier should be in 2 not 1, since it is 2 that sets
> > > the flag checked in 4.  Any store before that flag might be affected,
> > > not just the ->perf_events list.
> > 
> > RELEASE+ACQUIRE ensures the memory ordering on the `same` CPU, so do we still need smp_rmb() and smp_wmb()? e.g.
> 
> Eh, no, that's wrong. RELEASE and ACQUIRE are SMP barriers.

OK, thanks for confirmation!


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
