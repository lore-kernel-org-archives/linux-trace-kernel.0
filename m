Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBAE397B03
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593844; cv=none; b=OMkWLeWJhG1o4WMB70sPp9LldqfdPFW/oogaVeNXC6Fv+uZEAoRIR4CMjKfbIcVKpqS7WpzRY3sbihS6tUTlibfLw8pjzLhJ7SuB6Y8YoiTHCS4D/oF0OP9jOoECbdtqYvIA5//zARg+LYgRAQ2Ay7QcgUHkCUTy6Y04WNv4IqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593844; c=relaxed/simple;
	bh=hPoXuoFl/vaYuh8BDQyavsGzZfawPITD4eNEZJetS6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SpeSv/cTuVRVUBpZjR3bZ7Bg08IxpEOuyQolzxpaC9YZPXxIiZrEis29cULnCZoNGa3FKAzl2CXtaAqUf1ybp4TADAdykW2IWV4tcqfR6Zh47UDhWQ5Tb1MdezcyAQEMz8BC/+YE7eknJE5vzJxthF+FUlo7rIar36RYhfWbazQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y8pytPJB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y8pytPJB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778593842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XuNggr069CCi+WGH9I3+DQfxambtv+LBKZiD2flVRqc=;
	b=Y8pytPJBL3lk92wwH0Y5WTjXyEVhubUZ5KPiYvNhX/diSxTUOpKXNt/Agp0cSKmRysKvdn
	OqHDvdC/WZdYv6tMta4BTuManRmITDiU50hHJVJLfirnGoxfSs/YtjiMZAtn9C/HRY0Ddb
	Zd5mLiEGeAQYKXN5oRIVFaD9QPSTdlQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-9B_nymbONDy-JyblV28Ndg-1; Tue, 12 May 2026 09:50:40 -0400
X-MC-Unique: 9B_nymbONDy-JyblV28Ndg-1
X-Mimecast-MFC-AGG-ID: 9B_nymbONDy-JyblV28Ndg_1778593839
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b8fa5744b82so603008966b.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 06:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778593839; x=1779198639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XuNggr069CCi+WGH9I3+DQfxambtv+LBKZiD2flVRqc=;
        b=AAMouqbuxbPqBdySN+frlYHCwiH+xnqhsOrM99z7rBSkepgIBE2H8x2Ka8HrBDs2Z1
         +ZKzZXRkllqVvGQuOzL5/B/SXiUb/MCIBjP2/kKAF4vjPENxJlVWmLhD7gweXGpLec3l
         3ywX3X9hew+vDW3hvCQDgDvOzXMg++tHArR4xz4gO7H8QLlBHwqxiwGtD5bXBfBxUfsZ
         6rxhF8xDY9VNU7X7n6rdMiTZzw0Tgv7Jcp4yqQQgn5EvaBiBX2euhyfxKKrLBBWzMCRz
         JaKkO3Zs5dYLExEJFXRl9rkHk8BrItKbqw1WMCO+ZHV9gJtP0Y3tlOc3NcVOoHkxVFaB
         +/Mg==
X-Forwarded-Encrypted: i=1; AFNElJ+DwkJysDYPidrbGNaoQUHLrEJ5gZLep1nqQVrdVMfRaP/PLnRrHyQ/qsjFb554t8Q+wGJzsYap/D/lmIBhk1Oeph8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVjOANyK+/KNAJQSK+siQMhgVtnjbfNoZ3iIpHPo81hARjYH2Y
	nGlFgzfDmVUuweLYiQONcM7f1Cvq1tsdW1GPMqqKpftPSr8kJ2iVoJms5zYFXlckOoLwYXcuVwm
	92MT8xHkbwzwltVrXiIpUzFniwRI3LnZmzVnRWLnY3FiluIbctEC8jcIDQeCIEIogRzpQ7CrfIC
	Fdgx3bw82A983htD5Yl7pcyDOZrMAiak/tlq/lYyRH2y/luEvm+khGdHg2uGY=
X-Gm-Gg: Acq92OFhdc6sXqRbA/xHX8sd5NpvyXa8D+qQW1jWDTeUIUx1AvWZeVlMhvc4vpgmf9l
	6j6EyvagnmG5AoeQ8t2npkqnx4CaxI5WnHpFwxImatYgbP34bzXL6wHCCwdCgLeW8dWw5InD22S
	D4gpZuKGylkhIuxldj7HJRIy9lbHXMeSjmqrHbj6b585FzAirqkBXu3O+afmC1quEDfQgRakVZ/
	Yb/ww==
X-Received: by 2002:a17:907:9404:b0:bcf:5de8:567f with SMTP id a640c23a62f3a-bd28f29e744mr213036066b.28.1778593839041;
        Tue, 12 May 2026 06:50:39 -0700 (PDT)
X-Received: by 2002:a17:907:9404:b0:bcf:5de8:567f with SMTP id
 a640c23a62f3a-bd28f29e744mr213032166b.28.1778593838429; Tue, 12 May 2026
 06:50:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511223509.1483323-1-crwood@redhat.com>
In-Reply-To: <20260511223509.1483323-1-crwood@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 12 May 2026 15:50:27 +0200
X-Gm-Features: AVHnY4L5dTdHoculUf6x1pNWemMvjRXZhQbx4C0xzZ67cYh5AXvyGKJhygXI6fI
Message-ID: <CAP4=nvQEnCG2vabuA52p3bmGo7f1_-pZJ2b6rr5N=bKmaBuqxg@mail.gmail.com>
Subject: Re: [PATCH] rtla: Stop the record trace on interrupt
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aBf7zwXROOO2nA6RpKQ1yZ7QSkOZPDrJzb_KN0_Tliw_1778593839
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 12. 5. 2026 v 0:35 odes=C3=ADlatel Crystal Wood <crwood@redhat.com>=
 napsal:
>
> Before, when rtla gets a signal, it stopped the main trace but not the
> record trace.  save_trace_to_file() could also fail to keep up on a debug
> kernel -- and in any case, it adds post-stoppage noise to the trace file.
>

This affects only the "new" (since 6.19) --on-end trace option, right?
The regular --trace/--on-threshold trace should already disable the
instance in-kernel, as timerlat disables all instances set to the
tracer on stop_tracing threshold.

If so, that should be reflected in the commit message.

> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
>  tools/tracing/rtla/src/common.c   | 19 +++++++++++--------
>  tools/tracing/rtla/src/common.h   |  1 -
>  tools/tracing/rtla/src/timerlat.c |  2 +-
>  3 files changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/com=
mon.c
> index 35e3d3aa922e..effad523e8cf 100644
> --- a/tools/tracing/rtla/src/common.c
> +++ b/tools/tracing/rtla/src/common.c
> @@ -10,7 +10,7 @@
>
>  #include "common.h"
>
> -struct trace_instance *trace_inst;
> +struct osnoise_tool *trace_tool;
>  volatile int stop_tracing;
>  int nr_cpus;
>
> @@ -21,12 +21,16 @@ static void stop_trace(int sig)
>                  * Stop requested twice in a row; abort event processing =
and
>                  * exit immediately
>                  */
> -               tracefs_iterate_stop(trace_inst->inst);
> +               if (trace_tool)
> +                       tracefs_iterate_stop(trace_tool->trace.inst);

Can this condition be ever false? The signal should be attached after
trace_inst is initialized. Of course, it doesn't hurt to have it there
for safety, as long as we keep in mind that it does not protect from
the trace instance being freed (which should be fixed by commit
be8058f31b4e already).

>                 return;
>         }
>         stop_tracing =3D 1;
> -       if (trace_inst)
> -               trace_instance_stop(trace_inst);
> +       if (trace_tool) {
> +               trace_instance_stop(&trace_tool->trace);
> +               if (trace_tool->record)
> +                       trace_instance_stop(&trace_tool->record->trace);
> +       }
>  }
>

Otherwise this makes sense. The reason for doing trace_instance_stop()
in stop_trace() and not waiting for cleanup is that in tracefs mode,
the loop would get struck in tracefs_iterate_raw_events() if it cannot
process the events faster than they are created (see commit
c73cab9dbed and a4dfce7559d respectively). But it can cause a
discrepancy in the trace output, as you point out.

>  /*
> @@ -273,11 +277,10 @@ int run_tool(struct tool_ops *ops, int argc, char *=
argv[])
>         tool->params =3D params;
>
>         /*
> -        * Save trace instance into global variable so that SIGINT can st=
op
> -        * the timerlat tracer.
> +        * Expose the tool to signal handlers so they can stop the trace.
>          * Otherwise, rtla could loop indefinitely when overloaded.
>          */
> -       trace_inst =3D &tool->trace;
> +       trace_tool =3D tool;
>
>         retval =3D ops->apply_config(tool);
>         if (retval) {
> @@ -285,7 +288,7 @@ int run_tool(struct tool_ops *ops, int argc, char *ar=
gv[])
>                 goto out_free;
>         }
>
> -       retval =3D enable_tracer_by_name(trace_inst->inst, ops->tracer);
> +       retval =3D enable_tracer_by_name(tool->trace.inst, ops->tracer);
>         if (retval) {
>                 err_msg("Failed to enable %s tracer\n", ops->tracer);
>                 goto out_free;
> diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/com=
mon.h
> index 51665db4ffce..eba40b6d9504 100644
> --- a/tools/tracing/rtla/src/common.h
> +++ b/tools/tracing/rtla/src/common.h
> @@ -54,7 +54,6 @@ struct osnoise_context {
>         int                     opt_workload;
>  };
>
> -extern struct trace_instance *trace_inst;
>  extern volatile int stop_tracing;
>

This is removed as it is not needed now after the consolidation I
assume, since all users are now in common.c? That could also be
mentioned in the commit message.

>  struct hist_params {
> diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/t=
imerlat.c
> index f8c057518d22..637f68d684f5 100644
> --- a/tools/tracing/rtla/src/timerlat.c
> +++ b/tools/tracing/rtla/src/timerlat.c
> @@ -202,7 +202,7 @@ void timerlat_analyze(struct osnoise_tool *tool, bool=
 stopped)
>                  * If the trace did not stop with --aa-only, at least pri=
nt
>                  * the max known latency.
>                  */
> -               max_lat =3D tracefs_instance_file_read(trace_inst->inst, =
"tracing_max_latency", NULL);
> +               max_lat =3D tracefs_instance_file_read(tool->trace.inst, =
"tracing_max_latency", NULL);

Not sure why this used trace_inst instead of tool which is right
there, maybe again refactoring of the code?

>                 if (max_lat) {
>                         printf("  Max latency was %s\n", max_lat);
>                         free(max_lat);
> --
> 2.54.0
>

Otherwise, LGTM. You can also add:

Fixes: c73cab9dbed0 ("rtla/timerlat_hist: Stop timerlat tracer on signal")
Fixes: a4dfce7559d7 ("rtla/timerlat_top: Stop timerlat tracer on signal")
Fixes: 3aadb65db5d6 ("rtla/timerlat: Add action on end feature")

as this fixes two bugs, one with the post-stoppage noise (that is
present since the trace_instance_stop() was added), one with the
save_trace_to_file() not keeping up (which should be since the
--on-end option was added).

Tomas

