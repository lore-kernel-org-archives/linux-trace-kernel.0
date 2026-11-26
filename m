Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795661305;
	b=oSPn/qDCBsrOcWSMaHLj6wcdx0gNQgj2SjyEE5QykpqYUKcW8T+wnx/L5js2b+RK1iQq
	 VxkwvCEq9OYLmyQAIJwD6OK0G64MRNvlZx5JbcUvpIx7QI/qLSdfPfYUvyq3hKKT1Qlhf
	 g59bQhGORAc6G4mNZ8AQku7SXI41bWq7nroNVSwtpMnQNY7PBEOxrr0G1BQ7wi+1b9e9u
	 n32d/INb3HBKNQZ+Go7alTo4QpvAh4K6NjJruaISsqYn3MbSzUWi/kqTKwv3jVQnllB+F
	 fYgCNFQWKh/Oj2bZ2oxKrYY4YuXEl4NYGcY+2NF6XYY8cwfb2p7kz7xXK92Cfaw87JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661305;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=uXsG/J8SjUA+u6xV5gQi3ekCpADG/Nmz2q3u5DO1GSw=;
	b=QSe1k8nH+I8kaJD4Y6yQrfAJh9lKaMDMVDjdTVvWVMfvZifqsYzvRffM1pkwIrkVgbIv
	 zXUU+az6hHFKecN1JLmdrCqa8Tmt8loMBWf0SWNmjw4MqMAl7JgIf6IdLBtuHivNqPd9J
	 aIP9OuW+K0ThctbRJ3BC9RPZSF11DS+fASwGY22rmOeyEOdfuj8wwvRRGQ1fytolM17HU
	 m2TeEaxqK1OZ9w908XhG80G9FGr6Y9Qmi1sP2Oay6tr2AT+K7U+G046LeLzOQAU8qg57a
	 YNqjldJ4qmwtxAxw0YZ+aF1p2ZOIk+O8ShXc4+sqRvEmR+JjL1V/nGafxD/ZBtP3T3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hWIL7Kkf;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E00C606A321
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 02:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E00C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hWIL7Kkf
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cde827b7b95so2017661a12.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 18:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795661305; x=1796266105; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uXsG/J8SjUA+u6xV5gQi3ekCpADG/Nmz2q3u5DO1GSw=;
        b=hWIL7KkfCL3yaQsFQRKV2YraC7VVF3oAMqKIMdyD7qlk22rGclRIkoua5vlMpTMBr5
         rxPT1fKoNqe54FlsoE7dBShxb0WCzgSMpiLoPk2N93Dc0zNZHGX9eD6E1Lex6wcECS0M
         A+RRExWB5fzKTz1t8NJ4ieU3InEGHWU3TBv8jgNNXp/FGXAiOx0TZa2hoDqb6Pp9+lwI
         gWFOiqYZURGXSvKxHqj2oDh1MmESQqc97X8TuspANrgz+xqlEgKbl2F1HN1RKUVSRIUv
         2FuaOyz9D3e++Xel+ceknSPbtOhxPE5eaIFWuFUEiv80ZwxkNWwaKaEpJ4v5NJ3yN6rr
         3Lzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661305; x=1796266105;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uXsG/J8SjUA+u6xV5gQi3ekCpADG/Nmz2q3u5DO1GSw=;
        b=A7pQtS1KMjdosGM6TV2BLh8Rr3MbyzOk4ekxDe7ss6Bqgs2PDjB5pmoyfUeiaEniHB
         Sxr/G2DnmL89GpSflYiGhNdJGbigwpj90enMVmrWyK/kA/xkiy8lOh9jfiXx5+riEpsV
         VE8ilPIFEfcvlpo6hrgKqMgvcCY5Q9QfLT6EPif/oGFxn1Tp4bj3zLOpTE2CceQrfA0v
         stWVhjl9WkC2lx815ovowpH9Lx0U9R6olyH4J2WO9v3aOhDcNAcCslcNqDjD1RMUuwc6
         9tNSlbjeF3mjAs6Ik/m2E0Ea1j+lHKobhBx0dAxqCkYmhrJP9X9LemG1cw/jepEzyt9r
         I0OA==
X-Forwarded-Encrypted: i=1; AL+hErEiaj/zWS0ZtPJfNdwCz1J2Otk3RIeHqjv2cx1lDbzKdQ26JVvVFtNi5Lh7FKYvxruhR4yRnOdjoTY+r1MTt8oiRnc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/RZmiHoMF/TSIpCV/PwKQQfdzPuTxWFbbEQO0QV0sBMOUkEga4
	W5/nqaistlGH8K9UUhQXuuY7Ngk/4tut/00KE6RRef9XGDG8byRWJv7X
X-Gm-Gg: AZFdTZfXpLJRVMuo1OCxP+fq5Fk1i8YYlvBb1wwaxK4N6u6ZVhZlLa4A5ZTQJJ7WHP7
	tB/8L03ILiY36f0EbnfrgnOnANAzIcuIXyX33yyPwvFrZarRHtEgQX+fw8L90ij17vTMMOtzGOG
	W2x2S4/f3LKV3TSNRF2ZtacWbLASw1+Qr9JdbYFXXZNVK6puBIKpwpdj4XcIJKk2cYrWXAMSgiU
	CWHFiESnxXhjZ340Nf/06qA7OyPHgb7ojZxrwLQDseplv1haDD0dQuKDqB7kbzNxWLH0W8cQDwI
	5q1fABgt6SPUZd+wuW4fY5bqy6r2pVSs0FTX3tGXbA+QSIdsH1u1plbIIL36JSHqDvcgxe7UawD
	RJ18HqqQbYDEhEQOuSmsONldzkOFyp5lvGNgFDRzgx4Rgc0uJ9opz1NlT1qSwrw5aSQapi6h7MG
	Evk/mPYCDRc/BTcqPq6h8xlbTecVqUyDEMXzBV4AZ6BLtjGoryA/I4Yh0Y16NbwKsI7sVA7Bmtw
	PGocRQfmL2SVwCHZ5+d96YzP72dn8OPMdcRQeS3LtT4pOR1h1y+ID7Cr/tnywTrV/WZ/rxT9xyf
	euGB/ZfR9Ax3s+Vb5ve1sxIquHZgvqkiom8Q9YbSMP0y3im7ogWF2szPuHRwKuixsEMDW3wmUXS
	49Wu9WT/cLRj9r6KFY/wfiCHlNd1UIugcCg==
X-Received: by 2002:a17:90b:4d86:b0:3ad:4a8b:c6fd with SMTP id 98e67ed59e1d1-3b41c93b159mr16040203a91.28.1795661304665;
        Wed, 25 Nov 2026 18:48:24 -0800 (PST)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b420e1307csm29193554a91.7.2026.11.25.18.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 18:48:24 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 02:48:23 +0000
Message-Id: <DN4ST2VP3GVF.GGKMH8CNILM2@gmail.com>
Cc: <bpf@vger.kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, "JP Kobryn"
 <jp.kobryn@linux.dev>, <linux-trace-kernel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 0/4] bpf: Check recursion per task for
 preemptible programs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Mike Bazov" <mikeba@sentinelone.com>
In-Reply-To: <CAPnbwjpLcyJF70D5j-q23L3TQSFXebB_RndQRmDe+_5h02YazA@mail.gmail.com>
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com> <DN38312WXPDJ.2KLUTCWSDFL3P@gmail.com> <CAPnbwjpP9Fin=CyD0WiA2c4sxqbfyK7AziE64PCX4w9kbz55Kw@mail.gmail.com> <DN3Q2CZJSC2C.IM2EYLF1NR9X@gmail.com> <CAPnbwjpLcyJF70D5j-q23L3TQSFXebB_RndQRmDe+_5h02YazA@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Nov 25, 2026 at 04:03 AM Mike Bazov <mikeba@sentinelone.com> wrote:
> i tried it, it works when the run that preempts finishes first, as
> with bpf_timer_cb(). With preemption it can be preempted too, and the
> preempted run can go on before it ends:

ohh right. save/restore works only when the runs nest.

> A fix for all of them has to change how may_goto keeps its budget:
> lsm, cgroup and sk_msg progs never go through bpf_prog_enter_run_ctx().
> I'd rather split it out of this series: v4 takes may_goto out of the
> mark, so tracing progs behave like lsm ones today, and a separate
> series fixes the budget for all prog types. Does that work for you?

Makes sense. Let's split.

