Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793445050;
	b=3Ia9At7gj89suvTvdJ6WpnvvtRbn3GFd95L6MkphNQy1qwSAVYX3LzCRcQiv1zBd83s6
	 TXYpLYu6J4HQUdMTXqnFSCTnO+SVF8pvY4KlfFoJGZzFRjEhYZc5E1TMx8MTrVc/kSRp/
	 63YORGB2aCoYMp6KbpZICBr3EiNSioB3zdu09p7aQBpDGd+pdKif/1ZcZ6DKIcarePnZN
	 3PMjOe15ldnOgac+74RbugzM94lhjovZVFAQsuAZjRSCuazkgwaR0feLgT2bw2F94TbGM
	 DAwORxwznZXvY6HUvrm/4vBj4jeG5bLEnSHKexnqEFGyNgsyq+TOI2IRQu6wkgBt+vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793445050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=8/DEyBWZeNjbIYVLMYEXjqZxeouD7j/CxCTXFjXVFWE=;
	b=YP37pjl+t7m/jsnsh0FRcUy68G8Zi3qPZK0NaUeSWUd+qmTUoaEh900II1LzkUTsckuM
	 KN54pHtD1z4+nlRI3yi/Ju5jAVOOAlLXyEIVKgA+XCu+chwHnfart1Jm8ix0VrqmtZIqt
	 YHYpsSpaCd0yBsG+L78GBjNUy2xbouocGN5IxNqsrK63Xp0DHQOFw9yrlfjcyLqmTXXcN
	 G8uH/EApQIiAigoB53A1IyGE+i4vP/N8Oy2iwfwLlC6MxEkNfilTt+We8B/79L4MNUCfO
	 mJqxfSNwVC2lujnfTS9UfKtnbWWnHc/VsNMBGlpRGI40DYQhdnLSIS+rayU9ajSoz4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nlvriD47;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB1C606A31F
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 11:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EB1C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nlvriD47
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48dee593f18so1257292f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 04:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793445049; x=1794049849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8/DEyBWZeNjbIYVLMYEXjqZxeouD7j/CxCTXFjXVFWE=;
        b=nlvriD47siSUj/pHhAZKx+QLV5KHM/oCUhB2Z72IcmRKuDh3jiEue41W2bEqqDFxx/
         epSfCs0ji+w96+RHDverYdlufb2BeD51SHb8d3aVAf+bP+sHMqHpLrleLcr8XhEat+Nm
         VvdLIP08AZAu/HYXHTlVeHrk2AaqHs9omZ+vtzdVJZTnqNPbFwfOqYWohu0mLNHzx5kJ
         UjaZlR+pqvdN6OFKp6OtIFKhTA/nOquQtmw59tEofdPcG/4gvVN33faezMupVGz9Vq6b
         7noxXbyB6tLXWzdp8rBQ+Uvzirz/0qTMpQojvrDhungxg0breARLZraCM2bJ7BqfbDNO
         f57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793445049; x=1794049849;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8/DEyBWZeNjbIYVLMYEXjqZxeouD7j/CxCTXFjXVFWE=;
        b=MMax64LzN7KTAfqPkomLNGvNw8fpyDKCBXEspdZmmTRyrjTZ7ms84lsaKJL8EUliEb
         yMFKGMToR4CLzkZPxFMcV0q+4ZalSvN9op86+u9+An4zJ2L2psugWzBQ0pLCMSIoIfaB
         fFhqyy2KZwIWJbIY3IPu0UWw+ha+802yEfFTGX/Rnb1BuDSeoUCpbTnXXw8uNx/kgwPu
         5SJGq3DlqShDehM83CBIy9NmREnWuT5GoMA/BDvbK6kQ5T9rKpkHbxB2DZENEm3FTJDI
         8SGWOJV2TER9XyrFftz15HynlQhNugVE8zp/65qzEWCdQs4aAzQaO4xv5YQNoUIhxO1f
         3YhQ==
X-Forwarded-Encrypted: i=1; AKwUvBw3vw6wSvFe1Aa2/oVKaUc0JzQTO+lOHA/Hwg3Cjxnk/95xIpQ8wRa4JyY2iPh4U2x37oFTuydw8bYpDtJ9ympkpUo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLMiLEJfXdqEh+DWi1AwScz+xGxuUM7s5qLxJC74JsXc5GiygUu
	g6hHo5KXT6OrmSXSXzgc7cMrXhmH7GasU0PypIYq9JgnWolF2vRRYNPg
X-Gm-Gg: AYBFou0HeEQDf9CY1mduI9kYJQdzz54cVKHNDuiSARIeozgblMLOrFvuDawm/kWcuMe
	yemctWVB2XofoRQXjdxwAcFahUOICtfIapIqGWOykZya2hTQGBR8pax2TDOtq05Qb1xFc2G74Qi
	ggtZKT/Qz61td9cmhlB3+6sNn3vRf4o3L3G7tPYHbTQ0NVGU/Qy8C7t2QoNDUDn3++RUtFWGNkz
	huUAfDkCHQ7indBZEWoZYyCQk/OJobIX/Y5lERqn7b/tD7tAWhdxJPdWKKZjCKSDqJhQr8fss0J
	zhBLEZ0Qt7oIC+JEMByMWgKuadn5n1pz3RrwUOu9Ha6e19RLBOK8BJtnU35bT/Snp1qxYnexjDC
	vtoy2pk3AS19TsD11Ff6D+3Kw/sZf2+avQoJv6O2oXGB7H5gtm2q8JcQ39OzhErnv9CAPTHFrm+
	kABuRvDtYaiQpiLUFRLj4jS+n0nGZJLU5HX+3/SONuVCjcTutNUq0t3jLbVce0DL0XwhpdrOsKY
	gKE7KnpKYq0xh52DGWNRkaLNUUu92+S043iiTKtVEYg1w27lLk0FV8vaZH9DR5jtJ1JV8Tnc4Hc
	YaijmDEQEfJdxr0RilsYxpso+WS5EjJYPZir2sZvsgv034G2ErBd7ng/hQobC+vtrlqrn8LftrW
	b0JcfOevrB8Eo46vS0FeKHSPlmJG3a7f4Y3eUV1AkAblH7qoJa20w83ih6i8+fkYKsaFaOOox/q
	h+dX/kjshaY0L1JjtFF2CDaj6t7wJp
X-Received: by 2002:a05:600c:198c:b0:4a2:5ca:767f with SMTP id 5b1f17b1804b1-4ac151a9a36mr117500995e9.4.1793445048512;
        Sat, 31 Oct 2026 04:10:48 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a81d-e001-9c9b-db33-f166-0fda.310.pool.telefonica.de. [2a02:3100:a81d:e001:9c9b:db33:f166:fda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf67aa704sm117315545e9.8.2026.10.31.04.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 04:10:47 -0700 (PDT)
Date: Sat, 31 Oct 2026 12:10:45 +0100
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Hongyan Xia <hongyan.xia@transsion.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-arm-kernel@lists.infradead.org, 
	linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org, 
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 03/13] sched: Split preempt-count bookkeeping from
 raw updates
Message-ID: <auXLfz6mFh_uOvRr@gmail.com>
References: <20261028033127.82193-1-kmehltretter@gmail.com>
 <20261028033127.82193-4-kmehltretter@gmail.com>
 <20261029093219.GH1779021@noisy.programming.kicks-ass.net>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029093219.GH1779021@noisy.programming.kicks-ass.net>

On Thu, Oct 29, 2026 at 10:32:19AM +0100, Peter Zijlstra wrote:
> Urgh, so much crazy.
> 
> So WARNs in noinstr code are 'fine'. That is, they should not happen, if
> they do, bad things have happened and we need the warning out ASAP, if
> it takes the machine down, too bad. See the
> instrumentation_{begin,end}() markers in x86 asm/bug.h.
> 
> But yes, the tracing needs to go. But moving that around should not be
> this ugly and also, that will give you the opportunity to fix
> preempt_{en,dis}able_notrace(), since they currently also skip the bound
> checks.

Yes, that's a good direction.

I checked the call chain and DEBUG_LOCKS_WARN_ON() is already fine in
noinstr. arm64 just needs __always_inline on preempt_count() and
should_resched() so Clang doesn't outline them.

I will work on that.

Thanks,
Karl
