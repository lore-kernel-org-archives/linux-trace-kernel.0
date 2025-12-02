Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D888301002
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Dec 2025 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764663609; cv=none; b=ZzIThhpUf0SNJnzb63I91CpM2f9HYh4uqeBeptrNG34eZ/F8jxusM5T7X+LLgOLQlnhcRh6SfUjEz70dztga8fo6XHztbQ6dEmhFE2ZDGIPprCd1MAO773wki/3Clp+3lZOLFGFNASq1cicfjyrY07go8VZou/S36JhBTfrz/hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764663609; c=relaxed/simple;
	bh=TOzc+YtGKrQFav1JK/XIoTdNhUL8xeVX6xX+WO3kPhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyhdNHOyioy93G8IoQH+eAkZyg6rp8/MojNnYKoA7gTwUtj9W3msbG6zL210aV9BNdbFHvFB2YFR2vijaGHdKIPLA1QMSeijnqf8/6DRkGe4W6l8oL8FxhD/tLKwac8zyckY8V8XS3qkBm76tYaQAmbeK+2Ijkj7XyPkW1vAwLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LB8Zu/BP; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LB8Zu/BP"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-644f90587e5so8130363a12.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Dec 2025 00:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764663603; x=1765268403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DASpGnmo4fdFF5NWyyNjefmpCJ+p1mEJZQR/FEoIZeE=;
        b=LB8Zu/BPTEc7UxjOrGkqXD26051oof2CfPn3D6QBX0esIbCcNa31NykrY+YqXUMSDq
         E/00LnuQc7TmnLu0Tdh1BC9refCr2Zv41ceQ1JrEdqewcMXV/IR461ddOmTbDA6rHGor
         7cWl3mBNz1fLmQp5wonMDH17urc2itwQom5qAEh7btwcYZ19guzsOcMdMMt+KY09O3Jp
         Fm8tj3R0Ii4rOx2N9aG0ZnqSEtyeuL+bpHeKdK6cwO/5iVYW8rxZYf7f6PdroC4cCV/c
         Ctp3rQLSP5ET6u9dQ8rZ+eEQE0a5RGwBEKRRJr3GD6PhyJxfIJLHkHvlyvNvt9nuXWzi
         vf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764663603; x=1765268403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DASpGnmo4fdFF5NWyyNjefmpCJ+p1mEJZQR/FEoIZeE=;
        b=WdUq5GQjrPc/X+uH8VxKwN6T452+iWP1Y1E9sU/GMDkrp0D/6oBm0l/tbJB9rMB8YT
         +YT6hjPPqccj0nwj95A9LyfreXU4ZB4lkcmn1NUl1WKxOikIYokDyPR2h18UWCwxhPWa
         ei5DgitnNp6XjV4AD2VEqUpVkPlYAbj/j36BAPdKCntJ8eF0TnzhlxNzyl6/qay7eA9O
         QfW3Uq+9sPVcywGmi83Z59iHGRHU9MyElmHDMTxjjZAdL2A+GEqtSTEw/LARCdZy0Tlw
         lyN4+SmFaUKSKy0Zv2kV6G89NLnz17AFHoXpP3yU2i//747WhPCjUjHSuO9e9I78FIs1
         evrw==
X-Forwarded-Encrypted: i=1; AJvYcCU+6/HzqVBW9pKVlVmNEgGJGgewK5Bm2/0DzBw7pAk6Hwj/p/YF7O2Z2PKB3WcoZ8esE8aWt1isSs9SQHuzoVId5X8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJDntcdBCPiJ7RS6PQ+A+vPRrO8IQHdyDXvV+jrusskRcHAvN+
	70NqRa7x+pdkQymFi/O4/Px8+a61Ffq734AshMXG9tsXuXDw6k6PZo232pN2WpXAlQ==
X-Gm-Gg: ASbGnctYM6iJyiH/9R4Qkg4m1lxcMQsFaGn7fBvIs5swGAZLS4PQsKv1KhS1ioGX1UT
	whVDiYENkCJnVl2/r8y+t+Hb0wefxezEwdKnXhq7TSo96/QnyTK/2nfg6NrDSXgmCRJ+oHMJ2Zp
	N0C+1ItP8P99XilCr/GonpXgvvCnzgwtX+4e4dDcQcuK1b4oMMqaUO0ljX4JNp9/8KvO8MGsAim
	iY6WOV0U7D0zja1115F+6Dp3RjfkjjxvSfrKjit03+domwjv1ac5tERwyKGXVmSX9CgqCGQkSB0
	Cvw3XN6WQzKzvTsEaQR83rrTsBWXZxNbpNqMogdKXIf3m+16Wgfb5aS0YrccX/dnYI2RUvsXcf+
	DnIBylw5SIc4fUadC8DoS5y6+0ZDdhz4W2MdEl67bYGW7vftTZmAaHjVpllGbLgGwEY94ZoH14i
	P8xF/sPZaY3WHp08AdT29So2CVzAWwHag+vxS8tktmaHvSGiIG/zwxRZ9eVVk=
X-Google-Smtp-Source: AGHT+IErW4+TU0F/icO2uVLmBudXHsczagOsW3I+rZ22702sj20Oi38AWBYXnbL8PNp5rcoIlzDHdQ==
X-Received: by 2002:a05:6402:5113:b0:640:980c:a952 with SMTP id 4fb4d7f45d1cf-645eb228d07mr27548785a12.11.1764663601511;
        Tue, 02 Dec 2025 00:20:01 -0800 (PST)
Received: from google.com (155.217.141.34.bc.googleusercontent.com. [34.141.217.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64750a6e873sm15501693a12.5.2025.12.02.00.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 00:20:01 -0800 (PST)
Date: Tue, 2 Dec 2025 08:19:57 +0000
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
Subject: Re: [PATCH bpf v2 1/2] bpf: mark bpf_d_path() buffer as writeable
Message-ID: <aS6hLVxKoifrWlK6@google.com>
References: <20251202075441.1409-1-electronlsr@gmail.com>
 <20251202075441.1409-2-electronlsr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202075441.1409-2-electronlsr@gmail.com>

On Tue, Dec 02, 2025 at 03:54:40PM +0800, Shuran Liu wrote:
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

You forgot to include my Reviewed-by trailer from the initial patch
series (https://lore.kernel.org/bpf/aS3jARS7a-gh9UCa@google.com/), so
here it is again.

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
