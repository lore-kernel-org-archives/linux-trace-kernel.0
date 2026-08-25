Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1767303A35
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 01:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787621919; cv=pass; b=pfkitDpZ7VeTOy59ZEbF56KEhyI6U68rSCAtmmMCZJH2LmopInYRrTZ79Hn/gBaOPaZZ+E0EdToSgPfMxgNhmxT9HjefDWbyOO7stB4t6Bscg1euuCYjs+UPGZhh51g7BVNQCbyoj18yARKj5Hctcob7Eo5etEKpEXvJ74d3aSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787621919; c=relaxed/simple;
	bh=Dl1pNxz0/A2V30oF3MiIT/1xyFZzJWr2p2E5a2231MY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=byM5bqRbSauwhs01AtwJWFkYMg0ksg4yKQa+xhGlALsa2GQHeuaM/RrQyvlo5JZPABz0/5a5CE/kcKky3r1rH/58yst3FWZrOd3ake1fVF/lIS5tzVoqohqd5jkDbeogb7WyAzQteqXsEjTVdvmx6g9PGeYy2/zBBaQ97y5O3bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcpWmiK8; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcpWmiK8"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66c70cff944so4069686d50.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 18:38:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787621917; cv=none;
        d=google.com; s=arc-20260327;
        b=C/yEcf/NwwKg7FXK09v0Sm3NvJTrBzGoah8J03I0blaYBVoy4PV0ijcd/ItAb9yFWo
         U5fX28rPcaPpRgAdeaQLmklyAQ2SitHi2fYyCRYMBTqwnMB1oTJZSREn74ryZrgqURSa
         5q0EOgZGdqaeo7eRVL+Wsr3Hl5cSTir5RjMoDq1dJjM6dJn9kFEF8qxoZfWdKNF68l4B
         8PkNNgBpQk5KE0NZjtK3jFG7jz2nmXXBb7XU/rUpBqEg+TbTGNYpbVbgLAP6SmHbRPI9
         /tO12AtlLgeAOMwJF1VwWmRFlaBBn/nFoWkrYRtxEual+M3eziL4g0566bz8vfs9DdMO
         61fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dl1pNxz0/A2V30oF3MiIT/1xyFZzJWr2p2E5a2231MY=;
        fh=hlOyZ/03NVZcVqxoT7vxtQaqgR6pjPWSIFEw6UB+CC0=;
        b=U6AG2QBHpFTcUuDB8qaoftFgquRv/wbFRv9OOLc/CQpJx3FUJn+0q8fjMeZgukTJ7E
         wKLMX9kL+q0s3ZodoKphJLs8ecWVSyUjRqerEi315+WODnZSY5ldiIjPIr848dUGlRlV
         AFeoCaF9xLUQdQH5KSsAezq0pGa6lEV/me9ijCZRSTo6vPXUiGv6FjP3EJTLEk83A/hG
         AjJabdNF8EETqM5iQKXbEWFNibzwdF9PcXXYne0R/iLygIr/nNuriXCB5ZDdJ8YoR4B/
         BypPc4gmiMnHXfzU2Ub/fTFTzWk+XPWZ+mskdVHM15i/k2fLGKWgHIEEw0KC2JUfrp2+
         g6mA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787621917; x=1788226717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dl1pNxz0/A2V30oF3MiIT/1xyFZzJWr2p2E5a2231MY=;
        b=RcpWmiK8D6TXy8SeKasN3A0DZYwOfxBRVcB8htDEIll1rHrnI6lELCV5zqfa7hqRIU
         rEtXhQwWzLhCxVjqmaqiPTZ5z0dJcxPhJuB+w/2g+ZIvxA9AA7wp1nCUmi/Lx3BT7V/D
         ix6ekhi8ZBI5IfxzW0LEJW0lhdkZsJx2MxnwWBni2MPKVcGdd8ABIe0GT3XfKGApfkV5
         94uglqgNOv4yjFi7HXESZnyitoC9C18fLhT4/Qfuilf4PgC3Dq1ZbPc5PRBpzoDcd/MI
         IZqnD5RIjFJMBR6ogU+eumXbmPPa8+C4epLSIHNwNtfwpjDlK2p3AxRoHpFvQWAoEL3b
         j4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787621917; x=1788226717;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dl1pNxz0/A2V30oF3MiIT/1xyFZzJWr2p2E5a2231MY=;
        b=P6qZG6ou9UiWquw/Og7yKlXHhIbarUxdYCe6naE401YN6WDHvDd6Iabz8NC7Wu9snr
         ERrx9BZqo4ksgs0p3HVHd8eZUskLeqZko3jDWiq/WMYrBDjz4VWA9uV2wySZSUaqxWne
         KR+uWJf6h0kMFAWvZ/ZKe50VLzbotcvoDrvqpB2K1AqCLD2RDe6IZpUaRugCdCpn38Z1
         0cpxya6ZzTnvm82te3e+nkywoFdMHoNWTF7t8Bke/wwtcpzG8caYejJNMCFQfTUbybu4
         SomviGiFVdgxDNSE94tmnSGvbyBcKtGbn3KB/ocPSJewef24jK71CEednViV00mYj94U
         9g0g==
X-Forwarded-Encrypted: i=1; AHgh+RpsYmNU+LaHerGvp8XOLNS52MQ7vNL7H+G6FfdTzZKBZQ4x/DeNArRx24rtf4wSn8twm8iJSCLpNawPqMLpqp9/JG4=@vger.kernel.org
X-Gm-Message-State: AFuF++mPl+NNKmV3Li07q+IjtdHPfd4vXLgWWmcEsQrG6QZo9nx4az98
	ID1FUBEDG/q6KOLVWy82IPdKLiTi2vp/gxit2OKU6MuxdfhePAYFJu9J4V2GivLV4BPkT1Lqct0
	GsQzpJVOXC86Acu+fws9WvcHzuJsPmqs=
X-Gm-Gg: AR+sD12S738MfBVk0PibXQgrGSfdSi0WXQfyWHbvfD7dtiFstjoUUXU/6DWSoeChak1
	EDTl2KCj1sVEdGQHqBFvZtWQXvb/HrxnZvx6tGY94QnO1HydsTsvIR8Vpjk8KoW6enDIYALhO6V
	lLWrXiKdcsMKat+fRafV0xgEBQ/GgzU2qLWgtkDqHaPxldY7MpiBNCpOnJbbBAJiVykQlLdA5WC
	RBa8AnwfDcGhUqhI37a0nQWnuidUJ1oI0oYtMXN0c/7HXw7JK2VN4H9NCh8ZX1STmtOhg9nMRbm
	ns5yzApFwOfTnFJno2qTLlU7oyJNBQFFnnIzWsaXTLNbPrXD6vGnxUtw6zojwYd/OcIuMr0ZlmB
	5b+epkuCJvQnV8LMhzAz4FyNx6m56U9GW8I1mP+qYktY=
X-Received: by 2002:a53:a5d1:0:b0:66c:76e6:2d01 with SMTP id
 956f58d0204a3-66d14a21801mr845428d50.9.1787621916851; Mon, 24 Aug 2026
 18:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821014210.18681-1-kartikey406@gmail.com> <CAEf4BzazKkRiOCAAERt6YueeVYnnYeNEPmxH+EW3F4CR_YVjsQ@mail.gmail.com>
In-Reply-To: <CAEf4BzazKkRiOCAAERt6YueeVYnnYeNEPmxH+EW3F4CR_YVjsQ@mail.gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 25 Aug 2026 07:08:25 +0530
X-Gm-Features: AcwNN1U0LHGolhM0a7k05nKFQh1Imv-RibXkGJMcsIUuJJbyEfcSMIuHp8mjcg0
Message-ID: <CADhLXY7_Dpzwuqdq84scYObut=DTTqfZgG_U9f-fP6GFeRVT-Q@mail.gmail.com>
Subject: Re: [PATCH] perf/bpf: Fix lockless access to parent_event->prog in perf_event_alloc()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, olsajiri@gmail.com, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, kpsingh@kernel.org, 
	matt@bobrowski.net, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2026 at 12:04=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>

> exposing this mutex like that is definitely a smell.
>
> AI tells me that this perf event inheritance case can happen for
> non-tracing (i.e., BPF_PROG_TYPE_PERF_EVENT) events, which are
> attached while holding perf_event_ctx_lock, not the bpf_event_mutex
> (this one is held for tracepoint/kprobe/uprobe programs).
>
> Please validate and adjust the fix.
>

Thank you! You are correct.

perf_event_set_bpf_handler() is called
via two paths:
1. perf_event_set_bpf_prog() with ctx_lock
2. _perf_ioctl() with no lock

I will investigate the correct fix.

Thanks

Deepanshu
