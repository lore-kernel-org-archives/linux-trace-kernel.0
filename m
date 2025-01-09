Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8CC18873E
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Jan 2025 18:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736447068; cv=none; b=ASmJb0t0kKyIc4ySpVe4RpWkH/JjP/6fvC5wNaogLZioFZX0eDHoM1In4ovVPZPNQAUkQz2lzeMlKLjJStN/sy2gOmC+E3sDUY9I2DDE3ET+CkM+IwYK9DjPkwFd1co0dwAYkkxobMLjpOATNoMevMan7EBPv0rglJ9f0taOPEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736447068; c=relaxed/simple;
	bh=+vLgqIeCzolaIxQPxdz01oEdjsD8WPzfx1aPdgzHvxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FTDiDsKLi9BSjvfnXpN0rE848HJMRCX8YHen3cd/08g0czn0BdUbix87oNRGuS2rcStbh/n6SXIQHrcT/V9BHI5TSkGhbusO67gvKrNiAffY+TzBlvTLL1gKANzNJbH7PzWGVbzDPc2ESuY20rSAnxjT2gaGWhmetVVJvg/Vhb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QkzusyPU; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QkzusyPU"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so259435066b.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Jan 2025 10:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1736447064; x=1737051864; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cUcTIvdqWsHncGSnTDzqP6lVvkAKHUvwz4H9h8Ij3CM=;
        b=QkzusyPULuNegBalTYmpY9eiFWfLn029zhUixhXSTBT+PJEvI+LztM3O6IbJygvl0t
         m9SVvfOweTeQxBhL9w1t9d1upMUNi7Fw6nmdVyLfc7Q9JF623GXqzU2VS1fO/NdcRwsG
         a8do5BGv7dxvHEmlsgV8zzgV8VSxremCeRojA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736447064; x=1737051864;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cUcTIvdqWsHncGSnTDzqP6lVvkAKHUvwz4H9h8Ij3CM=;
        b=oVIuWS14fZrb8qrEXm9GhkA3DvEKEIWSFOvidNE+1s19WgHk1h+O+/QcFKdlA5yzKH
         mKJ6W72ZQ2EjvBNQ9A8SLj2wPFpsqMQGk5aNQGcTO3YSFKix0mHfnp9uay8PcdlTCJmv
         kwpuRK2L648NyPCrc/jinAaudIVp23xXZOGUX5MOrpJ0nEky2OGCblcR/NG4Z5CtdxQ9
         iGfYggE/pzeSsMb62G78W40X/OafNyH05jbjh3wJhyMzWkAxH/GToqAieaKQoES6NDwY
         58ZHEjM7QW+c+Q/hUP4IIpQwkZtPaQL9N8MMXt1TZP+KCddpqpA2gK4WDWvX374f7BXu
         Agvw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ2hQpyTQiivAQl8KWh0TrmWlm2ALOmLgtdPJZHGsdAn1Nvu+Ii9wmSNqJKeOFCiGGW0zDPgKVYRkKiYyZ6+EgM9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5KQLgIVpUisEYCgVn7phUXX05ar6TjuvAO7O5AaKvRgi08hWY
	qU8FAstaLlBE6/eo8lTi2zjgvgUUyHu/VpP50WXowqNyF6ANcj4UMV0sIqVS56x8PFQ6lVjrdk4
	R0UA=
X-Gm-Gg: ASbGnct/+NE7mwYbsE7o2G2wTnd02CY/BlB5KD6BmvGexoTsMC2u4a7roiHeR+KRvkR
	dWlDW2mR8PgkYOI1SvYlHoe4IA5kKZiaDm0LcSug1JoOq1Wae3Gc+Zpf6k4G8vbi+N+qjHMA+c+
	Rw2rIaa9Blh2r6RQXMWJsvSZ0sCvgO1VrBsRImotMS/JSv99z0RpP64yGb3308FPfeZLT5drAvP
	5cnDple31OvsPAzEfHFkhrcegVV8YZ/LsukDVOjkuB2tvuoHC+MNqxmkKJ6KMSLbtwQct/KXXuu
	+MMLRE91gpgrxdSvX2SEDl/Wn8QAIeE=
X-Google-Smtp-Source: AGHT+IGWr6UOyeqjXVSTrg5KheeRw8MtQI0jzuXCyGENPOhWL6whxFtB/ZvAKaL46/ZSl7y4HYYy2Q==
X-Received: by 2002:a17:907:1998:b0:ab2:c9b8:aaa7 with SMTP id a640c23a62f3a-ab2c9b8ad19mr314299866b.44.1736447064181;
        Thu, 09 Jan 2025 10:24:24 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c905f0b3sm95307566b.21.2025.01.09.10.24.22
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 10:24:22 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa68b513abcso230520766b.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Jan 2025 10:24:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW3QWNtqEhFneKYNaorqGLADfKbeDv9VDitAfnwEVLbosIF6EjU+Sd7j7EIUT7V2CMIT6Ukzz43FOS7XJ63DR4I9RU=@vger.kernel.org
X-Received: by 2002:a17:907:9691:b0:aaf:ab71:67b6 with SMTP id
 a640c23a62f3a-ab2ab73c487mr689359966b.31.1736447061714; Thu, 09 Jan 2025
 10:24:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107223217.6f7f96a5@gandalf.local.home>
In-Reply-To: <20250107223217.6f7f96a5@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 Jan 2025 10:24:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiafEyX7UgOeZgvd6fvuByE5WXUPh9599kwOc_d-pdeug@mail.gmail.com>
X-Gm-Features: AbW1kvYdQlWHwGkmwwAN8JZw7YnlZKyVkSwXwOwVP1gd8FGuLMeyZPa3VRecA5o
Message-ID: <CAHk-=wiafEyX7UgOeZgvd6fvuByE5WXUPh9599kwOc_d-pdeug@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/sorttable: Move code from sorttable.h into sorttable.c
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Zheng Yejian <zhengyejian1@huawei.com>, Martin Kelly <martin.kelly@crowdstrike.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@redhat.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Jan 2025 at 19:30, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> +
> +static int (*compare_extable)(const void *a, const void *b);
> +static uint64_t (*ehdr_shoff)(Elf_Ehdr *ehdr);
> +static uint16_t (*ehdr_shstrndx)(Elf_Ehdr *ehdr);
...

Side note - and independently of the pure code movement - wouldn't it
be nice to just make this a structure of function pointers, and then
instead of this:

>         case ELFCLASS32:
> +               compare_extable         = compare_extable_32;
> +               ehdr_shoff              = ehdr32_shoff;
> +               ehdr_shentsize          = ehdr32_shentsize;
> +               ehdr_shstrndx           = ehdr32_shstrndx;
> +               ehdr_shnum              = ehdr32_shnum;
...

>         case ELFCLASS64:
> -               {
> +               compare_extable         = compare_extable_64;
> +               ehdr_shoff              = ehdr64_shoff;
> +               ehdr_shentsize          = ehdr64_shentsize;
> +               ehdr_shstrndx           = ehdr64_shstrndx;
> +               ehdr_shnum              = ehdr64_shnum;
...

just pick one of two static structure pointers with these things.

            Linus
