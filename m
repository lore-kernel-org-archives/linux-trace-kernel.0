Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E210734F496
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216706; cv=none; b=rohYypWJUzVRcqlBrOs9X8OcerKWAVVhN4P0AQ2r7z6ICpUATt18VVWhPNKjcDk73RA0+h+wfqYbmUMx3AXrVdPsETzgDYJFr0JqhWM6Q3WvM5vpUV2oGLKt9lwEaRwbYi2ECyOLGZf7xUrCnKRS/yj7oqqbmLSPZywmWm2nlzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216706; c=relaxed/simple;
	bh=0IOWrBSonIuM7sov/2eQ6pybPgqc55C5+AnfNU7ia20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PblsiWsWZsSH7Hc+JReu4bVq/283alWEGDdv+un/UMkX/89EQhvNLQqVYjwXk5Ejqf8zeMLiIZfzXJKLjKo3mzW/fxYanClm1FIF1l1XHCPb5rM8Mp3I2RwVhlRTJwJa3d4J9qm1b+bRkF6J7ab9N2crgXtwtiaig821Kx/AmbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fpCXBdX/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpCXBdX/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756216703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0pU6hURthaHem3CYp4ZCQ+KsIQFQDrs/GIY5XRqPp9k=;
	b=fpCXBdX//u+yvzcrnSLrj42F6sRNGmWN5wSYSshh0vtoTIR7s9sMLJgseuElAc/PwnnfqU
	pesZPmBuLeY6XOMBmycVqi81cIujTr87wwchYLCxLPjrgwsvN5cAs2SAXxYrNKKFfRozMZ
	KLGpBFo1NR2MOlADXEjkVJNdrP3kjik=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-9ujOlZVGMqWfLNvkGkBq8A-1; Tue, 26 Aug 2025 09:58:22 -0400
X-MC-Unique: 9ujOlZVGMqWfLNvkGkBq8A-1
X-Mimecast-MFC-AGG-ID: 9ujOlZVGMqWfLNvkGkBq8A_1756216701
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-afeb7c2b49bso13826366b.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756216701; x=1756821501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0pU6hURthaHem3CYp4ZCQ+KsIQFQDrs/GIY5XRqPp9k=;
        b=v0mEM3Bx5GwzOQn511XuQoU9Lwk9pGgchZiem9pBUq6mf+cDJBiTy/od/A9ej0kcc0
         bXAMASlotyG2QLmBUwFMFVMApS5LReSNSJeUrhTsfq2lQbe4QVBgD20jR91bIcqyKNqc
         kbjD9aaskZOcz2MApI6dXGVjuI0+c6N1iKa11ngANvnVumoWHMLArJ0VnRS721Q5c/Vb
         0zWrHnxDdvxpbheZI/uSe9YCwEEw0HZdhznwqef2d5Br7T+deR5Ynt/S0CTLW1gC61t3
         8uR5NeM6rpq3RlhWIbFYDtuhdWy00KuAUnsSTpx5PBbsClEVKRmMBRrf+OzLlgDrasq1
         t44Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWD4sFpLUHDiWBYUWo8Hf+d4fCmV+V5lveEz3sL7x9jRTwvb9tdJSnchcH4EMWxN+ox7whOEtxuDrgbSeYhZ3KyWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjpBlN7QD++2tsJfsZ3yC5OQImyMbBB/8QGI8J5zng7gdhETre
	x04Qs/eHSaazwTxoQRK+qoZZyzz6HKStFUaCWW1WH/u1EmC1z/gpcgZv1z+Yf4RnMNG2t4fLmzC
	LrISlTAx7wbxdaYwXrhrtqu7dUWwEYyt/fIG6iPqkfPCZhDYCLOisCAZyLUfByu/gGwfxfnKBk2
	KJxQvvzp1adA+gLUpnRCaX2j4MXW+XSIg1LaCnTj4h6pepJtNE
X-Gm-Gg: ASbGncvRRJIHmNQnGGCrHC4gSwCv1pFRkgBTRVgyWoumtIv6+BCNpk2Btow0OsDA5ez
	L074G0v13VujlJML7lDGRdMjkIaxp3VGOG5ipQ/kg5EsS6/3bfZv78S+UbYnH5iCfHjY962ilAd
	ksFwd++awIsvbbFGtOQeg=
X-Received: by 2002:a17:906:d103:b0:afe:7027:56f9 with SMTP id a640c23a62f3a-afe70275e3amr709531866b.17.1756216700949;
        Tue, 26 Aug 2025 06:58:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFpZZ/1Qj+pbPTLRdWz9g2WWnXcGTGrYD7p5rKhmxR+1K7l6cgTDGY/TIrdPdp4g7vC2kC/PuphNC+uRCpqTY=
X-Received: by 2002:a17:906:d103:b0:afe:7027:56f9 with SMTP id
 a640c23a62f3a-afe70275e3amr709531366b.17.1756216700467; Tue, 26 Aug 2025
 06:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821035719.137161-1-crwood@redhat.com> <20250821035719.137161-3-crwood@redhat.com>
In-Reply-To: <20250821035719.137161-3-crwood@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 26 Aug 2025 15:58:09 +0200
X-Gm-Features: Ac12FXwrn21FQWKD8NwCbCgVnxnEMzBiR_eETMqO8FtUMmHcPRKTelVOrhIKyvM
Message-ID: <CAP4=nvQtKguNDikon2idnaET=Rpfsuo2DQeoRD4Nn8_FFRUX=A@mail.gmail.com>
Subject: Re: [PATCH 2/7] tools/rtla: Move top/hist union members elsewhere
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SVRvefBB5F-TVEbftssd3MQVBz7Y6OkVaWdtooPrm3k_1756216701
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 21. 8. 2025 v 5:58 odes=C3=ADlatel Crystal Wood <crwood@redhat.com>=
 napsal:
>
> The hist members were very similar between timerlat and top, so
> just use one common hist struct.
>
> output_divisor, quiet, and pretty printing are pretty generic
> concepts that can go in the main struct even if not every
> specific tool (currently) uses them.
>

Absolutely. Quiet and pretty printing are currently only used for top,
but they might make sense for hist, too, in the future. output_divisor
is actually always set to 1000 for osnoise-hist, once -n/--nano is
implemented for osnoise, it will also be used by both osnoise-hist and
osnoise-top, just like with rtla-timerlat.

For the commit message, maybe "Move hist/top-specific params into
common struct" would work better? "Elsewhere" doesn't quite capture
the idea for me.

> diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/sr=
c/osnoise_top.c
> index ad5daa8210aa..7c68feed300e 100644
> --- a/tools/tracing/rtla/src/osnoise_top.c
> +++ b/tools/tracing/rtla/src/osnoise_top.c
> @@ -125,11 +125,12 @@ static void osnoise_top_header(struct osnoise_tool =
*top)
>  {
>         struct osnoise_params *params =3D top->params;
>         struct trace_seq *s =3D top->trace.seq;

> +       bool pretty =3D params->common.pretty_output;

Is there any specific motivation for doing this and not just using
params->common.pretty_output directly, like for the other parameters?


Tomas

