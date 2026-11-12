Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493705;
	b=FLO91bVzeCENekF7N80erNffpi4+zqHI2cNyKqTHwN4iZF2h9ZHhBcRslTtAe6Vy/bf9
	 fPM26ATbueTDOrcGRSgYy0KeRV6f6b/L78dna06EfXPoNYA4CstirTM50myOHHvmL9Kkt
	 GaHzsw1Cvwx2taqCVaoqTxhJWUqcYAz/L23JfHC3VDGloF7tBj9VNuNFq0IWowA0E+cv2
	 ghYTWDIqcmnyHS5VHvaxXnUO4DNwzfNc5qtYxJ5mEBM80ueduoIIMO6vj1oAl31JOlqLR
	 LmNeGbtI1lYi60/j85pm+CW9J9LYGm6a45Liy1y9877OG4J6whE4QYpyV0uHqmoRFMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493705;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TJtSuWfEotizr4YyAeBtFGMT3cr+79OrTmJTZ+Qcylo=;
	b=NZdt2TYTNjo+EYnIc0Ft4pb7HSDd2cHw305RCnfADuCvdLwERSdQKFPlAXHL6bdTVPLo
	 Z57KtSAfVu4tsnWeWX+5RdiMxSdQFP+5ntUDPJTEzd+FUo0DS20hyB8GANHVAgzKxk1qr
	 cVF2G/HIH80/F+kunwVrcqFgN2E+7kc0ieqg62Oam6KHgAGqkDH1diQDdlXHaATOjzeru
	 jbdEabg9fUia0zNlx5xKUuUM7zZ7x0RMuyLzt4P2q9Z8LFN1BV6ATawWyTpsfqDgYo697
	 E/vwnoXszhgkuHNj4Z0iqqu3WMwC75UvjKNSxTXtKOOisqqmKzZ5i+vFSnEmp70/pCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cOYTYFMh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE80606A321
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cOYTYFMh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24ED31F00A05;
	Thu, 12 Nov 2026 14:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794493705;
	bh=TJtSuWfEotizr4YyAeBtFGMT3cr+79OrTmJTZ+Qcylo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=cOYTYFMhDOPbQiCGn1TmNiE3v4CstsGDjt7WyiL26wT8ra5mPy+2vWzj53zz1zlLg
	 RAJ3UzvlDq1Uo7ta0hBnQOtBqAELd3vo3p/2AiDRaqunqSgcs44d7Ro5ecvHM3ML97
	 yOa/FUzj5gawk2zLiw9SB0zUxY9n0yEISi6zT48azYQZyjAs3PVuzt+TTmI+WW+sSQ
	 hfaaERYBRBBXxevUGeiSalGbC7/a3cg9OmYpNak/Je1PwmtgpJLGO9dyI2bxhPtw6A
	 FMSr4xQEkon6QoqZYL/WlQvmtZgT0cOURbmvPBt3KKMHVZl61LRdzSPoS6thVndQOe
	 lKc22+29rOYOQ==
Message-ID: <sashiko-outbox-211316@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 8/9] ring-buffer: Enable context analysis
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261112141440.3050124-9-vdonnefort@google.com>
References: <20261112141440.3050124-1-vdonnefort@google.com>
 <20261112141440.3050124-9-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:28:24 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] ring-buffer: overwritten lost events count in
  __rb_get_reader_page() [1]
--

commit 07222abe396def21c907e79ee32f4784cd985857
Author: Vincent Donnefort <vdonnefort@google.com>

ring-buffer: Enable context analysis

This commit enables compiler context analysis for kernel/trace/ring_buffer.=
c,
adding lock annotations and inlining rb_get_mapped_buffer() and
rb_put_mapped_buffer() into ring_buffer_map_get_reader().

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 82f6e3df46276..99ade8b41b536 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c

[ ... ]

> @@ -8031,7 +8023,7 @@ int ring_buffer_map_get_reader(struct trace_buffer =
*buffer, int cpu)
>  	rb_update_meta_page(cpu_buffer);
> =20
>  	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> -	rb_put_mapped_buffer(cpu_buffer);
> +	mutex_unlock(&cpu_buffer->mapping_lock);
> =20
>  	return 0;
>  }

[Severity: Medium]
This problem wasn't introduced by this patch, but can __rb_get_reader_page()
overwrite an unconsumed cpu_buffer->lost_events count [1]?

When __rb_get_reader_page() swaps in a new reader page after an overrun, it
assigns the delta directly to cpu_buffer->lost_events and loops back to
"again:":

kernel/trace/ring_buffer.c:__rb_get_reader_page() {
	...
	if (overwrite !=3D cpu_buffer->last_overrun) {
		cpu_buffer->lost_events =3D overwrite - cpu_buffer->last_overrun;
		cpu_buffer->last_overrun =3D overwrite;
	}

	goto again;
}

If the swapped page is empty (or the reader catches up to commit_page on the
next iteration), __rb_get_reader_page() returns NULL with
cpu_buffer->lost_events still non-zero. Callers such as
ring_buffer_map_get_reader() and ring_buffer_read_page() then jump to their
"out:" paths without consuming or clearing cpu_buffer->lost_events. If
another overrun happens before the next page swap, the direct assignment in
__rb_get_reader_page() overwrites the earlier unconsumed count instead of
accumulating it with +=3D, under-reporting dropped events to trace readers =
and
user-space meta-page mappings.

[1] https://sashiko.dev/#/bug/linux-6817998d-f7d9-427c-82e8-fac5ea6dfa8c

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112141440.3050=
124-1-vdonnefort@google.com?part=3D8
