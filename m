Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794292512;
	b=NA+V5V956iq4eJhDgJ/+vs59J99dXpVAXwLRhTBuvyCWxcQ6/DczH548PHDNAEEq+dRP
	 P1kMlDgkLzXwR5RZD3OZ9XMiD6uIzmt5J9j39zMZJ0fgivSAawo1sR4NkZvNIQ7b0/eCU
	 BB2m8rLn9yzrRfsvPIav4Uwz/kN4fNUwhlWKslTo5BdG6z8S6YjK+7xolQPSPnhr5waIT
	 rQjyq8wcRYzf0rFAJcJ0l6qSJTjtTJdBBCYX3L2JCPkJMVDlmgEu5H/TON530RzkLTQc6
	 TgsK1bLP9Pb9wk67FzGxDqHKXfZOimoQ11mIdUsxPfCEKsRN5GJ2EFDk56iJ7/xPjyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794292512;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=SrAtUp9emSKSwdDhGVp75ycz8yJkKPQkr0AQDP+R5XY=;
	b=sQ9xWyAMbbaN6finMi9366c4BzIxjLZ9N2i/A814YDF/sg3EX9LwGoNicTXQkGC0wXfS
	 xQp2VjdHamSj71zQtnDlR3je9D69pwWdz/nNIzmqgl45u+RPfjDjJJzdpqRU0zvmS6jUs
	 JjlJ9nwD1UwozTeV0WImRI4zPsbUsDRSVtOnWVtGaWrbpoeqCNVItwHfu4E3v7zxngqHQ
	 BcWtj6UdQZxTHbo64IRDCPp67PcgZLvEhmKEvbGXqMmN1qJ1fZUV/LlfvZ3RHjfSQXCZC
	 VtofQxF8dk1ffUMNhfAN4wJkuE/dt7fsqnwQpMeow9Wht4KG3LySf2WtCXNGoQ7asSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KvZh9KkF;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D38606A33F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 06:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96D38606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KvZh9KkF
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-492f0a1b685so1093075f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 09 Nov 2026 22:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794292511; x=1794897311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SrAtUp9emSKSwdDhGVp75ycz8yJkKPQkr0AQDP+R5XY=;
        b=KvZh9KkFCB0l/6Bmr8nRlFNiNAYwTuU4bAbREFGDiprWKCca1D9gjGF60eGJA+3F1m
         /bv5d5Tc5eWM5D865wZT1/xR3NEMOOdRqy4g1KkEy4dNN0ai3E7ZEOXBKCO9AA5jrZON
         81noRzABdcThsTx/uPfWP2XKO8tbYcZNnqcldty/UzrmzSJt6LP+9II6IP/t+90m35A4
         cHdS20nAQY6nLpp4JCwaxwmfEkKJkszzwHAQ0RkC24pcwIC8g2itd/wYEPWH0RU5LloK
         +jxZ0egu/5nUvtzeuP+y0T3PHWti68rhJPt30aoXkp9b4h0G+AWEqtc8wek4WNU9qfaJ
         cryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794292511; x=1794897311;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SrAtUp9emSKSwdDhGVp75ycz8yJkKPQkr0AQDP+R5XY=;
        b=2z6TG7rAMag5JfsJ5eNq6nLTYXstqPJDLSN/yKiOL4G7/41cDoxb7hLeHNKftkrt6H
         yC3jHHP6hFqZUxlckseWQl4TjNx8JwKfYSsQGVKXBc4r0pDXf8EbjNDSQhfkih1MNCfB
         jgl+DkzaHheF7s9ibseo7yMHzFUWSM0GWVJRGwCllMze7UVg6/5AW0oPwSOI8O5fz4fC
         qOAu5YPS3Z8rjyPMvRBeKmo+gxKBrVsfi0gZQKhsvXXuI/drerh+k7oa24hzw7J/TJrZ
         7AOCQ/1rkWO3U+i6ANaO/4NpP1g5mKKG6+wfkUYFUG0CkJ5aqgJlqiHTh9X539pi+4QV
         jiFg==
X-Forwarded-Encrypted: i=1; AL+hErG3t1L8yxASH30RCAAaH91f5l1/9ik2W/S95Zpp6d/6k9PnqTNZBx6XHE+O2yP4tBhAGnd+Kc0SKb8S+LCUXfbYDCk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+uqcFRk41oHraOJI1Do+unidTvf+tUUTyapfFLPFwHEh/q0eRt
	nahigSKDBE00ngLLgDtzUFoFSuqH2t5zt9Use67TtYJHMn02mMfHeauO
X-Gm-Gg: AYBFou0h9fMeuSpv3WGdV3tP3W0CXhHScPopyH4kb6mkpyfuV4kSdti93D0XmR9Z485
	CyNQGIG50NVdrBVp8Quoe1R9hlN3EZH7s7kieDYg8hcUEbkfSfUpvmOx5qOMOR3WMUIADpSdu1g
	lVckEQZ18OA/ouorcA5Z6bjelSbW3uP9VlA6Ztah08WD8Jd5Hyrcs1vwOFY/Bwk1IIgrpsge1Y6
	2YoutAf4k1nO8oZd/OjDWBaR0hvABjCNABQgMaHa0Q1RK2/IkHWZ5mZalzRl4T3mqamouD1vqkk
	OIR4t3NPBON2HAOKBkN4JB8mqc45bIe24xYjS3IsXw7NOjtVP9z5Z02jgFlOlweBvF5J/sLKs1t
	3yVAWc0UGA9CWaoSfeINIY/2KaYY54/QqnTw8lk6XUuo9NT079djoF7tJ9myC28zii3vhqBODD1
	FwW2Zhd8qhSgCSzMHNOvOQuFkwjELQ84Z1ocKlDn7B27XmwbgSLl/pNtNAQGKLgJ3qPj00b6JTH
	N1jHK9/H7fhhp2JR56A9LAsCdn2gvkmh/qf0fy3e77pae8HrJWZuK1nHhqp0ChGuaTJg5N+zo5e
	1Dw4wLuTVHenZQoAbWd3oetL844cYT8pk3gTxqKVm1wlkHkccqSlLverIECL17JFwMDeR5/uPtc
	KGQt3xYU35aiN52u84LeISuvxted+/0yKYLL0YUOzAhEn/OkDtNOaUdbTX5AvEz9NQ8icZt1bC8
	v6Xyr2GsY8bP/X1m7Vq+MAk22zgZ47Smw=
X-Received: by 2002:a05:6000:288f:b0:48e:3cec:b852 with SMTP id ffacd0b85a97d-498306d02e3mr2957082f8f.40.1794292510590;
        Mon, 09 Nov 2026 22:35:10 -0800 (PST)
Received: from MacBook-Pro-von-Karl (dynamic-2a02-3100-a0e9-dc01-c402-36c1-c306-953c.310.pool.telefonica.de. [2a02:3100:a0e9:dc01:c402:36c1:c306:953c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498366c500asm3241156f8f.48.2026.11.09.22.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 22:35:09 -0800 (PST)
Date: Tue, 10 Nov 2026 07:35:07 +0100
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: palmer@dabbelt.com, pjw@kernel.org, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, linux-riscv@lists.infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	pmladek@suse.com, joe.lawrence@redhat.com, shuah@kernel.org, mpdesouza@suse.com, 
	martin@kaiser.cx, oliver.yang@linux.alibaba.com, zhuo.song@linux.alibaba.com, 
	jkchen@linux.alibaba.com, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v7 00/10] riscv: Add reliable stack unwinding for
 livepatch
Message-ID: <avK6oydgmtsa_Sjg@gmail.com>
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
 <20261110013750.36800-1-xueshuai@linux.alibaba.com>
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
In-Reply-To: <20261110013750.36800-1-xueshuai@linux.alibaba.com>

On Tue, Nov 10, 2026 at 09:37:40AM +0100, Shuai Xue wrote:
> Changes since v6:
> 
> * Rebase onto the current riscv/for-next (based on 7.4-rc1).
> 
> * Fold in Karl Mehltretter's two patches [1] as 1/10 and 2/10. Patch
>   1/10 stops arch_stack_walk() from reporting the walker's own frame as
>   the first entry, which corrupts the skip-frame accounting of
>   stack_trace_save() users (page_owner, perf), and adjusts
>   return_address() level accounting accordingly. Patch 2/10 adds a KUnit
>   test for the start frames. Both patches keep their original authorship;
>   I added my Reviewed-by/Tested-by and sign-off. I asked Karl on
>   3 November whether he would like to see his patches folded into this
>   series; he has not replied so far. Since 8/10 reuses the walker
>   extraction from 1/10 for its !CONFIG_FRAME_POINTER fallback, his
>   patches are included here to keep the series self-contained.
> 

Thank you for folding those patches in. I'm fine with that.

Regards,
Karl
