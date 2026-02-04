Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66053F0777
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 12:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770208913; cv=none; b=M0k5rXg0T2TWqjJDfZvslMa2ibbjO0Rob61rvV3lkmkQNceXAB7yeg1v6pn4KV3zZuJbS6AaNa1JmUaD62c5MZwLPFoTKFsrI6zE+wXDlZv6ARVHe7NuQnHTrXqdvZ2o9TC6oIM23ULlHX/OvtOQFtVSm8cXgeq4NIh8pboNvNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770208913; c=relaxed/simple;
	bh=JhSyZLf5exlf/95F7gHqaO7ZTGaK3U3qx48Q/8jzcUI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrMfP7aY0JPt0pIGXb13T3rdyjtaUXkStCDQ3h5fJxZRK4acLkauU26gWY74l5fxoyhgY9z9vZkNA3pBOI5+SiC7Nc1slA8SEuQyfozj1XyXJ1YoOnkIauvkLTGzdQ4jKeezFLF+NdG+EN+64oOdaGy1Ren457UiWTx9V1pt14g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiOosBKu; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiOosBKu"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48068127f00so58599485e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Feb 2026 04:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770208911; x=1770813711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sipdmvJVf7asP1VhJpC4Xbp+ZBzA9tqFuT/7XUNiBl8=;
        b=EiOosBKuEdLIpEZW3rDR6Cw4kAC0XggbEuw/21AG81NfNYE4PRZftayMdJjc/9TrCu
         cA9o4MuxoetDWnVkKMzUrRaRhgmFD/gOF2aGkRL15Z6Tqkklx9s4Is2ICNp3L8F/IHQN
         1qvm2Q6KYBzTcNyrMlHqH7YaQ/pq2U5kt7oBHVwMWn6apX7X+5dN6HjfXBaGyhosJXDd
         W4MomGR6Egkkjh6Rmkdog+1oaNzr2mW5vdBMWCeEYUZkFWbDFa4j4TPJnX6TvSadAvNj
         cKbhuohWqI0nyHpuEYCh6+39Xj5g77cUy2bTdIOYv59AMatDZYHSxjMo9ENnIDUPWVTC
         o9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770208911; x=1770813711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sipdmvJVf7asP1VhJpC4Xbp+ZBzA9tqFuT/7XUNiBl8=;
        b=oH2DDM02w8esb0Y9/lNjft5iSic3w7vYAMZazlZX34fi1EJJpEgBnumU02mBE3rY+Q
         PGnawQzgtEtxhu7f1+jbyF+5vCC01Z679pU85JKuDudikvhdEydHqviIlDeBNxfO3tAv
         NAGwk1gZFRxqqHl3NuCPTe+bL688whCWtERjPrlguMLJtQbtICFiWxfBtc5qSUbBkj32
         hUeBcsTBquAI8c9U2hBs/xcFD6r1V++l9OEHTKfhWYFsxHm8CXmIkfYDQLLWZtl/igfG
         2XMWdirDjzpQb8AW9fIh9lOgvW3HqrBIKGuwcL8ouraCIj/ClnXOqJwAIGG/1scuQuit
         LRow==
X-Forwarded-Encrypted: i=1; AJvYcCU6MeMA72BMPvglum5AtWLEGZy/Jbd5pjEUdO6nrg1MY5RZjZ/YBI02aMYuas5MK9ib1A5crIo7P1x6QOPh1XbkiJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs2Wrsows2bZ3pfKGDqhKZuoW+Gfp4RUBVvGyztgiNZWuzkOCg
	9sDpAei7jNZSJ6/QlqbMQHYpR3cWox5cSzn+485yuKB154e8uHXtP9VM
X-Gm-Gg: AZuq6aIuvoyjKHB7ZkI4EM1j4g44p0ozI6YQ+WZZjn3mR6951UeB26mEm0oLKow1wbj
	bm5x1VaIxy+rRODMUNBDxzMeWYmxYdPYW3f85Wo36c9gu1jzPMlX5q1SYuwfa8n/3tR25wZrTKx
	8lcxXP2X+3GhfsCx03sgSFZvnCgTOpC8v64D0rwfrTbqGl504QFxitsd0YLGqHZJ4qjF+ohw7UX
	DyZqSHsPrFGmeoE4QcZ0QycsZYm1S2okx1nh23erAB6uZ4U4sRIVEmShhVrZjzMNhXMwcQGNzI6
	c8i7QnNv0uGZPbGU7ylY+Ff1C9zI+YDglWZJvc0e5C/oytBpCHkPCLQpRw3njbZG1NIqyTyN9jv
	1uTiqkvJ215XOnYfBAELKgW92NrqQ6AqBdK0xWOtaK9NqScyaCkmlJP7YaLnd
X-Received: by 2002:a05:600c:4513:b0:480:699c:abe9 with SMTP id 5b1f17b1804b1-4830e97d784mr37940915e9.37.1770208910979;
        Wed, 04 Feb 2026 04:41:50 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830ec18706sm34237675e9.0.2026.02.04.04.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 04:41:50 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 4 Feb 2026 13:41:49 +0100
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [RFC bpf-next 05/12] bpf: Add multi tracing attach types
Message-ID: <aYM-jeV50WaVik1b@krava>
References: <20260203093819.2105105-1-jolsa@kernel.org>
 <20260203093819.2105105-6-jolsa@kernel.org>
 <3015991d-2e9b-4bf4-9c17-26e00b5d5926@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3015991d-2e9b-4bf4-9c17-26e00b5d5926@linux.dev>

On Wed, Feb 04, 2026 at 10:20:29AM +0800, Leon Hwang wrote:
> 
> 
> On 3/2/26 17:38, Jiri Olsa wrote:
> > Adding new attach type to identify multi tracing attachment:
> >   BPF_TRACE_FENTRY_MULTI
> >   BPF_TRACE_FEXIT_MULTI
> > 
> At this point, should we also introduce BPF_TRACE_FSESSION_MULTI
> alongside BPF_TRACE_FENTRY_MULTI and BPF_TRACE_FEXIT_MULTI?

good catch, will add it

thanks,
jirka
