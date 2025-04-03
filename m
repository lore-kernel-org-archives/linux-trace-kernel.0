Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3D12512CF
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Apr 2025 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743698894; cv=none; b=RCOtAHYsH6mSgxl1zsnzQr4TVSaXks+0MoSp9F2G7uhmGV2NOKhuksbVnz+KR0vm47Umk9LjCovNqL1ju4+54io1P4sLiAx1Nc5mixFs3s6h6a+bpmGa9cWXxzvLNmHEX/VZKfkxIlgEJ/kygv4LSCLml6ccrq3lYCCZwmYa5JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743698894; c=relaxed/simple;
	bh=tOhPfAjNck/fuEMBPjbaUAakEcHx5aW4W6Mm4+qEg6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UCKZT9nUKwGfbyn+z83L45vbhBVUAWl6WevkEqxt2Dqhgv6RwwizDYlBP3C+JsbYMSNC2RiHHufdPTG2pparUm4acFL8JShBBJmCSuZ6DSl683rmtSbZuzKWJAWx05/eRgOAk04C4RG9pmkUV7O/9zOkE9SQlq1NqditQBqfo38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=B2QY69jc; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B2QY69jc"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac73723b2d5so217481566b.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 03 Apr 2025 09:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743698890; x=1744303690; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5IeBQ5EurNMkDT+fQ3nS/eQb46kO76MprunhtwmK6a4=;
        b=B2QY69jciSslWGGIl5tSiU2zq7lhABiHbYUXup0NlogFaNrgwMz6jXR4NDoPRwyUQd
         KGAkQa3l//maVeWHxghTr9f43zkVpDnaBY4MXfFP443p+tSl9rucCfIEA5YqJo0Ux1Dg
         oLX32nf9h+4ejZ392+WqZkQ1RQIt7GD29FhF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743698890; x=1744303690;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5IeBQ5EurNMkDT+fQ3nS/eQb46kO76MprunhtwmK6a4=;
        b=FZ6/cTiQkfm5zsdQ4j2+hUfsWqG9YaWHeVitagSh5nErXjCyp8XDQMvTRfhoe4mcSk
         0R9SYYysgiOxC0bJFdpJrSJfllg2MpanrAEy296qjmax/85bpMvqC0aKbF1eZYGO5xt/
         8J05Ep1tx1BVKii3mgBLIIZDZWOZV+gYPvKoLUCbo4WW6X/j5LUdpZMoyDwT65alSKzp
         24V/n0nGaeBFLedJ85YAqGrIoozJfG+Jbr9Tno46iViX/VhFBORNCxuosWKnmIJM3R0r
         LIWnRGNQXAikhQnaVbVhgu65AnrApnZajCrhTDtR4yiDhIVGoPgXo7sjhO08gpIm/keh
         KcHg==
X-Forwarded-Encrypted: i=1; AJvYcCUK0tOUkj7ZGReia4vRIrGBInRytsiE7l0/mYh4oOkBaSPt3uc5RpR4xRZXGzMC8uNvT/EypZQ3Kuoh7vvQWmKK2ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoLx+yAuk5hz3ePQfsRLIqLkBG11oXlUy/FOl3i3GtuMBFO6Mu
	4JfJ6GqT1BLu64wuP2IF1YUC0/9xTxcYZLNzXvMRyXOXe/5+Xdc8CBtg5Ep9evgej+A2e9wrPNX
	ZTts=
X-Gm-Gg: ASbGncuttqKbnhX/qQlX+4UqaaVBtR1oencfvyGpenaWsQWuNLoqy/wATF53ZnbNEdc
	Z3sOXVMeGC9yDaBtN1jazVCq3fkrrmcXQDdOqKPdqVKOl96Dctzz1Aw6YBs57xOyAL8+br1/CQH
	fXsh0rgHAgOgsp1JkeXFzuH/f9NytEf108997GAtiR7Emzp+F963uc4oia0lgA9FAPiOFXVzELU
	k+f25EO0hhHww4w3nmkQ+I1sAmMQW+euSjVyVSy6h3V1vZQgxFmc4o+an/elKvv/ecFjCGao6W1
	BY8pYsu5SKOYzq3Tm5fhOke+OKQAy8sHqVzHMYZwzvuZ/HpOOiXhoDAiA/v5dH7bFsRs0JZZAmH
	J+kAievonIznuNf8qfUs=
X-Google-Smtp-Source: AGHT+IFC9yFbnjWrcJc1K9c5mtkqmZcyU4UTuVOtHr7BTISaUQZLvT9ZRglhLy3D2UmqGnEM+eT+fA==
X-Received: by 2002:a17:907:3da0:b0:ac3:bd68:24e4 with SMTP id a640c23a62f3a-ac7d1b812bcmr25201066b.53.1743698890204;
        Thu, 03 Apr 2025 09:48:10 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe5c924sm118032166b.30.2025.04.03.09.48.08
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 09:48:09 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5cd420781so912869a12.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 03 Apr 2025 09:48:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUySycmqYFSkZjzm4dmOCzfYvIV4SP3BsDG0rPE+SjLzYpfQUAYlTdaDjqTi0OXGcIy4Ks+ORUabUylOM4yq5M5NiQ=@vger.kernel.org
X-Received: by 2002:a17:907:3da3:b0:ac2:7a97:87fb with SMTP id
 a640c23a62f3a-ac7d199c916mr29245166b.33.1743698888537; Thu, 03 Apr 2025
 09:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wg0wQb+CbUk2GY0CeVuTQvq67-oYR0nL8wGgySia3ce7g@mail.gmail.com>
 <Z-4jzImykAbHK2Gz@gondor.apana.org.au>
In-Reply-To: <Z-4jzImykAbHK2Gz@gondor.apana.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 3 Apr 2025 09:47:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=whch6fMKH8FadOigqm_xrXfgWJyn=jz32GM6tUuM=nqvg@mail.gmail.com>
X-Gm-Features: ATxdqUEfHA6tq4tIjCHeUdY_kmVbwhB0XtABIt9Eygs4AQmADpeBZZvH_WAQpHA
Message-ID: <CAHk-=whch6fMKH8FadOigqm_xrXfgWJyn=jz32GM6tUuM=nqvg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code do
 the vmap of physical memory
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org, mark.rutland@arm.com, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, 
	vdonnefort@google.com, vbabka@suse.cz, rppt@kernel.org, kees@kernel.org, 
	tony.luck@intel.com, gpiccoli@igalia.com, linux-hardening@vger.kernel.org, 
	willy@infradead.org, Eric Biggers <ebiggers@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Apr 2025 at 23:00, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> There is no fallback implementation of flush_dcache_range for the
> architectures that don't need it.

Yeah, that literally looks like an oversight.

Probably because nobody needed it - or people didn't realize it was an
option and did the "loop over each page by hand" as in your example.

So yeah, I think it would be good to just expose flush_dcache_range()
as a dummy empty function in <asm-generic/cacheflush.h>, with the
usual "if the architecture defines this, that will override it" rule.

However, part of the problem is likely just unclear semantics. Because
the existing flush_cache_range() is about pure virtual caches and how
they need to be flushed before the TLB is flushed.

Also about D$ aliasing, but there isn't necessarily any TLB issues.

Honestly, I'd personally be perfectly fine saying "nobody sane cares,
and if your D$ isn't coherent, your perf mmap won't work".

                Linus
