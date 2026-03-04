Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E70E13B284;
	Wed,  4 Mar 2026 22:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661758; cv=none; b=gfgUlBys2hplZSzWYnVDaRPRx7l2CB1d7zxlIVIznn+cjQOvk0C8aJuw4C/0C7BUyoKNaRirn43kJtpRJgo619GnXyXcczBuzM08V8knQz/Brey1SD3jdOg5K09dMo3c6A5jaAWDerYbu7nP6sbFPEIwK2NIH/oP/wu/Pee8WHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661758; c=relaxed/simple;
	bh=QWcH9JKb0wKCDyWAEcEDbNAIl5GCGuh6FDwoc6j/OwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fa5aK6JxUD1MIHXH0YhK9ujgSUD9BUBYYmPBbXagWYNe3D5sHSwYoG4NUnhP6Wo9f0jHof7BL8QUvW+L/KMRdohOh3N4GJokWh48aBnDYKeS3UT4nymdd8ojksL4yzHx2HvhfSIRrVKiZNAyTA53Sz9nvQS8fKdaNTTrQBb/a1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UCFQqR2b; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UCFQqR2b"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ubkGAWt2PwudxcJDXQT+2LLWc96LXI7vXpBVWksTJYo=; b=UCFQqR2bTe9XmtGEiZYtTn0v4w
	f4LdyQl21LILBx9U+HMBFaOSkBlkopYOfYo7MCOvv7L8ify84nmdvZZWMlXQMvDkuQlL+TKdDU+2I
	r7VX7aEO7OaXoJPsicSCCyo6py+RpZxEffMVB5aofq8cytNJi0rmeWWU86F33ffrdpeF/vrhSm+rB
	og4CSK4DvYq9cZenK7rLBkJgoLEZvcdmIn3Gc7JhngdDQsRYNSDj32pat4BkhJMlsFmQEkn5nZrHN
	L/lZq98uVYGkAFaSMR2/yELZ2iGMYYmJzHsbNLvYLLF2kafJqC0JvPQwCkHoupBpQhj0+jeSTXusR
	iC9ZyQrQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxuIS-0000000Dxjp-3DuG;
	Wed, 04 Mar 2026 22:02:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9FA22300B40; Wed, 04 Mar 2026 23:02:23 +0100 (CET)
Date: Wed, 4 Mar 2026 23:02:23 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>
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
Message-ID: <20260304220223.GS606826@noisy.programming.kicks-ass.net>
References: <cover.1772642407.git.d@ilvokhin.com>
 <6b1f1521ca186d5c402a65619d8f30fe83b93bf6.1772642407.git.d@ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b1f1521ca186d5c402a65619d8f30fe83b93bf6.1772642407.git.d@ilvokhin.com>

On Wed, Mar 04, 2026 at 04:56:16PM +0000, Dmitry Ilvokhin wrote:
> Move the percpu_up_read() slowpath out of the inline function into a new
> __percpu_up_read_slowpath() to avoid binary size increase from adding a
> tracepoint to an inlined function.
>
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> ---
>  include/linux/percpu-rwsem.h  | 15 +++------------
>  kernel/locking/percpu-rwsem.c | 18 ++++++++++++++++++
>  2 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
> index c8cb010d655e..89506895365c 100644
> --- a/include/linux/percpu-rwsem.h
> +++ b/include/linux/percpu-rwsem.h
> @@ -107,6 +107,8 @@ static inline bool percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
>  	return ret;
>  }
>  
> +void __percpu_up_read_slowpath(struct percpu_rw_semaphore *sem);
> +

extern for consistency with all the other declarations in this header.

s/_slowpath//, the corresponding down function also doesn't have
_slowpath on.

>  static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
>  {
>  	rwsem_release(&sem->dep_map, _RET_IP_);
