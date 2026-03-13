Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451A2282F29;
	Fri, 13 Mar 2026 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773392654; cv=none; b=ml1wPMCaIl4a9DA/tCVx6vK58QfkV2O846pqbxEyucCmb8eCDbCC2j+9HNN5eEEkNCf2eo/T6S4P9YtaoduKvrAcoiVu9IlLo5Q48Lzf3a/WBW+A4okMi/Wvc+g/Njo6KARk/1nZIM3o/lxxjIBSVRarxL1/BsEevFztXGJnfKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773392654; c=relaxed/simple;
	bh=c+OSf/n7cv+nTPecTTUs7Q+tlQmVPSGxqpjCqI33uvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0+HILwFsfdNEIJhlmlLl3D7GOvSiRZMk/p+76hyqVUS5ugYK4kcoyTlS6BlnCTKR8djCWzvPDy+cqswrPr2e6ApurmP7EJskDhDa5wDEinPVADycvt4an51fWXZyxyWFx9mR/Z2jhDGwvsU3lb20FyYmijVRDrirzC6yr0QKck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VZFOvesL; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VZFOvesL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d1in1LivxTygelDpc3fvkaUshdJL6JIxUbijl840uK4=; b=VZFOvesLG6nkg1kFS3VbjoA+Wz
	T5YsDZWXmHoe460Sg+5KJ3KO5MVFk/DBzkio4BAcw3ZHm6bsUQUqwISJYcRFbyLVJ0Z4nkGsGN1nj
	Q/LP/C6Ndh0gaG3e0vwidAnwQYJ5tR+m/v6WTDG9ut1eFqTcIPQs4z9/YMQ3wAAol2Z/mwosgBZXu
	HpmWaJt3kVN61cRcTkpTW+S/0gVzGPudPsZuGXUX27gqZg1WEp98VOLRcs7A+dwZCpU18eqmgdU+o
	A7GvpoETAaC12ale4lP0kYur2IPkVVzfjBc7kGoVK02nRQ7IH1nAUr2bsiCGcU2/GLJV7BZgzNx2D
	5L1ZcYxA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0yRB-00000002v19-1KHi;
	Fri, 13 Mar 2026 09:04:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C985A300FB6; Fri, 13 Mar 2026 10:04:04 +0100 (CET)
Date: Fri, 13 Mar 2026 10:04:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
	acme@kernel.org, williams@redhat.com, gmonaco@redhat.com
Subject: Re: [PATCH v3 1/4] tracing/preemptirq: Optimize
 preempt_disable/enable() tracepoint overhead
Message-ID: <20260313090404.GK606826@noisy.programming.kicks-ass.net>
References: <20260311125021.197638-1-wander@redhat.com>
 <20260311125021.197638-2-wander@redhat.com>
 <20260311193503.GS606826@noisy.programming.kicks-ass.net>
 <abLzS0T_wEt_SkL6@fedora>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abLzS0T_wEt_SkL6@fedora>

On Thu, Mar 12, 2026 at 02:19:15PM -0300, Wander Lairson Costa wrote:

> > That's significant bloat, for really very little gain. Realistically
> > nobody is going to need these.
> > 
> 
> Of course, I can't speak for others, but more than once I debugged issues
> that those tracepoints had made my life far easier. Those cases convinced
> me that such a feature would be worth it. But if you don't see
> value and will reject the patches no matter what, nothing can be done,
> and I will have to accept defeat.

If distros are going to enable this, I suppose I'm not going to stop
this. But I do very much worry about the general bloat of things, there
are a *LOT* of preempt_{dis,en}able() sites.
