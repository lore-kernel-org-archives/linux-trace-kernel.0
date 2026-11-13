Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562252;
	b=dI4GKQxeZzl0U5qnlyPful7hvjXoSetHqxgYxuqF8aQ2VaiN7BHqK9HnL9TRYnakgAKj
	 gmyW4Vgzl8vdvx8QLa40XWSOYBqamanJOqD0+yD1plQs0990dZGpMsz0oRc63vEDD3O42
	 mhVNz2IRVHoZYKl/CNOf9h1l3REfc2FFdM+4+sydp1FdBOxoxloZgyV5BheGDQKCwDgSp
	 Su5PTmYc0sChLHLLfpQ9TZFpHzmjYFc+J0BrX9EHuqXf/g6rx0e6SJ0FpfxMrLhIpETb8
	 SM1d/6l1Z0diGhbV6lwHcUL1hlvONVKc5agP+B/kr+/AcR/Q2EpnvvNbfY4svBcCP4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562252;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=d/B3bFcJIpgiK/QVNwmE+oAB6Y1O3QJe1L6ZlDUNHHQ=;
	b=f8ljxN/RVCks3rRD5QGNHVg6EFZHPZKvFgqB/qS8wDaYRisxCQYaFcxflOm+7LTI2ux+
	 3sj6HqUtsvdhTMVN29WCgedIdWmaz/JpuHweF28WQL/fZ6BPt5tQXFflX35Jlr2LHVysY
	 zHF4g67ViEDsmEnCRadCBnjvDyIV0L6tVy4kn/CS039ofqpyfYL7wPfdZohSs1bveO7DV
	 NmS/XJ1PaB1zZY37C7j402dZizP9BykHJMTFqYElVFtv1LjL/tcFlQebt0kvLrEmGFuQ9
	 6j7rqPVNhr1ImiStJ863y2hB6WLTbvYhDJlB05yQsfeqzc29iKLRZrv1pCfxcZHjjRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dhuoKB0t;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEF6606A31C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 09:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DEF6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dhuoKB0t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794562250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/B3bFcJIpgiK/QVNwmE+oAB6Y1O3QJe1L6ZlDUNHHQ=;
	b=dhuoKB0txEpa0lTDDDj/Nx5Mghb27HtayjzVf0dyQSbJLB29a4I5WmAKjOdSJIGwCORJWb
	H4M8pgMnPhhLcn4k+OjkyEEpXAs5sXLxBqkHMXhKtZ5xvCT6EqwWtYaJuEsbmo5gg3aG3G
	0kymkGAi6le9rUfSwkLN94cPc2UrwjI=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-4iEysWl6OCymDRSQgkEoLw-1; Fri, 13 Nov 2026 04:30:47 -0500
X-MC-Unique: 4iEysWl6OCymDRSQgkEoLw-1
X-Mimecast-MFC-AGG-ID: 4iEysWl6OCymDRSQgkEoLw_1794562245
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8b6463f95a4so630469b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 01:30:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794562245; x=1795167045;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d/B3bFcJIpgiK/QVNwmE+oAB6Y1O3QJe1L6ZlDUNHHQ=;
        b=ibA1a1QVtzUXZ5U9R0vJOlRnTsCjPoGWmKh5ThbDE1jd/ilpsJBL2Ek08ZOnJ0TtcI
         URSWlOTtQuT9x1VXsjJ1yWNtu/wYk4HH+d+lEBOik4jE35Os/hkmuunNitqHKYgEhYrf
         QKKeQAd3NhJkgNuHntEVtVvnH0actcViW77OYm0bLLVhCZ5icU6zXwdIaZs95ClaHkwT
         WpU8MvexbLRA6Rz/3lHqL0XgaZva6DG5fBX477VEhpUIChynVLKo6jgMhrxhuQzSgO+d
         E4kmoHngHXdKeKJPHlv95iSi8Q3dso8Tv9mmJ4fO/SWZBcB8b9pRv+3zU24dU+LU3eKW
         anxg==
X-Forwarded-Encrypted: i=1; AL+hErFUIzZVkPxk2Eo5bj2Le2EwW6htzoLMMUuDT+kLx1R2LLrKileGlNrBoDdSkR6y973SFoBo95V3547jozpStFEPTtg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9e7iSyH8qkZfA/BItJKvKPoBCkgr8OMAKfktQvThSfRi7ebJft
	Bu5h96O8si/AydPMG4Ysjx3LfZ4GmEzQqUaXYmIIFpZNFRETab5MRLAncdvIjnmF/CkzUdNmiAd
	RgqWkP1X1+5NDyETjw1fZVkuR5UuvMRJyzcqJ3ZAwN72Y3CUearN76hETY7eot7nWBDKpkZQTSu
	tXSu51eZP3H02KpRXCD5m0+r3TGqX5tVa4nDohe806i33FDWaS
X-Gm-Gg: AYBFou2RKDrAb08QK9oYmFgZOUNkjTuopNfkemCBzCRCvKZIUj9u2TeVvakoBTffBZi
	uBeFy3761oKnBFS414hH7B51Pqw59EHoagAd38mLFdoq1I1ud1Ev771lvopkU+xRqI8+kTqHsFF
	zlGextHR7+3rIR9i4sINC6WDabeCF7laB/HPuwkpDR/Sme7AQT8vHs9cf/lPfv3YRaLyWtvi6us
	VEI59eE7WfD/rY=
X-Received: by 2002:a05:6a00:4191:b0:881:e626:74a0 with SMTP id d2e1a72fcca58-8beb7929222mr1804873b3a.47.1794562245121;
        Fri, 13 Nov 2026 01:30:45 -0800 (PST)
X-Received: by 2002:a05:6a00:4191:b0:881:e626:74a0 with SMTP id
 d2e1a72fcca58-8beb7929222mr1804847b3a.47.1794562244585; Fri, 13 Nov 2026
 01:30:44 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-rtla-mlock-v1-1-418986711b20@monom.org>
In-Reply-To: <20261112-rtla-mlock-v1-1-418986711b20@monom.org>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 13 Nov 2026 10:30:33 +0100
X-Gm-Features: AclHuK_XcAHaq3tn3ZycuByNMRaNhY9m6Xm00lSot4Kx5hwaAAm1rOPSYdVSGFc
Message-ID: <CAP4=nvRQE+GKPT1-KgZ4OgcVV7eKqnkURaELutSMgK4T8YAZMg@mail.gmail.com>
Subject: Re: [PATCH] rtla/timerlat: Lock the memory of the user-space threads
To: Daniel Wagner <wagi@monom.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O-89sRgQ8I8GKlCfdQqpCfV1ur6hVEYGF8rfTImWWXo_1794562245
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 10:26=E2=80=AFPM Daniel Wagner <wagi@monom.org> wro=
te:
>
> With -u, the latency timerlat reports runs until the measuring thread
> is back in user space. Nothing keeps that thread's memory resident,
> so under memory pressure the kernel reclaims its code, stack and libc
> pages, and the page faults on the way back to user space count as
> latency.
>
> On a Raspberry Pi 3 (PREEMPT_RT 6.12) under stress-ng --class memory,
> timerlat reported up to 40 ms for the user-space threads, which took
> 283 major faults, while the kernel threads' latency stayed below
> 1 ms. cyclictest under the same load: 133 ms without -m (mlockall),
> 0.9 ms with it.
>

Yes, this is a known problem. I have just not seen the timerlat user
thread faulting in practice, maybe because I use rtla mostly on
servers with an "absurd" amount of RAM. Or maybe I just have not
noticed it yet.

> With this change timerlat reports 0.9 ms for the user-space threads
> under the same load, and they take no major faults.
>
> Lock the user-space threads' memory before they start measuring, as
> cyclictest -m does.
>

Thank you for measuring this.

> Signed-off-by: Daniel Wagner <wagi@monom.org>
> ---
>  tools/tracing/rtla/src/timerlat_u.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tools/tracing/rtla/src/timerlat_u.c b/tools/tracing/rtla/src=
/timerlat_u.c
> index c80edaf07b00..42aaf1d7f216 100644
> --- a/tools/tracing/rtla/src/timerlat_u.c
> +++ b/tools/tracing/rtla/src/timerlat_u.c
> @@ -15,6 +15,7 @@
>  #include <pthread.h>
>  #include <sys/wait.h>
>  #include <sys/prctl.h>
> +#include <sys/mman.h>
>
>  #include "common.h"
>  #include "timerlat_u.h"
> @@ -69,6 +70,15 @@ static int timerlat_u_main(int cpu, struct timerlat_u_=
params *params)
>                 }
>         }
>
> +       /*
> +        * Keep the measuring process in memory: the latency it reports
> +        * runs until it is back in user space, and a page fault on the w=
ay
> +        * (its code, stack or libc pages reclaimed under memory pressure=
)
> +        * would count as latency. cyclictest does the same with -m.
> +        */
> +       if (mlockall(MCL_CURRENT | MCL_FUTURE))
> +               err_msg("Could not lock timerlat u memory: %s\n", strerro=
r(errno));
> +

Can we make this opt-in, gated by a -m/--mlockall option, like cyclictest?

We can add it as a boolean field into struct timerlat_params and pass
down to struct timerlat_u_params. See e.g. 2ff4464e3283
("rtla/osnoise: Add IPI tracking cmdline option") for reference.

>         /*
>          * This is the tool's loop. If you want to use as base for your o=
wn tool...
>          * go ahead.
>
> ---
> base-commit: ee83899302a0457a3ba47464a13e8682bd7ba27d
> change-id: 20261112-rtla-mlock-2a572f10533e
>
> Best regards,
> --
> Daniel Wagner <wagi@monom.org>
>
>

Thanks,

Tomas

