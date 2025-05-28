Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D111E1862;
	Wed, 28 May 2025 00:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748393723; cv=none; b=am7N33b69qMEQhm7P9j0ks3+H76PC1FbxxEVW1x6Eu1ilUjhB4wHW84w41GSMF9qWEBFanfP2INxLY18Gz+Xw+wcz5WZEY/pdeILNrhoCAptEyhdH3i0J/2OwCNRcKSmrXyCrDpq1qkgV6+PpiF1ufb0oRSQCke5RsdtkY7WDw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748393723; c=relaxed/simple;
	bh=REIF4VIRmjb8CyUwrD/mNL6EjChVwJh6vGRUfbRS6MY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=d9AgJAEiznzrrq9hgib4yl2UXDwioOook7miHVBb0GS5Gcb5qJ80VWbj4WQs80YnqgnVI8y7H0eXHXyo+vfC43DYLLYxDP4V9j8RAU5Csctjt7hKuYGaC6Smmxo2RAQfK9PS7Bjz3ajuwLoY7Vu12VEakptkXN1oS9rGoI87hFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkzxjemR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkzxjemR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36232C4CEE9;
	Wed, 28 May 2025 00:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748393723;
	bh=REIF4VIRmjb8CyUwrD/mNL6EjChVwJh6vGRUfbRS6MY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HkzxjemRmczAcQB9NmoIV8oiDzsmWOzh+aY5Obo8yhpFoQ99iUOeCzgFQeu9AfrnB
	 b22nbmCPVN05RBf9cV6H1s/MAsTYY08+V8JEvxr9LcvXS4UNourtVrmSNn27b+y97x
	 oezxdwEHCTDGSI/KE/29Vr8Zeo510+nRLTUqpycfzwxwxtMiCjJQ0wqGkkIt8+IjBs
	 /hZtKspbX1m0y02rPNuKMT04zagYGT8TId1dWn7mJ1D1IM2u07OhldxQApS5+vTscL
	 osCT7EZNKCrJQP9IG11WzQDJYPV2ZXM8cpmePxFqwld+10cy+Bj1CHxWsE1EGxkjxt
	 +xotiPDECgCtg==
Date: Wed, 28 May 2025 09:55:20 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH] ring-buffer: Do not trigger WARN_ON() due to a
 commit_overrun
Message-Id: <20250528095520.b4f236a354d9f15d65e7c2fe@kernel.org>
In-Reply-To: <20250527161130.26276a41@gandalf.local.home>
References: <20250527121140.0e7f0565@gandalf.local.home>
	<20250527161130.26276a41@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 May 2025 16:11:30 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 27 May 2025 12:11:40 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > But there just happens to be one scenario where this can legitimately
> > happen. That is on a commit_overrun. A commit overrun is when an interrupt
> > preempts an event being written to the buffer and then the interrupt adds
> > so many new events that it fills and wraps the buffer back to the commit.
> > Any new events would then be dropped and be reported as "missed_events".
> 
> I'll probably update the commit log, but the way I triggered this was to run:
> 
>  # perf record -o perf-test.dat -a -- trace-cmd record --nosplice  -e all -p function hackbench 50

Hmm, so this runs 3 commands, hackbench, which is traced by trace-cmd, which
is traced by perf.

> 
> Which causes perf to trigger a bunch of interrupts while trace-cmd enables
> function tracing and all events. This is on a debug kernel that has
> lockdep, KASAN and interrupt and preemption disabling events enabled.

Ah, that is the full-set of the interrupt and tracing :)

Thanks,

> 
> Basically, this causes a lot to be traced in an interrupt. Enough to fill
> 1.4 megs of the tracing buffer with events in interrupts before a single
> event could be recorded.
> 
> I've never triggered this when those extreme conditions were not there.
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
