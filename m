Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E550E1482E1;
	Fri,  4 Oct 2024 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728036261; cv=none; b=Atkfb4jN9mR/CzIiB4cHUh3dXuYnNFjMlbBy3ntOX3QE6S8HHiVuhPtLYjx1nppYDdl5CNy0FXZfLMHqk0BZ2IhZpsynZiEiXKkQku6qcccs6A55JmaD5c7+FLED5o6xsuJoFJEPNAqDkS32prCKOOFD4aQvnMPgZ53hh4O7CYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728036261; c=relaxed/simple;
	bh=qN/eJn4Pirir29JZzvANdMFmYnfZiW6w+vCXfNiKdEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRRxuuSeDPpLns9ShCRvt7Cba3+f7ZlQ2d0KE7NkxjyZFHi1AMrB/0ZoMFINuXPDvO2w+cbissQWnenB8NpqHFFEK34kMdARHbtMYhpWfZe6kcr7zvqwA/Bx3iJ8xCPkhOZSyhTtFhlO0tlGdQhG2sLr/YwevrPt3bsh6LLG0AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j5MWeWeu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j5MWeWeu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+BqI/9/ZiDN0/J5cE6AuUCWowLXJdtdoUMniEvzx5bU=; b=j5MWeWeuMPglXx4G6eSd6b9Ng0
	Epu/TlV6yYXcvfH3588Ed+OGnDqE5mlxI5fBENvSKgroHW9Ib3m3uzlHDB9avZJsXqh02U8LZtxex
	H+iT6DaPr+93pCeC0OV9JocWcpEDPpgOfquKrToOWl1pP9e/fVvYImgIG7RcsoVfcbKTROeyToXLR
	Oz6Q/MBRCVo6o94CqV5yApNorLTwWcVa0NOH9YBOYfAUmXyvgXjQGHpqYARfSc5QmeJh8YgrE4+g0
	ol3Lz6jcyaIkXoNZRCppKCJ1YDPl0/qkitF9GlrvYQpPZa7RFMys9R0gfKzJjTaprvvNeuYJm6QKG
	JQRyAYEw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1swfAR-0000000A8XJ-3jYT;
	Fri, 04 Oct 2024 10:04:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1F84130083E; Fri,  4 Oct 2024 12:04:12 +0200 (CEST)
Date: Fri, 4 Oct 2024 12:04:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH] tracepoint: Remove SRCU protection
Message-ID: <20241004100411.GN18071@noisy.programming.kicks-ass.net>
References: <20241003184220.0dc21d35@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003184220.0dc21d35@gandalf.local.home>

On Thu, Oct 03, 2024 at 06:42:20PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> With the removal of the trace_*_rcuidle() tracepoints, there is no reason
> to protect tracepoints with SRCU. The reason the SRCU protection was
> added, was because it can protect tracepoints when RCU is not "watching".
> Now that tracepoints are only used when RCU is watching, remove the SRCU
> protection. It just made things more complex and confusing anyway.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---

Nice!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
