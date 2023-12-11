Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BEBF9F0
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 Dec 2023 23:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAyWQ8pg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CCBC433C8;
	Mon, 11 Dec 2023 23:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702336050;
	bh=BElgQv8/npTSDU2dFL+JufzC4ciRNU6YqmHa3dc12DI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pAyWQ8pgDKHPBv3dj1xjaMrnr2k+U0DA1EpGk7u6/znbiQgAeXsuvQaAMXDMoYA/z
	 Xee5VdIeb2OOw460rxC7hL2YxgyXKySTqpi7/hED543BFBQX4d6iLrnt3u6WZWRsVC
	 Ykr71wo0h+38RSKjrF0Rg0ejIoTfzmX5Vpce71u4PPTdX21Xqkd+HAlwUKh/jE21gk
	 o9BwHHBvs8w15PZC4Yx9y+7h+6yW5sUzkUqVUs0cBoyjLT6Wku555G0l72D08YG28p
	 i5X1M7TNN1vvX+cuMG4wfd+ocZyd6NjMXq+N/ZFyyDIm3Xcsg+wfxiZxNxIxkddDez
	 yuWFhFuWtY6Mg==
Date: Tue, 12 Dec 2023 08:07:26 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] trace_seq: Increase the buffer size to almost two pages
Message-Id: <20231212080726.a8d1f614e65c3b49ff1d9fbd@kernel.org>
In-Reply-To: <20231211132837.24488ec1@gandalf.local.home>
References: <20231209175220.19867af4@gandalf.local.home>
	<20231211214627.cff4ecfead14029ef22cd3ef@kernel.org>
	<20231211132837.24488ec1@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 13:28:37 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 11 Dec 2023 21:46:27 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > 
> > > By increasing the trace_seq buffer to almost two pages, it can now print
> > > out the first line.
> > > 
> > > This also subtracts the rest of the trace_seq fields from the buffer, so
> > > that the entire trace_seq is now PAGE_SIZE aligned.  
> > 
> > Ok, but I just a bit concern about the memory consumption.
> > Since this is very specific case, can we make it configurable later?
> 
> I was concerned about this too, but it looks like it's allocated and later
> freed in every location except for a couple of instances.
> 
> One is "tracepoint_print_iter" which is used to pipe tracepoints to printk.
> I think we can possibly make that allocated too.
> 
> The other is in ftrace_dump, which I don't think we can easily allocate
> that. Although, we could have it allocated at boot up if
> ftrace_dump_on_oops() is enabled.

Can we reallocate it when we detect such bigger event entry in the path
of trace_marker write? If any issue happens in the reallocation, we will
not finish (commit) such big event in dumping buffer anyway.

> 
> Another KTODO?

Yes, I think so.

Thanks,

> 
> > 
> > Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> 
> Thanks!
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
