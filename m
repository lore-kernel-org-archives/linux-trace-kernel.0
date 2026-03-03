Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0103E3ED5A7
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Mar 2026 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548073; cv=none; b=TPty2duJQiNyk/0I0clk7hY+HrLVLJ3iJdIM/JLXvA51pExH3j4P8duMzu6c8S1rvufeDW+eEE8O9WtrRLol0DGJIXIbL35QgCtAa+0gCB9SDDtAlvhR03BEAYsLws5cWjQn321mp724VeLsVx0a2nMt6NLSfaSpS5bqlSiPEAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548073; c=relaxed/simple;
	bh=egMEBqKWfAr8CtNnm+dE/tXlDActJ7B5VMObkcMEQkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0DDNNMrOIiYUHJhQqGf9mirHVOXRWqktzw25MR/cDvaXro753RIuheokzp0yN5lkhc1b1jWSyLipAHie8vlsTR5QpRwPask5zUvt0rlPL0okwvY89xDQlLI/NaqW21GpXrxeYae/jEyHIqApkvS3LzBKowMbKdbWl7S7U/Im1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TIPuOudc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIPuOudc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772548070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0pzsSwi5adWCRovilNghDM/wCo/ieqebuXIEWNF2uf4=;
	b=TIPuOudcVBtsdt8Y4ckl4LP7TGfyV2bzYxKxTdSW2k0AJiyGPkz1NUSRcQImSaTT/L/B8u
	ICupI4lZ9lRsM9gM7K0G85lkuGeJKR2RIjHfkIEEagjAHkFwNJWAUUbmXmh1kIbTBu0Stq
	ZsbOF/5T5T8P+QaV5Bq+4WeLNVJJHDE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-rt82pWnINACRYa0BMCdIiQ-1; Tue, 03 Mar 2026 09:27:49 -0500
X-MC-Unique: rt82pWnINACRYa0BMCdIiQ-1
X-Mimecast-MFC-AGG-ID: rt82pWnINACRYa0BMCdIiQ_1772548068
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b8fbf8701e3so572626466b.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Mar 2026 06:27:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772548067; x=1773152867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0pzsSwi5adWCRovilNghDM/wCo/ieqebuXIEWNF2uf4=;
        b=hCM8+2jgbYygrMLXnJp1C6io06au+cfUQZv3yXr13O/CrxZX32GpSnz8+fnLpM8I0Y
         bTfGUd3c6adTZ0V48NJy9e+GGYogHXrUNptIQWOijhz4CmZfpuurzSjlwx2AKHdXs62A
         a1njIGJM7AWdLT5EQE2QmBJl+A/zf076lhfK1pVT0Ar1mMh9lvkTg3gutxdQz7sKvB8e
         kWWfvDB6tHjyLwtfdKK+cpgIhBRweYnwNsnXcoQgZCysjtbr76T6dN/O32V9Fio2dzn8
         076td1mKHIyotwAA3B5yVgwrhWccDTO5y+q3QEp3xr/VREkDLL8gpu+RLrdkSwzh0ihI
         NvNw==
X-Forwarded-Encrypted: i=1; AJvYcCVyUG7XDYAVWEBOCcn7s0XVNQpJo+2ZL4xFOqAsf+JXuirhZ0TjeNz0giJ6m5FxkwZuwdnmQLexUVx1htiXdK3rr2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YysU84n4qNSu9BxzsezzqlGwC4nEzqUnrBwQc9pRnKRJvESS60o
	vEt1dRk+w3rVWXJQeMBSWUdtwO/k18E69DYTq5P1ZOOG/43NZjkX2TSUFlYuhNwgSBx08bS5fmL
	sgObZ9qPTURMa7Hd96nBl5Q9GX/fKRpaqLHfn1TFiI6skbvB2Xmru0lRYrU4sNTafV0tQnQaRZj
	1QkL4pqlFQvM6y1fzqgUwhhxKq0+DQT2S8XT2Fgga8ZmOx7p8mnLRPABDMnyw=
X-Gm-Gg: ATEYQzxQWTiPBZMmG2dF4yPsOmaRkr4MNNsRpAobfNKqzTUzSmb2D/fN+uVWte3l9Cu
	Ri2+o4nWlrx+Vt32dKbgWRUY4Os9GD8UcVkNacwT5MJthm4xRj4ldBalFfwpEMvxMioZ/HjugB1
	AAGbrHq+If/jKrXIHNQN6kSzESQyV1VKPAPvlHp2v8IIV8mC362TKQ21CPapt+8XR+gptvghtFm
	wyt/w==
X-Received: by 2002:a17:907:9288:b0:b8f:7c0a:f955 with SMTP id a640c23a62f3a-b93763b77d3mr1103359766b.21.1772548067529;
        Tue, 03 Mar 2026 06:27:47 -0800 (PST)
X-Received: by 2002:a17:907:9288:b0:b8f:7c0a:f955 with SMTP id
 a640c23a62f3a-b93763b77d3mr1103358166b.21.1772548067100; Tue, 03 Mar 2026
 06:27:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115163650.118910-1-wander@redhat.com> <20260115163650.118910-13-wander@redhat.com>
In-Reply-To: <20260115163650.118910-13-wander@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 3 Mar 2026 15:27:35 +0100
X-Gm-Features: AaiRm52--PTPvTJjr7o8z065WWcwDMjy1s-ZrskhLMDXhoPN5incdHmTOca6bdY
Message-ID: <CAP4=nvQ6EeecMggeVciOaW_-=sa2QJ2r9DX0Xifzgsv5JBhAAg@mail.gmail.com>
Subject: Re: [PATCH v3 12/18] rtla: Enforce exact match for time unit suffixes
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Daniel Wagner <dwagner@suse.de>, Daniel Bristot de Oliveira <bristot@kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: twhmzbq_TlkRMioTOJGUbpAuqYBoL343ez5X212z01Q_1772548068
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 15. 1. 2026 v 18:28 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
>
> The parse_ns_duration() function currently uses prefix matching for
> detecting time units. This approach is problematic as it silently
> accepts malformed strings such as "100nsx" or "100us_invalid" by
> ignoring the trailing characters, leading to potential configuration
> errors.
>
> Switch to using strcmp() for suffix comparison to enforce exact matches.
> This ensures that the parser strictly validates the time unit and
> rejects any input containing invalid trailing characters, thereby
> improving the robustness of the configuration parsing.
>

Why not use your strncmp_static() helper to protect from overrun?

> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> ---
>  tools/tracing/rtla/src/utils.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/util=
s.c
> index 486d96e8290fb..b029fe5970c31 100644
> --- a/tools/tracing/rtla/src/utils.c
> +++ b/tools/tracing/rtla/src/utils.c
> @@ -211,15 +211,15 @@ long parse_ns_duration(char *val)
>         t =3D strtol(val, &end, 10);
>
>         if (end) {
> -               if (!strncmp(end, "ns", 2)) {
> +               if (strcmp(end, "ns") =3D=3D 0) {
>                         return t;
> -               } else if (!strncmp(end, "us", 2)) {
> +               } else if (strcmp(end, "us") =3D=3D 0) {
>                         t *=3D 1000;
>                         return t;
> -               } else if (!strncmp(end, "ms", 2)) {
> +               } else if (strcmp(end, "ms") =3D=3D 0) {
>                         t *=3D 1000 * 1000;
>                         return t;
> -               } else if (!strncmp(end, "s", 1)) {
> +               } else if (strcmp(end, "s") =3D=3D 0) {
>                         t *=3D 1000 * 1000 * 1000;
>                         return t;
>                 }
> --
> 2.52.0
>

Tomas

