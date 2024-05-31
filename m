Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB6D176AAA
	for <linux-trace-kernel@vger.kernel.org>; Fri, 31 May 2024 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717175920; cv=none; b=Z/uCRl1JpyA0sOFN2smkaTnOTjT8PXDkZ4mVCBBaDFM1zVghbK053/8FiYW2nLmgQRA0ttyx4q3pZ8W3WHecRJWqW7E1vE1BgHtE9N8GZXwO3yOvhKXcMvbU5Y+zrNyXOlq2fclXqDukztWPyBOb9jM35zE5QNB99AYBRzV5uw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717175920; c=relaxed/simple;
	bh=DS0hDZfNJZkkzFy8Yct62SEoWnrdxNIojjUrc12e2eA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZ3PQdIcvOtvLr8PiIY6Ebsp72MaSSgS5h40ZNjg91jc452pkHkK90++8ecpq+CyDSbn9n6d2VcGobsr3ZBWDGLhuAXDql68qqcLm2Ssau+6bDndIJVhlnXkBCDkqVYR6jDLXr3zE6UOVDIE67vFINX1k8kOtgsy+Uv8g3oLDvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1w8vZTdk; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1w8vZTdk"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a688ebb75b9so63355466b.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 31 May 2024 10:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717175916; x=1717780716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knmodrcY3ruf2qGktj4YBIa4Hu+EWJ5K27FOck3RpeQ=;
        b=1w8vZTdkn+mPNnfeaWCWFNEU2c0f10pXctds/U0m7HG321kIqRwKj7ZzOISd/4CFbo
         0Qbb0C43thFfBQ/XGsE/onPkA/f7t8pi9JWwq1JN8Ngl7X+ruw3hQmfOFiWhqsLnNzS5
         OBCvVAbg9a+tQoCO/5ggZt+VwHVs9xnzRtUXiMEaLuNMklAk7CBhnWORDhd/Q9S6vygi
         GD6Qyz6ucJSPj0Y50j1WL+MF4Wnki2JP35aph5oXkc6X8OzyQawOa5tNM/6FBQ3wGLb7
         t3918HXF74NBmQ07gKJ+4DcgFiL3pjccK6f0wXtM7U3pLLAuYavoR900EBrtbxehHdtq
         P58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717175916; x=1717780716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knmodrcY3ruf2qGktj4YBIa4Hu+EWJ5K27FOck3RpeQ=;
        b=GZ+mv2yqJyv269krlxWWwWkucDkoLnuTlHh31fwm0SqpgvIsyYTlKC8vTlcNbYbhMO
         y+0ZDlcErd4zwmt57+HSnNC/6PdYbpwJqtheLJgxTkcdipq1ne+Mzr17CPXXvxY/RBXt
         9TWT5fACtqpMygPyItzVAZfwGJHevgowiYe+4VLyPD16d3N9TnGus9UgZTgqR/3VCD0C
         RY9guj3DcTTxloi3sC/POTyt+5zyTu2f1rv/D2gIl23ms2CC6Lp3TlD6NzpAylJOubRH
         p7PjzZptrIMyefzC9rdMvKfGF3lnQ7ZGtT+7Q2Kweb5GN13hY6NPkVbvPvavSDJmdedi
         5n4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKUeTOcM5f1sKGZbitWqVBFhWdNOBYma7tuPpjoRk9gSwWT6d3RMJfzJAi/9ahvkCIzYmw6MXFUg1CMqsk/SqTEGMIkxGZSvk/AUK3NunEABsu
X-Gm-Message-State: AOJu0YwDCAn0Ja5Wo41AoSJ6cooNq4mAjpR0uDagLmtg7gLbZl7dDYPk
	8kaZWDTHV31RFt8OxOfhN6oiU2Z+bNlEp3vlTq19KntePJaDZZO5OMby2kvt91lOr/RDYd1a4Xw
	3kYnNBm2H+wKAtCTZAD7d3PCxaILvBY8Yfrio
X-Google-Smtp-Source: AGHT+IFq57opgQgUB+TA+18B1Szt8imqxEQZcxRZEyIW0myS+jg9WzpqrrZiKo7rqzk0TmUBniiGQ6+5D9+jhENDG1U=
X-Received: by 2002:a17:906:a1c5:b0:a67:b440:e50f with SMTP id
 a640c23a62f3a-a68224472c9mr177860866b.63.1717175915378; Fri, 31 May 2024
 10:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531-fault-injection-statickeys-v1-0-a513fd0a9614@suse.cz>
 <20240531-fault-injection-statickeys-v1-3-a513fd0a9614@suse.cz> <CAADnVQJ=bNg9nWQPXGjJ11pZnmjntt=zLBqtJng3328T1L-u0g@mail.gmail.com>
In-Reply-To: <CAADnVQJ=bNg9nWQPXGjJ11pZnmjntt=zLBqtJng3328T1L-u0g@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 31 May 2024 10:17:57 -0700
Message-ID: <CAJD7tkbvjhtFoycNvqbXVzKh2c=RE_cih7k8tnpDRFXSx7tatg@mail.gmail.com>
Subject: Re: [PATCH RFC 3/4] mm, slab: add static key for should_failslab()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Akinobu Mita <akinobu.mita@gmail.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 9:44=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, May 31, 2024 at 2:33=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> =
wrote:
> >
> > Since commit 4f6923fbb352 ("mm: make should_failslab always available f=
or
> > fault injection") should_failslab() is unconditionally a noinline
> > function. This adds visible overhead to the slab allocation hotpath,
> > even if the function is empty. With CONFIG_FAILSLAB=3Dy there's additio=
nal
> > overhead when the functionality is not enabled by a boot parameter or
> > debugfs.
> >
> > The overhead can be eliminated with a static key around the callsite.
> > Fault injection and error injection frameworks can now be told that the
> > this function has a static key associated, and are able to enable and
> > disable it accordingly.
> >
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> >  mm/failslab.c |  2 +-
> >  mm/slab.h     |  3 +++
> >  mm/slub.c     | 10 +++++++---
> >  3 files changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/failslab.c b/mm/failslab.c
> > index ffc420c0e767..878fd08e5dac 100644
> > --- a/mm/failslab.c
> > +++ b/mm/failslab.c
> > @@ -9,7 +9,7 @@ static struct {
> >         bool ignore_gfp_reclaim;
> >         bool cache_filter;
> >  } failslab =3D {
> > -       .attr =3D FAULT_ATTR_INITIALIZER,
> > +       .attr =3D FAULT_ATTR_INITIALIZER_KEY(&should_failslab_active.ke=
y),
> >         .ignore_gfp_reclaim =3D true,
> >         .cache_filter =3D false,
> >  };
> > diff --git a/mm/slab.h b/mm/slab.h
> > index 5f8f47c5bee0..792e19cb37b8 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -11,6 +11,7 @@
> >  #include <linux/memcontrol.h>
> >  #include <linux/kfence.h>
> >  #include <linux/kasan.h>
> > +#include <linux/jump_label.h>
> >
> >  /*
> >   * Internal slab definitions
> > @@ -160,6 +161,8 @@ static_assert(IS_ALIGNED(offsetof(struct slab, free=
list), sizeof(freelist_aba_t)
> >   */
> >  #define slab_page(s) folio_page(slab_folio(s), 0)
> >
> > +DECLARE_STATIC_KEY_FALSE(should_failslab_active);
> > +
> >  /*
> >   * If network-based swap is enabled, sl*b must keep track of whether p=
ages
> >   * were allocated from pfmemalloc reserves.
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 0809760cf789..3bb579760a37 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -3874,13 +3874,15 @@ static __always_inline void maybe_wipe_obj_free=
ptr(struct kmem_cache *s,
> >                         0, sizeof(void *));
> >  }
> >
> > +DEFINE_STATIC_KEY_FALSE(should_failslab_active);
> > +
> >  noinline int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
> >  {
> >         if (__should_failslab(s, gfpflags))
> >                 return -ENOMEM;
> >         return 0;
> >  }
> > -ALLOW_ERROR_INJECTION(should_failslab, ERRNO);
> > +ALLOW_ERROR_INJECTION_KEY(should_failslab, ERRNO, &should_failslab_act=
ive);
> >
> >  static __fastpath_inline
> >  struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s, gfp_t fla=
gs)
> > @@ -3889,8 +3891,10 @@ struct kmem_cache *slab_pre_alloc_hook(struct km=
em_cache *s, gfp_t flags)
> >
> >         might_alloc(flags);
> >
> > -       if (unlikely(should_failslab(s, flags)))
> > -               return NULL;
> > +       if (static_branch_unlikely(&should_failslab_active)) {
> > +               if (should_failslab(s, flags))
> > +                       return NULL;
> > +       }
>
> makes sense.
> Acked-by: Alexei Starovoitov <ast@kernel.org>
>
> Do you have any microbenchmark numbers before/after this optimization?

There are numbers in the cover letter for the entire series:
https://lore.kernel.org/lkml/20240531-fault-injection-statickeys-v1-0-a513f=
d0a9614@suse.cz/
