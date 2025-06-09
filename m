Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15642AEE1;
	Mon,  9 Jun 2025 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749485376; cv=none; b=LyV2WWRyT9/2VIkIRerMy8aAsZD9xVyCsES22KeUit+HPsYxUVxH0ebXAGeGYzSVy4/AExovcuY1p0K4jXm7iRMsfj6G3YoBlI1PK4HLVQZbeGKGKX72k3G4LC9i66Px4DxAwFkEvr5CAn02yP3lGFUnzNc4Mu3ege5CloSDw8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749485376; c=relaxed/simple;
	bh=TiigtRyHfh+ozHmASsxB2P7lifgezeH21jFNozNtlYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITHbLqlIYDXAqurnstnWCspeAbPmlOHUszYzDABv+ImUbZTi0VXjyBd7sVFitOQUJP1++ivPvlJ2dwdcJrXwANJbJAxFgU7fAL8VysH7W7w/7HGKALQgrLcvEd90gDpmrwDsGw7iRrLouQYBsDvSaGHJLguwCsLY+1AMl6fCsUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9cQL6df; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9cQL6df"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53497C4CEEB;
	Mon,  9 Jun 2025 16:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749485376;
	bh=TiigtRyHfh+ozHmASsxB2P7lifgezeH21jFNozNtlYw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=n9cQL6dfGtAM23AKcrGnHK8w57zfe8yZsQa6YUCZ+QKXqJ/pWZzhsTO87/Iy8jwbJ
	 qDAlomy96cPP+lqLZ1ADXff8ly6bBQrTLsqjxXtZD/3qoQxqozMSoDB8gAqZFo06Hw
	 qsYpANKXK7S/a1DKqUDJDN2Ug3X3M6mp2fb7BbF/zvZNdYBk/FG+6Ql+rJTYo9j8r8
	 vPNNzK9quenpjTtXeJG+a/cOxUUdj+5smpPaCp2nS80dgn4PSFvH8GLA/QYQxCNp/I
	 DfNVMxbzV0jeKkQZtjAKfeWK9u0Qqkt/nV6k1zoP3fbKMKzO2lkLmIfE4mVWEDyrdZ
	 aFHH/Xm3yLoaw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id ED284CE0B6C; Mon,  9 Jun 2025 09:09:35 -0700 (PDT)
Date: Mon, 9 Jun 2025 09:09:35 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Andreas Ziegler <ziegler.andreas@siemens.com>,
	Felix MOESSBAUER <felix.moessbauer@siemens.com>,
	Julien Flot <julien.flot@siemens.com>
Subject: Re: [PATCH v2] tracing: Fix regression of filter waiting a long time
 on RCU synchronization
Message-ID: <7468e7a2-e5f9-498c-a985-a1584969719b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250606201936.1e3d09a9@batman.local.home>
 <9a2f0cd0-1561-4206-8966-f93ccd25927f@paulmck-laptop>
 <20250609113955.47a2f44c@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609113955.47a2f44c@gandalf.local.home>

On Mon, Jun 09, 2025 at 11:39:55AM -0400, Steven Rostedt wrote:
> On Mon, 9 Jun 2025 05:21:19 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > +static void free_filter_list(struct rcu_head *rhp)
> > > +{
> > > +	struct filter_head *filter_list = container_of(rhp, struct filter_head, rcu);
> > > +	struct filter_list *filter_item, *tmp;
> > > +
> > > +	list_for_each_entry_safe(filter_item, tmp, &filter_list->list, list) {
> > > +		__free_filter(filter_item->filter);
> > > +		list_del(&filter_item->list);
> > > +		kfree(filter_item);
> > > +	}  
> > 
> > If the series of synchronize_rcu() calls was taking 99 seconds,
> > we might well be going through the above loop quite a few times, all
> > within a bh-disabled region of code.  For example, the calls from both
> > filter_free_subsystem_filters() and process_system_preds() look like
> > they can queue a very large number of entries.
> 
> The iteration is for each event in a subsystem.
> 
> Seeing what that is:
> 
> ~# for sys in /sys/kernel/tracing/events/* ; do cnt=`ls -F $sys |grep '/$' | wc -l`; echo $cnt $sys; done | sort -n | tail
> 24 /sys/kernel/tracing/events/tcp
> 26 /sys/kernel/tracing/events/xen
> 28 /sys/kernel/tracing/events/sched
> 32 /sys/kernel/tracing/events/writeback
> 33 /sys/kernel/tracing/events/libata
> 34 /sys/kernel/tracing/events/irq_vectors
> 55 /sys/kernel/tracing/events/xhci-hcd
> 92 /sys/kernel/tracing/events/kvm
> 113 /sys/kernel/tracing/events/ext4
> 724 /sys/kernel/tracing/events/syscalls
> 
> So the most loops that can happen is 724 on the syscalls plus the system
> filter. And adding in printks to count the loops, I verified that:
> 
> [..]
> [  100.019209] LOOPED 4 times
> [  100.020033] LOOPED 5 times
> [  100.020791] LOOPED 8 times
> [  100.021583] LOOPED 10 times
> [  100.022239] LOOPED 2 times
> [  100.110515] LOOPED 725 times
> [  100.111520] LOOPED 4 times
> [  100.112889] LOOPED 25 times
> [  100.114416] LOOPED 6 times
> [  100.115950] LOOPED 4 times
> [  100.117557] LOOPED 7 times
> [..]
> 
> (724 event filters and one system event filter = 725 filters).
> 
> If you feel that's too big, we could move it to a work queue.

That does sound like a bit more than would be good.

> As more system calls get added, that number will grow. But it is limited to
> the number of system calls.
> 
> All the event systems are way fewer than that.
> 
> > 
> > So...
> > 
> > > +	kfree(filter_list);
> > > +}
> > > +
> > > +static void free_filter_list_tasks(struct rcu_head *rhp)
> > > +{
> > > +	call_rcu(rhp, free_filter_list);  
> > 
> > ...why not use queue_rcu_work() in place of call_rcu() here, thus avoiding
> > possible response-time issues?
> > 
> > Or is there something that I am missing that limits the length of the
> > list passed to free_filter_list()?
> 
> Just the number of events in a system.
> 
> I could switch to a work queue but I don't think it needs to go as a fix,
> do you? That is, it can wait till the next merge window. Or is this going
> to affect things now?

Thank youi, and the next merge window should be fine.

							Thanx, Paul
