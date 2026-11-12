Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508436;
	b=AGMJ4B2tN2xc8vJUb8vq2P0ehsxZqLWvmPJq/EpXS9mIiJ8Mbjxa+te37GHL6JyMd+M+
	 i5eHRfbBmstiYEkSSDKPBXGSZNJgzob87Hyt3MybE9wbFAma+pan1vHik56Xnve6PKU7H
	 SV+AeDx9/oTlQ7tGTPAY3H/WISokeMFZXHGT7NrER2YABH69Oibas8eSg+NMsYAs81ll6
	 G0sW3/wSnKf1Q3dwSrjiRTMNFFXz8CPAi5sAcsJ/jg0txVElPK3Hg7hZw5pcAapZu3eFa
	 BSuDI3IydaROfCdr+bBEeT6UupQfjkeZAUPgGxnKXjKArs1Cwacx+KjpJeZx1m1TdbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508436;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0T59pX0NBuc6eb0M//aPEdCc6M8d0Cv25oKr0gLdXm4=;
	b=LVIUHhvndJXWjZjq4mktmHkpHQxEDoJa9QUDmF916/zSkDG6hzE/bB68b+J28JZUUmon
	 MjlnoOFDiFfXfpxSVAHTqrthjxqQODJ3i60XQAoPHsuQz4QvLpD22nMsw3aX5qDYIn97+
	 lBNGPnu4FmJIHxPirU2EyAUB7TZqZaa6RX4MU8NkAJ0ZfQReDKjiMB5hXwonUNoIC7bmU
	 j/2DAQK1DtiaIaECxhrlUV4uDU/UHCTl9oYfHurs4E1fbbiTrkYFc4I7hq46BnNYk1wd/
	 sXblhUdX0DKWgAjJgIEBkpZFnxaPBiFGmysH6PNeJcXAtPo8Y0VJzQl0pVmFqNKRV0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=imxi032c;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A015606A33D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 18:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A015606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=imxi032c
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so6325666b.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 10:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794508434; x=1795113234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0T59pX0NBuc6eb0M//aPEdCc6M8d0Cv25oKr0gLdXm4=;
        b=imxi032cS0x76ZjKJFrnJjVcpa4j/RetctXMOzH/RAoNujK81/PGf3OD9XVYf06OD1
         vMOvSOHUE1wes4tjT1uZAJSvdzXng96OWh7uXcoizRID5Qg974oCg9DJKqHlfSgvn0yB
         HHIrjDSMWAnaoz6IMUo/apC7uFmgXX5uqLfubomxF6t6a6FERmpTCCxABUYjEawULXD8
         klCWqBM5uZl2TzEOtDF8+awi/vDwXsGP9mrDUvkQ3x3dvy2DALPta8aXV3ALMPfppqQt
         QWVUBf5h/qbYDOLqSp+D8Q1sgXktGZ452oL3iWWjvUjnOjMKtiaDUjnMGMQH8PY1ThWJ
         yVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794508434; x=1795113234;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0T59pX0NBuc6eb0M//aPEdCc6M8d0Cv25oKr0gLdXm4=;
        b=eqiyCYlyj5MPCPZJkzsFoW1bUxQ1o4UynXdiE5v/WiiOCBWgQC9YO0rJKxxv1TKxdH
         3dBBf0pclSu0xYF+WUJTmZYxmRMsZ7VzGtnFfdLceWd9kngi6DcaDA007UYSu38UlkK7
         LEbKxvXt75Gx2hGo+yTMiV7lzHI3c1+s54mM9diXMNuLNO7kw3JJ8JtKkFO+KNXIcI/W
         WNgz/KZukV5oIrw7KzWC+6S0jVil+8bg7fxCmOO3BiGv3UY6TkdFi7FJZ6bjF6RCNx4n
         8S+kDPqz6r/6HwFbbg+5Q94/XyjbSjG86hlrreUUXl7Clqy3nBgwnZ/4vH/r3EyYQXmz
         C9zA==
X-Forwarded-Encrypted: i=1; AL+hErERx+Ce2Ie4u83ErcfHdZ78xk6v1ODDcom87dhk6UZVyFBtkK7jbRwLLBUqiyot6TzhzPeGhtgMGHMc8tr8FtkC/Qk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+eWZzd050YfPR2jhOW1qeCDGkyTbXaQHylzCsV4990YNGStxg
	4Q+xAw+bSVfunEiml6sMUSPbactSJ9KQt9RzPH2iXJVf1Xj2vhJ7FkktPM7r+ySN
X-Gm-Gg: AYBFou1zqkJQKYhQDcNGXb1t+05nvB0H8VjhsWA1okLH6r9TNdxfZc7jKOvrfNBkGUc
	TZdchtTvIc7Jo7cpc3iqvr3hvkcUjK5Z03s4X+glGUJM9SFot5lhiXhtDwosiYOdJJDTBRkCOQK
	6LsYVgZGIdkwp2YaELZYs8biSEHn9H+ChZFV9TFKjoUlHAvGzKuAQvtjozS7rFhZ5iWc5bt3F37
	Gptuz8TuRoWNoE1yUj8sqB7Kntg4Y5VTmfl7RfxfYCMlwm26YFy2Dmd/70m0IrdZiJAwBFRTbu0
	i8TQW4PcB3j3TLtXaQb5gtwnSgeREjxTs47qXtMylPQYcTbzhAfvGV1mr5eFHFUCcaPqVB/fvGo
	FahnHiXrEH2hwNvJx1NUgrF7MNgpB2GTW80mScN86ZQ+rhBq/EyFGslTJ9ir9VDqEDUzs0FtgHa
	04LXAxnFDCBcyC9WDSvvG0sjeqTkbeJpKbx/4MBhAE91NCGkiPWBZW84g6o5yI83a+ZNMyIeWy6
	I6wSKJPadXCmBmTCBrMRD8vfzmmpxQcHPOje4moGeuz7FQWOP5qNYO7r3qAyankmrQzh71ow/Qi
	L1ph16QtTXQsJWcF
X-Received: by 2002:a17:907:6d08:b0:c34:e9fe:82ed with SMTP id a640c23a62f3a-c50963d803amr9289866b.28.1794508434209;
        Thu, 12 Nov 2026 10:33:54 -0800 (PST)
Received: from krava ([173.38.220.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b236edsm6328666b.23.2026.11.12.10.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:33:53 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 12 Nov 2026 19:33:51 +0100
To: Peter Zijlstra <peterz@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Alan Maguire <almagui@kernel.org>,
	x86@kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 03/13] jump_label/x86: Avoid decoding instructions for
 jump entry size
Message-ID: <avYGjyj9-g5jugTt@krava>
References: <20261109194916.1089703-1-jolsa@kernel.org>
 <20261109194916.1089703-4-jolsa@kernel.org>
 <20261112083945.GF2668804@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20261112083945.GF2668804@noisy.programming.kicks-ass.net>

On Thu, Nov 12, 2026 at 09:39:45AM +0100, Peter Zijlstra wrote:
> On Mon, Nov 09, 2026 at 08:49:06PM +0100, Jiri Olsa wrote:
> 
> >  int arch_jump_entry_size(struct jump_entry *entry)
> >  {
> > +	const u8 *code = (void *)jump_entry_code(entry);
> >  
> > +	if (code[0] == JMP8_INSN_OPCODE ||
> > +	    !memcmp(code, x86_nops[JMP8_INSN_SIZE], JMP8_INSN_SIZE))
> > +		return JMP8_INSN_SIZE;
> >  
> > +	if (code[0] == JMP32_INSN_OPCODE ||
> > +	    !memcmp(code, x86_nops[JMP32_INSN_SIZE], JMP32_INSN_SIZE))
> > +		return JMP32_INSN_SIZE;
> > +
> > +	BUG();
> >  }
> 
> Does this actually generate sane code and checks code[0] first for both
> values before it goes and does memcmp() ? The naive translation would
> suggest it does not.
> 

nope.. you're right, I'll make it explicit

thanks,
jirka
