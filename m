Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777114;
	b=CL7CGL1P1QYx5K3A6oVtTMbYTBpxEqaAMZwoUpxBbt+ZbwOMz6jQ/O/IM9u3JWS0FkOU
	 4dlF/R/v4nPyWSxghsj/ge0y5NvKrZDtFUoHZ+HWrPbv5f8dkI+ch8PnmnHrTSVyXPzFq
	 yCfIk3HKvu2vjbI2M2niEFYsuPx4ncEm3KZBJvdOp5x5arQCql0OJnuMPNgoGaMeKN2p6
	 VUkhSc81soulVvp2eetCvE1DfgEXf1tDPDAvczWBnj33EXlQY8LVyFv7BjPoChMYnTRsD
	 PPhs8VEIhO3IlY9aJWHj3PGz299X8RirZgRdCz3hJSO7JzRxF+UbACY8tlzPHY4bOJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777114;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xceb5IU8bfgZgDF8uYnzWT+kl4EVCPQJ5Yl/w9i26mQ=;
	b=IENl+k7TFXHNhWw8pctdLutWBWHNhhhq8185bpOZ1/EtWPwh3DPRxELOes4EeuuVjI7d
	 wVWq/h5rJpUmSWy6inxgCUhopwLiwNwR4Xm+QETqTA1Gjfuz8APp39n1Ma7dMnaWmm00h
	 Cy52+VVDxFdCjbTYUS92r2n7VKB9qsDmT1V0QKxdeO/94GT8YpVAy6g3XqtjYGoHyyt0j
	 8jcF8XWD8e7dHNYBtIpq1OXlhZdqS/JiFkFKxeVy3GUBngXQQgVg8LzI/bVwxeBUIMsrx
	 zt6RprXRVxFlhQ+v9Db4MM5XP4XUGKwJpbVFSGftEBZAAl7CCWYFnbJxgOON/SJFQxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RnZOfomc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE5F606A31B
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 17:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RnZOfomc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421841F01825;
	Fri, 23 Oct 2026 17:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792777113;
	bh=xceb5IU8bfgZgDF8uYnzWT+kl4EVCPQJ5Yl/w9i26mQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RnZOfomcQ1bneuisxRQWTV803c0j4Uv0iVf6zwDBE5tJasoFQ0R6o1jPwnuQn81mY
	 Rv0Rzbdwc2dE2ieqiYpaiIFihU7zohAuYBvvb/ikXxQ0s3V9oHcWFJH/AdsMLYcwqH
	 CTH1r5ViQ7gxhzJtxUS46FlsaJlbqXtNL4YWLKlcaQG7gZpgEuifJCO0+RqUj3F0ad
	 QADrP5zSkSaPUuSSzOdYJJLqPWn3SYxgyeCYequKOGTMq309QOwDioASYJrb84sc19
	 k60oRW7SpEHENdTpNdFrxcE8LuxNc7NWcoHJN37f6zZCcNzrtveLWeR2xc1ONz6dtg
	 3sYhDLJ3kRf5Q==
Message-ID: <sashiko-outbox-183008@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] alloc_tag: Extend allocinfo_filter to support
 tracing queries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abhishek Bapat" <abhishekbapat@google.com>, "Suren Baghdasaryan" <surenb@google.com>, "Hao
 Ge" <hao.ge@linux.dev>, "Andrew Morton" <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <f577c773058265f0eb7fe2c10fb6aa4003445a00.1792690544.git.abhishekbapat@google.com>
References: <cover.1792690544.git.abhishekbapat@google.com>
 <f577c773058265f0eb7fe2c10fb6aa4003445a00.1792690544.git.abhishekbapat@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 17:38:32 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] alloc_tag: UAPI breakage in ALLOCINFO_IOC_GET_AT from growing allo=
cinfo_filter
--

commit b1243e6bc8216f5fe9d8786ec8ca3a597c41681f
Author: Abhishek Bapat <abhishekbapat@google.com>

alloc_tag: Extend allocinfo_filter to support tracing queries

This commit extends struct allocinfo_counter and struct allocinfo_filter in
the alloc_tag uapi header to report whether tracing is enabled on a tag and
allow filtering tags by their trace state.

> diff --git a/include/uapi/linux/alloc_tag.h b/include/uapi/linux/alloc_ta=
g.h
> index dafcba2f7e2c1..a96054ac22376 100644
> --- a/include/uapi/linux/alloc_tag.h
> +++ b/include/uapi/linux/alloc_tag.h
> @@ -38,7 +38,8 @@ struct allocinfo_counter {
>  	__u64 bytes;
>  	__u64 calls;
>  	__u8 accurate;
> -	__u8 pad[7];
> +	__u8 trace_on;
> +	__u8 pad[6];
>  } __attribute__((aligned(8)));
> =20
>  struct allocinfo_tag_data {
> @@ -54,7 +55,8 @@ enum {
>  	ALLOCINFO_FILTER_INACCURATE,
>  	ALLOCINFO_FILTER_MIN_SIZE,
>  	ALLOCINFO_FILTER_MAX_SIZE,
> -	__ALLOCINFO_FILTER_LAST =3D ALLOCINFO_FILTER_MAX_SIZE
> +	ALLOCINFO_FILTER_TRACE_ON,
> +	__ALLOCINFO_FILTER_LAST =3D ALLOCINFO_FILTER_TRACE_ON
>  };
> =20
>  #define ALLOCINFO_FILTER_MASK_MODNAME		(1 << ALLOCINFO_FILTER_MODNAME)
> @@ -64,6 +66,7 @@ enum {
>  #define ALLOCINFO_FILTER_MASK_INACCURATE	(1 << ALLOCINFO_FILTER_INACCURA=
TE)
>  #define ALLOCINFO_FILTER_MASK_MIN_SIZE		(1 << ALLOCINFO_FILTER_MIN_SIZE)
>  #define ALLOCINFO_FILTER_MASK_MAX_SIZE		(1 << ALLOCINFO_FILTER_MAX_SIZE)
> +#define ALLOCINFO_FILTER_MASK_TRACE_ON		(1 << ALLOCINFO_FILTER_TRACE_ON)
> =20
>  #define ALLOCINFO_FILTER_MASKS \
>  	((1 << (__ALLOCINFO_FILTER_LAST + 1)) - 1)
> @@ -75,6 +78,7 @@ struct allocinfo_filter {
>  	__u64 max_size;
>  	/* filter criteria only; see allocinfo_counter.accurate for actual accu=
racy */
>  	__u64 inaccurate;
> +	__u64 tracing;
>  };

[Severity: High]
Does appending the tracing field to struct allocinfo_filter in
include/uapi/linux/alloc_tag.h break existing userspace binaries calling
ALLOCINFO_IOC_GET_AT?

While struct allocinfo_counter consumes a byte from pad[] to keep its size
unchanged, growing struct allocinfo_filter by 8 bytes shifts the data field
in struct allocinfo_get_at and changes sizeof(struct allocinfo_get_at):

include/uapi/linux/alloc_tag.h:
struct allocinfo_get_at {
	/* inputs */
	__u64 pos;
	struct allocinfo_filter filter;
	/* output */
	struct allocinfo_tag_data data;
};
...
#define ALLOCINFO_IOC_GET_AT		_IOWR(ALLOCINFO_IOC_BASE, _ALLOCINFO_IOC_GET_=
AT,	\
					      struct allocinfo_get_at)

Because ALLOCINFO_IOC_GET_AT encodes sizeof(struct allocinfo_get_at) via
_IOWR(), and allocinfo_ioctl() -> allocinfo_ioctl_get_at() in mm/alloc_tag.c
matches only the new command value and copies sizeof(struct allocinfo_get_a=
t),
won't userspace binaries built against the previous uapi header fail with
-ENOIOCTLCMD (-ENOTTY) when invoking ioctl(fd, ALLOCINFO_IOC_GET_AT, &param=
s)?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792690544.gi=
t.abhishekbapat@google.com?part=3D3
