Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19C7314B9A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Dec 2025 23:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766100729; cv=none; b=FXwoUlb0galvYyN4RQ6vFXXHCGbbJbtPxEpDWl3TB4QveJIhrzTprcxpANBZI856Y8+zVjNz2MEL5fdMP+eeEV0URGg5MkZoyNIlre0PAuRMgwmGqlJ2a93yQnWkxXSz69f1TdZBfyJgK9EVVJ2weBJ3bnD+b1SgEuAvPQ3rXbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766100729; c=relaxed/simple;
	bh=VtuFtOxmYb/PpORgLs2pYY7m0pfwysUEfZQjWZDbffU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FStB7DWl1IjnMbhCQjgrM6kg1sSf2l65zbp+wjTf+jzDChc/mZnHc01bt0LbmD+IOh2eWKy9T7rXMi2Z9B6QfBLEqRqcarhm65pu0rF7nNeCVlqM/g0Rt0fihB8WM8wTUvSM28edN7i3kQNx2dAFX3OaisTMolV1vYxodGyfU5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6vbOYUO; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6vbOYUO"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4f1899960f0so12360501cf.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Dec 2025 15:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766100724; x=1766705524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IloyOMMd5ylI5AueuaVNDNa1yiVVaCMzgGfBgxrjjCE=;
        b=i6vbOYUOAsbpR9ElGKMXPYe5JQ3KfAA45oedS3qEeM34CDwsqt1WDizfqj/Uw2jbHI
         +7SY8ncju3P1mJJXqzsuiLv920OIwv2aN/nD3OoORVW9PdamMeP6yaZuW+12KpepxxMH
         ZtUXmte6hMG20b/jPTwQ//UJDWBSgkESg4r7gkR7xKDEZslv1LWpBeSwx5bFqoO/TqH4
         iH1iuIfG+4mf/qovX67mTgOlCe1/5tgaHyq5HZ26pKiw4wcAjEmAtfGJc9U7WHBfSls/
         gBTGJ1TNjH/9x5zZpJY2tQxWKpJ/RkYV1iHuIcMCpNnaWkA5yori+mdILXrcsKghQSdu
         J4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766100724; x=1766705524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IloyOMMd5ylI5AueuaVNDNa1yiVVaCMzgGfBgxrjjCE=;
        b=aKTEBLeHIR5rqeVUx0HPfPOdaDGLxfljv82HvlMhY3GcdOUwrxcb/iT0LHYnpAIDuc
         1APdYiunDc3IbErtkYTEtAF/Y1rfAC9IhQ28jBgVpjdYUAFyaxe8sZopMf6eStjDazTo
         5TohYoTVSoMqjGk4osbZIMi47mFUw9qWRT0goCvVH8xFxAmddbZzCdJdXkhNrCSlbRmJ
         ArCH53dgxhMf8eCW0dnQtXGvjzePhqusZkyhouUWdF2TxQd4rExCNwv2UaZQ9ziITtyQ
         fjKwS0T0aQNcd6l+/h+qfjrC72RAZyuRng9kJ2iaBabDHu/oRj6t0BS4xjWA5FEwi10q
         sSEw==
X-Forwarded-Encrypted: i=1; AJvYcCX9ScEbe3s88gBw4pTcber4ytdPgjNxabLMAKdhVONdSiyn4QgHt97Nj42wKglHUb3X9PVc2n1d9AINxONxOyXghPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDyFEmZpCXWaI6jjZjX9BrwU/j6vjnXyH+8vVda/lHKS5nRcSf
	0GLQaJyD8D4k824SUnLJbikCdH7uabqkadBumRjOuAmJ2lgap/pUvBgJ7rqs4A==
X-Gm-Gg: AY/fxX7VYXg91FBA5PhwyCjX8OxSy0vGzJqspJLCzzQLzdFSG/7PqHfH884VQZEoHov
	i4MYuVhMYN4pYEkSoylG60dmlFAjS5POGz6H4EupkklIlaHd7tbRLzpmrxeYuTikt9PAIJ60Svw
	Jh1P54/D6a2ra0FHF1cxrcfx+r6a+KaMSO5g7ZLDn2Yn0kcYU+cn2AJLCgcH0mOSD1kMpRik7kt
	rEGafX3Kx7iV6o2Vnh9oYahkVpoAgyEXaIKv15NLStlHhfLb7QuDQxAEIWJlUU6qFwyjtas/bI2
	r1S8gb9RlRzVE2t++NNL/3sh+2t2vBVd1pNmZkkOo2vMyLCX3LfFzaHxgWZ6o/7PCvnS55LHn6y
	+BLcSZ+ZJSZqU2AC/nWx5se/Kur4uLw63Ll0SqwP7tgt2SXz68BRzMKKB00cUZZUv6XdK3Dg7Fd
	oJvtTBUnNNRz9tE09B
X-Google-Smtp-Source: AGHT+IEuCqAiz7tKoEs7EuK/X/tMhWVEAkhspAQbq2aT86kftRRnc2o+VQJryW1KpVrUd0c8qF7fgw==
X-Received: by 2002:a53:bdcb:0:b0:645:5b1f:4ca6 with SMTP id 956f58d0204a3-6466a8a56e5mr521141d50.8.1766095012737;
        Thu, 18 Dec 2025 13:56:52 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:c44b:debe:992d:e6a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb43b298asm2433287b3.19.2025.12.18.13.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 13:56:52 -0800 (PST)
Date: Thu, 18 Dec 2025 16:56:52 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] tracing: Remove size parameter in __trace_puts()
Message-ID: <aUR4pJLYdNs4Zo-Z@yury>
References: <20251218163739.5605f9ea@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218163739.5605f9ea@gandalf.local.home>

On Thu, Dec 18, 2025 at 04:37:39PM -0500, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The __trace_puts() function takes a string pointer and the size of the
> string itself. All users currently simply pass in the strlen() of the
> string it is also passing in. There's no reason to pass in the size.
> Instead have the __trace_puts() function do the strlen() within the
> function itself.
> 
> This fixes a header recursion issue where using strlen() in the macro
> calling __trace_puts() requires adding #include <linux/string.h> in order
> to use strlen(). Removing the use of strlen() from the header fixes the
> recursion issue.
> 
> Link: https://lore.kernel.org/all/aUN8Hm377C5A0ILX@yury/
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks, Steven. I'll take it with v4 of the above.

Thanks,
Yury
