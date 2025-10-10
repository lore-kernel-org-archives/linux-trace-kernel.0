Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02621301031
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760122530; cv=none; b=eR0naG5v8ydl+dnBB+4i9JZc3smwwxkfoB1MQaXzUmAVox63/6XNPs4Q9A5C/9YzfET4IfRXxo+8MDlGJV9SvO3153soZ2w82/TpeO/vCqnv3+Tb+Fl+fowdncS2ll7uTFRZ4V4l2zQmvYplzESgemDzX44fRVTZno4tJNL7x5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760122530; c=relaxed/simple;
	bh=npVbrD9jcPN3MO54+Q2/A4DReVoNnNeo91JkHkudlto=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hge/zjemtL7W3aPJDm6JEjPl41MmeCXHbcuSpq7BtdkDMU9eG+CCS2kFxDeNrmMUUXQd1elvp8K2cB+tcWlAV0Yzs1ufUg6KmwlgeG3bGJaQkrsXOmu5R0uuqYsRbTZ+GrfILN74J3azzxu354lG/owCKWlLeZj35hG6LwAh7MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKDoPdTN; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKDoPdTN"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b5f2c1a7e48so1606218a12.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Oct 2025 11:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760122528; x=1760727328; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DlaJ/6AvVXUkXGRj+5X+fFEMgNImOtajCd+PpnPQ/h8=;
        b=OKDoPdTNBG70+u9wQrtEec9kevxOTxbTsd2yNTJfNp19hoZNmVi/RousvW5250ANgL
         TK0Tv+D3h+CWG85nHYS+qUX5zb29+aNdYgit5gnWTZVDMxpo5aZfynVIm2sOhNi8/Rhg
         nMyzL12smtwu21gL2nqPM7SbKuL3zcCBMlsOCA4Q/37VuhYA+/iidjRpEMFi/PY9s/Eh
         B8Iq7brsdhNOVIBCHZB3+bPKXiqEmU1QowJM2aqmPzou38OYlTkXDgZ7347RVLbPIZf6
         2MQhV5J4hpcyq3t9Ne9jJAEllCwHMOBwwu15lXYtRm8m0RxKd6x9QE/yBYCKFqc14uXT
         4xoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760122528; x=1760727328;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DlaJ/6AvVXUkXGRj+5X+fFEMgNImOtajCd+PpnPQ/h8=;
        b=HDUAHuRZmjCPcdPk/bDs738FR2IfZKPmmON1YCgZXls4W+Mvw4sK3z/QoyVmNBAVm3
         uQsmmeSie5oHipdIc/3W2BWYK7bVlQxDd5yYU4KPNhWnRAGOJIBjvdH0SKUf1Ls8fNh9
         N6SxRVPLlrv0zUlzfIQWgUWVfXrg4RxljAbz7asPElyOaZBAB3F5fyBDAGKhpJ7jyEQl
         yBi4BllOXNaNXgNF8mwGIK8IMxz+gfmvnUULGfQa1IYadYIjH4ha2wa9Gn6yXyfR1mi/
         J5DjLZa7SBAgGIJ13NKlEKj6m+8EiIdkHuGiYiHUTSjEIIV+53+r2MJVyqxptWnHuNz5
         +a9w==
X-Forwarded-Encrypted: i=1; AJvYcCWeXgeAkSWPnmf7Cj2e/en8Zz+kR5Kz6EYZMJ3yFHDEjJRV8ARVMCCg5skMwR+OEgXGcXey2pP/WAfofbdwrEbR+Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFj4d9pxDUztzWBphNLIo5wSdFZ52nvkkJuNf0ClRJH6KlGnat
	7HipaIMbAKva42oFxOfE7+2JOUH+XDROHfuJDpjxxiXc3ZMIpaJutmbK
X-Gm-Gg: ASbGnctvR6rhq496th9TFbH3cJ3IzXQq4l9K0g/UDY9csoVqO4YlZbpKABYi5YefEzl
	e7+nQaAShj4pIktfkHFgwP+haj5JWm0sU//H9IZQxVM2K2jpIQCVI6z9kGEs/XhEjyOR4Ys068a
	fXs6rajyatdgL0lGG3Jk5exK8AF2Yrdj/d79PInADB1fmmqOF2+tmx6fAdhGjG6Dj7pvi/CTVTj
	cDCUib+UbxSLmUJWO922T4saf3LpcsSm2TjovFSvHNFecHXj37QtdS9oQnCHpUaeGeIzKqH/8U0
	Jh2pPwcdDiKlbGgqG2ioSQ4nfNWA4N8aW91iQP71cMm5bmSit+R4RxVRT5BEWjwWCGDM5EWmtJ+
	rr6gDL0AlOQP7PxNcGSvVej0DVpZM98mP0pE6p73hC+HjmW+ZemT3qf7uQGi+w/sWKA==
X-Google-Smtp-Source: AGHT+IHeWKPLJf1YnZgJ8mQxBiUkHyLKgv/P+D1FaJ/vyeBufx1XcfVPQPq0hF9mfyos8PqBo/MJBw==
X-Received: by 2002:a17:903:1aa3:b0:269:9adf:839 with SMTP id d9443c01a7336-290272b3357mr162724315ad.19.1760122528050;
        Fri, 10 Oct 2025 11:55:28 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:ddee:16b9:c5d2:a3a9? ([2620:10d:c090:500::7:25f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034dea083sm64462435ad.24.2025.10.10.11.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 11:55:27 -0700 (PDT)
Message-ID: <f9be7eda8fb72ad6a7a730023244409ee065ea60.camel@gmail.com>
Subject: Re: bpf_errno. Was: [PATCH RFC bpf-next 1/3] bpf: report probe
 fault to BPF stderr
From: Eduard Zingerman <eddyz87@gmail.com>
To: Menglong Dong <menglong.dong@linux.dev>, Kumar Kartikeya Dwivedi	
 <memxor@gmail.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, Leon
 Hwang <hffilwlqm@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Menglong Dong	
 <menglong8.dong@gmail.com>, Alexei Starovoitov <ast@kernel.org>, bpf	
 <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel	 <linux-trace-kernel@vger.kernel.org>,
 jiang.biao@linux.dev
Date: Fri, 10 Oct 2025 11:55:25 -0700
In-Reply-To: <3349652.5fSG56mABF@7950hx>
References: <20250927061210.194502-1-menglong.dong@linux.dev>
	 <0adc5d8a299483004f4796a418420fe1c69f24bc.camel@gmail.com>
	 <CAP01T77agpqQWY7zaPt9kb6+EmbUucGkgJ_wEwkPFpFNfxweBg@mail.gmail.com>
	 <3349652.5fSG56mABF@7950hx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-10 at 20:05 +0800, Menglong Dong wrote:

[...]

> save errno to r0(Eduard)
> -----------------------------------
> Save the errno to r0 in the exception handler of BPF_PROBE_MEM,
> and read r0 with a __kfun in BPF program. (Not sure if I understand
> it correctly).
>=20
> This sounds effective, but won't this break the usage of r0? I mean,
> the r0 can be used by the BPF program somewhere.

What I meant is that for cases when someone wants to check for memory
access error, there is already bpf_probe_read_kernel(). It's return
value in r0 and is defined for both success and failure cases.

The problem with it, is that it has a function call overhead.
But we can workaround that for 1,2,4,8 byte accesses, by replacing
helper call by some `BPF_LDX | BPF_PROBE_MEM1 | <size>`,
where BPF_PROBE_MEM1 is different from BPF_PROBE_MEM and tells
jit that exception handler for this memory access needs to set
r0 to -EFAULT if it is executed.

The inconvenient part here is that one can't do chaining,
like a->b->c, using bpf_probe_read_kernel().
One needs to insert bpf_probe_read_kernel() call at each step of a
chain, which is a bit of a pain.  Maybe it can be alleviated using
some vararg macro.

[...]
