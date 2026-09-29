Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE7E4F0528
	for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Sep 2026 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790676012; cv=none; b=CvHspewl5fzA+dv9kRfuMlq1hqchvd0eBiYDZAXmN96KGxaqdMOyPZH70w3jR3cD8DMA/cgi/K+KYOro4PhKjLSsVMOCJ7yhTYIhUD41HSXmChdB6sI9SVQcp4pGG1YB2usQi4/yS0agkA7xoLiQtW2uTBlM4lRNqlhPHNQlKVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790676012; c=relaxed/simple;
	bh=nW2BpZfMFPJe+aNQAl50PTVcOHGXLoiRKZhhr8y1y+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dsp5r7wnIr1g4fVu2g58RujvFanbB3MpZ1ip5S47IWsSfpkycovpyom7CIJ4eEeZQ5k2jqLKNjlQRhYCTIFhkyhUrgUblSGBv4OzBIkznpVO7NkpbH6RKeS/mSFmnWnqZPrdA3Wt/UCCBwLL+9pDvdzNcXT+HeX9iUN6pYvqPuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=czAYU6TD; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="czAYU6TD"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ff9642c57so3639855e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Sep 2026 03:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790676003; x=1791280803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t0YyI8T0uXaAdN/WX1SYDvqqDpfpjOyIiMHz8pNiIDc=;
        b=czAYU6TDs/qJpUEvcimzBjaxgvwROLjK4nR/VKetr20qgtaU081Xl4ZARCZdYI5Yyi
         7hIdrkEmun9CrNQWgNpboFQeenC8U2N+8WK4k5Dl4/Qi2zbuCiMnALioo5UM2cEeO1pI
         UCGwq/bdT2c9wCpBQyMlNUEDcm/3HznisXRItGBY1PEc98tCpPKU79isBWbQnIcNcCBB
         j+G1uUtjSaDPhOtUF3nHq6OrXLg9uFPQjMCxF+6am+Agi/2CBvSgZgP2/YGnIixxFMcg
         pIypha3+sSTgCcDIVxN14EM9MBzsTWn85bD0VqoGNWcPhU7s+zaADPo9niyqjWoI16vI
         cZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790676003; x=1791280803;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t0YyI8T0uXaAdN/WX1SYDvqqDpfpjOyIiMHz8pNiIDc=;
        b=MkqW1aMBr+C1ANm5048aGzAPJkpWPT8qdP4tHF/RYiuEXjhVxIHNscf5iLAwDmKwRN
         kamLVwhfWF6Q7XgUoJARui29dORYI5kE19H5qXg/Dc+Qg7rc/sYR8LV7paEeKdC9lPnj
         uCBvf4sLtwokMN5+vhWWrqJRgu83gQukOvidVv307/GRkqTGZW9ll0wG+/OgxSP2++9+
         02eUHQxj6fnmuYzwyh1CTnu2M3BiJxRvsqUS24/c6duviTBBARiDYnKr1w/l2XXlHO4l
         5cSTd8uJULr3jV6e3TwcqSZG67mhASv6yteqkYokfMGjuV2w5F7XQHsQLyfPh7r43w+m
         v8Hg==
X-Forwarded-Encrypted: i=1; AKwUvBz6PvuhpE0lYr38MD51POOGCGhtQWjBX10zmoaalBiuM/qJnjPcS44tpScQfLhFOebuYDAsjO86ZqfTQ23CiXtnhFE=@vger.kernel.org
X-Gm-Message-State: AFuF++kUjS83YY/vbWd5icty5+4gCOu4xmfFIdIl0eKTl8xKjCAzD4KR
	l7uGSZlaZovQ5nce2LBRcw9MFngCtVc2p3TDAXvhJ+qQvqSp0F+wsVF5H6uYLqk5c7Q=
X-Gm-Gg: AYBFou1/n+nNvSfT4YQCQhqtqtw4a1zL5uXQP8uPAX62zPL1Wg0HTjR5vK/tkIqe7KC
	PIRsDpTL43Q9GhN/neNWJAqu42bLpeUryR6MT5YCVJyiyzKyagntgRrSXNU1Y0Id+VY6SdB19bM
	NbYetUna+99GPH1+O1rnz9GA6QVIwLTFJPdu9TUh4cCZ9kPmfRhdCbgQsITuc1+UpAOfay5c85c
	+D2p4nqKOTtZQUASvdE4dUSKkGRs3hVO9vfBFMwB3w+NSd0Y1UPCivvPeJUkLo1SLTSyynkXeUQ
	oYuf/ewYUL/+5m02JKNJLyiVjaHSD3A0M9LLoCIx12vMxOBUsdZxpPAfo3RPYNE+lgZyHmn9rE2
	3SU0aWbMSUDtI4rApaQvVSA6jGli8LmzOYOMQoZ24AoYjSikQwoJQovAwnWG2rtNhtjZaL9Td3Z
	FmH2Kf2WVpeE0L0xv3YatwK7CIeC56YcSLLSoHQ9vZXdh2YPoGlBdsFz9CJqlNUhgvve6OtiZbl
	DTcCPXo89MvXK5Gvm4akD4q3A==
X-Received: by 2002:a05:600c:470d:b0:4a0:34a:588c with SMTP id 5b1f17b1804b1-4a00d778efemr28813305e9.14.1790676003381;
        Tue, 29 Sep 2026 03:00:03 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf4598esm69391025e9.0.2026.09.29.03.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:00:02 -0700 (PDT)
Date: Tue, 29 Sep 2026 12:00:00 +0200
From: Petr Mladek <pmladek@suse.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jim Cromie <jim.cromie@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>,
	Kees Cook <kees@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>,
	Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v6 0/3] kallsyms: Accelerate symbol name lookups by ~7x
Message-ID: <aruMIFRPBEVX_j0N@pathway.suse.cz>
References: <20260926-ksyms-tune-v6-0-236620c65e98@gmail.com>
 <20260926133859.c8232c439184dfa17472b020@linux-foundation.org>
 <20260927065728.7f159234@pumpkin>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927065728.7f159234@pumpkin>

On Sun 2026-09-27 06:57:28, David Laight wrote:
> On Sat, 26 Sep 2026 13:38:59 -0700
> Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > On Sat, 26 Sep 2026 13:40:11 -0600 Jim Cromie <jim.cromie@gmail.com> wrote:
> > 
> > > As measured by kernel/kallsyms_selftest across ~184k symbols,
> > > kallsyms_lookup_names() binary search takes ~6.1 us per lookup due to
> > > two inner-loop costs:  
> > 
> > We don't have a kallsyms maintainer afaik.  Petr is pretty active in
> > there so let's give him a hopeful cc.

I am not sure if I could find time to look at the code deeper anytime
soon. I put it on my TODO list but I do not promise anything...

Anyway, the kallsyms search speed might be interesting for tracing,
livepatching, bpf, and maybe module loader. AFAIK, Geert used to
interested into the kernel size. Adding them into Cc...

Best Regards,
Petr

> > > 0. Candidate symbols are fully decompressed into a 512-byte stack buffer
> > >    before calling strcmp(), even though non-matching steps could choose on the
> > >    first differing character (0..N-1).
> > > 
> > > 1. Probes scan sequentially from 256:1 markers in kallsyms_names[],
> > >    decoding an average of 127.5 symbols per probe (~2,170 hops across a
> > >    17-step search).
> > > 
> > > This 3-patch series addresses both:
> > > 
> > > 0. Patch 1 introduces kallsyms_strcmp_symbol() to compare ASCII queries
> > >    against compressed tokens on the fly, bailing out on first mismatch.
> > >    Drops the 512-byte stack buffer and saves ~530 ns.
> > > 
> > > 1. Patch 2 increases marker density from 256:1 to 16:1, cutting average
> > >    scan distance from 127.5 to 7.5 hops and dropping lookup latency from
> > >    6,102 ns to 866 ns for +42.2 KiB of .rodata.
> > > 
> > > 2. Patch 3 inlines and unrolls get_symbol_seq() 24-bit reconstruction.
> > > 
> > > Results (kernel/kallsyms_selftest across ~184k symbols):
> > > - Baseline (256:1):  6,102 ns
> > > - Patch 1 (strcmp):  5,572 ns (-530 ns)
> > > - Patch 2 (16:1):      866 ns (7.0x faster)
> > > - Memory: +42.2 KiB .rodata, 0 bytes dynamic RAM  
> > 
> > Can you better explain the tradeoffs here?  Increased memory use?  If
> > so how much?  Is any change in build time expected?
> 
> I've had a thought of a scheme that should give most of the ~19x
> improvement of the original patch without increasing the data size and
> with only a small increase in code size.
> The downside is a slight slow down for sequential access.
> 
> The thing to do is replace the 24bit 'symbol number' in the 'sorted by name'
> list with the offset of the beginning of the name.
> (For very large kernels it may need to be 32bit.)
> The binary search for the symbol name then doesn't need a linear scan
> and also loses one level of indirection.
> You then need to do another binary search over the 'offset of every 256th
> entry' table, followed by a linear search to find the correct address.
> 
> For sequential access there is a reasonable chance the next symbol is in
> the same 256 symbol block (in address order), that can be quickly checked.
> 
> I got the code to run in userspace yesterday (with a real kernel symbol
> table), I might look at some changes later today.
> 
> David
> 
> > 
> > 
> > What isn't addressed in here (afaict) is "who cares".  Is there some
> > workload which is kallsyms-intensive?
> > 
> > This info really should be right in the first para of the [0/N], and in
> > detail.  What benefit does this work offer to our users?  Use cases,
> > example scenarios, etc.
> > 
> > Apologies if I missed this in earlier discussions, but if it was in the
> > [0/N] this wouldn't matter!
