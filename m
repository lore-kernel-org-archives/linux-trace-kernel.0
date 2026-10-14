Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C057C496D34
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792014259; cv=none; b=ALQtAi7gMxMsV3F2fmnWvGipohkC4G0WgMCh1l9Ea8YjHu3LPjMCvjEHxu+9V9lhtESx/Zxc/RH35OkuKq11b/GlqqLwjiJkFhqQHBrVRRu2EuydxHordWhr5xv0NdmjF+x3HrWU/gk8Um0hVRQgO12yYYGRS/Sh6BXLEcYnnZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792014259; c=relaxed/simple;
	bh=ZlsnNdUfOVho9jmT6Hnl5zvOQLLi6uv8gJyum34DEYE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtAih9CWEBHFNQWdxeuslImssO5xR2S4dkUoLpg/2iwcdxVBAFOie6ozoLkJAz2jYU1z58XgdZDzis5iZEgEUbErbA2FQSCrdM5NiYpdJUSDWw0e/KuPv+Ckw+CcIAXEY+XRQuLIeZr5cBa+rC1Hv7yZ+HDq+ez4F0yVmuDmuhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rCs/NXI8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCs/NXI8"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4956869750eso31345985e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 14:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792014256; x=1792619056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cff983+JIMMydZYhp9A54f/c6x1XpQzAnWFKZyZ7iSQ=;
        b=rCs/NXI8euK/ZK7HX1EnkZvgdG9BVnllooU4kf3BE/44kmSh7X9dP7mH0+hJuaH/3X
         SHHP6fXkK62Ro3qBm/p0OdhOm06qxaGj1MFgHrm6bP+BKRvcAioDWI2u0KsnGkFGVMei
         lTcFILxkLxLxkvnKwyjPTV5/TgRbDhhMgVU5dOaEP3J32gdVDZ2jf4QAMWXsdkq4AcsW
         w7wR7DQovTlvLKaw/xsWiaSJUdPsIzalOMnJQHZ6ul8rGevMgKGjTQ6mUdG5fc1w6Tcx
         8W8nWg/2eQpgS6vbh4hApd44mpP1yfw+m+Fa1j7sDsUj+qudZe19B/pf76R1dgMiovB8
         2u7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792014256; x=1792619056;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cff983+JIMMydZYhp9A54f/c6x1XpQzAnWFKZyZ7iSQ=;
        b=bRDcnxyZp6fEM8rbkCQXzKM+W83dnjBVAbO2T7cV6L3ZuqijpCjN4V092W3vewCFSo
         oH6tZnZ4iTduP/mkWTV1ZXawtXihaMKaBV8aAuxrKstWgoMta4ppmM0VOTq+FKyDwWE8
         ZNprZQpItErmkpuSjk85krn2E3gkZZDDVXSn7t8GYjvSh/ZYRb+5eqqC3qOSLm9CO1Ug
         33GDTG9GZwycBXN9DQrrLjfsQHAqQjq26BZ0/8cp1WCX2fBjqfaRvlMDq0yDjjJAk7+V
         ElrsDDg5CBIiB4Sg8dRRIexUNpxVJTgDyH3wjbPH9ZaEYM5B/vwYZvCGF3Ot+natcgaq
         9xUw==
X-Forwarded-Encrypted: i=1; AKwUvByV9wxHD6bd2ydCYd2RXSmPJEt07NVsmxMaf2xsWfXsHBNIEsTk1yDqNVzk3KnHMBpeXriEfxbknKelOM9xDyqjK9w=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNabiFCfOtK2N5Zfd1DCjtqRlJiTwP6t/ZDY1DW6rAvsIwrErC
	Tk6GQ9bmFVGPfC6hZQhY5YMrRH4YeNCFKIin9ecCILx1g/8mRwzsEedH
X-Gm-Gg: AYBFou20L0rY2rt2SFgJWg+trj4OQ9bXWG2ZJiwXYvrf8W5ib5CTKKSbJkz/djtobPD
	a8bXsUnprTwptuXkCHMDG7LysAr0FHLguQf5vRZawIIGsY9B4Ir02On/3Uid1eEouY/z4WogsGb
	6TtF5SLYbHe9QaIvkHOvGCsOSUIi4uAW1HiX/SmAxMnxonz8I1W09iTXKNXqpP5ldQQpiQ4qOIn
	+S+KxHJuwVeaZisc2Q6XGI9snHc8gAOe+hBvYc/M82/ZnTeCck+eowMmduYYqurd6M+haZfMVuA
	Tc/wGvWcceIoJI+2Ldt/GGuGMFDeDIJYTzY1pHrh8IzXSPWFmnc0VdFMUemGYumcrwCca+xeItX
	aE2x8BDBjYg46wV0YWMGeGypNVh2AurjvqVU3CeRIDJV9Ea5HDiHvs/omJj2JR4XTLD9WZjrNLY
	2VWtp3xmb7b8ZXF0pYb/3Qo2MSk4ZpkPURMkEEENgDG/Ec/PRRq3Y+acGNDQ==
X-Received: by 2002:a05:600c:c176:b0:4a0:c2a:485e with SMTP id 5b1f17b1804b1-4a18e4dce0cmr348735225e9.33.1792014255987;
        Wed, 14 Oct 2026 14:44:15 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bdbace19sm18835365e9.14.2026.10.14.14.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 14:44:15 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 14 Oct 2026 23:44:13 +0200
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Avinash Duduskar <avinash.duduskar@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>, Jordan Rife <jordan@jrife.io>,
	Rong Tao <rongtao@cestc.cn>, Eyal Birger <eyal.birger@gmail.com>,
	Pu Lehui <pulehui@huawei.com>, Jingguo Tan <tanjingguo@huawei.com>,
	Lin Ma <malin89@huawei.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 18/21] selftests/bpf: Add tracing_multi bpf
 prog rollback test
Message-ID: <as_3rZ5ToLjzQidZ@krava>
References: <20261012154024.29423-1-leon.hwang@linux.dev>
 <20261012154024.29423-19-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012154024.29423-19-leon.hwang@linux.dev>

On Mon, Oct 12, 2026 at 11:40:20PM +0800, Leon Hwang wrote:
> When rollbacking, the prepared trampolines should be reverted.
> 
> In this test, the first bpf prog will be attached with the trampoline, and
> the second bpf prog won't be attached because the bpf prog has been
> attached by a fentry.multi prog, that causes the rollback procedure.

there's rollback in bpf_trampoline_multi_prog_attach and in
bpf_trampoline_multi_prog_prepare, would be great to cover
both with tests

jirka
