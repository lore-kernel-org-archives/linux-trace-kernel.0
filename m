Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF1E48988B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 19:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785353486; cv=pass; b=o8csj+E4RyX4dE0L5yjCbHI9XXpucBmPnIcD0dxhUWCMR61R9bPioIx8VBm9AwY9dDsKhA81q1BrtxSXTUK2aciG/wniFqM6Njj7/iX4Axeds6VzKDiqZOqwOcMJXvD5grIJHNODnRGni0bI9aqugcJNEvOkNP6et8TCn9x2G8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785353486; c=relaxed/simple;
	bh=AW+2NReGvoch2mVxj+60oV42GoQXvVY/28NZ+o3sxTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQRQglShC4/eMvTz2bkbpVhcXEvNzY7onUKS2QIdPDau79Z61H1mYQOOw5WkJuXVqBGwQsSaCAC8E9r7oSktx0rI+Xxbgr1jRYy0dAqI+G4JNkjF8gpgYUCRJH4toUJaSrLo4WBRQd1HYXh2pC6HglqONTYqPoyejLqK7KAbswY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsCuZjvw; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsCuZjvw"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8487214ad2bso2033448b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 12:31:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785353481; cv=none;
        d=google.com; s=arc-20260327;
        b=noCD+M/w81bghimakT28zTDtaJLdd3EgMCmm5sVSjm05XX2yoIAp/RbQGkbr3lxcc1
         AShdi9rectF7aBQ11Ga/16ob8fDZjOUOPxb6V+2EVw0u0/pwCQSousnBBG0HL9wUMjlm
         fnuU95F1+pRKkq+nwXZh+Ns9mGM+Rj1Ve/Z5VvaJ8o4TrxbQ2OJTz7JlYATDr5VvMo9o
         q2Wkg5aYv8tLMIL4gMEhA1UQ1qEXIxJameGszNvK9qJ1ecF5ZO4wn5wNmnPMCfF9xjFO
         Yd9D0UEbqs5CtwaM7XhfQi0YPqkkCXsniS+JzSAR4tX9nL0JxoohAT1uT0fu53+eQuHG
         wFdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZEPCjaM0A4Cy5/l9buwk6OfkCA8SEBnX/nbFrur6xxY=;
        fh=/0foZBnWioIB2+knzw3iwbuYXSp3B/x/MivQ4LBLIbs=;
        b=N0QWyL0BJN+n0MDMMCzvFxT0TfhoSnvbw9JhheRGuMiqVwaTv/DV39GTqem8JrcDVL
         EBszMZ+CIgCkgn4fFawTx6pjEHxCyUwoN3BTXnG3Z3yACOORw7uXCjrJNgFT3xm53B2D
         9CHpa/XGXBGri777dkBlGArSO1AiveNZWU4khbpYqQTYeYYi15pIUzhcS9NcOKZcveS+
         Hvp8qfuJ+arh+GEWHhVC26L7TvDSMJdzB+7GTCUulMKWyRCErCn11HM6rIZISSnH4PZF
         qi04NvfD+9dZd6p5IRB0OJHieleVM6N0PlgDorf2B62K0f/7Nbgp6Vz0U6FHpEmERw7g
         D0PA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785353481; x=1785958281; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZEPCjaM0A4Cy5/l9buwk6OfkCA8SEBnX/nbFrur6xxY=;
        b=OsCuZjvwu53Bt5xqrwiBNeckfkSjiWJzvvxKY6fbPq4G9COH7Ao7fQV0AZfz58z/1k
         GIZ0BpmtujRkYBugLG2dR+6rnEbekKdfRwMITuWdJ8AovWlwsl79XJXZ5Y0ApsTWtZgQ
         Nwq1xEj6eWtYpteKMtKivHRPP0cXIzm+bijLcsOZNaHcXMIqDgkiRng3pDo4lNxhPxdC
         F/nexB2rV7cfx0Z3y8j/Z5yx+8U2YR1MBMfuizTq7qRQsbLhZ/rsbm+u8zL8A2nNqO3r
         d5HSRi2bbkmlizmKOvTi+lj8k8U+pyQNgWfRLduHxsxFKU8VZvg9B1GSRrPNyI1u8+jq
         3zMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785353481; x=1785958281;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZEPCjaM0A4Cy5/l9buwk6OfkCA8SEBnX/nbFrur6xxY=;
        b=igdTKKraFU6RDUE4O7Z3w98XET5anpaec3X5hY5Lbw5LSRCIT/RT8pOa4KLBaQWxcK
         S9FItsOkiS3WouuHeDR9xZrW5ettLpWjrlHFeSg8D6Y8ETNqlDv6ZchbgH5SiL2imSVP
         1zzJYkqycGUTtf9jOvJfyQretffU9VQiLUjL6Gz5u0ykCjFRDR0nsy1ILvuzQUhsTNqo
         /kOqDABvwkf0M1cNwZwm1M9lcN1ekAfcUjIXd7hpHLEEKGMfXGyHW0aV5koU1cafrxUX
         +kkJ+pCIGAc631iGzBPTWvMLFfqhrtbAeodoal4YaocwUHfKNrrgHnAlg91Nit7NxxYK
         awcg==
X-Forwarded-Encrypted: i=1; AHgh+Rr5e21fqZqs13gYaywvItnr2GPfUzY5KxMhck/EC20y2ll4VGCge4eRvNuaSKTBUBVGzPOXCIXd2cri9DXXogzeKVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1BeTFyDwaxOVs3Np6sO5SquBrQw8SMYR8dO25IVhrZB3KXv27
	lY/2hT+Kg9XLXD7dpoXccbFBwG34LvNFeawAuimefcslPbRhOH6pQHnwOIGVn+GEUfw5sbb6G0L
	INewP+favq+wB3Pj99pT1NTUfXw8Oi8A=
X-Gm-Gg: AR+sD1042zgX9Gr6H+xVugtuRc4VmBkVgn9bskUoXZ+ZEBIaSNsaz6jwZfh6HPvkwZw
	IJRDgpaYkzQP6sITXew4eDkKPiXzC6co1GVc8lCe2Nnm/aFQ5MGe/PX2X1P9/iozNmbMMc/aj7H
	1r0uoW5B5rHVlcvR9t5xfICFFbQVQIpaqLAlKHmqZULVFwmgU1c9RuBAxaBUCHa4L/4MtZhXl3J
	Y3qyC56mQPNACE28rQeaHSJWD+SWPMCPu5FhqymEk+qtyOrjZFRg+xwF0BG+v/GTSu9WuXK1R/o
	pml2/e5OjCnnGRXPKk4OLhrYCFf62TRNPB797VPWaJwIwQ04VhR1FYifLyGB1eRVrBwmrW5XzOx
	3OUIIRlHc/oqFhMnSoFTrbCT1ggkyXWRQW6Ib
X-Received: by 2002:a05:6a00:2d28:b0:847:8250:2b2b with SMTP id
 d2e1a72fcca58-84eba209c22mr58219b3a.52.1785353480816; Wed, 29 Jul 2026
 12:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729-uprobe-v1-1-61896b87c867@debian.org> <amokG13tEnA7VVVf@redhat.com>
In-Reply-To: <amokG13tEnA7VVVf@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 29 Jul 2026 12:31:08 -0700
X-Gm-Features: AUfX_mwlnvUi1r-ku73ZCSAcs_YOxNgVJkyNNO_0D-3nnjYBTZf7rGtYqZPK430
Message-ID: <CAEf4BzYON57L_HD71qUOdRdni_=1S-Xomz27PeDBxbbXDy0Jug@mail.gmail.com>
Subject: Re: [PATCH] uprobes: Fix NULL pointer dereference in hprobe_expire()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	kernel-team@meta.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 9:02=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 07/29, Breno Leitao wrote:
> >
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -832,7 +832,7 @@ static struct uprobe *hprobe_expire(struct hprobe *=
hprobe, bool get)
> >               if (try_cmpxchg(&hprobe->state, &hstate, uprobe ? HPROBE_=
STABLE : HPROBE_GONE)) {
> >                       /* We won the race, we are the ones to unlock SRC=
U */
> >                       __srcu_read_unlock(&uretprobes_srcu, hprobe->srcu=
_idx);
> > -                     return get ? get_uprobe(uprobe) : uprobe;
> > +                     return get && uprobe ? get_uprobe(uprobe) : uprob=
e;
>
> Well, looks "obviously correct". At least the current code is obviously
> wrong, it even checks uprobe !=3D NULL 3 lines above.
>
> Andrii ?
>

Yes, indeed, I'm more surprised this didn't come up much earlier
(probably it's rare enough to have uretprobe with refcnt at zero
during fork). The fix looks good, thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> Acked-by: Oleg Nesterov <oleg@redhat.com>
>
>
