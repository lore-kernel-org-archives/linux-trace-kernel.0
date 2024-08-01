Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF81170A0A
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Aug 2024 10:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722507650; cv=none; b=t5JkY14UO5OtqfCxq2g6wtYTds4MJc0f0Jek3KmwQSMtV8EctHOpxrUd8KQcqPM/87lst3Sy1IaeiM6dEuw//HZfXnwCECYQ2uHOOOXVOsZdIUlVJqqXiZCA4hYNaYleI75iIzREieH/ZX7/hGSYrr9KFVqXsh8oKAL6z4wCwwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722507650; c=relaxed/simple;
	bh=4qh2nmM/EexeuHVq9VR3ZhNY+D/o3BBt1yZ6uIKW0iQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kMa1Wgm6JNpsi/rQlpQbC7fAXMLGTNaKhoHzksNhifmF4bHC1m/4mplEU9BAR8DxWB/1tYDpGQ/1mHt9gFTDWSOYb2HTBzdaqtBdamRqOBXAPWXYQjx4Y/oVOExSb1SZ9T5yQJyT4ldozdAZPR8GJSWC9Fr9BTTzD8zL7//OQpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gr5Sor4O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gr5Sor4O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722507647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Ryj/byZM4/CkBZhyM4lK7iN6hcD1ezI3JrBfHWgefU=;
	b=Gr5Sor4O0LlGjobpaED4f4+Ecy7pXtfmKz0IThRaMcOduwtRnqCfWh87/yLa4HV71oequ9
	0BNQqwo5fweLG3R9dPuSPK2wcnfbvwnwVC/TvDtbZRhFl4AHWCGbKYNF+/ed9BWRHlwPL9
	PGmeBJuijW5Pjd8TuOZeXHWqP8NoLsk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-BeFaY1xEMES-S_RyBACk3g-1; Thu, 01 Aug 2024 06:20:45 -0400
X-MC-Unique: BeFaY1xEMES-S_RyBACk3g-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2f14b6f64d3so22807701fa.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 01 Aug 2024 03:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722507644; x=1723112444;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Ryj/byZM4/CkBZhyM4lK7iN6hcD1ezI3JrBfHWgefU=;
        b=BLqEVD1YWcbjPfK9LkqH1oPSVtGSsHeINI4xcgIx7zohWrvrY0H4ysiBgnCnAyp6b0
         BGP8JgNMDzRCPEhpD9vYdUOXVIL7ds/lU19BU8P0fveGpqHh4cxnMSt23R7aHLxAkfFA
         5P6pTBW+x+eucuZQoBJiElsrTbGZd7fd4gdEpPTU7zc0/PajjNmUZu8ZIsohgTtuCSlh
         ZZr682NCYbiOSf+FoZedtPVP4A34aVwNIXzpoQ8McHryvAlBjuHFQofT6NumfKjgUjFW
         5L4a60G3Mvcs2wa78imml0FWTRBWhRQYEK9RlWjucX/eaUf+Iy2pWBj1espyG+JNCO5N
         gR4Q==
X-Gm-Message-State: AOJu0YwmIPp4G1Gu5m7YXAh94ZYH/837K6FsDhYkAayZq1s+1NAawW/G
	7zER3Cwmcp8On3k04ald22KLMYrjTp223d5xnzcQdsYoM6KTgYbtYVlivUd5plTPcrLr4Wr4O3D
	ETg0hz0EXq3tBbbfrJgJORqxWDg7ojrIEPX++QtBC2wNsH0UFpS/p1y460gJwY0sI5WqYH0DgIH
	XAjCsLB0iDi+aQnXtUF++EwETF68j8JhMRjQybHeQqZAjs
X-Received: by 2002:a2e:3512:0:b0:2ef:251f:785 with SMTP id 38308e7fff4ca-2f1530d391amr14052721fa.1.1722507644125;
        Thu, 01 Aug 2024 03:20:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFedGze0XoV3r6eGI/EkC+bRZ26eUIKglkquRK2Ld+t5vx+Ab5czWpQjolrImbSl5+Ok4MZwWvBYtvbBdCIsyw=
X-Received: by 2002:a2e:3512:0:b0:2ef:251f:785 with SMTP id
 38308e7fff4ca-2f1530d391amr14052441fa.1.1722507643480; Thu, 01 Aug 2024
 03:20:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731083655.375293-1-tglozar@redhat.com> <20240731083655.375293-5-tglozar@redhat.com>
 <20240731115222.21e99427@gandalf.local.home>
In-Reply-To: <20240731115222.21e99427@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 1 Aug 2024 12:20:32 +0200
Message-ID: <CAP4=nvRnaM6ViT6t67prij+DLBso+0DB971G7ke+7OqEkPQpig@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] rtla/timerlat: Add --deepest-idle-state for top
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jwyatt@redhat.com, jkacur@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

>
> Could probably do:
>
> #ifdef HAVE_LIBCPUPOWER_SUPPORT
> > +             "            --deepest-idle-state n: only go down to idle state n on cpus used by timerlat to reduce exit from idle latency",
> #else
> +               "            --deepest-idle-state n: [rtla built without libcpupower, --deepest-idle-state is not supported]",
> #endif
>
> >               NULL,
> >       };
> >

I would still include what the option does, even if not building with
libcpupower. I'm not too sure if the help is the place to say the
option is unsupported either. I see two perspectives on this matter:
one is that the binary does not support libcpupower and should state
it in the help, the other is that the version of rtla as a whole does
support it, you are just using a build that does not, and as such it
should be in the help (you will know it is unsupported when trying to
use the option). I suppose we can add a note like this, keeping the
help message to inform the user what the option does so that they will
rebuild if that want to use it:

```
#ifdef HAVE_LIBCPUPOWER_SUPPORT
             "            --deepest-idle-state n: only go down to idle
state n on cpus used by timerlat to reduce exit from idle latency",
#else
             "            --deepest-idle-state n: only go down to idle
state n on cpus used by timerlat to reduce exit from idle latency (not
supported due to rtla built without libcpupower)",
#endif
```

What do you think about that?

>
> We could get rid of most of the ifdefs if you changed the header file to be:
>

That's a neat idea, thank you! I know this approach (with defining
functions that do nothing when some feature is unavailable) is very
commonly used in the kernel to keep the API consistent across
different configs, but I didn't think about using it like this here in
rtla.

>
>You would think gcc may optimize it, but I don't have that much confidence
>it can or would. You may want to change that to:
>
>                int nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
>
>                for (i = 0; i < nr_cpus; i++) {
>
>Otherwise you may be calling that sysconf() for each iteration of the loop.
>

Nah, that is simply an oversight. If GCC optimized that, it would be
in fact a GCC bug, since the value of sysconf(_SC_NPROCESSORS_CONF) is
external environment and can technically change during the runtime of
a program (think of CRIU live migration of the process from one
machine to another with a different number of CPUs).



Tomas

