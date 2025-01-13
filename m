Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEFB26AC3
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Jan 2025 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736785080; cv=none; b=uwG0bdv2kYraEeRkmgpchZtCw9t30+R5hWJC0hTn3JAOFyGAtASWNmzs7Lwd2lyjqJt5c97OIBff1nLfET3S0qcjGkhkoWrg7PjtfvglliYLXD6DHJz8BSEaP8NBeD8UVz7hGid13VZx6ZjNlc+cpsXsGxtnSgmWCegfgZdjRwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736785080; c=relaxed/simple;
	bh=i2OnbU868jbLpAGxnv33ZbXsXzgl95GrwT6kamytYyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DKv+QytKqEgsV3/iIS03MI/oVpwOTWlDvTtyLgEq8lgL77o50LuNqpvaW51xX7pG+VDHE1eYRDxNSZWpjJM97/KfII+Wg/fsYpheBpSjNpy8/0FH7jfX/wIuDlteFGQ/DHSDJIdOmm65lmFuE1Idq7lFF0Kd4oGWG9XLYEd3B+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A5bU8zcc; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A5bU8zcc"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6dce7263beaso40563766d6.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Jan 2025 08:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736785077; x=1737389877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfzu8LVinRmTffQRsvj5JwYAQma905XvC7kwPgp95yk=;
        b=A5bU8zccZdIrbPB/gL9qVoRCUJuVKehRJp7YbzaMmcqt0/JQxjrUGjmUwk2Fx96+b3
         pae0RnZHmuubM64TjLK50sPeuS/15cmwCU4PFt6bkripzdi1JEhZW3iyl/AbkK1uv4G6
         fCFSQwKRGT20V4zBOVbc9NJ6BkuVR3BvQKM1YD6EFd3ApoopyrTZpizI6Eh9Oqn+tkJt
         jXUzujH4Eyhd6EYB5WvU/pPuPOwpgdJ8aCvs0AV35Y584V0cfeytjDHFJGY6xzR+MTfT
         sCV1BdcntTBAEHM+4kAnbe1jxajE+dcX670fBJmbelbndz4V0d8E7aO6r37yT4XQ00JM
         rYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736785077; x=1737389877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfzu8LVinRmTffQRsvj5JwYAQma905XvC7kwPgp95yk=;
        b=e9PrmLU6sTpqmwMmMHxtR1XjRTF3ajYIgRM+hvyEXVAdH1oxSC6oQpTNVOzfY1qNKj
         8Kydo/bkDU0Si6d0Wf9GCrOiNec7bmEqW/dmDieJkY36IwrG/PQYc+vf6W9Rv73M7hYT
         1pHQLKri9s5dHz7m3tICaMXFmAivvhCHiec0yzg0D2yifW1+7PtG9Lo0YDmLyRZpmFHt
         EuYiM2BAKBEIjpESR5nqqasCvlvbBPzetLVmpW0GWVBK7wsQ5DgOgW/iUHjocWaHQPrW
         uzDqpRyqC8WJRRvB+ccIrBD1CvQbXhsSJndWjr00KDrXm5H9mujJIohdQGz3PzdV8VUU
         qJHw==
X-Forwarded-Encrypted: i=1; AJvYcCXUjDTiE3hpJFxSrsrF1o6mpsirrh9L9aHiPCtbTcWBMCWb6dne9acZ09pSpjMMcLjRDi2Hl9knKuyhFRBAxN+4edw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQIWW/cRAKp5Okm1c+76rVUA6fOpdKWooFpEdZ8trUaKgL9gEd
	wGJIeuJxXBEz9D/p5tVT9dbawEoPYxU/l9/QukWsP4KFrbCcP+YOnGwGOaq8wGvi9icGeN2/Kem
	H149LHWsT5b35wsNfF1A3M/H6x3cUASvW8Ii5
X-Gm-Gg: ASbGncuThXM7BP2RjkogUPemeZxYJP6O9F13pQVi0+xyv7jv9kREIOD4J11Cu7jQgh8
	XGoqIIg7iKF1CsJoJdalD7IzC5k+qaAmNB4M=
X-Google-Smtp-Source: AGHT+IFDY+ySlB1nZMJq9PlTNDL8qUtu0AiaG+WzwFjnrE/ylu2IG3nFGi1mN1AYrMM9NBOj0s/u+5iNgQWpIVWK82E=
X-Received: by 2002:a05:6214:20ce:b0:6d8:812e:1fd0 with SMTP id
 6a1803df08f44-6df9b1da95amr320133376d6.15.1736785077170; Mon, 13 Jan 2025
 08:17:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113093453.1932083-1-kirill.shutemov@linux.intel.com> <20250113093453.1932083-5-kirill.shutemov@linux.intel.com>
In-Reply-To: <20250113093453.1932083-5-kirill.shutemov@linux.intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 13 Jan 2025 08:17:20 -0800
X-Gm-Features: AbW1kvZz7xe4mjGEEdN13LDK63_d9mSHRFPhCcbgv5eQRi5YXclVXjASqcr-k6E
Message-ID: <CAJD7tkYH8KO8NLJY564PRAmW-mtMfDCMTECGKyYyVAf+JtTcRA@mail.gmail.com>
Subject: Re: [PATCH 4/8] mm/swap: Use PG_dropbehind instead of PG_reclaim
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
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
	Vlastimil Babka <vbabka@suse.cz>, Yu Zhao <yuzhao@google.com>, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 1:35=E2=80=AFAM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> The recently introduced PG_dropbehind allows for freeing folios
> immediately after writeback. Unlike PG_reclaim, it does not need vmscan
> to be involved to get the folio freed.
>
> Instead of using folio_set_reclaim(), use folio_set_dropbehind() in
> lru_deactivate_file().
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  mm/swap.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/mm/swap.c b/mm/swap.c
> index fc8281ef4241..4eb33b4804a8 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -562,14 +562,8 @@ static void lru_deactivate_file(struct lruvec *lruve=
c, struct folio *folio)
>         folio_clear_referenced(folio);
>
>         if (folio_test_writeback(folio) || folio_test_dirty(folio)) {
> -               /*
> -                * Setting the reclaim flag could race with
> -                * folio_end_writeback() and confuse readahead.  But the
> -                * race window is _really_ small and  it's not a critical
> -                * problem.
> -                */
>                 lruvec_add_folio(lruvec, folio);
> -               folio_set_reclaim(folio);
> +               folio_set_dropbehind(folio);
>         } else {
>                 /*
>                  * The folio's writeback ended while it was in the batch.

Now there's a difference in behavior here depending on whether or not
the folio is under writeback (or will be written back soon). If it is,
we set PG_dropbehind to get it freed right after, but if writeback has
already ended we put it on the tail of the LRU to be freed later.

It's a bit counterintuitive to me that folios with pending writeback
get freed faster than folios that completed their writeback already.
Am I missing something?
