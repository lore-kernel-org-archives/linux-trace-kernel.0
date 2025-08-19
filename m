Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966C01DB34C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755614323; cv=none; b=mqhTaGtwoiyxha1bQgBAE7v07mVY/mvbvGy9IjK3U4CapmEcc6J9iD5nmknUdQjyDONa/l1MwxcmU8LXJcpRXO/bM1X1lCjm3KeSsZMwNLRjiEnliFI1aroeBCvaVLs2OqsMtu5U6ts8lgkNVowqdN4Jajz3u0afzFQApu3O3Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755614323; c=relaxed/simple;
	bh=cg2kXjVsoV0pRM1swFf/4CYooxQWUROeNNhtPwxIdF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBZdslefoby09PNZJNIRvyW9gAGRfvF6B3ZAg35sFpDVTln4b4qAIcO7oWtHohHaJb7GmvfSgDeg8UgCrarNebhANymwWpKnuG/Jex075BWrfEMKq7BOzaHX7QJtQyy8l6eLZP/ozyuMBdUkJ+MPSjjUWXrA0Em9tZ8pZ+/+rIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BjKVYhxP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BjKVYhxP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755614320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPO4BKtyeVC6K3B9qpVkrs0JgUOPn4bkW5RMZGLRlx8=;
	b=BjKVYhxPsKQQS/6xFRMr1Vi2VAPJYb52A9ewCGmuTvDlHBniQmaEmsh+Xl3L1Vpr+h8bGB
	ekaEqQyXFVwQJ/Y29qWVBc1R78yvX85EeXo9mDKWf3+FhmooRjyQ7U9AZJZ/o/zhP3M0Lz
	tnTJovwEbtjxJZdo7twU5HAS7h3qJNI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-aCx41otDN--vxRg96zsBRQ-1; Tue,
 19 Aug 2025 10:38:36 -0400
X-MC-Unique: aCx41otDN--vxRg96zsBRQ-1
X-Mimecast-MFC-AGG-ID: aCx41otDN--vxRg96zsBRQ_1755614313
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 854EB1800366;
	Tue, 19 Aug 2025 14:38:33 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.44.34.10])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C8451800280;
	Tue, 19 Aug 2025 14:38:27 +0000 (UTC)
Date: Tue, 19 Aug 2025 10:38:23 -0400
From: Phil Auld <pauld@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, linux-trace-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 14/17] sched: Add deadline tracepoints
Message-ID: <20250819143823.GB282929@pauld.westford.csb>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-15-gmonaco@redhat.com>
 <aKRKaTJBxD3kdt_G@jlelli-thinkpadt14gen4.remote.csb>
 <20250819101244.GF4067720@noisy.programming.kicks-ass.net>
 <711ff45f008bb4943418c40eba604e83858767ff.camel@redhat.com>
 <aKSD3Pm_9qqmEaNv@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aKSD3Pm_9qqmEaNv@jlelli-thinkpadt14gen4.remote.csb>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111


Hi Juri,

On Tue, Aug 19, 2025 at 04:02:04PM +0200 Juri Lelli wrote:
> On 19/08/25 12:34, Gabriele Monaco wrote:
> > 
> > 
> > On Tue, 2025-08-19 at 12:12 +0200, Peter Zijlstra wrote:
> > > On Tue, Aug 19, 2025 at 11:56:57AM +0200, Juri Lelli wrote:
> > > > Hi!
> > > > 
> > > > On 14/08/25 17:08, Gabriele Monaco wrote:
> 
> ...
> 
> > > > > @@ -1482,6 +1486,7 @@ static void update_curr_dl_se(struct rq
> > > > > *rq, struct sched_dl_entity *dl_se, s64
> > > > >  
> > > > >  throttle:
> > > > >  	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
> > > > > +		trace_sched_dl_throttle_tp(dl_se);
> > > > >  		dl_se->dl_throttled = 1;
> > > > 
> > > > I believe we also need to trace the dl_check_constrained_dl()
> > > > throttle, please take a look.
> > 
> > Probably yes, strangely I couldn't see failures without it, but it may
> > be down to my test setup. I'm going to have a look.
> 
> Not sure if you tested with constrained (deadline != period) tasks.
> 
> > > > Also - we discussed this point a little already offline - but I
> > > > still wonder if we have to do anything special for dl-server defer.
> > > > Those entities are started as throttled until 0-lag, so maybe we
> > > > should still trace them explicitly as so?
> > 
> > The naming might need a bit of a consistency check here, but for the
> > monitor, the server is running, armed or preempted. Before the 0-lag,
> > it will never be running, so it will stay as armed (fair tasks running)
> > or preempted (rt tasks running).
> > 
> > armed and preempted have the _throttled version just to indicate an
> > explicit throttle event occurred.
> > 
> > We might want to start it in the armed_throttled if we are really
> > guaranteed not to see a throttle event, but I think that would
> > complicate the model considerably.
> > 
> > We could instead validate the 0-lag concept in a separate, server-
> > specific model.
> > 
> > Does this initial model feel particularly wrong for the server case?
> 
> No it doesn't atm. :-) Thanks for the additional information.
> 
> > > > In addition, since it's related, maybe we should do something about
> > > > sched_switch event, that is currently not aware of deadlines,
> > > > runtimes, etc.
> > 
> > I'm not sure I follow you here, what relation with switch and
> > runtime/deadline should we enforce?
> > 
> > We don't really force the switch to occur timely after throttling, is
> > that what you mean?
> > Or a switch must occur again timely after replenishing?
> 
> Hummm, yeah I was wondering if we need something along these lines, but
> we can also maybe leave it for the future.
> 
> > > As per the whole _tp() thing, you can attach to the actual
> > > sched_switch tracepoint with a module and read whatever you want.
> > 
> > Yeah I believe Juri referred to model constraints on the already
> > existing events rather than new tracepoints here.
> 
> Separately from this series, maybe we should put such a module/bpf thing
> somewhere shared, so it's easier to use it when needed.
> 
> 

A few of us use: https://github.com/qais-yousef/sched_tp.git

This has all the current scheduler raw tps exposed, I believe, but would
need updates for these new ones, of course. 

I have a gitlab fork with our perf team uses to get at the ones they use
(mostly the nr_running ones to make their heat maps).

Fwiw...



Cheers,
Phil

-- 

