Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FE3442F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Dec 2024 18:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734460989; cv=none; b=Q3E3z3tDjCQ8/XFzXlsC5X6gMgS7aeI21xYnjBl1ElkiTD8ELsvMEDnBqRDhXG2MG+hMtqG0jDckhgb8p/oEqljpdJbJfM+BipCbYEQVpluvXmi+7AjL2ItQBMnnaT4MZVvysdQ6944gshypVmkg5wVaB7/D3quHYyZ3Cp9DioY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734460989; c=relaxed/simple;
	bh=MFBOghCFQxrMYgoC0DhigqYvAwhKz8jTiCtMSSCoSqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNiTAULfwLTBvdP7fftmoc78ZxIsZjkJSvpVDFnVpe8/uWtTpMRe6lIRVnUSFbIbh9FXK+rfaXbJshJtjC8SXiB62ELusIzRqf1Spn3GlZqcBwiqsMr3bukmKI3ZoYckaAlcyrxUJ+4MaQEcf7QxCaAAmygS8yMWnDC0deL1p0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=X0uM+rDO; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X0uM+rDO"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa6b4cc7270so756240866b.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734460985; x=1735065785; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3mQXudYgFs4URfCivrY8wmstofKcT17DyeXJ55pVZ80=;
        b=X0uM+rDOnPQqvRuuiwCm7yWFx8lrK4Jsx0P3CeQFn+6/txluiUjW3WkY5G9fkHDr0d
         xiAx9/ftwVuB4ZhrEZGynL921LWqgLNnmIuLp/u0VCnPhb1bZIOqXv6PDqAtEFUBxh7E
         dcRkHFKl+wekEq/ltOQkP1KT/EFqYGRpsJCdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734460985; x=1735065785;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mQXudYgFs4URfCivrY8wmstofKcT17DyeXJ55pVZ80=;
        b=FtxvPxwlW6LRBLmcANNr8k/lVagH8wJbO/kZaHvrx3hv10T1wtl2WqzHWJ2abUoYbm
         6snkkrwQwAEI7Qg1dV/RiIAne165bol8MHDXC/Itqn1iwTVFufW5coXUPHwn+/X6AsY4
         JhnGKmo1bkWVv/rGKOY28X4yOYIgb8e/Hy38ShsQIk/GLCX89Gi9ddrG6ajuKhe+Rh1m
         O7YfxWn51lmZu4VS5eBT7c0sTyBNtHppjUw/t2wcj3IsCtpdVnoOrXG2CfusfgOE8gSM
         xBJ9NZkYrzlkElr/f2O0lcmdby+TXb8bzoiB3HJyuAqwhq54j3gDU3MPmMwuzCB7ACIY
         pKIA==
X-Forwarded-Encrypted: i=1; AJvYcCWGiN3UnLMG2FbWP8dUfFf8ilLdP0nZlasvYlFapOOSYSdlne6IZTsuP1Htwl5XJ2eBwJNMWSg3oAizChGKNhxbW5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIluTW0zwApkixQD64uQdgTVA3Qu8vPKWjzD9yKkqIjqFIcK+v
	kqCKRVfm9naoWy/vu+PpcD0l2doG9F16IGR56yxqQnKhaf21lM+s4d0+ZIaTlAD7tXNkv9eSTo0
	4/Rg=
X-Gm-Gg: ASbGncsP6CV6hEerdPnJWp65yGXm8bLGPkrQAOVkXDheuNEFClaHUJryVBBKy/EWaDD
	9mcOm/pL2ISrqErNzWgJ+iI0WnhmeGzK8Ud04DjH4Tuw7bGPGaEu1ijCsW5zw6jMoT2JLTJU8uO
	QS7OZU0c+lDvLd/WaiSKYPtA25m06ufxm3paqvrH29GIVBDRhb7IUbV8hLcbMFZGq8RKMaB0HPY
	h/zzj9MzLCC/iPV/6+J/MoYXkCF7kGhvMxMO8GVIvwzKZVYJXuUssxrL9kS9PNXevz7zlRzbUN9
	8k2bl7FvvaRlq3aJ7+/Q68dxsmY9Jwk=
X-Google-Smtp-Source: AGHT+IFbGB/bZ5qYY90eRREEqiB6zeJWyFZa6gAbYWtWyYfn2XON9OOfBy0Vt6RqO6xtzykipgT9HA==
X-Received: by 2002:a05:6402:13cf:b0:5d0:d491:2d5e with SMTP id 4fb4d7f45d1cf-5d7ee37b60dmr360614a12.7.1734460985545;
        Tue, 17 Dec 2024 10:43:05 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96359e5bsm472841066b.116.2024.12.17.10.43.04
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 10:43:04 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa1e6ecd353so761582666b.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:43:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXrrMSBR/6GLyqp8n3ADKLaXOKxYqNizMvAWRRu/FlpI/0xOyBDVJB6kCnAhk2/AKzr0JwMJ8Vhez2JGlWQu/aFCzA=@vger.kernel.org
X-Received: by 2002:a05:6402:40cc:b0:5d4:55e:f99e with SMTP id
 4fb4d7f45d1cf-5d7ee3b57d2mr405372a12.18.1734460984008; Tue, 17 Dec 2024
 10:43:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217173237.836878448@goodmis.org> <20241217173520.314190793@goodmis.org>
 <CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
 <20241217130454.5bb593e8@gandalf.local.home> <CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
 <20241217133318.06f849c9@gandalf.local.home>
In-Reply-To: <20241217133318.06f849c9@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Dec 2024 10:42:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgi1z85Cs4VmxTqFiG75qzoS_h_nszg6qP1ennEpdokkw@mail.gmail.com>
Message-ID: <CAHk-=wgi1z85Cs4VmxTqFiG75qzoS_h_nszg6qP1ennEpdokkw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 10:32, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> How else do I get the function name?

My initial suggestion was to just fix up the boot time array.

I think that's actually wrong. Just print the raw data and analyze it
in user space.

> I can make sure that it only works for core kernel code, and print the raw
> address if it isn't.

Streven, STOP HACKING AROUND GARBAGE.

Your solution to "I had a bad idea that resulted in bad code" seems to
always be "write more bad code".

STOP IT.

Really. This is literally what I started the whole original complaint
about. Go back to my original email, and try to understand the
original issue. Let me quote the really relevant part of that email
again:

  This stuff is full of crazy special cases for things that should never
  be done in the first place.

Note - and really INTERNALIZE - that "for stuff that should never be
done in the first place".

You started with the wrong design. Then you keep hacking it up, and
the hacks just get wilder and crazier as you notice there are more
special cases.

This is now getting to the point where I'm considering just ripping
out the whole boot-time previous kernel buffer crap because you seem
to have turned an interesting idea into just a morass of problems.

Your choice: get rid of the crazy, or have me rip it out.

            Linus
