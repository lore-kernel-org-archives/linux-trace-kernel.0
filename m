Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0102C9D;
	Mon, 23 Sep 2024 07:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727075943; cv=none; b=bTuUkD6+DotE6bwFkUWNK/3zf3c3m9VY05l9FrfnCHmdD4eBNJECRLAndaGtAYCxVGejb3mJVmm9cc6o2+pssEl3IZE/GmvDloWxEPpMUVViXxIeQuYqw8k+cegADzne6gdX6uf08GZ8Jg0Ytimz0b+eyAa3QeWReTyI0Xa0lIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727075943; c=relaxed/simple;
	bh=Ocmkj+uLEsz/w8DNkQaMK1OQUpnpKXPRPjzpvqt95nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adJK//jMWpjhkHGLt2/ecWvgNSfoInqzV7lQtzY4op2/Tk5F5yy5GBgXChPyLS1F3kdqYYG0chZjlFVymfAwbJNAvUvvHCb4hReS5iRWvhk83lmX06Jnj6REZdMXlGbKr48bqQXPTmhDFLcVhnR4uffJ69dsC5zthZJbj8hHIX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YN2UMLBh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YN2UMLBh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F32C4CEC4;
	Mon, 23 Sep 2024 07:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727075943;
	bh=Ocmkj+uLEsz/w8DNkQaMK1OQUpnpKXPRPjzpvqt95nU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YN2UMLBhxLc5XzD75KU8uuG/rOAxN/48szMddlfjHOqDLGO0VynFHWhco6Jzh5y3j
	 0cdCNhScIbCmy4KQ6nxEBzZcK41rlBTSFDvdwz8wNQuaZvnpdSyHtk11IvEJLpq4fj
	 OTroR5dMo8T3sFtIIlbQMnm2GnXRHsNIjYasHNJwC5zq9hdViXIM4inr1btMIU83P4
	 OEqzB/U+gkAbSQYrX0tqEbpRJsZ9OCSdfdTILVgUV7BOqjKi/6n9en8F9d+CcLFmhp
	 FhqYIZBu352FzndWilH5Uzv3bJfxafmhRnaVo3jbgqFNVyEXaZOGeYaSpwUizjfdlk
	 vsY+6cgC693Vw==
Date: Mon, 23 Sep 2024 08:18:57 +0100
From: Will Deacon <will@kernel.org>
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Oleg Nesterov <oleg@redhat.com>, mhiramat@kernel.org,
	peterz@infradead.org, mark.rutland@arm.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: uprobes: Optimize cache flushes for xol slot
Message-ID: <20240923071856.GA31866@willie-the-truck>
References: <20240919121719.2148361-1-liaochang1@huawei.com>
 <20240919141824.GB12149@redhat.com>
 <41fdfc47-4161-d2e4-6528-4079b660424f@huawei.com>
 <Zu2VdYrLWTJbVOAt@arm.com>
 <b90ce6f1-0d47-2429-5536-a8d5d91d6a70@huawei.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b90ce6f1-0d47-2429-5536-a8d5d91d6a70@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Sep 23, 2024 at 09:57:14AM +0800, Liao, Chang wrote:
> 在 2024/9/20 23:32, Catalin Marinas 写道:
> > On Fri, Sep 20, 2024 at 04:58:31PM +0800, Liao, Chang wrote:
> >> 在 2024/9/19 22:18, Oleg Nesterov 写道:
> >>> On 09/19, Liao Chang wrote:
> >>>> --- a/arch/arm64/kernel/probes/uprobes.c
> >>>> +++ b/arch/arm64/kernel/probes/uprobes.c
> >>>> @@ -17,12 +17,16 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
> >>>>  	void *xol_page_kaddr = kmap_atomic(page);
> >>>>  	void *dst = xol_page_kaddr + (vaddr & ~PAGE_MASK);
> >>>>
> >>>> +	if (!memcmp(dst, src, len))
> >>>> +		goto done;
> >>>
> >>> can't really comment, I know nothing about arm64...
> >>>
> >>> but don't we need to change __create_xol_area()
> >>>
> >>> 	-	area->page = alloc_page(GFP_HIGHUSER);
> >>> 	+	area->page = alloc_page(GFP_HIGHUSER | __GFP_ZERO);
> >>>
> >>> to avoid the false positives?
> >>
> >> Indeed, it would be safer.
> >>
> >> Could we tolerate these false positives? Even if the page are not reset
> >> to zero bits, if the existing bits are the same as the instruction being
> >> copied, it still can execute the correct instruction.
> > 
> > Not if the I-cache has stale data. If alloc_page() returns a page with
> > some random data that resembles a valid instruction but there was never
> > a cache flush (sync_icache_aliases() on arm64), it's irrelevant whether
> > the compare (on the D-cache side) succeeds or not.
> 
> Absolutly right, I overlooked the comparsion is still performed in the D-cache.
> However, the most important thing is ensuring the I-cache sees the accurate bits,
> which is why a cache flush in necessary for each xol slot.
> 
> > 
> > I think using __GFP_ZERO should do the trick. All 0s is a permanently
> > undefined instruction, not something we'd use with xol.
> 
> Unfortunately, the comparison assumes the D-cache and I-cache are already
> in sync for the slot being copied. But this assumption is flawed if we start
> with a page with some random bits and D-cache has not been sychronized with
> I-cache. So, besides __GFP_ZERO, should we have a additional cache flush
> after page allocation?

No, I think Oleg's right. The initial cache maintenance will happen when the
executable pte is installed. However, we should use __GFP_ZERO anyway
because I don't think it's a good idea to map an uninitialised page into
userspace.

Will
