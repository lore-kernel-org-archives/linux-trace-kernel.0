Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9572940B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Sep 2025 17:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758129038; cv=none; b=SPOSI7PYLWd0DpkbaFqyNheRclk8hOMG7Yel0eJxmiYhD+2Jo3MjxpZVhexm5b2XnJfoQpAkmYd52Y/uB0lbQHaqKXr8rNVlxcIWGZ473VTIc3v3Sv8A1Oi1Fe7tlgx1jYvyr01c8zegbKCEFz6k4NQXJu4Gv/xnDF6y9gLVEHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758129038; c=relaxed/simple;
	bh=G2z78z3yauMJqPaeDTmkhMVkVrKmoIUwOjIXhNMkTQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClvAWL1pMjyovxBfNaVLxOPFFX7fRff1MK5EtMJjQ6DarLQuioAyotEGuw52BaBUuD6p984YBJz4CnCoKqb6yR7syzrz2JQmsVoIbvq17Q+trBLULPkuhHzY6k7R6080jbycX6i6jT2Nek0btBvx7rDvXqeFBx6IWNFoJjFX2+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ujduGSxP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ujduGSxP"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-265abad93bfso9695ad.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758129036; x=1758733836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15u2gJ63Nvc+ryjb04blM2EZvX2JTQ7zkIDCOHZzkRg=;
        b=ujduGSxPFIlAG+QnsapeuoRpdNPIxfZ9pixacot+GaT7TVfx3VFarvazf80LYhjHG7
         z3AWLjVXCbpIZAhrXU5l6l2FrByts4/SFUrXCvBesRk9boBIAsxXtqF+m5h1fE7oO2TT
         MdjRRq17ZUUHniuJW/UJ7HcmMspXTl8eAg2MAAnZ4ZdODotG5zo/iWesO/eXsN/YFk5w
         1/1p4vWEtIVE1ESkjapUMg/Txi+SkFjkTPJbaKZ+jEOgENsjiiKsei8ierZjiLzp5mEh
         YjPBcpoAyQhfPb1ls6gHI45hiAi2lQ3zDjjG+QoRxrA2m6IDUYUGf2j1/c7AfoRTY2p0
         ZVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758129036; x=1758733836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15u2gJ63Nvc+ryjb04blM2EZvX2JTQ7zkIDCOHZzkRg=;
        b=tK1A0KDaDuVY5NGy2SEJBNKsxF/pDm3i226tBniPyEPRWseHNAcOLH5vFjNdvkprv5
         H9o+EK1jIx4hV0WDehVEuUtfddwpD9Z+zXA1RZYzOKCxUyU8g9Mx47J42R5DdKNLOJqS
         sfs3JbHPVTM+2G72DaoOnJ7y3CDE5VRkIDQtUNZbm8ndNsIG176upP8sQNeo/NVCJivt
         qrET/kakr0p7D9X/6qksFI50zL7mmHslZ7T8f1/GdsbdwRozM/4zMxXEEkrTrj1gEPmK
         Z8bv4td98BTnhzUCgP1UemxG6UqbGJOzUgggkprwBQZgw/2mLck3yQ1gm3OUNC2ofD+D
         VbDA==
X-Forwarded-Encrypted: i=1; AJvYcCUn5GQn8+ndELQTf2GlIEtDRqKCIEP1BbFQ0b6kzhrkB3Cy9ZzGZVpiC7h3Vqx5PGnPNZ9y59Upk4Lzu1OgB58SNZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9cdTRJywTzndCW3kdOa8ANEgXJYkN2bNJK8HzeZ0WGoig9jfm
	TUY6PK66crJ3gzDmzUVzKXj3W5blnlBB1jYIiiGlJ5xfzI/vGcZk45mJNi8zBmzBeswGPVxSLVN
	+Od14J31U5ln3fToXU1TtWBf+2d2VnxXyoRzi9qrW
X-Gm-Gg: ASbGncsPZKN8qbYW9ln7RFYGUf01szrU9w4MDg9u7RSlbcq98tvn8MSY8tT6ZuNw94v
	hDTcEoJu3smDk3lu0ZXKS+4sgYbUepYhQTFTGq2O8sTsPkNyI5zVGQUZ4tuijSoc+cRaFiU2WMH
	YLAXjbPdkXpFjjAxNWpBcoQLmcZivFZi0l0MvEqsYfMiUNqerRnh5loIemVMQdGnZtxviTza9+t
	PQuZpRqG28G4L0ddWOWzFaP/TGFEyMZkrgumjGeL29G
X-Google-Smtp-Source: AGHT+IFd4BAxZT/ufICRk+rEAu4Df/3LlVy7dl8wb8UYvf1Vkm7Wii7RkWbyYEbSSxpnLkv8kfjaHMhL5z1X210qqcg=
X-Received: by 2002:a17:902:d2c9:b0:266:b8a2:f605 with SMTP id
 d9443c01a7336-26808a2fc00mr4248005ad.3.1758129035969; Wed, 17 Sep 2025
 10:10:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-4-kaleshsingh@google.com> <c6eacb69-86f5-4bdb-9c6b-04e3f7ef7c29@redhat.com>
In-Reply-To: <c6eacb69-86f5-4bdb-9c6b-04e3f7ef7c29@redhat.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Wed, 17 Sep 2025 10:10:24 -0700
X-Gm-Features: AS18NWB7v1zd5wRtV4XjcNUI2Kl7h_0nJ3bBXH5VRcSHiB0MqTNwu-jJe9fGDsw
Message-ID: <CAC_TJvcXzrxhWFWyE7QEgPVmEJbnfT1W=s4TdgPGGAgCpn=8Og@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] mm: introduce vma_count_remaining()
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de, 
	kernel-team@android.com, android-mm@google.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 6:38=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 15.09.25 18:36, Kalesh Singh wrote:
> > The checks against sysctl_max_map_count are open-coded in multiple
> > places. While simple checks are manageable, the logic in places like
> > mremap.c involves arithmetic with magic numbers that can be difficult
> > to reason about. e.g. ... >=3D sysctl_max_map_count - 3
> >
> > To improve readability and centralize the logic, introduce a new helper=
,
> > vma_count_remaining(). This function returns the VMA count headroom
> > available for a givine process.
>
> s/givine/given/
>
> s/process/mm/
>
> >
> > The most common case of checking for a single new VMA can be done with
> > the convenience helper has_vma_count_remaining():
> >
> >      if (!vma_count_remaining(mm))
> >
> > And the complex checks in mremap.c become clearer by expressing the
> > required capacity directly:
> >
> >      if (vma_count_remaining(mm) <  4)
> >
> > While a capacity-based function could be misused (e.g., with an
> > incorrect '<' vs '<=3D' comparison), the improved readability at the ca=
ll
> > sites makes such errors less likely than with the previous open-coded
> > arithmetic.
> >
> > As part of this change, sysctl_max_map_count is made static to
> > mm/mmap.c to improve encapsulation.
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Cc: Pedro Falcato <pfalcato@suse.de>
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
>
> [...]
>
> >       /*
> > @@ -1504,6 +1504,25 @@ struct vm_area_struct *_install_special_mapping(
> >   int sysctl_legacy_va_layout;
> >   #endif
> >
> > +static int sysctl_max_map_count __read_mostly =3D DEFAULT_MAX_MAP_COUN=
T;
> > +
> > +/**
> > + * vma_count_remaining - Determine available VMA slots
> > + * @mm: The memory descriptor for the process.
> > + *
> > + * Check how many more VMAs can be created for the given @mm
> > + * before hitting the sysctl_max_map_count limit.
> > + *
> > + * Return: The number of new VMAs the process can accommodate.
> > + */
> > +int vma_count_remaining(const struct mm_struct *mm)
> > +{
> > +     const int map_count =3D mm->map_count;
> > +     const int max_count =3D sysctl_max_map_count;
>
> If we worry about rare races (sysctl_max_map_count changing?) we should
> probably force a single read through READ_ONCE()?
>
> Otherwise one might trick vma_count_remaining() into returning a
> negative number I assume.

Agreed, I'll add the READ_ONCE when resending.

Thanks,
Kalesh

>
> > +
> > +     return (max_count > map_count) ? (max_count - map_count) : 0;
> > +}
>
> Nothing else jumped at me.
>
> Not sure what the buildbot complains about but I'm sure you'll figure it
> out :)
>
> --
> Cheers
>
> David / dhildenb
>
