Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF0F34DCE0
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Mar 2026 21:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475343; cv=none; b=O/LomRJ5J+M+zYjcqrxznRb9TRhwevkuTqPU65mMOXIJWm9up+UD+RhVQPWtCUTJwT+OsDMQQMED1nmCKLm0dE3NSdlE/xh7o58I6Js/50AYE83w4PIbNpikm6LgalVnOxLAizBtHlZYqd02+1OSfEW1sqy0GDBnCUyMUaVvHwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475343; c=relaxed/simple;
	bh=MsH+PcXT30u+lJy802VpEE2WroiFoM+7z3TtQBxk4pE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCLH5msSJBlUo4P3onW0CrhDi2y1yOGSnv+NTxvZpKQMAizGn0KvwEzfuXDXRgF5DK2SbDHOBHJFTgBZOrc5qBc9GRqYlEbETU0DUwzjRkmPRZInX06Eoy/y2f5Xisob3t0U/uWPo0Mj/KmYWzku3SkOTizOFj9PM7z5/NnvyKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NisCVJG2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NisCVJG2"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48541edecf9so3781485e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Mar 2026 14:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774475340; x=1775080140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FMoNBjl/XwK2i9fbEYYiMgexUSM7RdwiRIGsr2oDlWQ=;
        b=NisCVJG2JgflV5gIbEfjBJSJcy6Jc09c07pZy6ak9QbhMJ3bKTVDMVeqMKDYs/X3Ca
         S4PGyx/c0wVQupe1nbY1jxsOSieKWLxAW9ARVYubBqVQ/G1vwwdSZ4bHJnYiuFNnfkNj
         yJBlwAsfdnOhDhqIl2JSoWKGktIFCVz+9kO+p8B64x+SavBtWpAO/f77zikJXGaP/xty
         rLcHOtZqz1EDmOZMUc6dE+nyVZXEFQUmwu6PKV9tqYuofbNFDzte3xY7XBz30URqR2HM
         fiBvDyYB8R7RbWq2IgTLlsr3u27QPYb6FEyqbURIZqsdC5WiGM3D+jFEMRAryOsop//H
         eEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774475340; x=1775080140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMoNBjl/XwK2i9fbEYYiMgexUSM7RdwiRIGsr2oDlWQ=;
        b=HQ2h99oxx3VDnufRw5YDCtdNJOXWsN7eqLSSduf7T9amsynfUFi1KsmFUnijfexSgA
         UEU7Jc63HB3odxIZN4DZKptSAVevqAeqwiX8DAZgXR8I/kTuye6x1rj9F7RdKOM1MiVD
         hcAq9rPo2RZb/pwpdQzkrGKwran/aQY3CWnoiUJNCd5Z7GPvU5qRZADR0aeBEkK/OxU4
         UMYW3xfjGTGd7x/WKWIqQj8TcQv6sCmT0GMqpWDxYdeWBLBPaW/cU7W4tEeXxu1N9UoJ
         LpOgF/i5LeRUAniGzgbLs4SB/+/AJkBhgRqFn8+lYjlefTxWN9g+TO4BKZFSeC7YEiov
         t/1A==
X-Forwarded-Encrypted: i=1; AJvYcCV4VxEhZxLOJXzTEhk4PKJ6Bs8Rb5SXfS6VYFlgfOhO+ATox4T69E6L+UqoiypHPtoxvDqOoVp4j8wc6dAH6QbgVAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqIHa1r3KOM/ZK0a+KLMHbQmTQU/uXDYAa5keUnAyG0PK75Yta
	ZQPzdyCc1PvQAc710FlwFRSQb8mRII+En1WZj1NYPzIcDyUm97xX8GrW
X-Gm-Gg: ATEYQzxZhI6dokODJNGNpOU1ne5smrLv7r1ImN0TnAC7aZW3faaHsPjnTe5HOSHucjW
	mXLaLZ5TGcHUYcEDkSVgLa+jcidBmS3Bjayi9RzZ/r8k+Rj3RJC2GNpwn8Li6t1NemaX8A6TrrR
	IHpSSk8iLB7SW5ho/NHJmyAppVyWyF/LRJe8S+q2yHkEetLVX6lkFGwHGayQAOc2zRrIn8h7970
	1FqVqxzX59idFa+XcB57UdrrTZlX8BgNXBc8d0v8w5z0IF+YMR+SKrNOySgmPwzpyxv5EIiZxyu
	YGhW0G9nJ3orpY099YPb6H7I8DfEQPWOSUB9UwAPN+p2GEdK+sRDBkBhfILgKDoUmfarrq9ovm7
	sPPRh713njHm+J6zTFN4rMVVuUNH3QmpdCXDMvWYZFH22YN3K0KglKTnynRQbKRXcyDAIfudvln
	v6HiGBCEgN3ayojQxOvMpsxcvB3nOb7Y4sRinNOZsCKg==
X-Received: by 2002:a05:600c:a4f:b0:485:3a03:ceca with SMTP id 5b1f17b1804b1-4871606c9e8mr64820085e9.23.1774475340059;
        Wed, 25 Mar 2026 14:49:00 -0700 (PDT)
Received: from krava (h082218179122.host.wavenet.at. [82.218.179.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b9192e3e8sm3094304f8f.5.2026.03.25.14.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 14:48:59 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 25 Mar 2026 22:48:57 +0100
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [PATCHv4 bpf-next 24/25] selftests/bpf: Add tracing multi attach
 benchmark test
Message-ID: <acRYSeQm58rVpWzk@krava>
References: <20260324081846.2334094-1-jolsa@kernel.org>
 <20260324081846.2334094-25-jolsa@kernel.org>
 <7a119223-9994-4edc-af0b-f1ee9876cd20@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a119223-9994-4edc-af0b-f1ee9876cd20@linux.dev>

On Wed, Mar 25, 2026 at 02:45:31PM +0800, Leon Hwang wrote:

SNIP

> > +
> > +	attach_delta = (attach_end_ns - attach_start_ns) / 1000000000.0;
> > +	detach_delta = (detach_end_ns - detach_start_ns) / 1000000000.0;
> > +
> > +	printf("%s: found %lu functions\n", __func__, cnt);
> > +	printf("%s: attached in %7.3lfs\n", __func__, attach_delta);
> > +	printf("%s: detached in %7.3lfs\n", __func__, detach_delta);
> > +
> > +cleanup:
> > +	tracing_multi_bench__destroy(skel);
> > +	tdestroy(root, tdestroy_free_nop);
> > +	free_kallsyms_local(ksyms);
> > +	free(ids);
> 
> Is btf__free(btf) missing here? Since 'btf' was calloc inner
> btf__load_vmlinux_btf().

ah yea, will add, thanks

jirka
