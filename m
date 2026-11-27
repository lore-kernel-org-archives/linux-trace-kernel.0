Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795784094;
	b=aPHrccGMvTGG/F4HL07FSJ2hiTqZjNVX/m9KHmvvHsoo6aybKZt4aI7O64ZMhsrkKInA
	 I9BNMGrL8W/IA1ij1ZsiyD1PTjhg2ZcbLOPWzAMtlnNrKHfbNm1o9k3Evd1JRrR4h3+rD
	 MCrC2GlOITZ115QOVmsspoE+/eOo6e45Ff/gWnksfEN+fC9icuGptjX8v5/ciSLD0SmY2
	 NZzT+4FlTTzi9b9KJqFagKku3wa2/JpThvfBKblidXMfjnAW9ejjnMPOCfj2+0uz/7xUG
	 zViyTi9HTNqBUjFZxwPO3LdqqJZN2Yft2w5NMbF7HtW9LEb88Am3snjJ0r86moq8WWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795784094;
	h=DMARC-Filter:DKIM-Signature:X-MC-Rep:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Transfer-Encoding;
	bh=aoCFCzIshNyrPQBZCxE5KPBXPIt/CPhY20OoZaQzriM=;
	b=YaDAQtmqyJx4sFbqVBiPNHWstl49JDqFyNm2xe6gV0zDCtB8XfqmUga9IPqXx4ydvVvG
	 x6HbXSryev01XkbRZm29Ru9ciwEgwmVjp6rO7z41tjrVDn0HhxU1or+IXmuE7dJHT1JQN
	 3UGUTUP4lBm/5HmfIueHDo9VwHd5ib/72shQqdsbI7E4DzjOBXM8PVumR5Wcgy2lVlpNh
	 rYn2BCC0telE2X0ARPSDvwYsgZHSi0tt0mYbe9Yx1rjFVuR3wksvx+zKOuO80UNzAo1jl
	 ieiVHR9RoUM2ncdschQnzhWR50XfwZhed2vauIt2fJYzjhCvaAK5xkKrfYUu7ArDfjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cu7m1CUj;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D79606A31E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 12:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34D79606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cu7m1CUj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795784093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aoCFCzIshNyrPQBZCxE5KPBXPIt/CPhY20OoZaQzriM=;
	b=cu7m1CUjmYGSBM0829JiM8qKzV90Yr3U0/1p3vF8J5ZczPcDGTItFRHRn5iXuwQRWxvOOy
	Yi2jku4RmbE5asovrClHsP7t5s+PLaSfWUKHHoBrq2HBM0bR7f2t/+DUsw0cOahPt2cV9b
	FvHr0rT5d+RgVcjG+21GuLWPDWnOvX0=
X-MC-Rep: binary re single
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-uj_xK4LFNXyZQyLMNLQpAA-1; Fri, 27 Nov 2026 12:54:51 +0000
X-MC-Unique: uj_xK4LFNXyZQyLMNLQpAA-1
X-Mimecast-MFC-AGG-ID: uj_xK4LFNXyZQyLMNLQpAA_1795784091
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8b203b0c139so5680426b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 04:54:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795784091; x=1796388891;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aoCFCzIshNyrPQBZCxE5KPBXPIt/CPhY20OoZaQzriM=;
        b=CX+PkFYP+ha1uT9roemmLb/dh3HlGbJCfkGdUAYZCaRbwER/wK5VKr9OrHzOnaPtGl
         ltwv/3u/A5jPbwKkowM9WczEGMsFRSsanLmFoXqG75XtD1GgLP9zVcpmKjHQvqd+slRy
         SO7zWs63AdRGe+OT3qRiT+VKfVCa0mxpL0HHcsR+zHR1+AY+q6ZeAZyWvfGKS647Rfek
         9lfK7ibiAVPFJFsQo7av0tD0NwR57dTQiTPtgJ/pR+sgFoxITVngp9u31W89InNyzIwG
         FPS3NlTOroEzEExs98wIJIpaNX0rv/ZAomTvhfn39LWq2vdIiQDS0+P2LQXb3Bmk1wqB
         cw4Q==
X-Gm-Message-State: APuU4Z90bHNXNvsv6uFjFaEGwirrMgQQc5UVeIVT//GOvKC8mLgeNv4F
	J7GZA49qu+7RT0K62GYlz2ebglHc1AE+V6Z85sOb4PUAJGquVZn+sB6K4ceOlBhVjR/i8rIq1Yv
	YBBfEx/LNQN1qjcxOXyDAK8TvGSFYzcLVBC3gL4HbZ+WcPvCUcBAgjWu0JoKWVyIejilpt/gJA5
	bq3R3whBq25/jAhseCvQCXAG6DOPoSbUIw2Y2lY4mFYCRQYC+9
X-Gm-Gg: AZFdTZfOJrO+iwUwb7uOcRysnafATlTq/t1OZpB2TEBUaKuageIIR5kZp99Xt7Wsu8k
	LGglRaischRYrMTxo3yE6ZgckkUEtHMe3qtTXxLc9O6AJY4FW4ia7VE5qr5Pubgwmb9IEIS/bLq
	ArxZTE4t1D4A6l0NUAQIlPrNyFu5z40AEp/A9ZFl9AqNFBpXEYqCIefjtzzSC86ejImE7eC5vHE
	9yhe6f67Xb1wBs=
X-Received: by 2002:a05:6a00:124f:b0:89e:b12e:7ee1 with SMTP id d2e1a72fcca58-8c8794b9878mr22414593b3a.1.1795784090564;
        Fri, 27 Nov 2026 04:54:50 -0800 (PST)
X-Received: by 2002:a05:6a00:124f:b0:89e:b12e:7ee1 with SMTP id
 d2e1a72fcca58-8c8794b9878mr22414574b3a.1.1795784090148; Fri, 27 Nov 2026
 04:54:50 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795262546.git.chaosheng.qu.linux@gmail.com> <328ecfadb98649f317985124b6b49bae2d356bcf.1795262546.git.chaosheng.qu.linux@gmail.com>
In-Reply-To: <328ecfadb98649f317985124b6b49bae2d356bcf.1795262546.git.chaosheng.qu.linux@gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 27 Nov 2026 13:54:39 +0100
X-Gm-Features: Aa3M54qGBxxWIk1P5kyegq9H4jk8G8LmhabQ5LcSTQ0-EevIyeLc7S4mtnWR1HU
Message-ID: <CAP4=nvSFE95SAvysnn2ay880DgFUrqQgUY1A3pTcSTXagdiDNg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] rtla: handle SIGTERM during a run
To: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Dv7UAa51_3PQrJ3lZpygaPadGas5lFFs3YfeBI07PVU_1795784091
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 21, 2026 at 1:03=E2=80=AFPM Chaosheng Qu
<chaosheng.qu.linux@gmail.com> wrote:
>
> rtla installs a handler for SIGINT, and for SIGALRM when a duration is
> given, but not for SIGTERM.  A run stopped by the system - a shutdown or
> a service manager - therefore dies without going through the cleanup
> path and leaves its tracefs instance behind, so the next invocation
> finds the instance name in use.
>

In my experience, stopping via SIGTERM most commonly happens in
runtime tests when a test times out, as that is what the "timeout"
command uses.

> Install the same handler for SIGTERM, and restore the default
> disposition in unset_signals().
>
> Fixes: 2f3172f9dd58 ("tools/rtla: Consolidate code between osnoise/timerl=
at and hist/top")

What actually regressed is RTLA no longer resetting the thresholds
(osnoise_stop_us, osnoise_stop_total_us) before starting tracing -
which would otherwise protect RTLA from being affected from a stale
osnoise option (that can be set by someone else, not only by RTLA not
terminating cleanly on SIGTERM). That behavior was implemented by
commit 0122938a7ab49 ("rtla: Always set all tracer options"), but
commit c219d4ee1d6 ("rtla: Set stop threshold after all instances are
enabled") broke it, as it flips the threshold back too late (not
commit 2f3172f9dd58, as far as I understand).

So there are actually two bugs. Together, the fact that RTLA does not
restore settings upon SIGTERM (never implemented) or on start
(implemented but regressed) causes RTLA to misbehave with respect to
thresholds in multiple ways. I'm going to take your SIGTERM
improvement, without the Fixes tag, and send a separate fix for the
reset on start regression.

> Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
> ---
>  tools/tracing/rtla/src/common.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> [cut]

Thanks,

Tomas
