Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F403A1681;
	Wed, 10 Jun 2026 08:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781078435; cv=none; b=bAlkSOLGtBuexdrtAs/UOue6UKtyQCHPkAaG3+/PWHn6UMq2xoDBF2s9oPxFm4wU/2XCpNbEueZDT8G6Rx96s0GZudCJJbdC0W8VoqpEJIXVcordeo9OUCcAWhnM+n+I4TfUeSxzDYFrGOojaEODzRnxjMUkT/jvySiI2fkwcUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781078435; c=relaxed/simple;
	bh=KPgqQlmqP114rXQuQuPq237douBQpWHdEQknijsksXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0nZQUZ0E8J36i5q63+w179OKmtOx+JtOczDf9mDsz5kfp2qfeTJppZI3BmGQmjlm5YYGWTbODfMFvWFJrGAV9IRZ9rPeJ2N8PmLZRP1+1tAzT+qUXx0htCjlFN6AmAy0LyK/6zYDYYgwnyYeF+7QsELVeWcSwc/Taec9lQx8DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XQcxaZDk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XQcxaZDk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=a2KQHtVnP932OmlGENISCOc8/sMmjeSDq+9+J0+4pyY=; b=XQcxaZDkCpcn8sSVLvyP1FqFIw
	EmIVJYrs4X+sohn+VhiCwxsMrrgzCpk9CFfHfNpMF+xoWvXcqX4d8WIfUGAM2MyUcw/7jUzyK5U/m
	fDBb8r5Jw1lYh4uPQFfIbuJt1mnqKeJPmHGmL2z5PVNkrv+HFIr3ilI5X87urigjaCNSoquIq+AD4
	9O9LM+GKcEJfzEBGl9VE2fKRyg7GAv0RMdIo4y1OytOpx8NvR+gFJpmEVFn/vGyoaG8R/eGn953hj
	0i+2/kIux56aVjqDlE+MJglJnuN1POWb0QX5WGejZJJm6unGjYKn8ZDZlnzaJysdtg6/IZw1LnyX7
	rTAt+hNQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXDrL-0000000HDd3-2Txd;
	Wed, 10 Jun 2026 08:00:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DA3FC302F8E; Wed, 10 Jun 2026 10:00:22 +0200 (CEST)
Date: Wed, 10 Jun 2026 10:00:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Imran Khan <imran.f.khan@oracle.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] task_work: add tracepoints for task_work callbacks
Message-ID: <20260610080022.GD48970@noisy.programming.kicks-ass.net>
References: <20260610041408.2461637-1-imran.f.khan@oracle.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610041408.2461637-1-imran.f.khan@oracle.com>

On Wed, Jun 10, 2026 at 12:14:08PM +0800, Imran Khan wrote:
> task_work tracepoints can be enabled by:
> 
>     echo 1 > /sys/kernel/tracing/events/task_work/enable
> 
> and trace logs would look like:
> 
>     ... task_work_add_request: target_comm=ls target_pid=227 work=ffff95d20641a508 func=____fput notify=TWA_RESUME
>     ... task_work_add_done: target_comm=ls target_pid=227 work=ffff95d20641a508 ret=0
>     ... task_work_add_request: target_comm=ls target_pid=227 work=ffff95d20641a5c8 func=____fput notify=TWA_RESUME
>     ... task_work_add_done: target_comm=ls target_pid=227 work=ffff95d20641a5c8 ret=0
>     ... task_work_add_request: target_comm=ls target_pid=227 work=ffff95d20641a688 func=____fput notify=TWA_RESUME
>     ... task_work_add_done: target_comm=ls target_pid=227 work=ffff95d20641a688 ret=0
>     ... task_work_add_request: target_comm=ls target_pid=227 work=ffff95d20641a748 func=____fput notify=TWA_RESUME
>     ... task_work_add_done: target_comm=ls target_pid=227 work=ffff95d20641a748 ret=0
>     ... task_work_run_start: comm=ls pid=227 work=ffff95d20641a748 func=____fput
>     ... task_work_run_end: comm=ls pid=227 work=ffff95d20641a748 func=____fput
>     ... task_work_run_start: comm=ls pid=227 work=ffff95d20641a688 func=____fput
>     ... task_work_run_end: comm=ls pid=227 work=ffff95d20641a688 func=____fput
>     ... task_work_run_start: comm=ls pid=227 work=ffff95d20641a5c8 func=____fput
>     ... task_work_run_end: comm=ls pid=227 work=ffff95d20641a5c8 func=____fput
>     ... task_work_run_start: comm=ls pid=227 work=ffff95d20641a508 func=____fput
>     ... task_work_run_end: comm=ls pid=227 work=ffff95d20641a508 func=____fput
> 
> formatted as:
>     target_comm=<comm of target task>
>     target_pid=<pid of target task>
>     work=<callback_head *>
>     func=<callback_head->func>
>     notify=<way to notify the target task>
>     comm=<comm of current task executing func>
>     pid=<pid of current task executing func>

And not a single justification for all this nonsense :-( So much ugly
and no gain...
