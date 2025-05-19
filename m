Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882042749C4;
	Mon, 19 May 2025 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747651093; cv=none; b=BthG9R17H2AUOg31ZPg0cge4MqlGV9KXxDVu6HnDyYRL70bjOTHdOa3xRormTVe0pr7JaI1LnbOdMKjAKl604NzJN6NBKmh+SYdYbtIPEd5yUxF6qsmMbeBYmo4+qS4Ko9CgGagTPfqaoBKzWcrcztTCIWgwkXxyHysx+DWX3uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747651093; c=relaxed/simple;
	bh=hg8mpkCMvXEDdzzeHw4qB0o3lgVeBPZMyY/VymmANOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8MBQTGpyctv3stS9t3s1xHu6sXaueeyHi19B/DmntRiz1q+ajw2NZTBqLD2Wo6S9EzMU4Kb9A4hNSgSwLbtll166XaHFeCTJWyY3bV/lYs7mzpCiKnL3jOvq3EzfN3n1a0sE4zs+GjVd5kOVGBktmzMhLX30i5sOe2TZFo5EtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gYEr9cO8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZtcNqMjB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gYEr9cO8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZtcNqMjB"
Date: Mon, 19 May 2025 12:38:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747651090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8TdLM1Y90Zt6LWl4XnsiKYQvdSc/i/L4bdofR7UaRTM=;
	b=gYEr9cO8cVvBvxJPu0zbJzM+TUrImNFKrl/JZIvLHGRRKWbGwiYk1eUw2WTKHESfeCznYz
	4MxFO40aRvFPUAcLJXgbYlXFGQMhVZoUmatDWEuY6F1XSoWF2gvdsmmQUooaD8LSWpAGpk
	JTfbpWqL06cH/1UprShzld8CqptV/0jMlpeAptE8NFZnuk6OHRak7puL/Svv6AEqOZ5T5s
	hFoaz7lz69r2k5RteetyHzUTbvc/Izp0DIKieT0CdzaNTMcwdEBOVLusp3Uwr2ES25uIRr
	B3pfSCbe1mBhL5VrnjJret5I3jeRuca7UdTCAeqmT0f5IEvuxvKzTWiiWHFOYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747651090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8TdLM1Y90Zt6LWl4XnsiKYQvdSc/i/L4bdofR7UaRTM=;
	b=ZtcNqMjB8NFQ+++ag5bfm7VZfieytAbG9G2rxCP8WHxB5drOWWCBtZrmACHStrkbH0ek21
	sAZ/deEQIJE8rfBQ==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>
Subject: Re: [RFC PATCH v2 10/12] rv: Retry when da monitor detects race
 conditions
Message-ID: <20250519103809.nuEUQbVl@linutronix.de>
References: <20250514084314.57976-1-gmonaco@redhat.com>
 <20250514084314.57976-11-gmonaco@redhat.com>
 <20250519090626.zjiYgUGW@linutronix.de>
 <5f1365f2cd84597fd3547544fcceab5c79682624.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f1365f2cd84597fd3547544fcceab5c79682624.camel@redhat.com>

On Mon, May 19, 2025 at 12:28:12PM +0200, Gabriele Monaco wrote:
> Mmh, although definitely unlikely, I'm thinking of a case in which the
> event starts on one CPU and at the same time we see events in IRQ and 
> on another CPU, let's say continuously. Nothing forbids that between
> any two consecutive try_cmpxchg another CPU/context changes the next
> state (making the local try_cmpxchg fail).
> In practice I've never seen it going on the second iteration, as the
> critical section is really tiny, but I'm not sure we can guarantee this
> never happens.
> Or am I missing something?

I have a feeling that you missed my point. I agree that the retrying is
needed, because we may race with another.

What I am proposing is that we drop the MAX_DA_RETRY_RACING_EVENTS, and
just keep retrying until we succeed.

And that's safe to do, because the maximum number of retries is the number
of tasks contending with us to set the monitor's state. So we know we won't
be retrying for long.

Best regards,
Nam
