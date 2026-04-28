Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A127537A4B9
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Apr 2026 19:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777403164; cv=none; b=OG8qW69NYGhsUiszUT9VsayKvBk9FVFuGKXJQk9ZLT37xVpBf0ooZA40JBYUduedf8TJL5m5GtxVI/rrPfxNZhvkCQQ+L+0KHBADzH7Brv4b9FlfLhHwDVnbB6QGfq11QJd+BAaXiOhnNeZp6xUP15C9rDObM8Iz1/hVjDiURhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777403164; c=relaxed/simple;
	bh=EXtj03jSDONSwz7ojbd64U9/7N12tpyPL8IuZ92DU0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hr6rgPfBUO22uuF2VpZAqf3EvxsPpU1CGE6ck4hjjPsshZTV2RWX8s/2FYvzMIR4W+v9nVRMoZOXPu31ONrs4l5rZFbwfyYJ6R3TbJEg7Z8ipl984wl6fRFlYg6wL/NxySlQvfaPaMdI9a5e9Ust7/2pk5vWRdCXO24ceviF4ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XH9f1gjv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XH9f1gjv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777403162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vbo6rUbYhvVjP5B0b4LhysdFlQMM84qaqHnlVngSXo0=;
	b=XH9f1gjvAwJDlouaWfrvtdiur7amcHiFMkgUSqLXbsla0KjGS1XtIQoh7XJYcj/eyjhq6o
	NVFol8+MTppGo8ycQdFsXHcRZGts1CDkJboE73deLlrtHj6+mDEURkF5mJd9amKVuNgGGc
	pahKi1hQ3TYy+2cYh4fTJSaljV2HB2w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-oST_kWqkMKiya5LBtHs2fw-1; Tue,
 28 Apr 2026 15:05:57 -0400
X-MC-Unique: oST_kWqkMKiya5LBtHs2fw-1
X-Mimecast-MFC-AGG-ID: oST_kWqkMKiya5LBtHs2fw_1777403155
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D6A11800473;
	Tue, 28 Apr 2026 19:05:54 +0000 (UTC)
Received: from 192.168.0.21 (unknown [10.22.80.105])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E2D819560AB;
	Tue, 28 Apr 2026 19:05:48 +0000 (UTC)
Date: Tue, 28 Apr 2026 16:05:47 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>, "open list:TRACING" <linux-trace-kernel@vger.kernel.org>, 
	acme@kernel.org, williams@redhat.com, gmonaco@redhat.com
Subject: Re: [PATCH v3 1/4] tracing/preemptirq: Optimize
 preempt_disable/enable() tracepoint overhead
Message-ID: <afEE8OVPEA_UFpIF@192.168.0.21>
References: <20260311125021.197638-1-wander@redhat.com>
 <20260311125021.197638-2-wander@redhat.com>
 <20260311193503.GS606826@noisy.programming.kicks-ass.net>
 <abLzS0T_wEt_SkL6@fedora>
 <20260313090404.GK606826@noisy.programming.kicks-ass.net>
 <abQsFM9tFPr3Mrtt@fedora>
 <20260428145151.3860aa04@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260428145151.3860aa04@gandalf.local.home>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: gfRcMDP969N3U9TH2-6IyGHqGGGtX6hau3Bn9q4jjLM_1777403155
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Apr 28, 2026 at 02:51:51PM -0400, Steven Rostedt wrote:
> On Fri, 13 Mar 2026 12:36:10 -0300
> Wander Lairson Costa <wander@redhat.com> wrote:
> 
> > On Fri, Mar 13, 2026 at 10:04:04AM +0100, Peter Zijlstra wrote:
> > > On Thu, Mar 12, 2026 at 02:19:15PM -0300, Wander Lairson Costa wrote:
> > >   
> > > > > That's significant bloat, for really very little gain. Realistically
> > > > > nobody is going to need these.
> > > > >   
> > > > 
> > > > Of course, I can't speak for others, but more than once I debugged issues
> > > > that those tracepoints had made my life far easier. Those cases convinced
> > > > me that such a feature would be worth it. But if you don't see
> > > > value and will reject the patches no matter what, nothing can be done,
> > > > and I will have to accept defeat.  
> > > 
> > > If distros are going to enable this, I suppose I'm not going to stop
> > > this. But I do very much worry about the general bloat of things, there
> > > are a *LOT* of preempt_{dis,en}able() sites.
> > >   
> > 
> > We plan to enable these tracepoints in the RHEL kernel-rt to track
> > extended non-preemptible states that cause high latencies. These
> > issues occasionally surface in customer OpenShift deployments, where
> > deploying a custom debug kernel is highly impractical. Having these
> > tracepoints available in the distribution kernel would be handful for
> > debugging these production systems. That said, I expect enabling this
> > feature to be the exception rather than the rule — most distribution
> > kernels would leave it disabled.
> 
> Is this work going to continue? Or should I just change the status to
> "reject" in patchwork?
> 

Yes, I am still working on it and should have a v4 soon.

> -- Steve
> 

