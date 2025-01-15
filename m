Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BCF1D935A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 21:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736977645; cv=none; b=WSjcZ3n3boWO8fr41lm9+hyAUS9g0eVzt2GUyOp8a6oj5FsXRXfBfZs1h97cwm+V3HCm3recTEfBVneK7vCRtOvpKT4RWlagEvacIomxMwT94udj/CUZ/rdowsAmQ5c2nRihOOhy3KK+hPOM+Y2tMCmnDAapZKiJvclVHSrFlh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736977645; c=relaxed/simple;
	bh=45dVOnxBFMRIfoiWqTEIPP+1eu4bxw46dGNIwYgiuSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F4aWeBqZz1iPgFCdhw/3C0I+kc67ftnzumMvOK847ZdKrwyrYCKHWcE2Nq1iqjpprhJcBwOTh/vkk4Cwlwzn4OYbU95+F2Bt3Zcb/5qA+Pod9YaHP8QdYRyfXT6XSI9aJGRJMonWuA34DwVrdlorTkYUexUCWarhYyMaP0N52KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NkgTlQtE; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NkgTlQtE"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86112ab1ad4so46735241.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 13:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736977641; x=1737582441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltmn9Mm22yVt64ua+/2W5DkLu4FvUvXKpZxg/TWxbvY=;
        b=NkgTlQtEkLYEBC10MzU4mdryhHYg4wsPquhFKN5WSKi6D3/wBiYHz8shmOjrG99ICt
         bV94i4pPQ+7GX96/q8xi3Te2b/jjUQF7v3/5T5ewESQnFfP7W/U5pT5k8q317ihEKsm6
         MhAy1VJYV67IO3IaD5WGlkG8ptdgvKPqxhl1/Swb+PsRxvGoWTjlgiKdTjchZSWjPk6V
         QT7g602vVNm/k0J5dqM7dVCf1Z+YBgDxj1zhzQtP/qDcxFq0NR9ELxmr8749OukfcGLw
         XywO/A4f6QVZI90+xc8fxTq5I9ctTPiZK0N1z1zj2J8MvJ6o+KKSe9T3OmHCxhmzsUpj
         oRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736977641; x=1737582441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltmn9Mm22yVt64ua+/2W5DkLu4FvUvXKpZxg/TWxbvY=;
        b=AdrSnbrc8IYkDl1FZ2UZjrhlSN0fXZ5YHEHMvJGkTqemjAEniw2lR51Xu2C44iWwzj
         CI0OZzZRWLjdkv3O0fxwc546BMVlzWooAtwcqlvd5W0y3FIWHrMuoE7LgGoXDk9D2wJr
         Rh9o6ddD3EiFXcFXpir+oBbnibhmS23LNXOm+Y/edX8iCA3LQMPalxIAl0kaFC2yYWdw
         1r/9JlDNI3ViJbvKrxUr8deASBFqlIBxRWgD3Q0WKQZzB0XMHfxdtRAVmZQumNDqoiPv
         a1hoBgRLLvkxGKsnkN6xC3dfPddR+vNW2QpWNlgcmUsNAIF9P8q+1uSM0l+cLRZ1gRT/
         +0Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXt4oQ7/A9teZnbF75ZXUm6d189LkhMtJnOnekmkKdXfA/TKxm3esHuxfz5zqYoHTo15ICWPauYO+XT+p+v+64MqDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuLVany9ye3jjB4pJzpY9I7cYFmqEO9gPGsMqLcGD0WH7tn0bW
	ffQA0BYmu724Y8zOu0wU1NiPlPX4wlxknX/EHKAxiG7jLkUZYq7YVomMztK4ZBeH0x8MX/1vz6l
	5pQFoKXiWb/tGRjWJotm0mIfN2xpdHkIScHMF
X-Gm-Gg: ASbGnctysn0J4aOJMiUA25WE8G2CmX4PeSuvQIj3nGvNP9P5j50hop23csUkgYBdRzd
	HQ/4QXLTqVihrk6ZpW0jvhVL8YaSiaZzim8wUlOH7z3DAVRkqMMLYsH5/0tMRYseZqLYT
X-Google-Smtp-Source: AGHT+IHddxhJJTm91TzdAwSi6uafTRzEfEyn82rLSJiZKUTard4Bp+c3/yQxdvAEMnMOjsCchFbxw41UJMogIcZ05rQ=
X-Received: by 2002:a05:6102:54a4:b0:4b0:ccec:c9de with SMTP id
 ada2fe7eead31-4b3d0ecc1ecmr29653773137.24.1736977641130; Wed, 15 Jan 2025
 13:47:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115093135.3288234-1-kirill.shutemov@linux.intel.com>
 <20250115093135.3288234-6-kirill.shutemov@linux.intel.com> <Z4gqJqcO8wau0sgN@casper.infradead.org>
In-Reply-To: <Z4gqJqcO8wau0sgN@casper.infradead.org>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 15 Jan 2025 14:46:44 -0700
X-Gm-Features: AbW1kvYmgQZAQoh1evl_F-cwT96TWCJNKl3oZphib0Y46aUVpuxrrUuhtwKH4hA
Message-ID: <CAOUHufZ42ZV1SU+rGLM-2j2Hp43Q9eLY_yFYg8jsifOfcPHUgQ@mail.gmail.com>
Subject: Re: [PATCHv2 05/11] mm/truncate: Use folio_set_dropbehind() instead
 of deactivate_file_folio()
To: Matthew Wilcox <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Andi Shyti <andi.shyti@linux.intel.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Christian Brauner <brauner@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dan Carpenter <dan.carpenter@linaro.org>, 
	David Airlie <airlied@gmail.com>, David Hildenbrand <david@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Josef Bacik <josef@toxicpanda.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Nhat Pham <nphamcs@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Ran Xiaokai <ran.xiaokai@zte.com.cn>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>, 
	Steven Rostedt <rostedt@goodmis.org>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Vlastimil Babka <vbabka@suse.cz>, Yosry Ahmed <yosryahmed@google.com>, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 2:35=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Jan 15, 2025 at 11:31:29AM +0200, Kirill A. Shutemov wrote:
> > -static void lru_deactivate_file(struct lruvec *lruvec, struct folio *f=
olio)
> > -{
> > -     bool active =3D folio_test_active(folio) || lru_gen_enabled();
> > -     long nr_pages =3D folio_nr_pages(folio);
> > -
> > -     if (folio_test_unevictable(folio))
> > -             return;
> > -
> > -     /* Some processes are using the folio */
> > -     if (folio_mapped(folio))
> > -             return;
> > -
> > -     lruvec_del_folio(lruvec, folio);
> > -     folio_clear_active(folio);
> > -     folio_clear_referenced(folio);
> > -
> > -     if (folio_test_writeback(folio) || folio_test_dirty(folio)) {
> > -             /*
> > -              * Setting the reclaim flag could race with
> > -              * folio_end_writeback() and confuse readahead.  But the
> > -              * race window is _really_ small and  it's not a critical
> > -              * problem.
> > -              */
> > -             lruvec_add_folio(lruvec, folio);
> > -             folio_set_reclaim(folio);
> > -     } else {
> > -             /*
> > -              * The folio's writeback ended while it was in the batch.
> > -              * We move that folio to the tail of the inactive list.
> > -              */
> > -             lruvec_add_folio_tail(lruvec, folio);
> > -             __count_vm_events(PGROTATED, nr_pages);
> > -     }
> > -
> > -     if (active) {
> > -             __count_vm_events(PGDEACTIVATE, nr_pages);
> > -             __count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE,
> > -                                  nr_pages);
> > -     }
> > -}
>
> > +++ b/mm/truncate.c
> > @@ -486,7 +486,7 @@ unsigned long mapping_try_invalidate(struct address=
_space *mapping,
> >                        * of interest and try to speed up its reclaim.
> >                        */
> >                       if (!ret) {
> > -                             deactivate_file_folio(folio);
> > +                             folio_set_dropbehind(folio);
>
> brr.
>
> This is a fairly substantial change in semantics, and maybe it's fine.
>
> At a high level, we're trying to remove pages from an inode that aren't
> in use.  But we might find that some of them are in use (eg they're
> mapped or under writeback).  If they are mapped, we don't currently
> try to accelerate their reclaim, but now we're going to mark them
> as dropbehind.  I think that's wrong.
>
> If they're dirty or under writeback, then yes, mark them as dropbehind, b=
ut
> I think we need to be a little more surgical here.  Maybe preserve the
> unevictable check too.

Right -- deactivate_file_folio() does make sure the folio is not
unevictable or mapped. So probably something like below would the
change in semantics be close enough?

  if (!folio_test_unevictable(folio) && !folio_mapped(folio))
    folio_set_dropbehind(folio);
