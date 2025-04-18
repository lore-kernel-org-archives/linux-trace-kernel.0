Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC0E217734
	for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Apr 2025 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744996728; cv=none; b=KqWpH1mnvK8ZAE4cCzedNAbjaO5zOvecODCmho2ASdJRxG5mn85ofkqH60//z9X0k+vpyR5weJoq8Ua+Z+mlqxjqqXRDMkHNcoGt77Bg3spjCAqp/GvJfqzsAP2kHEMlVTjn3ai2c9Xw/t9lnO5ZieBy+eqAv8oBeB7yqEPSfAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744996728; c=relaxed/simple;
	bh=+a1M5i9PKv67XR80Jx0OMOovmU/sGspbAiljC2qwxuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0n+xHpW1/zajCjtzYvqksjTYIYG8D/rY0p0f5qNqUDiM1r2V497gte+9YvZvY5gwczv+CNUZB8DjP4NRdaidvOZeD0ZV2MMCvILchedJ5u2qancTNNBpXh9C6JCFLZOzJMTvnefGkt07NK2XLcGTVGUJZzTvsSXDWG92pdbp5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EnT3Niis; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EnT3Niis"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744996725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gkdw8gsBY7I9in1XRxPqFzuV9M+R9WrhUEzgOn2phl0=;
	b=EnT3Niis9W0xH/rf+w7QkxHie+SPx28muraQzn9JZQtJop7AqTE9c7XZQxrRQ3iKaWmhAN
	415T1p2HlgmMvvnMwNWYicL77XpD1JyQHgYVb+zNk1Xci5bhCgryI8xcA9umVb9WEgjv+C
	gCFwzRfryVmVy6mRan/XO8VfneL/X4I=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-etAWFxTFNLq2ofwsy9LX8Q-1; Fri, 18 Apr 2025 13:18:43 -0400
X-MC-Unique: etAWFxTFNLq2ofwsy9LX8Q-1
X-Mimecast-MFC-AGG-ID: etAWFxTFNLq2ofwsy9LX8Q_1744996723
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e6dfe7c8d4cso2931167276.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Apr 2025 10:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744996723; x=1745601523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkdw8gsBY7I9in1XRxPqFzuV9M+R9WrhUEzgOn2phl0=;
        b=eurF9mPnnJnNCHewaLMtKpPECvN798zWWqVevAxCCqdlmK7WmRSlXHYt6z9she/B3S
         oLExM6Cw5cO23Batd4M5/xdzJ5uya7at9pdAvw6qvDMyEarSKzlrEoHYS1CGj7WhgIyc
         SLL8A4cDQi9eex1CKzs7wwAx07szQIU3MicHD4xSZqQdwSRidEB9QnS2RlcwxJXAHNAv
         /Xf+rSiwPZeBpURbZ8fxUHgfctcs+5ggKJN8+KPrS3KFHaIx17weWvMohZm6x6Ee4jmd
         JatWPVEpudk+u+18hsUWTcE1YnJCRScWpU2F2PRS/f2Tbk8rOHrVuX0w7s0tCj/cQiNI
         E0AA==
X-Forwarded-Encrypted: i=1; AJvYcCWCC78ni92ORz6BhBZalGKeXXVCmochLlv0rHQWiC167Qa1tTfap6XjZMRcNcVh8alN626vEUDyI8rgchf/0X9RCZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU3vvSt0WMkB9FwCkP6CoUj80GRX4j6mhfLALljb0R3flMe5FE
	4x3BBcj8o5+6NhnzKv/iA+ou02wemM9eWL+9FZd/99aAXKZXni2xXTb7IiJv4xGcOIjULoeHo2H
	a6pe5f3ELI3ZFwuoOlpgTw+uBuRMbpAJH1HaV98FvnVaK9+I1CX15blG3AQc4I4Y4Ji5AduLdpQ
	wC+qgc6PhfeS/NOizdStz3epGP4wWQ6M5/go2ki8y8ZJ0U
X-Gm-Gg: ASbGncsPfyYoxUvf2XY1A9ywFyapVmcteRNthe83rNEPt7qWpVKTsmXyJBefntTRobi
	J7s45aaqfUXziPFdXJjPQlbxquv6kSiQqWhty03pqMWCez+8/VPzNUwOhid39odkApdp2hLqED0
	oGMUvYZec=
X-Received: by 2002:a05:6902:1685:b0:e6d:eea7:35c3 with SMTP id 3f1490d57ef6-e7297dcb74emr4915473276.11.1744996723385;
        Fri, 18 Apr 2025 10:18:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgO3yGvbKJV4mk2YjiCklYNqNWcRnEs03RKhS2nZ9xH55/2YEz6HN6ctlOeQ69EMUsvvUuE8HxshphvDhfc0s=
X-Received: by 2002:a05:6902:1685:b0:e6d:eea7:35c3 with SMTP id
 3f1490d57ef6-e7297dcb74emr4915431276.11.1744996723007; Fri, 18 Apr 2025
 10:18:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417171758.142745-1-nifan.cxl@gmail.com>
In-Reply-To: <20250417171758.142745-1-nifan.cxl@gmail.com>
From: Nico Pache <npache@redhat.com>
Date: Fri, 18 Apr 2025 11:18:17 -0600
X-Gm-Features: ATxdqUHGLN0lFeajQ8s0PmbZ6wgOIx5rwI7HcqHdz6FT6fADQxCAu1ui4DqSWqY
Message-ID: <CAA1CXcB06JD9Fp4c7GGU3NHEm4W-aV7TS7JW7eWxshJEM4t2_w@mail.gmail.com>
Subject: Re: [PATCH] khugepaged: Refactor trace_mm_collapse_huge_page_isolate()
 to take folio instead of page
To: nifan.cxl@gmail.com
Cc: rostedt@goodmis.org, mhiramat@kernel.org, willy@infradead.org, 
	akpm@linux-foundation.org, david@redhat.com, fan.ni@samsung.com, 
	yang@os.amperecomputing.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, mcgrof@kernel.org, 
	a.manzanares@samsung.com, dave@stgolabs.net
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zBnv8h-YJdGspKaS2OwsS9McTJavgz5NUobec6JieZQ_1744996723
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 11:18=E2=80=AFAM <nifan.cxl@gmail.com> wrote:
>
> From: Fan Ni <fan.ni@samsung.com>
>
> trace_mm_collapse_huge_page_isolate() is only used in
> __collapse_huge_page_isolate(), which passes in the head page of a
> folio, so refactor it to take folio directly.
>
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
Looks good!

Reviewed-by: Nico Pache <npache@redhat.com>

> ---
>  include/trace/events/huge_memory.h | 6 +++---
>  mm/khugepaged.c                    | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/hu=
ge_memory.h
> index 9d5c00b0285c..a73699f000de 100644
> --- a/include/trace/events/huge_memory.h
> +++ b/include/trace/events/huge_memory.h
> @@ -116,10 +116,10 @@ TRACE_EVENT(mm_collapse_huge_page,
>
>  TRACE_EVENT(mm_collapse_huge_page_isolate,
>
> -       TP_PROTO(struct page *page, int none_or_zero,
> +       TP_PROTO(struct folio *folio, int none_or_zero,
>                  int referenced, bool  writable, int status),
>
> -       TP_ARGS(page, none_or_zero, referenced, writable, status),
> +       TP_ARGS(folio, none_or_zero, referenced, writable, status),
>
>         TP_STRUCT__entry(
>                 __field(unsigned long, pfn)
> @@ -130,7 +130,7 @@ TRACE_EVENT(mm_collapse_huge_page_isolate,
>         ),
>
>         TP_fast_assign(
> -               __entry->pfn =3D page ? page_to_pfn(page) : -1;
> +               __entry->pfn =3D folio ? folio_pfn(folio) : -1;
>                 __entry->none_or_zero =3D none_or_zero;
>                 __entry->referenced =3D referenced;
>                 __entry->writable =3D writable;
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index b8838ba8207a..950d147cd95e 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -696,13 +696,13 @@ static int __collapse_huge_page_isolate(struct vm_a=
rea_struct *vma,
>                 result =3D SCAN_LACK_REFERENCED_PAGE;
>         } else {
>                 result =3D SCAN_SUCCEED;
> -               trace_mm_collapse_huge_page_isolate(&folio->page, none_or=
_zero,
> +               trace_mm_collapse_huge_page_isolate(folio, none_or_zero,
>                                                     referenced, writable,=
 result);
>                 return result;
>         }
>  out:
>         release_pte_pages(pte, _pte, compound_pagelist);
> -       trace_mm_collapse_huge_page_isolate(&folio->page, none_or_zero,
> +       trace_mm_collapse_huge_page_isolate(folio, none_or_zero,
>                                             referenced, writable, result)=
;
>         return result;
>  }
> --
> 2.47.2
>

