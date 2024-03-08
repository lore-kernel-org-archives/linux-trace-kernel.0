Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6547D604A3
	for <linux-trace-kernel@vger.kernel.org>; Fri,  8 Mar 2024 21:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709933976; cv=none; b=I0gWLHDake9UnpVq5V+D29lQh0bOygPtK/CAhwGzAyxAebuqqhU/oNoAeMa32meCFXyQLinnMTxyuOwqWFHAp1oOKIsgf0mPC+jIw7x2cmSBPJvL9W+OLEb2SLOr2sA2pigLMFTmertdC+QmC7YUZwn6dz6UE7aZY28/gCzW1xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709933976; c=relaxed/simple;
	bh=a7v96kmQhDkc8Kx+zJIfhWvdsBlkGzLICy5mfG0ttH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGDeM78IRxGTSmSifjOTvcNTEEk6qk66POYaK8yalPxCh4jnY/47vUo4hh1J8p+FfCyNYAEWJqTN/JyTPO/9muFpHfs7lVznGVcKD0gELjJp9lKaEogX+uPtEDNfZf9GTrAjKArBqUttR2zlx+o9OQetjgaTSiT57Oet+yUfM7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=g7Kz0q5D; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g7Kz0q5D"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a45c006ab82so331579066b.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 08 Mar 2024 13:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709933972; x=1710538772; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ivKkfUleh9PGqoywIX/iRlhl8v/B2TOp1fqf3Qv6buM=;
        b=g7Kz0q5DpZYrPg3eHabd2YVDBEIDCZu384/Cu9FPlKF7xXFL2Cbi8ir9IhEvJ5cKAH
         2I9bH0HdzshhRxNiLNBBV17DVAtFZv5f/X/ccSJ/HiqPaTIqMumw/SZFvwICTQ2Bk88/
         aBcATymiHtMHEhdCiUcVI5Lh1Ox/ZSSd1YwgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709933972; x=1710538772;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivKkfUleh9PGqoywIX/iRlhl8v/B2TOp1fqf3Qv6buM=;
        b=BakII/4/+v3VNQJoYWctHANS1x4A5YScgnP8VtpgEQl/P4qiSKO1ICwLyOcPFb8eaD
         wneb//LXh4BSlM/gnGhMXRR8ziXDET3k0wQ1fDz1MH4nZt2K2xmMcAv6p6RFOAP1vyyW
         hRXKMHiGwmOGTo+gERdj3fig2LL9R+WMoozlMKLoey5U/leRGah+xZhAitcEVc/iH/Y/
         uwPYvsHl9wZdrkIDp4Erahk2NCJ6Eq//6zM7tacH+raLenrnr9wzMFKtxIE3cdrFnC6a
         nURdRmCCynNcXZvHpc7BbRwPyHXTpvvrsKWLrUxb4dommhtG/zjcyxNr7R8yB+qU/MHe
         sBpg==
X-Forwarded-Encrypted: i=1; AJvYcCVxjGJJwlOykFOJB3n1gLYPK9xcDB9gHzQ1raJiSHx0aLo3+QAmFz9gVn5v/7Rsn49Hh2qSMCVUF/0ywoQ6vGamDx1w8+A59pCFlfxGsLeoBtOF
X-Gm-Message-State: AOJu0YyZIJ2H1If7xhgF9THHjfP4HQsWSlCYuvDDfbZBJHtPIMoMscH9
	j7cl4gj+IGUMy/bL7qo07rPE2DYilZLyB5Rlhlc7umbxTlUB2FSmaDPSSRYSqU8ML8B+LCBIB8L
	gNtfbaw==
X-Google-Smtp-Source: AGHT+IHb+Njd1jmGqnB8z4ExZOOmJpH/9PF+FVmjKFY8bRlAt6+MMsaAfy/zHXkwbIcqBlmt75warQ==
X-Received: by 2002:a17:906:f0e:b0:a45:2e21:c78c with SMTP id z14-20020a1709060f0e00b00a452e21c78cmr198739eji.13.1709933972486;
        Fri, 08 Mar 2024 13:39:32 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id hq11-20020a1709073f0b00b00a458680f004sm188642ejc.125.2024.03.08.13.39.31
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 13:39:31 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a44f2d894b7so348418666b.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 08 Mar 2024 13:39:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXbCANGDlrrADIT7y/m0NnTNQZsldc0HQikOZlkoLNvBkt/Op4zm+wwPGUPZlZSHnK8aOizuBz+tJeI1dzTJ5WR/vTHg15oqCvxdaW9WImPg3/7
X-Received: by 2002:a17:906:f6c9:b0:a3f:ac54:5aa1 with SMTP id
 jo9-20020a170906f6c900b00a3fac545aa1mr180745ejb.21.1709933971409; Fri, 08 Mar
 2024 13:39:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308183816.676883229@goodmis.org> <CAHk-=wgsNgewHFxZAJiAQznwPMqEtQmi1waeS2O1v6L4c_Um5A@mail.gmail.com>
 <20240308163528.3980c639@gandalf.local.home>
In-Reply-To: <20240308163528.3980c639@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 8 Mar 2024 13:39:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=whaVBe14mbW4QWNuywBP_ZvGJYRZ3dbgx9-ebSxnNTXiQ@mail.gmail.com>
Message-ID: <CAHk-=whaVBe14mbW4QWNuywBP_ZvGJYRZ3dbgx9-ebSxnNTXiQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] tracing/ring-buffer: Fix wakeup of ring buffer waiters
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	joel@joelfernandes.org, linke li <lilinke99@qq.com>, Rabin Vincent <rabin@rab.in>
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Mar 2024 at 13:33, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> There's two layers:
>
> 1) the ring buffer has the above simple producer / consumer.
>    Where the wake ups can happen at the point of where the buffer has
>    the amount filled that the consumer wants to start consuming with.
>
> 2) The tracing layer; Here on close of a file, the consumers need to be
>    woken up and not wait again. And just take whatever was there to finish
>    reading.
>
>    There's also another case that the ioctl() just kicks the current
>    readers out, but doesn't care about new readers.

But that's the beauty of just using the wait_event() model.

Just add that "exit" condition to the condition.

So the above "complexity" is *literally* just changing the

                  (new = atomic_read_acquire(&my->seq)) != old

condition to

                  should_exit ||
                  (new = atomic_read_acquire(&my->seq)) != old

(replace "should_exit" with whatever that condition is, of course) and
the wait_event() logic will take care of the rest.

             Linus
