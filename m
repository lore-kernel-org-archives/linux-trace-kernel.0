Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E433DE425;
	Tue, 31 Mar 2026 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774964520; cv=none; b=JUn2xnCcWxRYREd7Tvh6h776D+fUysVZvVhmKcWtSCP5VIzeqX0kKqoQaQUMFh2pscAOJC3CpesLzQ7qizrrQpx4X/zU4NQRc+Gl7u/aOIYZf225vh+6V3JxjbAuwzGEwxE1hIEkCYtxzXpe4awpFW3gkijuB5WghDGz15FWfn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774964520; c=relaxed/simple;
	bh=ZK9vHzYS4pKmB2zEXRjnRO+XkJMtHA/GHRCH5l2nrrM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mX4TMPj6+ptPGbrYrFXH/py6tMk7WHG2/bAjijoA3Z1V8p8vttqXxKjLk99Fjz+8Cz9jxlTAfwTBDPYEYYXl9lWFVjefFjfmXFzl+lrp65+2acf7T+r4aqGt9EJN7W7PlPWU+hCpYeJlnBAC5iRLetLyWsLyezynswtZ6WSTQWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yWgaU884; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y47u+/II; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yWgaU884";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y47u+/II"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774964516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HeE50xHavahi4CU3t4HaEaD+R24vGxV7ezZ/B576vqM=;
	b=yWgaU884lqIy7cXVz8mfI6mVPkOTEmmSyVkMwR/r1GZSGbu3EEu+nD6YQAmdvuk6JICzt8
	MIDHFHiQi9GHtQn6N18TqWNJIau9AuY/O6Aqw0gWNAgvrpOQDTrWSv8Onr9nl5y5akXjkc
	YOAgh6g5x2Pkef5/RNDpw4Ou2FvHLjehXchGEFzSJMPSP9qjb6FTJxfQIZq1u3FySIm8FE
	42d8VBK/ABxTpafAjJt7y2ddyZkWljMKJcIxjQWLKAPstt1ChWBPDu6hV3GKGOiyMlkOu9
	v4W6w+sYd/dW4RMdW+wKV1F67y5VQO1eEewGWL+XJ9/c43OOMBJ8doA47m4KlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774964516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HeE50xHavahi4CU3t4HaEaD+R24vGxV7ezZ/B576vqM=;
	b=y47u+/IIIoHcXvVQqVYvj8ofuV8avp7rwCMXlRy9VFjN8nDEt7eSHulurbPgyPFsUrc//i
	y34KfDknlMorJ8AQ==
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rv: Allow epoll in rtapp-sleep monitor
In-Reply-To: <4b47d5e7e9dde0c76beb1a9383a13553c2455d92.camel@redhat.com>
References: <20260331104918.2710853-1-namcao@linutronix.de>
 <4b47d5e7e9dde0c76beb1a9383a13553c2455d92.camel@redhat.com>
Date: Tue, 31 Mar 2026 15:41:51 +0200
Message-ID: <87y0j86rq8.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:

> On Tue, 2026-03-31 at 12:49 +0200, Nam Cao wrote:
>> Since commit 0c43094f8cc9 ("eventpoll: Replace rwlock with spinlock"),
>> epoll_wait is real-time-safe syscall for sleeping.
>> 
>> Add epoll_wait to the list of rt-safe sleeping APIs.
>> 
>> Signed-off-by: Nam Cao <namcao@linutronix.de>
>
> Thanks for the patch, looks reasonable.
> I tried re-generating the header (sleep.h) with rvgen based on the new
> specification and I'm getting a different order.
>
> Is what you're committing the result of rvgen on your computer?
> We probably still have some unpredictable result in the rvgen's output if that's
> the case (no big deal then, though it triggers me a bit).

Right, fixing this is in my list. The script uses set and set's order is
not deterministic. You get different (but equivalent) results every
time. I should start working on that..

> I would still like to run some tests on this, how urgently would you like this
> patch through? I was really about to send Steve a PR with the other changes so
> this might need to wait for the next merge window.

The earlier the better, but no one will die because it misses a merge
window.

Nam
