Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173C12ED141
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Sep 2026 00:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789000858; cv=none; b=kIS9GTwOZ9bzzzjj9dkLKGQt5aprOUQFWmLWuIoQF3Du9BTou2WPRH6IUkhbvFEwweSmAJvt6sdF1W8FDMy8xIqX7JFeOit5nfPgKm0smC8EAnTwi+et3gPy+gsnIhdA0wGigdD+A8UjaE+PfVVJXDkhxH46uV+txpTUIZE+uAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789000858; c=relaxed/simple;
	bh=74ygga/reqr1ZEsDkm+e0wMz8cJ0eU972ALo5rbotsc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rMecbRszNqF1XMpz+W9Z4SWemX4VvbEb12R2F3lMgXCaqQKobpMfP0Mh4AirRtrtgmoAVgXcoshqamfO4FitnynXoz3LjNYVNUSmaoTBbyYXn70uCn+AtqYFqJmiJEiBj8WdwLpF5pJFbElF9MQ13dLgYbrjee183FfF3xZfRp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pu9nXWdQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pu9nXWdQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE9A1F000FF;
	Thu, 10 Sep 2026 00:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789000856;
	bh=rePHv9eCVyrUL/t2Av8JoORaG5gSxN2vxEfxNiEzjYU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pu9nXWdQ05m76BRnaWs+rxiaaVSP6Cl4GpzBs6wNBJuNxLadfpQa/shNWq7skf2u7
	 xYC/p5j8+ag919SX6F34ysbCTV+nFLFLqJ5gvdoNCCPCAsFJNUDL0do4K0d5YIYLgH
	 hC3luivRmePUusJP7/phJJrd/aF3qqEXNCzcvLeYM8Jw0Xn2qrI1MSD5XQBt+AN1v+
	 C2GVOT4b7VHDsDI6RqFpSudXG4ZRhTRH84DVBflhutZiO1Gv5fpHRnFjso6/XP+Ct5
	 bw0mJqD3UTIFRYM6lSKZEePXNtjr2M3dlwXdS4ydV5kFpyZcqZY2lFj5gaOtlAvijA
	 vQhVv8rMh1x5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tools/bootconfig: Fix integer overflow in size check
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <178900024679.183840.10345859264677533824.stgit@devnote2>
References: <178900024679.183840.10345859264677533824.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 00:40:55 +0000
Message-Id: <20260910004056.6FE9A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete Fix / Integer Truncation Leading to Heap Overflow
--

commit 2d027c4ee8625f17122dea0afb65c1e4b21ae531
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

    tools/bootconfig: Fix integer overflow in size check
   =20
    This commit modifies the size check in load_xbc_from_initrd() to prevent
    an integer overflow on 32-bit systems. It changes the condition to
    subtract BOOTCONFIG_FOOTER_SIZE from stat.st_size instead of adding it
    to the bootconfig size.

    Closes: https://lore.kernel.org/all/20260909161113.16C691F00A3A@smtp.ke=
rnel.org/

> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> index 7dc9fff9b6370..b380ad6777faa 100644
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
> @@ -218,7 +218,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
>  	csum =3D le32toh(csum);
> =20
>  	/* Wrong size error  */
> -	if (stat.st_size < size + BOOTCONFIG_FOOTER_SIZE) {
> +	if (size > stat.st_size - BOOTCONFIG_FOOTER_SIZE) {

[Severity: High]
This is a pre-existing issue, but the fix doesn't seem to completely resolve
the integer truncation and heap overflow vulnerabilities.

Can this size check still be bypassed for large files? Since stat.st_size i=
s a
64-bit off_t, if the file size is larger than 4.29 GB, stat.st_size -
BOOTCONFIG_FOOTER_SIZE can exceed UINT32_MAX. A corrupted uint32_t size of
0xFFFFFFFF would bypass this check because it is always smaller than the
right side.

If bypassed, does passing 0xFFFFFFFF to load_xbc_fd() cause an integer
truncation and heap overflow?

tools/bootconfig/main.c:load_xbc_fd() {
    ...
    static int load_xbc_fd(int fd, char **buf, int size)
    ...
        *buf =3D malloc(size + 1);
        if (!*buf)
            return -ENOMEM;
   =20
        ret =3D read(fd, *buf, size);
    ...
        (*buf)[size] =3D '\0';
    ...
}

Because size is an int, 0xFFFFFFFF is truncated to -1. This results in
malloc(0) which returns a valid heap chunk. The read() call then receives -1
which gets cast to SIZE_MAX, overflowing the heap chunk. Finally, a null by=
te
is written to a negative array index (-1), causing an out-of-bounds write.

Does this same vulnerability also affect load_xbc_file() when processing
standalone files >=3D 2GB?

tools/bootconfig/main.c:load_xbc_file() {
    ...
    ret =3D fstat(fd, &stat);
    ...
    ret =3D load_xbc_fd(fd, buf, stat.st_size);
    ...
}

This implicitly truncates the 64-bit off_t stat.st_size into the 32-bit int
size parameter of load_xbc_fd().

>  		pr_err("bootconfig size is too big\n");
>  		return -E2BIG;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178900024679.183840=
.10345859264677533824.stgit@devnote2?part=3D1
