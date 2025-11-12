Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DA7126BF1
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762913676; cv=none; b=JB3wcq0PLy0El3h5S41iS6Royg3M0sMfPMXGAuxokb0fpFFEuGwJU9k+uTBjDsIYchyEWnEtJkh/Em/bYS3C5s9+qp3DOes35gZcN66Y7dkRK8CFDUCMbDvryIXz+TofWCdhuAbdXb75Ld8J5vaOqTdxrse5uUWrvmBduO3AGc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762913676; c=relaxed/simple;
	bh=xwFVvgtw9uBd2ORKsLl6UhYsiyXLrRfI/zUbkQg0RWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/Lp7zUJlLazX3LLYMW+JWfpGPd+a90tcdISKQ+l2vo7DHWeoWytXQalOFkERpw/i+xpH72oIfTjVe/YSNcxrHEJXpaG4caO+STC/gUB79B1eVTdexRE0hdn2C3Usqmz7Xi9QtfQHFCt0iBOclAwtlVwL2xc4B/n2I3avmH2gnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuauiSLE; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuauiSLE"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-343774bd9b4so286501a91.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Nov 2025 18:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762913674; x=1763518474; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lVQBcx6xFjlJyhg8EGvnzlqkKD9tleq1IsOwgdEnnOg=;
        b=fuauiSLEBn9GiFcz5fEHg//fVQUy7nVf9NOyhSGqdw78w0KZF7cXP23cqhWiWVs2IH
         1M7qQ8Q8T0l758X2shuAsdXj7hHQ2xbwdsr7Rikwu0cEAPJQU+ku9XyT86rA/2U8JqAW
         6sS/u+ePsgpCAZS5Z8lbkgAwyfxIaXOKE6egbPGrWjzZbOcZdnKTR+nC9fcc2UwNdVs4
         m2jzFR9MPNnWRXsT9+ijW44d5VH7NfM9awbEWhyL6r/NFuJBFLvUnRcw7bMLOSxTwaEF
         rLDu9Ld+y6vZSR5p38zvNUqiNs3vSQlasopGQVnq/AVn7AFRXoFzszxPTXaGj5hipLuN
         VwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762913674; x=1763518474;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lVQBcx6xFjlJyhg8EGvnzlqkKD9tleq1IsOwgdEnnOg=;
        b=ounAe0kKH9XjGphxvI2dM/i2pWivl3HcIFmsXAGeXfI3XpvtR8jxsabA3a0wcIZZ8z
         HeTm2Ss+SIl+/izR8WHqieaaLvuP9njDu3y3PE8hZjZ0lIDTwc++ldkCsbRfNwG/9C0+
         824Wv4vHQ0/9Mu3dpWvClG0w/i+5kgX2+bmPCqbskbGBsbRKpLIohGz+RzW0YT3GKNKz
         7GZSZxn+oQoqaEs02/sji0r4gTYlf3SoVL4G2Wo9BpihqmNJq6vUyI0hgUiRCQZOmoBY
         tg0BYauqeb+wJJkM7Q3MQD8mgUEAlhfKGN+rG6EuulQpA29KtzeEl3MccdCCji9UmeRX
         tpHA==
X-Forwarded-Encrypted: i=1; AJvYcCUq/5Y8G4ocD/fHc58c6Ij4sJOT18NAoFRJGGPRZKfHUR8pt6iY9+3ZswQUyZznPvcI4QAgn4FHRSuXZ6b3QfB2xoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVOW2hUQQKFjs4fMY0FJtjHpuOl0xvVKA0JSE6XeM6BLu7L7R+
	LG0vzUCCJnspI+qgVdrOFyKbnFeWb+mbx+L8a/PlT4HJvfgmiB3NdjWZ
X-Gm-Gg: ASbGnct+T5dpJq85jeMsHg5aBYUWpqgjQq7eiYiGlZIRDPzGHqRd1DUqUdza6jZKjvO
	3cdkArfh4a7+7Zp0cArYqWiAW1tcFyzm4FOH7aK93Oh5EEDn07nv9S6slZFBaCv1HfJMZy7ohaD
	3FfsN47RJjgyTofGA+Vkv0Dj/X4hEI4cfvdWQbMvBVhs+R1eM2q5LzYRI8Mw6w4BfJmtmNOiKjn
	oR+OURxLVwaaSYtaWFTgkYJ5o228ktTn+Sq5JM980VcF3NN33UYuBgvvP0ViQQGMIhtvq4OSGxP
	rIsrKJLloV7tcysujtOg6ZGLQgRsnMiJKngB+3jVD6ET3x9BNShmdjEbdNmUBRW3cgLy1b7cwDJ
	yywX/GMpegFnIiZC2tycTYtXueXFXrT/htNPIGEGSotWvl63JNAya/rjYShW1+lh+OY4+WlLW3w
	kslmEEnHdJkdo=
X-Google-Smtp-Source: AGHT+IFqj6mSlRUdzokZ1Fx9dnl2ksqvuqBqsXipooXRvbblexf8W6duI6LZnIuMeBzrfzf2MAr1ZQ==
X-Received: by 2002:a17:90b:1b0c:b0:340:a5b2:c30b with SMTP id 98e67ed59e1d1-343dddf6caemr2117777a91.9.1762913673519;
        Tue, 11 Nov 2025 18:14:33 -0800 (PST)
Received: from localhost ([45.8.220.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e0714267sm559591a91.6.2025.11.11.18.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 18:14:32 -0800 (PST)
Date: Wed, 12 Nov 2025 10:14:29 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marco Elver <elver@google.com>, Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ben Segall <bsegall@google.com>, Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	David Kaplan <david.kaplan@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>, Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Justin Stitt <justinstitt@google.com>, kasan-dev@googlegroups.com,
	Kees Cook <kees@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
	Miguel Ojeda <ojeda@kernel.org>, Nam Cao <namcao@linutronix.de>,
	Namhyung Kim <namhyung@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Rong Xu <xur@google.com>, Sami Tolvanen <samitolvanen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
	workflows@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v8 00/27] mm/ksw: Introduce KStackWatch debugging tool
Message-ID: <aRLmGxKVvfl5N792@ndev>
References: <20251110163634.3686676-1-wangjinchao600@gmail.com>
 <aRIh4pBs7KCDhQOp@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRIh4pBs7KCDhQOp@casper.infradead.org>

On Mon, Nov 10, 2025 at 05:33:22PM +0000, Matthew Wilcox wrote:
> On Tue, Nov 11, 2025 at 12:35:55AM +0800, Jinchao Wang wrote:
> > Earlier this year, I debugged a stack corruption panic that revealed the
> > limitations of existing debugging tools. The bug persisted for 739 days
> > before being fixed (CVE-2025-22036), and my reproduction scenario
> > differed from the CVE report—highlighting how unpredictably these bugs
> > manifest.
> 
> Well, this demonstrates the dangers of keeping this problem siloed
> within your own exfat group.  The fix made in 1bb7ff4204b6 is wrong!
> It was fixed properly in 7375f22495e7 which lists its Fixes: as
> Linux-2.6.12-rc2, but that's simply the beginning of git history.
> It's actually been there since v2.4.6.4 where it's documented as simply:
> 
>       - some subtle fs/buffer.c race conditions (Andrew Morton, me)
> 
> As far as I can tell the changes made in 1bb7ff4204b6 should be
> reverted.

Thank you for the correction and the detailed history. I wasn't aware this
dated back to v2.4.6.4. I'm not part of the exfat group; I simply
encountered a bug that 1bb7ff4204b6 happened to resolve in my scenario.
The timeline actually illustrates the exact problem KStackWatch addresses:
a bug introduced in 2001, partially addressed in 2025, then properly fixed
months later. The 24-year gap suggests these silent stack corruptions are
extremely difficult to locate.

> 
> > Initially, I enabled KASAN, but the bug did not reproduce. Reviewing the
> > code in __blk_flush_plug(), I found it difficult to trace all logic
> > paths due to indirect function calls through function pointers.
> 
> So why is the solution here not simply to fix KASAN instead of this
> giant patch series?

KASAN caught 7375f22495e7 because put_bh() accessed bh->b_count after
wait_on_buffer() of another thread returned—the stack was invalid.
In 1bb7ff4204b6 and my case, corruption occurred before the victim
function of another thread returned. The stack remained valid to KASAN,
so no warning triggered. This is timing-dependent, not a KASAN deficiency.

Making KASAN treat parts of active stack frame as invalid would be
complex and add significant overhead, likely worsening the reproduction
prevention issue. KASAN's overhead already prevented reproduction in my
environment.

KStackWatch takes a different approach: it watches stack frame regardless
of whether KASAN considers them valid or invalid, with much less overhead
thereby preserving reproduction scenarios.

The value proposition:
Finding where corruption occurs is the bottleneck. Once located,
subsystem experts can analyze the root cause. Without that location, even
experts are stuck.

If KStackWatch had existed earlier, this 24-year-old bug might have been
found sooner when someone hit a similar corruption. The same applies to
other stack corruption bugs.

I'd appreciate your thoughts on whether this addresses your concerns.

Best regards,
Jinchao
