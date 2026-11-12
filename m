Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508409;
	b=PcN3vniY9GMj/bRVivqn3J6AFrYGtCmq51e+kvyVGVUxbN39U39VfyQiXKsnyDnl5r6T
	 4TssanOJxtkCA3tWovnu2UtObsDMPO12sX6UqPbX4NEnVtCX7zbf4xCW/Pf0u5G++oVsC
	 CSqnR5MCjwlShUSpL7fdmHthVPOS67CHKb8WMcwu63FQaZdneiJf/LkYN4IZgnkWV1vcT
	 mkbbEO+AYMA9cOZ4GUm/DCtloPX/E7Bn/6f7c9Pn2e2ln+zK9tf/dWEL67CoZD6B+uBP8
	 45+uFMD4M8bP4WaNDYqyA3YtYDdHZOVS03NY32+dciv3YjuEiGezl44WSLvmdViDl2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FmhP9MeZo5Es0js2kSt8GfipastboIXrtB3uKJCSmzY=;
	b=1Sau/tyKwAEucj/dtl6XFkuZ3uqMeONhzaP9+4UvQ3ZjsehHfkkMdTpA0azCIiclKKeT
	 N9mUkcFryBKGkUy81/Z7v1ZAwfHHsk0wR7lOAXldR0ifY11TqI1vHlIQZPhYoKKPD87Nl
	 PJlEN14gIrn0jGbgy1kHEIJ+QlQ6HzJZaazmCj5Tnv7xmgTK0Ca1kOpHiOhQEFbqURGaM
	 lxNfo7uWwV0jKvRTpaG9PFWPNcFgGtawaR+opR+LNtjpfJQE4bEMWF9MyWBm4u1yAWevL
	 Y0iGO5ql6BKhvSmC9QZyRx2x/EqUTTb0Dds0Fs6YhCI83eNgsI47eEm/qxP4BnwrgHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WMeS2P1h;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9C1606A89A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 18:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E9C1606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WMeS2P1h
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4395d31228so7210866b.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 10:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794508408; x=1795113208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FmhP9MeZo5Es0js2kSt8GfipastboIXrtB3uKJCSmzY=;
        b=WMeS2P1hZnTnffr1aH08d83wzDWTn8SllmQoVjBf3rwrHkLVXzy1iOzvRfrU1VsPTB
         jU1VKFpGzM5Lm/RctBUlZ6hO7tOIK49ulN95pPVl6Nyzo0QyTEKyd2TOr4cf778mVlJc
         Ta1Bk6/+hlIl5XHqMXSAFLWvJLMXNmWbuf8p9S4oNSbmqU6o82kKZVysyADSS9vW8xyz
         qR7Q//akUvVsLlOBQTQc1WmjXhAIkYdnimPAn9nmGXpL5lZEQfyERPZlzAaZ051xmAuM
         2n1qfLW8Zp5ShIvL8P6Uu4/aOzmeJhvjW2kLcKn/C1ys2wKnCHf9j9p9ed+InWCDbEkq
         Kdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794508408; x=1795113208;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FmhP9MeZo5Es0js2kSt8GfipastboIXrtB3uKJCSmzY=;
        b=TKvVeNN4aOB/t0rqJjhLVxohbk06gaGcILzCUGiJno+GyHTG4nXfm/kv4RVBdxkxrv
         xsv3WJCEQFO64XYKvbyTVT5Wl/jYqVyUsgM6RE74gn5iT4qPpe7f/JCqfnD7p0LFdw8L
         sPqlr4whC9OkkgHoeVKQiP3Zc5sI+jKd3wmkQHKSUw4nuMvZWnTvYkyTPsEK3thAy7Gu
         SVq3/ga8ZFE11U40Z2elbGknUISJJGIQdeY1Aj/2q0wLbKi5Q3xEeyrAxUltnbUWU9RW
         gCC+oTbhyRH+12D+OHgEbUoIOANKKNclfxE/MRyIvpoCYKAi8dLO6rc9HtDMT2jNdfjr
         SVRQ==
X-Forwarded-Encrypted: i=1; AL+hErG5JLEbJ0P/sRQVwGz+StnAEJ2WDkw5iqn6+pjJe1qbMLapbdNk/HnWXCF3/3POVqfz8ukrCBm5AiXJaYrYv1DEeSc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CciBZS638rxWgbaVQ/ny6pTfueJLvOhSDlXAy92XJEIzn/Fnw
	YXPuaJ6tBgCPpHS/BPELfZrocSW8fffd84FjJVrlnjDJYIDh/ZAdPaKj
X-Gm-Gg: AYBFou01luPyZKzIjorSS7W0C4O2kzB9BHdc/ekJX8wqjg23g4wIs63ApNzV8C1Dg2q
	xxvnn96EHo9IoBOZhetRy4XhBMSRi4rOMb9TV/6O+SkwVDOBmvxDTVH+ABlnkaCFbrFCZyLINQb
	7V6zgtgSqs2hKGprx1A9ThZ6dRmXXn7H68OW3yBDJPBgCk4x5jddhQjf095c+NxkyFCSe6vT+Hq
	g112aV2e8PAFc8GDzY1n0hCEX6G2sSl8tQ+KujVghpPn58fLF5Le809+EmR60Nf8GwHOs6JPNyJ
	ECa/ZwNVWJh0KDSedeMNpw0U64uU46VM09APfdFrknJKBSs4iCjjPA54+nK7U24jBPXLwSq95cw
	qoLg2CQfb+d2e95JIXBgfNHgRKo3wowdw7Wnuo34etckGI6tiV5B0Oj7yQZVs7NIv8grJdIGHt0
	MP4AgcF3M4888wk9fHqGEHDa6GgOto5RZt1afyCyNlXY0Rf0p56kAvm+W+6YeaRwQOG2M7AdiKI
	qwHAzmAeMKHrgFekc3oE2FSG2BLoDVleP2ZRN5ur+FGacF1MfeAx79VRpGbhq6fY0uaNqf2YLNy
	i7Pi6UP6/DjiGJdL
X-Received: by 2002:a17:907:6093:b0:c2e:4a61:d436 with SMTP id a640c23a62f3a-c50963856fdmr10734066b.36.1794508407688;
        Thu, 12 Nov 2026 10:33:27 -0800 (PST)
Received: from krava ([173.38.220.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095a5a78csm7085066b.4.2026.11.12.10.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:33:27 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 12 Nov 2026 19:33:24 +0100
To: Peter Zijlstra <peterz@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Alan Maguire <almagui@kernel.org>,
	x86@kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 01/13] static_call: Index code text reservation lookups
Message-ID: <avYGdFtNMjSrdc5l@krava>
References: <20261109194916.1089703-1-jolsa@kernel.org>
 <20261109194916.1089703-2-jolsa@kernel.org>
 <20261112082709.GC2668804@noisy.programming.kicks-ass.net>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112082709.GC2668804@noisy.programming.kicks-ass.net>

On Thu, Nov 12, 2026 at 09:27:09AM +0100, Peter Zijlstra wrote:
> On Mon, Nov 09, 2026 at 08:49:04PM +0100, Jiri Olsa wrote:
> > Text reservation checks scan every static call site. Build an address-sorted
> > index for core text sites and use binary search to find the starting point
> > near the requested range.
> > 
> > Module indexing is intentionally unsupported. Module reservation checks
> > continue to use a linear scan, avoiding per-module index allocation and
> > teardown complexity.
> 
> So this changelog leaves me wondering why, and at what cost. Why do I
> want to have this extra array in my kernel and such.

right, I'll include benchmark numbers for each change

jirka
