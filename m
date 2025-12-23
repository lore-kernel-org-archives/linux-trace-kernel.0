Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5132D3A69
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Dec 2025 03:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766460168; cv=none; b=CONijIVYZg8qvKX+opNV0p2mdm08fmH4FPFgKLcwKoQfC6rkryOCOeeGULodMX7t74yIJiifNhUB2nC4ZuUhIyI4tPJ5QWo6pLhjny5a1S9PI4jkWk8jPEWUH/V+EAQNpwrxcaBIKGeN7+L6+gUAWa9qu4prjZ92OBMmWeLrOIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766460168; c=relaxed/simple;
	bh=nXx4iU/G89xerhbNe+u8rqRV/ooGUpUr+zBdOwqNUIk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GUXrqkzInziLha0K6yvZJ1MCTbzkk91Kax2mNGjWbPMnJZy88nn04/jJAFPRW415TLmTjpCZ2b+B3ntcMzGLCe0lspAgjvzNFQSyNvernwAp+VsGRPvwD9IsEzdAlNCI06QiIMur5yiaiQFd6iFk2z1fYeE4WbCobJnCol4Hhhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOJs8TTA; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOJs8TTA"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso3744580b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Dec 2025 19:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766460166; x=1767064966; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIaw2BBgy4X6/8TUgYX4ddYdgedGRr8vnnHyY6AzWWg=;
        b=OOJs8TTA9zmASvFlalfZRRHcw7yjthb+sktasAWSRJyLbmTTDv1yaZ7LIbgFhJYnZT
         nfUzuSnWLKv2q1ygvKeNTVKLf2wR5OBafiWucKTrG2UYbw8+y0peq9wZxuPrhDKLvptO
         gnnmC/8tur1l8TywRFHit5z2BnmOEzuCgYE8TtrdChDS9mqecZrUwIdOxWT1U5vyKSMW
         kTResLiGzZJtxMkhmWAILe55gGIXsVFEvuiBNWDV00YqEnySMmjDxKIFhcCPF6IBJXqb
         /0cDYRXtyIIq5GKcd4JK9xw7mCGR/WvmKV0LRzKwaGQ6xZ8IOUYVhuxEAIMj8Yk4mIIp
         8/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766460166; x=1767064966;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BIaw2BBgy4X6/8TUgYX4ddYdgedGRr8vnnHyY6AzWWg=;
        b=n9b1wQGeVibyxhuomjPRFLjXjIvU0X2s2H0+xvDiE789do27LMdAyK9XZVznKixh1Z
         TMDGS4vDIWYpvuve0SXbccNkZhfU0BUSOFBmgj0KSP38NpYQSJyfofUUfxQVdwMMeh+V
         JQ//6G6eTvG7u/okFzxGg5hI8v88bfunQTuFvTRMeu79Ghid55EdtSA9mp4+s6tFX5JJ
         lndKQTm0xote0o6MxUNkC1/012D7YR9B+rBoBdpxXrAG8p3QZ/c2Y1MWLFoOqhC4trNa
         fxrQPTJwu0IppPP1cqgQEMwBBfVU9EAGahq1V8URvqAOjn5h7ju76HYiVY9D6g+32Mkg
         zzbA==
X-Forwarded-Encrypted: i=1; AJvYcCV05y2WWd0tjODtNUjElg/hxwhauZNzuUZIoOs7SHiBMHE5eJM4Xf0+RVQPjJmzu6pb3gAYHPJARMLc0IEyXKgQBnE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2LF8S1vipm4t7kh9rJWzOfpYsyADcbiXaN8RyBqv78P9YBz5g
	YQbsSRAdsYDqcmP2xF8qUHZKA0NfoFYkQfkn7U/bKNSNI3ZBOqOmM422
X-Gm-Gg: AY/fxX7Qw4OnCBtiXK4Ze+q+sr11gZtS1CFQgpl5wHtN/aoGWJ44ycsCTAedQpmujdZ
	KA/zF3HLpVhyemSrwv2Z6sv9JtFEJe0u2U49UNnu+6L1Mztf5PH1Uta4aLwNodk4xp1rXd1EZpz
	FbnGIb8mjTb8KAOxyrync+IcA1bGOCwbH3IoznpBZkaUaxYKhpmxivJq0s7iPgX7B7sZ3PTEPYU
	M1Dc6AI8p7DT55SenaTmhHGujNyrl21ft/X+AVyybIdJPpjMe5e4nDsZdX6IFLvvYb+kaY+/G6s
	/VkHE6TaYpAOqdudQiqXdWU9XtSb2tUZB+QsEQe/ZMLDKN5kXK7KOdSX/OEge3gj1OqIXsp9wFn
	9Ul2U4FsVlYgvm82BAe2+CSltszdObAdkA9C2nk5pfDWKkE/lkAWZfjgT91zM1hJCA0ZiQYOsDA
	POrCovU4Bmv5q2t2dN9g==
X-Google-Smtp-Source: AGHT+IGyFG9HgVkid7kCIt03WV3OP+yzvzYv8vgTEUV5lnnwd8VTxqHvW5riW9AUU8KdGUm/0KVsJA==
X-Received: by 2002:a05:6a20:7291:b0:35d:d477:a7ea with SMTP id adf61e73a8af0-376a7af69f6mr12887207637.19.1766460166103;
        Mon, 22 Dec 2025 19:22:46 -0800 (PST)
Received: from smtpclient.apple ([188.253.121.152])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e79a13f95sm10355774a12.9.2025.12.22.19.22.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Dec 2025 19:22:45 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [RFC PATCH bpf 1/2] bpf: Fix memory access tags in helper
 prototypes
From: Zesen Liu <ftyghome@gmail.com>
In-Reply-To: <CAMB2axPcJ=U69xyyyY_7og8OALRCbOgeppQv416k9yvMiD9CvQ@mail.gmail.com>
Date: Tue, 23 Dec 2025 11:22:26 +0800
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Daniel Xu <dxu@dxuuu.xyz>,
 Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 Shuran Liu <electronlsr@gmail.com>,
 Peili Gao <gplhust955@gmail.com>,
 Haoran Ni <haoran.ni.cs@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <0C2A0E4A-F35B-4247-B0C4-42C52C6786B7@gmail.com>
References: <20251220-helper_proto-v1-0-2206e0d9422d@gmail.com>
 <20251220-helper_proto-v1-1-2206e0d9422d@gmail.com>
 <CAMB2axPcJ=U69xyyyY_7og8OALRCbOgeppQv416k9yvMiD9CvQ@mail.gmail.com>
To: Amery Hung <ameryhung@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)


> On Dec 23, 2025, at 03:29, Amery Hung <ameryhung@gmail.com> wrote:
> 
> I did a quick search and there is one helper slipping. We should also
> annotate arg1_type of bpf_kallsyms_lookup_name with MEM_RDONLY.


Good catch, thanks! I will address this once we reach a conclusion
on the ARG_PTR_TO_MEM semantics.

Thanks,
Zesen Liu
