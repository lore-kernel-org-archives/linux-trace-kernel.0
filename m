Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDA2322E
	for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Sep 2024 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727015994; cv=none; b=Is7e/s8nCh9E61HoV83cl2QDzSYMRUghDefnI+exLWrVGyRBv1A8cgbp5UxOpd4o9vmK0nDjJd8ePQKICofBOpU75wOP/pSznj0TIhVmraVoTYN84vbzTMarvxubt4HHKgcFx5SnmkgLzdrL8j/fTMHbDAFroZMD1jyrbaqgSWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727015994; c=relaxed/simple;
	bh=JgOeLL0IYvmkBbS/pYNCgrjdwSOsXQKq/hWzgtqUvQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCVwUqoO+KxShHcn5O5AtJ10JwimCzIwNxy9QjCOfT0s/LdxFd/JzgIt5v8z1Tla/qOPeTytpWDHmDd8x1++bTzl5mz7+cXY4I3wi1NwCIh3A7MiRMUkdeovOuNivRYL2l1UDHzCEdf1ZqmUSkq3ioD73v0xEV0N/FfY5CVFa6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RiOdYEiG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RiOdYEiG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727015990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/vzo5yzIRVQBZ2gEsbSHUGsht80CRLIfxnN8cJiG0Sg=;
	b=RiOdYEiGd1Cqg1QDVuGrPpRMaEboPK8cH9mO43lyx9Au9Xj5KJcB84TwGz28BYL/UrkXrz
	Uqgau5oNhtjRD0Z/J7LoHEABeeWmHFIP3Neir3kUgZ2IFZ2EzfrYQ7w/+KzOaR0pzbei25
	mhxf/Ck6HnGTO/QilpZWH0zc9Dpdg1s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-YQ2wLZ_mO7yMR6mnMZ0BdA-1; Sun,
 22 Sep 2024 10:39:44 -0400
X-MC-Unique: YQ2wLZ_mO7yMR6mnMZ0BdA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AEA9618F655A;
	Sun, 22 Sep 2024 14:39:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.28])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0A1BD3000235;
	Sun, 22 Sep 2024 14:39:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 22 Sep 2024 16:39:30 +0200 (CEST)
Date: Sun, 22 Sep 2024 16:39:25 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	"Liao, Chang" <liaochang1@huawei.com>, mhiramat@kernel.org,
	peterz@infradead.org, mark.rutland@arm.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: uprobes: Optimize cache flushes for xol slot
Message-ID: <20240922143858.GD9426@redhat.com>
References: <20240919121719.2148361-1-liaochang1@huawei.com>
 <20240919141824.GB12149@redhat.com>
 <41fdfc47-4161-d2e4-6528-4079b660424f@huawei.com>
 <Zu2VdYrLWTJbVOAt@arm.com>
 <20240920173223.GA20847@redhat.com>
 <20240922140910.GA31288@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240922140910.GA31288@willie-the-truck>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 09/22, Will Deacon wrote:
>
> On Fri, Sep 20, 2024 at 07:32:23PM +0200, Oleg Nesterov wrote:
> > On 09/20, Catalin Marinas wrote:
> > >
> > > On Fri, Sep 20, 2024 at 04:58:31PM +0800, Liao, Chang wrote:
> > > >
> > > >
> > > > 在 2024/9/19 22:18, Oleg Nesterov 写道:
> > > > > On 09/19, Liao Chang wrote:
> > > > >>
> > > > >> --- a/arch/arm64/kernel/probes/uprobes.c
> > > > >> +++ b/arch/arm64/kernel/probes/uprobes.c
> > > > >> @@ -17,12 +17,16 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
> > > > >>  	void *xol_page_kaddr = kmap_atomic(page);
> > > > >>  	void *dst = xol_page_kaddr + (vaddr & ~PAGE_MASK);
> > > > >>
> > > > >> +	if (!memcmp(dst, src, len))
> > > > >> +		goto done;
> > > > >
> > > > > can't really comment, I know nothing about arm64...
> > > > >
> > > > > but don't we need to change __create_xol_area()
> > > > >
> > > > > 	-	area->page = alloc_page(GFP_HIGHUSER);
> > > > > 	+	area->page = alloc_page(GFP_HIGHUSER | __GFP_ZERO);
> > > > >
> > > > > to avoid the false positives?
> > > >
> > > > Indeed, it would be safer.
> > > >
> > > > Could we tolerate these false positives? Even if the page are not reset
> > > > to zero bits, if the existing bits are the same as the instruction being
> > > > copied, it still can execute the correct instruction.
> > >
> > > Not if the I-cache has stale data. If alloc_page() returns a page with
> > > some random data that resembles a valid instruction but there was never
> > > a cache flush (sync_icache_aliases() on arm64), it's irrelevant whether
> > > the compare (on the D-cache side) succeeds or not.
> >
> > But shouldn't the page fault paths on arm64 flush I-cache ?
> >
> > If alloc_page() returns a page with some random data that resembles a valid
> > instruction, user-space can't execute this instruction until
> > special_mapping_fault() installs the page allocated in __create_xol_area().
> >
> > Again, I know nothing about arm64/icache/etc, I am just curious and trying
> > to understand...
>
> We defer the icache maintenance until set_pte_at() time, where we call
> __sync_icache_dcache() if we're installing a present, executable user
> eintry.

And to me this looks as if __sync_icache_dcache() must be called when
user space tries to fault-in the page allocated in __create_xol_area()
and returned by special_mapping_fault().

So I still don't understand the problem.

Oleg.

