Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793263559;
	b=07YkqA/Od/wrnBQPjC87ysrEhL6FBFKlmmx3K1dI54/BP3RBm34ot0ZjSa3ropvug42s
	 z6hdNCUiqAKImw8OWWkT0u91N8e14i5/ZrcYlx9Y3xXRgb1YphLL/etgUMpQC7CfzNvcK
	 VDCfONSY7P/f/ZlNGdVLJG39UuisiHOtNfSxBCEpldBNU0b27LVAlo5uOUF1SwRNi5oe/
	 AbMh9Fk0w4EO3OEPxOd/EzHFvUEDrM31DFo7HcaV1vG+GhiinUs0LKW+vR/4eqqZiPH8z
	 wFStbtPu2UH3oLP3Rrgu3OZSMeHIn3jg7rhI2FfOf7oC6zmqrgePbfXfWk4XRgY7kgA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263559;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=PAqiTMoWWwPC+iS0a6+A9B2UUx92tJTBgbIRi8GYKxc=;
	b=x+6ITjTkA/Mp7XNoo8tMoG3v+KRC1YztqB70K1ZnO6wU6/TMPzroGa9DjfddQCJ+sRkD
	 kC5b/ifCQTC83y2TLNgxl+35Qj3UQdTdswt+5eoGn7oX9ALrjch1UMwgGblPGsfqZZCWG
	 DrPn4YjBq27ZdUqsFKca47p448cowl4+y5MWguqGLhY3O620aMfvh05qh2jKpM5SkznGc
	 aD1q2hkv4NvNEpwZpYXW+ZR0U14eh1tbJtfeUftN/sX8bzUzNONm7pn7EMLYafOZOjg8Y
	 jrzX/RVKt6zZm3nJlNEHcWGchV0nzo0sXteiJi1Pp5unvSYc4HWKPhoiJ1MtzXTtxlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=au0UfRoZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144D5606A31A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Oct 2026 08:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 144D5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=au0UfRoZ
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-82380b0f55dso976128a34.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Oct 2026 01:45:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793263558; cv=none;
        d=google.com; s=arc-20260327;
        b=PZJspLm10zkBchlMpA0AFtTffc/VjmoPK5rPC3GJGi04TzV3eh3xK0PROx2VXSsM4O
         VEfIaHYI3FLcfcl/32SXYFaMR5lDkWtrVOG/3ASafcZrcXy9kskKkd5Y7N4TIDfMnaIw
         wr1Dk0MIJHw4IvHB4nSnHpZFWuU7F2JN2o3UWt83FJRSQ3hsa9TS+lOdUh8GMCVo4RPI
         GLCoGg64RA0upGSlV/8wW4eDv8OS+aaQCRiCFoFYglW5psVzJuculrfUk9w6/pUQA+Oa
         fcuY0gbGVj3eAxaJ97cW7C9Yt38mrLseJX+ju5LN2sOTuKCIkcfWSLuT47fZBx+k5T2t
         i1yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PAqiTMoWWwPC+iS0a6+A9B2UUx92tJTBgbIRi8GYKxc=;
        fh=YFWpbAPRJ8QtTHlIhXOhDQWdTEozQD4PBeZajH2Qb1M=;
        b=sU66vkgJWU6gXQKXU0OtRhn/pgI+qD7VpUDBkutU5s9ME2bs2QpEgT4jBgYQCpSO9g
         OyuRoMJjb9thPUDHeW2N/+r5o67B5ks/P1mVbRQodamTwFgWrkpL0Hiasd1G2Ve7YK2f
         VnHSTSozJWuLv+c3Z3bV7v3vLk6HqLKxOmReaaCs3qxBHb0Cxe7Kv7UKGin/0kaciFWM
         hxSz3Gsw4Fw42mWdhzNKVyjBH+Zel79FNfc5nsVuUxN9LJ+PaybynvvWus3cB7KI33xU
         aJYgDiQnUQcISqjisPm71SOUDJak6t/Gwn3Gl+guNXva8l3NJJGE6dWOEc2n2IDQCtSN
         QASA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793263558; x=1793868358; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PAqiTMoWWwPC+iS0a6+A9B2UUx92tJTBgbIRi8GYKxc=;
        b=au0UfRoZT9OZ+PogXKMiA/a4a83jjA29tx9LOXcH9z6NDNHLMfjOwwveXDPGNs2LCK
         I2hkmGMaPmoMZZnrglEFIFGXRWYhyGowSoMs0ZwlWNWYIJL5VqKo2p67y4Ni5ouO9+xj
         AUBt/yhhEV0Rjots/ox7C5fw/JvfzQMQ6qLqbbc1nP6ijbLbGUoa4cSyboqDSsCTSSPp
         SAWcQFZWU2rvqV44Igv+sGf2zpyt/XU5ylZHGjYwPEhK1Gf4rSj6phkcwNpjQSWOUUbg
         gnB+obPQ1DJMaIcPgS5iQatWb0gpH3K1SP41tpP4rcxE1w22oXLjG0w9tlk+j7Ct0KiG
         f1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793263558; x=1793868358;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PAqiTMoWWwPC+iS0a6+A9B2UUx92tJTBgbIRi8GYKxc=;
        b=a5l/8rvH9Iw00He1dNlL2SuuaNDSfeaVFc7simxPQ9ZwLncp8qg53LTXw43Ekh1t7X
         QFzsCC0cDO4q97cLGrvZmAGaOXFb2CyDP8Jm7PtHXtj45ulavHXxRm0K4koDGSEpm6wk
         GV9Sro/azWaV1oh9NnCLJXQTFkhSaWgwMvbug+AtgdQTcgqR3dCLQE6NiXp4yBZQw0wu
         hEOs3VJhuhHyzzdSg6YHz4JAr+CJZiCoJD5LX/4lWqU0Wd4VPP9HonoAHlrQvBOrcR1m
         vF/C1FY5h0cqf5vvfdM2QktM13Bi7UD6+7gZOEgJbpakORQ/nzXx/XUrFrl+FUuu78Xf
         CGiA==
X-Forwarded-Encrypted: i=1; AKwUvBztZ4ifoytsvUlW/1ubXp6H1gDxu1BvrZLD6jbfjAF2CB8pEa8jyRRFQ+F7GuPlYb8124i9hhJeMxQJE+kU+n1gdCA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIl/9oz/WHE7XeR2AZtxKDUNXtdcEvTKmBJhPfTBbvBiaz7sQLO
	g52ilzYYI09OD1XRyUGsTMiht78h2Nr3QItzLgEOLGuTLwlMEBZm/ndBDXpk+P6It91P4W38t/7
	91ETNQ5PQrTu6sTqOxhfpIjFTqDQdIaM=
X-Gm-Gg: AYBFou0xIxPFf37nVcjHAoXKrOWy/MGyrLI921PiaRxi3jD0MED+Ueg/uuj8FwsLd/n
	jIAfm393wkDofDG4ob7a3oISWDxZ7M8hpJEO/iPCJEGvpWA3lvh36KvV5mzVEN0nn6UMfOjesch
	QGR1Q6n+y8uK6JWWGl+zi2O9TjkdWyFiirIT5Q99qDpXjqdayF5KxraMEBg4T43Q6ft6/Vue1Dw
	pJyTZjrAOvxswmXSkmhyG1v33lLJMZUyAHu2SnK68Ily/+IfvZj12jojLJ5yjflK+fR4EUx6wv2
	pFdtqIvrytHFfSoLIWLAIi1CZZmXYk8CvbdYh7EZTa1LoZMDcLqZ2Zjuho+EFRUvOAKPO17mqK8
	COlPqdpmmUjSeXhzwDiK24AjJCIG1jeTaf4OacLi2wq1DBM94FQXSxabpozMJuVFVzDiOGq8=
X-Received: by 2002:a05:6808:15a4:b0:4f1:5068:b95a with SMTP id
 5614622812f47-56382c84c84mr2564899b6e.23.1793263557980; Thu, 29 Oct 2026
 01:45:57 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027073719.4010659-2-thnkslprpt@gmail.com> <undine-1793236109048848648-013753fe98f18601@undined.local>
In-Reply-To: <undine-1793236109048848648-013753fe98f18601@undined.local>
From: Avi Weiss <thnkslprpt@gmail.com>
Date: Thu, 29 Oct 2026 10:45:45 +0200
X-Gm-Features: AclHuK-zrLquvdqJ3SzSpP7uOV6gERwOur8Jmu30wRw3AWJ2QAkVsioGlaIaVTY
Message-ID: <CAKOB7-ZixMNzdcizYL9Re+zp1HMO1kfr87PHytAmwmBOx7zKEA@mail.gmail.com>
Subject: Re: [PATCH] init/bootconfig: pass init arguments in documented order
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Cool no worries. Makes sense.
Thanks Masami

On Thu, 29 Oct 2026 at 03:08, Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> On Tue, 27 Oct 2026 09:37:20 +0200, Avi Weiss <thnkslprpt@gmail.com> wrote:
>
> Hi Avi,
>
> Thanks for fixing this! This looks good to me. Let me pick it.
>
> > start_kernel() appends command-line init arguments before
> > bootconfig init arguments, while setup_command_line()
> > places them in the opposite order. As a result, the
> > arguments passed to init do not match the saved command
> > line, reversing the intended precedence of options.
> >
> > Parse extra_init_args before after_dashes so command-line
> > init arguments are passed last.
> >
> > Fixes: 1319916209ce ("bootconfig: init: Allow admin to use bootconfig for init command line")
>
> BTW, the Fixes: tag should point to commit b66fbbe8d482 ("init/bootconfig:
> Reorder init parameter from bootconfig and cmdline").
>
> In commit 1319916209ce, both setup_command_line() and start_kernel() placed
> extra_init_args after command-line args. It was commit b66fbbe8d482 that
> reordered setup_command_line() so that command-line init arguments come
> last (to allow cmdline to override bootconfig), but missed reordering
> start_kernel().
>
> Thus I will change the Fixes tag as below.
>
> Fixes: b66fbbe8d482 ("init/bootconfig: Reorder init parameter from bootconfig and cmdline")
>
> > Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
> > ---
> >  init/main.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
>
> Thanks!
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
