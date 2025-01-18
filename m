Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34445136658
	for <linux-trace-kernel@vger.kernel.org>; Sat, 18 Jan 2025 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737185084; cv=none; b=FAgZzPz+nrvMtHycC3mU4juF+UsyYkPhDWNQnue9e9lOaZZL4ZXm6k2wJHh2g/UZv/H8L0zW6p1/+XWhoidQFPSLugQJLEmSu2pdlLo54mp/hgNcDGZLaCfD66pljYOTCmCv3aHmPak/JrAoFaRKNXIZfYHwfH9c5AJ3F1Jw5E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737185084; c=relaxed/simple;
	bh=KhUjOsUtKjZxVWEAfpaUIwtDFofgniDpgtWv9gaFW9k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PyQvjhYsd4yTbmy6iG0SBW+q8gXc3629EG2qcQbMDBqwddd/Q/sxnvXG1VpLhjUAZ93t3P+N3nVv57HYUgJ/KKNU/sh0LRId9LkXwKnkYbndOrwkPPtvcFOAHcNrYGHciMMg5nnxXwOYBO5jzDmDn6q0g/yXzTMPUFAV9yQ5fUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E1DgqX9V; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E1DgqX9V"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2162f80040aso51467085ad.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jan 2025 23:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737185082; x=1737789882; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=940iCcxpvzyGM4mZVRnuDDdVwqFoEWjVZnkzqluQF6M=;
        b=E1DgqX9VJM+cBK61JImc+P+ytlAmeu6p1geXMRMle6+IXrt7rjhnf6XPoKkHKw5sSc
         OGQlvBsxa0w9cC7jdSPKM0m1xc6UzzDLmiwo294/zkQzC5prsYxQQ8UD/Nu5+VuXXUoz
         2FwcGnmDQbx3vuvQz3oIO3srbl2PU1dm3U/dDayNudZJV4tq7ur5fkilttYHdy6IPm53
         /LvNcmgItHrr78d6sgfHyGx7oTobTvifdiuc5LqSaFpMOqaQfYKFfu8eYn7UB2aeAMCJ
         J2rEx6/RE2ZZ+A+AU1eWSJEdzf+U0OVhzchpbUMDoug0+Uxj0qv5ovO0wteyIYkkvzEk
         9zCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737185082; x=1737789882;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=940iCcxpvzyGM4mZVRnuDDdVwqFoEWjVZnkzqluQF6M=;
        b=t76hwHUeudZgWgf1JuhhRm9lnYsNmHL5s9dzXJ9ve6/oxn71cx0cMghpn2ZNK0obk1
         xAe1z8Ls0YRXkO4hX3bxLhDts4mNqxelfYC7Rir87bV181PXg8NNVsfLbRD9AgaKpAwE
         aTMrAL4Ofhe1G8hLrf3gztxKEQ37SWF8z9944kgrdK1CtZJCqYHpcoN+Xyqc7Sdl9+mV
         YMM3prI+vNz3WF5jgwNb5TppksutmyQYQxgl0qti1BztAmSI7CKMZwt1mKm27jXByvlN
         Dhlmb69gxBgX+Pla4kEBp3w13PDtcG8kYrt6nHiqL+bPQvkKpkgmFA1xq468X0B07pC3
         s4mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXt0RsQq6mBiSQd8vClbu6ZfoCkU9pHsyKkza+vhoXeWLol4ZdJi3Gatcj9UEFQs5N0IHq5+ePbKFSpc8Y1p8bTRKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS3Xz/auTpjWFNv9yRJw7vVBVmBSRiuzW85djG6ru2UZfuXGsa
	x8tPCVvUT8Q0eszoFr5VAtsHEBqeKtN3tQZ240LqQHsk+Xlmdwq1S6duzbm0QzFgdA7JaA==
X-Google-Smtp-Source: AGHT+IEIBAeQmO6MGQcNwnYFn8SkrDPGzn+XCE5f7u+ZLY2Fni10ILvoUB2qzb6E+YF/skiDhuyrjNMG
X-Received: from pgbcs4.prod.google.com ([2002:a05:6a02:4184:b0:801:cdbd:2727])
 (user=keyz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:f29:b0:1e3:e77d:1431
 with SMTP id adf61e73a8af0-1eb214da830mr6276082637.23.1737185082483; Fri, 17
 Jan 2025 23:24:42 -0800 (PST)
Date: Sat, 18 Jan 2025 15:24:38 +0800
In-Reply-To: <20250117105132.4122940b@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250117105132.4122940b@gandalf.local.home>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250118072438.3647805-1-keyz@google.com>
Subject: Re: [PATCH] cpuidle: psci: Add trace for PSCI domain idle
From: Keita Morisaki <keyz@google.com>
To: rostedt@goodmis.org
Cc: aarontian@google.com, daniel.lezcano@linaro.org, keyz@google.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, lpieralisi@kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rafael@kernel.org, 
	sudeep.holla@arm.com, yimingtseng@google.com
Content-Type: text/plain; charset="UTF-8"

Thank you for the review!

> Why not make that into two different events:

> +	trace_psci_domain_idle_enter(dev->cpu, state, s2idle);
> 	ret = psci_cpu_suspend_enter(state) ? -1 : idx;
> +	trace_psci_domain_idle_exit(dev->cpu, state, s2idle);

> Then make the above into a DECLARE_EVENT_CLASS:

> DECLARE_EVENT_CLASS(psci_domain_idle_template,

> 	TP_PROTO(unsigned int cpu_id, unsigned int state, bool s2idle),

> 	TP_ARGS(cpu_id, state, s2idle),

> 	TP_STRUCT__entry(
> 		__field(u32,		cpu_id)
> 		__field(u32,		state)
> 		__field(bool,		s2idle)
> 	),

> 	TP_fast_assign(
> 		__entry->cpu_id = cpu_id;
> 		__entry->state = state;
> 		__entry->s2idle = s2idle;
> 	),

> 	TP_printk("cpu_id=%lu state=0x%lx type=%s, is_s2idle=%s",
> 		  (unsigned long)__entry->cpu_id, (unsigned long)__entry->state,
> 		  (__entry->s2idle)?"yes":"no")
> );


> DEFINE_EVENT(psci_domain_idle_template, psci_domain_idle_enter,

> 	TP_PROTO(unsigned int cpu_id, unsigned int state, bool s2idle),

> 	TP_ARGS(cpu_id, state, s2idle),
> );

> DEFINE_EVENT(psci_domain_idle_template, psci_domain_idle_exit,

> 	TP_PROTO(unsigned int cpu_id, unsigned int state, bool s2idle),

> 	TP_ARGS(cpu_id, state, s2idle),
> );

Looks good. Let me apply this change in v2.

Thanks,
Keita
