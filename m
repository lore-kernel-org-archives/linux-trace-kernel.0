Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DD23F58D9;
	Thu,  9 Jul 2026 08:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586574; cv=none; b=lbKofbaMM63j6RnHWsl3KvJrEx/sFbIkfEkq0pYyk3QRxCzNj3zSfGieadwwAjDlfgLo9deaV5tkxiV+BguPl1bjw2WN6DC0+6T1MGHVeKEGDdZvJA20K/uBnoKNC1K6+gnlti9CtMUTQm/SUK3kVpRxoKqfSAgBzuXTgXjHM2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586574; c=relaxed/simple;
	bh=HAnrtkmPoRcicDoSbeIjna05ykyw5QcMdrBk32AvK3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lfl+uMfrqxpWQntrqdtRiSJZAvoNlDfTsNsNao5pSDbTevQVMgjwKD8Hj9i1dRmBc3K02IOqPaAeyuWeAsbveadd8IZ7FGcgRy5xy3zNOXjvhDvR9etriyiRx+tNlbO5oX+3Q076f2Vhj8HKNaNqt+OEX92qTAn+nI3cgJ8/JnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NeAcRb2a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QeEzWspH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NeAcRb2a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QeEzWspH"
Date: Thu, 9 Jul 2026 10:42:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783586569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lDsVqicYydxGz5kLXUXwm+1P85L+HsP2ziC8koU12BY=;
	b=NeAcRb2aqfvOi9Tg2p5Ko6EuzAemMafFzO4tSWsKwx6vN8wmcinC9HQzNRvprKbxrMfO1U
	dS5HL/KEaEYvC23p1ZAS7driQxJeQPOmPrldEx1xyrDszY5KsDuC1Dl5pA7Bsu0HqaVPip
	nRFvPBaEGAyvpTsFfiexw788G7e+7CKPJwK+biLck8waiaFQ6QARrNQt1jpbBAQuA2YDKA
	V+Fc0XqrH9UIF0paXyszDeGQn1e4fd/Y2OJ8iZulvYOlAkWQ7RjiMaStCpRR1tce+AEJsD
	gZJGnVPdVUlR+IubjB9tzfJrRUTxzBaC7fTXEsRiJyfES6lQC5QvmoDqOdqhhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783586569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lDsVqicYydxGz5kLXUXwm+1P85L+HsP2ziC8koU12BY=;
	b=QeEzWspHT3ZNdkKlORK27/vaa4kXhq00DjL8vtQY+ZIFmJGbtl3HzNUT0/8WsQg0fOINyo
	+cjNjy3cB2KsyiAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Wandun Chen <chenwandun1@gmail.com>, vbabka@kernel.org,
	david@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
	Alexander.Krabler@kuka.com, hughd@google.com, fvdl@google.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	akpm@linux-foundation.org, surenb@google.com, mhocko@suse.com,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	riel@surriel.com, liam@infradead.org, harry@kernel.org,
	jannh@google.com, lance.yang@linux.dev,
	mathieu.desnoyers@efficios.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	pfalcato@suse.de
Subject: Re: [PATCH v2 2/4] mm/mlock: wait for migration to finish when
 mlocking a folio
Message-ID: <20260709084247.HJNrqVk8@linutronix.de>
References: <20260707125925.3725177-1-chenwandun1@gmail.com>
 <20260707125925.3725177-3-chenwandun1@gmail.com>
 <ak0C-DP_1ZrTVSLj@lucifer>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ak0C-DP_1ZrTVSLj@lucifer>

On 2026-07-07 15:33:32 [+0100], Lorenzo Stoakes wrote:
> On Tue, Jul 07, 2026 at 08:59:23PM +0800, Wandun Chen wrote:
> > From: Wandun Chen <chenwandun@lixiang.com>
> >
> > In RT kernels, sysctl_compact_unevictable_allowed is false by default,
> > when the mlock/mlockall system call try to lock all the present page,
> > the mlock_pte_range function skips non-present entries. If these
> > non-present entries are migration entries, and the migration is not
> > guaranteed to have completed before the mlock/mlockall, it may result
> > in a page fault on subsequent access, which then waits for the
> > migration to finish, causing spike latency in RT kernels.
> 
> Is this really noticable and measurable?

You want to avoid page faults like this which is why you do mlock in the
first place.
If the thread has a RT priority and it blocks here then other RT threads
will be scheduled and your migration thread, which will resolve this, is
SCHED_OTHER and the last one in the line. Assuming that thread has a 1ms
cycle/ deadline then it will likely miss it.

> I suppose not too many ranges should be mock

Sebastian
