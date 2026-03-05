Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119C8379EC4;
	Thu,  5 Mar 2026 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726773; cv=none; b=XErk9SR0AqNw89OJxpNpe0TSgw+EuI8f7XwO89fdjXPb4rvHUA3EHQbXR/aDQ/5oQxRv7G/+f1kK6OWVSUPIaYQCjGcDPeI5OQRlMzYMA52hyzTZ80gZ4uZ8I8yck9QNk3ctQhOLQvkFOzIy4E2y3Xh1FubUnTjm/8g+N/ZqpWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726773; c=relaxed/simple;
	bh=Z3x+Se9yIuwlUrw5IJht45f+3n/jmFguEMA2zfjsXPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHv/uvrAMahLl4BYMAsep0hFpBuBzVcCIA0FQcsZs/kGp+SaiKDQUNa4Gg34j0yzP3Wf9/G+Vf0gChbQKLmWK+HZHcOaGIh2Cj4U/Wb7gxdM0pVmaltnYSzkQgvWjBMM9O7QBV57WDNMnF7W75FFYAT+dzkO7nfYxFxqYz5qwYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G48/mJtC; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G48/mJtC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yoXLVExaeD40rMm6BLEsNzbF/cVQ2Kh2LQ9L0d5YO00=; b=G48/mJtCY4pqf4sNMBVKTL4lmv
	LbtVcnZiyUmaBFfgSm6dkg7BW7aG+WGFTW2qN2xc/0+Qch05f4jp/nzx+N8dKAM2Q56QErHm63Yym
	jXoeQQu3Lx+HUMsyF/kknumyDtn3MaLldp1kF9wqQoB8SEzZeO8VtpzocDTC8f8JUPGc0zd9PQPFs
	BTBPAk4HV3x7SEI+FRhEO7DJtEXVPr50Qdv7cx3S+TVPoXb7VO98ursViRK/1xiTfwDz3b2GFCaWl
	8xwyr4LAmRRPc6u72ab28Ni5FJjOlhqeRd3BTZhNsbLAJiDeLm1ceXTDPHbaCwHI09XM2IcKuylBK
	MpJNh4JA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyBD5-00000007A4B-0rha;
	Thu, 05 Mar 2026 16:05:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 97952300182; Thu, 05 Mar 2026 17:05:58 +0100 (CET)
Date: Thu, 5 Mar 2026 17:05:58 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Dmitry Ilvokhin <d@ilvokhin.com>, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 2/3] locking/percpu-rwsem: Extract
 __percpu_up_read_slowpath()
Message-ID: <20260305160558.GD2277644@noisy.programming.kicks-ass.net>
References: <cover.1772642407.git.d@ilvokhin.com>
 <6b1f1521ca186d5c402a65619d8f30fe83b93bf6.1772642407.git.d@ilvokhin.com>
 <20260304220223.GS606826@noisy.programming.kicks-ass.net>
 <20260305104703.2a1e8151@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305104703.2a1e8151@gandalf.local.home>

On Thu, Mar 05, 2026 at 10:47:03AM -0500, Steven Rostedt wrote:
> On Wed, 4 Mar 2026 23:02:23 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
> > > index c8cb010d655e..89506895365c 100644
> > > --- a/include/linux/percpu-rwsem.h
> > > +++ b/include/linux/percpu-rwsem.h
> > > @@ -107,6 +107,8 @@ static inline bool percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
> > >  	return ret;
> > >  }
> > >  
> > > +void __percpu_up_read_slowpath(struct percpu_rw_semaphore *sem);
> > > +  
> > 
> > extern for consistency with all the other declarations in this header.
> 
> I wonder if a cleanup patch should be added to remove the "extern" from the
> other functions, as that tends to be the way things are going (hch just
> recommended it elsewhere).

Well, I rather like the extern. But yeah, I know hch does not agree.

> > 
> > s/_slowpath//, the corresponding down function also doesn't have
> > _slowpath on.
> > 
> > >  static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
> > >  {
> > >  	rwsem_release(&sem->dep_map, _RET_IP_);  
> 
> And since "slowpath" is more descriptive (and used in the rtmutex code),
> should that be added too?

It already has __ prefix, no point in making the name even longer for no
real benefit.
