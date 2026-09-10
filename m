Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D345165F16;
	Thu, 10 Sep 2026 00:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788998860; cv=none; b=TCCzVxI4ItSanhVM0pmp2da7lV6jcqhR8wUve4VWhZXRZ3JE5eix5xZFokQ86S/GaIz5jmeqgkYKUbeQED+/dUIJn2jyg8ugw+9qhZyDppPvgohjdCaE/QwBp/MFA70aO3fvJqPGjpNJyaBCi88/HhCfygePXWx8LzsZXHyVAlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788998860; c=relaxed/simple;
	bh=OPZFJNx/s2XWlF51Hy5Gd1Cr3scc8wwvsKweOUdLwSY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KFlNAnz0RlifsMTPfS1XL5Cc1KXbNpLsGks2kNMcT6t1Ka+BP8K+/weETEE78Oz/ie1n6VJWmOssi3/cyN8cROQAeNpB78hMVycrocTtIDh1EW4m4PNQ9wtAxEKCuPW6/3LoIvduYJYvbrVuxx8ksLRE9xZlt5msQoMZtcyJLvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aH4U0svR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aH4U0svR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2461F000FF;
	Thu, 10 Sep 2026 00:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788998852;
	bh=S8zizNtknzRdfObMVl3dtL2J95NxjW9qMbW6IPe+Ih0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aH4U0svRXUfUSaOnD1zdYrDm+Mqe9IGJu07GGsKmAMFXMzz51Ft1DxHw6ueXN/YxA
	 rPq5l+ZblKWH3OP86gXSaDybj28fWOefPlea9jvSLTQyK8f/MHbIUvUXbt4fizPgq/
	 OnWI/rEyiW1DHDsM2JmObCouE9/HR1M46zwsjt+CfUli/Dxu8L35dmIY+wOd0jrWA+
	 qbnWk0Lc3t3uxXF2hB+AXNCJHmgeqy+LC2RTg9zDaU5AXF/AemkaKQCZ9Z3vl3Ofo8
	 SMBWHhPAHYqTAXWdZqNRBsJwuYXrH59i+475xH0SDoTT+vpiMv3ARxkUUdDbkgom+w
	 YTBGTqhtEsF2Q==
Date: Thu, 10 Sep 2026 09:07:29 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] tools/bootconfig: Consolidate xbc_init() to error
 message wrapper
Message-Id: <20260910090729.d18eb065753da71daccefb3f@kernel.org>
In-Reply-To: <20260909161113.16C691F00A3A@smtp.kernel.org>
References: <178896921555.177508.434402948295885560.stgit@devnote2>
	<178896923375.177508.14682854552827605824.stgit@devnote2>
	<20260909161113.16C691F00A3A@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 09 Sep 2026 16:11:12 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Integer overflow in initrd bootconfig size calculation leading to a heap buffer overflow.
> --
> 
> commit 51beb61f7aa059b732b7d7560c90f8155150ccd7
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> tools/bootconfig: Consolidate xbc_init() to error message wrapper
> 
> Use init_xbc_with_error() for all bootconfig initialization in the
> bootconfig tool instead of showing errors in different way.
> 
> This simplifies the code logic and make it easy to maintain.
> 
> > diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> > index 6035404733c38..7117aa9b2a839 100644
> > --- a/tools/bootconfig/main.c
> > +++ b/tools/bootconfig/main.c
> [ ... ]
> > @@ -238,52 +278,9 @@ static int load_xbc_from_initrd(int fd, char **buf)
> >  		return -EINVAL;
> >  	}
> >  
> > -	ret = xbc_init(*buf, size, &msg, NULL);
> > -	/* Wrong data */
> > -	if (ret < 0) {
> > -		pr_err("parse error: %s.\n", msg);
> > -		return ret;
> > -	}
> > +	ret = init_xbc_with_error(*buf, size);
> 
> [Severity: High]
> This is a pre-existing issue, but is it possible for a 32-bit integer overflow
> to bypass the size validation check in load_xbc_from_initrd()?

Oh, I never thought I could shoot myself in the foot like that.

Anyway, since bootconfig file size should be smaller than 32KB,
so we can check the file size before opening it.

> 
> In load_xbc_from_initrd(), size is read from the file as a uint32_t:
> 
> tools/bootconfig/main.c:load_xbc_from_initrd() {
>     ...
>     if (read(fd, &size, sizeof(uint32_t)) < 0)
>         return pr_errno("Failed to read size", -errno);
>     size = le32toh(size);
>     ...
>     if (stat.st_size < size + BOOTCONFIG_FOOTER_SIZE) {
>         pr_err("bootconfig size is too big\n");
>         return -E2BIG;
>     }
>     ...
> }
> 
> On 32-bit systems, if an attacker crafts size such that adding
> BOOTCONFIG_FOOTER_SIZE (20) wraps around (for instance, if size is 0xFFFFFFFF),
> the stat.st_size < size + BOOTCONFIG_FOOTER_SIZE check can be bypassed.
> 
> This would lead to load_xbc_fd() being called with size evaluating to -1:
> 
> tools/bootconfig/main.c:load_xbc_fd() {
>     ...
>     *buf = malloc(size + 1);
>     if (!*buf)
>         return -ENOMEM;
> 
>     ret = read(fd, *buf, size);
>     if (ret < 0)
>         return -errno;
>     (*buf)[size] = '\0';
>     ...
> }
> 
> The malloc(size + 1) would result in a 0-byte allocation, while the
> read(fd, *buf, size) would cast the negative size to size_t (0xFFFFFFFF) and
> overflow the chunk. Finally, (*buf)[size] = '\0' would write to a negative
> index (-1), which corrupts heap metadata.

Good catch!

> 
> Could we make this size check more robust against integer overflow?

 OK, let me fix it too.

Thanks!


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
