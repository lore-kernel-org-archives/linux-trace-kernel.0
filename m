Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CDB21B9DA
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Dec 2025 18:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764614921; cv=none; b=P+4Ztx6C2gyTyhbvOZo1zX2hNb5xJkUypYvMhdnzxFkiPNNwpFacJpTOyKWMjLCygosPQKNDnhz6s4fDqyl5UFsO+aGKmuO4fhABvECArMNYpngRmlRw7M/EZu+o4rLeRtq/s2VEE7DkK7Y/OQSDOZGSEmAfHN6yQOBMqSZqZSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764614921; c=relaxed/simple;
	bh=CnfhMURLCP5gRu/Vrz9Z8ry7dgu8WYAjKRHKa+VVXaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BV+h3AsQZ6yCVm/32hP/1rEPR/e3pk5didvtkOXK0nuAcSccJ1D5mNhrgkFEHKAGFxI3VYzSyg0c5w2U9IEfc6s+1GiDfM4SKt+cdK7mZTCczZfZzJk8tZOlPHV3jgOsMMBP1btXLiHMdy8XAIbLm5ZpGq7fo5X+fgYYKYi8GOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zt0F4DGZ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zt0F4DGZ"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64175dfc338so8651630a12.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 01 Dec 2025 10:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764614918; x=1765219718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpfWqQh/CZVZrTLcwqyUSpbKiv1XUQTOI1ALBgTqqvI=;
        b=zt0F4DGZ4ZMRna/OkrDQum4+KXCfr0LyCmUs1tjukY0fQoUZZv+JOf/92yf4PDk9m6
         Hs/nkFwsQ+q2Xr+q3yKOSeJPHLj3DxzsqKcZlhxUL1+bMfrNa8RuHDYnokYOm9hloCsJ
         BTlFiCWCZ2lf20aIDobB9mv8Xs+chcYKzvK+Benz1FkKAK7V3rELcm0+VISnnOtL9gjR
         cc3bMnT2U5tpmLQ9MBG6iv9qPvjSB+5raKv61Ga1b528pteDmLB9VCOPn0/JeQftMRBy
         VEFRMLOefwhPChBvFhvg4apiMu+zUTg6+b4M1anb+ct5taswd10UwcC3krJlwcv75rGG
         XAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764614918; x=1765219718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZpfWqQh/CZVZrTLcwqyUSpbKiv1XUQTOI1ALBgTqqvI=;
        b=wtLv1an/iK+z8gDybAKDk4XYnozMiyeic9LhnKcG3w9y/mA8yy/FfzQKTl8V9tQwVx
         P33V22Wau9s2V3+yy2KoHca4YyLvuUcF+QRLE6gqECPz+vq6QnSWTdmqySuhwdIHRxgY
         GcD+1K6Qwd75vbULHeBTdrENwdZXKu4shLIeQmgxXADRga8IPxkHC1OReE7BuRlZ2zgV
         WKg3at9D4tciCtZ5PuRRG02jm62dpw3bmGnzbC5gsnNnT7C8U4tMJaJHf8x7qYJ45jWC
         IPonenRy6SdBQrudttnk/ow0M4eaPNeup72DPmXE6mgwjKJedNgS8enAy+rXE2rYDuYy
         fgrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS23TSx+erKkmwDaHuVjdn0sSi5WZwhk1gh76rKlWnmUmLVgSwZkuzG++qdtvTB8Vicsg7nHsdx0RiavqtLYFZo0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YygXuC+VSjzf4+6Mr2r2Oc6ximIbvF33yjtQ6smyIsC1Fi5lKI4
	C868T8aBcb2P0RS64ibl9CyeW2rlK52458sdj5qJh521yLcLsCCZ4K22OzCFQLu/Gw==
X-Gm-Gg: ASbGnct5gSp1b8B7095TMCfpQwffSlYBAPzX5GNPjwahipB9L8sUTtt6UP4W/rBKM8X
	2/y+zZNlis+jRyK9lX/w94BW62BMwn4CHl+lQ6HoXFpk0XOu77zqisoHazovWJSAHtiI5r5Hs7J
	ENMWl2RrOre3JSLvINUnCY0kydbhDzE3XSWo4Eg6DPBpu2DoXxHbVgTcjcZRbouRGYC/WPTjbX+
	fUJNqN1wfcqpJd3H4saxdOMNkUW+tL/fS0k6CSOdj5eBrGxUY+QDYMidOE9EAGL0wkO5rvB25Db
	HZTKEC0DpOHOy8ptronSO7dW1XLhLEKWenu63hr60LWDYi+lQkppJjTVDXBKhA531YILlMWKDc4
	IO017YZaRYj8gfokthu38XWTxUFL+2qf6Rms7YkKSI+g7Tya7IZecp4fOwbbgCMkShLL1jmEW2L
	17U1+hWT4aFYTGtocAkLkbSaIPX6vNZ2W8KAcQ7UR5YECyQNg4rsAlb0Ex9mI=
X-Google-Smtp-Source: AGHT+IGmXA2mP0MtVnshtm+vBcsRlVLPNa1rL0RYJJvD58tPEKTOZlQjPjIiAfAy0yNT5MrN/ysZGg==
X-Received: by 2002:a05:6402:3246:20b0:640:c640:98c5 with SMTP id 4fb4d7f45d1cf-6455469d112mr31462733a12.34.1764614917515;
        Mon, 01 Dec 2025 10:48:37 -0800 (PST)
Received: from google.com (155.217.141.34.bc.googleusercontent.com. [34.141.217.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64751035b75sm14363010a12.20.2025.12.01.10.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 10:48:37 -0800 (PST)
Date: Mon, 1 Dec 2025 18:48:33 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Shuran Liu <electronlsr@gmail.com>
Cc: song@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Zesen Liu <ftyg@live.com>, Peili Gao <gplhust955@gmail.com>,
	Haoran Ni <haoran.ni.cs@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: mark bpf_d_path() buffer as writeable
Message-ID: <aS3jARS7a-gh9UCa@google.com>
References: <20251201143813.5212-1-electronlsr@gmail.com>
 <20251201143813.5212-2-electronlsr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201143813.5212-2-electronlsr@gmail.com>

On Mon, Dec 01, 2025 at 10:38:12PM +0800, Shuran Liu wrote:
> Commit 37cce22dbd51 ("bpf: verifier: Refactor helper access type
> tracking") started distinguishing read vs write accesses performed by
> helpers.
> 
> The second argument of bpf_d_path() is a pointer to a buffer that the
> helper fills with the resulting path. However, its prototype currently
> uses ARG_PTR_TO_MEM without MEM_WRITE.
> 
> Before 37cce22dbd51, helper accesses were conservatively treated as
> potential writes, so this mismatch did not cause issues. Since that
> commit, the verifier may incorrectly assume that the buffer contents
> are unchanged across the helper call and base its optimizations on this
> wrong assumption. This can lead to misbehaviour in BPF programs that
> read back the buffer, such as prefix comparisons on the returned path.
> 
> Fix this by marking the second argument of bpf_d_path() as
> ARG_PTR_TO_MEM | MEM_WRITE so that the verifier correctly models the
> write to the caller-provided buffer.
>
> Fixes: 37cce22dbd51 ("bpf: verifier: Refactor helper access type tracking")
> Co-developed-by: Zesen Liu <ftyg@live.com>
> Signed-off-by: Zesen Liu <ftyg@live.com>
> Co-developed-by: Peili Gao <gplhust955@gmail.com>
> Signed-off-by: Peili Gao <gplhust955@gmail.com>
> Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Shuran Liu <electronlsr@gmail.com>

Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>

> ---
>  kernel/trace/bpf_trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 4f87c16d915a..49e0bdaa7a1b 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -965,7 +965,7 @@ static const struct bpf_func_proto bpf_d_path_proto = {
>  	.ret_type	= RET_INTEGER,
>  	.arg1_type	= ARG_PTR_TO_BTF_ID,
>  	.arg1_btf_id	= &bpf_d_path_btf_ids[0],
> -	.arg2_type	= ARG_PTR_TO_MEM,
> +	.arg2_type	= ARG_PTR_TO_MEM | MEM_WRITE,
>  	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
>  	.allowed	= bpf_d_path_allowed,
>  };
> -- 
> 2.52.0
> 
