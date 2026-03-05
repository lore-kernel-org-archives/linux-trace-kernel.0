Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EE13B8D4A;
	Thu,  5 Mar 2026 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772725591; cv=none; b=tcDk3xTVqCVu0ZJ4igCXXveCkQ2K3SBFo2xpAD3lwZi/K1XoptSu3nDfdjhvpKxLSpe/auNk15iNI7gg+bbpj+qMXPog7RutUwzrfXQN6j7PD9lEgTOsWMTs83XjC/e2h20L+vamHgtPAyo9wfMpO6elo6qkaimwsn5dbTJ/fP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772725591; c=relaxed/simple;
	bh=mCZXEa6zlsJn111KrUykBgY88sLG5x451RjP6zlmprQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HFOFoMPdAV7jFsbpqva4m0OtuLp3ZFKKqF7KoUd6b+U53CWVyn320qk5WCaaGt/ZRyAKlR9GjPANZVahdEzq5bivfLJ5uLJM8B8ottNyQF6SblHMQOcH/fkFPkzxGft08QNFWSNP15eYWqaocYDxQf3djpnM1lyaHg76pZIN+SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id A4AB9B5A3F;
	Thu,  5 Mar 2026 15:46:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 5F5C918;
	Thu,  5 Mar 2026 15:46:24 +0000 (UTC)
Date: Thu, 5 Mar 2026 10:47:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dmitry Ilvokhin <d@ilvokhin.com>, Dennis Zhou <dennis@kernel.org>, Tejun
 Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng
 <boqun@kernel.org>, Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@meta.com, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 2/3] locking/percpu-rwsem: Extract
 __percpu_up_read_slowpath()
Message-ID: <20260305104703.2a1e8151@gandalf.local.home>
In-Reply-To: <20260304220223.GS606826@noisy.programming.kicks-ass.net>
References: <cover.1772642407.git.d@ilvokhin.com>
	<6b1f1521ca186d5c402a65619d8f30fe83b93bf6.1772642407.git.d@ilvokhin.com>
	<20260304220223.GS606826@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 5F5C918
X-Stat-Signature: 4hnw4cfe9w88jmegwzf81bu64kp1gurp
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+HpKi6jg9NxZeYvZzvI5zrlCwxsTFUgfk=
X-HE-Tag: 1772725584-160659
X-HE-Meta: U2FsdGVkX1/vo6T3T+yuIek1bKKSMPqW9ClvKUbD/u9KLUN2zrHj7XRTbFeVkRtaSFZUOkw0539RDqNm6B207m1bk35iuxf4EGUTuw+XDhzWoTOU8tj3v9jYqdnTLTT7VTiqb4HXVp4wE7ZDusaVw70vI16AfZWUaKQPfB3VZF3sm0LMDmMBzHshvIh7eZRl9Sm5PXhFImNF/H+YoC2hp8sDcCRc4CkqevvjO+kSmbfHywomSMfO3lSy5PqSg6i7dSStj6O5q+He0it6WCjhMI/77NpkQXNdYrCifzUVrEknKsDZEaNkAo5avvJcKA85+SP9HlWuTo1GcfqwE6LBAXHndQewr22fChGGaLE8ghkvpTN+ymuojV3y960dI67n

On Wed, 4 Mar 2026 23:02:23 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

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

I wonder if a cleanup patch should be added to remove the "extern" from the
other functions, as that tends to be the way things are going (hch just
recommended it elsewhere).

> 
> s/_slowpath//, the corresponding down function also doesn't have
> _slowpath on.
> 
> >  static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
> >  {
> >  	rwsem_release(&sem->dep_map, _RET_IP_);  

And since "slowpath" is more descriptive (and used in the rtmutex code),
should that be added too?

-- Steve
