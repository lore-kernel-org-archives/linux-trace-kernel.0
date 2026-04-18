Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF7F25EF87;
	Sat, 18 Apr 2026 19:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776541978; cv=none; b=nU/74BjQqm4iOmD5POCIVm6e+35sokWlbnrw7+YkLepbCef95GzoVNc/PWiit5KEmiXI3A04pgq2iduep/K08/DDicUmJGD7mmYgX4Jz/SliSimFXllfUBZXLtRG+xxQSHpTLKThpIsZI4xmx3VXDQnmkR2IDthDUcEQ1p+cEDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776541978; c=relaxed/simple;
	bh=bI7VgZL7Kty67qfNz3iVEfZNIMV0lr+nrYM3VNJ/7FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qx4jnSwcg8krofp0Fm7a8Jx9+qObw6oIM5ysiupOai8p2xMeGrZlh8/8RBvk8vwCfNkwclpP2ky9ZVzTfpAu6+/uL9DLsGutjRGMDoz4tCf5PRTN9/ex3wB5hq0wDdaYNmqz73NaRuQ29MK7NV28CTNxK2lFnqvqX2rNLZ9FK8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 1EF98B9DB0;
	Sat, 18 Apr 2026 19:52:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 5BC988000F;
	Sat, 18 Apr 2026 19:52:48 +0000 (UTC)
Date: Sat, 18 Apr 2026 15:52:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yash Suthar <yashsuthar983@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, me@brighamcampbell.com,
 syzbot+a1d25e53cd4a10f7f2d3@syzkaller.appspotmail.com
Subject: Re: [PATCH] trace: propagate registration failure from
 tracing_start_*_record()
Message-ID: <20260418155216.0c2d8785@fedora>
In-Reply-To: <CAPfzD4kQg94qA0oRd+=JOju=+a76872WCsBSo8=aNG5QduNQbg@mail.gmail.com>
References: <20260417063827.84146-1-yashsuthar983@gmail.com>
	<20260417115258.65e216be@fedora>
	<CAPfzD4kQg94qA0oRd+=JOju=+a76872WCsBSo8=aNG5QduNQbg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 5BC988000F
X-Stat-Signature: 765z6dmp4nah3i1atd4i9iqmo85tzgbx
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1++KkFMsWdYJk7nxq4CU2FNOt/ugrHSXIs=
X-HE-Tag: 1776541968-559234
X-HE-Meta: U2FsdGVkX1+IQ9D4hNvmVxAL1sXLCguUseVHj+SlqjCKGFnZ03wIQCApGdzV/Gm/KHob7imUjzY=

On Sat, 18 Apr 2026 11:08:42 +0530
Yash Suthar <yashsuthar983@gmail.com> wrote:

> Hello Steven,
> Thank you for taking a look and really sorry.
> 
> I did use ai assistance for commit message, but I reviewed, modified
> and tested(with syzbot locally) the code myself. I should have
> disclosed really sorry.
> 
> One thing I want to know (or I am still missing something):
> sched_cmdline_ref is incremented before tracing_sched_register() and
> register fails,  but sched_cmdline_ref stays at 1 and on disable
> tracepoint_remove_func() sees NULL and return error (as syzbot
> reported and reproduce also locally).
> your suggestion WARN_ONCE correctly flags the upstream failure, but
> the secondary WARN at  tracepoint.c:358 will still fire on the next
> disable, since the refcount desync isn't addressed. Was that
> intentional ?

Yes.

This is why I'm not too thrilled about syzbot injecting kmalloc
failures. These injections are for one page or less, in which case the
system is in pretty much a failed state anyway.

I don't care about warnings being triggering due to kmalloc failures.
I'll fix UAF or NULL pointer dereferences, but warnings? No!

If you fail to alloc a single page, expect a lot of warnings to happen.
That is intentional. syzbot should not flag an error for a warning that
was triggered due to a single page memory failure, unless that memory
was allocated by in atomic or something where it can't do reclaim.

-- Steve
