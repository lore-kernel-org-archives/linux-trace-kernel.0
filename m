Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792526459;
	b=xzCsK3qaAGmZqMYKCBGa6YzsrVKXIB89sX52+f9L9TFPpq+12WDPVmoQAaUT3c4T8w1X
	 Qc67l1JhK3f2B7F35/Qp7sjz5bY/3/iMLDESdzvcSKu0AqWHnJ7/dwJsYAxr0UyipHhoz
	 YGikRbo92zdmJIYptaXQPXR33ziWz83uxRcLoEIbNFPg8xFp6E6zzjdLdfQvl1sR4qA3V
	 OFOEsJeTbL9VqseSuPzG32BDADDsZiRPPUp2e7T3BSG2Uyj9RsmJ9/BCyhuTbmyfpicJv
	 yTuDuMuggn62aZd5MoeQZtqXbUjk7Z7KgBsfwK7z6hg7pBuzhrr6BCaW1wK7e28YZxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792526459;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zfyehBfZ/NZDmVggboetswaZ5EHjIBQH3RA15D3wRlg=;
	b=HX9g7URX5WWh1uI5T57bGsnFRuHzTmnliQaudedMarw/nb3x65dR+siKB6pN+Zsl89YH
	 /LMKSja6U5IGZrww4WPFsysm18w0ixAbIoQBxBv55RRsQ+k1TWC4QqafP14bX0MZyqJim
	 CkkjmD3XNd323PkDUA21KOJ4mmklIDiT3QwwlnhDvILcKt92Y+m0RWX6fLweNNvAxL6qP
	 pN64z7pQdw2CXv5J4Hj4gnp2uGgteTN3tO4s/iYOqV9sjq1to0sPWJNPXCNrdvpKlh+Y4
	 Wa7C4eU08b/BiopOegWCnC0AY2+Eg/+wWhZCh+tl9tM7jySXol7YW4gkaJWRRRz+pew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KEH9pa0d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624EC606A31A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Oct 2026 20:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KEH9pa0d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26DF1F000C9;
	Tue, 20 Oct 2026 20:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792526459;
	bh=zfyehBfZ/NZDmVggboetswaZ5EHjIBQH3RA15D3wRlg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KEH9pa0dOrTQBDrixpNqKDsr6RzRoUWWTdOEZMK4QHhiFKXks1om6u7kv4+pOXGHZ
	 UTvq8ophVkkUkPpojCXThVz0k9IJ2cdif6USzJ4+SoTnh2XpFJMqAzRFmgzFV22EAr
	 xLlUPk30MQ/6Kls48HSu7aTt//sVtx2xxRPnMKOlviTcLyHX9YWW1hIgw+2FmtL1el
	 YmbJY2IMALTIYdBelp/6D6ncT9cCQG8X38OWNPTAuEJFcDZw4G/g6zLOJhvJy9AXKK
	 V78LOF8Gkwad+/kvAhXlUjqqCvVWe7DFeuAInRrkPQTZY1k5SX9hhl6IiEFmB675k0
	 JdMuqu36pE7DA==
Message-ID: <sashiko-outbox-179524@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] alloc_tag: Extend allocinfo_filter to support
 tracing queries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abhishek Bapat" <abhishekbapat@google.com>, "Suren Baghdasaryan" <surenb@google.com>, "Hao
 Ge" <hao.ge@linux.dev>, "Andrew Morton" <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <9e49a8f68e4e7d25c5a9a73c1926f68e468ef320.1792439751.git.abhishekbapat@google.com>
References: <cover.1792439751.git.abhishekbapat@google.com>
 <9e49a8f68e4e7d25c5a9a73c1926f68e468ef320.1792439751.git.abhishekbapat@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 20:00:58 +0000
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
- [High] alloc_tag: UAPI ABI break in allocinfo_ioctl() from growing alloci=
nfo_filter
--

commit 93a7b2baed26770ea553f10bf7e51ee61056c1ff
Author: Abhishek Bapat <abhishekbapat@google.com>

alloc_tag: Extend allocinfo_filter to support tracing queries

This commit extends the /proc/allocinfo ioctl interface to report whether a
codetag has tracing enabled and to filter tags based on their trace state.

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
> =20
>  struct allocinfo_get_at {

[Severity: High]
Does appending tracing to struct allocinfo_filter break the UAPI ABI for
ALLOCINFO_IOC_GET_AT?

struct allocinfo_filter and struct allocinfo_get_at were introduced in comm=
it
1d581ab2348c ("alloc_tag: add ioctl to /proc/allocinfo"), commit 5732a4e4c1=
8a
("alloc_tag: add ioctl filters to /proc/allocinfo"), commit 6f6769ea88f8
("alloc_tag: add size based filtering to ioctl"), and commit 33588e0b81df
("alloc_tag: add accuracy based filtering to ioctl").

Unlike struct allocinfo_counter, where trace_on consumes a byte of pad[] to
keep the structure size unchanged, struct allocinfo_filter has no reserved
padding. Appending __u64 tracing increases sizeof(struct allocinfo_filter)
from 232 to 240 bytes.

Because struct allocinfo_get_at embeds struct allocinfo_filter by value bef=
ore
the output field data:

include/uapi/linux/alloc_tag.h:
    struct allocinfo_get_at {
            /* inputs */
            __u64 pos;
            struct allocinfo_filter filter;
            /* output */
            struct allocinfo_tag_data data;
    };
    ...
    #define ALLOCINFO_IOC_GET_AT _IOWR(ALLOCINFO_IOC_BASE, _ALLOCINFO_IOC_G=
ET_AT, \
                                       struct allocinfo_get_at)

growing struct allocinfo_filter shifts the offset of data by 8 bytes,
increases sizeof(struct allocinfo_get_at) from 464 to 472 bytes, and changes
the size encoded into ALLOCINFO_IOC_GET_AT (as well as struct
allocinfo_toggle_traces and ALLOCINFO_IOC_TOGGLE_TRACE).

In mm/alloc_tag.c, allocinfo_ioctl() -> allocinfo_ioctl_get_at() only match=
es
the new ALLOCINFO_IOC_GET_AT command value and copies sizeof(params):

mm/alloc_tag.c:allocinfo_ioctl() {
    ...
    switch (cmd) {
    ...
    case ALLOCINFO_IOC_GET_AT:
            ret =3D allocinfo_ioctl_get_at(file->private_data, arg);
            break;
    ...
    default:
            ret =3D -ENOIOCTLCMD;
            break;
    }
}

mm/alloc_tag.c:allocinfo_ioctl_get_at() {
    ...
    if (copy_from_user(&params, arg, sizeof(params)))
            return -EFAULT;
    ...
}

When existing userspace binaries built against the previous UAPI header inv=
oke
ioctl(fd, ALLOCINFO_IOC_GET_AT, &arg) on /proc/allocinfo, won't
allocinfo_ioctl() fail to match cmd and return -ENOIOCTLCMD (-ENOTTY)?

Since matches_filter() only evaluates filter->inaccurate as a boolean via
!!(filter->inaccurate), could the boolean filter criteria be encoded without
growing struct allocinfo_filter, or could allocinfo_ioctl() handle the lega=
cy
command size so existing binaries continue to work?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792439751.gi=
t.abhishekbapat@google.com?part=3D3
