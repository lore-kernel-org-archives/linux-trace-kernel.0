Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4445183CB7
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722505510; cv=none; b=qpjDlI5lwFJhNVD8OsoFA+soK+LSC4e9msVnh2MLMjRbKMqujAIxE8fZ31GOcA8hqNBVpMLJaw75QlsDvS4IFvm53Xuk2ee/lVUMBL1O18H8G703h3EJDEyQh9u+CHQ6Kgf/wuGrIie6LDr+K1/jMOiA1LD+vsuYipBf8r8dlpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722505510; c=relaxed/simple;
	bh=clgL082mVYG3cRF+MaIMEVHgOzQA3SgdEwqoX1UqzE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4FL+A15CjKKN4xUzZGvjgoD7ncLXe8YsjL/ubjatYA+dKmm/T6F94apY26iK8Sddb/XYb3Sde09zeWRx1fq0of8n/978YW8LrqN4UoC3dKhwNVq88M3N14NEHPwi4jQOQb47nDZFFox5JJwQswP7gQaWESykdZ3QOttgrfXh3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aaaIXQQv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aaaIXQQv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722505507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8qN/79PmuKOBJUmafOXpm7k5iDkosvcOvyIebczVrtU=;
	b=aaaIXQQv3Zqvvp4Eipj/NbG1rAFxwaGpl+MZ3tp8OgqfWUHIQchJyidft38KdJCxwojYpR
	QzBbDsKso9OXXcdwZI5LNad1btrXDNK80Bdvd0jH4gPzJjh2jaokobupZksps0JkdfTs2K
	ITx6TTsUhoHQaQCDDuqVVx2rnZ5oplc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-BNkNF1b9MjKyFZ9ZZngK1w-1; Thu, 01 Aug 2024 05:45:06 -0400
X-MC-Unique: BNkNF1b9MjKyFZ9ZZngK1w-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a77e044ff17so451844166b.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 01 Aug 2024 02:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722505505; x=1723110305;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qN/79PmuKOBJUmafOXpm7k5iDkosvcOvyIebczVrtU=;
        b=S/AxjfeTjGokPdfGKeAA28yrAATUhVO8p/vfoyfj3xX+gAd4X4J6afqzqZoCg1cYFY
         /0dGqx/oxjbTkhQ44579fraDabcli42Eu6AOHCw6PvIY4+taFof++Qjp0zl0KW9QTH7V
         w7oqkREl7EG9vsrEL5VHxu7Nlg+qF0B9oJhw+IF0eKb4wIXMSLXv4iSkNwHTAXgztMbL
         g613WI5hz3S2OlcVjOx7z/8j6KDECErE1GZHg/mrnn/8CyghYZaI0vi2vyroySFM38nd
         oYFOprcmZJrot+8wD65Zi1aSC5uB9OU+KpPABWHPC7Fz8T+jJQgDWOeC4GSQjTqM6ixa
         gGwg==
X-Gm-Message-State: AOJu0Yy5IJEi+G1cqXJCwwa+30m21h0PqbIGYODD44I6QF0OlWqUOjpH
	nkbgINvaWVUvf6K4S9X0WaonlzZFRt6937DYXR1Nv/UP39rnDX+kjiujRjkOIHuiqESvKLXNtGk
	SunfbZQFZAavrlw158O2IjLls2Sxn/30Btd6Qgnodrht1uYeOIezBhCXnAtxnLH0dqtZEYAk5vv
	TnyRffFDOLig5+L9Zzjs+gViwuMmOx/NRrAYC4M266tm8w
X-Received: by 2002:a17:906:6a25:b0:a7d:3617:b5f5 with SMTP id a640c23a62f3a-a7daf659c17mr118178166b.42.1722505505116;
        Thu, 01 Aug 2024 02:45:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUc+aTMM6ixUwEQdBCzdpLRUaysXSjI/S3eq/2DMY+/Pt0yDyS3H3KJApcbfEdivaG3F5DnF7KOO9ht7luUHM=
X-Received: by 2002:a17:906:6a25:b0:a7d:3617:b5f5 with SMTP id
 a640c23a62f3a-a7daf659c17mr118176266b.42.1722505504554; Thu, 01 Aug 2024
 02:45:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731083655.375293-1-tglozar@redhat.com> <20240731083655.375293-4-tglozar@redhat.com>
 <20240731114137.21499fed@gandalf.local.home>
In-Reply-To: <20240731114137.21499fed@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 1 Aug 2024 11:44:52 +0200
Message-ID: <CAP4=nvS08OtNdGdFfVNst09HnZjR6fsoCMPKsbTb-Vey8wyX8g@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] rtla/utils: Add idle state disabling via libcpupower
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jwyatt@redhat.com, jkacur@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

>
> Need to check if the calloc failed and return an error if it did.
>

Definitely, I completely missed that.

>
> Hmm, should this warn if state is not zero and disabled is negative.
>

rtla timerlat hist/top will error out if save_cpu_idle_disable_state
returns a negative value, so I don't think a warning is necessary
here.
```
            if (save_cpu_idle_disable_state(i) < 0) {
                err_msg("Could not save cpu idle state.\n");
                goto out_free;
            }
```

>
> Should probably have a check to see if saved_cpu_idle_disable exists.
>
> > +     nr_states = cpuidle_state_count(cpu);
> > +
> > +     if (nr_states == 0)
> > +             return 0;
> > +
>
> As well as saved_cpu_idle_disable_state[cpu] exists.
>
> Just for robustness.
>

Right, that would help catch some possible bugs if
restore_cpu_idle_disable_state is ever called before
save_cpu_idle_disable_state. The values of
saved_cpu_idle_disable_state and saved_cpu_idle_disable_state[cpu]
have to be read anyway, checking for zero should not make any
noticeable difference.

>
> No need to check here. free() works fine with passing NULL to it.
>

Ah, I see, I need to check that for saved_cpu_idle_disable_state so
that I won't be accessing null memory in the for loop, but not for
saved_cpu_idle_disable_state[cpu], where I just call free().

Tomas

