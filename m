Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7015B386C3E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 20:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787601783; cv=pass; b=jwoAnw8fAS+bVNF67HjHjDgP2jxAHBYlvTrSi+fbrehDVmiLm1wuamnj7rI8cmemxwQvteTPMW9RZjYt4h2oZiCBR+j+1BN2e2mMZ4r/LZ3uRiseFYSoCPbKxOVfk+lAp2BAibgiQ1FfnedhALoO7oNRa2qeyiecHvhtWrFP2ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787601783; c=relaxed/simple;
	bh=Jj1eMW4hRuQ95Mf8+sMk0J8dXwuhop1yzKow3ZKRqdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYjFpHDWHRCzn8IHvBxD0AjF25Nf8Ec4uh441oQskUpAAQRwvZ+qglhddxU2aTAqg3selep5r3QEmxxvCdbBE6eBprZz2bfVNAMuQU+G+pz2o4g2q32N5dhtN9hFhGRTdW5bPCCDxMogpGrk87MnrjRV9sBsos2tyEQhCnXzIo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7VMH41k; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7VMH41k"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc149372c14so2852421a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 13:03:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787601781; cv=none;
        d=google.com; s=arc-20260327;
        b=SO4OWuxthgKxXsGolaPg26fKIk1ymA2ypk1B+/u+Twi+bf5aObZKDVUVjV1aMdmOTL
         ccIBtvkXP1taF72m3r3/hs5V67IU9+2rMvQJdQMRFKquA85d2NMTS1wVdMOCk8nq3Ep/
         wrsq3+4KNGltW6knOVVTso1kS9OXiEKRByPwddsT8Ute1AISytcYTCHTMc8hOE4jzbBp
         uCTxZfad1yyLHwLvN8NDL0TlpYMOU071FDnHdV/x7sFJmblvNC452ykjLg1rs8ksEC2x
         hD/p87AWy9rF/AKHD3VH9loSHMFCIwVp5x/gtgoQl3N6Daqkh7lvViTBNTHHs3ODQb1a
         PWUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3mEWmWLPfbBEGQVJCFnc4zzX5ivCTH8MT18ptDlEOY4=;
        fh=H9AU747tJYZJn6Dj6Ng5PTphQwf4rLCY0X6jjO8HUtw=;
        b=W0rGe09SqBZEMlAY9ZcL9jEeiJdCz/s+QLR+VGJkAppSAcMl+nTx9G76x6ts7J6s1X
         PGuAdsRDPLsegtI0ihGNCK2Ru/SwCWbqkF10/5b2HkFTw1RjwCbP9AjOH8WOAXIbn+Ri
         CuYcqJpyzaxBraTcDPFr8nclgPUs3KPbXVP6MJ923s5CFGqfN32Zxa2h/7fpAEZNwBe0
         xA2MFyce9Lmn02ZqlLuvFy7JU7dFmY91ATKiFOUTT+yDQGLcu3lPRKnHMchYVRAcHlim
         wHIIsValbeuYCENcFKaFIhUH66q7YqXmDqf4MEycLM3cOGYn09Q090UgCRsVOPSmkxF5
         6GzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787601781; x=1788206581; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3mEWmWLPfbBEGQVJCFnc4zzX5ivCTH8MT18ptDlEOY4=;
        b=J7VMH41kmK8mIuh9ZjV9D9Avu9Xa6+mp8Rq9yfrfFzNvpEQTiMn7b40k1QNkQenpuU
         Kl5JjYabDxgWO0yyz2VX9daDVetNFn8sQsJbxPE8e9SOjNm7P/geY7Ao1iLlrnO8UPTg
         2KGPa4wak9VhlrL423otduYahQMbmTOSO37R6amPpv3/tl1HmSdBL89hM6Zt0sTNeh6g
         9rNZk+wL3O5WyiynYwH/L9Z8b6SxCgulO4C2XDQvn3uBQTBp6sjaSRmUcbE0T0zGbg9R
         vyUVoLV0N81FfLrt2eIvf9/4x+AS6GF1Yzw2nGx7sCD2Z9/U2xKTnyhsC2KgYm4ekO77
         nX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787601781; x=1788206581;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3mEWmWLPfbBEGQVJCFnc4zzX5ivCTH8MT18ptDlEOY4=;
        b=ApUDwbwruOOyvo7pPm4USGIhZfYWR7KGS1yCkJ4HkUGZlbOCCTBSekhWlsY3X8BTbU
         Es+1bIatK1MMNSAj/HWNDmhO+xG4JhVM5k6RaGSgygpBsqDG6G/D37lT8LNvTpm5od0w
         nL4Dt9urIj/2kZSqrhxbR59eVIbcRNTi5QPj3Q0kJsHdbWoqxstKYuSAIkK2H0XmurV1
         32JcqDF4Qa+pWSZuYZQNZ/zFXD1c8Onb2ySe1oGi3DknLMpJb8ZTnp6k564hLLarjT+P
         1Vmo0aKP8uems19Ndt7u4OU+86xWT7HY6cbPIH35WMmmkqTiRGWoUAhA8DizyJ1tQWtG
         E8EA==
X-Forwarded-Encrypted: i=1; AHgh+RrBnmVkJpQHQjBXDTj8vBDgPAn6XFXu1Ce+KfE86Zx1IQLuP/5iXYRvOnyDLIWePeBT8NmNd+A0UOKLHd3j+hkGnyA=@vger.kernel.org
X-Gm-Message-State: AFuF++ngf4nYvajAs1ZcfFvw0GTqEfDa649sfiFzZ9cWK8uzpiA+Uvpm
	yQ8jZmiMCqxGtWqfEgh756Ys1aRD7ELgLSG8I1X/4KYzrnmv9pnGVSlpOkdNNqNM68vwBpJwN/R
	UE45KWEU0QrNPdbOyyx0ID4ryEyiB+nk=
X-Gm-Gg: AR+sD134h+ACnNSV4w15SeVLZqVCURnyjIo1mxW4gIpp0yE+lo0jplSJcOeKJlzesxN
	WOI2tEOD5NG7mRPeEUGfjqbAPUMTh6okfd/npU2hoomHDCAqdwQMLevJSjVry5sBYZl2oyX/Nh0
	r8j3IozyTcRw5Kw7jsAIMKe7miIM+++YA8YX9eDH+CQfjWEWGZrUzqSRpGTG61Ylq3I95gohzPo
	Ho3DaRCXxj9VVWjBDwwB0gb2dcg90vbovAuYAPhWyr8FERdi9l+vIUArT7LphGqMedDGYGSw2xJ
	nFkjLteU5TRlSNReny0yrQIq6G530Jf1BIJ1PpwOr4mUOHW/8BgoqgCrk3nPV+6OBWampqeR3Wn
	Q3iZnalfpSZ98bgejwaQikecuOWAKLdfwNcCRqVpB8g==
X-Received: by 2002:a05:6a21:e96:b0:3cc:b26a:7686 with SMTP id
 adf61e73a8af0-3cd9107fdecmr2555856637.6.1787601779615; Mon, 24 Aug 2026
 13:02:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809150111.45000-1-leon.hwang@linux.dev> <CAEf4Bzam=0V6n4_vBahhYh2Qn9KfriDKXSz58L4L+teHJRWfPQ@mail.gmail.com>
 <0b30bc97-2ecf-46eb-a863-94e706e18c6b@linux.dev> <CAEf4BzaXaLLqs6XXCG_02c7UcvNWfbGUAJTYosr22oaD4iokuQ@mail.gmail.com>
 <c71d27ab-ec59-4b72-855f-7bf437095cd5@linux.dev>
In-Reply-To: <c71d27ab-ec59-4b72-855f-7bf437095cd5@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Aug 2026 13:02:42 -0700
X-Gm-Features: AcwNN1W7QHx2RbjWvAKjCJKxsiFvI4VgPdw5RI8B_3Oxui6UCoF584p_UxygwRo
Message-ID: <CAEf4BzZpB-qkhu3SAu5MrYYAT2+ZN8WaXqpmnKruOOdjJOLK2A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/13] bpf: Add tracing_multi link support for
 bpf progs
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>, 
	Avinash Duduskar <avinash.duduskar@gmail.com>, Anton Protopopov <a.s.protopopov@gmail.com>, 
	Amery Hung <ameryhung@gmail.com>, Jordan Rife <jordan@jrife.io>, Rong Tao <rongtao@cestc.cn>, 
	Eyal Birger <eyal.birger@gmail.com>, Pu Lehui <pulehui@huawei.com>, 
	Jingguo Tan <tanjingguo@huawei.com>, Lin Ma <malin89@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 10:00=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> =
wrote:
>
> On 22/8/26 01:46, Andrii Nakryiko wrote:
> > On Sun, Aug 16, 2026 at 11:20=E2=80=AFPM Leon Hwang <leon.hwang@linux.d=
ev> wrote:
> >>
> >> On 15/8/26 04:14, Andrii Nakryiko wrote:
> >>> On Sun, Aug 9, 2026 at 8:01=E2=80=AFAM Leon Hwang <leon.hwang@linux.d=
ev> wrote:
> >>>>
> >>>> Similar to the tracing_multi link support for kernel functions [1], =
add
> >>>> support for bpf progs.
> >>>>
> >>>> When attaching to bpf progs, it must attaches to the target by text =
poke
> >>>> way.
> >>>>
> >>>
> >>> Please spend a bit more human effort on justification for the change
> >>> and explaining your use case. In what case you'll be attaching to a
> >>> large amount of BPF programs such that attachment speed-up (if there
> >>> is any) matters.
> >>
> >> Will update the cover letter with justification and my use case.
> >>
> >> Here's my use case:
> >>
> >> I'm planning to enhance the function-graph feature of bpfsnoop [1]. It
> >> will trace all bpf progs, including their subprogs, to draw a full
> >> function call graph including bpf prog call sites.
> >>
> >
> > fair enough, interesting use case, definitely outline that in the next
> > revision (and provide before/after attach time as well for such use
> > case, please)
> >
> Will include my use case.
>
> Implemented the attachment micro-benchmark. Here's the result on an
> x86_64 16c16g VM:
>
> ./bench tracing-multi-attach-progs
> Setting up benchmark 'tracing-multi-attach-progs'...
> tracing-multi-attach-progs: prepared 1000 identical BPF program targets
> tracing-multi-attach-progs: fentry created and attached 1000
> programs/links in 679.324ms
> tracing-multi-attach-progs: fentry.multi created one program and
> attached one 1000-target link in 470.042ms
> tracing-multi-attach-progs: fentry.multi creation/attachment speedup is
> 1.45x
>
> The speedup 1.45x looks good. But attaching to 1000 progs via fentry

I'd say "meh". If 500ms is ok, 700ms is not that much more noticeable.

> costs less than 1 second, which is really faster than attaching to
> around 1000 kernel functions via fentry:
>
> bpfsnoop -k '*:(struct sock *)sk' -m entry -D
>  Tracing 1096 tracees costs 11.597266736s
>
> Thanks,
> Leon
>
