Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792436172;
	b=NatoMqfB6J38nTCRe8Hjj2fihgAmLn/Sfb7JVmZ7vCb657ly7Avu7lPMohVkjJPqAD7D
	 J5PF3MS9NhUC76Iz5v6QmajByxGCdY9JX4XLwVca3DA8f0Vi7MV4Ex3XJMd976fj+Mz1b
	 cPTTgS5P/72JX9ID6bNK1s/+ddt4ZGyAezAQgLqMQPOUxGSiEvPVBKowzJqii4XTq/Sik
	 vz/wRfPpGTyoK2nws/WEE+aC7RnkAh4YjBkM/SVMITi2xkaKl5cXkO7q/SuB9fjP+eHvi
	 ibVy/uEkYhbWtCZA5E24my1PhBMz+RpnsMjDDZGL9XN2mri5KFrZk2AUaAQkCA35LpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436172;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YweAkpYKyGj3scLTRzUA6IGAh/m/fJWQQXcdDA+kHZI=;
	b=stabG/rkTuYNwa3tGYa3fJVVlZxOmx1FwCImU0Bo84PCxo4etEtIE41FVgf5IXmCRD0r
	 Dsaf52uPxUHcHY+W4qg5sJvcrGC6AIfbXxGc7ywVLxoLPb9gkNfmFCKFddX784dx+0TvA
	 4xzeOo2nWOloZyM5IBIsIOtvPryy7+B06NpW4+TwT+HotwUl6bYpzXhT3d3XY9PlYqZ8Y
	 hSRTN12si+EWP83oClh+qIbrPW3cC7a2kKPfVbA6V0u/+mfhmbR1ZvkvbEmTCaKsPMbpJ
	 DX+Ra84BHN+ykHJ44ER94FFkHyr86fINVibSoDUn0l59feCikXvePn6hKw3adpURIDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=oDMD6X2E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB6D606A32D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 18:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EB6D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=oDMD6X2E
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e9f6a16afcso9835ad.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 11:56:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792436171; cv=none;
        d=google.com; s=arc-20260327;
        b=JwbJzmnbsul0VtPbLWzBqLHGg2HNptP3S6kuYWqHttlxTBbFSW26/udiGmoEmzjeSd
         6tkoF5wsRnat87i71Z9U7V28nMN002KTQ+rb33rHeSypURh1kY5uRg2kO3swuKNoDrAN
         FSU7AUxQayHOkUxntfCKFQALiZO1NzOD+DD6+vAupFuqNTenmbKH0YzPeAvVCRZFM7YE
         +JzKLiElVdyvzEhdtTv/UPu0pGJE8Fx+Gp9RzELS06DhezILf2NMgxxC/lSyWYw5fINP
         aD3ynMVemIASWH3Gq+zMfvSagTcrqJNYkk4Qihjxi0FA9yK8ICGF1UQUR4072gO6Ct+V
         qMVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YweAkpYKyGj3scLTRzUA6IGAh/m/fJWQQXcdDA+kHZI=;
        fh=xLzgsYYURTCU0+MvPJUFotjf/ms1QZ7C0YT+R2zZ/CE=;
        b=XMt6EzIQgnAAYgUgqOijDazhSC2hmFSf5S7Oatgg1YVOpfAXhEb6jdbhwqjuS8h3KW
         QUdC3US8CPDrjiDVjYuafrjPBYK8YtIs13efj7M54yoBEKhJvNeJlZai6uZdyrQ0Fqgc
         i1B7AKkg1D29buUwgFRg38E5seo+MHYGkkHoDI9M+NutHG6ZrA/rTQv/tEUTmBlTxH62
         9WJlv8ipyEHTLxKX1NceJ3zjSL7EuXvBlQG6M9UGFyQXVjsWl+gYRN2eRvcPH8CYkHsW
         2bpiyio7xArtTNE3D/MyDGs9JjD2+oyF0txKykKuH4UnhqRSo5QnW1NRUfFmwgAnLEM9
         ZaNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792436171; x=1793040971; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YweAkpYKyGj3scLTRzUA6IGAh/m/fJWQQXcdDA+kHZI=;
        b=oDMD6X2Eh4w3FF8FEe47ZcJa+Qt0V3MyeqweKl16cI1EEoBLMhYXZPP21MLDprf/hd
         LZ6sDd5RawtsMHDi0yrbLzK6zKod14lmEU8fEs9x/0Mltbw6nR9EkOlq05zMCsuUxD39
         c1Y5fKSxu/5LJKvM5LFLvGe0n531IHMtbOu2qGpfAq715K0cIwNio9FsN4N4h059Ql43
         7OL2hfH1L5TQK/lNP0YqSkqODA8N9z/7mGCHE4IWhDqrZ5NwlJultZSYyTNeGdLRi+uu
         jpmbk2sscX2AjFItDLw2Lhyxq3lcDWWxTvEAcqnQhrDY38rCVku38OcJOWp8CRWh0Xj8
         fyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792436171; x=1793040971;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YweAkpYKyGj3scLTRzUA6IGAh/m/fJWQQXcdDA+kHZI=;
        b=QxKBf9IotUXkYZ9sVz6FGKn+E9M+YwXkpO5LTfLK6jGfJpH/Iod3iSpCw48OjE2owO
         AEW6nxdsk8wJtkyC30H3YOahiBLSC+x1JFQbaia0fg2ce1gQnyNjNsyOoMH1xQE7IY4y
         4ieHRXLasFLhMZYsnxHrsSLddIVI6T0/ABJTmhAXRc8gHyCVApnZHZ/XmCvuNacH5Dby
         P7RA02lcAW3VcCYEgkjYcEjkMi52lPE8rj/kG+diK+uwJb9MskE/cA31MKvdB7yxZ6K9
         Q31olkjmXGzkEPqZWjmRYuFVfLrAYAQujS9nzest2VTcW7tIX6gR8o6axiuJXXXI5Xsb
         6thg==
X-Forwarded-Encrypted: i=1; AKwUvBy0vDedjb95LDZpNs/7FGWAJk6cmsARvQ+avNGVOZaEA3+B/tYsp75ghGHIJBUkcvMeeP4MzcT2vHe/KRSgj3sL37I=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZIa5uvrkfC+tt840rQci43JU/6t/aDCTCDbl4yjDq/u+oDkDw
	9uI4uzYt5X1M6XCgF740iKqB7kbWDQk8LDNidRvkTdYuNqtcr4abKmNF9DTZRNqOIRb3h9bPmcv
	FyryN4/vKIKnhTY/1JHlACJ+8PFzaZUSWHsCSnbQW
X-Gm-Gg: AYBFou1h1ZX4gOg0DhGGSHsWEh274kuHfkbg/21DGlibthqQ7V4kxXIxeTzgle3uHkX
	jITqd8Io8wyLBlfB5jm0K8f2zkWHgK2uZsQut+OWjFh12xttoWkKYuW+rnCSuKTEBQnEvHRugzE
	u0tQCYbQfLlB9CfrfYRM9z7HihY5cHhTMMSp1xzGjLduvHMLG5hU1nCFDRIFtqOKiCTndUOOPP4
	+hzSyvsZQAapuP6rLzJT8lZNvi4qLCrbq6/PwCY/P5yeOfeZ37+DIU9Po2AyA/rQ/40AXo90WoV
	//pDnYyv7XcuAtpep6LjW7urX9q6QCTFSW37YCIytWDVOTJx8AOmuK2RQyS+UiQK+bPfCpafHvl
	lHSPDVmFMlQ==
X-Received: by 2002:a17:903:f8c:b0:2e6:23e5:4934 with SMTP id
 d9443c01a7336-2e9b3302552mr10210825ad.14.1792436170142; Mon, 19 Oct 2026
 11:56:10 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1791410885.git.abhishekbapat@google.com>
 <aae089a81ea891e1bc7e3ad171064d37d800ad1a.1791410886.git.abhishekbapat@google.com>
 <CAJuCfpF+kVSa0Rb0pW2gSwkBF57u-JC0J6gwFk62iGUpXVNwSw@mail.gmail.com>
In-Reply-To: <CAJuCfpF+kVSa0Rb0pW2gSwkBF57u-JC0J6gwFk62iGUpXVNwSw@mail.gmail.com>
From: Abhishek Bapat <abhishekbapat@google.com>
Date: Mon, 19 Oct 2026 11:55:58 -0700
X-Gm-Features: AclHuK-9zWJgFdAaiaHRH5quyks5irCzrBiNc0VLEM6EY4t9qn-35fHPfFLOiaY
Message-ID: <CAL41Mv7cFudV97MEr2gq_NDno8z=BtqiKegDdM-haxUq3WRCAQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] alloc_tag: Extend allocinfo_filter to support
 tracing queries
To: Suren Baghdasaryan <surenb@google.com>
Cc: Hao Ge <hao.ge@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2026 at 9:52=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Oct 8, 2026 at 2:40=E2=80=AFAM Abhishek Bapat <abhishekbapat@goog=
le.com> wrote:
> >
> > Extend the allocinfo filtering mechanism to allow users to filter tags
> > based on their trace state.
> >
> > Signed-off-by: Abhishek Bapat <abhishekbapat@google.com>
>
> Acked-by: Suren Baghdasaryan <surenb@google.com>
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
> >         __u64 bytes;
> >         __u64 calls;
> >         __u8 accurate;
> > -       __u8 pad[7];
> > +       __u8 trace_on;
> > +       __u8 pad[6];
> >  } __attribute__((aligned(8)));
> >
> >  struct allocinfo_tag_data {
> > @@ -54,7 +55,8 @@ enum {
> >         ALLOCINFO_FILTER_INACCURATE,
> >         ALLOCINFO_FILTER_MIN_SIZE,
> >         ALLOCINFO_FILTER_MAX_SIZE,
> > -       __ALLOCINFO_FILTER_LAST =3D ALLOCINFO_FILTER_MAX_SIZE
> > +       ALLOCINFO_FILTER_TRACE_ON,
> > +       __ALLOCINFO_FILTER_LAST =3D ALLOCINFO_FILTER_TRACE_ON
> >  };
> >
> >  #define ALLOCINFO_FILTER_MASK_MODNAME          (1 << ALLOCINFO_FILTER_=
MODNAME)
> > @@ -64,6 +66,7 @@ enum {
> >  #define ALLOCINFO_FILTER_MASK_INACCURATE       (1 << ALLOCINFO_FILTER_=
INACCURATE)
> >  #define ALLOCINFO_FILTER_MASK_MIN_SIZE         (1 << ALLOCINFO_FILTER_=
MIN_SIZE)
> >  #define ALLOCINFO_FILTER_MASK_MAX_SIZE         (1 << ALLOCINFO_FILTER_=
MAX_SIZE)
> > +#define ALLOCINFO_FILTER_MASK_TRACE_ON         (1 << ALLOCINFO_FILTER_=
TRACE_ON)
> >
> >  #define ALLOCINFO_FILTER_MASKS \
> >         ((1 << (__ALLOCINFO_FILTER_LAST + 1)) - 1)
> > @@ -75,6 +78,7 @@ struct allocinfo_filter {
> >         __u64 max_size;
> >         /* filter criteria only; see allocinfo_counter.accurate for act=
ual accuracy */
> >         __u64 inaccurate;
> > +       __u64 tracing;
> >  };
> >
> >  struct allocinfo_get_at {
> > diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> > index 262f00f2bba9..8e63f347657b 100644
> > --- a/mm/alloc_tag.c
> > +++ b/mm/alloc_tag.c
> > @@ -250,6 +250,7 @@ static void allocinfo_to_params(struct codetag *ct,
> >         data->counter.bytes =3D counters->bytes;
> >         data->counter.calls =3D counters->calls;
> >         data->counter.accurate =3D !alloc_tag_is_inaccurate(ct_to_alloc=
_tag(ct));
> > +       data->counter.trace_on =3D alloc_tag_is_traced(ct_to_alloc_tag(=
ct));
> >  }
> >
> >  /*
> > @@ -323,6 +324,13 @@ static bool matches_filter(struct codetag *ct, str=
uct allocinfo_filter *filter,
> >                         return false;
> >         }
> >
> > +       if (filter->mask & ALLOCINFO_FILTER_MASK_TRACE_ON) {
> > +               bool tracing =3D alloc_tag_is_traced(ct_to_alloc_tag(ct=
));
> > +
> > +               if (tracing !=3D !!(filter->tracing))
>
> nit: Compilers are smart enough nowadays to convert u8 to bool without !!
>

There's a similar check right above it that checks "inaccurate !=3D
!!(filter->inaccurate)".

I just want to be consistent and less ambiguous. Also strictly
speaking, compilers convert a bool to an int implicitly, so if
filter->tracing is > 1, the if condition without the !! will result in
false.

> > +                       return false;
> > +       }
> > +
> >         return true;
> >  }
> >
> > --
> > 2.56.0.385.gd3acb90ef8-goog
> >
