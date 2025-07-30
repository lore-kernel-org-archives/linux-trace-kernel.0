Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8DD19DF9A;
	Wed, 30 Jul 2025 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753885010; cv=none; b=tsahtaoI/KWLNFfLwjYyFsG/0Rez3R2mN3XfyFA2HqeJk/0x87XDzPS82P55nJBZhmZrlFkITp8zeK2JgTGxII+sPZ05Agm8edkfEP797ouOcoimyxRGMtfZnLVsX4mvCdHU5AyyQH44RgG5R5oTwYmZq1vxh1qfmePChlzBdc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753885010; c=relaxed/simple;
	bh=g/RQHOQBrSJi+ZvhaeL892W4Flfu2qwUEGRnSNLGsys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5azCGqszK+H5ntg4sosY6+3tv4mGBBaEZ2ASAiJuRSWdofvynCb/ibs0Ezx5H8L4u4oVXQvdrnklT4E3/khm9dF7fzdkS9cDo8fYSKmBLQ3Mhj4nGjShdGvkFOfOMtbrjTHqLZjTDFosXxEzyya/6sVxsTrKBQR47YW/DGMsyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wp9mRDcc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LuoPzYk4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wp9mRDcc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LuoPzYk4"
Date: Wed, 30 Jul 2025 16:16:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753885005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MC8rMIu7AyAkV4Xy6OW3/FsyWIw/fJOi46AIjLqjPYA=;
	b=wp9mRDccVJpDI65MUmwiSBPpVjNzjUgZ1HPKvBiZb9aG7cDdpmTRpkrZ+O2zUG8kkDzQiJ
	Ps92cXHgdAkkxAA/fGXP6mKmZQdkjqLdMKxSilqPBKJESYwbBrJ48nD5Pkr2i6fNkek1rD
	8dmuNraCdONuZ9UBDcACjbQYxcohzKhhG/NQhzHdxB0B8bU6MBqYh/JGgt5ZFmtVzp4R9H
	lhBNJ6lV7vHgGEctzNJ2OJj+44yfNdHCH1flakISvmnoIHBSs/ljowGKkfBWfhSPufVW2o
	xUHaOZ+p9afmeiLm68dOpNT5FvpgpyvuzopWMcPAzh6YoiJ/m5y8ePBxoOSDsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753885005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MC8rMIu7AyAkV4Xy6OW3/FsyWIw/fJOi46AIjLqjPYA=;
	b=LuoPzYk4JOX4E05vT3sl8/cbXc2oKAhAA5Hw6WhPBNAQAvRgC7/D9DFBBRyW5gkH2Mwgsv
	76grWZ19+XXd3QBQ==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v5 7/9] rv: Replace tss and sncid monitors with more
 complete sts
Message-ID: <20250730141643.RD-uucXa@linutronix.de>
References: <20250728135022.255578-1-gmonaco@redhat.com>
 <20250728135022.255578-8-gmonaco@redhat.com>
 <20250728155332.sbkepHj7@linutronix.de>
 <76d7e572aae2ccd1699a461aded7a6146f6d8215.camel@redhat.com>
 <20250729092510._Hq3RWF_@linutronix.de>
 <20250729093717.3AqIu_f0@linutronix.de>
 <5803d2623278c7516406534b035a641abfdecee6.camel@redhat.com>
 <20250730125224.ScWqm03r@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730125224.ScWqm03r@linutronix.de>

On Wed, Jul 30, 2025 at 02:52:25PM +0200, Nam Cao wrote:
> I do not have trace-cmd in the riscv image, but I do have perf. I will give
> it a try.

Instead, I replaced with tracepoints with trace_printk() and managed to
captured the log moments before disaster below.

I'm not sure what I'm seeing, just dumping this here, maybe you have an
idea.

Quite interesting that the last "normal" line for cpu1 is:

            test-762     [001] dn...   112.407548: da_event_sts: cant_sched x irq_enable -> can_sched (final)

But in the next error line, it mentions the "enable_to_exit". Where did
this state come from??

           <...>-1621    [001] d....   119.919846: da_event_sts: rv: monitor sts does not allow event sched_switch on state enable_to_exit

Something very strange is going on here..

Nam

            test-1198    [000] d....   112.407332: da_event_sts: cant_sched x irq_enable -> can_sched (final)
            test-762     [001] d....   112.407338: da_event_sts: can_sched x irq_disable -> cant_sched
            test-762     [001] d....   112.407347: da_event_sts: cant_sched x irq_enable -> can_sched (final)
            test-1198    [000] d....   112.407351: da_event_sts: can_sched x irq_disable -> cant_sched
            test-762     [001] d....   112.407363: da_event_sts: can_sched x irq_disable -> cant_sched
            test-1198    [000] d.h..   112.407370: da_event_sts: cant_sched x irq_entry -> cant_sched
            test-762     [001] d.h..   112.407383: da_event_sts: cant_sched x irq_entry -> cant_sched
            test-637     [002] dn...   112.407413: da_event_sts: cant_sched x irq_enable -> can_sched (final)
         illegal-1091    [003] dns..   112.407418: da_event_sts: in_irq x irq_enable -> scheduling
            test-637     [002] .n...   112.407424: da_event_sts: can_sched x schedule_entry -> scheduling
         illegal-1091    [003] dns..   112.407431: da_event_sts: scheduling x irq_disable -> disable_to_switch
            test-637     [002] dn...   112.407433: da_event_sts: scheduling x irq_disable -> disable_to_switch
         illegal-1091    [003] dns..   112.407438: da_event_sts: disable_to_switch x irq_enable -> enable_to_exit
         illegal-1091    [003] dns..   112.407448: da_event_sts: enable_to_exit x irq_disable -> enable_to_exit
            test-1198    [000] dns..   112.407459: da_event_sts: cant_sched x irq_enable -> can_sched (final)
         illegal-1091    [003] dns..   112.407460: da_event_sts: enable_to_exit x irq_enable -> enable_to_exit
            test-637     [002] d....   112.407468: da_event_sts: disable_to_switch x sched_switch -> switching
            test-1198    [000] dns..   112.407472: da_event_sts: can_sched x irq_disable -> cant_sched
         illegal-1091    [003] dns..   112.407472: da_event_sts: enable_to_exit x irq_disable -> enable_to_exit
         illegal-1091    [003] dn...   112.407481: da_event_sts: enable_to_exit x irq_enable -> enable_to_exit
            test-1198    [000] dns..   112.407483: da_event_sts: cant_sched x irq_enable -> can_sched (final)
            test-762     [001] dns..   112.407488: da_event_sts: cant_sched x irq_enable -> can_sched (final)
         illegal-1091    [003] dn...   112.407492: da_event_sts: enable_to_exit x irq_disable -> enable_to_exit
            test-1198    [000] dns..   112.407493: da_event_sts: can_sched x irq_disable -> cant_sched
            test-762     [001] dns..   112.407501: da_event_sts: can_sched x irq_disable -> cant_sched
            test-1198    [000] dns..   112.407501: da_event_sts: cant_sched x irq_enable -> can_sched (final)
            test-762     [001] dns..   112.407508: da_event_sts: cant_sched x irq_enable -> can_sched (final)
            test-1198    [000] dns..   112.407513: da_event_sts: can_sched x irq_disable -> cant_sched
            test-649     [002] d....   112.407517: da_event_sts: switching x irq_enable -> enable_to_exit
            test-762     [001] dns..   112.407518: da_event_sts: can_sched x irq_disable -> cant_sched
            test-1198    [000] dns..   112.407521: da_event_sts: cant_sched x irq_enable -> can_sched (final)
            test-762     [001] dns..   112.407529: da_event_sts: cant_sched x irq_enable -> can_sched (final)
            test-649     [002] .....   112.407530: da_event_sts: enable_to_exit x schedule_exit -> can_sched (final)
            test-1198    [000] dns..   112.407541: da_event_sts: can_sched x irq_disable -> cant_sched
            test-762     [001] dns..   112.407541: da_event_sts: can_sched x irq_disable -> cant_sched
            test-1198    [000] dns..   112.407548: da_event_sts: cant_sched x irq_enable -> can_sched (final)
            test-762     [001] dn...   112.407548: da_event_sts: cant_sched x irq_enable -> can_sched (final)
            test-1198    [000] dns..   112.407560: da_event_sts: can_sched x irq_disable -> cant_sched
            test-1198    [000] dns..   112.407567: da_event_sts: cant_sched x irq_enable -> can_sched (final)
            test-1198    [000] dns..   112.407578: da_event_sts: can_sched x irq_disable -> cant_sched
            test-1198    [000] dns..   112.407585: da_event_sts: cant_sched x irq_enable -> can_sched (final)
            test-649     [002] d....   112.407596: da_event_sts: can_sched x irq_disable -> cant_sched
         illegal-1091    [003] d....   112.410126: da_event_sts: rv: monitor sts does not allow event sched_switch on state enable_to_exit
           <...>-1621    [001] d....   119.919846: da_event_sts: rv: monitor sts does not allow event sched_switch on state enable_to_exit
            test-642     [001] d....   121.459650: da_event_sts: rv: monitor sts does not allow event sched_switch on state enable_to_exit
