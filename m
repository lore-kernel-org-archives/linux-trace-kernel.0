Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6BE57EDA8
	for <linux-trace-kernel@vger.kernel.org>; Wed,  9 Sep 2026 16:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970275; cv=none; b=bC2M/15Y3h4uH9UXEB/eyJQN5Dabhv8JJ6mzca9dPmBVj+2C+ikro3P9M+rO8PB1IbjrM2L5BpHbrr22ep0pI1lheythFKOfgaUb719Ble+aXAVQ/JyOhD1U1s21mRS3l+z218WOsca2p5j60lq9jO2UEFBbHKdUbniCj4GMAt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970275; c=relaxed/simple;
	bh=fbBXPbFjZbGHpfirqnCsICqoUYycE1qyyMuvgN9FQI8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fE9iLwl1JHLNPU4vK/TsV3WtfVED2US/+nhW3sY+MUe2r2nS5nCrQPTXAv1OF+z0GYe0NXODVHXGj5E4cdLsVnD5EcRhoikBI1h8qlB1378eRSx53H0IFUGSFCCnD3apZ2DTOZ+ccWY69ciIHWGYPhjBpn27jvodeRcMcTm+xw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcPmEnZE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcPmEnZE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C691F00A3A;
	Wed,  9 Sep 2026 16:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788970273;
	bh=1Npj2WBz1s/z3P3qOcP4/+CQJPQ4GF6mfYJSJON6fs0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CcPmEnZEybbCLBwZzN9xKbxQP6haWDn9aC8Y0qzqu7Lx4esukZLQeF4DPJ7e5CIT6
	 L6kpBOYpcZZH5PWd3Njkxajv7TzaXhnGlE8JT9AHxLKdcCjct+xGImcRJwb1Q5ZmJ9
	 IDK31WphBqNUmTAHUsL73ZtbAttqSRrEpHJ8CModcCViB5iCamzJHpGZ51TAdPhdyj
	 6d2Csh4jIVMbawtD19VXu9MBeDFwN2bVsE7i7Kwczj9a0eQvjq0gLmVx1tmdbb+VKw
	 N/x1QYHl/SPEzKQuzhXBEEyoHStZu5wOo4RegXGVHTusZ19aY3Zb1LfjPZMsjxSr8f
	 QrCuU7kdwIR4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] tools/bootconfig: Consolidate xbc_init() to error
 message wrapper
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <178896923375.177508.14682854552827605824.stgit@devnote2>
References: <178896921555.177508.434402948295885560.stgit@devnote2>
 <178896923375.177508.14682854552827605824.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 16:11:12 +0000
Message-Id: <20260909161113.16C691F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Integer overflow in initrd bootconfig size calculation leading to =
a heap buffer overflow.
--

commit 51beb61f7aa059b732b7d7560c90f8155150ccd7
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tools/bootconfig: Consolidate xbc_init() to error message wrapper

Use init_xbc_with_error() for all bootconfig initialization in the
bootconfig tool instead of showing errors in different way.

This simplifies the code logic and make it easy to maintain.

> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> index 6035404733c38..7117aa9b2a839 100644
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
[ ... ]
> @@ -238,52 +278,9 @@ static int load_xbc_from_initrd(int fd, char **buf)
>  		return -EINVAL;
>  	}
> =20
> -	ret =3D xbc_init(*buf, size, &msg, NULL);
> -	/* Wrong data */
> -	if (ret < 0) {
> -		pr_err("parse error: %s.\n", msg);
> -		return ret;
> -	}
> +	ret =3D init_xbc_with_error(*buf, size);

[Severity: High]
This is a pre-existing issue, but is it possible for a 32-bit integer overf=
low
to bypass the size validation check in load_xbc_from_initrd()?

In load_xbc_from_initrd(), size is read from the file as a uint32_t:

tools/bootconfig/main.c:load_xbc_from_initrd() {
    ...
    if (read(fd, &size, sizeof(uint32_t)) < 0)
        return pr_errno("Failed to read size", -errno);
    size =3D le32toh(size);
    ...
    if (stat.st_size < size + BOOTCONFIG_FOOTER_SIZE) {
        pr_err("bootconfig size is too big\n");
        return -E2BIG;
    }
    ...
}

On 32-bit systems, if an attacker crafts size such that adding
BOOTCONFIG_FOOTER_SIZE (20) wraps around (for instance, if size is 0xFFFFFF=
FF),
the stat.st_size < size + BOOTCONFIG_FOOTER_SIZE check can be bypassed.

This would lead to load_xbc_fd() being called with size evaluating to -1:

tools/bootconfig/main.c:load_xbc_fd() {
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

The malloc(size + 1) would result in a 0-byte allocation, while the
read(fd, *buf, size) would cast the negative size to size_t (0xFFFFFFFF) and
overflow the chunk. Finally, (*buf)[size] =3D '\0' would write to a negative
index (-1), which corrupts heap metadata.

Could we make this size check more robust against integer overflow?

> =20
> -	return size;
> -}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178896921555.177508=
.434402948295885560.stgit@devnote2?part=3D2
