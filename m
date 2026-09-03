Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B43444D03B
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Sep 2026 17:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788457105; cv=none; b=dIaPXrH52Q36ulQkHYbjCA2rZ0/lk74sGJIpg17AljcssjX7EqOBIbY0me9HF61p90MbIiDrrnQzMHNzz7kdsczhk/Zr3BERaJHRoJ3+fCleBsqKJPIUBjcZSETQ0BLbbKKHE7AVjpUPkzj5Rv6vUF72xwvAU4d3kj9xKBbTcuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788457105; c=relaxed/simple;
	bh=QPEuCcHzvysT0/CX5gZ5XC3vEI6OuguEmIpU5ojY7uc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MhFsTGXT5wG3My26m2UQAtWkbDYHGA5oJTgOyzkbSoN9jkApk7TVc/4PyHCuy2r9W9l6MKetvRSegkoQRB1/CvJjczFvWvY5D6jiPpQIjGb0SIvqZvUR6ftP8vhkjyc4QmDEua3NmbiRblYe6eMXzSDd/6TTmjq7KqRYbQ3HjU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7KWwkdl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7KWwkdl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D61C1F000E9;
	Thu,  3 Sep 2026 17:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788457103;
	bh=tYWbBJz403nY/ZY1QkZDtlmdtA+gtbxu4LDUEYQVM0c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n7KWwkdlNUoJH4QMW3lLFX0UsH7mSoyaRHc7o3drhs6UCnMRfDjBkK1W0N/HOGqta
	 lMb/4T6b1D3B/xl7CZFhdHXudHcUSurwA7iT3WoSb5cCviqfnigCnx5QLp89xXT3ls
	 NwME0hneNvXjA0cWlXbESzSqf0vBYxCQRxhqm5hlAVJDtCWTUgliwLW4LqYtazR+fb
	 9Nq6MvYvsUubto5CXwmTn7siahWx4fju+XKsqq0KUGiWvxUCVJ1alCsIjsko+/g2f8
	 cwN4sv2MQ+Avp7RBMuhRE82O3qHJla8dqyd/R0572DCdJqxWxu84tYfDewbEHp9A0d
	 ENrucrVIjFmww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ftrace: Add checking nr_subbufs to persistent ring
 buffer validation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260903132728.7fb27d34@gandalf.local.home>
References: <20260903132728.7fb27d34@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 17:38:22 +0000
Message-Id: <20260903173823.4D61C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Integer overflow in per-CPU ring buffer metadata calculations due =
to 32-bit arithmetic, leading to memory corruption and false validation rej=
ections for trace buffers larger than 2GB/4GB.
--

commit dffcd0268ea5b9908d6dadacec8d07651bd25ceb
Author: Steven Rostedt <rostedt@goodmis.org>

ftrace: Add checking nr_subbufs to persistent ring buffer validation
   =20
This commit adds a check to the persistent ring buffer validation logic. It
ensures that the saved nr_subbufs in the metadata matches the expected
nr_pages + 1 to prevent mismatches.

Closes: https://lore.kernel.org/all/20260901164836.D962D1F000E9@smtp.kernel=
.org/

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -1856,6 +1856,11 @@ static bool rb_cpu_meta_valid(struct ring_buffer_c=
pu_meta *meta, int cpu,
>  		return false;
>  	}
> =20
> +	if (meta->nr_subbufs !=3D nr_pages + 1) {
> +		pr_info("Ring buffer boot meta [%d] invalid nr_subbufs\n", cpu);
> +		return false;
> +	}
> +
>  	buffers_start =3D meta->first_buffer;
>  	buffers_end =3D meta->first_buffer + (subbuf_size * meta->nr_subbufs);

[Severity: High]
This is a pre-existing issue, but could this 32-bit arithmetic overflow for
very large trace buffers?=20

In rb_cpu_meta_valid(), subbuf_size is an int and meta->nr_subbufs is a __u=
32.
If an administrator configures a per-CPU trace buffer larger than 4GB, their
product might truncate before being added to the 64-bit meta->first_buffer.
Would this result in an artificially small buffers_end, causing valid buffe=
rs
to falsely fail the bounds check on reboot?

A similar pre-existing issue appears in rb_range_meta(), where both variabl=
es
are signed 32-bit ints:

kernel/trace/ring_buffer.c:rb_range_meta() {
    ...
    ptr +=3D subbuf_size * nr_subbufs;
    ...
}

Does this signed multiplication overflow for buffers over 2GB, causing the
ptr to move backward and potentially corrupt memory when written?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903132728.7fb2=
7d34@gandalf.local.home?part=3D1
