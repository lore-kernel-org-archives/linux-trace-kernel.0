Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D376F9E8
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781120325; cv=none; b=gXXTLpTttlAUxpZxWqfP3CVCXMsjrnAdhUhJ1pDHNz/58LOV06qPx27ajcqNrm8P0enHXdhq69hT4EmFPdY0XxzP3feK4DMJwrP74XhVTpvcPeRNoE8pROLPg8f5o86AaqcINzIEY+zq8a4YCTlJ83NdPBz6oVvPXL63nKTp9bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781120325; c=relaxed/simple;
	bh=f8alUmU+MCKBx+wztJltfUsqV+k0rQZ/8XYpCmnxPJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5EcNZrNSoDZR53N3+H6wgICuSQ7SlUaqbYTWnZJV8XEDtqaHgKIpUSgHdcJ5sOYTVpBguyl+C97pgRnTo6P8JnEwKg5MF61AlBudgj7z2hh3II8BZxDqHlAkPhbJsf10S651PZu+4lJ+6p6I1thPjb70gI2TlrBxUt949uguNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MNkgL23Y; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MNkgL23Y"
Date: Wed, 10 Jun 2026 12:38:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781120311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NlqXfjmgJLP/Q6k6kAvLcMiBTA3fQFMIe/Jy/ZMH6YY=;
	b=MNkgL23YGeQs7rdqJ/NzOA1ozu1wl7Gki/fXyrtzOFf0AN4RNNuWsTzbOH/GeE6KBpRGnV
	pLqAUiPCEabrG1q+3xcmO2u6AqNjiIRcj6S91RWnhPUak7RKpy/MFyh/K2Av0p04RczBX0
	N/LgJqjNapYS99MxamG+tyqk5sa1xGw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: JP Kobryn <jp.kobryn@linux.dev>
Cc: Barry Song <baohua@kernel.org>, linux-mm@kvack.org, 
	willy@infradead.org, usama.arif@linux.dev, akpm@linux-foundation.org, 
	vbabka@kernel.org, mhocko@suse.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, kasong@tencent.com, qi.zheng@linux.dev, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, chrisl@kernel.org, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, baoquan.he@linux.dev, youngjun.park@lge.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/lruvec: trace LRU add drains and drain-all queuing
Message-ID: <aim8zKzCH7p-6v1h@linux.dev>
References: <20260609041156.31127-1-jp.kobryn@linux.dev>
 <CAGsJ_4xk2Q3xTkQYMPb7rnvnvVsjp24uXRcOja5RxqSbQpdoEg@mail.gmail.com>
 <3e55e520-b979-4b1c-874c-3b4e5ca629e2@linux.dev>
 <d676cf78-4b0a-4d6b-b322-f64826aaca75@linux.dev>
 <aii7WWFmAyoXn9rk@linux.dev>
 <6e7739cc-327e-4ca9-86f4-17729b624632@linux.dev>
 <ffdf9b07-487b-4668-a91b-27b0ab29c70d@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffdf9b07-487b-4668-a91b-27b0ab29c70d@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, Jun 10, 2026 at 12:20:19PM -0700, JP Kobryn wrote:
> On 6/10/26 11:54 AM, JP Kobryn wrote:
> > On 6/9/26 6:21 PM, Shakeel Butt wrote:
> >> On Tue, Jun 09, 2026 at 05:16:15PM -0700, JP Kobryn wrote:
> >>> On 6/9/26 5:07 PM, JP Kobryn wrote:
> >>>> On 6/9/26 12:44 AM, Barry Song wrote:
> >>>>> On Tue, Jun 9, 2026 at 12:12 PM JP Kobryn <jp.kobryn@linux.dev> wrote:
> >>>>>>

[...]

> >>>>> Do you need tracing on each CPU individually, or is tracing the
> >>>>> entire __lru_add_drain_all() invocation sufficient?
> >>>>
> >>>> I think the latter would be fine. The remote work will invoke the
> >>>> mm_lru_add_drain tracepoint, which will show up as kworker stacks. Since
> >>>> the event already has the CPU, we could see where queued drains actually
> >>>> ran.
> >>>
> >>> Actually if it's just a single invocation and the only event data is the
> >>> force flag, a tracepoint may not even be needed. Other probes can be
> >>> installed on function invocation and read the single argument. I can
> >>> drop this from v2 and keep the single mm_lru_add_drain tracepoint.
> >>
> >> No we do want to trace the callers requesting to drain from all the CPUs. If you
> >> trace just lru_add_drain_cpu() then you will only see that the drain is
> >> requested for a given CPU but no information on the requester. 
> >>
> >> Also as Barry said, I think single trace for whole __lru_add_drain_all() is good
> >> enough.
> > 
> > Right, but couldn't that already be done with fentry or kprobe? If we
> > only need the calling stack and the argument value of force_all_cpus I
> > don't see a strong need for a dedicated tracepoint.
> 
> Nevermind that. I see it's declared inline so I'll add a tracepoint and
> send v3.

Thanks. BTW even without inline keyword, compiler can still decide to inline
a function, so kprobe/fentry are not always reliable.
> 
