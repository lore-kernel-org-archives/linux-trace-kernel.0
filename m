Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BBF3AB5DE
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 19:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788810179; cv=none; b=LYA+tIzi5IOOjeBhEYHbl6bs7eFN//Py73r/Iu7u1sNe1iTNxabmxDfLAZUY2IveTifybQ+o7JjQbk/sDk8FuiwGq1JIper5iXPCPV2fFZdz80cV/9ApE+HofoRV1IX0y/5unniWJzO8jGbh1dm8E8bMY4awxz1oJOpqD1L9M0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788810179; c=relaxed/simple;
	bh=xWeO59TTl377knUNGMhNw7JdIl97jFni/8E2JmP7Uxg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FeSByb3RXHRWYgFS6ljHuz2aqJ7oi4TurwBmR4zb8sQ41KusSnARpeMRmNaWVAnXb+g/YKQ8pump6Y055B0TbcXgaeNAnqZ4KhgajhL+/6lxOpgGt5beZ2xtylPvOrt/bAvW4j4YkP98lgV0NbvQfweoEQmkm8nnF82HGNgGJik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVyaWLJh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVyaWLJh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6E21F00A3A;
	Mon,  7 Sep 2026 19:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788810178;
	bh=uvWKEZXmXJpXX7Dix3feO30N6iJMRZRzbaOz+FRrmQs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KVyaWLJh0hp4a80TpytBEQdH1jSKJU7tobj08suVbJvifRGCTJoGXRmFXETZJXo4X
	 0leffbgKpLPFV3DQbuxBq9/NoNdWlMoLhG+lQ1MF0Rj9qXNtf/tmi9Y0SVOinuDFLG
	 /ENitgQFElqoxwBrC7Y6bmCe/Guph+BNaxqRGBYyXNYAa/iXgjOelFxyAadgQW6YsN
	 QL98xzQap+IznBl3dSxaFwrnKw43STsrggLiJTGTrPafAftrfMSpkSotLYZThGnrF8
	 as7yEfeN8xkKWwZzGYYFEJ43IjhHVcIx0AtezOS0YMj2+cY2etBtlsvghO+/UjMBZO
	 L/CvwHeSOi+IA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] ring-buffer: Unify ring buffer minimum page
 calculations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260907192643.42513-3-vdonnefort@google.com>
References: <20260907192643.42513-1-vdonnefort@google.com>
 <20260907192643.42513-3-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 19:42:57 +0000
Message-Id: <20260907194258.4E6E21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] A hardcoded minimum page limit was missed during refactoring in tra=
ce_rb_cpu_prepare().
--

commit 699b707360c7ac89e4a8f2b996c220e5cb22ea93
Author: Vincent Donnefort <vdonnefort@google.com>

ring-buffer: Unify ring buffer minimum page calculations

The commit introduces the RING_BUFFER_MIN_NR_PAGES macro to formalize the
requirement of having at least two pages in a ring buffer. It updates multi=
ple
sites across the codebase to use this new unified calculation instead of
scattered hardcoded values.

> diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> index 7a1a92f876503..a9401b8ebc721 100644
> --- a/include/linux/ring_buffer.h
> +++ b/include/linux/ring_buffer.h
> @@ -99,6 +99,13 @@ struct trace_buffer *__ring_buffer_alloc_range(unsigne=
d long size, unsigned flag
> =20
>  void *ring_buffer_meta_scratch(struct trace_buffer *buffer, unsigned int=
 *size);
> =20
> +/*
> + * A minimum of 2 pages ensures we can always swap a page out of the ring
> + * buffer. This does not account for the reader page or any other page
> + * containing meta data used by static ring buffers.
> + */
> +#define RING_BUFFER_MIN_NR_PAGES 2UL
> +

[Severity: Low]
Was a hardcoded minimum page limit missed during this refactoring?

Looking at kernel/trace/ring_buffer.c:trace_rb_cpu_prepare(), when a newly
hotplugged CPU is brought online and detects varying subbuffer sizes across
existing CPUs (!nr_pages_same), it still uses a hardcoded fallback limit:

kernel/trace/ring_buffer.c:trace_rb_cpu_prepare() {
    ...
	/* allocate minimum pages, user can later expand it */
	if (!nr_pages_same)
		nr_pages =3D 2;
    ...
}

Should this fallback allocation use the newly introduced
RING_BUFFER_MIN_NR_PAGES macro instead to avoid a maintenance hazard if the
minimum requirement changes in the future?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907192643.4251=
3-1-vdonnefort@google.com?part=3D2
