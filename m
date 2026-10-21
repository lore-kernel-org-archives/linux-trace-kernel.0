Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792620073;
	b=gSWtgeIrEUkPgEOXICEtS2ZL98KO6aI+cKtz4KrD2ZxfU6vWRQW+/zYTaOzEgF6Z6vPR
	 oPX0CpMHuSoRvKcy9PsB88sjqihH/Zs0On/+qUDYuDFES3e8/iQb9VUcsOAMkxnwfIg3N
	 v2iKxPy1NuqM9DUaaLADkeCU3tQWkKW56Ifpxv5vQJvNBHqJ8W7ATNZ0yJAuGvsUd9Khk
	 Q8KYxzlvoneuk5u1NGeB7TnrcjMa/9jNhEgZWPyy9xOCmr665Ktky5nXCH5+3hJSVPCq7
	 dJhooVUnYw3CYCEEKM8au3kH1tT/DjcGgnYAP/8nxJbslW9ebop3lqBdyF/xERbRFug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792620073;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=ekANNG852YX/Rv0SYRliAvOikAthVPOfNHHk1KWJgg4=;
	b=UcYwTr8BUn/HjELEjKaC3hJ5ag28dQsJCDuf3YW7fCLG4Qi1IhQia1T3dFnZFOnVJhW1
	 O19ehoXkFkGl0+0T83T2nYAhR40nA0ZzvdyUDEK12VXvg+sSmwvKHW4fhogkm0RfrgNHq
	 4XElBxwWpoYu7vy9o/BAqMO2dkuNREuUOLa45w0W3CofEGlB64dS2SF6ZfZerTI4ZRsu/
	 DGJUeifEdD2owGiWT6eVxh4IZ9YvbXVmEQmSW+MvxI6IwXFc36WPeKRmRDu+yisb5/gqo
	 2WQML0bIO5xHw/wn5ETWf4JEzB3Yl93gTlqsUK0XMtafsm3kU/BWwbEy99mhliyZ+iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ezRxCH+X;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC594606A31B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 22:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC594606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ezRxCH+X
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a064dcfcfdso380329b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 15:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792620072; x=1793224872; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ekANNG852YX/Rv0SYRliAvOikAthVPOfNHHk1KWJgg4=;
        b=ezRxCH+XFN6kqXAzUkHG2tuyt8LY9Se12NNEu6NCx7Zv8JzLColYWlPyghLRXld6hm
         xZDWfFEMmj6UzTmaikg6Y8318LeQ5mTF0RtV9FAJAfzSh5gQS/qFqIyjFEUI5x3l9lNr
         R/yIsuaAtmNPhm/1e6maqY5TwrtWTXBVM9Gn8GuxITZD0CQ3PsV7i6dVAcCSByahXTGR
         5fvL3Kj4C8GY9JjpuLmhrLTQKJ0PcLhfeSPhwwIB0tnkzDXjQKPFH+gAQwG7KxXESkdu
         musrbh9L5xzU8OLHo+AoJ0AWoSAI5mdC8PO1sWksCBobfztW6ACBhalN0Z6F0mCiXkdd
         wpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792620072; x=1793224872;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ekANNG852YX/Rv0SYRliAvOikAthVPOfNHHk1KWJgg4=;
        b=N7GGjg2nO9EFqyVllRx0BAaBpbqeTON62FxslhG1RsMf98M5wJSJuOHtTTvN9dfusq
         V+trC6oOkBwp30PKI87tw+k6nai+HxMxq8spBko9kWrFmshDLzdvs4QTGn3bQaSMYABR
         tdGathb/v/KwlDMVRmJx3W86+F92AqkliACBqHCDdZz9V7eXRqWV+yHCqVx5FlIElhaL
         11mw8fONWQNL3wMC8lGAuRAeQKXE79FxR+xIrsRVT8T/8kqCIdMVPmM84YtG4mUkAxTL
         xA1EcLtEy4B7fSnpoeD++Csje8CDsL7j66J6L2SR3oOKjz2sTYWv+/qOmMQ8mJvDWm1C
         E/qg==
X-Forwarded-Encrypted: i=1; AKwUvBwai0RHsZc1G4bjCWOMvbOlIWkQ/S14oVcPVjHkJDWzRSDem7BivRvcwYrpjSl6dNcNQphkH99Wa9wkvjPLoVUKyYQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKu0JB1ipMZJ4fugcxBU/VG08bii1UNxhF1PzGNHR114Oh6JmrR
	Symird0fX2F4eHLFZGi7Ly3KxVHOQkyEik1SgfqBWvUTC2+dxXLiKSLT
X-Gm-Gg: AYBFou0SIcqHoqjnZvwZ6QVhKZPeOkIt/Gt4V/k+6wfv90BonWWu5/Nle8L42hQwacH
	a4bzmOO/10KmyqcmnKRacZ55ly7V6WBaZqKGqjQpwCeUlAWg2j0wQDzJddh5pPOBqnfwUgCbePL
	gB08nNWP0cfV4EHif3TnobH/NmeB0FhSDwVr7AePEL4tWicxY9hYZpipBFAiMwe4AdYgttogexR
	RQPX5+dpz7aryG9LYZDj08eSnyifOyIhEdHhtHd3JL8Y8N3XeOIFB1rrrNzykamEPkrGcnZ/fH1
	TKhKNZAs+6zOpt9XseZ9uRTQLsfY9OmwzcFh/uPgpjIJ9AHgjGBR1MY+Kn9O0WYa0zCyayb9V0x
	S072GmVmOp5/A55zrr/WtazX7rKOgANdQ49cJYxmXEab9cfrhlqXxHqAYzuFCzNgLxAuL3dm6jT
	4H9PLWZpByao9pjxhyulbKVLgj58FJr9LF+/7RpFv4Yq+Jd1B3CCb9taoli7wrPSy5N6tC934/s
	vj+2tuNn1Q9LjgtoMY6fcLGBBmulOX6k3Ynm5igdJ18wXbxkfUIAbWg9mppCJUajSCLWv8m7kZS
	S6pfefHEEFcj6CIfHQSSyb8tOeYFdE182imcgyTtGn3Jbq7ngme5Lgsbtn1A
X-Received: by 2002:a05:6a00:e86:b0:87c:e6aa:30e4 with SMTP id d2e1a72fcca58-8a089d79060mr2663523b3a.48.1792620071973;
        Wed, 21 Oct 2026 15:01:11 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0895c05f4sm1334306b3a.28.2026.10.21.15.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 15:01:11 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 22:01:10 +0000
Message-Id: <DMAUS3F32198.M27YWDF2F3UV@gmail.com>
Subject: Re: [PATCH v4 0/2] tracing: fgraph: fix the quadratic shadow stack
 walk
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Vineet Gupta" <vineet.gupta@linux.dev>, <rostedt@goodmis.org>,
 <mhiramat@kernel.org>
Cc: <mark.rutland@arm.com>, <mathieu.desnoyers@efficios.com>,
 <andrii@kernel.org>, <peterz@infradead.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <kernel-team@meta.com>
In-Reply-To: <20261021174406.2891598-1-vineet.gupta@linux.dev>
References: <20261021174406.2891598-1-vineet.gupta@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Oct 21, 2026 at 10:44 AM Vineet Gupta <vineet.gupta@linux.dev> wrote:
> On a 60-core Sapphire Rapids machine with 400000 idle threads it took
> 227 s, inside a single bpf() syscall for the kprobe_multi case.

Acked-by: Alexei Starovoitov <ast@kernel.org>
