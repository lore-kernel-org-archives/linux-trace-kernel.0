Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA50426F476
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Aug 2025 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754062509; cv=none; b=qpOEJ2Zjwx2ddZLTRUVyKaqkZX6gzVh2dxZauX1A/9T6swg3R28R7aJrRsq1jH3iDTQqojTlMZL9MoFQ19siK9rP0DKfUdmJSgMJpJxMoyjwY1mWGd422ov4EfEvBNegaKQyHkv8AFZ3aZXoCsHlAHQEQ3Jcz7y9T4VauP/5LW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754062509; c=relaxed/simple;
	bh=3t7pavYnxvZ2zr+sT6EoGPHPeQNdp+X8VdJPWKkQuPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HAys7DZAF1JnJIxpLDcXu4SOG1lrOmkXbxShR2pIzgCI/dVNE0DFzQFhUrEOJGfDokqmFBxt+b4RqUmYuewrSHQu+ITtmp/ub/JnTmW7hOUFWouNqmio0gfapxPYdZ3qw2dHXtz7LKUhvWUE9bDg872CnhZVpOtY0eXFBaoXXK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f8bSnrir; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8bSnrir"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754062507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3t7pavYnxvZ2zr+sT6EoGPHPeQNdp+X8VdJPWKkQuPc=;
	b=f8bSnriruQF7yJcXbeh7UVSwPISQbW0tcBN6h+TL6L0oUiagFBcI6GX5NG9jLzxQ+RS4FE
	HGwU3IxWgu24buuFjjC6eGKcmKC0MgwnfVOefgdRPZBgm7Dl9WmsddMsGt31dqrRRsiEi0
	rqSsatWeie54FX8lRK1qoF0/l5YXLXk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-SWDKx5DQMEyHOTz6KQXiVg-1; Fri, 01 Aug 2025 11:35:04 -0400
X-MC-Unique: SWDKx5DQMEyHOTz6KQXiVg-1
X-Mimecast-MFC-AGG-ID: SWDKx5DQMEyHOTz6KQXiVg_1754062503
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ae1c79fb8a9so172588266b.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 01 Aug 2025 08:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754062503; x=1754667303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3t7pavYnxvZ2zr+sT6EoGPHPeQNdp+X8VdJPWKkQuPc=;
        b=sPrLGM/fCRCtvN6dYZMasKfAVz8tPSO/fBGFW2rL2Za3sD4W7vzP1rladetCrLHB7q
         aQXnuPhrbHhsAvfa5UJYk9txxrPFdqOe/7vASfQ59PmRn9G2EI/QD+rf8DfJt/HGBRUJ
         Hp7mgiqXEL3tXKM7Y0DF4Fkd4hVMUL/2EFHRduDZbomZC2AadMCIVgnXVel3Snq3kCFQ
         LE+XNrFb6g7tkFQlCrBCsM9NWkkPCZC+pwGkhGQd3TtcDttRDhRNdcgDeIPCG5fcTFRa
         rGuC8Y03KH2Ua9qXWx9mtUVF2edith1PpSLXPfEYnbAo1cdA3scwUNJTLbdWwYGVISEt
         Y1qA==
X-Forwarded-Encrypted: i=1; AJvYcCVEkWQivzrS7TKxZtAsDy3ppu6ITFxqNYNddXS5085Opr7nnV2G3oBDTlMaCyG2XLsnoj2U5lvtlhjlOS4rT90bhKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRMvP775y6M36/MaT9NFoAg+SlU7X0M93h2B+cGLvqYFANJUg0
	hsIgiKDqmnipVWnpcFsr46wrr+BY9zgn5E7iLKHXJMY5Xqr+8+dbwSD/tzIIz0rq6ncfcRd3LI4
	1tIWuaXdg6kynbM5T5Zfu14zlbN5ceXAbfNULLXto2z6V9ewKujUeqepJamlbptx8Vs5S01nM6c
	gEwx8lq/vOp+yofhHNP7jJ2ktsVs4pjjt5/Djn+bj8II8bsS2N
X-Gm-Gg: ASbGncuvMhIqUOeeO4zcAG1L6pnqUAJJu4ZRhJb8JKsoH5CCf+baXMBh+uBLD/nz/bD
	jALFvpL+TThS7Q/MCcLBG3yXj3DvtZR1oPb/nSdcmeOBghgwMvJNnaZ51m51ZIyUnGK9w5ETRAM
	+IzYFfXcpjE/ls/lXaj8oUoFEXE94qdK49TWhrtzIxZ1l70nNr6K0=
X-Received: by 2002:a17:907:9455:b0:ae6:dd93:d7d1 with SMTP id a640c23a62f3a-af94022bd18mr24177866b.56.1754062502707;
        Fri, 01 Aug 2025 08:35:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEffcQ80umUTy89ebwr2s4PAM6/RBBB8AMdwFz4nIXXP4EkDzw5biAznHDWzpfhf0kLY0g1Q4rSu75I/gxLePE=
X-Received: by 2002:a17:907:9455:b0:ae6:dd93:d7d1 with SMTP id
 a640c23a62f3a-af94022bd18mr24173766b.56.1754062502265; Fri, 01 Aug 2025
 08:35:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801071622.63dc9b78@gandalf.local.home> <CAADnVQLky+R-tfkGaDo-R_-tJ8E3bmWz8Ug7etgTKsCpfXTSKw@mail.gmail.com>
 <20250801110705.373c69b4@gandalf.local.home> <CAADnVQLFLSwrnHKZUtUpwQ1tst71AfYCcbbtK2haxF=R9StpSw@mail.gmail.com>
 <20250801111919.13c0620e@gandalf.local.home> <CAADnVQJnTqXLNT9YWWkpLqjxw7MGMrq_CTT7Dhb__R0uO2-COA@mail.gmail.com>
In-Reply-To: <CAADnVQJnTqXLNT9YWWkpLqjxw7MGMrq_CTT7Dhb__R0uO2-COA@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 1 Aug 2025 17:34:51 +0200
X-Gm-Features: Ac12FXxzpQTuJoSDpFwJ5S798l7k_pWSubckc5Xl8rkjsWL2kupB9MLIkTqSUgE
Message-ID: <CAP4=nvSNeviiHg89L3dB9pGzi4Obf_s=bWJ8v89Q-fsJbuqymQ@mail.gmail.com>
Subject: Re: [PATCH] btf: Simplify BTF logic with use of __free(btf_put)
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H2gRAkrwIL3eYyFQRomT-4thtn7baMQIRaE3paC6fyg_1754062503
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 1. 8. 2025 v 17:29 odes=C3=ADlatel Alexei Starovoitov
<alexei.starovoitov@gmail.com> napsal:
>
> but __free() is imo garbage. It's essence of what's wrong with C++
>

Here, you at least can read the beginning of the function though, and
see that a free will be done at the end, like Go's defer, right?

