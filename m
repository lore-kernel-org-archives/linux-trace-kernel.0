Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57F52FC01B;
	Tue, 10 Mar 2026 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773156372; cv=none; b=k05nsBB1vUrFY/ebPvYPGIkl20ibt6z61vd1N9LMmX6e3plZvbqHgjxkEZpZXUXYS9A+eiaapewwsfvxOZZQVRORzlrD34GDjqaiZK3v7sUQtQ6E+eQelEEDF8dXDOyj23Udx74iqpu6dgqJK9midHejirPMmMtaW0PE5yLq/pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773156372; c=relaxed/simple;
	bh=AQENKe/3Bq7Nek5uNaczizBsMHDGl1pFNxQClZoiXQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhlMO5RhxRoWGoEzZrvBwkbnoVxUBw+FWMsC4Jtn1xnJbVN4h1cX9SGaNw7wZvctQtMvlA79YZRzzH6e6fh0LRmU3IoBGUS5k8qquhGzL3bs5M5z17NOw/yJlmpqstdCND4oWEvKfmIu4TXqlYG/qUvM6LkHSszDxH5xqsTmLfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=ycOW/lEt; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="ycOW/lEt"
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 09486B37FF;
	Tue, 10 Mar 2026 15:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1773156369;
	bh=Pa74cTSbG0z2foj2y+9iiBszrUG7TFk6AQHAxUoXkgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ycOW/lEtJ1S7Wio87A4CpZHQVlBIvlISLpJdNfmiLEcWnuK2JREX/B+/5EgwKgnJj
	 YoUGqrnLdIPlWdcaMd8AQ+MSjd86QZ7N0TSTQK9I1trSEfX6Ce3SLiPjNiWN90yed3
	 igvdkShdgulQvEsnl/p9Tsz7RFfimzeFeLHMLu1I=
Date: Tue, 10 Mar 2026 15:26:07 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH RFC 2/3] locking/percpu-rwsem: Extract
 __percpu_up_read_slowpath()
Message-ID: <abA4DxpOmbQyl629@shell.ilvokhin.com>
References: <cover.1772642407.git.d@ilvokhin.com>
 <6b1f1521ca186d5c402a65619d8f30fe83b93bf6.1772642407.git.d@ilvokhin.com>
 <20260304220223.GS606826@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304220223.GS606826@noisy.programming.kicks-ass.net>

On Wed, Mar 04, 2026 at 11:02:23PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 04, 2026 at 04:56:16PM +0000, Dmitry Ilvokhin wrote:
> > Move the percpu_up_read() slowpath out of the inline function into a new
> > __percpu_up_read_slowpath() to avoid binary size increase from adding a
> > tracepoint to an inlined function.
> >
> > Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> > ---
> >  include/linux/percpu-rwsem.h  | 15 +++------------
> >  kernel/locking/percpu-rwsem.c | 18 ++++++++++++++++++
> >  2 files changed, 21 insertions(+), 12 deletions(-)
> > 
> > diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
> > index c8cb010d655e..89506895365c 100644
> > --- a/include/linux/percpu-rwsem.h
> > +++ b/include/linux/percpu-rwsem.h
> > @@ -107,6 +107,8 @@ static inline bool percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
> >  	return ret;
> >  }
> >  
> > +void __percpu_up_read_slowpath(struct percpu_rw_semaphore *sem);
> > +
> 
> extern for consistency with all the other declarations in this header.
> 
> s/_slowpath//, the corresponding down function also doesn't have
> _slowpath on.

Thanks for the feedback, Peter. Applied both suggestions locally.
