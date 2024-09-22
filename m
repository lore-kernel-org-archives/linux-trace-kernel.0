Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888C163D;
	Sun, 22 Sep 2024 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727014157; cv=none; b=DbMwrq/2OUFSngnqP/ZlNFbf7NxAs35ntvxClxCIq7+F3n3XSmqMWFYwGW6VvGutWEBS80DKxmuBSXXpfNqcOtA3nQsrX/ZTS64x1ekXoT7f7oaAFaTSMpx0kL5Hj9XhhP84h3Pe44jFdcQTP1YqK8Hs0E/TGV5JCPlkZ78bgkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727014157; c=relaxed/simple;
	bh=4cbjSwV1hEvFOITCR8e5fXcH066EpaFxjqWOysM0esY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ownhcWFdUz+UDC36jnN79g0Cnv0Y1Y1reNwVkntWs+hi0U+/kQBpz2ApQxfVNqByTgvmxXZesEcDN+kdL8zbxZQo8AWjG1X0M1/3bXm01d1jqFwn1JjzNJmKfwA+0E16tgsz2z7TVklwH827YwCXkdZOASsD3rtO/L/hH76M5xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMigkMuG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMigkMuG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3280DC4CEC3;
	Sun, 22 Sep 2024 14:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727014157;
	bh=4cbjSwV1hEvFOITCR8e5fXcH066EpaFxjqWOysM0esY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FMigkMuGQUnyYCLlp7jO+pCXv0G1eCStZn9Nw28iipxMY/8jhNOsZPyHYzRqKfeYM
	 A/iuWlWPSQnINyhvoA9Nqdyy4fnSXaYtM0417eaAghJ7jewTPz7ydwAreS5IR92OK2
	 KcyKoep+Gdv26ym4VgcsSeLKV9NgXOJlWgBwy8Z+u/SJXbeR+2aGSmKaQtfJ04NXGs
	 e1qPmB59epal/QmckXkPI0u2E39FY7Gr8TibWxdPxwABNHLkeGSYdYI39aDazo2Pg2
	 vJAP000d89l7xGF4sXC84/eR1PZU+jLHcToEDVJMHscV1tipSKOOUqQUqkufSAEqFM
	 lWK/opz17Wj9g==
Date: Sun, 22 Sep 2024 15:09:11 +0100
From: Will Deacon <will@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	"Liao, Chang" <liaochang1@huawei.com>, mhiramat@kernel.org,
	peterz@infradead.org, mark.rutland@arm.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: uprobes: Optimize cache flushes for xol slot
Message-ID: <20240922140910.GA31288@willie-the-truck>
References: <20240919121719.2148361-1-liaochang1@huawei.com>
 <20240919141824.GB12149@redhat.com>
 <41fdfc47-4161-d2e4-6528-4079b660424f@huawei.com>
 <Zu2VdYrLWTJbVOAt@arm.com>
 <20240920173223.GA20847@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240920173223.GA20847@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Sep 20, 2024 at 07:32:23PM +0200, Oleg Nesterov wrote:
> On 09/20, Catalin Marinas wrote:
> >
> > On Fri, Sep 20, 2024 at 04:58:31PM +0800, Liao, Chang wrote:
> > >
> > >
> > > 在 2024/9/19 22:18, Oleg Nesterov 写道:
> > > > On 09/19, Liao Chang wrote:
> > > >>
> > > >> --- a/arch/arm64/kernel/probes/uprobes.c
> > > >> +++ b/arch/arm64/kernel/probes/uprobes.c
> > > >> @@ -17,12 +17,16 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
> > > >>  	void *xol_page_kaddr = kmap_atomic(page);
> > > >>  	void *dst = xol_page_kaddr + (vaddr & ~PAGE_MASK);
> > > >>
> > > >> +	if (!memcmp(dst, src, len))
> > > >> +		goto done;
> > > >
> > > > can't really comment, I know nothing about arm64...
> > > >
> > > > but don't we need to change __create_xol_area()
> > > >
> > > > 	-	area->page = alloc_page(GFP_HIGHUSER);
> > > > 	+	area->page = alloc_page(GFP_HIGHUSER | __GFP_ZERO);
> > > >
> > > > to avoid the false positives?
> > >
> > > Indeed, it would be safer.
> > >
> > > Could we tolerate these false positives? Even if the page are not reset
> > > to zero bits, if the existing bits are the same as the instruction being
> > > copied, it still can execute the correct instruction.
> >
> > Not if the I-cache has stale data. If alloc_page() returns a page with
> > some random data that resembles a valid instruction but there was never
> > a cache flush (sync_icache_aliases() on arm64), it's irrelevant whether
> > the compare (on the D-cache side) succeeds or not.
> 
> But shouldn't the page fault paths on arm64 flush I-cache ?
> 
> If alloc_page() returns a page with some random data that resembles a valid
> instruction, user-space can't execute this instruction until
> special_mapping_fault() installs the page allocated in __create_xol_area().
> 
> Again, I know nothing about arm64/icache/etc, I am just curious and trying
> to understand...

We defer the icache maintenance until set_pte_at() time, where we call
__sync_icache_dcache() if we're installing a present, executable user
eintry. That also elides the maintenance if PG_arch_1 is set (i.e. the
kernel only takes responsibility for the freshly allocated page).

Will

> 
> Oleg.
> 
