Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968F533769D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756487636; cv=none; b=tQWsy9UBwHUM/fX+yAK5R5Z5DEMVsOVbd9E8lV+o+GqRiH5t24XZGqoa9P2dk/zpZXC1+Ix2l1pCdri/AnLHHaSELwj0pYLIhzNX9+Kwqu9rAe8WXeEdwdCcnz9qo3rlW6k057AnsI1kOk5yGL0YcN2zajKs+H2mqja+Q8J2NbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756487636; c=relaxed/simple;
	bh=iHb9WdSbAWsQISH5SeW0HmAsw6mcHOltHvAyxrfR9Ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rlw8Ae9VRJKINZkOz9lf0DF3fV+e2qlHPVufZ5br6WdgQN0xCNti/GgfGsQJ6kNQWFWIkTZWlB5hfkugIfzbNcWluNGbEX0Xp24ip/nRA2oRbCN3+0BriIGYbd+7TQl5hwdjeSnV2J8TDn43WDP+HU80zDJIm8UQ2c2B+PWZYro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bVCZqOMX; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bVCZqOMX"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61cd3748c6dso4606561a12.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756487632; x=1757092432; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mKGIjOYE1ze9iH1dgqLKf8Xyy++WiMU+AjEh9bVOYgA=;
        b=bVCZqOMXZSYmZlyZ/7dEJk4j9UZNb3JUk/4cBlq1kM6F2x0TepqBeERJUPxx2HYNvF
         S7Ldxspw4D2RfgSRJ+PJcWU27HHyn3zWLDZZ2PpN77vQCmIr8Ni5jGY1WSf+w2a3oMgQ
         Su3xS4HQPRI88oFFOIGsE1CKr53pWYowYGnLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756487632; x=1757092432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKGIjOYE1ze9iH1dgqLKf8Xyy++WiMU+AjEh9bVOYgA=;
        b=eO3VK5oBYPrKlviPM0StyP2cbTV4tfD6J6FK115yI5Op+xoYQpBgJwuQ6mzYeGpiWX
         NS93HinY+zIxldRLfrr2hecxq79Oe8a2WyKYC53tklZy8m7O8HQZF2D1lpyh/a4djqvY
         23B3z71QufptPDgqIALJj3LZs/0Llxae4Do9uxBWHLRIqg7/zQUXfJN8W3vqqxDJJrBu
         IMC28/L2N5o8Q8HEqM5Bz9A6zcUijT2Cq1jeolN0A2WWvFHloiRjYxfHu7iKEEnnao4i
         lMsH1VYFYDuG8LwwgIIlRjBz16390T5sDixf4z2T2zpq0ZuMbKsra6BGS/C+gd6r8Odd
         57mA==
X-Forwarded-Encrypted: i=1; AJvYcCULDe8TJgQyylSJNFqpLK45CMCyrgZU2NeA6uaRGf3bdNWndo3ORnPKqrzFvOJZxzjiXqpC91v8jy4tF7KCtOge9tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YydeBxu2Nuvew49uoyTgsSC3BqCbdSzPV9bl/TUTPaNugHR7v7g
	WkEMYL6AzrIHWqto7buLSJKMwTPQvzz+8qKmN1WjwMjad2Bl/m+oAFIbFk5pv7r7/FQi3KFmE8o
	EnO8+9//2Ng==
X-Gm-Gg: ASbGncua62GCUDgIgoM8xr0RAzURD8UtgMMT/LNGaZctaWTXZ6KojlRL1hLFl8ErJoZ
	hNClRF6knqt321SadOjlCSaQVneVS98+wLTTPb9itDnc8zTS2SQ5XSk+iiL0OtemnNtmbM0X9Ru
	2upgCouU+WgwvWu1CgcZIvFZ8QSP1L+LMqoHgL6qH5n1DyhFmM5cKj656Rn4KnaV2gCwA2he8Ru
	klmTbnb2eihpUlOb6lhtveCQc2iwbhXXXI+HLGX1aptzVVfzV0DIGUnRhOjz/NHh3w3BwYPS7Tm
	bsqYg8eqyR1ZEwI26ZaaIYeAgP7H0c2j2r+qNuL4sI2UfA1Je24msN3e8rEvJsZq3yuGZgUHhcc
	M3ns+/tyEyEA5bA7n2WeJdDFOFJWkMjiRnmWRBhOxAsaBgthlJUnoxM6SJRani1DN2RDbwp9OyG
	RQ3Etc/4o=
X-Google-Smtp-Source: AGHT+IGeSsGXPbg/3bAH7LPcLla/XPFUOYNtfQ8dYRU7EoyFrYLFM6Cg1REqvcrFwDYpMd0XqPnqQA==
X-Received: by 2002:a05:6402:2801:b0:61a:982a:3738 with SMTP id 4fb4d7f45d1cf-61c1b6e49e4mr24091168a12.30.1756487631679;
        Fri, 29 Aug 2025 10:13:51 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc4ea764sm2031609a12.40.2025.08.29.10.13.49
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 10:13:50 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afec5651966so430187266b.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:13:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXzohIDhFXB5o3JGu2ReZjx5woLPlYZQqBsIoUC3QqtoVyillivt1WK8bzTjUXK1J/XjR/iiBF4s0Fr4vWAu9xWgUQ=@vger.kernel.org
X-Received: by 2002:a17:907:9410:b0:afc:a190:848a with SMTP id
 a640c23a62f3a-afe2962294amr2593662266b.60.1756487629636; Fri, 29 Aug 2025
 10:13:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
 <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com> <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
 <20250828161718.77cb6e61@batman.local.home> <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
 <20250828164819.51e300ec@batman.local.home> <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
 <20250828171748.07681a63@batman.local.home> <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
 <20250829110639.1cfc5dcc@gandalf.local.home> <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
 <CAHk-=wjCOWCzXG7Z=wkbLYOOcqFbuZTXSdX2yqCCWWOvanugUg@mail.gmail.com>
 <20250829123321.63c9f525@gandalf.local.home> <CAHk-=wgv11k-3e8Ee-Vk_KHJMB0S9J1PwHqFUv2X-Z8eFWq8mg@mail.gmail.com>
 <CAHk-=whbHyKvJ5VSvObfmGSSEukYhv5DZVhR3_-smu_1_b54mg@mail.gmail.com> <20250829130239.61e25379@gandalf.local.home>
In-Reply-To: <20250829130239.61e25379@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 10:13:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3muqW7XAEawu+xvvqADMmoqyvmDPYUC_64aCnqz-WLg@mail.gmail.com>
X-Gm-Features: Ac12FXzOUr821UWDaFJ2PkQOv_cHIiiBd9eyjGJVTqCl8VoWLaBc08lTL7Mwpbc
Message-ID: <CAHk-=wi3muqW7XAEawu+xvvqADMmoqyvmDPYUC_64aCnqz-WLg@mail.gmail.com>
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

On Fri, 29 Aug 2025 at 10:02, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Note, the ring buffer can be mapped to user space. So anything written into
> the buffer is already exposed.

Oh, good point. Yeah, that means that you have to do the hashing
immediately. Too bad. Because while 'vma->vm_file' is basically free
(since you have to access the vma for other reasons anyway), a good
hash isn't.

siphash is good and fast for being what it is, but it's not completely
free. It's something like 50 shift/xor pairs, and it obviously needs
to also access that secret hash value that is likely behind a cache
miss..

Still, I suspect it's the best we've got.

(If hashing is noticeable, it *might* be worth it to use
'siphash_1u32()' and only hash 32 bits of the pointers. That makes the
hashing slightly cheaper, and since the low bits of the pointer will
be zero anyway due to alignment, and the high bits don't have a lot of
information in them either, it doesn't actually remove much
information. You might get collissions if the two pointers are exactly
32 GB apart or whatever, but that sounds really really unlucky)

                Linus
