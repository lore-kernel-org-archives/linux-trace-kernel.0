Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B9443B49D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 07:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792049189; cv=none; b=N+Dbe+aEtCMuQmfc4Vf3fmr4VknbYjeRrQdJVVOyigJ8VIAT8Ux/ek05Nh52IoYsIPDr/y3yGIBJh211PVRgRt52dAG5xEn23xJoOEXem1bdDi+P4i5zwFTG5/fRTun/Jr0ZwiV7oG9sguJ08X5vwoexfc3kzV4aAMyzzpJUe48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792049189; c=relaxed/simple;
	bh=xwtBzirXEOCLJqRYZFFzZjl9ExUUK4CKgV7ms93Fd3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BaNUye4GnZmM4R+lzDYfX9erHYMUf/y+yLckS4Lkd2VJkr03Vi0G4k6O5Vcw/HqZ4iRtmg/Dsm+x+YrfXbTZgjX+/HTuNWegpz1VSWiq5YY0LMhB1QdiCZtu9QOKPo5jOQ0zZhjC3C3nt7+6+Yvb/nYfHjTo0nABgSg3WMI9uEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmOgOEKt; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmOgOEKt"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a0213948d3so29884705e9.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 00:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792049178; x=1792653978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4TcvTv0+MA3VdoeuP+foXkM6LedLqAHNwCZW23zraGo=;
        b=CmOgOEKtLDPx5dFMZzstlEpO5tqqbN0GmUvZEOP+bNEI5ebj3yT6+MiiMGqHSBV6Jx
         MJrwDFv9411A7gxzZozTN7uA07+2fys4UdRO0KOs+WFaycBoOc+CMpoP9gBZDLU6aCXc
         7pzeIPwG1hniWVl2u9yOlP7tAl8FAJfz59Qp5iPewo1p23kIqNC6ou5V55SyaAVEvn+h
         m7KJeJLS9+m3FhUS8bZkgzkE1s6ckq4/yI6lmikb8exXJoI3nNT8E2t6GmDIDX/l9FtL
         FzikmILsmC/r+6O7Jl+udQTLlwnjxB7mS3DTjnlc94g8ieSGDawgDCeCtgxzowLSLO+7
         pv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792049178; x=1792653978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4TcvTv0+MA3VdoeuP+foXkM6LedLqAHNwCZW23zraGo=;
        b=x5UbD1sVjPFdtF4BLuPX8WtqCm37Tbzwxxy0IkGkx/pFLiPyhXfK14+5OiIzoU1gE9
         rsnPONwf/RKnT/EukDe85bdXEYmXG6SLvN2u46fkqYOKzCUu5g0+QcM34SCYT+IZfFJo
         HUVSRPeVuDnbNi8PCvHy7YAoS9GLcLPKzjaFf3nBKqlFjxQKjkBwGvc3jj0tQglA8u62
         xTTJcSrfGK4hnvDxKWrq67jqUjuvoFf66dRVxfvrOg+KNMSvT37ntb5ZldRF056Igt4t
         IqkwqpyuEbhRNale+Na+bpF3mNT0EMtKrUQ6Iir6Vm342R/+/y9ghr5eoIejEdhXml9R
         ERkg==
X-Forwarded-Encrypted: i=1; AKwUvBwAXW1w+2U/ujtXmItcAC0VXfp2dCHZ+gJHGXFKSmRj1tMj22SaWGoeWKrAOvGZhzSJf/tApsR/kM9W/5WkL6GH6Bc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLEIy3eFMgW9mt0+LXKnLcgvgKs2JZbpErAwHxAivPaAs2EAvmg
	RDlBY8GP3hw5Dc1H7eYykFATeS7+z1uClaJH1j84N5yoiER2Hse0gCPk
X-Gm-Gg: AYBFou0mu7M+677TYavKFQRfWc5hC2ox+o6f7opYDpQtPPpgDikUBZgVWunirXtwvk+
	kcVYdULXSRmuQeMY7wl55IXmWdF1Ea0ZgEokic9cvDU4TI2BP4Qqwi2/fx4FQ02Zcidi+V9VcDx
	U7+obIdmN3WUqvs2b+X/r75Z0mo1yYLO6dNvns8+ihj/oll4lrV75feA8IIoPs6GKuFb/ExKPGk
	X8OR3Vii7lH2qwySuV8kOXf5oxeDgXqzp1lVv7k4p/lYikx1kCDwFZXwPjVy9YkBrNXpVbmDHE3
	zWj6bntAUgmUS86Gm5B7G0A5tza8zjmCVe6RqH4UQZWNHKhX/vci7VWqn6hY9cvOYG4zBZE81bo
	CmQbIeGfMePGKpdLyKAhJtWXzDf+1OXOLDiyVmXQo1etuElGxSN52ZbjF8UH30Y7AwTpHmu9ogG
	jVIgQ5nocCQ6+ihsmx3gy89d1fR7jXq8vynbYK4u22WxxCa6qL6ttQV4KzJa6Veet3zRp83PmJx
	qreWhGiMexwMa2xbdnqtoPQ2MWJD2gUv4ZWxXQriHq7Gg==
X-Received: by 2002:a05:600c:609b:b0:49f:ce78:356d with SMTP id 5b1f17b1804b1-4a18e4c9944mr358446205e9.30.1792049177294;
        Thu, 15 Oct 2026 00:26:17 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.109.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd97ef4dsm55898465e9.4.2026.10.15.00.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 00:26:16 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ftrace: Fix lost recursion records in ftrace_record_recursion()
Date: Thu, 15 Oct 2026 09:26:11 +0200
Message-ID: <20261015072612.401602-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014172821.2b1fde91@gandalf.local.home>
References: <20260917090217.6738-1-parri.andrea@gmail.com> <20261014172821.2b1fde91@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Oct 14, 2026 at 05:28:21PM -0400, Steven Rostedt wrote:
> > Can't claim to fully understand the logic behind ftrace_record_recursion().
> > Notably, its smp_mb__after_atomic() calls and the lack of barrier comments
> > both look suspicious to my LKMM-trained eyes.  ;)  Hence the RFC.
>
> Well, the nr_records is updated via a cmpxchg() which itself is a full
> memory barrier. The smp_mb__after_atomic() calls are to make sure the value
> read is in sync with other CPUs before doing the compares. It also syncs
> with the clearing function that is disabling and the writes, clears it, and
> enables it (the -1 updates).
>
> Otherwise, IIUC, the atomic_read() itself doesn't guarantee that what you
> read is what is in memory without explicitly using the smp_mb__after_atomic().

Thanks for the explanation.  I don't think smp_mb__after_atomic() gives
us that, though.  Per Documentation/atomic_t.txt, the barriers
smp_mb__{before,after}_atomic() "only apply to the RMW atomic ops";
atomic_read() and atomic_set() are not RMW ops, so after them the
barrier is not guaranteed to order anything.  Most architectures
implement it as smp_mb(), which happens to cover these uses, but on x86
it is not even a compiler barrier, so the compiler is free to move the
memset() before atomic_set(-1); LoongArch still defines it as
barrier(), though a fix for that is pending [1].
And no barrier makes a load return a more recent value; barriers only
order accesses against each other.

What I think the code wants is: on the recording side, the load from
nr_records ordered before the loads from recursed_functions[], e.g.
atomic_read_acquire(); on the clearing side, the store of -1 ordered
before the memset(), for which smp_wmb() is enough.  (The memset()
itself still races with the recorders.  Marking its stores would make
that a well-defined race, but clearing would stay best-effort, as the
existing comment says, unless the clear waits for in-flight recorders,
e.g. with a grace period.)

This is independent of the cached_function bug, so I'll leave it out of
v1 and send it as a separate patch, with comments, if that's OK with you.

> > @@ -67,24 +67,27 @@ void ftrace_record_recursion(unsigned long ip, unsigned long parent_ip)

[...]

> >  	old = cmpxchg(&recursed_functions[index].ip, 0, ip);
> >  	if (old != 0) {
> >  		/* Did something else already added this for us? */
> > -		if (old == ip)
> > +		if (old == ip) {
> > +			cached_function = ip;
> >  			return;
> > +		}
>
> I think we do not need the above. If old == ip, then whatever set it before
> should have updated the cached_function.

Makes sense, I'll drop it in v1.  (The cache only holds one entry, so
another ip could have replaced it in the meantime, but that just means a
later call takes the slow path.)

Thanks,
  Andrea

[1] https://lore.kernel.org/r/20260908073906.31781-1-yangtiezhu@loongson.cn
