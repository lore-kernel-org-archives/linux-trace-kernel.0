Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D48E2DCF52
	for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Jul 2026 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784561202; cv=pass; b=Y34smjSXNIhaIzVtVfjmciehSFFi8jJpanMtj7NeLGsl+IR538MJXJ/h5MtpGayDSAD58NZiPCz/ah5ZPnDyKwcYql/w4NrqWd+6yh9ogIx1sDNEPKUtzp+pSaMIa9v6tcrAcJrOlzGnWTSTCPmX7lMXaMBmrBh5d8MhyxyNjeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784561202; c=relaxed/simple;
	bh=wIOvE9E0izI9cWeOHA+3iIQfg+0GMdGrx8Op9HFx2UE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qEZ2QVqLygJ4PhD5HMl7+BuqQvUCUnu5+0xNHDR69YYKDbFlHIsY4eST13eEhGQXQnJfR5Jw83aL5tZPRZCPVhYw2qfIZk41QqYl0IBgYI1NzVvaa/WtiyNmWb8m90vaggJuFK8FW2kPCoQ/wkDP7Pr0WzW0XLi7P6pis6qIgyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LT+pVXHy; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LT+pVXHy"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-381216921aaso9938380a91.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Jul 2026 08:26:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784561201; cv=none;
        d=google.com; s=arc-20260327;
        b=RKHjruc//k69BXma0x/4yYxpjGE2oz+JJFdLxrSNN/KY0HckKBTUzgAoF0K+oUQTnM
         FDs2q5Q+pAiFv2DrypUqinhrUdxZdXeN1s8Z4o1+d9Y/nn1776O24MxjWK+MIxP75U1W
         gdZgLp1lRH4TVF2R3gezS84PpeYR6aUrSV8j/PZr831VucOus6fG8ce+3vRjG0+xf/qj
         NvGZe443CN09SsfN5b/rB/3dOgg5KHSWc4F2Yef6dBub9akYsLK6I8SPV35cfN+cP2w7
         jXKKFVIoBT7jiHK1FC7oK2yOlAYGfFXQjP36pOPF8jByMx52cWt0FVGIqOhP/l5jXksJ
         VlRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ppRDMOFJLBPX6KQmdpRBZE7SlCyjKiRE9PJURFV6vac=;
        fh=I2x934HpOZLR+3OYt48cVyDh4E6+fMNMxFu8TtUVpIM=;
        b=XIMYfL6MwaPOqkgmQLazVY9TQvEAjE3Xcrb3DDsfJvotBH6AQMKX3yCdnJcbqZeCyL
         6EJLdv+95n9uGiskVtgtpBHzQ8mmj0VBYhBZVkbW6gnGOd7jnRd1mYSQ7SiczypcE7lD
         x8xWem6iMAGpcZkRXInC9H4G4QbPmZl66hoU+xapkSnQ9oW52VGNP/urenVzye0mIrwg
         T6V0sdhyLtMaof6XDCU+u6XSIhucLZkuIcvakt708XBcNXX7MWLS8BYmlgrrnsgTmi8m
         E3xFYRGUG5pg0zOyROksr4J8q3lTkoR9F2p76z4umejKpLd0oiset8wi17THKlrJ1/NC
         z8Jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784561201; x=1785166001; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ppRDMOFJLBPX6KQmdpRBZE7SlCyjKiRE9PJURFV6vac=;
        b=LT+pVXHyYHUENBhySP2pRmu6cUgMRDvXXNl8lKWWTXZsYz6OhuZ/lRYeFnYFdx2EXQ
         XgHJLGQRQr6kYB70kss/MUip5lezDWGz6rh3vzbqhLlMI0plh6sCxV53F5O9M6CYTPKd
         EM/G597uu5IOdKJPmgsImBLx46qLvrpFwm49JV988N/rUT1LyJ58I6jPO3hkGevdHP/v
         geiulL7xSAxSumO0j0LvRBtmfp+UA4HRfEse6lBKj0u6GQxktYRFdVdwPAmHUhhDj9tJ
         gefME7aMumQSfJDRKAk/B3oCUHw7jJQDHRWAcA7zE6Kk8bWx5P5QB1H90AQoSePiUxZM
         eNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784561201; x=1785166001;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ppRDMOFJLBPX6KQmdpRBZE7SlCyjKiRE9PJURFV6vac=;
        b=HVpJrX4cALcmReYvAjgZ1yCt9ZVg2KGbZfQoiaxtnnlYcZeCcQFg/YkTHqP0uTDj9C
         FblsPhCUfqcSMQ3CLw1Lw8IHX11i0WqVR9Va37WsJsCpdxoxosfYqRSmDblxVSeZp4DY
         X6nRa9Ys+dLSLUw7HzAaTfjh1sG71S+qIC5oBOORnq1m31YHt8IJ5mFDsg4oJrb4cPvr
         PpEF4ZiqnrUFO+Vn1ZY+FEAvsH9yQAMJCdzx1woog40BjbnveERRAkRu0e2Nt3qmwAxP
         zeCf8bVmpI4oncRIjgjsAib0M58UC+VQo3msWSfo1iOWX95Mjq/h5qkibxmeu+TynqRI
         8q6A==
X-Forwarded-Encrypted: i=1; AHgh+Rr7yn+nDTiUo1KLFEUANYXtSOxQvsawesQwo+M8Z7kcJgTt1d027Qgb/cRh38Df8RzAv6Kdf9CbZaITiaXeHbLAzNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUnlARMCo96imNczRyI/zSVATJ5GVLBzYWT2zbCQDGuTRd002P
	smG5plz/fR9mdjGDLUAfs3nmw7uF2gjMwpjlgWp2EjbzI2Z5C7X6l+fVc//yygeMqN9BmZpiQNc
	Ifq/Y+wR8+iAJNlOX9by72c1UcOMU7fBh18252LXd
X-Gm-Gg: AR+sD11w+UVxnObuGkSrlE6AuCjB2vaev/q5ZHEP57TISnMN4WCvq5hhA5pVvoMvsCy
	gDMsVYwh8YoUPjjIKB4bI5bOvpNLC7gKLVXRISoh3Vi2BNhBEAJHfGUH5c+uRn9Fonge6qEhCOB
	R7i+l/T92twXeliniVxJgN+7+Kx0OTYTgNdIvSoAXTKC9e5lfK4aXV1zItPYDwhY9o5YNAtcRRO
	43nTLrt5+qXi3vS9TK420j6GnReflEtNLMyz+sqUefi4bgD9TVVJqMLLubYTrb8quVZtf1hQEFk
	vi4B0rUSe5P3Kft0s2IJOw3l3w==
X-Received: by 2002:a17:90b:580c:b0:38e:2524:724f with SMTP id
 98e67ed59e1d1-38e4b410109mr15364918a91.12.1784561197991; Mon, 20 Jul 2026
 08:26:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717125023.1895892-1-wangjinchao600@gmail.com>
In-Reply-To: <20260717125023.1895892-1-wangjinchao600@gmail.com>
From: Marco Elver <elver@google.com>
Date: Mon, 20 Jul 2026 17:26:00 +0200
X-Gm-Features: AUfX_mytGrClEjUL35sTA01mL-vDpdcepD52IC2sE_eAPBJUPR35g0y1m7pBRLg
Message-ID: <CANpmjNMpKXxk2KsZORakwwdOpDG=pRbtJKi7doBt7QmQwUKdgw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/13] mm/kwatch: dynamic hardware watchpoints for
 hunting memory corruption
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	David Hildenbrand <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Randy Dunlap <rdunlap@infradead.org>, 
	Alexander Potapenko <glider@google.com>, Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Jul 2026 at 14:50, Jinchao Wang <wangjinchao600@gmail.com> wrote:
>
> Motivation
> ==========
>
> The hardest memory corruption bugs are the silent ones: a rogue writer
> scribbles over a live object through a stale pointer or a race, and

The stale/dangling pointer (use-after-free) case is the main one you're after?

> the victim crashes in a code path far away from the culprit. Any
> single developer hits such a bug rarely, but across the kernel's code
> base and install base they keep arriving, and each one is
> disproportionately expensive to localize. The question to answer is
> "who wrote to this object, and from where?", and it is hard to get at
> with the existing tools:
>
>  - The kernel's own reports - an oops on a clobbered pointer, a
>    BUG_ON, a list-corruption warning - fire at the victim's access,
>    not at the corrupting write.
>  - KASAN/KFENCE catch memory-safety violations: out-of-bounds
>    accesses and use-after-free. But they have a blind spot: a
>    corrupting write can be fully memory-safe - a *valid* pointer, in

Language-semantically speaking, a use-after-free write to recycled
memory (be it in heap or stack) is NOT memory-safe. The detectors may
not always catch these (KASAN relies on quarantine for that to
increase the chances, but yeah, not guaranteed..).

>    bounds, to a live object, written just at the wrong time or to the
>    wrong place - and then they stay silent by design. And even for
>    the bugs they can catch, KASAN's rebuild, overhead and redzones
>    change timing and layout enough that racy corruption often no
>    longer reproduces.

There's also tag-based KASAN (KASAN_SW_TAGS or KASAN_HW_TAGS), of
which KASAN_SW_TAGS has an x86 version based on LAM (not yet merged
though? see https://lwn.net/ml/all/cover.1773164688.git.m.wieczorretman@pm.me/).

One property of tag-based schemes (and any other lock+key detection
scheme) is that upon recycling some memory, the tag (or key) to that
location changes, and any previous pointer that still has the old tag
will fault. The caveat with current pointer-tagging schemes is that
entropy is relatively low (4 bit tags).
