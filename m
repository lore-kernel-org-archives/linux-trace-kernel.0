Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA47C3793BF
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Oct 2026 22:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791413244; cv=none; b=JY4qZegzo5P0HhC7swFda6VdQTlgk3BgvWa3oB3rcT0znO61iR3eOIUPtUVy+vF0Q3Nz3Fe8yvdGpCujLUYdqhOd0UnnpXN8TYaGznimlljJ5bX9+nG0RdS1SK6SzYKEch/KiTZkTqFPgHT9Ma8bKJpD6gt78nb6R0GNjVuXUdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791413244; c=relaxed/simple;
	bh=1kTuoMjqwhV083iMxzIYheRV9mR3sRoaNzTQaU7dpDY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=CqKJ1xdcPp3bYIx6U7UFoDId98vNaeNnuPJijbX8JUW8eazdtq9fHN/+Kd6kK4LNugpWzS1cvmE6qxTS7n8egwqoTW6JZtFqobhIL2UCISeX9hXGAt0PRHeQ6/qHDw8Q3dw6IbsdDhrdlrtypRviyt2nRXQWwsXQhMeNtP4sbuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6tliXww; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6tliXww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3871F000FF;
	Wed,  7 Oct 2026 22:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791413243;
	bh=eZHuGrSqmh/C/1VcENUy6pdX921dJUkKR9TWl8N+Uo8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O6tliXwwDSFblOcjqU1XSYrsQtSGjfYhXo/Ri0CjRnRoOGjXRtDWOt61oeTI+kogL
	 ELW7wfUCAxAZX87ZAOKjftAJAM9OEn5Ki+bgk5N+MNNgHytNdD9cJb8QXVniZcPVmj
	 ypI0jgTIHY1YSsfOKqdQN5oT9tiGEdeHG0LGNBEP5rfyHLrfdrGhjC0OVRpufwsCaz
	 0qsz8pl9Y9LJY5en7pqLYCGkEyb1VB/rHI7QtrfIRRH9ETejzFWcrAep6JZH2IUNQn
	 UAOUHwyH5p47cdxXuQC/P3oYdSFG/X/eMqm58tGmqfuaglcNOTzmzgNo1IewGddiTF
	 BiCt1ABhkPsFw==
Message-ID: <sashiko-outbox-163422@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] alloc_tag: Extend allocinfo_filter to support
 tracing queries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abhishek Bapat" <abhishekbapat@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <aae089a81ea891e1bc7e3ad171064d37d800ad1a.1791410886.git.abhishekbapat@google.com>
References: <cover.1791410885.git.abhishekbapat@google.com>
 <aae089a81ea891e1bc7e3ad171064d37d800ad1a.1791410886.git.abhishekbapat@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 22:47:23 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] uapi: alloc_tag: ABI break in ioctl numbers due to struct size=
 change
--

commit 0e3a8bd841b68b1a5bbc064967d29e2e813bc3ba
Author: Abhishek Bapat <abhishekbapat@google.com>

alloc_tag: Extend allocinfo_filter to support tracing queries

This commit extends the allocinfo filtering mechanism. It allows userspace =
to
filter memory allocation tags based on their trace state.

> diff --git a/include/uapi/linux/alloc_tag.h b/include/uapi/linux/alloc_ta=
g.h
> index dafcba2f7e2c1..a96054ac22376 100644
> --- a/include/uapi/linux/alloc_tag.h
> +++ b/include/uapi/linux/alloc_tag.h

[ ... ]

> @@ -75,6 +78,7 @@ struct allocinfo_filter {
>  	__u64 max_size;
>  	/* filter criteria only; see allocinfo_counter.accurate for actual accu=
racy */
>  	__u64 inaccurate;
> +	__u64 tracing;
>  };

[Severity: Critical]
Does adding this 8-byte field to struct allocinfo_filter cause a UAPI
regression for existing userspace applications?

Because struct allocinfo_filter is embedded within struct allocinfo_get_at=
=20
and struct allocinfo_toggle_traces, their total sizes increase by 8 bytes.
The IOCTL command numbers, such as ALLOCINFO_IOC_GET_AT, are generated usin=
g=20
the _IOWR and _IOW macros, which encode the size of the argument structure=
=20
directly into the command value.=20

When the structure sizes change, the numerical values of the ioctls change =
as=20
well. Since the kernel's allocinfo_ioctl does not include handlers for the=
=20
legacy ioctl numbers, older userspace applications issuing the ioctls using=
=20
their original command numbers will fail with -ENOTTY.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791410885.gi=
t.abhishekbapat@google.com?part=3D3
