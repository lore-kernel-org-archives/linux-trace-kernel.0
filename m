Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF415304BA0
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824930; cv=none; b=J77a0DfSd/YsV6tgtbXzuZniZ6B5JcP5sc+JWJ+6xt4ETZzqPy8XjubZwM55ko9MIIzsyCDBRZXtT2UvwNc5LBkpsAFl3t1IV0HtfhJMbBrP5OXyeP8fjhx8ud+w2xoGqE5CAUiTtlmDKjTV8eedQRwM0A+ZLnfQMUj3RuXv/T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824930; c=relaxed/simple;
	bh=x91AmagGFMOtZuXmG4RqVXoVp9qcPc0XFnUmaJ/YIm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=n0jxMJMixeqH+OB6z+aQ5P9ecflGhhBrHL+wKdJql54moAwGpry4rdTXKElMYLM3O45HNtE+wb97Z5sWZaYwierjPLUBlHFYSprjQPDtHM9/2vBvN3SpvjVR8vzmKZHrCIL4KMHt6IT52aTN91yMv1j4o1qZpd7squ4Oy7k//D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Afo+AjW7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Afo+AjW7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756824927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CFNwloMDDAvR9YVWd6AQKio0WoX59cEAVHNiSQ9F17k=;
	b=Afo+AjW7uZS0t2Els172C8Kw8RYiGgQWHylowF2HVt4+j2hEYKCIZ69eD7gGJnrKDXABoP
	5tl/oyerjUIptNJnp8QNHXL3lL7iQ6PaqPZy/+L1rMzWfOMQEcMx3bN4Wpe4kfbpWxc4VR
	cqRbtotiiCsqixqwGkeeoekUnbXPVl4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-8D1I5ZDfP9KaOKlg1J79AQ-1; Tue, 02 Sep 2025 10:55:26 -0400
X-MC-Unique: 8D1I5ZDfP9KaOKlg1J79AQ-1
X-Mimecast-MFC-AGG-ID: 8D1I5ZDfP9KaOKlg1J79AQ_1756824925
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3d17731acb6so2937378f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Sep 2025 07:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756824925; x=1757429725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFNwloMDDAvR9YVWd6AQKio0WoX59cEAVHNiSQ9F17k=;
        b=xARrZHw7fXl16ecvua3e1y7HSvqMpXmkNmy2jqdjTPnwh87ZcIHCr+jnlF5wE6+2fF
         u8bucCapOLG32+Lz3eWFoPZHIcmko9FD9qHaG1UGZQhWzhLbViPlVWSWrg3kxrzLpexT
         6r8YKLtQVzljC/kZhlUJNjBF3RzLzkuKjy493sjzFiGgrcCnuC1FDD1esyofmo+dFsBS
         0NgCTmet+DdUUjW75e+DTIl0p/xCQAOIxPue/Vnmtl0iq6x7Rjc0RFmfTHWtQdryqYEr
         O1zhzJpFP1jI0u6FJZL+GvZ1BDRjqnjbr5/OI77UdXIeXpw0yR/gSsFQJGpfuqW74LkK
         8zvg==
X-Forwarded-Encrypted: i=1; AJvYcCV8zNwBExeSuwjpIAomlLokFiP+QvLEGBqDbALxQTrK8/c6FhP/3nc5BfcP2FluHMF5eR3cio95h96kNWEYl9gbNWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrtMKjdERn8Q82m3G+4AtneSZzOVdvgcEIwsPDxvbq1VxvGHSq
	isF+LJcqDZVvaakG+ZpJKBMQYPim75xh/YMGFSzivur9UPwlvkkGw/X/tG1Xrf2SahyT1fk/lxC
	HQUdUmKvjZZci63zhfQ+H3Rid0MiH+fJkgp5EdMv55++PunDZKh4QU1jklA6422k+JsWt4vm9Uw
	==
X-Gm-Gg: ASbGncudIAy0opYnj1ypLToC639K/xncArv3LM+55VxtGiPd2JkFckuc42XBH4QIO0/
	A9Z2yRBvQV/VpH6mb9TEfoblgzH8YANyAyHTRCD7XgyeqM91nzUWcz2X1jv0fWqLeLxR/tIFdsK
	Q09c+/+LfyKaqCZjGoT6zkJXHXqmEN9JQH0CfM85uNcXcpdIT5oZdox+foJb+4xuqzhH40kY3Pb
	TjZP1jkWPt3qPbIfac24dB4/JzlFz+5rMdhp6UvVAK4Yyq49GEALjjzLYAe5umA2D7FIlv8lRnp
	dLmJB9Xaq79IZAPKGY9bHgp29JcgsCOAQZbkulupAFGCb7G39SaSE6ZriG4Yqm2HeafxcB0=
X-Received: by 2002:a05:6000:18ac:b0:3d8:3eca:a9ad with SMTP id ffacd0b85a97d-3d83ecac1femr4388491f8f.20.1756824925383;
        Tue, 02 Sep 2025 07:55:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr+eQvFvHKDY9pW1QWHP+fNzpn5umUflMtRnLW1mu9VwW/LAlTg4kdk2oVrowt/ttwr680hw==
X-Received: by 2002:a05:6000:18ac:b0:3d8:3eca:a9ad with SMTP id ffacd0b85a97d-3d83ecac1femr4388298f8f.20.1756824922871;
        Tue, 02 Sep 2025 07:55:22 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.70.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33add294sm21363639f8f.29.2025.09.02.07.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:55:22 -0700 (PDT)
Date: Tue, 2 Sep 2025 16:55:20 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, linux-trace-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 14/17] sched: Add deadline tracepoints
Message-ID: <aLcFWBGfeET6_KuO@jlelli-thinkpadt14gen4.remote.csb>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-15-gmonaco@redhat.com>
 <aKRKaTJBxD3kdt_G@jlelli-thinkpadt14gen4.remote.csb>
 <20250819101244.GF4067720@noisy.programming.kicks-ass.net>
 <711ff45f008bb4943418c40eba604e83858767ff.camel@redhat.com>
 <aKSD3Pm_9qqmEaNv@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aKSD3Pm_9qqmEaNv@jlelli-thinkpadt14gen4.remote.csb>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bfOu3il8W0RORvq6Ru1JG7U-F_AVZatnt2Jrw7Ti4Ak_1756824925
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 19/08/25 16:02, Juri Lelli wrote:
> On 19/08/25 12:34, Gabriele Monaco wrote:

...

> > > As per the whole _tp() thing, you can attach to the actual
> > > sched_switch tracepoint with a module and read whatever you want.
> > 
> > Yeah I believe Juri referred to model constraints on the already
> > existing events rather than new tracepoints here.
> 
> Separately from this series, maybe we should put such a module/bpf thing
> somewhere shared, so it's easier to use it when needed.

Maybe we could

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 383cfc684e8e..994b6973d77d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -117,6 +117,10 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_throttle_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_replenish_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_server_start_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_server_stop_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
---

so that the new tps can be used from modules like sched_tp Phil
mentioned?

Thanks,
Juri

