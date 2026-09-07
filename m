Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ABF220F2D
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774677; cv=none; b=MKa2KxG4+P6gOndnaKt9f83a2526afGNiUdfykAV1xNKLNLlL/wl2HzmoAkscCvXoI0O49zdnBB+n8wbUs/wLIKNurzxV2mWT/8fONOWKgV2DgSH61EArfYDeJCk54Y2sQismat/3yv5U8JLt0JswUDcILSKZKZShMDStfl1Eok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774677; c=relaxed/simple;
	bh=1QdCxYrS0pTlLbDZKno57WJdA8pqk4ddtZrHqOPrqsQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CJqbpMVMCH15ucOp177waLmzqLN3UCdgrrlGxntnkbZCfnPkMVFLwNz5uuYR1Jz0cM/XtsIu2yGyQDSNZyjj1PHEWF1VsruSSlfpckZgCy5yfMYm97J8b9QaZQhJwfGPnaU4CJYPZXEtplFZJYGTzchF4NoYy/ksvFpD4+DTMcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eziGP8FL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eziGP8FL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38FE1F00A3A;
	Mon,  7 Sep 2026 09:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788774661;
	bh=R2pZ1ie5ChZkXVbdk3xvNHi0XYLYCzofRtbEphHLdBA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eziGP8FLFLI7tYbOEtzKiQng4wWDK/sWP6fQF4jyPnqk1V46nh9Be33Q3TADPOu3H
	 TELKjSahzHxU3D/sEPTgvqtcecW+j2y5/BReB9hYEtuPumsbAeQxivI3cBmdYBs7ta
	 CwUlvuXA2c5lD1NdsiUMXNF+dXU0OqbLb591F57fDvJirMiYcuJ3ahSPQmiQIs4hH6
	 pPLs1J5JnZ/v4RxuVv42WoSquu2oRYaLCSSQSVa8OsXPrnY8QrpmoOtOOB4NFyba8m
	 hlcwbfZ+U0y+Q1X6+2hhwe1fVcoxW4kDoLdtTSNH6eaCwwbfC3NOvesiqm5Xup1jDL
	 JvZXV78L4K+tg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] ring-buffer: Rename ring_buffer_size() to
 ring_buffer_capacity()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260907094238.3624013-1-vdonnefort@google.com>
References: <20260907094238.3624013-1-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 09:51:01 +0000
Message-Id: <20260907095101.C38FE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Typo in the newly added docstring for ring_buffer_capacity().
--

commit 0916229b26fe9d5e8fd8143432df2554e399aa85
Author: Vincent Donnefort <vdonnefort@google.com>

ring-buffer: Rename ring_buffer_size() to ring_buffer_capacity()

"capacity" refers to the memory available for events while "size" refers to
the raw allocation. ring_buffer_size() actually calculates event capacity, =
so
rename it to ring_buffer_capacity() to match this convention.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 9c03a555a6ba2..2940ff7633542 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c

[ ... ]

> @@ -6547,18 +6547,23 @@ void ring_buffer_iter_advance(struct ring_buffer_=
iter *iter)
>  EXPORT_SYMBOL_GPL(ring_buffer_iter_advance);
> =20
>  /**
> - * ring_buffer_size - return the size of the ring buffer (in bytes)
> + * ring_buffer_capacity - return the capacity of the ring buffer (in byt=
es)
>   * @buffer: The ring buffer.
> - * @cpu: The CPU to get ring buffer size from.
> + * @cpu: The CPU to get ring buffer capacity from.
> + *
> + * Capacity is the total memory available for recording event data in the
> + * ring buffer. It excludes subbufer headers.

[Severity: Low]
This isn't a bug, but there is a typo here (subbufer instead of subbuffer).

> + *
> + * Returns the capacity in bytes, or 0 if the CPU is not set in the buff=
er mask.
>   */
> -unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu)
> +unsigned long ring_buffer_capacity(struct trace_buffer *buffer, int cpu)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907094238.3624=
013-1-vdonnefort@google.com?part=3D1
