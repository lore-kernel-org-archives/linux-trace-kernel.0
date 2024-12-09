Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D972221661A;
	Mon,  9 Dec 2024 11:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742264; cv=none; b=Zk6U14GQJsSjjtfKQvoi6SMzueYuACFIQAzU9li9egfOwvr/qIl1qj7eLEaRj+JQnPy9rE/9urkr6ZpulFSMGyXC8Usg+msujvGTrsGbkm6qQGwf4bOaoX/7fUtlJHIgNvNrABkDcBuDopGl2aSE8ezjPTCc1yfICWqBw/NlRNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742264; c=relaxed/simple;
	bh=9Sd0lsx/TwXCrq5YbYdHmcrDqJ/fm1yXbjwIQSfj+NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+/OB6CMIMb/Ib1aMa/rvHmW6HwpH53R0YCMmjUPiy9OKsf440DURdYY3AuiLP1arg6b9wAhMhR2m1Q3S41XzjanVwlmy/8zwb5Qnyy9JfLUXWroZQ87ScbCokfIDrMz4BFIjZHjBxRCcCn5MDIgK5GhltXerIWW7IPUDpXW3Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YtM46qlP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YtM46qlP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z6w7NbYaS12zZFu/dPccmWnN6xSZUjRxRHiwMzPEdYw=; b=YtM46qlPP7s8AumUkd/xWcZBQk
	9QtL9eCAU/aIqfuecGiefB7kellX2CX7Gvo/7O31RQgr/NB1/7fZhRtk48E93TKMeXdlV/TVO8hHy
	jrpi8+0VXdayWHAzEA/3oMsQTWJhMYbA0IY7J/Ti2PIGDCqUbdrGQOO66wf5opD4QNgKVadWXCJF2
	+3o+cbS508nXUTRPusjEZACo84CBXrcYaJ2EbXU1fPlWLdbFC7oBjR/3QYoHt9tbWxUK3lCOvk1/1
	ViBanbReQNqUaCBdiru4iD9gsMoFSz0kb7oF5uj0jvQXgMIC3Okq4qZijA1iuQZqW7ui0K0Bhkq0V
	4SWz9uYw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKbYh-00000001Tsj-3H2Y;
	Mon, 09 Dec 2024 11:04:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0F70A3003FF; Mon,  9 Dec 2024 12:04:11 +0100 (CET)
Date: Mon, 9 Dec 2024 12:04:11 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] kprobes: Use guard() for external locks
Message-ID: <20241209110411.GL21636@noisy.programming.kicks-ass.net>
References: <173371205755.480397.7893311565254712194.stgit@devnote2>
 <173371208663.480397.7535769878667655223.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173371208663.480397.7535769878667655223.stgit@devnote2>

On Mon, Dec 09, 2024 at 11:41:26AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Use guard() for text_mutex, cpu_read_lock, and jump_label_lock in
> the kprobes.

> @@ -853,29 +850,24 @@ static void try_to_optimize_kprobe(struct kprobe *p)
>  		return;
>  
>  	/* For preparing optimization, jump_label_text_reserved() is called. */
> -	cpus_read_lock();
> -	jump_label_lock();
> -	mutex_lock(&text_mutex);
> +	guard(cpus_read_lock)();
> +	guard(jump_label_lock)();
> +	guard(mutex)(&text_mutex);
>  

> @@ -1294,62 +1280,55 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
>  	int ret = 0;
>  	struct kprobe *ap = orig_p;
>  
> -	cpus_read_lock();
> -
> -	/* For preparing optimization, jump_label_text_reserved() is called */
> -	jump_label_lock();
> -	mutex_lock(&text_mutex);

Why does kprobe need jump_label_lock and how does it then not also need
static_call_lock ?
