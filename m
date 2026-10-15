Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B2B3E1D02
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 19:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792091013; cv=none; b=kKXCjYHzcRP0CM1/0R9WqktyDXkqWh6bKQajMJtQoEEZcY9W0Ztu6DCkLjI8mynFXBNjOKEwV2+sdDQkP2+WpiO3Ew8UDj8yOgEHW3XjarB22kxW6aeBISIjTSs/jSq5+7kp+Llsa120vEJWBm8kS/cXvl8jT1LZvcsKJZUJL5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792091013; c=relaxed/simple;
	bh=7b1Nk/ZJMD8drhAUN0wfc2gumfVbFyem4H6YFgUVL0I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Gu7OjppUxTSciX9EyPkKmrqz9fAS5RZwe80vWVzBOeKzNq2Zabsb7C/lfDVKuf0/b9QTXZ9igidcfcqgA698VgcU0Q71IBO8SmiXaCssgp7/Mlc6TrxDFR/I8i1F+yXaHPBsJmnRecWag1XxK2Lq3j2+3PMVZgQvvKPICv+auLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cabQjDQA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cabQjDQA"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2db710396ffso1842195ad.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 12:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792091011; x=1792695811; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7b1Nk/ZJMD8drhAUN0wfc2gumfVbFyem4H6YFgUVL0I=;
        b=cabQjDQA/k9ATVD4gnaKh4L7m2sori+UVd3ZH8wkFq9YfJR07+qoCNn8PbsY9jFXjD
         opQb5ZbNd7L/PdeaBc1knI0NK2tG5sRWAxs1++tNNLZ/CdDHfEMnP5RyublAYLkz2IDM
         bhqRcVtHNQEbSDghMBZJH+j0/jWlO6l0FUxF0hOMWaPSuGJ2lByZ4zWrBI+L6+Tckzi9
         tEFYrK3kDLUptKZ7snEhsyjpN7I29XjuQJqEySWe1cthQwJ3/mZ/RzeG/3Q55yWn+2bH
         Q2qA3mNKPEDvIv42hLV6cz09T5EN1AAEriNlOZXYe5RT3dmogzTNUryiQKDxL55QlniU
         ZkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792091011; x=1792695811;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7b1Nk/ZJMD8drhAUN0wfc2gumfVbFyem4H6YFgUVL0I=;
        b=zKwE13IJT7/6u961SbL+tzUVSD0Bfo202gAtNsoPhSY6VKcc8ehghNYN3n83nQ7tn+
         75GGLjwAfW+3KVq18LWmMBarRxDyuwa5Voysbe27Gd2CSWvual5V4tbPeeGvUL+175mE
         ZLBYGb9The5eQTnkYrbWRKPPL2VodjfBBbVLMvhOlUScoEu8afinGL4XDjhFEA8ffB1W
         iH3/0J2LFYZCuPI7z4M8EZY/Q47iHVgc/PtqvgbryhTogDYaXlo5WViT4VQBqCfSNXye
         T5ZLQ/REq7WnLKDfwgkXRdGtcMQhXJNFeNcq+ik/RXV+zMA62mzqmKvI/Pc9NbjjQaqp
         KYcA==
X-Forwarded-Encrypted: i=1; AKwUvBwu9LQvUFXVPiF5iRy+FmdTsjagExpTRMIq/t5fEGohYyFmTSxnfs217na0uhMVWRjuytR2GU7NZ82HXWcohvVmmQY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0BSc2DjvM2OfWWH2EgxWYNi0JNwjmJyI+npKM8WdoNhtWr3C8
	DLJWl25SvGQY7kuhaZ+9ez6knSxV5e9XhQt1njw8YJOf9dJ8uFOTG6ys
X-Gm-Gg: AYBFou3UjFjOJiyKCPzneBX48y6kEs5g6BwNpWKr5pV4kQGuY9o5QdqDytPyHZN43vf
	RZNi5njbA3zJ5ShhxJVh4vC//lPEoEZ3DzzDr4ScDTcmKe1H4DIaI1/CpTM09ccyHdUJKbL3JiZ
	CdAcIuTGn6AIOiMWKJ81ZofLvI2KSzYYu64GC+kpGfwW1ElFcXulHWJhyo1O/6DhQrloO1cSASw
	qOIHLQSjD7t727nmS+axroOqmiktiMczxWcIjnMU3cbmm6SIgJi092TBDqfic4a9mVVCZ4WfULl
	jkEwUE/OyXlt7M9DaRoVAYB96J5uvqJE8vG/jl223gP2Jxz9ZV3rnQOup7ZQvmxfJmWBQtDM8HK
	W2IlhrI67orUQKEQrLqccR09vHmNigPQXz1XCl5SGY5lvVOifgoJOAeeJ5xAuO1rDynyqYOR8Kp
	tyZbovnXKFoIhy+HKV/WqCjh7Snz2zpV7MGXx9e3zackV1NcEUPN0Mnjoflj6EZczNgvqO0LLXW
	stp5+BMKxNNgcGJkYw2sOrnu2XrDiHiK0T7vxiisdOfM0C6DqHJhmWdNQl3wOX6O3m9rUiYi7T4
	x8w=
X-Received: by 2002:a17:903:144b:b0:2e9:64b9:a338 with SMTP id d9443c01a7336-2e977140eccmr6102915ad.7.1792091010968;
        Thu, 15 Oct 2026 12:03:30 -0700 (PDT)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8aad3dsm464765ad.64.2026.10.15.12.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 12:03:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 19:03:29 +0000
Message-Id: <DM5N8SCBZDQE.2SC93YN5ILEYG@gmail.com>
Subject: Re: [PATCH bpf-next v2 00/21] bpf: Add tracing_multi link support
 for bpf progs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Leon Hwang" <leon.hwang@linux.dev>, "Jiri Olsa" <olsajiri@gmail.com>
Cc: <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "John Fastabend"
 <john.fastabend@gmail.com>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Quentin Monnet" <qmo@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, "Mykyta Yatsenko" <yatsenko@meta.com>, "Avinash
 Duduskar" <avinash.duduskar@gmail.com>, "Anton Protopopov"
 <a.s.protopopov@gmail.com>, "Amery Hung" <ameryhung@gmail.com>, "Jordan
 Rife" <jordan@jrife.io>, "Rong Tao" <rongtao@cestc.cn>, "Eyal Birger"
 <eyal.birger@gmail.com>, "Pu Lehui" <pulehui@huawei.com>, "Jingguo Tan"
 <tanjingguo@huawei.com>, "Lin Ma" <malin89@huawei.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261012154024.29423-1-leon.hwang@linux.dev>
 <as_7Jgy_sdTE9M5O@krava> <09db7d70-b7d4-4cf5-9447-6d16bac10794@linux.dev>
In-Reply-To: <09db7d70-b7d4-4cf5-9447-6d16bac10794@linux.dev>

On Thu Oct 15, 2026 at 1:48 AM UTC, Leon Hwang wrote:
> On 15/10/26 05:59, Jiri Olsa wrote:
>> On Mon, Oct 12, 2026 at 11:40:02PM +0800, Leon Hwang wrote:
>>> Similar to the tracing_multi link support for kernel functions [1], add
>>> support for bpf progs.
>>>
>>> With this support, I'll be able to enhance the function-graph feature o=
f
>>> bpfsnoop [2]. It will trace all bpf progs, including their subprogs, to
>>> draw a full function call graph including bpf prog call sites.
>>>
>>> The attachment could speed-up when there are hundreds of targets. For
>>> example, on high CPU core count servers, it probably runs 200 tc-bpf
>>> progs as Kubernetes CNI, and each tc-bpf prog might have 4 subprogs.
>>> Hence, there will be 1000 targets to trace for bpfsnoop's function-grap=
h
>>> feature.
>>>
>>> With tracing_multi link support for bpf progs, bpfsnoop will be able to
>>> attach to all targets quickly.
>>>
>>> When attaching to 1000 targets, fentry.multi is much faster than fentry
>>> on a 16c16g QEMU VM on an AMD EPYC 9745 server.
>>>
>>> ./bench tracing-multi-attach-progs
>>> Setting up benchmark 'tracing-multi-attach-progs'...
>>> tracing-multi-attach-progs: prepared 1000 identical BPF program targets
>>> tracing-multi-attach-progs: fentry created and attached 1000 programs/l=
inks in 338.171ms
>>> tracing-multi-attach-progs: fentry.multi created one program and attach=
ed one 1000-target link in 47.345ms
>>> tracing-multi-attach-progs: fentry.multi creation/attachment speedup is=
 7.14x
>>=20
>> it's faster, but the original attachment is under 1s,
>> so not really a problem imo
>>=20
>> I guess the api is better for your use case, like having
>> less file descriptors open ?
>
> Correct.
>
> The original attachment is fast enough. So there is no need to improve
> attachment performance with a large patch series.
>
> Even though the series brings two benefits:
>
> * One bpf link for multiple bpf prog targets.
> * Support for all archs that have trampoline support.
>
> But, I also doubt the value of this series.

I'm not sure about the value as well.
You also need to benchmark detach time.
Overall the perf improvement is too minor vs added complexity,
but the first couple patches in the set look like a nice cleanup.
Pls resend them.

pw-bot: cr

