Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892564A33;
	Thu, 26 Feb 2026 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772119265; cv=none; b=dG/HhPGW2esQb9afX0exelh7wGOTWNtS4lXI8PHbKkaKCrrMhRXI98mMROyh3C5bJI+yvskLyqvQls0nQAMNGNrJwvAoeuLxefip9iIYQmXO1HmmFIUqNbQ3KXYhxst17QHAYwqpTFLXgB28si7kwWrxtpXyzBo1k/gSFC9/+bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772119265; c=relaxed/simple;
	bh=1hceql6V+qK3bJedOl1YkRDNlU2Ri4mwQkIXFgq1Eik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSxO28/8apuqf2U8gzQwmiGE1TNlggfaeI2mVtML+WGWcZ0FdjBtieT4cgKh0s1kdbtqDjNMgdImMrmfju9hozoJZ1VChAJg4EwsxOXtKsnQVd3LwtK23b+nQlotE6g4yu4GhvRSSQmDUSmZ+iglXBhOAq3lnsRsI4K2vW1KMyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=mIZhFrh0; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="mIZhFrh0"
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 81AF4B2CAA;
	Thu, 26 Feb 2026 15:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1772119255;
	bh=96bMLt1vc+CQTxpugO4N1U1WWnL6JTb1Hqk9UYVV66k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mIZhFrh05aUyF/HK0rWw/gi4f2rji4Hsjriiuv1EXhc0M6f6cwDcwZkyagYwoJA7h
	 iPb5AKgAqqNAEgHesIpSbxIxeGq5L5jsLf0mZWLkfgIUbHqSn/qgQ5kD93RR+/K/N/
	 xJdcq6T/DKzG9QNzrXIshckbpzNDGVCgi+Hw4G1Y=
Date: Thu, 26 Feb 2026 15:20:54 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	kernel-team@meta.com, Benjamin Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v2 1/4] mm: introduce zone lock wrappers
Message-ID: <aaBk1sVcy87EPQ2D@shell.ilvokhin.com>
References: <cover.1772030186.git.d@ilvokhin.com>
 <5bcc39cd3a227944d0fbe75ff86cdac92b38d4ca.1772030186.git.d@ilvokhin.com>
 <20260225121421.2eb75a94578af35780978851@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225121421.2eb75a94578af35780978851@linux-foundation.org>

On Wed, Feb 25, 2026 at 12:14:21PM -0800, Andrew Morton wrote:
> On Wed, 25 Feb 2026 14:43:03 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:
> 
> > Add thin wrappers around zone lock acquire/release operations. This
> > prepares the code for future tracepoint instrumentation without
> > modifying individual call sites.
> > 
> > Centralizing zone lock operations behind wrappers allows future
> > instrumentation or debugging hooks to be added without touching
> > all users.
> > 
> > No functional change intended. The wrappers are introduced in
> > preparation for subsequent patches and are not yet used.
> > 
> > ...
> >
> > +static inline void zone_lock_init(struct zone *zone)
> > +{
> > +	spin_lock_init(&zone->lock);
> > +}
> 
> Please consider renaming zone.lock to something else (_lock would be
> conventional) so that any present and future and out-of-tree
> unconverted code won't compile.
>

Thanks for suggestion, Andrew! Makes total sense to me, I'll rename lock
to _lock in v3.
