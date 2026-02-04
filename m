Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E612749CF
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 02:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770171657; cv=none; b=iTbFmdBBEOQeY+sl58dvG+VSJUEhkewevVKOux+xLYlgqo2UxoGWcy72YpS+LOMTgYPkTNax1H9B7rywTZmc91JlVvhT0ZtRvdhfSwf95/px+otOPvvyic5jyepmiA0NrUKhFdgr98B+ngNXZE8NGk5auYRe01q89eZYHFv5a3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770171657; c=relaxed/simple;
	bh=O8heI5Nogc6vWjzTGjyj/YdzwgHPxl9kt7RAabw7pKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h3yUJoIdr3sD1qjEax5GdQ2IhW4tBHMo/U9s6S1Ot6ptCQWxJobx9TFZLbLn+WdLSLmbguMPesrmwQ5aNcszHY3qwmM4QwrsA0s3poqcbQqbBktuV3APBTqepCB4E9UbJQqS1TukyK8WgXPkeg6Vc0hH4CwEkYGLK0qWGPqcmV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pT0QZMN1; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pT0QZMN1"
Message-ID: <3015991d-2e9b-4bf4-9c17-26e00b5d5926@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770171644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dLuGikwdkVKzxyLyIG9nEjwNvRtmY4mW49/acC8aAhY=;
	b=pT0QZMN1Hxfu4g4L+SSvYdf9s3VJdB8g4PfsYMvBbl91/ufwe2DoU7RM5o7G88Xs29OQIG
	16j4hTloNcghaeJqrDOihcv0V6pg+kkdK13UY2ahdtVuSS7dIKyTRgcxWGZuIQI4nhXrH5
	EjNY+9NS0XvDFXgzRIQ2Qqoxsfpjz9s=
Date: Wed, 4 Feb 2026 10:20:29 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next 05/12] bpf: Add multi tracing attach types
Content-Language: en-US
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 Menglong Dong <menglong8.dong@gmail.com>, Steven Rostedt <rostedt@kernel.org>
References: <20260203093819.2105105-1-jolsa@kernel.org>
 <20260203093819.2105105-6-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260203093819.2105105-6-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/2/26 17:38, Jiri Olsa wrote:
> Adding new attach type to identify multi tracing attachment:
>   BPF_TRACE_FENTRY_MULTI
>   BPF_TRACE_FEXIT_MULTI
> 
At this point, should we also introduce BPF_TRACE_FSESSION_MULTI
alongside BPF_TRACE_FENTRY_MULTI and BPF_TRACE_FEXIT_MULTI?

Thanks,
Leon

