Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547FE194AC7;
	Thu,  3 Apr 2025 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743660018; cv=none; b=TLbo4a+GIwNIBooaQ7PEiagHHHwKGvkhML4PnGOP4Myl+1jALlYY9mcktQ33fIOzk8wR8F+ghxAZDFUqI6oVanC/NaaIlg8oJ8ObGGQ44x3m7EvDjtwAgAQlLI7WwJnz7OCdL9DnNddc9oqD1WVq8yQbXHLGue93Ddj5tutR/MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743660018; c=relaxed/simple;
	bh=GgGLK/JKAFdo0H9wSAMZLdeL31KlQxn4teieuzIC7e4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KQRf57wG6QAS086LUr/ASYY18toHeX8UZcOV4K9vhuX2FaIU5uDq+HWldBKi3UEIlytLHlLibOzPELOidmj70RCHSybRLHxnigA2gZM5oFEA8gcA14bpSM2PjKtinmUqyKeqdFEFdNqk4r5mYN8F/cBoBTpeigHxSqoV7tdrMhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=gdYF5TZd; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="gdYF5TZd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5NwkqZuewG0v34YS2DSouf6H/+kIB+PU0H+C6MMnpBo=; b=gdYF5TZdvGh9Vwsn8O2FKNpeb4
	UQ9rL8LYkC1s+dWDW0+bG+nYwSBEtkWifq11PtQTeIqvCmHfYpJxJDSH1io13BwcPqWxuWpankDqV
	tXKofZLYSY1EPbR4v05KKktU6v3q2KLPBSqRosSSQlw+HHBIxa+m+yguVd2X6zqrAosfc0BBcPOTx
	5//aIrcnM3WkGfnOT7CXJ1zGO+o9JSMciu/zMwEgbipJ6EeoDL/s3oPx6aOpgLD1EiQwXuolAGaER
	THtitDTc94QXgCbx0U9wxtEroTG9WFv5eCImTRBuv12jshe42t/8SqoDuCrhSk6dxi32GUnxjgZ76
	orbc10aQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u0Dc4-00COSZ-0p;
	Thu, 03 Apr 2025 13:59:41 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 03 Apr 2025 13:59:40 +0800
Date: Thu, 3 Apr 2025 13:59:40 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
	mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
	akpm@linux-foundation.org, vdonnefort@google.com, vbabka@suse.cz,
	rppt@kernel.org, kees@kernel.org, tony.luck@intel.com,
	gpiccoli@igalia.com, linux-hardening@vger.kernel.org,
	willy@infradead.org, Eric Biggers <ebiggers@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code
 do the vmap of physical memory
Message-ID: <Z-4jzImykAbHK2Gz@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg0wQb+CbUk2GY0CeVuTQvq67-oYR0nL8wGgySia3ce7g@mail.gmail.com>
X-Newsgroups: apana.lists.os.linux.kernel

Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> There's a flush_dcache_range() thing too, but I don't see a single use
> of that function in generic code, so I suspect that one is currently
> purely for architecture-specific drivers and doesn't work in egneral.
> 
> So *this* is the kind of "bad in a different way" I could imagine:
> things that probably should be cleaned up and be available to generic
> code, but very few people have cared, and so they are used in ad-hoc
> places and haven't been sufficiently generalized and cleaned up.

There is no fallback implementation of flush_dcache_range for the
architectures that don't need it.

It would be nice to have that, as doing it by hand is pretty silly:

static inline void scatterwalk_done_dst(struct scatter_walk *walk,
					unsigned int nbytes)
{
	scatterwalk_unmap(walk);
	/*
	 * Explicitly check ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE instead of just
	 * relying on flush_dcache_page() being a no-op when not implemented,
	 * since otherwise the BUG_ON in sg_page() does not get optimized out.
	 * This also avoids having to consider whether the loop would get
	 * reliably optimized out or not.
	 */
	if (ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE) {
		struct page *base_page;
		unsigned int offset;
		int start, end, i;

		base_page = sg_page(walk->sg);
		offset = walk->offset;
		start = offset >> PAGE_SHIFT;
		end = start + (nbytes >> PAGE_SHIFT);
		end += (offset_in_page(offset) + offset_in_page(nbytes) +
			PAGE_SIZE - 1) >> PAGE_SHIFT;
		for (i = start; i < end; i++)
			flush_dcache_page(nth_page(base_page, i));
	}

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
