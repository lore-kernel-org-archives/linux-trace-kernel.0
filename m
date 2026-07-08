Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550653E122D;
	Wed,  8 Jul 2026 06:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492547; cv=none; b=rUa3q9Vz4Ogp3dtAsH0P7gUyyBK9yTPcp1FFrK4YZ0srOtiblNXO0f7/x0015PjwtdnzxfJ7Lw2YMNDzVCIQKJ4TzFvXevj85V3k7Z1pjCWKh3NAHudJtv4otOQhJXq1pdYsItIWF4lFar3mObOBVUhcJ3SIHU32Yic09sVvxOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492547; c=relaxed/simple;
	bh=2SLEHjvqxwahZHw5fJ0rt5b8i/q3Q53Gs72fUc04WV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AM5ydjLpZag6V+vvMsnXDLAbVFL0k+/a0HJTcoYe5QAgPSonZAGEkNGGKhkZXujwO/0wnv89Cg6c71tb1YEmTZm5RRWJrrVjeZ84srrUI7N3ZK5SZv3Rztj5etEFU/YyDuXKKwdF19A9HLTjUI+GAavh+1CMy5zG1YeuaQfLBPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ary3czBU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ary3czBU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A611F00A3D;
	Wed,  8 Jul 2026 06:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783492542;
	bh=XWmw6MhRs0t0z19SkOsOO9Camu8gGn8nD1+tXIB2gPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ary3czBUrY5BcdJ3bPJlEhOFr7Qcw04lGjDc9MQsKZGy5g1+Dp/Ez09GzJmArhggm
	 tleNdg56kmZuj3eGJ2O5/pzrHjYhaBICFkjn6pHDMqP6q/UTcyS025e43edF6cH+uM
	 f1gXic3Gx44bPepct+tpNB7qDbE6hHVN1WUd9CQPkYrOIw0igHwe0CY3qxyTWTk2Ut
	 I+iqjyhG3QRvZFTD9Ns0Pxuc1yjYyz27HY0UBeT3Spwl8jYgid3Ad/kFtEO/X/oz+c
	 qKMkS7odNKVVb0eJew/2nh7nPJgDR6oyrQpWvgolblZHNv0Y0nGb6yJqYOzWnEZsqE
	 0B5Q6JJuonTJQ==
Date: Wed, 8 Jul 2026 07:35:29 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, akpm@linux-foundation.org, 
	vbabka@kernel.org, surenb@google.com, mhocko@suse.com, jackmanb@google.com, 
	hannes@cmpxchg.org, ziy@nvidia.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, david@kernel.org, liam@infradead.org, rppt@kernel.org, 
	bigeasy@linutronix.de, clrkwllms@kernel.org, Alexander.Krabler@kuka.com
Subject: Re: [RFC PATCH 0/3] mm/compaction: honour
 compact_unevictable_allowed in mlock race and alloc_contig path
Message-ID: <ak3vmMYh2dzO28wJ@lucifer>
References: <20260604023812.3700316-1-chenwandun1@gmail.com>
 <ak3uV7L5EEi3aKyD@lucifer>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak3uV7L5EEi3aKyD@lucifer>

On Wed, Jul 08, 2026 at 07:31:26AM +0100, Lorenzo Stoakes wrote:
> Errr... how does this relate to your other, non-RFC patch series [0] "mm: honour
> compact_unevictable_allowed in mlock and CMA paths"?
>
> Why did you send this separately and why do you not mention the other series
> here or there?
>
> And why is one RFC and the other not?
>
> You really need to add more context like this, I spent quite a bit of time
> reviewing [0] and don't want to find out that actually you are abandoning that
> for this or something?...

Oh hang on... this is old, and [0] is new, my bad.

It just got pinged up my mail client because of recent replies :>)

Thanks, Lorenzo

>
> On Thu, Jun 04, 2026 at 10:38:09AM +0800, Wandun Chen wrote:
> > From: Wandun Chen <chenwandun@lixiang.com>
> >
> > vm.compact_unevictable_allowed=0 is meant to keep compaction from
> > touching unevictable folios. In practice there are still two paths
> > where it does not take effect. This series fixes them and adds a
> > tracepoint to make such issues easier to diagnose in the future.
> >
> > Wandun Chen (3):
> >   mm/compaction: skip isolate mlocked folios when
> >     compact_unevictable_allowed=0
> >   mm/compaction: add per-folio isolation tracepoint
> >   mm/compaction: respect compact_unevictable_allowed in alloc_contig
> >     path
> >
> >  include/linux/compaction.h        |  6 ++++++
> >  include/trace/events/compaction.h | 26 ++++++++++++++++++++++++++
> >  mm/compaction.c                   | 14 +++++++++++---
> >  mm/internal.h                     |  1 +
> >  mm/page_alloc.c                   |  2 ++
> >  5 files changed, 46 insertions(+), 3 deletions(-)
> >
> > --
> > 2.43.0
> >
>
> Thanks, Lorenzo
>
> [0]:https://lore.kernel.org/all/20260707125925.3725177-1-chenwandun1@gmail.com/
