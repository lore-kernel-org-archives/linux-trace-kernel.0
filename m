Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17B7136E37
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Apr 2025 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743612142; cv=none; b=euEO7KHgD7+gkBf6yDphdemWyo9612rOSWNfGiueasEDW3i95qy33+hXCmDSC7FvxMquQ/QJuff+a21tJpVoia52Rx/3d0OB+zaXC7MlgwQhn/qSOX1Wo5wdmDnIMF02I0BBqJYKyH/zEi3NOGdtk7Ic/4EsxHE0SzSVZ0ayMhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743612142; c=relaxed/simple;
	bh=jDMS7s/QqERhxp6/24eiwlAd0eMfjngKpnVvj0XkLKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GdfyLVziLp1IlOSXqgehbY5Tb9M2bXcsJ7fqalgy55eBS7+bXfY/bHbGbjFZu0TmGAsF7+AgLZGP7SxOmlfRZiGwm3ImFLLHSPCvXngN49NCre3uDVHD6yfOlWjoqTXLl1qfj03qi/j93w9YMAyfZz54fQAyvV8nI03siFvFpyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fUa6MEmF; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fUa6MEmF"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac297cbe017so202739666b.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 02 Apr 2025 09:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743612139; x=1744216939; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PiI+w7mkKlftQ5tbROJbiyp27FCKTbLNo5OCEHanpjQ=;
        b=fUa6MEmFiAFLnnMoaAYsEze4TkUuRyRmrXEqXXIvcFtXbERU058DFbuC8cOVQMARY6
         FgEAFO/B6PLiFVxAeMUPeBhlrs6HNF76fTb+kJgf/SeEjuor8G0iZrxZnDOVCdJqgc8v
         Q2oiB33bia5h6HkTddyrjv6zrkbJbkBeRayVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743612139; x=1744216939;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PiI+w7mkKlftQ5tbROJbiyp27FCKTbLNo5OCEHanpjQ=;
        b=JGUmSCRY621+c+ifNZBPaRvGKcJXdoLzjaahIEQQiln278U9fOkeID4jQclHaxaSEq
         oFRWBxx/WozEwofpHoFQ4CNEsMeTYRXySrc7mblWKzBn+9ZouIF6/AkUt9SkBPjnzosq
         aYxTpMrqbBxfoHYiGSMWvwWppADQigilwmUr9VlM9ulRzk2rA44KCIZmg0SRw4VEIiQF
         IfQtmiK8ZqJOTHAiOUfxlkzig/00YiMVxINEYfGoinMxuHxbSoUBM1K9EdgM/QGU0EUx
         NTCdSI/Dbf5upSRcOHWUVoAVkdN7CUTcLG0yiKPRpIr+XWfy5Wommjihg+JLqL8/3v+E
         aFHA==
X-Forwarded-Encrypted: i=1; AJvYcCVOgFNgOApHpko43rPlqGzHo5LvzZHl9VnEAtRTkehugVQbi8rSlArboEeMJjdEG5oomFaNRbhqjXZDwxjrYTFMcp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnX48XS1w47+HUehL4utI/3k2r40FFO1CyfrXDuHnfC5zlPOku
	jfx4yAYQ3cp/V9dn39h15Qbcr9ZNn95y6C9FlGRKtIiBu49ySLg+qIarN0V6LsyPPNkC6OjtQ34
	Bh4U=
X-Gm-Gg: ASbGncsj/CJcLMYVmJPFGCYiiQf7MuZO9xvQ7EGDxi7PPNQhWErNgvvkcmdnnXtu6Pz
	HJVYxgE/xRVdhmjmnWWXQ54etVLbhJGmlHRf62o2+lK/1RfvH2b2tPIwE/N6YlW5hsfnsfqwpPE
	c8A989OlDmcGOa/KgwnCcKWIQT7huXpc0HmlKJx1Bolnetf4VrNZozSYBSf3xrCe9hJx+ebNExc
	gsIsUviyXDaNHcXbuJaHQIYYR7SmR7J/UI7FnFZ9diBO0KOdRxQQthOyP+FpKw6qBzoBrLBet0H
	sNFW7aXaVk4nuIabDjQF05QEGO8WjvVhBnLY1YVCus8HZOlrnFnl3vymlxAdoiAkWfZi71KPv1L
	FDWy1bWEhNMf2zLucFmU=
X-Google-Smtp-Source: AGHT+IFOFR75b0sCNTAT6mLsMrLiQyvS2Z34c6k+2Qr6yZQ/ZML2ozUX3uFPMMJwzse6mjNH12Ig+Q==
X-Received: by 2002:a17:907:7eaa:b0:ac7:7e35:ec09 with SMTP id a640c23a62f3a-ac7b6c57edcmr20871866b.12.1743612138740;
        Wed, 02 Apr 2025 09:42:18 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac719621718sm950784266b.102.2025.04.02.09.42.17
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 09:42:17 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab771575040so212361866b.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 02 Apr 2025 09:42:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUcK6Eazv0e58j4H/m46+l/M+4JqC3sf8sF51j/E5XaMmgm9H9ShBlhJ6pidlQ3C4LVWldyjF1sKOzFihwzLrkms+Q=@vger.kernel.org
X-Received: by 2002:a17:907:72c9:b0:ac1:ecb0:ca98 with SMTP id
 a640c23a62f3a-ac7b7184e0dmr16775366b.26.1743612136665; Wed, 02 Apr 2025
 09:42:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401225811.008143218@goodmis.org> <20250401225842.597899085@goodmis.org>
In-Reply-To: <20250401225842.597899085@goodmis.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 2 Apr 2025 09:42:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wifCDa6FfRKzeioYuEqJFTeXnYQ1DpeuYsmmn59NWuakQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jo_6jfKVd2ZZL5O-Nn69rU-B6u26vp9pp03kbk_PkBqnLF3DFsRfWV2_Ok
Message-ID: <CAHk-=wifCDa6FfRKzeioYuEqJFTeXnYQ1DpeuYsmmn59NWuakQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] tracing: Use vmap_page_range() to map memmap ring buffer
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vincent Donnefort <vdonnefort@google.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Apr 2025 at 15:57, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The code to map the physical memory retrieved by memmap currently
> allocates an array of pages to cover the physical memory and then calls
> vmap() to map it to a virtual address. Instead of using this temporary
> array of struct page descriptors, simply use vmap_page_range() that can
> directly map the contiguous physical memory to a virtual address.

Wait, what?

Didn't you just say that you can just use page_address() for the kernel mapping?

So the whole vmap thing is entirely unnecessary in the first place.

Including the simpler vmap_page_range().

             Linus
