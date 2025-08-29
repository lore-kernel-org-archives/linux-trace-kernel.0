Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D041530ACE0
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756486983; cv=none; b=B2oLGq8qUekR+pEfdv/ae2tvQ0KiVtRWtvmI2Lzc6/sWDw3dm7Hj0wRp/2Kg+FVc1ozTIpTvDA8gZex9Yg0orGTpWNTD/E1GJZTzBRYslyBrv1078THeIh7tS7QlivRLnNgXC8eZ1S59dlQyNN6x4SKI9gkriCim+Dt718r0Y+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756486983; c=relaxed/simple;
	bh=fD4739ZL8XX1stZE9Og6p4xwwcsU6Q7KYj3wGwFxT7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlqvDlznAgSVHcnmIq/qnz7TA+3pbTCdHD77k/DvhtGTsXxH2+MzNNubp0P6tFPyiw2DBsr8f3N2fgzCyh7vno5vCoUDOlbH30ta1iEAaPpwVOQUaKbHCN7ZQf8yHaRNXJpKJkH0fmAEaOD/OUBgK468dRoEV9NJxfV3iORSRYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UnOkgM7m; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UnOkgM7m"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aff0365277aso145466566b.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756486980; x=1757091780; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ad3L86iH5Z7fm1hgP7OBtRKFsr713rsXkiJ6RmeN8+s=;
        b=UnOkgM7mJ7PumPkqlNpf9g9//C0oMJGPH8QnM9dw0pl6PGo+9kb58WybtYi3XhwL11
         OfIsdJ2UwS36o93j6C63B9t0h1XB/DF73zc6wYNvG/dkFSX+Q88tpiKLgZTA08Xk1C+d
         Pa4YrdtOnkblE/dmUSvHCwDxHQ7FrvDY4MydA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756486980; x=1757091780;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ad3L86iH5Z7fm1hgP7OBtRKFsr713rsXkiJ6RmeN8+s=;
        b=oCTULyuaF0HRNheFKo7oBSuy6f0I0RZpvHjsKbVBmi9BwjB6kMSkxxPI/Yrzqop7Yd
         5gtqWSLmthR2QHNVI1fQRibb4EVdup23HuoIXHwOwaEvZSVs0MWTSzZ3FPaVtsnp/uSB
         O5583Blw5agVHwAmuVGS1Z42iQ1GlLBtL6qSpxMPtnY8eDytmGDVaamUEb63c14DXBRE
         cBdQ7vu0Z3guWYyhWSgGLGWn1LsKu9E+pEkNHWDQnTh+GVXlybQqL+4Hgudp0qK29Q+Y
         d6jgMX/rxjdgu3zqrJ8BCoBUi8E/wyYfiOpBooxdZKgdPgi5XS5NvTc7oSCFw0xhoNlZ
         CvtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbdx0sfklL0rMAhG6y3pZzc1cnPGfvXgy1WrMRDnQ4zDPdExSN9EosMVOpuEH7grOPTjTDxQCFT9haAOAKFnbCOFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJzb4m9b90UuV1RsbNyhnztoGgwuKYx3fo2qmyBwFaxZT+IZbH
	d1hJN5iqs8mPNUiYlArt48Qbn2eKO0GoDNdXbDBBbD4WdCPn5uZRchpD0RPM4dPARCWc/b7uFDH
	LaB1XbdH5BA==
X-Gm-Gg: ASbGnctLqgardz0mPT3zAoyqpx9zZgLazR8V6n0/iqpRodpd2yaEPSfOxe6KvVN/rRz
	kzRHzVK6ILivCGX9Bhe7xpfxH/aqhYnOxyHlCVY5lOTYkKY2RSu6YfizZgw4bUYO/77snPZ9J+K
	pZxDbUsHJCH80R+ZTTE00tTda9qQJ9fkw2pSN/Cc4tpMx8n9sf5CbnoNKTscGNFfTkgqe7N8OFD
	ziIsF2drtJR5qFd6h/TVguTY7R46c4o8Jf/YIzzTFCDkmoCsazMVKp4EOdUK1uAjc2/tWhmFvTP
	VsBM3IA7r6h7Sjm7ikbocLNvKo6r+pdAGBUbj+VhhL6tEAiOg6s6cKdTe9sVUajGMzxG7e3oht/
	SEeEW5KCXRfkTb8KfuJ80bOUVgJD+/o82EgJatduSyoXmXUXFZUtXiLyjgzx6HqmcL5wNEm5N
X-Google-Smtp-Source: AGHT+IFCMwcWdhjsWda+dyfDeN3FodFCH3iru3/cPgStB9eDfmy3mZNgjeHVsNNPvsTqc08NnXJ5kg==
X-Received: by 2002:a17:907:1c1d:b0:ade:4f2:9077 with SMTP id a640c23a62f3a-afeafec8fe1mr1334996566b.5.1756486977783;
        Fri, 29 Aug 2025 10:02:57 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff054b7fffsm186135066b.0.2025.08.29.10.02.57
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 10:02:57 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61c7942597fso6747680a12.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:02:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVbxMweSBQDPRYZ4hyONQ/XbiW6F80aWbsGcdQPAmtdtjn2UzGN/4/lcMSFARoJh3OBnOdQrZfFtp2heVzPDJtwyn4=@vger.kernel.org
X-Received: by 2002:a17:907:6eab:b0:afe:ef8a:a48c with SMTP id
 a640c23a62f3a-afeef8ac7f9mr611238166b.8.1756486976814; Fri, 29 Aug 2025
 10:02:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org>
 <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
 <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com> <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
 <20250828161718.77cb6e61@batman.local.home> <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
 <20250828164819.51e300ec@batman.local.home> <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
 <20250828171748.07681a63@batman.local.home> <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
 <20250829110639.1cfc5dcc@gandalf.local.home> <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
 <CAHk-=wjCOWCzXG7Z=wkbLYOOcqFbuZTXSdX2yqCCWWOvanugUg@mail.gmail.com>
 <20250829123321.63c9f525@gandalf.local.home> <CAHk-=wgv11k-3e8Ee-Vk_KHJMB0S9J1PwHqFUv2X-Z8eFWq8mg@mail.gmail.com>
 <20250829125756.2be2a3c3@gandalf.local.home>
In-Reply-To: <20250829125756.2be2a3c3@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 10:02:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-ZfHXfXKtSNKoRXhNz10Do+mqDyUumEkx8H8OqVYP-A@mail.gmail.com>
X-Gm-Features: Ac12FXypzub4sT_YQp3-NVQ4K7fOdzCL-9SS4ZE75x9Zoqx6YPOM5EIXszDBXRM
Message-ID: <CAHk-=wj-ZfHXfXKtSNKoRXhNz10Do+mqDyUumEkx8H8OqVYP-A@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, 
	Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Aug 2025 at 09:57, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The reason is to keep from triggering the event that records the pathname
> for every look up.

BUT THAT WAS NEVER THE POINT.

There is only a single 64-bit number. No lookup. No pointer following.
No nothing.

The whole point of hashing was to get an *opaque* thing very quickly.
Not a pathname. No reference counting. No verifying whether you have
seen it before.

Literally just something that you can match up in the trace file much
much later.

(And, honestly, the likely thing is that you never match it up at all
- you can delay the "match it up" until a human actually looks at a
trace, which is presumably going to be a "one in a million" case).

              Linus
