Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8763B2FD1C2
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Apr 2026 07:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776929317; cv=none; b=AMJXpnR0R9zNvoPcV5zGcFepXDZnckXyFu2SpHOPvTwI7OtAi+U8KvjQJleFuHC4DJ5zhSbEACbaEf0drxjm92xw9BoML8aCNw28rc1mXJOQ6sUUMkkPfZ174qnkpMxHGgs9fR1eDg23HumsraZIv00rkItc4a3cupKxIVriKmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776929317; c=relaxed/simple;
	bh=WOppIZrBNo3RcYtvFtLVrZmytJcotb0AqBF8c7GVOVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6PIcrL10L6fZkGMZYtsQFgyVWbLWOOuPhPTj20IsMGRbD/X3Pq6ljW1xSDlNjTvCLKMlooV8sH3uIXCMoI2rpGir1InbVB2lORfe2QQcdKn4ECfh2X29gdeNzVoXMgxYC+LJu1xNNFGRGEr79VsnRG9VV+Dvzy5es+hb3kv2pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-944168e8c5fso3853412241.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Apr 2026 00:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776929315; x=1777534115;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlFZtOeHAVGD6oxAHJWQ3NW409GkmoeA2VYFJ7x7mFg=;
        b=g1dv0qwFRwyP1jkyHrJ999NVVdsRyF4paCSKzdqt1XxamoPjzkMqSvbK3vceopKaug
         27Tcb+vuprh5/gPJcfWTYC/R6h/PMGiSwvIFKOfNHjlGcJ0Rm3nIemcsYeXvg2flTeqX
         hRshyXrn2UIhtXrtCI9go4hHBN58D0LJeeUUG/9MLrmgn5LoA96mOp6pAYISwRk/jiBM
         GugqmI5RRAayDtY6702Udt7PCISKtxFYLKSWfiXmeI5hR7QrCSEsrecapuRtgNmhKc9f
         QTn/Y3RAvPFTUI6kd5CDfaxb6lhi4ZLQcjHEsKGlaYgCzkYuGd7PrW4YISaEWfauOH4n
         Ob2w==
X-Forwarded-Encrypted: i=1; AFNElJ8/d+W7VAXFNZW8wp/8OJvNUDWERi9ZNjXe1/C7yO/g6M+sYo+gvmRkLda9cJvmiVSjVzRB62CTh1K9n0+vBdHFF9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH/27YcIioELSmYp3wGfdm2L+jJJlfxibN/U3fXHHNjb6OUuNm
	P9cNCV3adN/x8aJdcn5AKkb96ncUPntN3awFMTm46eT6WQ/JgnfJvntgHUJtOC8sr1E=
X-Gm-Gg: AeBDieu9S3OxN/6RbJcH2C9FpF4X0pupww4DxgHfhGSsmajpkKOTuNL9KtVDB44xWx8
	T7E34O9uhDWk25ryP6lUhPrb5paei3/GvFZkd1ArREl4BWOPublwKxOCrOBtVceBgb3s8Ek0G5e
	NVAa+YPPcyYY4LHg1/3O2JpSIT8DF/7v+5tAXeHnQUsR8Xg/NRXc4ye5DQolXZy1zir/wt4rmmZ
	kFt33vxOuT/YdqcCbHPKPqVwsR5U/bkF5Z154wJXEOSb2WTcqt5Q5WakSpjLrHw3LniVhCjAlVE
	r2oIWQQoxbv4DVARrS4/oWAEn6rJpMNNPCo9j/2GwWvWvZYXfYVr4XrDdQfeh7qzLVjvlnkJgdJ
	KHs3UxpMpgDTZPc40KN0sgfeiNzAdqcpZEDRHuW5ce3UuS4JyF1LBfb1FCSKFZhwHly/2CInV1E
	znPvjkdzCOnoDSwMepNLtYmIwLkDn96Osaf6DIAKJe8tMNdwodA/E5LOLPFHvnOPXMhSrIieI=
X-Received: by 2002:a05:6102:41ab:b0:612:13af:f5e8 with SMTP id ada2fe7eead31-616f73fb7cfmr12959004137.25.1776929315458;
        Thu, 23 Apr 2026 00:28:35 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6174272f752sm9413934137.0.2026.04.23.00.28.33
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 00:28:34 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-60904a76e63so3708932137.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Apr 2026 00:28:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ916WpSZv1s2VmmGrN22IzE7I/me01fO1WbGK1pADUco6TK1l8GNiIzBkoa7fKEaaiJILVYdeiapwY2At7+mk8VYaI=@vger.kernel.org
X-Received: by 2002:a05:6102:374e:b0:610:76c6:b759 with SMTP id
 ada2fe7eead31-616f68d86a2mr13645250137.15.1776929313804; Thu, 23 Apr 2026
 00:28:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177687458572.932171.10907864814735342737.stgit@mhiramat.tok.corp.google.com>
 <177687459412.932171.8121855108122534476.stgit@mhiramat.tok.corp.google.com>
In-Reply-To: <177687459412.932171.8121855108122534476.stgit@mhiramat.tok.corp.google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 Apr 2026 09:28:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUfaE8PJOYSv6nSDat0BArp416U0JvVNizWXp_pJeFAOg@mail.gmail.com>
X-Gm-Features: AQROBzBWFvupdSeqAxOVAc0cy9hT-Tw95EFaUW-lHl0FiR8iYpsy7jXE1aKRWTQ
Message-ID: <CAMuHMdUfaE8PJOYSv6nSDat0BArp416U0JvVNizWXp_pJeFAOg@mail.gmail.com>
Subject: Re: [PATCH v17 1/5] ring-buffer: Flush and stop persistent ring
 buffer on panic
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Apr 2026 at 18:26, Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> On real hardware, panic and machine reboot may not flush hardware cache
> to memory. This means the persistent ring buffer, which relies on a
> coherent state of memory, may not have its events written to the buffer
> and they may be lost. Moreover, there may be inconsistency with the
> counters which are used for validation of the integrity of the
> persistent ring buffer which may cause all data to be discarded.
>
> To avoid this issue, stop recording of the ring buffer on panic and
> flush the cache of the ring buffer's memory.
>
> Fixes: e645535a954a ("tracing: Add option to use memmapped memory for trace boot instance")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

>  arch/m68k/include/asm/Kbuild         |    1 +

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
