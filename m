Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792682814;
	b=sk+vZ/feC2a7+pRZzW9Wi7BVi4CjcnBcuxX7M1YMM+dYqY7HPh6GmiLQNDh4azT7uEJx
	 OipDk4Yaqaa92GHPkn6Vpzg2YG9ZBpVGbXamedCFaxloC3r/w4i30s+UbymSPvASb+jX4
	 Xpn3KHPtv6OiPRGBQfkZLbYlBHv+nW3cCVofvFcaqhYCKx5/FoZNm/dZ3339b2q2NI0fz
	 5nKNeSygrInB+y8zV+fBBfMPr805AhRnAuUdLXOJj23tJZcVW5PXHIqz1WU6kgSV68glD
	 rPGRcXleXEel9dwa70a8AyAxv/qJmnTK4gmg+r1MrlCmgc8vpfW5fdUmHOn+nx01Ryg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kKY9lXCqmIHp0E1eSfDqDHg5eGZHzHb0/xVe+f4AVFI=;
	b=holiW1XU2T7vMfN2kxd35fPn0Lc6JOFYyPJwldsgw0bSFQMk3gdI9Juo2lQuKZo1+/pp
	 c2atpx6qbFN9JQJQpQSAx2IcekFJv2oMz1sJHHEz9lSJ7jfNjZsB4bDiJiVOzW3fAReBD
	 HSWvTuE6DmsISuqNmHKPWwxp43u9gwwRP/4yyAL7JGxFTfBPbf6o9t2+h7F55vaxqizlu
	 sNDVxRpm8XMWlH+Y5eAZL9Zbu8r6uGJc5fOc2pMCPEIbSAnU/EGgjChevLAGgPXKBUPP3
	 vKbCHOdPfUw6TSEeLaqMyV/CAO4kHDtxkNur3XY58bPbC5CMGdAe02CnYOBiCaRav/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="SRWjhO/6";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02C1606A31A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 15:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F02C1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=SRWjhO/6
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5337c7b9937so380391cf.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 08:26:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792682813; cv=none;
        d=google.com; s=arc-20260327;
        b=X6yAl4TDVYN37ibQB+O12ilD+AlIO43vl1hCig/Wnfgnt4cC9QCDIXBUbxG9X3J9LE
         7R76mYuCV35sjAs102lAmSOj/pvWCADfD9iRevHVkTx8tJ7Osxpvm6p3UtkRwu35IvzT
         YBSXltv4ioZ3gU2WfHj1MGD3LZC18OM3OLAxrNg4IgKQtshklmhy0qAZXft2wkPIRgMg
         QkfAsekAeOE36wzMaRT/Lsow6DYmth5dcXLmLY7m3JP3w+u29TLdnFS6oozqdYro6/Wy
         Q9gltEMFRNYIwJP3h0ftHTLrwFgpQPlilHFAi1fJjV0AJSTij15osyHHqIT7ffStRCKA
         9CaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kKY9lXCqmIHp0E1eSfDqDHg5eGZHzHb0/xVe+f4AVFI=;
        fh=6TOEvhWDWKrDNCCQwdxpVcynBbzjlE643C04om/feiA=;
        b=piUIC671/TC6tYex4oi8Nrjn9loNFT8i9VGDEYHlR+yRpYfnyBAnAb+bjT5zvLcMNS
         tmY0kfIymEQe5XryxhUTHIy/hyufE10GTkngcYl7x/zvbLyNicRqteWqeCS1pd4GeYQ9
         9ViwjZ+y4Fn9wKTnujYap2o42Dwg/zWxsqOITGy3SvkRAxrvivebxlgP71T+QBKZnyGO
         F+q1om4j4IC96MTv4doCBBSkSZHSlIncEDyGj7yFHc8eMlizFLZ+JVErL3T842MchzMa
         685e5N8zcI2M3IMkJ2ISyNaP3UTLowcMHT2HgnWjABS3yu+XddmfqpkNqZ7e9OklYDWs
         rkWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792682813; x=1793287613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kKY9lXCqmIHp0E1eSfDqDHg5eGZHzHb0/xVe+f4AVFI=;
        b=SRWjhO/67mlCwYkFf09O9G2vA27TgXTmnwgcLgRSqbJH1Lg6dJUaG8+Rzn0W0pG2z6
         2W8Qo1E5FjW7K5WD8e1/a6KDnxsyGKWAVrEDDV5nlnlgmY7kGrQEMjqa8A73hbSUD85L
         2kvgJzr64r3pLFa64VOG0yUUZSfG4VOixinpLhQISu2sjyi/vbIH5MzEkYjQBbchxUkS
         PC+G+GejWba2OH5sNeMaYy2F9akpC5BT4k0oUla2IfFSX97ycZMrSP0CkHeZQ5x/UGNH
         rf1ukyhOowrLj01YXdBnmbXZxKOCd/RGd3SyXdfB6ulZw+iQxfAbXZFhjDo/yf0ugTeW
         3uMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792682813; x=1793287613;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kKY9lXCqmIHp0E1eSfDqDHg5eGZHzHb0/xVe+f4AVFI=;
        b=hp2cj489As6roXpfmEYaAnmM2QMcQGxG9pyJCPEIQSbh8X4/tO+nfpF1VPwdjbCraE
         MUPgboE08OgdVOP0hqApv5aX/3yRZmuKYLhTld1tK9eegW2mAlJiZm24TiUMUpBXJrI2
         Ojq39VlodhuuycFUN9zKUfiFowKm34H4YKed2OPwNiVJO4FIYbh9j4Aav5NkAeIpohgh
         jLDtkhU3bPll4tyIrZ69EakD7uLQhRocsfLC5Skp/JopDsvaPOf2WyjyjagO40viV6Xm
         QSl6OKSQ6QsFU8RjCSOS0AMawHOTRpRDtrTba2DG/YT+BXeXBKCV6hc0TPdlCKI5e66A
         G3+Q==
X-Forwarded-Encrypted: i=1; AKwUvByMdqtW6b+qLzUqI1+OaNzNHjCJwt7Dk7YQ8atpO/K3m91yO7PenKiS2pHs2ZZeB2yC3Bz1UZncBKg9zUNCDQ0CtKg=@vger.kernel.org
X-Gm-Message-State: AFq9FYINFioWTTBxBVKyI20V+9d/O8/xDtnilALKmsiidQx8NsffRsfi
	J2t3CxI7wmu+1YkTKsD+OoaeBecXkx4bL/3WiAsTxR/SqB1hnX9CmcMWeShpVnz7QFndS0h3EvN
	PkQSG2CRUOIVRnv7RzByUuUA/dvB2E+d3pDYuti6Q
X-Gm-Gg: AYBFou1r+iEG/9vee9sXdt7n7RYvYHqL3Lk7zgrF0VByb9pPC4aaDJ+A/xUOuUGNL1H
	o/IKyiNPvoEKbMwnF2UnMLR7BaCiEQDVFgNZo1rI8+RGebzxpz2H33iAoU3tCxA4p0RCJEAxOth
	l0Cy385/sjai0rax8V4Pn3K9sgs+XS40oS/x0Fgozh1G1dYvep+gFWyspRynXskgBtjXUPEX9eo
	tGDB9OCoidNVqCMaGlKjzTrr6DTmOAyVY/b3hxmwP/lEbbIRYdIzdRirrlgBFfAwhV5i4pzgpm4
	8GRD3I6fyuprRuccM4nbgqLriHle4qJqdNIF9CRZPMdt1YD/Ns91YOSGhdCKrhKrech3qlWwv3o
	Xpnn0qsyT8sQ6F7fR775+Cp/h68m3puCE328DddLf8/aNNJeaeV+gHPgsD+/fvInQ
X-Received: by 2002:a05:622a:e314:10b0:532:a17b:9581 with SMTP id
 d75a77b69052e-536aeaf3b92mr12054111cf.3.1792682812079; Thu, 22 Oct 2026
 08:26:52 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792439751.git.abhishekbapat@google.com>
 <9e49a8f68e4e7d25c5a9a73c1926f68e468ef320.1792439751.git.abhishekbapat@google.com>
 <98855929-df9c-4615-84ea-b90acba8c2ae@linux.dev>
In-Reply-To: <98855929-df9c-4615-84ea-b90acba8c2ae@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 22 Oct 2026 15:26:40 +0000
X-Gm-Features: AclHuK98Q_RR2pQhVQuaYAm5_PHt843ZOWGZFsQ6emeYuT-eX4QwHRsne4e1aO0
Message-ID: <CAJuCfpFDT7ZiUaSwcxr5sLNOm7gNr0kibJHzcuMev2fLkJFOMA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] alloc_tag: Extend allocinfo_filter to support
 tracing queries
To: Hao Ge <hao.ge@linux.dev>
Cc: Abhishek Bapat <abhishekbapat@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 7:43=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
>
>
> On 2026/10/20 04:00, Abhishek Bapat wrote:
> > Extend the allocinfo filtering mechanism to allow users to filter tags
> > based on their trace state.
> >
> > Signed-off-by: Abhishek Bapat <abhishekbapat@google.com>
> > Acked-by: Suren Baghdasaryan <surenb@google.com>
>
> Acked-by: Hao Ge <hao.ge@linux.dev>
>
> > ---
> >  include/uapi/linux/alloc_tag.h | 8 ++++++--
> >  mm/alloc_tag.c                 | 8 ++++++++
> >  2 files changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/uapi/linux/alloc_tag.h b/include/uapi/linux/alloc_=
tag.h
> > index dafcba2f7e2c..a96054ac2237 100644
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
> >
> >  struct allocinfo_get_at {
> > diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> > index 9ff9dd04d692..0d4d267c065f 100644
> > --- a/mm/alloc_tag.c
> > +++ b/mm/alloc_tag.c
> > @@ -250,6 +250,7 @@ static void allocinfo_to_params(struct codetag *ct,
> >       data->counter.bytes =3D counters->bytes;
> >       data->counter.calls =3D counters->calls;
> >       data->counter.accurate =3D !alloc_tag_is_inaccurate(ct_to_alloc_t=
ag(ct));
> > +     data->counter.trace_on =3D alloc_tag_is_traced(ct_to_alloc_tag(ct=
));
> >  }
> >
> >  /*
> > @@ -323,6 +324,13 @@ static bool matches_filter(struct codetag *ct, str=
uct allocinfo_filter *filter,
> >                       return false;
> >       }
> >
> > +     if (filter->mask & ALLOCINFO_FILTER_MASK_TRACE_ON) {
> > +             bool tracing =3D alloc_tag_is_traced(ct_to_alloc_tag(ct))=
;
> > +
> > +             if (tracing !=3D !!(filter->tracing))
>
> I recall Suren had a small nit on this hunk in the previous version.
> I don't see this change here, did I miss something?

Yeah but Abhishek replied to my comment citing similar usage of !! in
other places in this file, so let's keep this consistent.

>
> > +                     return false;
> > +     }
> > +
> >       return true;
> >  }
> >
