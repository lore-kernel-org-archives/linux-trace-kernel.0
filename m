Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4AF479873
	for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 12:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789214404; cv=pass; b=l/xYpJftHylxn+sybXVAkJkzZeANH1C8r9R5geXyHCsxS/LI9Cpfg4QnSneze/q3XQfo0RKSHGJhvjoHE3/sPo1mXxc1RvcB6+QLpmsDNjOBQUtVT5aZEHfKXY6p78wyby/SC1hhHEzXH3Zey6E4hgtPBZiK5QJRaCIZ1hjLQMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789214404; c=relaxed/simple;
	bh=DJLwU76RmwdfEAtO/ImX8T8e/PYYw87Y6xqvD9hhE58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KakX+hNfkwIeHIyA5IXWOhEaO2HFXIE9JKW312tqOtRLXxNG4EjfRF4NSMZ83h63kvbAuliuVjkUg69qVZSf9fxWzL88dFGfAvw1IpX2glhqOQHuWmPp25nDDdOE/l4c0fUXOL/Upk+wzXZakHUpE7nVY/JKvQA1/nz2taFauqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvjHQeUj; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvjHQeUj"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccbd478cso140185fac.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 05:00:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789214400; cv=none;
        d=google.com; s=arc-20260327;
        b=ppyQ0JR6tQCFeGqIq7eifSwadciczmHTgS5SllDlZ939/ufpvFfrLDZKulGUonx8Pc
         BeaIxQIV59eiiHIkSZKXNXUMtc0RHS4/KMLBsxR2XNzvm39lRsravj/eHYITn+9dNtwV
         FaMYahDcCqh06Ky8M3Va2lcnp44vc6FOA13wpwXe1viK/GA36lNwc3RNxaw3e0rvoAS0
         lqOWu2fTViKxOQc/OCCsogQGa7+8c7gZLjBVTgPK3KHfv4cPRDZWhCQovk4zO9IBhX02
         l31DVLH511dveYgUCf9HvqzJ+IASutExIJCginYGbmfEAeu66YlfIN7z1dx/4T3tEdn1
         VQhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YghKBDGzorABwgLsb3vWz9Ic4mK6I5Sn46J6CQloWEY=;
        fh=bzS4lM/aJPXUVVzM7ZXP2ar0QUo2xn/bvWtI5toWN9Y=;
        b=iohMdn0OCf61jZgAJeB/oRet+WFvV++NxBJ2uSFUwbWTzxuYXCTvi14dyB12I5SK6d
         4WGeE+OsDs2kSdiVmok2d1UKpai1oMrKCWdX1hPemT2RXOJv+nx7qK/VCCDMkycF2Thj
         0SQ0nPcI0BxSjPfNvOmY4mQpk/8P+oh/jUtCgIKQVMtmbvGN/c19yknAvAv8ffDF84o4
         63QwtlK8yW5bJbAupk2ZuycVcPlecJ78d/0U1tBVMrn0TnxLPmePczxLXhsf9yb0VNo/
         H3+CQQK/TkHG8eQ9uDqup5/pPljOORJCvnKv7xYzIhVoJEo8zrWNZCJPwDBnbIvvxaj4
         5hFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789214400; x=1789819200; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YghKBDGzorABwgLsb3vWz9Ic4mK6I5Sn46J6CQloWEY=;
        b=PvjHQeUjqg/X8fZxWXc8hwG4EHEybIot2VJtMbU0D9ybFtp6XNPMtZ+KK0+7GP0ek9
         031iBZNfLOof/L8MA66TpDdG2TDkGn4dqEXPDYBrDcNpUAZOxJZngpzcYl3UGJET6lJx
         kbAuvB3jFoLpURQa3Y3vij8DkcZHhmzeBy1KqkKrh9H1RNU6IGVf048cXVjrwI+WxCTE
         KHEc1rCOlbP+xgLfFSzHoGAs/sw56XkymvfwH2XqT4JcuzCjc0Ht9IhTcAu4REZ1I8t7
         a60oG1HNXj1xBuR/UR27VKMaqyxGg9MYvzS0xb6eYzmsZCwbYAI9GiFdx8I6wMnnAB/p
         Ggpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789214400; x=1789819200;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YghKBDGzorABwgLsb3vWz9Ic4mK6I5Sn46J6CQloWEY=;
        b=St8WbhP+pY234rG8AqiZRpUbFkhjgWNEd8zZWrvaXb+opVzy47p2xcfSivtegTgS4b
         BWBK9Y1bEtNjAt4TjiH97wuUbcR6MOqrDMOOv8KqDx48DuDeIGiHegS6SjahBzS76TXV
         1R/htgCK/Bn/2/hacX860SegwI/HpCqYthl1j5qmLAS8Wv3xJEiEmgPNDEY92h5Znk8w
         Bpg5bEtRj0t3BwDZSTinBtqc0OqzBQArth85s1xj/K9jnByGUZ5F85gLEsTXLA7IBo4U
         /5yc5e8a5lUhdfg6hn1zC9LLLLZ9B0Hz23fiz7Jx9qTAiImQB248a269858vJsNltVmM
         kh/A==
X-Gm-Message-State: AFuF++kA+0JBgsRbcepdELWqn/dFq7v9eiNieJJ7skwFy9cnlyfuP/FV
	jUmGDvM1595nHICbdAsAmRI/ECJwpSECccb56v5+04yB0XbmGprT6qo8vRjSudzlYEabDk89UxS
	M4iD2WY5CViNpt1wl0lwby+fv6FuOWBhttGWG
X-Gm-Gg: AYBFou3WdAgEur17SVinj3zFMQG6A4qZbUn5IXFP3WR4rF4KaJeBfNIXQvlxKV9wrhL
	INJmLvGoUCrWd8guJwVNFrcJwvKsSd897B1yuyn4xCkjDEEbROwY4lhv2RDoEzpfM/DhmQO4xfD
	QfopM5hV6FRiRJkxht2MqyiKO1iVq3/BNVhG7yKYVDB7n8cBNaBVrGYUtvrFDyWcdSwboeEhROM
	K7KtqMY5t3yWokZyE/CPWynyJS3kxbQeOvAn5hTdrCenuvpJmvXK4MlYdKWgyoWuepUJEjRUZ3S
	CuG+DL7Wfc5tN8bWb5pNnQCHFrDPtoyzTnxvUD2Uv8ZLWP9RqeMHXLb8R8j8yIGedzc2kxvQcj7
	4+70c5ZaZAw==
X-Received: by 2002:a05:6870:b9c9:b0:47d:7ee6:98da with SMTP id
 586e51a60fabf-47f5819c69bmr1345392fac.8.1789214400282; Sat, 12 Sep 2026
 05:00:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912103938.1127021-1-devnexen@gmail.com> <20260912105659.6FC5B1F00893@smtp.kernel.org>
In-Reply-To: <20260912105659.6FC5B1F00893@smtp.kernel.org>
From: David CARLIER <devnexen@gmail.com>
Date: Sat, 12 Sep 2026 12:59:48 +0100
X-Gm-Features: AcwNN1VSn-ZCNd8bo4C1at1sh1g1MVQJlFUnzvIaT3Wa0TcW_A3cdLgKbNn_Ju0
Message-ID: <CA+XhMqxdBB3_W2hdkoMkrM8aoSdhFBko4ky1h4ke0C41CgYTAA@mail.gmail.com>
Subject: Re: [PATCH] ring-buffer: Check resize_disabled before publishing the
 new subbuf order
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The first point does not hold. trace_rb_cpu_prepare() allocates
buffer->buffers[cpu] and IPIs via rb_cpu_sync() before setting the cpumask
bit, so observing the bit implies observing the pointer.

owever, The second is real but predates this patch:
ring_buffer_subbuf_order_set()
never took cpus_read_lock(), we can fix as follow :

--- a/kernel/trace/ring_buffer.c
(/home/dcarlier/Contribs/linux-trace/kernel/trace/ring_buffer.c)
+++ b/kernel/trace/ring_buffer.c
@@ -7465,6 +7465,12 @@ int ring_buffer_subbuf_order_set(struct
trace_buffer *buffer, int order)
      if (psize > RB_WRITE_MASK + 1)
              return -EINVAL;

+     /*
+      * Keep CPUs from coming online while changing the order to
+      * synchronize with new per CPU buffers being created.
+      */
+     guard(cpus_read_lock)();
+
      /* prevent another thread from changing buffer sizes */
      guard(mutex)(&buffer->mutex);

Cheers.

On Sat, 12 Sept 2026 at 11:56, <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Missing cpus_read_lock() allows concurrent CPU hotplug events to=
 crash ring_buffer_subbuf_order_set() via uninitialized list dereference or=
 NULL pointer dereference.
> --
>
> commit d554518f86e022de0069fc76033b9d71e9046148
> Author: David Carlier <devnexen@gmail.com>
>
> ring-buffer: Check resize_disabled before publishing the new subbuf order
>
> This commit checks if resizing is disabled on any CPU before applying
> the new sub-buffer order. This aims to prevent a race condition with
> mmap fast paths mapping already-mapped CPUs with the new order.
>
> Cc: stable@vger.kernel.org
>
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 9c03a555a6ba2..d7e5e4620d096 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -7474,6 +7474,14 @@ int ring_buffer_subbuf_order_set(struct trace_bu=
ffer *buffer, int order)
> >
> >       old_capacity =3D rb_subbuf_capacity(buffer);
> >
> > +     /* The mmap fast path reads subbuf_order without buffer->mutex. *=
/
> > +     for_each_buffer_cpu(buffer, cpu) {
> > +             if (!cpumask_test_cpu(cpu, buffer->cpumask))
> > +                     continue;
> > +             if (atomic_read(&buffer->buffers[cpu]->resize_disabled))
> > +                     return -EBUSY;
> > +     }
> > +
>
> [Severity: High]
> Can this new loop race with concurrent CPU hotplug events and trigger a N=
ULL
> pointer dereference?
>
> Unlike ring_buffer_resize(), ring_buffer_subbuf_order_set() doesn't appea=
r
> to take cpus_read_lock(). Meanwhile, trace_rb_cpu_prepare() can update
> buffer->cpumask without holding buffer->mutex.
>
> On weakly ordered architectures, could the lack of an smp_rmb() here caus=
e
> the reader to observe a newly added CPU in buffer->cpumask but load a NUL=
L
> buffer->buffers[cpu]?
>
> Additionally, without cpus_read_lock(), if a CPU is added to the cpumask
> between the allocation loop and the final page update loop later in this
> function, new_pages will be an empty list head:
>
> ring_buffer_subbuf_order_set() {
>     ...
>     /* One page was allocated for the reader page */
>     cpu_buffer->reader_page =3D list_entry(cpu_buffer->new_pages.next,
>                                          struct buffer_page, list);
>     list_del_init(&cpu_buffer->reader_page->list);
>     ...
> }
>
> Could this calculate a fake pointer overlapping the cpu_buffer struct and
> corrupt memory when modified?
>
> >       atomic_inc(&buffer->record_disabled);
> >
> >       /* Make sure all commits have finished */
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912103938.11=
27021-1-devnexen@gmail.com?part=3D1
