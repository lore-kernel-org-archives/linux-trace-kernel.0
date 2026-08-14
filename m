Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4FD2931D2
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 02:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786673368; cv=none; b=FN4GS5eaI0h8k3aJ/rB/iNNM8AfKxCWBHG4yJHICeXng8e5kVF+BT1AVPLonD/1ZUMS+EBg9rajEHGCwJGfDpUBzQvpVDUbileU5rRXgsoxFzU/1zYCE1X2yK9rEMYG0v7+W5eYCR5dB2Koo3MRkYYC2e9OOqukxlgBA1DfqwH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786673368; c=relaxed/simple;
	bh=VRhMyrWoqUhCYUecNuW2UZkvqg8ca9nh62gzWICnqCY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JBg+JFr3+0s3AFqcxMYXD8qWourNOPYs2e6M4kZcpOvAXW59onxrcC87/FRHbsIJh62x1tN1zUS/ZsYPYThZ6oRUzkpjnvMy0VO2nhSMOqj50zU0fLEvAVZP2lWhPsduMnhRoNekaRnu1g4CfHWmspYm+fzjwqYDt7ZFkCy4L1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKRArJ2d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKRArJ2d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E571B1F000E9;
	Fri, 14 Aug 2026 02:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786673367;
	bh=iwusftwrf+Jd+iBC1Gtb++dM5nyYnslfY0aGIAFSFUg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DKRArJ2dfLL8B66lT0W+xxZEO4QZUN8cDijSY/YDGt6JPnHgvmJvEBl7HE46C1Uem
	 1vw24YYenp136qSvK5uaDwiwhli5WepSLD1TlF/bV7W8zUTPU89bcTHD7wmcFf3afC
	 Ade0PC4xH+/iwMvBH263spn2cf04/hFYiOZljVP+1PJU9J2uANarkm3g/owRM99Z+W
	 tAKUSPByWjDEphnettaUU6g8x9/sUDpV/J8h0hLNtyEu7XfQWdVLvm6uB4btLGat+v
	 vx9yMP8+mT6OpESwhtZBTzxbqt+Vt+DYAjrfQ2fg2eDte6ZS3i5PcE/9ADbL2I8Oer
	 MPSm5I6+LvmVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ring-buffer: Fixes for subbuf resizing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260813215230.7aa47950@gandalf.local.home>
References: <20260813215230.7aa47950@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 02:09:26 +0000
Message-Id: <20260814020926.E571B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calculating the total ring buffer size in `ring_buffer_subbuf_orde=
r_set` truncates large sizes because `nr_pages` is declared as a 32-bit `in=
t`, causing large ring buffers (>4GB) to silently shrink.
--

--- Patch [1]: [PATCH] ring-buffer: Fixes for subbuf resizing ---
commit 2e24224b70e061b34a4388f3a630382a4b8c1c44
Author: Vincent Donnefort <vdonnefort@google.com>

ring-buffer: Fixes for subbuf resizing

This series addresses multiple issues discovered with the dynamic ring
buffer resizing.

Link: https://lore.kernel.org/all/20260813131152.3589632-1-vdonnefort@googl=
e.com/

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -7320,7 +7376,8 @@ int ring_buffer_subbuf_order_set(struct trace_buffe=
r *buffer, int order)
>  {
>  	struct ring_buffer_per_cpu *cpu_buffer;
>  	struct buffer_page *bpage, *tmp;
> -	int old_order, old_size;
> +	unsigned int old_capacity;
> +	int old_order;
>  	int nr_pages;
>  	int psize;
>  	int err;

[ ... ]

> @@ -7367,8 +7424,8 @@ int ring_buffer_subbuf_order_set(struct trace_buffe=
r *buffer, int order)
>  		}
> =20
>  		/* Update the number of pages to match the new size */
> -		nr_pages =3D old_size * buffer->buffers[cpu]->nr_pages;
> -		nr_pages =3D DIV_ROUND_UP(nr_pages, buffer->subbuf_size);
> +		nr_pages =3D old_capacity * buffer->buffers[cpu]->nr_pages;
> +		nr_pages =3D DIV_ROUND_UP(nr_pages, rb_subbuf_capacity(buffer));

[Severity: High]
This is a pre-existing issue, but does this size calculation truncate when
the ring buffer is larger than 4GB?

Because nr_pages is declared as a 32-bit int at the top of the function,
assigning the total byte size (old_capacity * buffer->buffers[cpu]->nr_page=
s)
to it truncates the upper bits of the 64-bit result before calculating the
new number of pages.

For example, a 5GB buffer would get its byte size silently truncated to
around 705MB before DIV_ROUND_UP computes the new number of pages, leading
to an unexpectedly shrunken ring buffer. Should nr_pages or a temporary
variable be declared as unsigned long to hold the intermediate byte size?

> =20
>  		/* we need a minimum of two pages */
>  		if (nr_pages < 2)
>  			nr_pages =3D 2;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813215230.7aa4=
7950@gandalf.local.home?part=3D1
