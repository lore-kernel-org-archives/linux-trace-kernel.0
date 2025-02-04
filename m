Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AB120D51F
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Feb 2025 13:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738676124; cv=none; b=oKXsEtGrh+Eur6t+nIfACEcicG/XwJw7WVdQGl8TSatPBPxQvBF33t9szzMU6T2E1YOHpgWabptlKZQh6bAZ1Xrij8SkY+0GtxW1jPck6dckO1VDtccJksxhDJQSpThVDbQ4FPb6E1z2iUbXWmnc8YYDso12RdPwr/kqeGmuFhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738676124; c=relaxed/simple;
	bh=JV3BNjA3BqQvufGTY+ytUgeeitaZPiDOaSBuz/gglQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q1bYW5X73877Hg+ghlV2rwcqS0sx6eHzaCpThUvzYlZE+d3kvp5OoFBMg6AvO/En/v/caEKqidOtNZHpGpXl++zxSEoHmKP80UaGxWbLGAV0Rj2v3i5EghvQL8Mek9XOnEWxkzcvHLl2tLS6dbjc/9lWEPYzVUzXovvI6xdrJRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fk6g67lN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fk6g67lN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738676121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q7zHF/JvGQhbmzpDX8U/7SveUcBjozFywVEOZh0Mkhs=;
	b=Fk6g67lNRTrD2GIEpfO9g+MHL2h4loRWDUynRUr3fpzMf2gKgqtnNdnZ1kcPZQ4U8i8HyJ
	euT5cS0zYbEF2/4TEefodaNF5hT6rJfYlBl0UeWW3RrqmwLadqFuO5ZO0fPoLMnyXOrTv8
	9ONQNu9su+FjVNL3vHYVnfn9Sirjy/U=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-4jjxb_NRPSq8nB0Y2bQHaQ-1; Tue, 04 Feb 2025 08:35:20 -0500
X-MC-Unique: 4jjxb_NRPSq8nB0Y2bQHaQ-1
X-Mimecast-MFC-AGG-ID: 4jjxb_NRPSq8nB0Y2bQHaQ
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ab6e2b653a0so518069866b.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Feb 2025 05:35:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738676119; x=1739280919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7zHF/JvGQhbmzpDX8U/7SveUcBjozFywVEOZh0Mkhs=;
        b=aqTU22XLjnzc5WxJBpHPyuUn9tiwT23++GTtEJcT1JkN+UqUnrKwjpOXvnJJv86kIJ
         UmPfQe+RWkzOryNAZJbbIujRscfyos6PT1wtoyaUuiSUqArnqi7rYHSWYt4bdPZ0fNgw
         84PBNACbM1gTPbpaKfI6PZwRL9IeSFjMbq97NH4tNP/N1sSicmmjTUhRII9V0PBeuryS
         T/XWP15u6r/Cy89gj6uWDyaHFOI2WqZl1SUe71VFQ8xETOZPNk/zTQcycP/Jxx3V5p2N
         +vBCc5Kd22sp5GlhIJOqk+5kJ4RtnHN1WPDUSp7y4/erSAlCmWgggS1e2qp/4lUYLVUa
         nhTA==
X-Gm-Message-State: AOJu0Yz6lil1AOZ9M6Awcx4jalH2uNxBWRTUqGrMXz6hr8Q01kQmuXNZ
	ICyjqFvVtc/ZvGz7ZH+aq20nly2MlYP9lPMKKWCFfEhNIHzYPrrQ7vDf6NIGGbTosaVPsnzFuuV
	3T0SdYZBPxodST1S7IXkjXm3CLTJRWIxaVzuO52Q443+EOuCEHiCUsR55AwNZc9Fbmtsixo3dm8
	laRpnsIVB7lKPnqutqClFECy2r9nOPuu5jq6/RZideGq1K
X-Gm-Gg: ASbGncuc1lByLj4HnUOKES6FQ5CltprNgxZcmFRlt5D7HgbQmbcFxgcTs/b2nT9/V8w
	9edOfzZGtpNOJ1EycgypkFwJCUGI7XTxAjwSlhhzLR5QNYT5tmtqPVvCl/BSS5A==
X-Received: by 2002:a17:906:6b17:b0:ab6:d575:9541 with SMTP id a640c23a62f3a-ab6d57596fcmr2295660266b.19.1738676118803;
        Tue, 04 Feb 2025 05:35:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQyNZ1zFA8JAY/KtD95RTHjfORdE4Cje3fpR1/nyJsOcP6SudPE/Vp6vUC8rTSidIxRyJdkiofR4fmIJabZcw=
X-Received: by 2002:a17:906:6b17:b0:ab6:d575:9541 with SMTP id
 a640c23a62f3a-ab6d57596fcmr2295656866b.19.1738676118429; Tue, 04 Feb 2025
 05:35:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203090418.1458923-1-tglozar@redhat.com>
In-Reply-To: <20250203090418.1458923-1-tglozar@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 4 Feb 2025 14:35:07 +0100
X-Gm-Features: AWEUYZmRxU_emUlB_7qFxmTcQu7MxIBoaSaHpAe48IjFMrz9TipzOHm2LidJm9Y
Message-ID: <CAP4=nvRNvdULubjN1XPF8jNxY3tRdfy+9Vqv97EsKjzNGKyYig@mail.gmail.com>
Subject: Re: [PATCH v2] trace/osnoise: Add trace events for samples
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, 
	Gabriele Monaco <gmonaco@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WjKZKTq-zEiBf2WnPc9bLD5i1VveSpwV0lz2qY6UL94_1738676119
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 3. 2. 2025 v 10:04 odes=C3=ADlatel Tomas Glozar <tglozar@redhat.com> nap=
sal:
> A proof-of-concept bpftrace script using this feature:
> https://gitlab.com/-/snippets/4801190
>

I added another PoC using event histograms to the snippet. That one
captures data from all CPUs, and thus can be used for testing on
machines with a high number of CPUs where rtla cannot keep up with
timerlat samples (in our measurements, >100).

There seems to be an issue with division where most values are rounded up, =
e.g.:
max:        135  timer_latency:     134657

This also affects the main histogram and seems to be specific to the
event histogram PoC. The bpftrace one shows exactly the same results
as rtla when run concurrently with it. Another difference compared to
the bpftrace PoC is that you have to calculate averages manually from
the latency sum and the sample count.

Tomas

