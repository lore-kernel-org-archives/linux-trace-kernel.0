Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3FD3AE6F3;
	Tue,  9 Jun 2026 10:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000504; cv=none; b=MPKI78P4xzmifxCMk8arlS4f98GfaGrS3NyKd9qCVPQ1owfjzS11s7ovwywUoX6j2OfHacku2nBv7QqISwRmjpk3JG1TK/ZkIDzmMqqb0ColP29ZU4F04OXK5XIBjmCNFJqrjXXjI3DMKPcDo0/yONfUlB+AXlL/kXtHmVBY28I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000504; c=relaxed/simple;
	bh=yTbPOFep//xnXucTDWTRchd9BaLydjBq64dWeX2DbsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gss35Ke7WD4aN9E39sCgFwh6Mpu6//hgcPVjZlExg2dyCXyN3iX2H8z021FK7PZJIGsYhMxs+OegaPdT3nsh3BKsQzGmxrOH+ny27VISw5HT0wJoO8ScdsHiPY6uz0XbmBWh9JYUri0PU4zHW2iWY0k0arBJ98s8aNqhVWzDlZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=VhOHgGRx; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="VhOHgGRx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bn99WnrCUkbfsqFDL/rbJh3F4JaVhuaOf+afGyjHySo=; b=VhOHgGRxICUsrfaJgFcDQvvyze
	d9kU96FibEcIKwwIChvLusQP1uyaxogC376OFW/AuBQ4/sC0tjMisozUvLOInxpkQWTJLqQDxZZJt
	9DsEt2XtWd4Aguk3T5BvR8TsEhbi1Xln5HAwjm8PsQTTeiP/t4aBmQQCX4h5y3nVJpqslXa9MHvrz
	JnAK65jAXDj5l0AfPhc+AWdP7ElR7Eds261BEZMueM4J3CH460yFVbQNeSRuPsaDlPGN72UkyZuBG
	q8od3dNXMFHF/CM/cCdTCYcoDvC2X2ESqPKHy2+WIP6zSy9I6UZ80nZcxpw/yldz+Pku6i63nBnY1
	roxpDzkQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wWtaD-008Kc4-2z;
	Tue, 09 Jun 2026 10:21:22 +0000
Date: Tue, 9 Jun 2026 03:21:15 -0700
From: Breno Leitao <leitao@debian.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>
Subject: Re: [PATCH v8 2/6] mm/memory-failure: surface unhandlable kernel
 pages as -ENOTRECOVERABLE
Message-ID: <aifo8HlTY7YBWsrr@gmail.com>
References: <e3d023f1-ab6e-4424-b304-55f1294480c3@kernel.org>
 <33ef8821-c809-b7d1-ea77-6e8a07a6e784@huawei.com>
 <21732071-14a1-486a-951c-34de97b7c757@kernel.org>
 <4b27467e-935f-5587-2f48-5a794c30a592@huawei.com>
 <aiKXrovzrNN-gExm@gmail.com>
 <f1a742be-80cb-4256-b1f9-e50a0f83cb15@kernel.org>
 <aibN4osY_QF1Rejh@gmail.com>
 <4953bcee-5a0f-2bc5-7295-63e5e7513e8b@huawei.com>
 <f2a4d5c8-3d7d-4fc3-8769-66e0c24866fb@kernel.org>
 <f21d7c12-e6c7-49b0-8d83-c26946d0d4ee@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f21d7c12-e6c7-49b0-8d83-c26946d0d4ee@linux.dev>
X-Debian-User: leitao

On Tue, Jun 09, 2026 at 05:08:14PM +0800, Lance Yang wrote:
> 
> 
> On 2026/6/9 15:09, David Hildenbrand (Arm) wrote:
> > On 6/9/26 04:39, Miaohe Lin wrote:
> > > On 2026/6/8 22:15, Breno Leitao wrote:
> > > > On Fri, Jun 05, 2026 at 11:42:53AM +0200, David Hildenbrand (Arm) wrote:
> > > > > 
> > > > > I mean, any such races can currently already happen one way or the other?
> > > > > 
> > > > > Really, the only way to not get races is to tryget the (compound)page,
> > > > > revalidate that the page is still part of the compound page.
> > > > > 
> > > > > I'm not sure if that's really a good idea.
> > > > > 
> > > > > But my memory is a bit vague in which scenarios we already hold a page reference
> > > > > here to prevent any concurrent freeing?
> > > > 
> > > > No, we don't hold one here in the case that matters.
> > > > 
> > > > HWPoisonKernelOwned() runs at the very top of get_any_page(), before
> > > > try_again: and before __get_hwpoison_page(). The first refcount taken in
> > > > the whole path is the folio_try_get() inside __get_hwpoison_page(), which
> > > > runs *after* the short-circuit.
> > > > 
> > > > So get_any_page() itself never holds a reference at the check -- the only way
> > > > one exists is if the caller passed MF_COUNT_INCREASED (count_increased ==
> > > > true).
> > > > 
> > > > So on the MCE/GHES path -- the one this panic option exists for -- no
> > > > reference is held when HWPoisonKernelOwned() does its compound_head() +
> > > > PageSlab()/PageTable()/PageLargeKmalloc() checks.
> > > > 
> > > > Given that, I'd rather keep it racy and take no refcount than add a
> > > > tryget + revalidate purely for this check. As I've said earleir, an operator
> > > 
> > > Would it be acceptable to add a simple recheck? Something like below:
> > > 
> > > retry:
> > > head = compound_head(page);
> > > PageSlab()/PageTable()/PageLargeKmalloc() checks
> > > if (head != compound_head(page))
> > > 	goto retry
> > 
> > Sure. I guess it could still be racy in some weird scenarios where we
> > free+allocate+free in-between.
> 
> +1, sounds reasonable to me. Still racy, but acceptable here I guess :D

Ack. I will post v9 shortly with this plus a couple of selftest fixes
Sashiko flagged.
