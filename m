Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB7837475B;
	Thu, 10 Sep 2026 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050771; cv=none; b=LxlK8GZ3K5Ve01Cwq28YTgGcYIHIovJFx+Zhnuc91iAtU/c6GcKyNoGwEU+0bHkecCuyickfQpdVkUC+qgfi1+H2m2N+WjeYC1x3Rref4elUVxZ6IK4T7yeaCtTsjY4Pt40i2Qbgr9m2rEvWN2nzbwTzOsf4bn+8W4lsH7AWIQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050771; c=relaxed/simple;
	bh=rOx8eV9OuL83QEvT5j9vhIhsiErUhRCiznN3invJ8d0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CsjayvtaTQY3i2i2a+VCOpStvv11qEJ2lCTu5Ln1Yfvn7ohRRZdhYKVS3vARmwOO7J8SSfTsqAWGi00CDIoGiuJFFFPFKDQEOjmIa4taUA57IPyfR32H0YZshor8CXXQZAgxZgmxYYMC5q834Q4OBSVEX+dxDKmpDZAbhjfSy24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9qTJ2+/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9qTJ2+/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEAB1F000FF;
	Thu, 10 Sep 2026 14:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789050769;
	bh=fegjRSkc9C+qKzqCJvJ2d7s7VIC+fu2qJYVP0KhxvSk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=O9qTJ2+/M6LjrIJS6LgFdy5QThbvtHtN0Rdxg8zTDIfimNndVJO/3UgyLx03j3rOP
	 vg0p5EA9ZhFrQDUWnyLJQxJaeeUz5iQC/FGTuNCDBT4OMJM28RHeF7QUnqNRqnm6rV
	 Ix939EETXM3mn3boGPj6TtKJtWlxPYEI0rkWzOrRYJomXoyNhOuYGcy29Hxlo+tk3M
	 lF2Y+7IgDvM2mueV6tmUHaPVsio/BwreqsBf9QRSo+IBMe1lbcDf4qYK9keazupX31
	 KNUaTER7QhY65mXPa9DYPfSSRyTHbpwAHMxiiBwU6x6glz2n2MRwthal6HoUsVDTD1
	 NwlEhTEF586tg==
Date: Thu, 10 Sep 2026 23:32:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] bootconfig: Fix integer overflow in initrd size
 check
Message-Id: <20260910233246.5b9d279ceb72e821ac58d921@kernel.org>
In-Reply-To: <20260910020902.193961F000FF@smtp.kernel.org>
References: <178900555453.200943.4719889510443114485.stgit@devnote2>
	<178900557529.200943.11099215789605267709.stgit@devnote2>
	<20260910020902.193961F000FF@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 10 Sep 2026 02:09:01 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Mismatched boundary checks for XBC_DATA_MAX cause inconsistent fallback behavior for embedded bootconfigs.
> - [Low] Misleading error message when bootconfig size exceeds XBC_DATA_MAX.
> --
> 
> commit a24325c6fe0374f1cfc3fc8cbe63efbad0f22f32
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> bootconfig: Fix integer overflow in initrd size check
> 
> This commit fixes an integer overflow where a crafted initrd with a huge
> bootconfig size can cause pointer arithmetic wrap-around. It ensures the
> initrd bounds are respected and verifies the size does not exceed max limits.
> 
> Closes: https://lore.kernel.org/all/20260910010137.EE0431F000FF@smtp.kernel.org/
> 
> > diff --git a/init/main.c b/init/main.c
> > index a9362b2cc258a..de24c41ce815e 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> 
> [ ... ]
> 
> > @@ -294,16 +295,21 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
> >  
> >  found:
> >  	hdr = (u8 *)(data - 8);
> > +	if ((unsigned long)hdr < initrd_start)
> > +		return NULL;
> > +
> >  	size = get_unaligned_le32(hdr);
> >  	csum = get_unaligned_le32(hdr + 4);
> >  
> > -	data = ((void *)hdr) - size;
> > -	if ((unsigned long)data < initrd_start) {
> > -		pr_err("bootconfig size %d is greater than initrd size %ld\n",
> > +	if (size > XBC_DATA_MAX ||
> 
> [Severity: Medium]
> If the size is exactly equal to XBC_DATA_MAX, this check passes and the
> function returns a valid data pointer. This prevents the caller from falling
> back to the embedded bootconfig:
> 
> init/main.c:setup_boot_config() {
> 	...
> 	data = get_boot_config_from_initrd(&size);
> 	if (!data) {
> 		data = xbc_get_embedded_bootconfig(&size);
> 		...
> 	}
> 	...
> }
> 
> However, setup_boot_config() uses inclusive inequality for XBC_DATA_MAX:
> 
> init/main.c:setup_boot_config() {
> 	...
> 	if (size >= XBC_DATA_MAX) {
> 		pr_err("bootconfig size %ld greater than max size %d\n", ...);
> 		return;
> 	}
> 	...
> }

Hmm, this is wrong. Since XBC_DATA_MAX is including maximum size, 
setup_boot_config() should change this condition.

> 
> Because the limits don't match, an exact size of XBC_DATA_MAX causes
> setup_boot_config() to reject the payload and abort without attempting
> the fallback. Should this check use size >= XBC_DATA_MAX to match?
> 
> > +	    size > ((unsigned long)hdr - initrd_start)) {
> > +		pr_err("bootconfig size %u is greater than initrd size %lu\n",
> > +			size, initrd_end - initrd_start);
> 
> [Severity: Low]
> If this error path is taken specifically because size > XBC_DATA_MAX, the
> error message claims the bootconfig size is greater than the initrd size.
> Can this message be updated to accurately reflect which limit was exceeded?

Ah, good catch :)

Thanks,

> 
> >  		return NULL;
> >  	}
> >  
> > +	data = ((void *)hdr) - size;
> > +
> >  	if (xbc_calc_checksum(data, size) != csum) {
> >  		pr_err("bootconfig checksum failed\n");
> >  		return NULL;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/178900555453.200943.4719889510443114485.stgit@devnote2?part=2


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
