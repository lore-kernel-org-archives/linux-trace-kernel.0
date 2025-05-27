Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6322C20013A;
	Tue, 27 May 2025 20:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748376633; cv=none; b=TRtooR1W0IVCeNWVeGdCLK1ACo+Q+0dicJRTio0Q78EdXVgiTNpha22PywvwH9Jav2cK3kEN21bH/ZCdhCUSKfjiOgzmIQmZJmGPEoSAOLuYLO7soxAOgYGzlM5ZMbvD+6HWGdCl8AcSX5R3ty8dvXMej3a4yQnHC9WMQdSb8Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748376633; c=relaxed/simple;
	bh=AATuyonrmvgT5T9PKRZ3HpXkLiEavfYuc5PwEVk76Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rSIhH/PGtIPFVjMNvo4Yzeq1x0A+7+n7Z7K7ZN7SZg7i8xUg9gqqHXyknkydC+m8R8PFsD9iE8LcDXlWomeO8F8wmzcIvB5CZx+Q+SNbVlD5gaqhAFq44mucUxpsam72rKi25dxcnBsIs8r8ECj00XCLcrTwEUR8eXEwqdM5d8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9865FC4CEE9;
	Tue, 27 May 2025 20:10:32 +0000 (UTC)
Date: Tue, 27 May 2025 16:11:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH] ring-buffer: Do not trigger WARN_ON() due to a
 commit_overrun
Message-ID: <20250527161130.26276a41@gandalf.local.home>
In-Reply-To: <20250527121140.0e7f0565@gandalf.local.home>
References: <20250527121140.0e7f0565@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 May 2025 12:11:40 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> But there just happens to be one scenario where this can legitimately
> happen. That is on a commit_overrun. A commit overrun is when an interrupt
> preempts an event being written to the buffer and then the interrupt adds
> so many new events that it fills and wraps the buffer back to the commit.
> Any new events would then be dropped and be reported as "missed_events".

I'll probably update the commit log, but the way I triggered this was to run:

 # perf record -o perf-test.dat -a -- trace-cmd record --nosplice  -e all -p function hackbench 50

Which causes perf to trigger a bunch of interrupts while trace-cmd enables
function tracing and all events. This is on a debug kernel that has
lockdep, KASAN and interrupt and preemption disabling events enabled.

Basically, this causes a lot to be traced in an interrupt. Enough to fill
1.4 megs of the tracing buffer with events in interrupts before a single
event could be recorded.

I've never triggered this when those extreme conditions were not there.

-- Steve
