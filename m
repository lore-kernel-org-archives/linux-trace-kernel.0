Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D93013D897;
	Fri, 17 Jan 2025 15:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737127758; cv=none; b=UsNjQ6+B//04KUN1hKddGjEHRtasAEXDhjr71m7UaYO4UTmJ6O6HdEinxQy76hsNG/e2Ilk/QurYY/ezpkCNctvuNDoNiHceAuUBJgMBrD6t9HVJ+uSWrthgMJ/UU/cqKCE9AckgQLD5VqcjCcleP97u06f1+3OaWWgV6u4mW4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737127758; c=relaxed/simple;
	bh=SKnIJa2kDBbEyoWXSf3vebW59o/vzyAYQcyXln0eWmM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UZ57r7quxM7wNL7gOow61ZmN4TD8aleZhTH2n7X1w9pW5XrdDisPV0MTE00u2/5Q4pWUrXx/529NussIh8XAWPNlpfsg8NLwDxHwn4Asj67PakM1oL7WA4qunMl3aiHGShCTknM2ArnFIuct9wW6Myy1RoVUqx6qvLgJB5vDGOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11F6C4CEDD;
	Fri, 17 Jan 2025 15:29:16 +0000 (UTC)
Date: Fri, 17 Jan 2025 10:29:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, John
 Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, Gabriele
 Monaco <gmonaco@redhat.com>
Subject: Re: [PATCH 0/5] rtla/timerlat: Stop on signal properly when
 overloaded
Message-ID: <20250117102924.690cb7c7@gandalf.local.home>
In-Reply-To: <CAP4=nvQpS20ubNspE0PPhiyWb3-ARV=gmQzFCA7WwAT8+rxMjg@mail.gmail.com>
References: <20250116144931.649593-1-tglozar@redhat.com>
	<20250116194621.7b309aed@gandalf.local.home>
	<CAP4=nvQpS20ubNspE0PPhiyWb3-ARV=gmQzFCA7WwAT8+rxMjg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jan 2025 13:04:07 +0100
Tomas Glozar <tglozar@redhat.com> wrote:


> I was thinking of turning timerlat_hist_handler/timerlat_top_handler
> into a BPF program and having it executed right after the sample is
> created, e.g. by using the BPF perf interface to hook it to a
> tracepoint event. The histogram/counter would be stored in BPF maps,
> which would be merely copied over in the main loop. This is
> essentially how cyclictest does it, except in userspace. I expect this
> solution to have good performance, but the obvious downside is that it
> requires BPF. This is not a problem for us, but might be for other
> rtla users and we'd likely have to keep both implementations of sample
> processing in the code.
> 
> Also, before even starting with that, it would be likely necessary to
> remove the duplicate code throughout timerlat/osnoise and test it
> properly, so we don't have to do the same code changes twice or four
> times.

We could also add kernel helpers to the code if it would help.

Hmm, the timerlat event could probably get access to a trigger to allow it
to do the work in the kernel like what the 'hist' triggers do. We can
extend on that.

The reason I haven't written a BPF program yet, is because when I feel
there's a useful operation that can be done, I just extend ftrace to do it
;-)

-- Steve
