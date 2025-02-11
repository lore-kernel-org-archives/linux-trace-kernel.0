Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FBE1F4603;
	Tue, 11 Feb 2025 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739271459; cv=none; b=DKgt+J7gH8cs6XLkgBKWbpPlEA6k5uqt6iJyUOkFoM9iRd18kq9R5XJTun30B3vbs6VVSxZ6fuPGntDXIMnXdzwcoX2GxVWEZggyq/Wp3pel2DHecl+fP8qVOgOFPhxIVXWIkIBurlHYAE5FY+VKDHcBJtnH1USgTJQo9tGclzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739271459; c=relaxed/simple;
	bh=n7Kfv8GusfTR6LL1bE5QzBC3w5D+cQ4NlPl5cgfpT2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCz5KTT8ettOJzq4WbUOEYD+gtU64jfo00gvuPOFwx9ghm1AppciRbe3FlwFYRNk2arjQ+9B8y8T+I3FoEx0v5pR7Ukun6Ob9LWoqePfzgjlQoBHbgo9vAb3fTkI9Ad36p2IoI/G2tRfJhfgVtFMPRJ4otKzz77aRBlWawHtIrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WoI4Fyma; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WoI4Fyma"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YZ7DKPe0nzskULMYwtIOGHC3I52VF4VhPYSpWleaRA4=; b=WoI4FymaOwHtwJvfSW/ke3Cxmw
	4yB1XYmZA42v/QONXf4Qu6B0inAkax1aN7Cg6Fs+qWCnXuMX46ZeTLVG9RBIuFBFVxwYN5GtYHu0n
	BjxZaaE020vSqopCNQtwq48NbVWYN+ZBoiAHJOPpAOWsXT7+B0ZudNsQ09FyGoDDLQ7V5AcyAhEr4
	2RJCafAiOrACA1Wx2IIcUBprX+zcv3tNW3S2MCDoO6wE++8MVjDC9PhSvmoHBZj8es24NJmCvZS87
	sHdtswg/mc4xeczSmCG1vsSm5HOw03O6Yq0ZnS9EbLaaAMCAWrTw4Gni/phXXOMk9get1KGugPaGR
	tN7gY7nQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1thnx5-00000000Z62-18IS;
	Tue, 11 Feb 2025 10:57:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 04FB83004AF; Tue, 11 Feb 2025 11:57:14 +0100 (CET)
Date: Tue, 11 Feb 2025 11:57:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Prakash Sangappa <prakash.sangappa@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
	bharata@amd.com, raghavendra.kt@amd.com,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Konrad Wilk <konrad.wilk@oracle.com>, jgross@suse.com,
	Andrew.Cooper3@citrix.com, Vineeth Pillai <vineethrp@google.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Clark Williams <clark.williams@gmail.com>, daniel.wagner@suse.com,
	Joseph Salisbury <joseph.salisbury@oracle.com>, broonie@gmail.com
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Message-ID: <20250211105713.GD29593@noisy.programming.kicks-ass.net>
References: <EC77D83D-DD17-4CCD-9EF6-C4C39FCE16E7@oracle.com>
 <9DA1FAE6-A008-4785-BDF9-541457E29807@joelfernandes.org>
 <20250204220418.35949317@gandalf.local.home>
 <CAEXW_YQxTi2y_hY_e4AjLSa6RwVVLn3DPj5d4Cfewq0js-0UTA@mail.gmail.com>
 <20250205081635.397eacb0@gandalf.local.home>
 <CAEXW_YQY2zuU+XZjrYWLS860+PJno0nf9WAe1iPU=EyDkA7H4Q@mail.gmail.com>
 <20250206083039.0916ad24@gandalf.local.home>
 <20250206134408.lD_POjuG@linutronix.de>
 <20250210144321.1f5974a6@gandalf.local.home>
 <20250211082138.iqvedSfG@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211082138.iqvedSfG@linutronix.de>

On Tue, Feb 11, 2025 at 09:21:38AM +0100, Sebastian Andrzej Siewior wrote:

> So with LAZY_PREEMPT (not that one that was merged upstream, its
> predecessor) we had a counter similar to the preemption counter. On each
> rt_spin_lock() the counter was incremented, on each rt_spin_unlock() the
> counter was decremented. Once the counter hit zero and the lazy preempt
> flag was set (which was only set on schedule requests by SCHED_OTHER
> tasks), we scheduled.
> This improved the performance as we didn't schedule() while holding a
> spinlock_t and then bump into the same lock in the next task.
> 
> We don't follow this behaviour exactly today.

I think I send some hackery Mike's way to implement that at some point.

IIRC it wasn't an obvious win. Anyway its not too hard to do.
