Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D0D33B6D3
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Jan 2026 13:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792301; cv=none; b=ANHzH8Dz9xKVz3qNpgRA27ia+h8Tcrnle/tn872IHYjdhuZTnAWg/IHYvJyMeUil7jRDQVnrUYGbRSfpMyACgZ30+7NJIvtmo2d1epZKBw0j4NjtoRY5/xxhBTDnuwmPcEH/YwEOok2cR781U+stA0QgKjoLiXlYOTM19MgMTeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792301; c=relaxed/simple;
	bh=yEqsB60VUUiSvZef4yR/lKFwaZig+oFC8NOOkXv0P8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UWmARcSzpaTSQ5rnK2VZZ/KMMHA8RrfmAchIgFxNuNkuN6HzwKrkxtkrobS+rBjTVIOMihcAoJUSGSrfxjghNHr43vP+OwwZHfzn/AC8PQELxqaWgZ/fEGgBI7oVJQJtz3Evbv+Dt4MImbKI0Kv+zC2DYHn17TcAAso0MciP+N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hZJip5cq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZJip5cq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767792298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WTXeW4ZAylqeo4C6/c+qkj78SBOOk3H0bhNujdt3nhA=;
	b=hZJip5cqgboqGgMr/pSyOjpJh1cNxZAMZsjhnTHeDEmJNH5YKKIPi5SH/tIfB0gQnRVGN8
	M6y+8E63i/m0n2Nz7t8GHUrxaDoC6j63oOsMVy0nafaGcmo783gpWsDUqxg/AB0FRQ260d
	Fj/9H6qQnxqDwUNlA33wdqChyb+rAoU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-3QNRPD_ZP3KWEfxL_cd8gg-1; Wed, 07 Jan 2026 08:24:57 -0500
X-MC-Unique: 3QNRPD_ZP3KWEfxL_cd8gg-1
X-Mimecast-MFC-AGG-ID: 3QNRPD_ZP3KWEfxL_cd8gg_1767792296
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-37fc7967c41so10559681fa.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Jan 2026 05:24:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767792295; x=1768397095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WTXeW4ZAylqeo4C6/c+qkj78SBOOk3H0bhNujdt3nhA=;
        b=A+qfY+Gd08n7K2OGiwByb5+Ss+8Ri+zx8asB4TOxQl1MD2r6CvXwv1b40AdiGILH+S
         V/PBaw0VEYvxdlv5Df3DXn0SJtUSS4UfJxaaN4p3flMM3y0w4tj2EtMTFLQtv11HVV+y
         5Se/Av0HzAocTGDOaD1L9yvtBch6Wze/PpHxvteFz0+gmIlntQEcU9qv61gEjIb4zSqV
         VN7E9YDjjSj9AJcd6vqHoBNYsmgyxzhLCS6aQjozw6ACYcyfSz8IN2Ipq2s4+DXpBcE8
         jf5VfelhfO0gsBAeHiFEe6WkyNxhP8mjCTr8ST4yqZtaJVd39PEDdzL9XCadoFE+6Y+u
         ZUbA==
X-Forwarded-Encrypted: i=1; AJvYcCVXAZ6Ti1mjsRngoF9TAy34GXSzgGBZRZM0DjP0GHUZFCDt2nk2/sz5didppajBv/RZ5CTuDN6fcfgnUmzZ5jMSDBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF48uiCAgLKrL7bGG7mmcLKJK+7Cw912HwHeRk0tlAtgx4POnI
	xmYxxnURbG8/rfNFn/Vb8gpEDbbAzpD6RE/z99eAGfYv8SVDEL9F8NM9GemDTrvymySQh0e/InJ
	MtyLVXox3ZIVtNdslTPEgSzT+i3spM4fYjbKVNzZ7VbnyNZn3MI1kEjJ3j3IOOF7+Pq5UGw8nZM
	ZfFmPDunXtXcBZiRFSeolAGxD3CLv1xoDouWuM4iL0gUTTvijp
X-Gm-Gg: AY/fxX4DsXZqPxBy25Mt8ZVpHrC49G6a+xs291Fp8IheBy/VL13JWydQ39/6p6RgUCG
	gEc/UbB9+gUqWT/e4t4gwUtI8AbXPmZeqGJwzkoRkUd1icYuMh2KsdcjqDm9Ql4W/7hmuA5V6qy
	ypnkeLlFxStU+J+SCjq+h/z8EFmJbxhb+BhkqHnSv+hLQvz+rkEnEZO6egDsqBOGf2RYr7ENUgi
	bLvjZki4uxIRRCrt7xpURquMDDNIbMYfdCnKnpQVzegbZWeH0nTnsYJ0uqmZ3TtKNQ+WRpUoVt6
	R6xiSVRiHJxa
X-Received: by 2002:a05:651c:4cb:b0:37f:e645:9aaa with SMTP id 38308e7fff4ca-382ff68f5d0mr7279021fa.16.1767792295549;
        Wed, 07 Jan 2026 05:24:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyawBIep3Ik0XO0p0nY5zOT4BWCobPTD6vp/nnCBtidrWgs1APGZFenLumvjNgvAs21TAmCXukSA/QbA3PgoY=
X-Received: by 2002:a05:651c:4cb:b0:37f:e645:9aaa with SMTP id
 38308e7fff4ca-382ff68f5d0mr7278881fa.16.1767792295044; Wed, 07 Jan 2026
 05:24:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106133655.249887-1-wander@redhat.com> <20260106133655.249887-16-wander@redhat.com>
 <20260106110519.40c97efe@gandalf.local.home>
In-Reply-To: <20260106110519.40c97efe@gandalf.local.home>
From: Wander Lairson Costa <wander@redhat.com>
Date: Wed, 7 Jan 2026 10:24:43 -0300
X-Gm-Features: AQt7F2pnk_lk_Dg3GLoifyjkvvfBEFoRWSzObyVIZ9HVC1Wwtre9bKph1GmQoxA
Message-ID: <CAAq0SUmW7mUP0iiHMJevR+T6BKHJiFoU4M8sCVjJSRMFnT2J_w@mail.gmail.com>
Subject: Re: [PATCH v2 15/18] rtla: Make stop_tracing variable volatile
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3r8xmaAzir2Hb4eR4Sa3-agvszx_Q9LRJdAA8hiv7k4_1767792296
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 1:05=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Tue,  6 Jan 2026 08:49:51 -0300
> Wander Lairson Costa <wander@redhat.com> wrote:
>
> > Add the volatile qualifier to stop_tracing in both common.c and
> > common.h to ensure all accesses to this variable bypass compiler
> > optimizations and read directly from memory. This guarantees that
> > when the signal handler sets stop_tracing, the change is immediately
> > visible to the main program loop, preventing potential hangs or
> > delayed shutdown when termination signals are received.
>
> In the kernel, this is handled via the READ_ONCE() macro. Perhaps rtla
> should implement that too.
>

I considered that, but, in this use case, I saw no point because it
didn't bring any advantage and volatile was simpler.
Furthermore, as Crystal pointed out, using volatile for variables
shared with signals is a pretty standard practice.

> -- Steve
>

