Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFA620AF87
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Jan 2025 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736784684; cv=none; b=iswcQxpBPmjWcQEXCEWaAp9wobt6526yr9OCJSQXmV1G6fxFV5itsMMms5uRgrdCOqtjJSg/51kAgiuuHg4ZqGxWGp8wqb/ljDx/JxjU1zs45pYwAFAXnQ2Wnm1imXCxJI3OKXe1IxlTu9wsRQhYo5wNmgsN6diclHhZG6gDKyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736784684; c=relaxed/simple;
	bh=psxJGpeVFsbrFufxwmUIDo351AmSH3mNDvNXtHO2nq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abzYksavqShVzZ/27eWmqgSqCn0Hnjsj1Igz16I5tcOfSBd2xpAgkEggYIC9WZSwQocBKbGhjm/R90i3qKXEqHh8wTj4d/Xri0qUdbek9OneyWan6Kry3AkRr3fILVxwQLPJ9pcCsvRpwIVQv6YW3VxM5Bm9pGNQ45DakmriFpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XIXQHB73; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XIXQHB73"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6dd0d09215aso35864766d6.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Jan 2025 08:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736784682; x=1737389482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nln6xuSTTaoMOsjO/bzAdYR40fjFobKxVXqk79yIRg=;
        b=XIXQHB73/bEY5a04oXp0dZ2wYzZySyXsuDRQdnh10kK/CJIr0IPEzK2YiJ8mvOwVfT
         EwycpepZyRm3Askly8S6VpfQGsvf3y5EIqidaM5T5MggyC/S4rAaMm7+zCZm/a1rfFhm
         rHSqF3z3BEA7/hWcc8cMFAr37yMV3oF86wPF4M5Rs+1Tml+nhlkgvHhbxDGQV0EoS+uZ
         iybLcpugozsx1kZ8IsEl1ddrHTZxqVKq+rA2poIzC3lcxQo9uuBg9iRbg8JVqav2gHwj
         EyHNWzQfFyXbQtwP/dFABvHufqL8SEe0MDApGbC3UU8KvRs3dmZiRGrqEfnWNda7O/B6
         AA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736784682; x=1737389482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nln6xuSTTaoMOsjO/bzAdYR40fjFobKxVXqk79yIRg=;
        b=Qn6uvU7AB+MiHvOeQ1ZfHuTZPIlkPEcD0SaEpKuiQA7B5Tid9nRAojAFkaRQLcL9io
         rO6sGdgyragZrZJbOuo4am/Vou1vr7U51MRw6N3/yh3sLO2vg0jcaehuoyXAGjULU7+Z
         QMbX6S1+/xAQlIoBQ7pIStkNFS0dzQuDYJCsneRltVzSImCBpNdHXa1A+x0rg1m81Kwj
         AA1xB3+q+tCA1EqXdZUo2ERgx/4MHETFB83lZCJXikCVgkQTBfo0WOdwyf95z/VAFG9L
         cCjzWbplDuVro5I58d8VeG70g0xTL2jhWeEFz95mxE0xSrt3nmjThf9P8weQ7q3/4Zmm
         dCvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+85LIzkzG6bWL2jxkIjru9UY6zYRmRtePqeTFF48xSaUUCLbVThdzn5is0yj91nWalMvdPwlWnrOhAiEWaO2b7IA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZo7rWNi7alwRhOSylC+dClNZ0lEvuK8BVKxRsoEnxVy7ymz7Y
	xtkdPVIvGuqMAPZPKunNdzZOQ5XDt2zYc3oL9s3p7zuaapYLZyJIcxuRucrr+1/XwpejZHWV174
	Rbg/A4w6GkoIAGwHEoQKZQ/J7NCIPT0Fbx2S5
X-Gm-Gg: ASbGncsNgiwW+H11WmPm8gHXcZcuI6rWWoJEfuV4NL5VG68BrURMAhsZJIkHIQLRMs8
	jzxaOkL6BrAlCmdXObmyFMUDQ5CdL2dbcHKA=
X-Google-Smtp-Source: AGHT+IEZHimf0erqHl9P9hdsVm///MN8stQzn+Oj7UFKcLM1rFbaFHquGnXMlUQnxJqTuDGwgck+ox3NI5bhvjgf1ZE=
X-Received: by 2002:ad4:5ca5:0:b0:6d4:25c4:e77d with SMTP id
 6a1803df08f44-6df9b2ddad5mr358474696d6.34.1736784681463; Mon, 13 Jan 2025
 08:11:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113093453.1932083-1-kirill.shutemov@linux.intel.com> <20250113093453.1932083-4-kirill.shutemov@linux.intel.com>
In-Reply-To: <20250113093453.1932083-4-kirill.shutemov@linux.intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 13 Jan 2025 08:10:45 -0800
X-Gm-Features: AbW1kvYVFjw-APVc_AtsFocTeHs3A7WI3FQm934n3hdXUG8p6Ploc_paz3DXv-A
Message-ID: <CAJD7tkYfh=K1FV2NPFD5P0+Td66PtoMRHAkAcwUJcRwYDKLZjQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] mm/zswap: Use PG_dropbehind instead of PG_reclaim
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
> zswap_writeback_entry().
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  mm/zswap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 167ae641379f..c20bad0b0978 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1096,8 +1096,8 @@ static int zswap_writeback_entry(struct zswap_entry=
 *entry,
>         /* folio is up to date */
>         folio_mark_uptodate(folio);
>
> -       /* move it to the tail of the inactive list after end_writeback *=
/
> -       folio_set_reclaim(folio);
> +       /* free the folio after writeback */
> +       folio_set_dropbehind(folio);
>
>         /* start writeback */
>         __swap_writepage(folio, &wbc);
> --
> 2.45.2
>
