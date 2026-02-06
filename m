Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EB52DE6F5
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Feb 2026 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770397109; cv=pass; b=eG3gEuZuihZSNbfh2Zgw2TcwFTQqdkT8hJWZnaWh1BqYIFOx+a7lL1Zp/+RY9THWfaAgUNuP/ePZNeT+LQHBdf21s8HdhM8CUiqPQjEwws9uSYgwOA2ZQRyA7tuLMUXQ2e4OmaufS+dEDALDQ/jc9KkikxFPV8RECh85GllZDdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770397109; c=relaxed/simple;
	bh=6IBq+XbEsFN4SvSjZqsxD5Hu9kTyhaVUfqnxmZg2dCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iral5xGFG/cxHzLztWnLfBtpeVRSyIsiTFZovNQb2PGaokL9WReuA8kO8f318qExZH1F5f4l8IAewcRAvCc9CrpolH8TOfgfYuyJODGjXpApLoDeMerdfsFwfIxFmHSRCetr09TGlopt+WReIvS0iGr1bkPuN8XRcr7JDcizFJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnsGqm39; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnsGqm39"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-824484dba4dso705315b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Feb 2026 08:58:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770397109; cv=none;
        d=google.com; s=arc-20240605;
        b=fT0D7qL1BUCppqIJQq6HL+GQOTdEHyOwrP5NHnUEoCmx3aD82M+6G1H/FaC7wcad97
         U2NoRqkLUj2HtD9aVtVdf3hbYuPaI25+5gwcpPTEFQ8rDFjO98Ir5OFwQTL8XTDbNY0J
         4EaU9C/z+7qEINRkyQ2MJWjMjxWSb7CddAWZrm0LcHU9Gm7yHGTnbwkvAY1rVpHTpWJJ
         BmqauNvrpCpzthwznOx3msxavozz1qMlp0l0qmJXPfPe3URBOyhK9NTI9F/DPQR0uGmU
         AB9ZeVMwh7sBxpVL8PsHK4gA0aasKjmdEZ7LVu3nAwt926oSkYjkK1C8+LaDZH4N891C
         mivw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XLXsV7YNko4F5p8PCqHk8efpKDU+F1mnMJ2HETyCDMw=;
        fh=7HhqeHXcUiuikh0FujPKuZ6s6KlM3UFDIDRVerzhK5I=;
        b=jOKs9387NuVPnsxLbnbg5vpJXzvp/+64xAx4XrmGiM/6oCNNX3syMR7amYyU1rQ/IM
         1WRMDrGyh2R4xeK50y8k1lPogg4XnW3PjY+/qGjdj047nia+C/jWiYsW9mrMkOo92izj
         LvhPz3NF3wmdeYSW69pKVSMWeDcnTltSrUT7dXSBe49zo5nqte15drJuhf/hET6PQa4C
         vWTMpn+wDTW43yq1aryaDpE7Q8iImJqst6KZ0/e7OPuoTO3kPqqVnhGMQ87d0xMybyn9
         Wvr1tgDSEcRbo9DWi29vrBqfOz37sUXTecD2SZ5BqnwZt968e46ikb5c3pfLgvPhB4P2
         t+Lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770397109; x=1771001909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLXsV7YNko4F5p8PCqHk8efpKDU+F1mnMJ2HETyCDMw=;
        b=KnsGqm394y9Ec5UmYEfDL9ebWNGzvTU2cZS3NoZnx7zBh9F4O8PNar8bwKiYjxUDgJ
         VhSwsGqloAFm0uqWB3+rVOwA1zL1XaUzoWSpfl/SNMNRqu8oU/Bk5yW4C7eFxn6FzI8M
         Dc8IbWLT0nXHVygvrdktGAmLBcz6K9BvkFSvI4WXvL74IKGYMyyjs6NvigIA1+X9oYLL
         kOXK6xTJ2Nac1UaayEWeT9nRBibuJUiStJCNe/UFzTzuw2VhZzC8mDvObiYfNS5viVMI
         suSN5gZ61EUYq41duqUpEfBeoT48INOdC7AncsBzR3lL7VSdJii0h4BfdMCQzpKdVstG
         oMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770397109; x=1771001909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XLXsV7YNko4F5p8PCqHk8efpKDU+F1mnMJ2HETyCDMw=;
        b=vp7OLpv3OwgVLZGUTb0pQgHbUrioj5DIXiS/029MACutsxDc4KrPKJBwh8auDprpMw
         ufjf3GIZcWkG3D10/383Ck21A+nOzYYkzv2rch6R/UL1VdSBReVWy5Gj7OVn8VjZS4WV
         cQg/J5RSocQ4KUhc6SfyWPnWKPktXmAZek2DK59H4iI3ka3MxnfVdQtWgW8XgEjSOc1e
         jvWOHWVWA8uw3cO2XUhWLDnJrVztOgZ6h/TNyC4d+qOSPTW+DLWgjRUC4c6FGDNgQmSE
         dPaIPwB+52CFtKwhQQVF34yh2bB3tZfO/DibzCrtaaQAMrsvn+eY3VjgaRVPHTOkMrGj
         EQQA==
X-Forwarded-Encrypted: i=1; AJvYcCWy7CyBp/w4OMSFWXtip9wINqjbQl8bsx54ZU1fMD4aeU110nufvUy2YlSsscrsY61U9/YScJjWr39sFO/jQm+0Wys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzacrHh5OoI/Cy9Y61HSgTZAFcy7Q4jYCVPlHVmvxjInClMZFHx
	31tx9+Tt1OM1LQD4DvebDMTdLu7iT7sff9JOErKt5JK2Zm3j9gaoHu1BtTihPbdgY7226iSCVay
	gnQaOmyR1wwTR8ByDET5YFjWqng216nY=
X-Gm-Gg: AZuq6aK0PHbnHb4Ixy8hIenYQef8ZTOax4MwXtvfjjwvW9pA73wQzZA/rjOyMNA458q
	Qa9Y/2abR+pqIukgYGbNzq1nbvPivj5MQ45381iIAMSQR8O2bCh+wsBm7I8fbX/GP1hH3EnVjhQ
	BdjxIleEO2gp8xp4WKkEfrpSbArEwEAv7jcTqeVUMj8wObII9wmOz8itzi+0PL0Y0vs5+vDNVE5
	QI/NdBormRtcjzbaZUbMrYlPKFPUdhJ2M8aq3x80LklatOuaMMPoY9EFIIwwVTNftRW9QPJAlGE
	kP5b+bIGeVdtmDF8IYgEyg==
X-Received: by 2002:a05:6a20:43a3:b0:35d:5d40:6d7b with SMTP id
 adf61e73a8af0-393ad369c51mr2887295637.37.1770397109028; Fri, 06 Feb 2026
 08:58:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203093819.2105105-1-jolsa@kernel.org> <20260203093819.2105105-9-jolsa@kernel.org>
 <CAEf4BzY7zZmEqFq577NiG2wh0aU0_og1_RjVSURjaqTOnTc-Bw@mail.gmail.com>
 <aYRbbL-QCnAZ6PGD@krava> <CAEf4BzbzrPemyBe0xtEwuxG8d-JUC+Dd+B412VBLLAui=88LEw@mail.gmail.com>
 <aYWpotJVLSZdiZgG@krava>
In-Reply-To: <aYWpotJVLSZdiZgG@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Feb 2026 08:58:15 -0800
X-Gm-Features: AZwV_Qgu8joHCiUmGxaBJbBTrtx31pQZffg_bfACSxJhNn6lYqmj5nWwGsha45M
Message-ID: <CAEf4Bzag8E-hUyQ9CR671HTiDngiQFBRGqoicSpVigFhuQy8Kg@mail.gmail.com>
Subject: Re: [RFC bpf-next 08/12] libbpf: Add btf__find_by_glob_kind function
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, Menglong Dong <menglong8.dong@gmail.com>, 
	Steven Rostedt <rostedt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 12:43=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Feb 05, 2026 at 02:45:14PM -0800, Andrii Nakryiko wrote:
> > On Thu, Feb 5, 2026 at 12:57=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Wed, Feb 04, 2026 at 11:04:09AM -0800, Andrii Nakryiko wrote:
> > > > On Tue, Feb 3, 2026 at 1:39=E2=80=AFAM Jiri Olsa <jolsa@kernel.org>=
 wrote:
> > > > >
> > > > > Adding btf__find_by_glob_kind function that returns array of
> > > > > BTF ids that match given kind and allow/deny patterns.
> > > > >
> > > > > int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
> > > > >                            const char *allow_pattern,
> > > > >                            const char *deny_pattern,
> > > > >                            __u32 **__ids);
> > > > >
> > > > > The __ids array is allocated and needs to be manually freed.
> > > > >
> > > > > The pattern check is done by glob_match function.
> > > > >
> > > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > > ---
> > > > >  tools/lib/bpf/btf.c | 41 +++++++++++++++++++++++++++++++++++++++=
++
> > > > >  tools/lib/bpf/btf.h |  3 +++
> > > > >  2 files changed, 44 insertions(+)
> > > > >
> > > > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > > > index 83fe79ffcb8f..64502b3ef38a 100644
> > > > > --- a/tools/lib/bpf/btf.c
> > > > > +++ b/tools/lib/bpf/btf.c
> > > > > @@ -1010,6 +1010,47 @@ __s32 btf__find_by_name_kind(const struct =
btf *btf, const char *type_name,
> > > > >         return btf_find_by_name_kind(btf, 1, type_name, kind);
> > > > >  }
> > > > >
> > > > > +int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
> > > > > +                          const char *allow_pattern, const char =
*deny_pattern,
> > > > > +                          __u32 **__ids)
> > > > > +{
> > > > > +       __u32 i, nr_types =3D btf__type_cnt(btf);
> > > > > +       int cnt =3D 0, alloc =3D 0;
> > > > > +       __u32 *ids =3D NULL;
> > > > > +
> > > > > +       for (i =3D 1; i < nr_types; i++) {
> > > > > +               const struct btf_type *t =3D btf__type_by_id(btf,=
 i);
> > > > > +               const char *name;
> > > > > +               __u32 *p;
> > > > > +
> > > > > +               if (btf_kind(t) !=3D kind)
> > > > > +                       continue;
> > > > > +               name =3D btf__name_by_offset(btf, t->name_off);
> > > > > +               if (!name)
> > > > > +                       continue;
> > > > > +
> > > > > +               if (deny_pattern && glob_match(name, deny_pattern=
))
> > > > > +                       continue;
> > > > > +               if (allow_pattern && !glob_match(name, allow_patt=
ern))
> > > > > +                       continue;
> > > > > +
> > > > > +               if (cnt =3D=3D alloc) {
> > > > > +                       alloc =3D max(16, alloc * 3 / 2);
> > > > > +                       p =3D libbpf_reallocarray(ids, alloc, siz=
eof(__u32));
> > > > > +                       if (!p) {
> > > > > +                               free(ids);
> > > > > +                               return -ENOMEM;
> > > > > +                       }
> > > > > +                       ids =3D p;
> > > > > +               }
> > > > > +               ids[cnt] =3D i;
> > > > > +               cnt++;
> > > > > +       }
> > > > > +
> > > > > +       *__ids =3D ids;
> > > > > +       return cnt;
> > > > > +}
> > > > > +
> > > > >  static bool btf_is_modifiable(const struct btf *btf)
> > > > >  {
> > > > >         return (void *)btf->hdr !=3D btf->raw_data;
> > > > > diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> > > > > index b30008c267c0..d7b47bb0ba99 100644
> > > > > --- a/tools/lib/bpf/btf.h
> > > > > +++ b/tools/lib/bpf/btf.h
> > > > > @@ -661,6 +661,9 @@ static inline struct btf_decl_tag *btf_decl_t=
ag(const struct btf_type *t)
> > > > >         return (struct btf_decl_tag *)(t + 1);
> > > > >  }
> > > > >
> > > > > +int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
> > > > > +                          const char *allow_pattern, const char =
*deny_pattern,
> > > > > +                          __u32 **__ids);
> > > >
> > > >
> > > > as AI pointed out, this should be an internal helper, no? Let's als=
o
> > > > not use double underscore pattern here,
> > > > "collect_btf_ids_by_glob_kind()" perhaps?
> > >
> > > ok
> > >
> > > >
> > > > Also, you don't seem to be using deny_pattern, where you planning t=
o?
> > >
> > > the tests are just rudimentary before we agree we want to do it this =
way
> > >
> > > but I'm not sure I have a usecase for deny_pattern.. I think we added=
 it
> > > just to be complete, I recall we copied that function from somewhere,
> > > it's long time ago ;-)
> > >
> > > >
> > > > Also, are there functions that we'll have BTF for, but they won't b=
e
> > > > attachable? What if I do SEC("fentry.multi/*")? Will it attach or f=
ail
> > > > to attach some functions (and thus fail the overall attachment)?
> > >
> > > yes, for the benchmark tests I had to add is_allowed_func which mimic=
s
> > > btf_distill_func_proto and denies attach for some functions
> > >
> > > also I had to filter out some core kernel functions like rcu*,trace*,=
..
> > > which seemed to cause trouble when you attach them
> >
> > So the question I'm implying here is if libbpf should do what we do
> > for kprobes: use libbpf_available_kprobes_parse and intersect?
>
> right, I think it's good idea.. and in addition (just for patterns) we wo=
uld
> filter out functions that:
>
>   - won't attach (is_allowed_func =3D=3D false)
>   - might cause problems (rcu*,trace*), maybe for that we could have
>     opts config bool

Well, who's going to maintain the "might cause problems" list in
libbpf? Let's not try to be too smart. If some functions are not safe
to be attached, we should mark them as such in the kernel, IMO.

>
> jirka
