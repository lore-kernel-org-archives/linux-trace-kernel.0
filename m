Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2577B1D555
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Feb 2026 05:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771564665; cv=pass; b=qRvttcBn+ZpA3BFtGmheX0hI06a+3f915gwV2y4UVu4Iu6ho2Oz1hnOmqcvnH2F7wOGaeew7sMrsn4sTQIUiqhSPy8t67vv2WQQSTwe8pxFyNCDyXsTTM3cntbw6gA/nuaHlbnsbuf1/i2pvWjQ4sYLFtY6znjUSHbJDGCkw2ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771564665; c=relaxed/simple;
	bh=nqYqK7qYSwiChKPT6YGNR1sWhns+iWH1ykmmdD+MTNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LkrjSmlNcEZ0OKhPNX+4r6PB7YD1O9Z5+EYLpYEkb7BifRFlyQjgRx0sr8Wo9+CQ7puUDZqnNYn0mhtLrJV0JnrXmH+jZZG9NR9j+ckHNmgUST6NJOsqvlWJ12q5BvmngTH5a/OdvoIukFMCodGeZ5oCQ14Eo2cbf06G8cyIgzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WT2ASGCa; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WT2ASGCa"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a76b39587aso55905ad.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 21:17:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771564663; cv=none;
        d=google.com; s=arc-20240605;
        b=djmb3sbYIQaSDW+zl+8V8TCUf00k8joC7/nuc5oCVsm50//tEMoi65++GK8MuEUiKI
         Vrh2QXSYINBDVt+dNxDMfJcpxESu0OoCtblNfk/K9G8N9svFTDDLDsQmPUxSy2pjSuoi
         ezalWlq9jNtiP1JXvkwUhm5kQpq2oLYoEAzeks37GETDd75K4L481Hi5J3w6I60UyYSh
         m4mym55jxFXSQGYw/Jip0rp32mbduXgEfSQe3PgOiYJup5UYxWE4CobMzpUkPfTghQQj
         8ZnI0npYLECpA26jh3UvzAI2bodhE2TZ1rbh2k3YVaZkYrcmV5LsICdicB6HKrXdvpgP
         ZsQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rI1NbYa8e4vBJeF0qLPEWLyiL/LU82orZ37dDXTTjz0=;
        fh=dUprtuBLeJllSZSa1zYlPCiwypePeeDzvXnCJGdTf5Q=;
        b=A68z2xb0TSY8RsYb5/1fvcjah1YUl7owhssJd/XPNh2Y6UF4R5Ih4yMghWzYQb4I/w
         id5HDxIxNroeTkg2t+8FmWAk6nsSRIblJqX5jT1v5jb9oE7MNwDZU6CfLGdBZvP0Q6Qz
         7EC58/yv7GhFP6hxKzPr94bO/2xDZq3iHLtxsF1o4rt3HBQo9GfktO/Dwg+zE6atZ4kB
         S9Vr3HyBn9oTG0IxBV/V0h5QxcPJHuHvgPDAYzMygNS5CKJDkKYqbHgc0JClLXKlLR7j
         yfLOStXFhXsI6fwWzrhrUt/r7enosUQhBj59MzzEQ52mGVzbmieZo4Ik7n7XmePWupcz
         5wPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771564663; x=1772169463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rI1NbYa8e4vBJeF0qLPEWLyiL/LU82orZ37dDXTTjz0=;
        b=WT2ASGCais2o1cG0qjFJKpG6hiabiXDyOgSc5J71i/DZn2vD4RrQmNHHokvRDGWGgT
         4VQDNy2zkZybqDy5SIJ3+Yv/Np1bPwD25eHRCyWbQ3XxGfIcaj/cyL0DcIK3GQVVlasA
         qHxpugmTG5C4FtNCKjyMX3exqbZFDic0SFmrTGFXvdVOsgwf0PgawIKSb3Bn9Ok8Fx7N
         2CFEvwZO1A0FoJVWxtW9tJ6CMHwGyZSeG1V1fXtkjarmqnbcz7By0u944Sb0q1KlK+FZ
         ZPEQet0JFwhCQGS2wZgOjFPJ60avb3/ySAK7l8p1djhaaKxGQB6TiQU9Stls5ACqvYw/
         gsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771564663; x=1772169463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rI1NbYa8e4vBJeF0qLPEWLyiL/LU82orZ37dDXTTjz0=;
        b=T+2tSP54kj3A5Q5YAiskTI4eMzrNI/4mwM7AArQvF7zBjIS3WZs6Ny+dqpvorCeFPW
         VbpI5KzrwQyJBSfnpL81btuvCairt3fiaJ62SpKMI1G3EKY92Uf63r1ayytsLy4xxXBP
         LGGG2mwUWm/WYlUYSh4uB7eUNFiUHCdQVhD/ODktcPn+PrUmMYDGqKr+EF1AT5HxkEJm
         xn5RcWdOG6ud2hCOjKsdmfP4KQSg18fmJ+b4chb2WuAo2Ai2JxYb1nlmSjNr3Olxmdo2
         f2uNitHEcgJg0By8moHBcWIZ90xqk3XZG6AAAZAaioCcF2rUylRnOSKRvpw4xImMf0bz
         Ye2A==
X-Forwarded-Encrypted: i=1; AJvYcCUGfWtTyYFnfI/4IuV7naZ5BGafGj5JXCbgJowwrNUxiTpg/0dGqKWfK2QntVBMQLXj3lhyhmuP+v0hrhXYt3gLsgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxULzhxTxIvRcvzeWXVlBY5UICzHYdgCqUhCyv74LIUacxxavSu
	fYd0E4xo9cV7F48xEUbAzGy/dZ5Zkqh7Qz+PqYP8Mix0qOSfI60RcTCu9FD5oCGvIkE1EL7Df6i
	xF7FhGOncJO2cqIlE6kyCLta0o6/dH0s3+1maHyBw
X-Gm-Gg: AZuq6aKuujHO36Su118NvhGQxPRZk/Yx/HvPTC9ZNYk8LtHkTvXNf+k8VOfJY0NkXBN
	r1RrYtjtneyWoImoQYAGK0NjVCXNmiBzvE5xB5pm26FQg6OkyzouggVEBZFTio3Rdxz905HY8Hk
	g9Bp6DTAitUhzxy4cHygP+3/3AKOMympNN1Yzojso+bBKbCZn1p+arT6gEuZsA77srlKMyIUeOU
	cdczaKQvpqPlwv1sV0hy+JkE3+IbJcm/CONER9PPitrbofresUItK8R4FzbpTxo7xYNX7+ns/H4
	ak2xJoK9ZOd6qNV/u0GIL/LIfQ+mpR/r4V57Rctm
X-Received: by 2002:a17:902:d584:b0:294:d42c:ca0f with SMTP id
 d9443c01a7336-2ad69e114ddmr1414495ad.2.1771564662949; Thu, 19 Feb 2026
 21:17:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219233708.1971199-1-kaleshsingh@google.com> <20260220011700.127763-1-sj@kernel.org>
In-Reply-To: <20260220011700.127763-1-sj@kernel.org>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Thu, 19 Feb 2026 21:17:31 -0800
X-Gm-Features: AaiRm52THFMQu8DD4__rg--y4qYBq0Xcvfy_Nb5EOcRcZKNj46I4M1T8ZW27eX0
Message-ID: <CAC_TJvcdwaUspCXze4grzWeX8Kt_CQd0KmXwKG20Ex52n0hoaQ@mail.gmail.com>
Subject: Re: [PATCH] mm/tracing: rss_stat: Ensure curr is false from kthread context
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, rostedt@goodmis.org, joel@joelfernandes.org, 
	kernel-team@android.com, android-mm@google.com, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Minchan Kim <minchan@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Martin Liu <liumartin@google.com>, 
	David Rientjes <rientjes@google.com>, Zi Yan <ziy@nvidia.com>, 
	Wander Lairson Costa <wander@redhat.com>, Petr Mladek <pmladek@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 5:17=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Thu, 19 Feb 2026 15:36:56 -0800 Kalesh Singh <kaleshsingh@google.com> =
wrote:
>
> > The rss_stat trace event allows userspace tools, like Perfetto [1],
> > to inspect per-process RSS metric changes over time.
> >
> > The curr field was introduced to rss_stat in commit e4dcad204d3a
> > ("rss_stat: add support to detect RSS updates of external mm").
> > It's intent is to  indicate whether the RSS update is for the
> > mm_struct of the current execution context; and is set to false
> > when operating on a remote mm_struct (e.g., via kswapd or a
> > direct reclaimer).
> >
> > However, an issue arises when a kernel thread temporarily adopts
> > a user process's mm_struct. Kernel threads do not have their own
> > mm_struct and normally have current->mm set to NULL. To operate
> > on user memory, they can "borrow" a memory context using
> > kthread_use_mm(), which sets current->mm to the user process's mm.
> >
> > This can be observed, for example, in the USB Function Filesystem
> > (FFS) driver. The ffs_user_copy_worker() handles AIO completions
> > and uses kthread_use_mm() to copy data to a user-space buffer.
> > If a page fault occurs during this copy, the fault handler executes
> > in the kthread's context.
> >
> > At this point, current is the kthread, but current->mm points to the
> > user process's mm. Since the rss_stat event (from the page fault)
> > is for that same mm, the condition current->mm =3D=3D mm becomes true,
> > causing curr to be incorrectly set to true when the trace event is
> > emitted.
> >
> > This is misleading because it suggests the mm belongs to the kthread,
> > confusing userspace tools that track per-process RSS changes and
> > corrupting their mm_id-to-process association.
> >
> > Fix this by ensuring curr is always false when the trace event is
> > emitted from a kthread context by checking for the PF_KTHREAD flag.
> >
> > [1] https://perfetto.dev/
> >
> > Fixes: e4dcad204d3a ("rss_stat: add support to detect RSS updates of ex=
ternal mm")
>
> Sounds like the issue is not that critical, but user-visible?  Would it b=
e
> better to Cc stable@ ?

Thanks for the reviews, SJ and Zi.

I didn't add stable initially because it isn't functionally critical.
However, it would be nice to get it backported, as without it,
observability is much more difficult.

I believe the patch should apply cleanly to stable with minimal risk.
Andrew, if it isn't too much trouble, would you mind folding the
following tag into the staged patch?

Cc: stable@vger.kernel.org # 5.10+

Thanks,
Kalesh

>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: "David Hildenbrand (Arm)" <david@kernel.org>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
>
> Acked-by: SeongJae Park <sj@kernel.org>
>
>
> Thanks,
> SJ
>
> [...]
