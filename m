Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795615967;
	b=GpddKh2ixab+LyNhKM2vWBY7fzG7CjiRisVGJGY5mlpO7ONCeXhPo30tEtnJ7mpFKNhD
	 8fUSAUA05gvsf3YCAvx+B9FMM1OQI+S+MzDVwtqtqXajgWZto7M2htEcvnFNLpZtCFV3u
	 CMsNz2/RTdGxOsOOu+uAoFpIauiAmbNCaQVRQA1VUY58cjoAdvzwZ3Lssxwwr3uUu4Ggn
	 AQww25oK4lBUuiXTDZcuq3o4hX+iCq47uqWEAOmxYvpSYiR0g3OclrScgxen+S4Wa08Ii
	 4yxHAyoSXVrScISP5Xu7HaVJkrP1YwmhMlSy/lu9s482SsFQ6eXzvV2LzJIHFhCam4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615967;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=+j5ASClty8/ZKXrnqcuhSTiI2lW3GfIrSFmOpzRXZaU=;
	b=sbsdkOyA9OglQDY8DG1ah9gzhlS5EgobeCywjVjqp9CWSOEmiM61WOW8OGsH8iiUOxKt
	 Oy8MxwPZUI8VRlZ4uczwg3hNtcLKYw7gNOPsxLf9hogluhNZbY3iZLMja9nPSRTgWEeG2
	 yglVShHsFQCYXQR6o48Z0moHLMrWxZhuJQAp+Hxrrdie57g38v1P7qXn9pEBqCsyV8ubr
	 2TlS1CgXCfG+tTx6h6gX171QbaWNAkRrnrrJi8w+96OYY5EuAbvLBK1DQ3cKurqzWoJdD
	 d7OiM5rDL12gkv0YPfUP6iMyNBWqwcm1ADtttMoJhTfbhB7pyOfe8YhNK80hPNbLmGg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sentinelone.com;
	spf=pass smtp.mailfrom=sentinelone.com;
	dkim=pass header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=dDeTy2Rr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD84D606A31E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 14:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD84D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=dDeTy2Rr
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2eb33b5c067so4799505ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 06:12:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795615966; cv=none;
        d=google.com; s=arc-20260327;
        b=ouj/7LbPo5A0sR2wa2iDZvowfEMw7EzZZHsEl9CsdhmeJmIt/lu30ByUP8fAs/gJ7w
         eKxfrx1pzSGrPJQKSr1AZ1AH+6EICNKd9N2RBmHjD4qUghT9s2eE3Em22StbZpHraL/h
         em+WLFL2nR8s+LRJIUxASK2EeOyVtJvB8OAsI9kVkNAPpxxzhNctsRquuQ03/+RgUCl0
         OxhwT4Ck08ejpdr6TIRr8OMq3ic47lGGcAIgPa4NzTnCcZNR+uwqaI5a+3SiyFQNj51C
         5+uXJb7ilrMbTyNnhkHzQfwH27RQriv779ojZpV8BAhdUF/fhQ7Rcuz6H5NnS5We391M
         EP2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+j5ASClty8/ZKXrnqcuhSTiI2lW3GfIrSFmOpzRXZaU=;
        fh=Gygs/2dWGL6exGZuRdNJFked+jWi8Rdt/g4RHWnlsGQ=;
        b=K71YEt9lGaDgZMqOqEmJgXXQGxbNl3iYaKlKTLi+upDcI6bE/TZpeudH2jpHmll7IH
         UNcNvio2S46bionEL8M/Hn71fewp4MnLNoXjZDmNXLnZzF0EKzudl6NGT/BvI6oy2tva
         a84wmgofHClFB79lQossCUaLFIFoDu+pyPKn48nkoLkRfgECyca5rNAY2crOPwNVSnMP
         RXohjZ7GjYlTGH62wr2YgehWVbmm77fkFccyyu64hJfYcWXvzrA+xfvwZnkz7it6edrC
         +P6+37dHkvZiJs4ky6wOAEsRUPVI9U3Ds09eqDtcAAsos9MZIIZFJNNAesl59ieqnKsw
         9J3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sentinelone.com; s=google; t=1795615966; x=1796220766; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+j5ASClty8/ZKXrnqcuhSTiI2lW3GfIrSFmOpzRXZaU=;
        b=dDeTy2Rr9s2Rac8C7vb4lUCuu1aLkI265b3Dd6A3RHP0Tda/gW+a3I9JA8QPYMpG7o
         sp3bIVjAmhy+7kK0EYbeim0rN1VCdPk3bMeYF+aTTOUtGaixEYoQis2fVYc4opjYRUJt
         uggEBl8SlXCoz0e3l4qpT3CjggmqpDyNGaED7GbXsei9uRIUYhz5y/E35WAuW3vgUCZ/
         hTclPzUDxe4/lxgWWAyMgVzpg+JJgyfWe0ZqC6qbA8RzckHLq7tGzofGnyNaXfCF2Aqw
         i7k8MtKe9uII98rn8cLoWJdhV40HZLyxMegmuojtqRnwGeEXBxuN2I4D91JhyxjU0hlg
         2v0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795615966; x=1796220766;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+j5ASClty8/ZKXrnqcuhSTiI2lW3GfIrSFmOpzRXZaU=;
        b=DEkukwp31oXPyMtyNVCU6ItsVOHJXLZzi/OXajyTaxkOqki6EugS19QlKFrRkbj8Gf
         G+fLcRvypqUgE/ZaJv2KC1AIyO1z+Xky1t7Iut66F73VwL0ypOMO3pqMqzv9YdqBEp1A
         5oKgbOiTySiJJLQNnB9zybRepMxa3aFNcagZp18/HjJiviQg4owLvfjK6oKx8CSN0pcx
         2khobYiIxQSend7uDccMA6hDZDUzM2EVjDks7JA56ZALbmnt8/S7fFHUken9uqRhMkyD
         V5rkBp88KLesqiXzB6cETg752WQ0FhIUKw4dWiLSgCXrv4oNkVxodpP83n2fyAclQTMv
         BQCA==
X-Forwarded-Encrypted: i=1; AL+hErE37LJR2bqNFJM8vnTe0PQ8LcV1sIh4daFp3UwLSHdvQWDcFSXOuJWB83LEqzEj/Y50apPCF+slttM2T4D2GF0tElc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8VO+0L9Nocl9n/IQDu+q/qhYWOqm9HkZk/i8xMTgTD2WejSixt
	FetQijYZEXDi7Z5/t+ble5zLRpX4rgfr2xEGnxt6u0ojv68cV4Jm1XPGluQGegjj7gOus//l9Ku
	6K4odbNquLayCkYdzvT0MADG4qHIMJPZPfNkMsO/JhQ==
X-Gm-Gg: AZFdTZd7pTm5ws51i35TTLPvhw/rmegrqrp5DU0rW/s/a+/itydzX+FE44GGMrFJOYV
	N58vYEKSINR4YCtF8KoeE7UwQCvjXI/Ke7Wz7wfX2BFLE6djSEw8MIC/bCNoE/0QdAbXnkQeUgf
	VPpodVvL6tCq8GLoDiRdhoyg6AFtrPZG8Z4tZCOBAST8NZoXJalbo21HvuuvtuWFJv5yGx2ykEq
	Yz575SfS2fT3cw/JryjQ6HnCD/IQmgn3Es7zorwW1fDtlfEvfysuvCGT4ETYYxuIXfBkcdQA0Xs
	H/YFHgfJXkwaMKQ1ssjFO3g1hLNl2aYjfkDdHSLSyghyTY48+29NJ2D0VeKHdugAphTD6B9AfwI
	Uvb7+9dUBGGHFqxvXXl3KoQ5kTA4tKorlEUg=
X-Received: by 2002:a17:90b:498c:b0:3ac:73c7:9c07 with SMTP id
 98e67ed59e1d1-3b41c55b914mr25284757a91.0.1795615966034; Wed, 25 Nov 2026
 06:12:46 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com>
 <20261117-bpf-preempt-v2-r2-v3-3-586376ec3672@sentinelone.com> <CAEf4Bzb6sq6g7jq715fqAAaL=PNSvuVWn6u3o+76w52gsT+bJQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzb6sq6g7jq715fqAAaL=PNSvuVWn6u3o+76w52gsT+bJQ@mail.gmail.com>
From: Mike Bazov <mikeba@sentinelone.com>
Date: Wed, 25 Nov 2026 16:12:50 +0200
X-Gm-Features: Aa3M54qvrNfH9VUBkNsCxXuuT_4IkvvxlNYuj2vYVSaYeAaT17sYXXVQTIxMML8
Message-ID: <CAPnbwjrkkX63T6UCdtsE0yTV0C81DFp51ONXvNOFaB8zOdmZ3g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/4] bpf: Check program recursion per task via bpf_ctx
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	JP Kobryn <jp.kobryn@linux.dev>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 24, 2026 at 2:04 PM Andrii Nakryiko wrote:
> Am I missing some complications that would prevent that separation of concerns?

Not really. I can do that in v4, it simplifies things.

Thanks,
Mike
