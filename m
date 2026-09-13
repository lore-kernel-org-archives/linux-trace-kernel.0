Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1750831E858
	for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 13:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789307348; cv=none; b=sXGStKhbUKEXsZWzrgV8cyAAzu9tL/PvLQqnqBJfysabljkVCodim+oo8Up3Jk89Z9zquWKwaLUMVgfK5hDcFl0uZyuU0IddhbE+ji++qwYAe2Zfn2UWgHYb/8Qo8tHyxGgqbR/cHPns72hIxgXZJYI5+bgT0/nzblAExoWMheY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789307348; c=relaxed/simple;
	bh=k4IuMZ2PtMEvL2Qow9kTzu3Lf+Ql8xwOpSYaXpIZw/4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jkbj3rTxyWjqhjr3Z8ouUGaJUQRPcJNGdTgUHGy9enB/+WDuLG1IbNlnk2DQFZJ46XlwCjuZUrQ1hhuk8XILqdLwttTbAQaAoy4wPDwkGVM0HSt1/sRjCWQfmX5bDs3+XdnOofyHcQH7U7jH9NoBpK5SNF+RN5gerWp4fJVIcQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awNwb+lR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awNwb+lR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8A01F000FF;
	Sun, 13 Sep 2026 13:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789307346;
	bh=ftH38G+2S9VD+E2NiUWFkZRrSL2tPOsTwwvzuCmLFJg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=awNwb+lRAYR8oT9V99qRCkChFQk6S6y/ES73eqvNNgh02f739q9glm9sYN+FCBtJf
	 ExvhW6pTQMWcPKx6CStxVHiQaHMJZMDxUiEnp8ts8+uDksLbI3vEFlBevK9Trip/32
	 552kA15OWYbgCShAQGgEPMWiIRczN0gqzB1bLQXjSc285OtjzP9QzZJNG+XMJc71WW
	 FWstgK2VcT4pwKLToLjQxDj28RNSGgZrnQuWVRep6wGcovAVj9YM+WapIgr1zoCy0c
	 0G1PcT/g0LaJAyey7ZtuDlZk7uXglYFv5gg2vjkb4gbe0lXZ2wZedbZCoD4BLkGohq
	 xcwUle3d8ugJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing: Take trace_types_lock when dropping the
 buffer_meta reference
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Carlier" <devnexen@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260913133829.15307-1-devnexen@gmail.com>
References: <20260913133829.15307-1-devnexen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 13:49:05 +0000
Message-Id: <20260913134906.6E8A01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Reading a per-CPU buffer_meta file for an offline or unallocated C=
PU causes a NULL pointer dereference.
--

commit f8d13605bef286fcf84c808917e1ab8eeeade189
Author: David Carlier <devnexen@gmail.com>

tracing: Take trace_types_lock when dropping the buffer_meta reference

This commit fixes the error path in tracing_buffer_meta_open() by using
trace_array_put() instead of __trace_array_put(). This ensures the
trace_types_lock is properly held when dropping the trace array reference
if ring_buffer_meta_seq_init() fails.

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5881,7 +5881,7 @@ static int tracing_buffer_meta_open(struct inode *i=
node, struct file *filp)
> =20
>  	ret =3D ring_buffer_meta_seq_init(filp, tr->array_buffer.buffer, cpu);

[Severity: High]
This is a pre-existing issue, but reading a per-CPU buffer_meta file for an
offline or unallocated CPU causes a NULL pointer dereference.

A user with privileges to read tracefs can open and read
/sys/kernel/tracing/per_cpu/cpuX/buffer_meta where cpuX is a CPU that has
never been online. This invokes tracing_buffer_meta_open(), which blindly
initializes the seq_file via ring_buffer_meta_seq_init():

kernel/trace/ring_buffer.c:ring_buffer_meta_seq_init() {
        ...
        m =3D file->private_data;
        m->private =3D buffer->buffers[cpu];
        ...
}

Because alloc_buffer() only dynamically allocates cpu_buffer structs for
currently online CPUs via CPU hotplug callbacks, this pointer is NULL for
unallocated CPUs. The subsequent read invokes rbm_start(), which immediately
dereferences the NULL pointer:

kernel/trace/ring_buffer.c:rbm_start() {
        struct ring_buffer_cpu_meta *meta =3D cpu_buffer->ring_meta;
        ...
}

Should there be NULL validation for buffer->buffers[cpu] before allowing
the file to be successfully opened, or perhaps a check inside rbm_start()
to handle it gracefully?

>  	if (ret < 0)
> -		__trace_array_put(tr);
> +		trace_array_put(tr);
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913133829.1530=
7-1-devnexen@gmail.com?part=3D1
