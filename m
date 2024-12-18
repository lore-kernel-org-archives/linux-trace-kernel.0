Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AD01E495
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Dec 2024 00:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734480179; cv=none; b=GKDF+OCeUhKmvAQ9vyX2E9hnYye8JWmukLtY9NC8ehBhNnubbwId9lL/7X8vdhjIdI2KBMUxlbMgiatkbs5HRFwlF0X20kAcT+GgQvR4PvAT8D1TWbiUV0TSt6Ux+PFQGYc3vJfHqz0Dy6rd3+gvkW/mnNCvVJLS1/kKkbzi6wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734480179; c=relaxed/simple;
	bh=TzqYrtdHi6eNGmGGNshxzQLbW6aEixLNXnqSldxiIL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qMNhvMjFh1b2NPBZj/gh5r9LZ3xOHB3EwNjLCHBuCmtppdcQkPDsn9foH3nSA6Dkd/0ukaigbh15dr3KgclbwPsr8tnU5ypF1gIudQweVQVbFi0VIoC5uDlI1RClfeO1phI+Sr82aTsCFiQPuBmrMzhn77qsX+kOjZqU+xALsWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SHouGuIQ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SHouGuIQ"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8dd1so9887305a12.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Dec 2024 16:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734480175; x=1735084975; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JV+w9s52Xx8eRNhj+xW1leokp3ZTDX6dKUvSrTDSBw8=;
        b=SHouGuIQTyYQJFjj2oQBBa3NlfX8puViBRwhxPx4SgSB9gPt0QxNMbakTae/B/5b+W
         KrvXw8PeOxKWZBn9Wq7KsFh//8vTaC3Z2iNVIGkMkhDXqBcHwMgdZeW24OaT/5cbnaOf
         Og+iZ/EzdhfBBeDKUyV0guJCJe25VYwZds5cE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734480175; x=1735084975;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JV+w9s52Xx8eRNhj+xW1leokp3ZTDX6dKUvSrTDSBw8=;
        b=PzLPRikVho3lwTcedYQLAmZqtRf/Pj5uPswgIR30uKCoxHHcy7OF2HmnRtXov4vnkH
         qnOZgIT2HzBEzewG9W26CBz9aOMU6GeclYZ7mjcX+0+1KATMXrYE8bLsxpUvU8KuBaxf
         yfIDfx/Q0dHl5HHViT89NqxnoHFRhslRFmAfizcyONMy5ATcsLVP6xgjskL+A37NY+OF
         5/6D8IEWhqVmvyMtj1LO3up4xHirfemy4MoWx6cBQzllIWN6XKUhb3TCxq7ewL1CAkPI
         GHk6oPopy0dKQRiasNNrPQXUMS8Hl8Vfv58xg0D9KHtWOIbyKaN20Tkic4vOHEA0PuEa
         L0SA==
X-Forwarded-Encrypted: i=1; AJvYcCUVsk3XwuLkL1bjXr9XT+VoU8tGUumEtI6LwMUNbLX+/X1pWpBy50t4RZsN/T8RwXKvNXvhAOKTO55NN4+FtPwiXl4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw51f05CQhAawT2+VgUFsCP/QmO9x4y+AocGyQDv7RgO/+rA6Ok
	1VnV0I1dR4trOcsF8c4YG9xtaegb4RMU12KAX8ee7Gxcke0e3s2+4QWpIJ7pbtMKloJEh32semD
	eudQ=
X-Gm-Gg: ASbGncsruXt9+uaUY36XCi+WnBvz8oYd8T0tGqEnBKLHnRGD9u8UdxavwAbIsbrLWTx
	b0bHChmbZt07kJ2gc7Rfc1aBDkY9NBSDkUR6WdiwHW6xVbVk5JUaKZG89K0qMmn3P7CdrLh1JP5
	LLWu4a9wGeGcD5BlwHHcfLSuNghvX2X2NEMhVudoA3zBLrJYEdCQkvmv4NXgszD9Kcf3ZgHH+n/
	sYl49z6N9gXbyaxleAVY1bkuLczaEN3RHUYWu5IXSnn/dbPlXl2c02EhHPXurz6V2NCJ18cr753
	U/OoI96oL7bAZtv3sCP+ijdLXM3sWK0=
X-Google-Smtp-Source: AGHT+IE2nx8FwweFmvovFl+TmsAkcs0W+QtHkDpFjHRIPjoO4Fgg1wm4P9AmfvRJ36QxdlSjKrwn+w==
X-Received: by 2002:a17:906:31cc:b0:aa6:800a:128c with SMTP id a640c23a62f3a-aabf4719dafmr51942166b.11.1734480173750;
        Tue, 17 Dec 2024 16:02:53 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96006303sm491115866b.7.2024.12.17.16.02.52
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 16:02:52 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8dd1so9887227a12.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Dec 2024 16:02:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXGWVlNoJPdh8a+B5kLWH1dMd0OuYM67vAoCrqbXMoRxiO4cvjGuyuPZEr03PN1ChaI2XGckPmxhXFxhvbEukCK4oU=@vger.kernel.org
X-Received: by 2002:a17:907:3e8c:b0:aa6:650f:cf35 with SMTP id
 a640c23a62f3a-aabf48d50ecmr51073266b.47.1734480171482; Tue, 17 Dec 2024
 16:02:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217173237.836878448@goodmis.org> <20241217173520.314190793@goodmis.org>
 <CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
 <20241217130454.5bb593e8@gandalf.local.home> <CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
 <20241217133318.06f849c9@gandalf.local.home> <CAHk-=wgi1z85Cs4VmxTqFiG75qzoS_h_nszg6qP1ennEpdokkw@mail.gmail.com>
 <20241217140153.22ac28b0@gandalf.local.home> <CAHk-=wgpjLhSv9_rnAGS1adekEHMHbjVFvmZEuEmVftuo2sJBw@mail.gmail.com>
 <20241217144411.2165f73b@gandalf.local.home> <CAHk-=whWfmZbwRmySSpOyYEZJgcKG3d-qheYidnwu+b+rk6THg@mail.gmail.com>
 <20241217175301.03d25799@gandalf.local.home> <CAHk-=wg9x1Xt2cmiBbCz5XTppDQ=RNkjkmegwaF6=QghG6kBtA@mail.gmail.com>
In-Reply-To: <CAHk-=wg9x1Xt2cmiBbCz5XTppDQ=RNkjkmegwaF6=QghG6kBtA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Dec 2024 16:02:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgdFnwBD9odfSBz2zjedw1oWKKO3F46YAC_puE4b9J6JQ@mail.gmail.com>
Message-ID: <CAHk-=wgdFnwBD9odfSBz2zjedw1oWKKO3F46YAC_puE4b9J6JQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
To: Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 15:32, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But if you look more closely, you'll see that the way the buffer is
> managed is actually not as a word array at all, but using
>
>         char *str, *end;
>
> instead of word pointers.

Oh, and in addition to the smaller-than-int types ('%c' and '%hd'
etc), pointers that get dereferenced also get written as a byte string
to that word array. There might be other cases too.

So it's really a fairly odd kind of "sometimes words, sometimes not"
array, with the size of the array given in words.

That binary printf is very strange.

               Linus
