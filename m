Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12454C133
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277487; cv=none; b=tNubdR11uVkTQXUO30TfB8DlXCTSmmcooew/3AxyjOKMf0yg5WdgoXFHRyJz+MCi+UDb3FPIslzAH7fD1SOxfaJ0xbTZglBqdVlDa4keIrn4joPXVO1IN29171KLLamXnrtwsP37h3iDprNssTo3lngIKDMKJ7XxA+SmQvxZPKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277487; c=relaxed/simple;
	bh=NBFAPxkmF0nG2JXokfLo6NIDkFlGKGxnWNcZLB+xlE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AN3UA8InrGlNz6Yl7DK/W6BPEzhopTAqjzH1ZPe8fj+aAfWt/d3R03wwp+73DEYyRU3Z2Jc6Fc2ONwd5Ao6x5YPBaIBf8Vs9n4JSRdjX5tTHhTGrg+CT38VUmtl5S0jqf6UEgn7IuWdNRkb79+V0ncL1zCGSRuZB8Pkf6Tip91U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=euBP7fyw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="euBP7fyw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756277483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w/WadWqKMXyJrUdDy4ttS1CdpuC8sMO7gA9sEwfAQyw=;
	b=euBP7fywYHEZ1VIG+Xnn/kU45ZJNndzZrdacN2oHar8Grne61k93yUv1hsM44eyjDwAAUM
	ik5rqImD7hLXsElB9GJRUVnZZ4bDKtLXFfQ01R+/3U/oQ+m48jl9pY9Irr09AFdETov1FG
	mtahmJvxpE/Hng7odY90e1CYYXi1tOw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-WPVgefU7M-KFZKRqFTHsaw-1; Wed, 27 Aug 2025 02:51:22 -0400
X-MC-Unique: WPVgefU7M-KFZKRqFTHsaw-1
X-Mimecast-MFC-AGG-ID: WPVgefU7M-KFZKRqFTHsaw_1756277481
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-afec2192e4aso34789866b.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Aug 2025 23:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756277481; x=1756882281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/WadWqKMXyJrUdDy4ttS1CdpuC8sMO7gA9sEwfAQyw=;
        b=vwvt/ac9z5otz6057agMr4zZ0iVg6AH1OqubAE17818j2+kCsris7m16S/lM3rBKbW
         7nXQ06qttduemubHSm//jp7+baJdGSKoGZ4mcw+xoGpKZpHbXKVKUdbTpFJ25m/hfTRW
         +lda34puKDrdxB/9woK063oJMdYeIRe8xwjPApa8DsFTbkAnrxjD7mLvv2S68/fFeul2
         VMSjIUCHji/HBeJfCBBlCqzPJcByDLo+w9xBB9Z+yiCR9TqahBBrXgayvRIklmedrcco
         QHaIA+TyMY6pBTMNDiqQJUzHhOaB9DB4UxjdqmSsA/xZfiOu6vAlfAjLr7H5MzJoMo2d
         3t4A==
X-Forwarded-Encrypted: i=1; AJvYcCVin5TUjypfuTVAjqvLtEGK1h0CNxn8WH9iaSaCaBxjrxS7/9leUu15uwJPxJN9zmxIY2Gj/SJWn1XW1lww48WKPds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhRb91OgSCAb+SAMKSYH7W9/8VxTdOGY8fk7T9E9BKPKrum8tZ
	QiLxSFecksBIF0BQ/Xfufex6agpeX9ayHIhOfKxu4ZYIafdiP1XKstWPFUeolqdlZikker2bVMn
	l3xCtBKVN5BmzS8Z2S3+Wdy9LQpvcbHdXJfukivf7Cb8KBIfVHhVzlQVSRAPno1R8arbCnEfvXA
	sG5BWxy0SXjGoArpDKe3JPif7wFHw/bSvYDUL4M7kgqSAQmY2k
X-Gm-Gg: ASbGncsysH56VrF5rOdVeTTs0WJi2iFPk/v0Sfk+44ZQBYkAakDfaBV9/85+GhsBpTy
	QQId5YcunzVfhtnUWpHmnnmfTw6ajNmZiNnKkP5Cz7YzLLGctYMGkgcp86ZDINR4ZoEw3NHI40l
	6uH6UBzLgssfiJd6lnotT8EGHvF6kvAoJpzrAWNal8fb8F6P1Lqko=
X-Received: by 2002:a17:907:6d25:b0:afe:c795:9ae3 with SMTP id a640c23a62f3a-afec795ce5cmr59034766b.38.1756277481133;
        Tue, 26 Aug 2025 23:51:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHAaAA+0dLAd0rofqjX8xIsFsOA7bdl5WtvCtZUN+NyqC20bxjlzfPbsaLj7M8qEg5MLZzFVKQzjsauV3poQk=
X-Received: by 2002:a17:907:6d25:b0:afe:c795:9ae3 with SMTP id
 a640c23a62f3a-afec795ce5cmr59032866b.38.1756277480799; Tue, 26 Aug 2025
 23:51:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821035719.137161-1-crwood@redhat.com> <20250821035719.137161-3-crwood@redhat.com>
 <CADDUTFyDJGTKU9vq_f4AjV_YJtktW8LHRZuwgJWh5nPAnwUvBA@mail.gmail.com>
In-Reply-To: <CADDUTFyDJGTKU9vq_f4AjV_YJtktW8LHRZuwgJWh5nPAnwUvBA@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 27 Aug 2025 08:51:09 +0200
X-Gm-Features: Ac12FXwsFRAWkx6J7wj93kDoCXQKQTYeetiSHkavaeVeUuav50Uq0heyaCdBExU
Message-ID: <CAP4=nvS5rbwwc+MBX+Gana59SoP+rDt5Kw2rmnRKiX-0PTDtwA@mail.gmail.com>
Subject: Re: [PATCH 2/7] tools/rtla: Move top/hist union members elsewhere
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Crystal Wood <crwood@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XGYMUpdWltmFhNdlAdix3-AvMda66M7C6qYVkbHtBds_1756277481
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 26. 8. 2025 v 20:06 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
>
> Moving `hist_params` into `common_params` could lead to
> the `common_params` struct becoming a "god object" antipattern.
> The `common_params` struct is intended to be tool-agnostic.
>
> I suggest we use `hist_params` within the tools themselves,
> rather than in `common_params`.
>

I wouldn't worry about that at this point. Currently, both
rtla-osnoise and rtla-timerlat, which are the only tools in rtla, use
histograms, and share most of the histogram params. Furthermore,
histograms can be seen as extra data compared to top mode. In this
way, it is natural for hist_params to be a field in common_params.

See, for example, this part of the patch (in timerlat_bpf.c):

-       if (params->entries !=3D 0) {
+       if (params->common.hist.entries !=3D 0) {
                /* Pass histogram options */
-               bpf->rodata->bucket_size =3D params->bucket_size;
+               bpf->rodata->bucket_size =3D params->common.hist.bucket_siz=
e;

There is more information now in the code, making it clear "entries"
is related to the histogram, plus if BPF sample collection is ever
extended to osnoise, this code can be shared. That would not be
possible if hist_params was moved to osnoise_params/timerlat_params.

If tools that do not use a histogram are added in the future, this
question can be revisited of course.

Tomas

