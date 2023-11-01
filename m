Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526EE7480
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Nov 2023 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gojnSgNJ"
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8C9109
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Nov 2023 08:25:08 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-7b6e3dc54e0so616341241.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Nov 2023 08:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698852307; x=1699457107; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SfiHwz4JZCGCwOFzpsQX+9HxRoqlRbBYRIA8jQuHjhk=;
        b=gojnSgNJNWZTFUvUV3ymj2lJ9sKywpT1fHMDi1Yiv+t69IHzCKqfXJYC29qOcwcmeD
         KoecJrPUI6bsCIH5O2kL89TEibdWrwaEtl04bfyMI3DbH3mkzT1C7OrDlYaTKWxnD2rD
         InyDywG2YfDzFk8LUSt8eRoRXDFCCqetezMABK9hzdZzhMv7acjW6ZPypjNuvwMaaDqh
         B6pDksBCVbsfjMxP+H9E0XMRY/ypG5GPpT3mEZRn0WxLBuMHYFwRnHLFPmn1zVQ1CzXS
         7EezqHc74TIHk9sA6qSIqUK8j1OcEKSwnAgwCtXfrviN5JhdVARyNjtoXpSiez2M9ZPi
         afdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698852307; x=1699457107;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SfiHwz4JZCGCwOFzpsQX+9HxRoqlRbBYRIA8jQuHjhk=;
        b=TY7P1Mitoe8YqeEuiEUSAyLJomUTjB/MyrzxVnsWHhMTkyxYpiT0cXNpk4TCIDmlmb
         uaSBCKAvb3l7583s0Qc/o57U+Ipk6rx3vYUPURm4yE81ThzJzQ3OX0EmNqBrFKHY+KjV
         6l6Ib1xDV6DMXVsClJpbWWD6A8fGKjY/yDeSxIAuaHVh1o7r4sqPWOVmAxpuYywlNuvz
         fvYiJZGCiMaX4jPeHYT3G5i7hhdPb0mMi0tfp8r9decg9o6EYRGko2Lk6YEyq3A33q6R
         wBiRQ9Likn+MyRgKyThn5BYM3y79HUsFPyoo8oVpTbdL47cYigO30DQQPV53D9+bnRPz
         H+dA==
X-Gm-Message-State: AOJu0YxL/+dFcWZcKd7YOGbWTcYY3cbJAFWEmEQGRJ5aCjyLFtQhFafI
	dvRP2aIV8YV/L4B4bbPMAUw19KmXg3IrdrNCx8nfvDF97JXrNU9JSVtVtA==
X-Google-Smtp-Source: AGHT+IGB9b+1rEPVTrYv4IJ+vUsXCoo/tQMZZ3ZEmvnr6Jqqi+qZ3cnyKNaOVAab5gWZdhD70XttrEib3NGJJP2FEY0=
X-Received: by 2002:a67:c311:0:b0:45a:a173:aafb with SMTP id
 r17-20020a67c311000000b0045aa173aafbmr3587060vsj.12.1698852307068; Wed, 01
 Nov 2023 08:25:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 1 Nov 2023 20:54:56 +0530
Message-ID: <CA+G9fYuFUTr+riZ5bREOowR_QsspR9n_UC4pLCJQGxksU46M2Q@mail.gmail.com>
Subject: stable-rc: 5.15 - all builds failed - ld.lld: error: undefined
 symbol: kallsyms_on_each_symbol
To: linux-stable <stable@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

I see the following build warning / errors everywhere on stable-rc 5.15 branch.

ld.lld: error: undefined symbol: kallsyms_on_each_symbol
>>> referenced by trace_kprobe.c
>>>               trace/trace_kprobe.o:(create_local_trace_kprobe) in archive kernel/built-in.a
>>> referenced by trace_kprobe.c
>>>               trace/trace_kprobe.o:(__trace_kprobe_create) in archive kernel/built-in.a
make[1]: *** [Makefile:1227: vmlinux] Error 1

Links,
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2XXALLRIZaXJVcqhff4ZmGTeZoQ/

- Naresh
