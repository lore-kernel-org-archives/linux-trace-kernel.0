Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491253B634F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773416188; cv=none; b=QqiFRQOcB7djxlEXBJpTBETHBQ51t/QIEp+pb2jC9WB1SgUdj8jw2IJL/4AhttYm+CKskcsWR72ipPIu49fEiOZlDhxMpFOCawbPNcLb5xJtRQhr6wuXkBegnf9VugKQHlZdlOJyffho79dgnNoJH4wc58pxwbsF/0BMv42GMPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773416188; c=relaxed/simple;
	bh=CyCGUMD3VoVbcPs264yI0PvIDuyg8kPmxW1bTL+plGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ccj70w6j31aQtfJS6aCkjc6Br+STJUQQaFSWEQdh8tD6on4VECc2SpDvVqQzPd/CZsbiMdst6ibdjJdXTbc5CKLfDWlBd7wCukIB+Xmkkx0c4ohmHxvzD936GNiSBFVr1l8a/vqhkIDK8JkZZffIwWXEpCA7QnujZpJvOuL2Yhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fNZaqAej; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fNZaqAej"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773416184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8YOawQNVQkIo70h92e1d8c2a75rIGeMZJhaqZP76hJU=;
	b=fNZaqAejtdyhlX0lj4oX+VZOQHEGLGGVbg1wjLz3q2FJSSH1Fzg7wyY/tQZTXZt362mx62
	0kKmNGYS0Iu3kyKH9XnrNRY1Qe6fZZaXMFNEH3FoiMGfb/MC3K2fd9Lo19yrbfvOa1ctRs
	qxqWTPujIk+3hPMQoZzyieLtEetkhEQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-r3Sdx55OOqOtQwgAUmxByQ-1; Fri,
 13 Mar 2026 11:36:20 -0400
X-MC-Unique: r3Sdx55OOqOtQwgAUmxByQ-1
X-Mimecast-MFC-AGG-ID: r3Sdx55OOqOtQwgAUmxByQ_1773416179
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67509195609D;
	Fri, 13 Mar 2026 15:36:18 +0000 (UTC)
Received: from fedora (unknown [10.22.81.255])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 10B6E19540C2;
	Fri, 13 Mar 2026 15:36:11 +0000 (UTC)
Date: Fri, 13 Mar 2026 12:36:10 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>, "open list:TRACING" <linux-trace-kernel@vger.kernel.org>, 
	acme@kernel.org, williams@redhat.com, gmonaco@redhat.com
Subject: Re: [PATCH v3 1/4] tracing/preemptirq: Optimize
 preempt_disable/enable() tracepoint overhead
Message-ID: <abQsFM9tFPr3Mrtt@fedora>
References: <20260311125021.197638-1-wander@redhat.com>
 <20260311125021.197638-2-wander@redhat.com>
 <20260311193503.GS606826@noisy.programming.kicks-ass.net>
 <abLzS0T_wEt_SkL6@fedora>
 <20260313090404.GK606826@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260313090404.GK606826@noisy.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: uQJ7m3B_z_5UIhUaBNEwqhp2h8nqxKN4eif711RZpaA_1773416179
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Mar 13, 2026 at 10:04:04AM +0100, Peter Zijlstra wrote:
> On Thu, Mar 12, 2026 at 02:19:15PM -0300, Wander Lairson Costa wrote:
> 
> > > That's significant bloat, for really very little gain. Realistically
> > > nobody is going to need these.
> > > 
> > 
> > Of course, I can't speak for others, but more than once I debugged issues
> > that those tracepoints had made my life far easier. Those cases convinced
> > me that such a feature would be worth it. But if you don't see
> > value and will reject the patches no matter what, nothing can be done,
> > and I will have to accept defeat.
> 
> If distros are going to enable this, I suppose I'm not going to stop
> this. But I do very much worry about the general bloat of things, there
> are a *LOT* of preempt_{dis,en}able() sites.
> 

We plan to enable these tracepoints in the RHEL kernel-rt to track
extended non-preemptible states that cause high latencies. These
issues occasionally surface in customer OpenShift deployments, where
deploying a custom debug kernel is highly impractical. Having these
tracepoints available in the distribution kernel would be handful for
debugging these production systems. That said, I expect enabling this
feature to be the exception rather than the rule — most distribution
kernels would leave it disabled.

