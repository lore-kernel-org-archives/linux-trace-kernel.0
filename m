Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793661451;
	b=ZqCjdcSyyR0XoHgMA/pJRoHdQGpkopgkRxunDWMLDcIyp2XwWDVtXvhCcxdMIez5fI8e
	 4Zii/JPz9dWQfailtI0WlMN0Q0q8+BMXOAIDpwEDyFPRuv2E8BfIvqzOCgVJvTaT+vFMp
	 xAxyFSVYgGwNBxM4XAJdPDh60yxWleuuEwXAGdQpZ1RvShUWXzeG/FJZdh6QQzpNocrqp
	 EnlafbSodTRJYipwp1GV7/B9mI7is2Fx743bQ0X3/+3nFlQ+n5sY0IJxa1keENADduGIp
	 NzJC/trchDyiKCGl/E6L8VUmb8PS2UUwcMGvdWNYiJ5d7IMi44zqhMt5u0cYkjtsEhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661451;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xKD9YvpeuRe/dGg9UOpRwAfoOUMyefhjGpw4KelDrg4=;
	b=lbvKQDgGJOUPqQWV280TasYZIh2Jm6cBkMb9Rti1CZm9HNn1N8PHAJ9YgVhf4u47SQJC
	 dFHYqIfCPY0dHDvEniz7S1o1bp50oQjAOKPMtwfdhpl54qS914nam49/7D0uUQlqlsY1i
	 HswzDtqG76IOMIc6ZxvGG3+7noBzYT2TLkG2XNqEgoiptL8JNK44S/PrXy2JQyT9y0k6e
	 2CdSFy+WcyDhkg5kfeiz90ZC/EYDmD9qwdPPLuyFACapjlASXeoXEwiwgEwz77ZdnTnv5
	 hCWUzRNa2O7F/n+1JiZSwkM/CknqdVQVqN3NI+jSEmgQy9yqhsg4fzue0dCfZuNTBYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UHYepW1M;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086D0606A324
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Nov 2026 23:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 086D0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UHYepW1M
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so7135ad.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Nov 2026 15:17:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793661450; cv=none;
        d=google.com; s=arc-20260327;
        b=nx6FPtEVz2y3x8530dgCmE6Z7+fe6u+bKlTWA3xZEx9HW/3tBTQ163Xu/tOvYWP4O3
         +HkNal9OzzWjhT1brNTJxAUOhPmxSGN692AgRm2WcS9y85WpEZvB94S+miCrW8ag6N60
         Ck4BS6pDtFiu3I5hKBdrioGWmkVyvE+jFDPtSD/f38RYQDQwUCBA/PSwZnZv6/43TYk7
         5kQsRn35MmId4JuuHMqdE38McJBckt5bpAeDg8YrJMGCzkl8uD+xZET4j4I0WjRHc0kZ
         RI/BybNVJPiXmKoqWo/sMGQvZ8xt6iRtYgsqq5QtRVIZl0zkrNI5A2MubDNR8Ow3qpin
         HmMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xKD9YvpeuRe/dGg9UOpRwAfoOUMyefhjGpw4KelDrg4=;
        fh=TfC/xjgb+vprYGmomA8EI4DqCxaLblOu3kXjVmvv91A=;
        b=XcuNdtLt5C1kbLWMGMc//b66IriishGKvE4ijKgdmUGBzLCOk70SkZGhfF5VvaDCeN
         9u1/u3/MBaf8hhVHlSIdeYWBxa1x618Co9mpWX2A01YjtH3BQd+BVVA+GUTjqZd0yQac
         LQuMexACviQfoNgh6s10LNCPhxJckRzlm5I4/WPbnXOi8EYBxUH4rJOiorMV2uWneSUi
         F6tr0QUcXksIw//fWRFBhr4AqFgyHBJEvj6ZIEaQ9kF268Y0rNTlUVs1q6HjKNKwLpDE
         zrkK963bnJkaeWPCOmoiEvRGYpXXEcnMahAFeFebGDpIrjKfvGOz+a7eJ2nx/hNMOd8k
         AFmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793661450; x=1794266250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xKD9YvpeuRe/dGg9UOpRwAfoOUMyefhjGpw4KelDrg4=;
        b=UHYepW1MdD6XDjtI+J/Js8WfooNo9HWZD9hX/bNs2MsfMV9iHOX/MAdaQAW6oUnupl
         2t4wtE+SFlrn7VuoqNwM8RAgDcCGM+ZiXj0WUlljvCltkQNL3rNAiLaCDL99tMzucd5r
         I1opuwyPYsPDr51UIbPyAdkLO+tn5838ES/2sURotU02d81JB/IDv0xXGNjsU10AldEe
         IhFO5etULc7z5nxQYUf2lFWkM9SXJCqDw+aUXvi8zKb6+cs+ccC6EHpo1MpS4YFN77i2
         C1Tcg5PWnR4z5zNIrF65RtJpn5l5LR1ykxBLZxfZN8hlHunCZBGC9JlJwggyj6XQOauW
         aQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793661450; x=1794266250;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xKD9YvpeuRe/dGg9UOpRwAfoOUMyefhjGpw4KelDrg4=;
        b=ptya61ROfZXvUIC8XUXX6rzxLMTYSDYnH3umKuzB3qXA9re/onGXI7CLQJ+QKLDCI9
         yV1xO1IrLylB9UBXBCknwFIUd2GkYa/+6EQs7xzJd7NqjzD4+Dzzn4j+PFjYyRZIr7mi
         IwxpJxhRMbQBh3RpB7B7CNDbQCkwuxM/IAyeLGnfWYhhw6Fegk0ygomgK7eiVg7Sm/j8
         p0hBUXxO2Zd84PxC0XPxVNSHKPMzCchmWvVztmAHUxLg1Y5wjlgk6T0bkm6GrxFEp+uS
         V33De88QBYUizQtJFwjjpXqFvvIIQU1mJNotRU2ydILJZt5DOUSaxIo+Clq9j6rYMLmH
         wGGQ==
X-Forwarded-Encrypted: i=1; AKwUvBxwZyfvxkDQfY6Gk9HK2A1LNbnfTxfzIX3CcjzYiV0mq4XH4sZLDk/2Esy1NdR/HTr+FaPyW9JBSSK5dY676/RFw54=@vger.kernel.org
X-Gm-Message-State: APuU4Z8FZ9lEp9DeSI3CbIAEDuHCjQ5OtM2IkwsZI5Hy5VmOsqnx9e5A
	zSB6Tyyr0OxeeE90uLZTvh8njk4lNbAqq3Z/zbcweISTO/mFgIZy9GymuTfUR3dsi6cbGUBYlv6
	hXrdQldHBJcm7LCF/nwsC5iaYFGnwaw1jsXKhninA
X-Gm-Gg: AYBFou1hfJwor+luQe+ZELpuWHxHd+zu64ZxP/pKmNmQVEEXfC3w8dYXvYBztpquiX+
	vB9p5Mepyl1EMW0MFRUan7PtDCtvaHvkpm32jJPflEBLKG4piDCvtQC8xngUMDtpKpMAo/j06EU
	dDvho9+tvZ+xPKRp096+pSMRXzJCRw4nD2grP6e8uQMKGxeUrZqvON5ywsB0c1zsu1FmNq/j+Fo
	e7551dXFbPlDTHXIYsJSsEjhTOTgxe2ASUOdPfm4qCTrZJONFGwzQg2eU8r9w1y0UsaY+crw6oz
	575FS9phCftKp64vURpIy7el8lUl/sD8qFor/Fag4mP3EZWoHp2XurYfdcG2AtdiBl6BQ5OV4RG
	ZWpznGzM6eUmfPdSptJJ51qpbioNubaYJgQLX5bQVpFeFFgGwoOc6/KyAQZMzgraDbzE=
X-Received: by 2002:a17:902:cf0d:b0:2c7:f0cc:dafa with SMTP id
 d9443c01a7336-2ecee02a602mr1319195ad.5.1793661449821; Mon, 02 Nov 2026
 15:17:29 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792690544.git.abhishekbapat@google.com>
 <f577c773058265f0eb7fe2c10fb6aa4003445a00.1792690544.git.abhishekbapat@google.com>
 <sashiko-outbox-183008@kernel.org>
In-Reply-To: <sashiko-outbox-183008@kernel.org>
From: Abhishek Bapat <abhishekbapat@google.com>
Date: Mon, 2 Nov 2026 15:17:18 -0800
X-Gm-Features: AclHuK-hHejKvvLFEoGswR0AFCGtiaitOOypnWQKOfKmeT59R1ag4cCR_-OpHjQ
Message-ID: <CAL41Mv64927fy+w4FVzROTS2iNjRqZc8Ss=dZxuk-WqmJpoh8A@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] alloc_tag: Extend allocinfo_filter to support
 tracing queries
To: sashiko-reviews@lists.linux.dev
Cc: Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 10:38=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] alloc_tag: UAPI breakage in ALLOCINFO_IOC_GET_AT from growing al=
locinfo_filter
> --
>
> commit b1243e6bc8216f5fe9d8786ec8ca3a597c41681f
> Author: Abhishek Bapat <abhishekbapat@google.com>
>
> alloc_tag: Extend allocinfo_filter to support tracing queries
>
> This commit extends struct allocinfo_counter and struct allocinfo_filter =
in
> the alloc_tag uapi header to report whether tracing is enabled on a tag a=
nd
> allow filtering tags by their trace state.
>
> > diff --git a/include/uapi/linux/alloc_tag.h b/include/uapi/linux/alloc_=
tag.h
> > index dafcba2f7e2c1..a96054ac22376 100644
> > --- a/include/uapi/linux/alloc_tag.h
> > +++ b/include/uapi/linux/alloc_tag.h
> > @@ -38,7 +38,8 @@ struct allocinfo_counter {
> >       __u64 bytes;
> >       __u64 calls;
> >       __u8 accurate;
> > -     __u8 pad[7];
> > +     __u8 trace_on;
> > +     __u8 pad[6];
> >  } __attribute__((aligned(8)));
> >
> >  struct allocinfo_tag_data {
> > @@ -54,7 +55,8 @@ enum {
> >       ALLOCINFO_FILTER_INACCURATE,
> >       ALLOCINFO_FILTER_MIN_SIZE,
> >       ALLOCINFO_FILTER_MAX_SIZE,
> > -     __ALLOCINFO_FILTER_LAST =3D ALLOCINFO_FILTER_MAX_SIZE
> > +     ALLOCINFO_FILTER_TRACE_ON,
> > +     __ALLOCINFO_FILTER_LAST =3D ALLOCINFO_FILTER_TRACE_ON
> >  };
> >
> >  #define ALLOCINFO_FILTER_MASK_MODNAME                (1 << ALLOCINFO_F=
ILTER_MODNAME)
> > @@ -64,6 +66,7 @@ enum {
> >  #define ALLOCINFO_FILTER_MASK_INACCURATE     (1 << ALLOCINFO_FILTER_IN=
ACCURATE)
> >  #define ALLOCINFO_FILTER_MASK_MIN_SIZE               (1 << ALLOCINFO_F=
ILTER_MIN_SIZE)
> >  #define ALLOCINFO_FILTER_MASK_MAX_SIZE               (1 << ALLOCINFO_F=
ILTER_MAX_SIZE)
> > +#define ALLOCINFO_FILTER_MASK_TRACE_ON               (1 << ALLOCINFO_F=
ILTER_TRACE_ON)
> >
> >  #define ALLOCINFO_FILTER_MASKS \
> >       ((1 << (__ALLOCINFO_FILTER_LAST + 1)) - 1)
> > @@ -75,6 +78,7 @@ struct allocinfo_filter {
> >       __u64 max_size;
> >       /* filter criteria only; see allocinfo_counter.accurate for actua=
l accuracy */
> >       __u64 inaccurate;
> > +     __u64 tracing;
> >  };
>
> [Severity: High]
> Does appending the tracing field to struct allocinfo_filter in
> include/uapi/linux/alloc_tag.h break existing userspace binaries calling
> ALLOCINFO_IOC_GET_AT?
>
> While struct allocinfo_counter consumes a byte from pad[] to keep its siz=
e
> unchanged, growing struct allocinfo_filter by 8 bytes shifts the data fie=
ld
> in struct allocinfo_get_at and changes sizeof(struct allocinfo_get_at):
>
> include/uapi/linux/alloc_tag.h:
> struct allocinfo_get_at {
>         /* inputs */
>         __u64 pos;
>         struct allocinfo_filter filter;
>         /* output */
>         struct allocinfo_tag_data data;
> };
> ...
> #define ALLOCINFO_IOC_GET_AT            _IOWR(ALLOCINFO_IOC_BASE, _ALLOCI=
NFO_IOC_GET_AT,        \
>                                               struct allocinfo_get_at)
>
> Because ALLOCINFO_IOC_GET_AT encodes sizeof(struct allocinfo_get_at) via
> _IOWR(), and allocinfo_ioctl() -> allocinfo_ioctl_get_at() in mm/alloc_ta=
g.c
> matches only the new command value and copies sizeof(struct allocinfo_get=
_at),
> won't userspace binaries built against the previous uapi header fail with
> -ENOIOCTLCMD (-ENOTTY) when invoking ioctl(fd, ALLOCINFO_IOC_GET_AT, &par=
ams)?
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792690544.=
git.abhishekbapat@google.com?part=3D3

Hi all,

I recently discussed this with Suren and we realized that the IOCTL is
in v7.3 so this UAPI breakage is a legit concern. However, we have a
workaround for this. We are going to convert the inaccurate uint64_t
to "flags" where the bit 0 would be a check for accurace and bit 1
would be a check for tracing. This allows us to extend this UAPI
without breaking the previous versions. I will send out a v5 patchset
with this change soon.

Thanks,
Abhishek.
