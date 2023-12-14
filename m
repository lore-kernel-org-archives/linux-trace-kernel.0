Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA29433A3
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Dec 2023 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VpMKTsYD"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e0ba402b4so4726858e87.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Dec 2023 12:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1702585828; x=1703190628; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JS5aqGDyH1ekW0+NktEKhGSSqL1J+90vZeAFR9levjM=;
        b=VpMKTsYDlF0fDx2aD5bLACrR4ppRPkerfgjOPK3prqlXKTVVyCu/r2kcFk6Jen17YG
         3O+inOjBa3tOUjE5Y2IGtooieGeOlSclzrG9QVJ4s54UZ3wprzfOM9mmLuOwOcYAg3rC
         DO1Iey77w3mg3gqjW/n5UgwreEeFOwRnnops4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702585828; x=1703190628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JS5aqGDyH1ekW0+NktEKhGSSqL1J+90vZeAFR9levjM=;
        b=CenMOzt23DOkN2lkRcmM3QVIv9nu0jyHGn22c8Eb1IzhiFTaaEjTI32M6VRcAYXzJ3
         LGHKFNITJj8vmz+sbbxxsVzxQKfE/X7nzp7BFkqUOKkMgZwu+wIr4AKAYnfpOa7oW/4I
         TCB68s5PDVb0rJDQKDj6YX4KIq1QARPIYpAqXr/mzH1BZvaWcTtbML9eANivIxauhcJT
         EM5sQYQkfXCTxrT7yBGmtdzS5+bMzHuHngZIKSS3JI1X1YlyynTGJfu82ZeQyJODXeQh
         /nHW5+Yvlct8gb1a8aWA+uCdTDFAvOkCRHTS6+C23qL0krRfZ44p3PrPJhxwClixba/y
         YpQA==
X-Gm-Message-State: AOJu0Yx4pwViqTweQDTGLHswPxbn5WqXhWBsW0Zkbn2oIwoHnwIPcnqc
	rjXD9T7FobSsQ8W393oTlKtxrx6ZPHQEUCqoQMsGe4e7
X-Google-Smtp-Source: AGHT+IEtjkiI0XpLMa0TNmvvXKrSRpZm2IgF9W+OOvZj4AUS2iZIEkrM/kdMuro23q6/sRjcCSltzw==
X-Received: by 2002:a05:6512:48da:b0:50b:f1e9:b0ea with SMTP id er26-20020a05651248da00b0050bf1e9b0eamr5251635lfb.100.1702585828514;
        Thu, 14 Dec 2023 12:30:28 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id qo5-20020a170907874500b00a1b7b0cc30dsm9821686ejc.7.2023.12.14.12.30.27
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 12:30:28 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-54c846da5e9so8028805a12.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Dec 2023 12:30:27 -0800 (PST)
X-Received: by 2002:a50:cbc7:0:b0:54c:5d34:980c with SMTP id
 l7-20020a50cbc7000000b0054c5d34980cmr5413656edi.82.1702585827509; Thu, 14 Dec
 2023 12:30:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214125433.03091e5e@gandalf.local.home> <CAHk-=wiKooX5vOu6TgGPEwdX--k0DyE4ntJDU4QzbVFMWGVXFw@mail.gmail.com>
 <20231214151911.2df9f845@gandalf.local.home>
In-Reply-To: <20231214151911.2df9f845@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Dec 2023 12:30:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh5XgB4Jb9cRLe6gh_C_wXK3YevqCLi1BFRk5z1pJDkQA@mail.gmail.com>
Message-ID: <CAHk-=wh5XgB4Jb9cRLe6gh_C_wXK3YevqCLi1BFRk5z1pJDkQA@mail.gmail.com>
Subject: Re: [PATCH v3] ring-buffer: Remove 32bit timestamp logic
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Linux Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Dec 2023 at 12:18, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> For this issue of the 64bit cmpxchg, is there any config that works for any
> arch that do not have a safe 64-bit cmpxchg? At least for 486, is the
> second half of the if condition reasonable?
>
>         if (IS_ENABLED(CONFIG_X86_32) && !IS_ENABLED(CONFIG_X86_CMPXCHG64)) {
>                 if (unlikely(in_nmi()))
>                         return NULL;
>         }

No.

Read my email. Don't do random x86-centric things. We have that

  #ifndef system_has_cmpxchg64
      #define system_has_cmpxchg64() false
  #endif

which should work.

NOTE! The above is for 32-bit architectures only! For 64-bit ones
either just use cmpxchg directly. And if you need a 128-bit one,
there's system_has_cmpxchg128...

                 Linus
