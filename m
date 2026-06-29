Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A8435B136
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 10:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782730296; cv=none; b=aMUrkQkoxvZkTDnx6IGeiyJDs67jlz6DOgElBoQ6B8dXeWbu05EjqzOBcNtiM8uJpsOa/7N+YqSbNrVrbKfIcQQPGy/LJInhFaZC5OjHe+WW8IRZefbQr1/Lb65mwGrJOaqszzM9zgBbdzYrOPoaZtFVn7yEEoI26qOcL0zjHt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782730296; c=relaxed/simple;
	bh=nqW6mIdM50mSNOd/Nn4h+yUBk2ArbNHCm1eThX2561w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aj4ftmaUPiyeb5Wv8iz/yjwUnbdUPXWrGS72BnZcPIzvnRyC+/i63CUJ0LN+pO5wp2rHaOgOAADfmXvhbVoOPQaBDbM9SDOfzBkySGzqNnitEZOkDUX3j68wbywIcf8N7rVuIPbz5RdSDI4coFMdP8+VUNMkGka1uQFIXvniiqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fPHzykEx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPHzykEx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782730293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n3ws4rCPq8FbI/qAzWfHfsiqF4EgFOS1VekAziRSQrk=;
	b=fPHzykExCHrpDNnrpVkFoBa0TtIYMNHWC2rJ6gyH0QeoTzfss0IaoYc98Du2C3G7cAHGFz
	VFCuSo/6VZqfKCwiUNdmsA8/vj81umI9iY0Np5dT0C7cVhEfkSHf9eWpyPbc3gqixgq/v0
	Ot8A5HYjGSYPPu790f3vHSvrmSQIg40=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-jPZFJunUPLqybpb7R8mp8Q-1; Mon, 29 Jun 2026 06:51:32 -0400
X-MC-Unique: jPZFJunUPLqybpb7R8mp8Q-1
X-Mimecast-MFC-AGG-ID: jPZFJunUPLqybpb7R8mp8Q_1782730291
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c1215680359so288049966b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 03:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782730291; x=1783335091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n3ws4rCPq8FbI/qAzWfHfsiqF4EgFOS1VekAziRSQrk=;
        b=PeTJOSiI0Wig34lj7idSqaz6mspnUh7AHNslMItuj/BvIM9+iYoR8r5OYlifoi2OWz
         Sa/gkMxiHnfW3yczG3UYqghDI/9vEl1abiHGFZvK8pj4fW68kWT41dI2L7woDvC8o7Ai
         S1f6h8T3Uhr5hAP6n2dYCYRg4Rn7aZg8CPUVp1twEu+JiNThGpHgLfFjmBFvIMguMZpz
         /+pkcLH13QLAvdAOIF36kbaJ4mWz/7OTfbFK+BbAj/98maR+EZ7s9rRT7FBsyY+h557R
         6rGY5tpr1XnBSgGJa0AwnOx5s4WvJAvJ+E/zZ+8EINKURgr6rev+X8P69zZBD7PIoJhf
         ch+A==
X-Forwarded-Encrypted: i=1; AHgh+RoPd0cD+XYL+sqbjK3R8wZKwTBJglN7cJzERu0zlkwxAzD6tojnX+vaUlsZdfhE5fIxouA2eSTePm9+r9S703q8v5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU8ekCEtv8eqQ6jESmUBO1FDr5y9dTenx9unK1n1DlBHqj1ixt
	PxhqpEDywWcvBivTZ6Oc4CfAG6eUyNqTAj6/kSzpqpmBrKpFavqOssP5s+okG5EBWOtCGMGCH2N
	rPjAfAyVWsR45AvEc5VvFcMrEM2L42cVPlCVQgh1XVKT9krydwQOXcl4ywWbhlHjYnAfJocjEMB
	k8TBMybUY0zzSMcD/NdyvR9Tx1U/OZlZOdMQmMoKUt1736Ntwj
X-Gm-Gg: AfdE7cn3N72tJdjMrRQBkWJVxPZ+jNxORvaf/+fuQkx7ScZmFRIPw1mck+eEWtpZ6F1
	w1jSUJVdx3I70WklY8zWHiGgsM5Km3AtLeGrHy8dj2v7ZhALEXKX1+P5GgHb9csre5VvUBnqXuf
	KVCx8ED5COwW2yNgSnO9cNiQkznpZSPjcTxLocqNh689VsprqDrczXFbqTv2jXRGOvw0g=
X-Received: by 2002:a17:906:fe06:b0:c12:7e41:3904 with SMTP id a640c23a62f3a-c127e414cf9mr28207466b.16.1782730291292;
        Mon, 29 Jun 2026 03:51:31 -0700 (PDT)
X-Received: by 2002:a17:906:fe06:b0:c12:7e41:3904 with SMTP id
 a640c23a62f3a-c127e414cf9mr28205666b.16.1782730290876; Mon, 29 Jun 2026
 03:51:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617131803.2988989-1-vschneid@redhat.com> <20260617131803.2988989-2-vschneid@redhat.com>
In-Reply-To: <20260617131803.2988989-2-vschneid@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 29 Jun 2026 12:51:19 +0200
X-Gm-Features: AVVi8CeewMn0xxsTpGREX6lOHn5ir6xfRL8TugZkdPaRQZuSYqopfoNIae3lRL0
Message-ID: <CAP4=nvRiOdiLA-O8RLBwY+db9__vV+i-Qw3uofOZzjONV+kzYQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] rtla/osnoise: Add IPI tracking cmdline option
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, John Kacur <jkacur@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Jonathan Corbet <corbet@lwn.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bYBr2FTTKZvxpecLsepIzk7Z3k1JcjMuoIYNJjLasR8_1782730291
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 17. 6. 2026 v 15:18 odes=C3=ADlatel Valentin Schneider
<vschneid@redhat.com> napsal:
>
> Later commits will add IPI tracking to osnoise top. To avoid breaking
> existing scripts, this new feature will be gated behind a new -i option.
>
> Suggested-by: Tomas Glozar <tglozar@redhat.com>

Thanks. Implementing this as a separate option also means we don't
have to worry about the performance impact in the general use case, as
the feature is not enabled by default.

If we decide to enable IPI tracking by default in the future, we can
just change the option to "--no-ipi" without breaking anything, as
libsubcmd generates all options in a pair by default (i.e. it
automatically recognizes --no-ipi when you define --ipi and vice
versa, unless explicitly disabled).

> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  Documentation/tools/rtla/rtla-osnoise-top.rst | 4 ++++
>  tools/tracing/rtla/src/cli.c                  | 1 +
>  tools/tracing/rtla/src/cli_p.h                | 3 +++
>  tools/tracing/rtla/src/common.h               | 1 +
>  4 files changed, 9 insertions(+)
>
> [truncated]
>
> --- a/tools/tracing/rtla/src/cli_p.h
> +++ b/tools/tracing/rtla/src/cli_p.h
> @@ -305,6 +305,9 @@ static int opt_filter_cb(const struct option *opt, co=
nst char *arg, int unset)
>         "the minimum delta to be considered a noise", \
>         opt_llong_callback)
>
> +#define OSNOISE_OPT_IPI OPT_BOOLEAN('i', "ipi", &params->common.ipi, \
> +       "track sources of IPIs")
> +

As IPI tracking is not a commonly used functionality, unlike e.g.
"-p/--period", and -i is already a different option for timerlat tools
(-i-/--irq), I'd suggest keeping just the long option, --ipi, like I
did for --on-threshold/--on-end (on Arnaldo's suggestion based on his
experience from perf [1]). This will make it clear to user the option
means "IPI detection" and not something else beginning with the letter
"i". We can always add a short option later if its use becomes common.

[1] https://lore.kernel.org/linux-trace-kernel/aEmWyPqQw2Ly7Jlu@x1/

> [truncated]

Tomas

