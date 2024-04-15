Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29588BEF
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713201777; cv=none; b=tdtRbI7zK3mPOFDa194Oai3Ir+Vdi+KzqC5lbRXzgbAAP3drrJxb6M7lwfDDpG6/oU8ZDZykrYrAbnrwugbk+m603kp09+rkToJFj6bf1CFebGodffdBqxcq+LsEiCbDHHcYBPTRXBAmqWrkGFXt2ZsOC2NSVQlwv72qZunyQcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713201777; c=relaxed/simple;
	bh=cVYE2ehOGt9AZu4lK44Xq/DDtOiFLWELDzP2xoxBwKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USS22RqUP7ZHpcT/VycsShzPIHhOOrCYjprYyKUpVXqshtaKlj/XUpDdxORin/bfMbNP1iD7hsr3eP76TYBbt0feI5v8AYJIpnhGMEPcfnEdOyxUhySuGT+ysGn8dRHX5vP6OL+KaINESnP/mSaDL6SQVjpzExH2V3zj4Hsl/58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n1/7fwws; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n1/7fwws"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so35483145ad.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713201775; x=1713806575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7LGAaJZA3Ieswr80lcknUKfoXzL8DxCdWx6U4KMKhO8=;
        b=n1/7fwwsz1foICewoRUWdT5xs8fB6NPWFGr0ktjY/VuOuhmhiUJFzqUk7Hh0CxPvax
         E5YisngVBin3djrd6DDhs4QCGQ3QzkFrCWfEDkLyfrJo6Rw1syIkQ4vSTaxW32o1JVNp
         BsyNyTkN7IyXA2SxPVivq380Pagf5FO7bMGXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713201775; x=1713806575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LGAaJZA3Ieswr80lcknUKfoXzL8DxCdWx6U4KMKhO8=;
        b=oZbHMk6eizJ6qIX55/HSUIyVEugp2gJhsh8jXng6VNP+yl3sn1B5t5XJNHjvLr3l0T
         9ZgpFSnlIV8TlQCnXK33m1rDPCTupoJ2ehgT7hzHFHSw5h+OBOZUud4BwmogUk4EEWDp
         eCtbDJBtLBH8Hz4JyNLLnk5fWKvc0bJ49h/con8feV5Yb6rqCpiCWsNhAt5PLm8P6PnG
         oF5ig9SkzarMQABJszyroi/qEX+u3zDQDEZkaYxyPLcJuAh1Mqf7qs3mFssOGwEAnxCO
         BWEcirKlAOtBNqwgkR6RB14fcGgXkhgZoomnTrAyIzK55smK2V7T5Em/OdB8WRUUZqwF
         EmFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIN+wHxPk2llxVhYLAEi0X5ZuSXkZTLMMWco8ESXP4HzZHWDKb7EgX56VavivwxAI5fD6YCLfAh/EpMQ8RHPb+ZJbGz9wK5PaGO8buORIJ1kXX
X-Gm-Message-State: AOJu0Yx0l/rq2vaGHKZOJe7Zf73qOyZjKXVuSajzvxRwZ+0+A8uRQPzW
	5a5sRVrKsFADkKLEaoM5BBKQOG/7peE/R9S6FElnAgBarBDwgZ/u6Vcc2P2FGw==
X-Google-Smtp-Source: AGHT+IGecUmEOfE36Uzb8gHIAKlLpWNf+xF3BoTR88anSiFWvmiZTMlAPARou5mOFCGqDFBXXAVwXQ==
X-Received: by 2002:a17:902:e807:b0:1e4:1eea:a3ae with SMTP id u7-20020a170902e80700b001e41eeaa3aemr13173797plg.5.1713201775022;
        Mon, 15 Apr 2024 10:22:55 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b9-20020a170902d50900b001dee4a22c2bsm8144525plg.34.2024.04.15.10.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:22:54 -0700 (PDT)
Date: Mon, 15 Apr 2024 10:22:53 -0700
From: Kees Cook <keescook@chromium.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	Ross Zwisler <zwisler@google.com>, wklin@google.com,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [POC][RFC][PATCH 1/2] mm/x86: Add wildcard * option as
 memmap=nn*align:name
Message-ID: <202404151017.FC002AA5@keescook>
References: <20240409210254.660888920@goodmis.org>
 <20240409211351.075320273@goodmis.org>
 <202404091521.B63E85D@keescook>
 <20240409191156.5f92a15c@gandalf.local.home>
 <202404091638.2F98764A41@keescook>
 <Zhmgm86tzpanoweB@kernel.org>
 <20240412181940.3e1d99f7@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412181940.3e1d99f7@gandalf.local.home>

On Fri, Apr 12, 2024 at 06:19:40PM -0400, Steven Rostedt wrote:
> On Fri, 12 Apr 2024 23:59:07 +0300
> Mike Rapoport <rppt@kernel.org> wrote:
> 
> > On Tue, Apr 09, 2024 at 04:41:24PM -0700, Kees Cook wrote:
> > > On Tue, Apr 09, 2024 at 07:11:56PM -0400, Steven Rostedt wrote:  
> > > > On Tue, 9 Apr 2024 15:23:07 -0700
> > > > Kees Cook <keescook@chromium.org> wrote:
> > > >   
> > > > > Do we need to involve e820 at all? I think it might be possible to just
> > > > > have pstore call request_mem_region() very early? Or does KASLR make
> > > > > that unstable?  
> > > > 
> > > > Yeah, would that give the same physical memory each boot, and can we
> > > > guarantee that KASLR will not map the kernel over the previous location?  
> > > 
> > > Hm, no, for physical memory it needs to get excluded very early, which
> > > means e820.  
> > 
> > Whatever memory is reserved in arch/x86/kernel/e820.c, that happens after
> > kaslr, so to begin with, a new memmap parameter should be also added to
> > parse_memmap in arch/x86/boot/compressed/kaslr.c to ensure the same
> > physical address will be available after KASLR.
> 
> But doesn't KASLR only affect virtual memory not physical memory?

KASLR for x86 (and other archs, like arm64) do both physical and virtual
base randomization.

> This just makes sure the physical memory it finds will not be used by the
> system. Then ramoops does the mapping via vmap() I believe, to get a
> virtual address to access the physical address.

I was assuming, since you were in the e820 code, that it was
manipulating that before KASLR chose a location. But if not, yeah, Mike
is right -- you need to make sure this is getting done before
decompress_kernel().

-- 
Kees Cook
