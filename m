Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935652D1F6B
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Jan 2026 02:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767666100; cv=none; b=QAWg1oSExjDN6Tbh4yVUExJsh84BeaPJPduWxgiuD0m9kTze3doXD4uIMkWK7jxIl63X4zOQEyrgVfjWNtqoOnxGLhMEo0m0SIE3UE2dmtE4oIY5ujYG/QcagXZTYItWfvecF0V9WzN1Lo25KeDjdqRhUZrPoKYU3HpJ2uP7/Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767666100; c=relaxed/simple;
	bh=9wCgZGW7nxl/c5vpeAOnnkhs8zBWIJYUg7JcxkxuwD8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0RNLOBaTPbIVzXwA6v6zbLZCno8b2nrfsmm1Ro9y4srr22Sn2jfEHyOM8c76RCbaaV/WCSImnrIQKLPzrmVIDoY2BeT8U4Z4qiiSW5RElP2GGBFxB4EDVYLBL3NXN37CfatQO7CbZQg7f4hN//lujib+HYR1gSLpJRJDqZY1ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 329EEC1879;
	Tue,  6 Jan 2026 02:21:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 6939830;
	Tue,  6 Jan 2026 02:21:34 +0000 (UTC)
Date: Mon, 5 Jan 2026 21:21:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Ballasi <tballasi@linux.microsoft.com>, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org
Subject: Re: [PATCH v3 0/2] mm: vmscan: add PID and cgroup ID to vmscan
 tracepoints
Message-ID: <20260105212157.503db606@gandalf.local.home>
In-Reply-To: <20260105180640.2072c151c9f1f56458cb2dd2@linux-foundation.org>
References: <20251216140252.11864-1-tballasi@linux.microsoft.com>
	<20260105160423.23708-1-tballasi@linux.microsoft.com>
	<20260105180640.2072c151c9f1f56458cb2dd2@linux-foundation.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: a6jckkp7odd3h8kkgnary3opzd6shgtg
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 6939830
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Ras5liyNeNz5fAhJE8zcGxrgBhR/tU1Y=
X-HE-Tag: 1767666094-528518
X-HE-Meta: U2FsdGVkX19LJ3kgQO6B3sHlGOz1ndXlzIrbk28EcFCTzPW8dESrGl1l7tnYBNlXRKMILkXGAhR2hscB+zmT+O7D8yyVVaJlOOdr76FF3H8Y1ChSJEsEogYVE+44mdpz5Byk8MeefL/ygMmQVB+1GjKJxg+yudF1q4zSs5Zt/sc4sMCBHVpeAVRid+6TqPfzLZ1CEFN/xLeu3wgsbAk2ekwSA4YkeUD8rN3Q2MIMZrSgHUA1swNiFQ6kg8cVs4VTnoMPfracbND0M/r8x3BQInCjgyvMxuIB59OWy4KsbTlaOlIKe+5GhrM6Gd6dkljuQ7HihROblc+VXAvvrZg/wMMM99qy7ZPGCdIp9VzgLmWcyG6gQU4wafLNoT6KxF/rvncM7GLPnIZzTKzgc8sC0H5jUqieDWO9oWi1FcE07Ss=

On Mon, 5 Jan 2026 18:06:40 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon,  5 Jan 2026 08:04:21 -0800 Thomas Ballasi <tballasi@linux.microsoft.com> wrote:
> 
> > Changes in v3:
> > - Swapped multiple field entries to prevent a hole in the ring buffer
> > - Replaced in_task() with __event_in_irq
> > - Replaced mem_cgroup_id(memcg) with cgroup_id(memcg->css.cgroup)
> > - Rebased the tree to latest 6.18  
> 
> x86_64 allmodconfig;
> 
> 
> In file included from ./include/trace/define_trace.h:132,
>                  from ./include/trace/events/vmscan.h:569,
>                  from mm/vmscan.c:73:
> ./include/trace/events/vmscan.h: In function 'trace_raw_output_mm_vmscan_direct_reclaim_begin_template':
> ./include/trace/events/vmscan.h:140:17: error: implicit declaration of function '__event_in_irq' [-Wimplicit-function-declaration]
>   140 | +               __event_in_irq() ? "(in-irq)" : "")
>       |                 ^~~~~~~~~~~~~~
> ./include/trace/trace_events.h:219:34: note: in definition of macro 'DECLARE_EVENT_CLASS'
>   219 |         trace_event_printf(iter, print);                                \
>       |                                  ^~~~~
> ./include/trace/events/vmscan.h:135:9: note: in expansion of macro 'TP_printk'
>   135 |         TP_printk("order=%d gfp_flags=%s pid=%d memcg_id=%u %s",
>       |         ^~~~~~~~~
> make[3]: *** [scripts/Makefile.build:287: mm/vmscan.o] Error 1
> make[2]: *** [scripts/Makefile.build:556: mm] Error 2
> make[1]: *** [/usr/src/25/Makefile:2054: .] Error 2
> make: *** [Makefile:248: __sub-make] Error 2

This is dependent on my patch:

  https://lore.kernel.org/all/20251229163515.3d1b0bba@gandalf.local.home/

Where I said you can take this patch. But I don't see it as part of the
series.

  https://lore.kernel.org/all/20251229163634.5aad205d@gandalf.local.home/

-- Steve

