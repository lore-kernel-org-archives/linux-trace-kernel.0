Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4851428690
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Sep 2026 01:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002099; cv=none; b=amIqiniLVBLNs0EarLOXWUkpzWQLOh1ljAINzM06samR3PDTLTOhl51kB2NU52U37EO9+LRC+z3LGYLKhkMeafWFJGlZ5RJ0ljg341qnr9nRTZTBysI7kw6hyxUmkqqgXaagefxNwpOF54nlI5xW062ixtWXsuu4AXAiXUS1pLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002099; c=relaxed/simple;
	bh=T3ssuxuzIXsfw/CO7f2IJAr1mAFcjrG4omLzXViWYYc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dypUvNU+g/T+26Y65yK2ppwNwa4oR3R37KUYv19eyUwfCWbr+JuvnrjewTUWdT7izssZXzW4Qkn0kHjzd7rNH744bHkNpEwqind5UZykpI4SnOeAdgCbTIRtRGyQlPZlCx5doOTCPEZzSPcvm71+pRQXf6NV1e8ttmaakil79Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lx7TMQ+D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lx7TMQ+D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0431F000FF;
	Thu, 10 Sep 2026 01:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789002098;
	bh=ythRq7ach0Zpdxb0IN7EXsqcqEHcZ7PlIQpBZjWOdxM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lx7TMQ+DUL5eZ2Fy0+0QN0agfaqwPK+TPih3jgR5rqtYNEAZPmynVky9sScIDMYtb
	 S98OR/VncrcK7foXQVOsLpv3xZwz/FQDEQ4u1IwHAMXt6bA5fdkT8zwvTq/MtYAoxU
	 SkyhcdkXGCWqLFZugCna46CxzRv716Pox8E3ISkEbP3RsoSf0xDhA1cwvMoCDnjKZV
	 aKDSvfX3XwG6SVqrs51qMC9L1nsMFC8OomYwY4AZcdJjingxHB6uvSIYO2SU1yCD3t
	 NpJLYDPAMaqfqlsWVHzYtLwtfJwwQKASZV9XsBiAn8RhLxJJaX+4la2+QTHfNMXFHA
	 pswzdOVS0nNcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] tools/bootconfig: Fix integer overflow in size check
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <178900114498.187028.9558747732041210116.stgit@devnote2>
References: <178900114498.187028.9558747732041210116.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 01:01:37 +0000
Message-Id: <20260910010137.EE0431F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The integer overflow vulnerability fixed in user-space still exist=
s in the kernel's bootconfig loader (`init/main.c`), allowing a crafted ini=
trd to bypass bounds checks and cause an out-of-bounds read and kernel pani=
c.
- [High] Truncation of `off_t` to `int` causes a heap buffer overflow and u=
nderflow when processing large standalone bootconfig files.
--

commit 1cf2181ef71cd516068d73bd6993bef0811e1b9d
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Subject: tools/bootconfig: Fix integer overflow in size check

This patch fixes an integer overflow vulnerability in load_xbc_from_initrd(=
)=20
within the bootconfig tool. On 32-bit systems, a maliciously large bootconf=
ig=20
size could wrap around, bypassing bounds checks and causing memory corrupti=
on.=20
The fix rejects overly large sizes upfront and verifies against stat.st_siz=
e=20
in a way that avoids underflow.

Closes: https://lore.kernel.org/all/20260909161113.16C691F00A3A@smtp.kernel=
.org/

> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> index 7dc9fff9b6370..bf6a4e2163154 100644
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
> @@ -218,7 +218,8 @@ static int load_xbc_from_initrd(int fd, char **buf)
>  	csum =3D le32toh(csum);
> =20
>  	/* Wrong size error  */
> -	if (stat.st_size < size + BOOTCONFIG_FOOTER_SIZE) {
> +	if (size > XBC_DATA_MAX ||
> +	    size > stat.st_size - BOOTCONFIG_FOOTER_SIZE) {

[Severity: High]
This isn't a bug introduced by this patch, but the exact same integer
overflow vulnerability appears to exist in the kernel's bootconfig loader.

On 32-bit systems, a crafted initrd with a huge bootconfig size
(e.g., 0xFFFFFFFF) can cause the pointer arithmetic to wrap around:

init/main.c:get_boot_config_from_initrd() {
    ...
	data =3D ((void *)hdr) - size;
	if ((unsigned long)data < initrd_start) {
		pr_err("bootconfig size %d is greater than initrd size %ld\n",
    ...
}

Because data wraps around, the bounds check
(unsigned long)data < initrd_start evaluates to false.

The kernel then calls xbc_calc_checksum(data, size), attempting to read
4GB of memory, which hits unmapped pages and triggers a fatal page fault.

Could we apply a similar bounds check to get_boot_config_from_initrd() in
init/main.c?


[Severity: High]
This is a pre-existing issue, but does load_xbc_file() have a truncation
issue that can cause a heap buffer overflow?

When processing large standalone bootconfig files, load_xbc_file() passes
the 64-bit off_t file size into load_xbc_fd(), which expects a 32-bit int:

tools/bootconfig/main.c:load_xbc_file() {
    ...
	ret =3D load_xbc_fd(fd, buf, stat.st_size);
    ...
}

tools/bootconfig/main.c:load_xbc_fd(int fd, char **buf, int size) {
    ...
	*buf =3D malloc(size + 1);
	if (!*buf)
		return -ENOMEM;

	ret =3D read(fd, *buf, size);
	if (ret < 0)
		return -errno;
	(*buf)[size] =3D '\0';
    ...
}

If a user or script runs bootconfig -a on an extremely large file
(exactly 4GB - 1 byte in size), stat.st_size truncates to -1 when
passed as the int size parameter.

malloc(-1 + 1) correctly evaluates to malloc(0) and succeeds.
read(fd, *buf, -1) is then called, where -1 implicitly casts to SIZE_MAX,
causing the kernel to write up to ~2GB of file data into the 0-byte buffer.

Finally, (*buf)[size] =3D '\0' writes a null byte at index -1, corrupting
heap metadata.

Should load_xbc_fd() take a size_t instead of an int?

>  		pr_err("bootconfig size is too big\n");
>  		return -E2BIG;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178900114498.187028=
.9558747732041210116.stgit@devnote2?part=3D1
