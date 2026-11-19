Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795087319;
	b=1Y3muD9JtxVW4crb9K13ybnHNA55XyByb0HjrvzPYGHkAI8CJbPsff91rCaA64NKwfXK
	 LZvpfGfCWheA7rMZKCF+QWOORJ+NTFKsXCgBho2Mhf+IEhNoTxZFL7AqRG+nzLww/isgp
	 WZ+fWb3tJG0m4SKUldbaHIVVJhDNvwI2NAynLI5RNhqKH78nx3boFjH6ARbQe50dcHvUD
	 tfVTbSy4FEUM9gcmiSm6B4+Ts7nk7QH9U/e5gzVU9Qn+YUnorpuhQ5qBRWgoSYmxMajhe
	 iEVkiyx+Pzzi9GBqTzG5T93EAqQHyB+BbdXRVgynILG3bR5eUTpPgCw2GxuGx+DEDHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087319;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=e7QbyMAcdTPueERTIe2W8rC7FaSuEijLUH0VfDQBIQI=;
	b=2O4r6i1s+yHCSXVcakA4faGciQqqPX3vgkaEYn7aelh2hm13qCUVCjOHAJrqInTnhBa4
	 TozypAgygaap96EFBqos6PyLAhFHTaSc4q4la9B/tB15Cvv8H3QCM5X6eHSKjNelVeaxM
	 Z8pJBEB4GgnMUmICJRzetlBTWvUnF7Wdqodduobmv3rPCEXEOqH1MeHAhdOVocWBmvzSL
	 aostK1PxmzllqERkYz5hoCBCLFGVJ8v7P8KBV0v/uRxS0b8L3+9V+SXaqzhkHEBT4iafl
	 nFC9lkrYqZBvIeSg3xabf+HdSWoEJHh5MPaWYUWrdkvd0m8Kj6sfmPLAjYCGJKZDoKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sentinelone.com;
	spf=pass smtp.mailfrom=sentinelone.com;
	dkim=pass header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=Z4mols3g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011EB606A331
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 11:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 011EB606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=Z4mols3g
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b0ac1900efso195438a91.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 03:21:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795087318; cv=none;
        d=google.com; s=arc-20260327;
        b=SgFxWw192fTw7ip770cL9owqXvyCINuv1GdYoB7mQ5uDC5S01Hmkh6m3wbkkOMGKyL
         xHIuM9/0ytTWXThD7FCRTkJSCXZSH/JLJACJbx6IR1vNWGGGJKfPdn7no79wpmHaHYnB
         XDdUpcP9EB6kMH0apGmNUWvnH1buGIvlNXWQySjee9SSLBqwew3HFwnMXey3XiRmgJc+
         9pTcNfXnZt8it5Ujiv5JG3ee8e7j/57JpAvh0PykGEOMx9n6o28xGmhbIB2I8zFXA447
         Yc37ItC7BTvrIsDEC/xwSyv+zrXxCVUKc5F0XdZkqISQvXiopILNf44qJSn74YGw6ESD
         nDmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=e7QbyMAcdTPueERTIe2W8rC7FaSuEijLUH0VfDQBIQI=;
        fh=RPM4gU4aks6sEPDPGmCZ9CoOiQ4jCdtlqmGwbmz9ya8=;
        b=OryaCUe6iaq2q9XfEGaLo9EhR3J/JzUgY5PCrEFyGE7scYITXdRXjj8c+/bu2DBhfp
         Vld6dmajVbV08dJJMpIRd/ARwAldZrvydjLQtS2c798XNruuYjYlkDmkwBqVPMPZvVPt
         zfTShqwi8q4Klahif1KM1lTwCzUPqvJJRE5z22C5ZoMa9vJr4fGjEC/5joU22bjUSYPe
         p0QzFE7G4/EE817WuW8YhXF0v/k/lDHLlo9w4/G438KoRluac0qOtGTQdD4LARCLlA0n
         kyw0xrZI2zQ1EA31q0WRNAHMbWaJybC1v15uOviK9oHMBHmey/UyZwuxIUZdLCoe27nR
         9g+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sentinelone.com; s=google; t=1795087318; x=1795692118; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e7QbyMAcdTPueERTIe2W8rC7FaSuEijLUH0VfDQBIQI=;
        b=Z4mols3gn9bqimDi52cguSw/2T0WTaWDVxdxz6zcyZXyPgg4sGM6Q+/r5Aj7Rzapp4
         h4quJH7omFkk7iE4D1JVrPEgmWV4GrtURSbA15/kDOpfGZpA58rouU/VUzeMHkx1S+F7
         Hz9s26xztX/RE7p9nVIAfXB7l4QoNZ8jWho+SKI9PJDvV8FShCDPYBBuiOZ3HvFMBFhO
         v3hpLPm3gIQEI07GGdkMFokdCQWvgs1JkPg/mR2mEUTp972OXoxMqhkZvLvtSKmLROjZ
         b2Ss1p4URUlPL5cH7XnchQ8UvXl/BfSjp0iGlBz6WajH/WD0dm7i8pvOrVqQJWga0A5w
         J7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795087318; x=1795692118;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e7QbyMAcdTPueERTIe2W8rC7FaSuEijLUH0VfDQBIQI=;
        b=szMy8OMBMy+U2PKgrnBoShD93hVCGF4ona0c2fpmXUUc4hnLXRrDUfx46pydwct5vU
         LD6MLu0MJL9WnrR2XwvsMvoyuiao1xBqCOrVIOIQh4lCkk1obHXGLttFqXXxRY2Ys4Z9
         KvqBb6j2wogR+b6uxyGYT1jhLCDsfcJlQUKhVz/XWSwizcO4Pg6iJhYh4YGdU/8By/Hc
         xfH1Siku4K7dPbaaBoRhZTsdPWCelVrAQ6763cNVrzQGjEns3olSTMaen0crg6yzFhMT
         Gc+d8kKDd6IS5W9q5itI2aK4Pdvhy0kcwyRMnIaRkXEahrC0cgVKLkhsNnGYgc0wiT/J
         67HQ==
X-Forwarded-Encrypted: i=1; AL+hErF/9w/2YQzGixNqYzc0ColU1OHuQsGWZh4xqZnBtK8aeYy0umjHU9xmVopOoViIEnoyePzN7ilHrDG4xbhNkaHdPAQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+JdcOwq6pH+dr2uEO8Yxq+T3Ah14SMOpHCfa9z1VPaCWwSSgRq
	ZoxjKBuuNfpgB3US0VjPspuOlp6WINm9O9RcZZHWpFT8ihh245qfCIr3ahKMlLy1JCiH4Ezax+D
	iiFgD7dyrSk8dQNnSSq6J6Ir546r5KxICrevskz0Z+A==
X-Gm-Gg: AZFdTZdnGzUqkj5sjiDrWqgvZl33uM9KWM7i4wrkkGyd5+tk5Ojiq+4efVNRU4CrxJ0
	WgKhWFGQnqouQHWSOq868xeGClXBHLWL98DH2XNPlR92rBw5ryGhKLKrl898g2IL+P7BkL/hM0t
	zfOvDgAlXj7jw/TVUM02v0DYRsgpc8k66b3GcfXDEgszDTz61yjUKo0HDtoHrroc+EvMJ1HTnQN
	4MVJNjvgTGxflDI6y7gPaIl2WIoNgh+cPM+fLIr679nYYMclufSmLk8i9+X5ZzGuTkDvkM7f4/i
	DyMdlvJ+ptsFp5fqBOoKFjYokwYKWbilIwVsCgRor8dZzcyACoXRWMaVr5QBmfPxonIDmZ8Ipbd
	gsfS9y5q3EGDvbuiTrIMuXnPPUsYu9II7eyx3UdbKLCbZzBZk1Fd1T5U=
X-Received: by 2002:a17:90b:4c11:b0:3b0:9e2c:9b55 with SMTP id
 98e67ed59e1d1-3b3d06bcc48mr9840688a91.2.1795087318201; Thu, 19 Nov 2026
 03:21:58 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com>
 <9a47ede3-24fa-4fa3-8d7e-50f221de0929@linux.dev> <CAPnbwjpmRCR3F4V3StUz=702AdWZzHHZjP68GepnYdYykjoC8g@mail.gmail.com>
In-Reply-To: <CAPnbwjpmRCR3F4V3StUz=702AdWZzHHZjP68GepnYdYykjoC8g@mail.gmail.com>
From: Mike Bazov <mikeba@sentinelone.com>
Date: Thu, 19 Nov 2026 13:22:00 +0200
X-Gm-Features: AclHuK9_wchn9jrgtgMQTEmt7b1vm1t-1CBFRs79WS1-atFN5hx7C0543m1ETUI
Message-ID: <CAPnbwjrQcd5R0aqNKeJV3wWuMcTTsxsamxpKVpKY7Za2xKB1gA@mail.gmail.com>
Subject: Re: [EXT.MSG] Re: [PATCH bpf-next v3 0/4] bpf: Check recursion per
 task for preemptible programs
To: "JP Kobryn (CrowdStrike)" <jp.kobryn@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Martin Kelly <martin.kelly@crowdstrike.com>, 
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>, tyler.wilson@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"

Thanks for testing, JP.

> fexit (marked)                61      135

Marked programs take the same per-CPU counter as before, so I expect no
change there. How many runs are behind these numbers, and how much do
they vary from run to run?
