Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DCA36405A;
	Wed,  1 Apr 2026 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775075149; cv=none; b=AhJXWKr1KjLAaCDEFZbfGXxE+NVg5Nlb/Qbq6LDRwzJpD+Iu1ia7qGBguLmWGSKJA6ibv+ZRtZJC0AYvFwy8WeMxoiGoiP3aKGWaAJX2gCDIoEkmygFEgGqYuRHSj518SzKYHCVEl9WXhCTPN/HgxeG8Ts2Zzcc1XaI0M3+01eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775075149; c=relaxed/simple;
	bh=aip0lYMxSY0eZkohJjpofiyP8PHfh5rPTkWIcdjD6gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEiiK9NS89IKyzysqiu+09Xo0ngB5r8gmRSzy5BE+VhXj6hf+xlGCFynHFERGhrlTuURaEe8nLnMK8fWD1czOx+0WYVNn5kGIiz6v1ZLzAeKPaFQ4WEZl4ZNcGKUmJkQfEEgyYVsNkLdYCWwRCnbDXkJBegkF8/s0PgfdVPM4kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BB5J8mD4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BB5J8mD4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GM7SuvrcxV0B9vUZwK/Ars0C8bRP+ejExO65ydNuQz0=; b=BB5J8mD4qSo9sx8nNobrY6mI/p
	KXo7HddaqQGxW3USM2lBg4KswZDUFMximAvHtHLDjWhpJFRtbNON/evkQuXesyyQrR+7gsNG6FzUf
	wshrvRjwyI7GBmWxCwCibRaVPbNrd5nZfhJwZgLOKQ2LQTlCTgSe9PpaQVwqHmPp7RCIMdoo/Zdym
	Ih5zLgXPvFvREqnMyG/zfTCyYRA4j4Hy2KHur4QJYD0Z2FdYKyRyAPajvxoJjZrf72NfKXJnHoR7e
	1ArrfDzF1PAsLoMA5HvCXDPrMurC19RfvbvRZA/KjoEVkOqy8vRFVunXYGJINUhtX1rJa8be0LXNh
	eyGOkf0Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w828E-0000000AzIE-3Sfw;
	Wed, 01 Apr 2026 20:25:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E267430301D; Wed, 01 Apr 2026 22:25:41 +0200 (CEST)
Date: Wed, 1 Apr 2026 22:25:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brian Geffon <bgeffon@google.com>, John Stultz <jstultz@google.com>,
	Ian Rogers <irogers@google.com>,
	Suleiman Souhlal <suleiman@google.com>
Subject: Re: [PATCH v3 0/3] tracing: Read user data from futex system call
 trace event
Message-ID: <20260401202541.GB3254421@noisy.programming.kicks-ass.net>
References: <20260331181349.062575155@kernel.org>
 <87zf3m7a0o.ffs@tglx>
 <20260401161919.147355bf@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401161919.147355bf@gandalf.local.home>

On Wed, Apr 01, 2026 at 04:19:19PM -0400, Steven Rostedt wrote:

> Well, it would be updated for trace-cmd not tools/tracing.

So I tried using that a while ago:

  https://lkml.kernel.org/r/20260116181524.GF831285@noisy.programming.kicks-ass.net

and I found it really rough.
