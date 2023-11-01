Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316FA63C
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Nov 2023 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nCR0Tl8x"
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAB318A
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Nov 2023 08:18:31 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-457cba20cb7so2776390137.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Nov 2023 08:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698851910; x=1699456710; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9RB7BfhgpRCUBVJO5uIDlwkrn/lyyD50XG0yLUMwIqk=;
        b=nCR0Tl8xMzZJtARG7shYdxMc+x+3+CpLKn8w2U3UjJbYZ38qrWg2shRSHQiBw0YbUi
         NWZzyQnqu8s1iBAmn92k0d28H69kT6tpiU7nbGmFXImamcbryF1+FDE5RtwCLlm1E/jq
         RwxEVtL3K/p7wF7pa7RAJXZ1gH3Kifj41vBGu+XWjHdihBagXGys4lepKY0TzP7qUFBl
         tXlWa6N5fDQ4MpuHi6Nqb219q4WhmKyoG9GEUxLw6kHIMTNWGgjN5PUUWgz2F6M+FkuB
         EgVNmN99mxzSfnzQHWax7KGX8rR9hzEW44spjmnIB4f0u6MfXlar6+hL4WwahVGyNuI0
         FQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698851910; x=1699456710;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9RB7BfhgpRCUBVJO5uIDlwkrn/lyyD50XG0yLUMwIqk=;
        b=t0YxyMyKp0eqZ9WvaRfP9/mlqAcbFGGH5lOG/nYIQSVqDLDgonAtaNNwKCjS5dUXfr
         Ve5QawCv6Ekoz/T24hcx4lWdONHGnwPwswmPbygtBDa33moaSNQgT3AMneSc1m0C7Xjr
         3S/L6BWD9nVA65k+c94IeN6HTchJ+MYHfo3sbXEXac30ohwxwJTd1xabx20W3PLG/Se0
         ++ydjzvnnBQToPNYdjzJQR+R+6RbvKIJmpDRMDDfpunO+snFSj2dF27ZU9/98QF9SCtz
         heoF9kMFHGp/DvxejoMxWqLgGf1tpwZ0iCrkTJTnu7JEL6EZLA1P/LMNfrpZGH80AbYy
         704g==
X-Gm-Message-State: AOJu0YwVK3QE+Gda2/VNV1qDtNe7+BWGOEkV25Y6YYLewp/OBU3R7Jdw
	LeGVLsT8yRpLqJfOECu3GT94BjEAsKQy+jZnerqt8g==
X-Google-Smtp-Source: AGHT+IGUVnJ4Kri5RWsIPeqzB2Au8woVRnmkFohfQGhuwqW6ihHKnI9RyhPRUbH6QEbNk9siiSJ56wW5hdjEJvMH70Q=
X-Received: by 2002:a67:e09b:0:b0:45b:6afc:6819 with SMTP id
 f27-20020a67e09b000000b0045b6afc6819mr9117223vsl.21.1698851910053; Wed, 01
 Nov 2023 08:18:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYt-XxvA+Fg5+htpqy8ySAtY-q+dGD_FOvmzGJOPbAySHA@mail.gmail.com>
In-Reply-To: <CA+G9fYt-XxvA+Fg5+htpqy8ySAtY-q+dGD_FOvmzGJOPbAySHA@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 1 Nov 2023 20:48:19 +0530
Message-ID: <CA+G9fYu0Xix_eZBuRg1+MdVmUDhbFcfR5FeiU8VzgMa__M5iow@mail.gmail.com>
Subject: Re: stable-rc: 5.4 - all builds failed - ld.lld: error: undefined
 symbol: kallsyms_on_each_symbol
To: linux-stable <stable@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Nov 2023 at 20:38, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Hi Greg,
>
> I see the following build warning / errors everywhere on stable-rc 5.4 branch.

I am sorry,
It is on stable-rc 5.15.

>
> ld.lld: error: undefined symbol: kallsyms_on_each_symbol
> >>> referenced by trace_kprobe.c
> >>>               trace/trace_kprobe.o:(create_local_trace_kprobe) in archive kernel/built-in.a
> >>> referenced by trace_kprobe.c
> >>>               trace/trace_kprobe.o:(__trace_kprobe_create) in archive kernel/built-in.a
> make[1]: *** [Makefile:1227: vmlinux] Error 1

I see the following latest commit on stable-rc 5.15 branch

tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols
commit b022f0c7e404887a7c5229788fc99eff9f9a80d5 upstream.

- Naresh



> Links,
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2XXALLRIZaXJVcqhff4ZmGTeZoQ/
>
> - Naresh
