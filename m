Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6056A267B89;
	Thu, 10 Sep 2026 01:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002215; cv=none; b=HhN9HE/2fawZHn7peJbvGb9321JX+sAfcuMkYh7d3T4vUFTQG5tsJRDiGUa/tpLl/HoEfWr8GWFIfJCay1cWrx9uHYpU+JiWMkAKRG3Ul6q/ogfA+52RFnXfOCipmJzLg4yf5/FGKELSYgqO28+DXU51qZ9Ojt1ZXn8HY7V/gS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002215; c=relaxed/simple;
	bh=ADJhxUtLRDyWlgEf0CeEegaEyhOB4J5XHSA9MvQ0tKg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ABVSJgd8cDwdJU3yfZ09MDsjtZctXbmIiw1Agz4Y4S7biKHjeG1CsHg76LeqZuHXCvhc7x3kcaOSU5bfTvkJAbcVFSwp1yqjAzVo6JojiKhSR1it+WA4FuCaR2F/ysK3uZVD4DjGPyu12KFRNE4z1f/Pu72hqmzJaxScZbbz9sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJrKOsUR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJrKOsUR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B3C1F000FF;
	Thu, 10 Sep 2026 01:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789002214;
	bh=E8+04fuszkT0UeBchr03/C/oM1JRnPox0VjsrG+dofw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jJrKOsURWE6lYbAn2ZVeXuQd+FHLTNNvecORqcfffBcG2t5A3pbSjJTH9669EPdLs
	 0LRumXc1PcXA7IDhjBRu6Y9V4MBm8QsMRB0qkaV9NtcvFx9Jh7yCLe/AHdrzg2rFWv
	 6caFhZBkzda1z6gv3JBYxRn73W16bZFLcZYm6lGBVRWGw4DG3SNb/cAWf7uEXLhEXj
	 OPbZdmUyJKsShzz9C4UZCiHtI2hPMWs1/OuaYABSFaDKC50KO73iruXxqxfjEy6O4J
	 XA7blVtLciZ/Qs7ZbDADKYiXjvka+0lDM2O/MAYEDnFePNafzFFZC+yoAQ6lulnD0h
	 vhFMUNjv5JplA==
Date: Thu, 10 Sep 2026 10:03:31 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/bootconfig: Fix integer overflow in size check
Message-Id: <20260910100331.c2d39516cead6c1e1fd00f78@kernel.org>
In-Reply-To: <20260910004056.6FE9A1F000FF@smtp.kernel.org>
References: <178900024679.183840.10345859264677533824.stgit@devnote2>
	<20260910004056.6FE9A1F000FF@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 00:40:55 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Incomplete Fix / Integer Truncation Leading to Heap Overflow
> --
> 
> commit 2d027c4ee8625f17122dea0afb65c1e4b21ae531
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
>     tools/bootconfig: Fix integer overflow in size check
>     
>     This commit modifies the size check in load_xbc_from_initrd() to prevent
>     an integer overflow on 32-bit systems. It changes the condition to
>     subtract BOOTCONFIG_FOOTER_SIZE from stat.st_size instead of adding it
>     to the bootconfig size.
> 
>     Closes: https://lore.kernel.org/all/20260909161113.16C691F00A3A@smtp.kernel.org/
> 
> > diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> > index 7dc9fff9b6370..b380ad6777faa 100644
> > --- a/tools/bootconfig/main.c
> > +++ b/tools/bootconfig/main.c
> > @@ -218,7 +218,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
> >  	csum = le32toh(csum);
> >  
> >  	/* Wrong size error  */
> > -	if (stat.st_size < size + BOOTCONFIG_FOOTER_SIZE) {
> > +	if (size > stat.st_size - BOOTCONFIG_FOOTER_SIZE) {
> 
> [Severity: High]
> This is a pre-existing issue, but the fix doesn't seem to completely resolve
> the integer truncation and heap overflow vulnerabilities.
> 
> Can this size check still be bypassed for large files? Since stat.st_size is a
> 64-bit off_t, if the file size is larger than 4.29 GB, stat.st_size -
> BOOTCONFIG_FOOTER_SIZE can exceed UINT32_MAX. A corrupted uint32_t size of
> 0xFFFFFFFF would bypass this check because it is always smaller than the
> right side.
> 
> If bypassed, does passing 0xFFFFFFFF to load_xbc_fd() cause an integer
> truncation and heap overflow?
> 
> tools/bootconfig/main.c:load_xbc_fd() {
>     ...
>     static int load_xbc_fd(int fd, char **buf, int size)
>     ...
>         *buf = malloc(size + 1);
>         if (!*buf)
>             return -ENOMEM;
>     
>         ret = read(fd, *buf, size);
>     ...
>         (*buf)[size] = '\0';
>     ...
> }
> 
> Because size is an int, 0xFFFFFFFF is truncated to -1. This results in
> malloc(0) which returns a valid heap chunk. The read() call then receives -1
> which gets cast to SIZE_MAX, overflowing the heap chunk. Finally, a null byte
> is written to a negative array index (-1), causing an out-of-bounds write.

This part should be fixed in v2. But below is another problem.

> 
> Does this same vulnerability also affect load_xbc_file() when processing
> standalone files >= 2GB?
> 
> tools/bootconfig/main.c:load_xbc_file() {
>     ...
>     ret = fstat(fd, &stat);
>     ...
>     ret = load_xbc_fd(fd, buf, stat.st_size);
>     ...
> }
> 
> This implicitly truncates the 64-bit off_t stat.st_size into the 32-bit int
> size parameter of load_xbc_fd().
> 
> >  		pr_err("bootconfig size is too big\n");
> >  		return -E2BIG;
> >  	}

OK, let me update the patch.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
