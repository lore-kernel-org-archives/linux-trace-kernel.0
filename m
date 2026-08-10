Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDBC3AD531
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 11:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786361082; cv=none; b=AtQoXyUVPjd6+OyUWyukZ311GXxs2cLqbLTPskeAWNo4LLn/Pw9FSsjwvNWCxcq0d26qBv+M/hLd3k2jlD8JzEt0MvnbLTZSZ9PAVnD6+FvWTqnBSe38DMXpHQRuV+icY/cO73xt+kLrWd3trHJ2suM80o98DSXMGSaT30JpnNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786361082; c=relaxed/simple;
	bh=rG67YPN+IQ5GxEVD1Z4vUKW1Q+j0I4W36HtCEZiYrFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oerSYNN/MGYElX2aVsuNX5lXPUZFCIxPvSIjg5FWv4nUMuzYdthCip43mH2DsFpZHkgRkWGbNMTzvj5fGT1ZJeCFnVVlyWscC5JY9sZo6AL6Ib0d0lVruqAK1zLnO0qQ+fjZJHRuEoUbmHCxn21pc7pJsWSB0ZCwWcrV5HxUwt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UGrMuy0g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGrMuy0g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786361079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q05k14Mr9qmCMQ3puKkSxPe4tNYbeR0j9ln7xMTVYYE=;
	b=UGrMuy0g1jfZJsD2mh+Ub5352gNlyae46kzloclE+Krr8uOrVzl+lSwy0mOOctXviyOOy3
	pXDagfmYDw/QjMar1dywK7Dkn39YY1ydYMcU4fGlG8cLMCaDRdTbD3Qm9joYm082WYXsXb
	iiiytjb7UfGOjZw+0JowfIf0klhiVyg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-f2LCu9cjM0SPs0dowE92DA-1; Mon, 10 Aug 2026 07:24:38 -0400
X-MC-Unique: f2LCu9cjM0SPs0dowE92DA-1
X-Mimecast-MFC-AGG-ID: f2LCu9cjM0SPs0dowE92DA_1786361077
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c1f74261f67so161895366b.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 04:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786361077; x=1786965877;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q05k14Mr9qmCMQ3puKkSxPe4tNYbeR0j9ln7xMTVYYE=;
        b=UakZDL29fGIU/LQZ4HlVdrYQqSAlt5/wlIjxCnhQKcyfXWBXDCk1/dHBvwXNd+4PaC
         P/fJxeEG884ir7etlKY9iHJutqqofzUKDLd3Uz7NeKFI9FFkg/BbyoaA9ILaTy8TvVKA
         zppGHQOyYEo1rffkM4iL1xmIVE+xVWWkwu53a4lsV/8N4FmieIWD7Nt3E9znadlDluhA
         T6DX8AG2h1IzU+ioaWlbeVdVxbKcbB2lqsxFa2iWC9OnL7VxSHVkzHJL0eHey90tE9+h
         xtaPMSgDGLxpuv6kzXaKNpQgfKpof78JGtfI55c1jfo2KKz1sjWBBOF0COLOXCNEe1Vw
         ++Eg==
X-Forwarded-Encrypted: i=1; AHgh+RrjGrwvhyWMxBIis0xUtICIzTrwfo71luP0E2/+O1nZYCWi6m45Xf4Z5ZkoYl5YIWb1ITdRzbH5F1pE2XKXo8UTke0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSNs2kOSZD2yh9Nqx8ZUNK+MQKZg5g5IuE8EGbaWylF4S+NveQ
	Pj2c8fpJHQoYsg3/fB4VywTZ62TVx7DLd1IBSv8N7CCnuLG5P0PznYEnPv03EsUAtS92iXQBqc3
	OpKFBL/BjWkPEN4fPcraS2LlYjKO7MY4kDEcUHiZNh+DdQgjuCDs77Jhwi+bSoHFFEXowZ3JjTY
	GA0Q5vNYwiyhXpkFZIY4wGgPBKiBYpUpXRbJL90hBp7lMs6RGi
X-Gm-Gg: AR+sD13muzQFUEcQr89ArLFhusdV+VhZ5RAaTQ9EISW60Hi7gcjqCERP+e2A3BUMR1N
	2tclW/6Vqo38E6jrEk06wnI/HlSOFKFIjpZyvp0wGnl2FxLzSd+DZq3c5xYHE65bijRxAI6Dp3O
	ICDZtVF0ZyCk+Ynd1Hn9yQ3ra971B1XbEwpZ9FTCbA+SwVjKMRK23oiYnaA30nIpfNtZwT/xNq3
	7S5tghmN5KQPv4=
X-Received: by 2002:a17:907:db03:b0:c15:f65a:43a8 with SMTP id a640c23a62f3a-c20c6920bf9mr44373166b.12.1786361077303;
        Mon, 10 Aug 2026 04:24:37 -0700 (PDT)
X-Received: by 2002:a17:907:db03:b0:c15:f65a:43a8 with SMTP id
 a640c23a62f3a-c20c6920bf9mr44371066b.12.1786361076815; Mon, 10 Aug 2026
 04:24:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804174242.2288433-1-vschneid@redhat.com> <20260804174242.2288433-6-vschneid@redhat.com>
In-Reply-To: <20260804174242.2288433-6-vschneid@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 10 Aug 2026 13:24:25 +0200
X-Gm-Features: AUfX_mwbqy-x6Abt5OxhSPeqjHWYVB_AnT2rrUuJUb9eEFIQ2sQnLRu40eaSkGI
Message-ID: <CAP4=nvSafV3qasrKjVfZQsTcKzeMCsNKdF0KMpNpzkbHM28iLQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] rtla: Unconditionally clean any pre-existing
 filters for user-provided events
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, John Kacur <jkacur@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Jonathan Corbet <corbet@lwn.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _14gtZjH17QwJm4EEJIBZn0HokQTgAiFVWVtk20LKAw_1786361077
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 4. 8. 2026 v 19:43 odes=C3=ADlatel Valentin Schneider
<vschneid@redhat.com> napsal:
>
> A later commit will apply a filter to events recorded to the trace
> output. To prevent any user confusion, remove pre-existing filters when
> enabling an event provided via the '-e' command line argument.
>
> Suggested-by: Tomas Glozar <tglozar@redhat.com>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---

I found that I missed one case when suggesting this: the user might
supply an event twice. With this change, it will now clear the filter
the second time the event is applied:

$ rtla timerlat hist --no-aa --on-threshold trace \
    --on-threshold shell,command=3D"grep sched_switch timerlat_trace.txt
| grep -Fv '[000]' | head -n1" \
    -i 1 -e sched:sched_switch -e sched:sched_switch --filter "cpu =3D=3D 0=
"

Without this commit:

```
 Saving trace to timerlat_trace.txt
# RTLA timerlat histogram
...
```

With this commit:

```
 Saving trace to timerlat_trace.txt
         <idle>-0       [002] d..2. 423185.347008: sched_switch: ...
# RTLA timerlat histogram
...
```

(Note that events are processed in opposite order to the command line.)

This is unexpected and might break scripts that for some reason enable
an event twice. So I'm not sure if my suggestion was the best
solution.

> [truncated]

Tomas

