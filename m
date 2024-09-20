Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215E4F4ED;
	Fri, 20 Sep 2024 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726846330; cv=none; b=irkB82vnY5cqPb1AK6nugH/cekz5dfjf11eB3J4bsg59+LTHAr/R77Daaw7P1z72002aEiRlLN1noV624kqO8wlRoc7EJhEF6HdcLJrkGLoH9kxysZvDIGCLAWVaw0HpJoxgEWXna9YJ06n62tm1/eHD12XOC2CliBlsHWBVnGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726846330; c=relaxed/simple;
	bh=JF70X+ZLnqUMZXHEnErPBJDFd27FkBHHnqQIZJKM0Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ie65hWiuRPmrVc0bkEKQ4kNPaxhW+XWz8Z7eJtHorCQVBoOzPoWb4tyubl3nKfFiAfhmGaPNT+M12sS8z/f8yFbXMglPu2N0HZQn3A9Isvhrtum40HRF6cCn4JPjh9H2CXMLvSfQyvYPDgQNgyPu75EvMPWg4XowPzp/Nz7roIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C405C4CEC3;
	Fri, 20 Sep 2024 15:32:07 +0000 (UTC)
Date: Fri, 20 Sep 2024 16:32:05 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: Oleg Nesterov <oleg@redhat.com>, mhiramat@kernel.org,
	peterz@infradead.org, will@kernel.org, mark.rutland@arm.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: uprobes: Optimize cache flushes for xol slot
Message-ID: <Zu2VdYrLWTJbVOAt@arm.com>
References: <20240919121719.2148361-1-liaochang1@huawei.com>
 <20240919141824.GB12149@redhat.com>
 <41fdfc47-4161-d2e4-6528-4079b660424f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41fdfc47-4161-d2e4-6528-4079b660424f@huawei.com>

On Fri, Sep 20, 2024 at 04:58:31PM +0800, Liao, Chang wrote:
> 
> 
> 在 2024/9/19 22:18, Oleg Nesterov 写道:
> > On 09/19, Liao Chang wrote:
> >>
> >> --- a/arch/arm64/kernel/probes/uprobes.c
> >> +++ b/arch/arm64/kernel/probes/uprobes.c
> >> @@ -17,12 +17,16 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
> >>  	void *xol_page_kaddr = kmap_atomic(page);
> >>  	void *dst = xol_page_kaddr + (vaddr & ~PAGE_MASK);
> >>
> >> +	if (!memcmp(dst, src, len))
> >> +		goto done;
> > 
> > can't really comment, I know nothing about arm64...
> > 
> > but don't we need to change __create_xol_area()
> > 
> > 	-	area->page = alloc_page(GFP_HIGHUSER);
> > 	+	area->page = alloc_page(GFP_HIGHUSER | __GFP_ZERO);
> > 
> > to avoid the false positives?
> 
> Indeed, it would be safer.
> 
> Could we tolerate these false positives? Even if the page are not reset
> to zero bits, if the existing bits are the same as the instruction being
> copied, it still can execute the correct instruction.

Not if the I-cache has stale data. If alloc_page() returns a page with
some random data that resembles a valid instruction but there was never
a cache flush (sync_icache_aliases() on arm64), it's irrelevant whether
the compare (on the D-cache side) succeeds or not.

I think using __GFP_ZERO should do the trick. All 0s is a permanently
undefined instruction, not something we'd use with xol.

-- 
Catalin
