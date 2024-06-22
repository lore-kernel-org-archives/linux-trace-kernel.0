Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207837F7D5
	for <linux-trace-kernel@vger.kernel.org>; Sat, 22 Jun 2024 22:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719096520; cv=none; b=GEBSRs68fG690H30LRUJFrwxY40T5EtpgqxNQu6V7V5HdLXD+7vCYjodrWYYQwiZBVm6JyiMcyedap/xwjppOdj3Do/KzzezgOEYNf1trQSG1hFTzYkMJgjPLClQTFaI3T3Iv7OVDi1eCjKqVr7SGjDd/7WiUOyYYDbOJI4XAwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719096520; c=relaxed/simple;
	bh=kqyVjEgP3/7mXzKVNMbYCUNnf3n+IgnYTEx7zPeTiw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDEy7VEtjSbc8a1yw3hMh0hcGKSNz2JSwP0sCu2mvihj3vZpTcGXUpv4gAZ9SdCmU+2SDCLMzz8DG+Op3kX1PvCUiRqWU5WN8cupH+cyICf9JJoptsm4UIrkVGLk2Z7FTBuZoo5bO3yj/uZTm9sKDtxOYq0OAvRk3sW1KQyB2eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OQtH0SDP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OQtH0SDP"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-421cd1e5f93so23668715e9.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 22 Jun 2024 15:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719096516; x=1719701316; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZntylMGkkO3rfxQI8jPvTsKY/9VRyoYvjHsl0ZwmXlQ=;
        b=OQtH0SDPUlOWhSKtfD5BFNhyq+39/0wdra2XC8prlbc08xDHsb9Br7WnoNEgug8MiC
         xO+KNh95NtZXTNcn4o9DI5G/2DQOcgGmxgbZc2WkSzCBEUrZgFrlmyTG5Q2aJWaywivE
         WFBTHInrLn1KPbxi+XGFxs1AbgrgnmLF/Y3l8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719096516; x=1719701316;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZntylMGkkO3rfxQI8jPvTsKY/9VRyoYvjHsl0ZwmXlQ=;
        b=IkWGAuLQ0XWMhNgBaqlvBs3hqybAr/uuDN1iA5zZGW4mrJ6qYUY1E5Zxj+loCI2BKD
         dDFeGggYPJwWnyl38NmfRR0KZzqRpuyx9z4N1DHUqFHh6wimIfNRfuJPtKNugJ8Ap1/K
         jsCvZEs4KpFXkzkcQnHzmQ5+MLwaG7Bng+dT3iicXd5YAzT1LL4/3NMVOcfLsUlPfhxM
         V0WYve7E1VoaN8s42pxLJ8kgi2cUFV2bvt79J+vDCtBt5uJIJ8WWAm3kurVSUBCE3QA0
         wx0xvcclwArgdJerlD6VFqX/iFU3tQjsEzVW6aX0KjC8KL/8S2MCfAv3q6JySoxOalIf
         XRtg==
X-Forwarded-Encrypted: i=1; AJvYcCXkSXqbWkFpzK2CYhCtXRREacR6AGS9ruaho+ejZ373uBAgwC1M18QHVXbhxo2emFQOM+OAWK5FYU/Xzc7Cw46HJ2NqyQbMpFbspql7T2z1md+N
X-Gm-Message-State: AOJu0YwTYoDFJDCRTUj3b7qRU50AKce+fAOtF8FH4zdAeozRHrEOSD7O
	uVuWQOTWDbcErhVVxd84SRlbLr3UukrU2ZAyJ1QktDlVVQyMZaaQWNkwraGT+f5TS7T2cdMbN8R
	M/4TrJQ==
X-Google-Smtp-Source: AGHT+IF+f6Yx+fNdtcFB0AkL5/Zaxs9RBorlAz7dUl7LIOWK05Qrg11BLjV1GPlB3AoAjY1RMxcuEA==
X-Received: by 2002:a5d:5444:0:b0:35f:f6c:b971 with SMTP id ffacd0b85a97d-366e94cc56cmr537641f8f.38.1719096516109;
        Sat, 22 Jun 2024 15:48:36 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a724853d557sm20097366b.221.2024.06.22.15.48.35
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 15:48:35 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3626c29d3f0so1783568f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 22 Jun 2024 15:48:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWMTtMHetXybGo8IKIQcU8m9KD4reIrfNgoI0LTKQvaRj8IYGRM3mxBQUcgI5/q7eWFGYBEDy5FNrGYC+FNUoY97UhLYD1VIS5pSUiUU+Fiau/Z
X-Received: by 2002:a50:d653:0:b0:57d:785:7cbc with SMTP id
 4fb4d7f45d1cf-57d4bdbfae4mr617930a12.26.1719096096671; Sat, 22 Jun 2024
 15:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240622105621.7922-1-xry111@xry111.site> <kslf3yc7wnwhxzv5cejaqf52bdr6yxqaqphtjl7d4iaph23y6v@ssyq7vrdwx56>
In-Reply-To: <kslf3yc7wnwhxzv5cejaqf52bdr6yxqaqphtjl7d4iaph23y6v@ssyq7vrdwx56>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 22 Jun 2024 15:41:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgj6h97Ro6oQcOq5YTG0JcKRLN0CtXgYCW_Ci6OSzL5NA@mail.gmail.com>
Message-ID: <CAHk-=wgj6h97Ro6oQcOq5YTG0JcKRLN0CtXgYCW_Ci6OSzL5NA@mail.gmail.com>
Subject: Re: [PATCH] vfs: Add AT_EMPTY_PATH_NOCHECK as unchecked AT_EMPTY_PATH
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Xi Ruoyao <xry111@xry111.site>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alejandro Colomar <alx@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@loongson.cn>, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Icenowy Zheng <uwu@icenowy.me>, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 22 Jun 2024 at 14:25, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> +cc Linus

Thanks.

> To sum up the problem: stat and statx met with "" + AT_EMPTY_PATH have
> more work to do than fstat and its hypotethical statx counterpart:
> - buf alloc/free for the path
> - userspace access (very painful on x86_64 + SMAP)
> - lockref acquire/release

Yes. That LOOKUP_EMPTY_NOCHECK is *not* the fix.

I do think that we should make AT_EMPTY_PATH with a NULL path
"JustWork(tm)", because the stupid "look if the pathname is empty" is
horrible.

But moving that check into getname() is *NOT* the right answer,
because by the time you get to getname(), you have already lost.

There's a very real reason why vfs_fstatat() catches this empty case
early, and never goes to filename lookup at all. You don't want to
generate a 'struct path' from the 'int fd', because you want to never
get anywhere close to that path, and instead only ever need a 'struct
fd' that can be looked up much more cheaply (particularly if not in a
threaded environment).

So the short-cut in vfs_fstatat() to never get a pathname is
disgusting - people should have used 'fstat()' - but it's _important_
disgusting.

This thing that tries to short-circuit things at the path level is too late.

              Linus
