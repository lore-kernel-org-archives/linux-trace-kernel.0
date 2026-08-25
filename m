Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAF3EEB3
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 05:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787636014; cv=none; b=OM15IfOCFFvabNefDUfChFndfldJodsZ14kWkRaJ+U3dKiYlwq3usaicINWDM1JSIcEH9nO2RG0eiLgwuC2fqGmdgGmAweO6yfu5VUxkbx0zFj2ls7YCL17XFsd9f2iZTSsKTpayD4g2WgEH23GJjnGjJKPvFEtQtt1iCp5HgHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787636014; c=relaxed/simple;
	bh=W6x8VamMwZwOhEcYhju0YvEQAj/7HHGLouUlzA7fHPU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vg0oFWJpxYQ7c2SX3k9nyU0ujM6lOP8j+4aQfdNxs/hGXYWwwJHZGIwVpMKGbrmMp0ABPickYCBmT/DuiNJDuHrOITl31xHZxzzv52ojEF6gNLYoncXPJf8s6g15Q5rAd4a7pQ+1XMbCPuhnkQG+tOkfuYZ8th/uYzAtHV5dssw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsBFvQI4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsBFvQI4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234A81F000E9;
	Tue, 25 Aug 2026 05:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787636013;
	bh=d+0jG5LsvRKFS5aIF5dFnmFzxIuS2BQgeoFVDRdI1Ys=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DsBFvQI4VjXK0gNTtXTKxpFbWTqNe/DMRU1vvP5qMb6D/Dee05yrTH7b1rNs8MMqI
	 kwvbEhN3+w8GFw4ETE5fLGGc4cN5gXhBGaeGP+AFIlDNe2ObR7bp0mlZoaLAUjMUZX
	 ROs1Bcl1lr4PDYB9DpG96ApFeanuTRlrmyK02N5hweWIoT/mc5bxv0Dhx4Ap+CoaHF
	 mnxvfI6CPESM+OU3I/9Esisf3zsCB+vZpSnIellOQakTy1xuaa0Tg+/frqbQNjmOd/
	 DWRdRcg+PVZdRsppzO3YSeB5G9YHzgex7BFo8ij2W92yTxA3tXLz1HuRrhSLBNan1E
	 TH1ytoK/5iIFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] ring-buffer: Stop remote reader update when page
 swap fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ivan Immanuel Shaji" <ivanimmanuel1234@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260825-kernel-patch-1-v1-2-e9349aa0b165@gmail.com>
References: <20260825-kernel-patch-1-v1-0-e9349aa0b165@gmail.com>
 <20260825-kernel-patch-1-v1-2-e9349aa0b165@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 05:33:32 +0000
Message-Id: <20260825053333.234A81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing bounds check on shared memory fetch allows out-of-boun=
ds read and Double Fetch (TOCTOU) arbitrary memory write.
- [High] Logic Error: Function fails to abort when remote reader swap succe=
eds but the reader ID is left unchanged, corrupting the ring buffer.
--

--- Patch [2]: [PATCH 2/2] ring-buffer: Stop remote reader update when page=
 swap fails ---
commit 90c9d4edbac629b3b97121e741bbf3aba71f7d7d
Author: Ivan Immanuel Shaji <ivanimmanuel1234@gmail.com>

ring-buffer: Stop remote reader update when page swap fails

This commit modifies __rb_get_reader_page_from_remote to abort and return
NULL when the remote swap_reader_page callback fails. This prevents the
function from splicing the same page as both the previous and new reader,
avoiding linked-list corruption.

> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -5805,8 +5805,9 @@ __rb_get_reader_page_from_remote(struct ring_buffer=
_per_cpu *cpu_buffer)
> =20
>  	prev_reader =3D cpu_buffer->subbuf_ids[cpu_buffer->meta_page->reader.id=
];

[Severity: Critical]
This isn't a bug introduced by this patch, but does the initial fetch of
meta_page->reader.id need a bounds check and READ_ONCE protection?

If a remote entity (such as a guest VM) concurrently writes an
out-of-bounds index to meta_page->reader.id in shared memory, it is used
immediately as an index into the subbuf_ids array.=20

If the remote then updates the index to a valid value before the second
fetch lower down, the later bounds check will pass, but prev_reader will
still hold a garbage pointer from the first out-of-bounds read. This
pointer is later used in linked-list manipulations, which could lead to
arbitrary memory corruption.

> -	WARN_ON_ONCE(cpu_buffer->remote->swap_reader_page(cpu_buffer->cpu,
> -							  cpu_buffer->remote->priv));
> +	if (WARN_ON_ONCE(cpu_buffer->remote->swap_reader_page(cpu_buffer->cpu,
> +							      cpu_buffer->remote->priv)))
> +		return NULL;
>  	/* nr_pages doesn't include the reader page */
>  	if (WARN_ON_ONCE(cpu_buffer->meta_page->reader.id > cpu_buffer->nr_page=
s))
>  		return NULL;
>
>  	new_reader =3D cpu_buffer->subbuf_ids[cpu_buffer->meta_page->reader.id];
>
>  	WARN_ON_ONCE(prev_reader =3D=3D new_reader);

[Severity: High]
This is a pre-existing issue, but should the code abort here if prev_reader
and new_reader are equal?

If the remote reader swap succeeds but the remote erroneously leaves
meta_page->reader.id unchanged, this condition evaluates to true.=20
The function correctly identifies the invalid state with a warning but=20
continues execution rather than returning NULL.

By continuing, the code blindly manipulates the list pointers of the same=20
page (for example, overwriting new_reader's list.prev to point to itself),=
=20
triggering the same kind of linked list corruption this patch was intended=
=20
to fix.

> =20
>  	prev_head =3D new_reader;  /* New reader was also the previous head */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825-kernel-pat=
ch-1-v1-0-e9349aa0b165@gmail.com?part=3D2
