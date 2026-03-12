Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D153D8102;
	Thu, 12 Mar 2026 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773329894; cv=none; b=BYnGQRMMksmlQYZWYmcoeAHKhuP5Y9AdfepbZgN51zgDu4YyfNFI4vPUhcesSmI2eTBLmk9cOuVqaFZGdEpUS79jCl2L+t4+Ur77EUjDDb9JArCsJfUhIGDg/kYM0vrmdRho2+IWe+AwYjMmb3cfqNRZCI8HSLDvG1ep5ndYOus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773329894; c=relaxed/simple;
	bh=PR/f1n7uG57qlvm/xk14YeoZjXYQZnOzLHH28xdutTE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nvPjpdWiq9hR4DbyOl+puGRyz2ubcaLc013pYHeqLVxhwjJ31O3PNjpyZI9Hdec8BHm5DpAoaYtGy4NyzIJnEllgKFPz6OHtJ4xiehBSyuUIZZXITvzpKLraK3kEJrJYg/R2CDcezh9fmrE0OW1wCf3GpKxIYO+no9mDikWv1Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id A62055820E;
	Thu, 12 Mar 2026 15:38:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id B18AD2002C;
	Thu, 12 Mar 2026 15:38:02 +0000 (UTC)
Date: Thu, 12 Mar 2026 11:38:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Keith Busch <kbusch@kernel.org>
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>, Peter Zijlstra
 <peterz@infradead.org>, Jens Axboe <axboe@kernel.dk>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 03/15] io_uring: Use trace_invoke_##name() at guarded
 tracepoint call sites
Message-ID: <20260312113816.01de2b53@gandalf.local.home>
In-Reply-To: <abLapcC7YGYDyJ3L@kbusch-mbp>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
	<20260312150523.2054552-4-vineeth@bitbyteword.org>
	<abLapcC7YGYDyJ3L@kbusch-mbp>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B18AD2002C
X-Rspamd-Server: rspamout06
X-Stat-Signature: ydjzwf5dpd4o6ggwojmqg8uzfsd7tgre
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19GYtGsO1dCswyGmSJxcmkqX4fLSPUIpq8=
X-HE-Tag: 1773329882-287988
X-HE-Meta: U2FsdGVkX18K7qiQD/6Xfxb0oECS8YNphCvdIFtE4W697E3JZrq5sCtXkBUFLj5HVywLNM5V12eNs6VYSo4DU8pbQWHqQJzFhKKzp0xbsubxSLYXVUZPcB/XmneTwQ6yPsmwmncU+XF9IaxOs2jozDpABWgZpNnRWRr/SxuCv1wRL/Wc371RyFwQHMlxrsft4DMUgmpDDjFEpZZIuIwzPDMxlaV+pIFOwBxo1G/NoqGfw0RfY4Y/B++oQAV2oLAB4WoGD+2ioQHyWuOG24fOA7mT1Td5OXozshyqh7BoQZFr+vzPxdZ+ahwBp2a8A2oQkTGpJ7auyOm/qKsX8ned0DeZiEQmKGGc

On Thu, 12 Mar 2026 09:24:21 -0600
Keith Busch <kbusch@kernel.org> wrote:

> On Thu, Mar 12, 2026 at 11:04:58AM -0400, Vineeth Pillai (Google) wrote:
> >  	if (trace_io_uring_complete_enabled())
> > -		trace_io_uring_complete(req->ctx, req, cqe);
> > +		trace_invoke_io_uring_complete(req->ctx, req, cqe);  
> 
> Curious, this one doesn't follow that pattern of "if (enabed && cond)"
> that this cover letter said it was addressing, so why doesn't this call
> just drop the 'if' check and go straight to trace_io_uring_complete()? I
> followed this usage to commit a0730c738309a06, which says that the

You mean 'a0727c738309a06'? As I could not find the above 'a0730c738309a06'

> compiler was generating code to move args before checking if the trace
> was enabled. That commit was a while ago though, and suggests to remove

It was only 2023.

> the check if that problem is solved. Is it still a problem?

We should check. But also, tracepoints should never be in a header file.
That really should be:

#include <linux/tracepoint-defs.h>

DECLARE_TRACEPOINT(io_uring_complete);

[..]

	if (tracepoint_enabled(io_uring_complete))
		do_trace_io_uring_complete(...);

And in a C file, that should be:

void do_io_uring_complete(...)
{
	trace_inovke_io_uring_complete(...);
}


Which reminds me. There's other places that have that tracepoint_enabled()
in header files that do the above. The C wrapper functions should also
convert the callback to the trace_invoke_<event>() call.

-- Steve
