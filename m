Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD509140E50;
	Fri,  4 Oct 2024 09:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728035956; cv=none; b=R0sUSK+60eCqcbVldIlK6jLVYUWf61BGHklzvVtFXZrWBRQyjsoOE+34BQc43dQ+DbSrt6cmwAwLOn1o21KjC52/otKsrrd4Ln00QaAVhW8cz6lZacwFq+2qasJY1lT2BTwE91V3vk29ajBy8AYMEWDWi2PX4CuRzYVUJiQ+iTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728035956; c=relaxed/simple;
	bh=8dHOrYMbrQSbyQZH+soc9ql3Bdz4W/Wgei0LBQoKOjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFHKGTzlAroUcExovhcUudOnares0gHdMgA/AX8UtnRI19iXBviXy+93BgjF3cs0hremNr913puZUwOQQV8EUMFdYUHvVmHIQEgeD93s5odlsBzDBC3JOvGRGZ6UTRIY4UYGiyz/m44W/8Ag/KK56uV66Y9s/+RwELp3YJWgK3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wAVPwWiG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wAVPwWiG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J8iuKLc8E2H5aZPka9pLueUIzyPDQ5S46BditoB9yUc=; b=wAVPwWiGC6wMsh4MmvG/zYi0J0
	w5lUC7+zwV1x7U4R11lQIhb/oEMSWHBHkpqbTDRMwYFSxZ7HEwsiqXapiA3Sy4hB3xj3mqQ7mltPd
	xjRYS2if5UPJhLBJnMGR3MmvsF47OFtBTtLFkEwrZ3b124WqKihGkZ/Dg81YYMRQ3xCSv3JIddVuv
	8lSoyWNWbX0F3ryT+F+PQ+77YjhIeNnlBO4cP1ibQfO7V2lDWaaKEZ2XETbXFzZCeP96lBBO8OkLP
	Jw3sRBAKqznuq/aOAvg85MmzRGOaovmpojWATa5yDNyudIxbZeVXw+P4yeEfk/8KSDFbN4G2JDqYD
	Rj2HN1sQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1swf5X-0000000A7jR-0HrG;
	Fri, 04 Oct 2024 09:59:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5292F30083E; Fri,  4 Oct 2024 11:59:07 +0200 (CEST)
Date: Fri, 4 Oct 2024 11:59:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2] tracing: Remove definition of trace_*_rcuidle()
Message-ID: <20241004095907.GL18071@noisy.programming.kicks-ass.net>
References: <20241003181629.36209057@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003181629.36209057@gandalf.local.home>

On Thu, Oct 03, 2024 at 06:16:29PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The trace_*_rcuidle() variant of a tracepoint was to handle places where a
> tracepoint was located but RCU was not "watching". All those locations
> have been removed, and RCU should be watching where all tracepoints are
> located. We can now remove the trace_*_rcuidle() variant.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---

W00t

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
