Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFBE23ED60
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794676; cv=none; b=k29t5OKHDG3uMkaT5vEOt4id5lt6YL2QEX4pojOlN/2c3OApAMJXDpgyJObJnV+PAXSRqI9tgd0R+LG2GNhdrslQqP09zIZ4Cztupgy4tKp3/WEzEi7SnzET3eQvxP9rFNDaR46qW1Tn8guSqhPLHnOgmsnMUt+M4x0Zf4qCPJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794676; c=relaxed/simple;
	bh=wdNCJTzoJSuLjTqXfTxcG2O0gkSp4rOOYD8MKqoeeaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=POOqiwfX6li3hdwpRmYuZ5llkh6vJwhfsflzg+tf9lh2okmks0z7h7s3VE2GiYphFFGG1vSxRg9EAdfWJMtgIrSwkkbem+GxcDqcBBZ/DoDmMtkDGEl3SaAlLjrc/EebwfM4mtdwdqeindER9gM0iKaUmbNY8wPu6SCCUAUAREY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JKuCFdJ0; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JKuCFdJ0"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff69365e1dso47943a91.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Mar 2025 08:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741794673; x=1742399473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4waYuPFx6L6goSYkoo7WhTZHz9gZ3Nxcbawn3orXnWI=;
        b=JKuCFdJ0bnW3vlkDJUJQeIBNNXct8eOxX8LvSkUzYW3k/HSS/CgCrcAnwQvowAzkk3
         RjIUDvVe6b32sGVKNd7pUp4Rrgj755Ob3dfw6ZZHYMO/XFCptLNE5RG5p/g3ArAmN4uh
         Epw/nFV0RxMrAD4pevLTkB5Hw6UvMESuAiDAkBffcdUl6t9j82+ycsgwztPPW+uQ1Kxi
         PbAd6PzNzPf2lGh2SiEThOH5ZMquMBVPYJdRNcRiESDAW4TWrjNYVLT6eQdcD4EybWhO
         b6VZJEdSIJQfvs16BkWFwQgGH2XxvvbdIy5lJinUhUQFrRYArm/OF7vRC2p/pvSVYznC
         Lhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741794673; x=1742399473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4waYuPFx6L6goSYkoo7WhTZHz9gZ3Nxcbawn3orXnWI=;
        b=vDSfjlG7/MsAaBcvtQQSlUF35sJUfkSqBrXfuKDaYKjL3BGnRWkBMyQPNVpJ4eNBgY
         1vD/tA/rZDy3QEGrIet1dlj5Zhc4tx3fNxxsyt/RKIhEqmSZZg7GKk1r6KuvVw0YWPXS
         un7Er8is9O5hKiDsY0nyaLBScg56Bpb2ZAqrsj6rWuxUVWXHVODMkVKkDUeCqSIBnDqv
         STbSxivoHN1m08Z1iQ4Rit8kfRNzUvb3o6he8ZTCbQcvl8NRZxGoGkDhAhGrqwxuZXvU
         NKxzkVSLtt7AfX9VKCV+SB+4oD1hUgT4STC5IvYLlWvO/lB+pPSK0aPYXMr/ULG5fecS
         x33w==
X-Forwarded-Encrypted: i=1; AJvYcCVfNChVl8d96RqB8Oaur60412VsVRSIaNf6b5/wgAMZ/7RRuYi8X+LCnex2pAlCJOsNyiCgXERaF67gvzT/VT6CwPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrLlpeJYqP+xBWmL8UK9/dHXZ+V3OpspuO0HZQrsvGF9E58PxZ
	8utkEyNG4nBDgRV/M8RBYYfz9hhQI8QtR5hggl/Y5ztnI18Ffhb4GzSgMw6DXp9mIm0GIczNcMG
	3xcwpgnyZBinUd8eihY5XH5S7T6LzJALOzxhf
X-Gm-Gg: ASbGnctWYz2X/B/PcAor3/iYjaqheHevGT1SfXk+CygNqtfJ6iP/8g7CeP+SX6E3nm/
	tFNOnpadNgXYLc+KmaZtz1W+6NVVZon3gTcuIT7asu1zTbekhMmG3ewaaHrAhb5auG/Fh1rF0Oq
	Zz5s9uEYeukRlftiat6Huslj7KAZJZas9B3rpfpoNbsDwzb4MtNP1EvR2e81ou//8xJofvQw==
X-Google-Smtp-Source: AGHT+IGxEBodeV+/yMZZaDdgVXjLm0ljYHatWRv38P75PhL5DIaId/G9DlTGJaKiO/EJxaRirPI129so8i6lFmu+wqo=
X-Received: by 2002:a17:90b:2fc7:b0:2fe:ac91:4667 with SMTP id
 98e67ed59e1d1-2ff7cf1d266mr31811537a91.29.1741794672597; Wed, 12 Mar 2025
 08:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308034606.2036033-1-liumartin@google.com>
In-Reply-To: <20250308034606.2036033-1-liumartin@google.com>
From: Martin Liu <liumartin@google.com>
Date: Wed, 12 Mar 2025 23:50:34 +0800
X-Gm-Features: AQ5f1JoGKRqr_zxgpVnFUvr04vIAdj97OFW6F_Uv6QoZM1DoRozKvQsjmIZTEG0
Message-ID: <CAASV4h4_xgJPZOvh8k5snJc_ocvwPih+SvK9D8+_Fid2chcz6Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add tracepoints for lowmem reserves, watermarks
 and totalreserve_pages
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, minchan@kernel.org, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

I hope you've had a chance to review this patchset. I was wondering if you
had any concerns about merging it, or if there's anything I need to address=
.

Thanks,
Martin

On Sat, Mar 8, 2025 at 11:46=E2=80=AFAM Martin Liu <liumartin@google.com> w=
rote:
>
> This patchset introduces tracepoints to track changes in the lowmem
> reserves, watermarks and totalreserve_pages. This helps to track
> the exact timing of such changes and understand their relation to
> reclaim activities.
>
> The tracepoints added are:
>
> mm_setup_per_zone_lowmem_reserve
> mm_setup_per_zone_wmarks
> mm_calculate_totalreserve_pagesi
>
> Changes in V2:
>   Fix coding format error. Feedback from kaleshsingh@google.com.
>
> Martin Liu (3):
>   mm/page_alloc: Add trace event for per-zone watermark setup
>   mm/page_alloc: Add trace event for per-zone lowmem reserve setup
>   mm/page_alloc: Add trace event for totalreserve_pages calculation
>
>  include/trace/events/kmem.h | 78 +++++++++++++++++++++++++++++++++++++
>  mm/page_alloc.c             |  4 ++
>  2 files changed, 82 insertions(+)
>
> --
> 2.49.0.rc0.332.g42c0ae87b1-goog
>
