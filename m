Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65432DBF75
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Nov 2025 18:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763145733; cv=none; b=cnjsEAIJQlz6J7uMt0zdL0w2KJZiHuWDVhEpuTgA9NzJgh+Yags0Ph60CXDEi83qP/y2axrrKCFFFno2h5ChtVgeKFkEILXt9xiVtSoxOi4ZltwUNs4kle/9E5kG2+dqmohsUREdzC8IdhMesBdZJfvOHbNP9eQn8Z0Iht3fggQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763145733; c=relaxed/simple;
	bh=Yr+QYXSio/Vt6yezILbjQ/kPLtEqHWKN4wAJumxy6qM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOl2m/MKZyr4L+7+Yhwf0RujkJ//2+u97QNGVpyP+wz8Ds0h5P7/zGN9ADvXz7DRjK1q4VCSfFt+gBFPyOMgqrIK90wq/EcIPgm516GIlfLP/fXt300aj4UJWmF6QlqH1mCHEptCUe1WeWEF+y9Nhn4qAQmO7Yq1HOhCtgXM6NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MC0M2kIn; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MC0M2kIn"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b3d4d9ca6so1983267f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Nov 2025 10:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763145726; x=1763750526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXikbDMo1y0MhesOpF400bT9rLKaVPJBJqU/w2OePJs=;
        b=MC0M2kIn8tdiRweUAuArxzleG4xIgqXU3xr21TJbY0S78mbKd+rwNBfsw4rBrN0O/a
         zmiJpNqPPmhwiFdy5GFPoZH68RvGM9e2o4MQQxRM5t3akI4RdCYcNNjXWB1KRC9aOLYS
         etepWVrjMSHvr4ryykvL7TXgeucE4bVAAOhfIqGnGe6eMG73TOB4Bo8LfApMQPD1WHKu
         NW+wyaTMN5MYydexMRqTW8q8ARs3X5Q070xd6h0feaokQGw57s80EN371fNt78PTIJoc
         Z1eHjodiAs42sijDHmxib6NZqakxqeaOkWgM+BqLn7yuNcLvvwNWyChlgkQxrImZtvE4
         nFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763145726; x=1763750526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jXikbDMo1y0MhesOpF400bT9rLKaVPJBJqU/w2OePJs=;
        b=dGf80RZ8bTxsFMarsW4EtQUIq95pnnBZRsj0dOUt7K9u2Gv1DU8V2AfTQTWHq7GH9G
         4PUHEtobuQ5XgYR7YJnKgWm18gQxzsfqYxfC7SFicck7ewFUhpuEszy1sGdLldhWlO/W
         d6va9S0JIfAj3ONfFUHCqJMw7o5GRPlLitCsoqVnfLKGdng9Y9ydJGBSSyyptdSfYvOk
         MZx9Adp4ktcHvDtvnbRKScfNMNe+naIPaBqiKtv3MFYIlgFPEJrN7OzRF/meK+0rgfzZ
         z1mJ4TYeuf3AiIYufbFckFCZBKkHpCVA+erJEAq9hdtkmLaHujZrdwjONoB6mc5dsCtE
         +1zw==
X-Forwarded-Encrypted: i=1; AJvYcCVan9mcxZqHfVVsVf7oxToktakQe3DJ9P5yIRYDowVCKiGFeYy/IF1Vl3kaeiMa49bBB4OVbMWwBQgg4Es1+ZXWTbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPtUmYrIOYoK/JVzLz1uYI8cTFnUF4vGVE3XJu1LArpuF6QW7h
	Q6KTW3RlDs1jUont52iSYne2KeAQfU6r9m7h7B5ap8uH3MddGj+WBpOyZz6jx0mCN2pRHFPz9gi
	tuN3ALWBW/q7IbMsstil92dk7xFLCvLQ=
X-Gm-Gg: ASbGnct7yVpm/8xz74QL1SqaIsFd4D3SDLHkCHWJRDP5F9EWlxwoy9TrnGU5hZhlpI8
	qPHQSnc3m5wIB4C9q43MA1bvDWfoOh9uV1lD52/hug/z9YuGyvULH25wrb9vvqATmLfezsu5/LB
	9SWuFD3f30crSNW0LGeRtynHVgnDniF1DGV3rtVH8rnqHkJjqrpE2vxbNUk5epJl4lmNYI62o1q
	B98JRKp9RTVVhShl1z6MZ7Upo+sndwjlPDiI8B0MjYDcZv/yZEQZhexDtTM+8ppHKxpOkexpUOg
	DTRJlRIOf7ane857lql29K4asQkB
X-Google-Smtp-Source: AGHT+IEwNUK/Pn1NIOkddN345K3xYtvPkS+urQ1M5vbjd/Sue+SZbGJFokCEzoWcyWa4lCoV5KaAN5xxaFCYElb+/fI=
X-Received: by 2002:a05:6000:3104:b0:42b:3ab7:b8a8 with SMTP id
 ffacd0b85a97d-42b59341539mr4087488f8f.17.1763145725905; Fri, 14 Nov 2025
 10:42:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114092450.172024-1-dongml2@chinatelecom.cn> <20251114092450.172024-6-dongml2@chinatelecom.cn>
In-Reply-To: <20251114092450.172024-6-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Nov 2025 10:41:54 -0800
X-Gm-Features: AWmQ_bkjvU9z2EP9HEX18ZUpIH2hTIcIwoCeBxuk2sjgbg9_DACCoNFlr-aYKGs
Message-ID: <CAADnVQLemtF-m5et+c5pWppNZoWnWBehtMCHVJU9Yagvi+dRZA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 5/7] bpf: introduce bpf_arch_text_poke_type
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 1:25=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Introduce the function bpf_arch_text_poke_type(), which is able to specif=
y
> both the current and new opcode. If it is not implemented by the arch,
> bpf_arch_text_poke() will be called directly if the current opcode is the
> same as the new one. Otherwise, -EOPNOTSUPP will be returned.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  include/linux/bpf.h |  4 ++++
>  kernel/bpf/core.c   | 10 ++++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index d65a71042aa3..aec7c65539f5 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3711,6 +3711,10 @@ enum bpf_text_poke_type {
>         BPF_MOD_JUMP,
>  };
>
> +int bpf_arch_text_poke_type(void *ip, enum bpf_text_poke_type old_t,
> +                           enum bpf_text_poke_type new_t, void *addr1,
> +                           void *addr2);
> +

Instead of adding a new helper, I think, it's cleaner to change
the existing bpf_arch_text_poke() across all archs in one patch,
and also do:

enum bpf_text_poke_type {
+       BPF_MOD_NOP,
        BPF_MOD_CALL,
        BPF_MOD_JUMP,
};

and use that instead of addr[12] =3D !NULL to indicate
the transition.

The callsites will be easier to read when they will look like:
bpf_arch_text_poke(ip, BPF_MOD_CALL, BPF_MOD_CALL, old_addr, new_addr);

bpf_arch_text_poke(ip, BPF_MOD_NOP, BPF_MOD_CALL, NULL, new_addr);

bpf_arch_text_poke(ip, BPF_MOD_JMP, BPF_MOD_CALL, old_addr, new_addr);
