Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E422FFDDB
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Nov 2025 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763570960; cv=none; b=Q0qyeKTPlAiMfEi8np1uLcnwh4ousq2k2r9yh1TOgat7QrCwMUY8moxcjEHFFnoT/4YUHSUU/hNZud6JOFRWTVWuV1kWJrqS8ptLO/KRW6bW9NtxaKMeMcnP1NkUw/dSWDqUtCXNWsIKRNC4+gS5JmIhGf4+gLgYjU/+IoDyRU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763570960; c=relaxed/simple;
	bh=Ntu79LxvHkkLpbqi13VepeqzmJSPf4zQKMOz7mKoU6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rkc5geYIpkGdmEH4Kp2PYeGHoI6K0OXaGkA9r8ezk1VP9HHoTbsazxYFt0r3LNymYLCbp90+bg1KmGy7eHeB4reAHx2q1NjoBwvUF/OlGXgMQhjkIM/adkol2s9iusxtstdorhZiavQk4X0OVE1qsy1YcIWXLmWheITIBmSX02U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N/Z7EAfl; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N/Z7EAfl"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-297e13bf404so233315ad.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Nov 2025 08:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763570958; x=1764175758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMXsqgKysW6m2FrQa3pYXbUBYKL4TuiIPv4CnNvKLAM=;
        b=N/Z7EAflTrqkSa+dBTG00mPJcJj10qpHqDUcXhnWgiUdD7VA9XqflFc7mZhDTYENhY
         3/fXZrtoxHNjGROS8ZtfNr/Ba1ruzOh2CTr+TLDKy5fsztwK9PTEht9xy82c49hQ/DNt
         0q10JSXzEQpzs3DG61sERP1Z3ikTunZ1v7h0R/PfgUFEXuTGidRdGB+OPeix7nCcz5YX
         HmSReT19XnvcxLHETPaRo4xVHc7LBgAqTmxJsq+5cyHN9AbcybeVUB0MJA2ut4Ajlj2p
         pDu5KTBAeAL2cqWvJ/o4YUD2Uv4TiLGe4cQDhe91tNq/KEVH69zh68lT6zZkmTMoksRC
         yjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763570958; x=1764175758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sMXsqgKysW6m2FrQa3pYXbUBYKL4TuiIPv4CnNvKLAM=;
        b=G64N0pNQ23h3eIN7w8R+OnZ3Dua8nXXKDC3vwEL7E8bnwuC6HNIvvuAl6JsKz1YyGA
         U8UGwP+WGij08HvxqZAX658j5DtbmiB32y4Z5YuObfn4nZHk6IP7Cfk8gQzTSNwmoQDM
         45cZ3IfnW/MOb7jQfXfq1trFvMRduyhSGILHLgK2G8mUXXCMTWTNdpOxHCuAWwnNahH5
         4uB/wnvQraHWZA+g/kO7gUnBc9szzalwhHBUdZYzHY7KS9yKqS8JHW3hsG9vE4SoRzTx
         Iq/lgJk6TDHEzRnJ8NF8ggfbyGS8itfGU9Y9Xb3RBAZS7rDlJMGFk43GNmVJPbiASgb4
         LoEA==
X-Forwarded-Encrypted: i=1; AJvYcCVPFejHsa1IUOuMfm8Mbni8LWVaRdUpDAn0Tway9lq31R7ALluCUyScP14+5RhlbyCcwKPO8deVwhXjV1ycx1c8Dec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqIdhKw7p+i4/le6bYuvCZBfSItp95EmU4mDUDJZNzp0+nUVRd
	6jaz5X4ufZrhk5XUufBDIskdnzG0xrtpHZh1i/UugL96eTDrl3MscAmFH7sruYOfDpwz7ryGflY
	B2etMmTNrxnb9NCfQnQuelfxxXRsbuOajIMbAcBsM
X-Gm-Gg: ASbGnctAyfn9J269wVk55BlTW1mNSTGRYx94ESWKqj+M3Vqc2ZQCyZTBaFFFumhYl3j
	uTzx1AIk6nw+TRrRKK7P949Ewiyylxn8Ta1Itvcjtk714hUp7JAa2too4b3Zvk0GcQEq4MvPBuP
	XsqyXu5vAqtiYu4v3wP64aMruTk2mgQVq1gaub9ry6W8wVmLion+lWK5bbzHaM9PPKLoKazU2RB
	4k1dK9TpAP3Y8UzF2OpzmS7szv+EXo2vSmVc1c9WiVI0/yGvt0QSQoMbaWDyOUblsVrbrT/V+as
	Gcwz9kKpgnu7aeKKholTHheFRQ==
X-Google-Smtp-Source: AGHT+IFwgAnkLR0jx5LdmWn3kQVmzzBqFc3ZBGwWcfrEixV6e2Vn8lfZW5HJjzboKiJOREeEKIkahsDPoO/Vh1R3le4=
X-Received: by 2002:a05:7022:e01:b0:119:e55a:808c with SMTP id
 a92af1059eb24-11c8ddae890mr119358c88.9.1763570957615; Wed, 19 Nov 2025
 08:49:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115234106.348571-1-namhyung@kernel.org> <20251115234106.348571-2-namhyung@kernel.org>
In-Reply-To: <20251115234106.348571-2-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Nov 2025 08:49:05 -0800
X-Gm-Features: AWmQ_bmWEG9oywEpm1PC44iobFk4gdVnk4-eYJda-DCWGCTGZHFeOLwBPXQD-Lg
Message-ID: <CAP-5=fU135iJV72o6tLEBj2GW-uMsQdnnbE=hTAz3rDbmSnBEg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] tools headers UAPI: Sync linux/perf_event.h for
 deferred callchains
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, Jens Remus <jremus@linux.ibm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 3:41=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> It needs to sync with the kernel to support user space changes for the
> deferred callchains.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/include/uapi/linux/perf_event.h | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/l=
inux/perf_event.h
> index 78a362b8002776e5..d292f96bc06f86bc 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -463,7 +463,9 @@ struct perf_event_attr {
>                                 inherit_thread :  1, /* children only inh=
erit if cloned with CLONE_THREAD */
>                                 remove_on_exec :  1, /* event is removed =
from task on exec */
>                                 sigtrap        :  1, /* send synchronous =
SIGTRAP on event */
> -                               __reserved_1   : 26;
> +                               defer_callchain:  1, /* request PERF_RECO=
RD_CALLCHAIN_DEFERRED records */
> +                               defer_output   :  1, /* output PERF_RECOR=
D_CALLCHAIN_DEFERRED records */
> +                               __reserved_1   : 24;
>
>         union {
>                 __u32           wakeup_events;    /* wake up every n even=
ts */
> @@ -1239,6 +1241,22 @@ enum perf_event_type {
>          */
>         PERF_RECORD_AUX_OUTPUT_HW_ID            =3D 21,
>
> +       /*
> +        * This user callchain capture was deferred until shortly before
> +        * returning to user space.  Previous samples would have kernel
> +        * callchains only and they need to be stitched with this to make=
 full
> +        * callchains.
> +        *
> +        * struct {
> +        *      struct perf_event_header        header;
> +        *      u64                             cookie;
> +        *      u64                             nr;
> +        *      u64                             ips[nr];
> +        *      struct sample_id                sample_id;
> +        * };
> +        */
> +       PERF_RECORD_CALLCHAIN_DEFERRED          =3D 22,
> +
>         PERF_RECORD_MAX,                        /* non-ABI */
>  };
>
> @@ -1269,6 +1287,7 @@ enum perf_callchain_context {
>         PERF_CONTEXT_HV                         =3D (__u64)-32,
>         PERF_CONTEXT_KERNEL                     =3D (__u64)-128,
>         PERF_CONTEXT_USER                       =3D (__u64)-512,
> +       PERF_CONTEXT_USER_DEFERRED              =3D (__u64)-640,
>
>         PERF_CONTEXT_GUEST                      =3D (__u64)-2048,
>         PERF_CONTEXT_GUEST_KERNEL               =3D (__u64)-2176,
> --
> 2.52.0.rc1.455.g30608eb744-goog
>
