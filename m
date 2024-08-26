Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9C91991CB;
	Mon, 26 Aug 2024 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693142; cv=none; b=G916XjrtO5PFdatmhgNI4nYOGPtW/2J3wuZVGs2UvGeugx7yYl4F88tLt7m8Ay+fN+1xzwK+0oxNi3GA7i91Csg9NCKaxkPGge5RCJWYJzI6SaXD4OCvHf5FdJWxquzlEz2AJT7fvAL1YP3k2lxvfNz2y/QNZZYtpHgysCpsExA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693142; c=relaxed/simple;
	bh=bFCDh6HQGIio1OqCsuLrcWyXqRIk/lGjSx9LbGP/dQg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LcaRANxQlu/pQB7NXVr6LjThH77XLc/LVAvV39+99iadaGULqlZZFna91weRH3nrs4VMO5Ot/LhqAqkMnfgrCZA2I/bfAoul1I8Zdp+Ex2rbaZJJNgMGH1gk2kKsNmQQMKNox5vwHuZ6pC3smBfyVDABQigkRbEYlfJSRh3zFYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0EABC8B7A2;
	Mon, 26 Aug 2024 17:25:40 +0000 (UTC)
Date: Mon, 26 Aug 2024 13:26:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 jkacur@redhat.com, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH] tracing/timerlat: Check tlat_var for NULL in
 timerlat_fd_release
Message-ID: <20240826132620.1618d201@gandalf.local.home>
In-Reply-To: <CAP4=nvQnW5vS5CQBZtKp-BdjYxNFbq26P36uRy3RhCenHEG_YA@mail.gmail.com>
References: <20240820130001.124768-1-tglozar@redhat.com>
	<20240823125426.404f2705@gandalf.local.home>
	<20240823145211.34ccda61@gandalf.local.home>
	<CAP4=nvQnW5vS5CQBZtKp-BdjYxNFbq26P36uRy3RhCenHEG_YA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Aug 2024 15:01:24 +0200
Tomas Glozar <tglozar@redhat.com> wrote:

> > Before the reset, all but one of the tlat->kthread is NULL. Then it dawned
> > on me that this is a global per CPU variable. It gets initialized when the
> > tracer starts. If another program is has the timerlat fd open when the
> > tracer ends, the tracer starts again, and you close the fd, it will cancel
> > the hrtimer for the new task.
> >
> > I think there needs to be some ref counting here, that keeps the tracer
> > from starting again if there's still files opened.
> >  
> 
> The timerlat fd is not supposed to be open when the tracer ends/starts
> again, since osnoise_workload_stop() calls stop_kthread(), which in
> turn calls kill_pid() to SIGKILL the user workload, which will also
> close the file descriptor. Only one PID per CPU should have the
> timerlat fd open at one moment, since timerlat_fd_open() will refuse
> to open if tlat->pid is set. It appears that this is somehow bypassed
> and osnoise_workload_start() happens before closing the fd, not sure
> why.
> 
> > This looks to be a bigger problem than I have time to work on it for now.
> > I'll just apply the mutex patch for the kthreads, but this bug is going to
> > take a bit more work in solving.
> >  
> 
> Yeah, unfortunately the issue looks more complicated now after looking
> at the traces you posted, I will probably have to do more tracing to
> see what is actually happening here. Thank you again for helping us
> with this and also for the patch for the mutex.

Yeah, I think I finally found the real issue. I don't think we need the ref
counting. The problem is the creating and killing of the threads via the
start and stop callbacks. That's not their purpose. The purpose of stop
and start callbacks is when tracing_on is set to off and back on again. I
think this is what is racing with the close.

Anyway, the start and stop should probably just pause the threads and not
kill them an start them again. That is, the osnoise_workload_start() should
be called by the init callbacks and the osnoise_workload_stop should be
called by reset callback.

The start and stop callbacks should just pause and restart the the threads.

-- Steve
