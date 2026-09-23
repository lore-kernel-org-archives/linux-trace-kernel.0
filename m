Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A4E455176
	for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Sep 2026 07:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149460; cv=none; b=JYsiBu5nxlrW1mczg20NnQ7z9+A32DXJsqz0agKqakf8jccxw50yw3Tfstfj142Kl3Uq7XOHOW76vrU8Hcx2fbVmjOTlftBDYFqsQC00peFUCbNOHH7CpRTOGc20uqedlfZ475wQEz0fRbYm8nQoMYIC6a1Mnh9O5f6wudnHxYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149460; c=relaxed/simple;
	bh=M9lMAFUnH2NTE62JM03Y7t5HyySwHMlsThVH5J/2ELU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvO5IA/raPWUfL16+HOHr7idIsTCYRNK/3yjftQhQHcWjVI9w+1VP7EO3vOaD9oAR2IPZi3Ks7h3Z0OjDB0xjwnx0Wg3WQwQx+/ZevseP/LDphyZy8PWAT5o5uLXO/lYmaO06iLGRjO7A0rgLWsv9JGlGRNagrgvbTEXI28uPfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e06pX9Ws; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e06pX9Ws"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso5086975e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Sep 2026 00:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790149453; x=1790754253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aAsvDchc+x61ynFxcLSRLs5AAyNrnPoee4eK2EySr0w=;
        b=e06pX9WsWvTdRwAAMUJKI6Jq27L/lD3MT5v+XoOJr4n9lSBrr2uXn+e0/W6FtByr2j
         HER7lewG3BISPp1VByK8q8VI/je159qx8NyFPRjI0fTLnC+U9WB3aSwk6STXh1BTcLGP
         2P8EBvI5STfshG7g9TnXsItow4PSEO3KshIFkGdY5LlS9K1ONBliEkvKCa2wGzz2SD1N
         PUO4TYo2PpWgqlBDkSl1CLrO+uZP9NGbTNURLlm1qz76om+E5W+eUAoBLpnes8b0Zegr
         +YlZyc7g2wRfVByOmzdPNCWotnjKudlPREFyjAjeozlUxWwIvfWUAatbcmWMpSF8edH8
         fIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790149453; x=1790754253;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aAsvDchc+x61ynFxcLSRLs5AAyNrnPoee4eK2EySr0w=;
        b=G5uJCfZn2kvGk/SiUjkQSATweaQnRg/dz3kRtMAsRzvwSZpKZ7lMKJBiyKe0iUAWOe
         ql7oacsYrhVuRLKCXW9XgGRsEnlDTfETjwcibdMo94n00rJ1ip7F8dMTLRYSp1etx/S5
         sP56hqlwjoPXHFxfSMeS1j+EwtRKh8lcP7h0vF0NqoY7Z+ehzoCx063JTmyPNMrPAAd4
         CTkL98esVPovg1nWjFSHnoEynk0XTb9vRs7jDdMYMt62g3PAK7grDvHTZE7nF+5PeZm6
         2FZcyegvznPKF7fGhNIkZ17ZVVsRu0v/cgweOA7ehh5it4I8C91rKFTV5t7R7fkBOurQ
         sSEQ==
X-Forwarded-Encrypted: i=1; AKwUvBxVeWXr0YyvNS+ipVKetxrXOha4xlW11kC6c+6adI+i/f1t+Boz33w07Zkc2gIeFiRt98SZGxDc2IpP8q7++X1iOt4=@vger.kernel.org
X-Gm-Message-State: AFuF++mlQpvvJN9+6E5qfDwGt5B2roYnwUvJwLwqMElLNKJ+ws1StD9a
	k3kcwqi4APZcy8aeAhuEBaMQsQ/nQS2B4fkH258lw1yJ+JIzXAQe90IFqKwss1iEkg==
X-Gm-Gg: AYBFou0MGpyAyvGMrIhqCSkFrazIjjNM+WSPzPfLYFYdA9Fce8BqixocWnbEU6AgACe
	Nb7SA1pvCZrj44Z9RD/QIJklU0XGrSRYrTF+hosF2OaAMUDsjSi6EK47lRb38F43a0qU+HHMyTE
	yd9fvRwpb1UYgdltScRg6/qBaGcBHCBU6NNX2o4802FOoNrEth3oTFxrb4TeUPL3kR+1oMeRejO
	ZBNIldBNbCwD5UJzjtX1WpNRZpQ0q53kDGAp/pluLFRPjX+EQnHrQI1ejO2X4MgChCVIBl1izfm
	oIHvgvAguiYHII3wAkjkK165uZvP09AUhaKC+cFQ6oExEjD03RRUcCf+9qe4bcdJHD4xh1LeM5y
	3hMTu5Xbz9eWBbAMHaRPisZO0lUyl1P8TTlSOqZb6MYFmqpuD9bB7V5waC6dyssR5St/HGMzRzb
	h2yE+aVKgo6uvCXHg8xJYane3/BNmW1Jp5eFp+hrCeyfR6bVcEirhrbl7zCGJgUTQnfqOcnwAM/
	XG91w2gD5VS3wtmzCj96W2mSAIGlB/iGfMdmxwf0so=
X-Received: by 2002:a05:600c:8b6f:b0:49c:fff9:f684 with SMTP id 5b1f17b1804b1-49fdf13502amr22086715e9.21.1790149452550;
        Wed, 23 Sep 2026 00:44:12 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde198f85sm59969785e9.8.2026.09.23.00.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 00:44:12 -0700 (PDT)
Date: Wed, 23 Sep 2026 08:44:08 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: trace/simple_ring_buffer build failure on parisc, sparc64
Message-ID: <arODSJcEFYShdkou@google.com>
References: <5574c9e6-9ed2-4ee6-a2b2-fb6ee81e83a1@roeck-us.net>
 <arN9bPXyZFt0DV3H@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arN9bPXyZFt0DV3H@google.com>

On Wed, Sep 23, 2026 at 08:19:08AM +0100, Vincent Donnefort wrote:
> On Tue, Sep 22, 2026 at 08:57:05AM -0700, Guenter Roeck wrote:
> > Hi,
> > 
> > when trying to build parisc:allmodconfig or sparc64:allmodconfig,
> > I get the following errors.
> > 
> > Building parisc:allmodconfig ... failed
> > --------------
> > Error log:
> > Unexpected symbols in kernel/trace/simple_ring_buffer.o:
> >          U __atomic_hash
> >          U trace_hardirqs_off
> >          U trace_hardirqs_on
> >          U warn_bogus_irq_restore
> > 
> > Building sparc64:allmodconfig ... failed
> > --------------
> > Error log:
> > Unexpected symbols in kernel/trace/simple_ring_buffer.o:
> >                  U 
> >                  U 
> >                  U current_thread_info_reg
> 
> Thanks for the report. I could reproduce with clang. I should have a fix
> shortly.
> 
> > 
> > I always thought this has to do with my environment and/or C compiler, but
> > it seems as if the problem appears to be generic.
> > 
> > I have no idea what causes the problem, why only those architectures are
> > affected, or how to fix it. If anyone has an idea, please let me know and
> > I'll be happy to write a patch and/or test it.
> > 
> > I disabled CONFIG_RING_BUFFER for test builds of parisc and sparc64 for
> > now, so this does not directly affect my test builds anymore. This is
> > primarily a report that the problem exists, not a request to fix it.
> > 
> > Thanks,
> > Guenter
> 
> -- 
> Vincent

https://lore.kernel.org/linux-trace-kernel/20260923074213.3077182-1-vdonnefort@google.com/T/#t

Is that good enough?

-- 
Vincent
