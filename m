Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD971F9F70;
	Mon, 26 May 2025 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748260406; cv=none; b=mmX3CTpjwm9Wr9YzfOC0DeTWjyFQb/Oj0dQfh1AeuXDEdSetw4WFV8oKRjqCb0YpoEKmvp/1yuQ/IrfBxMFczHYU9OQdGCdiHtD2baVdeunei68sMNiI5WL01QmsJj+9IQ8xd79qJ6zWRJmCjPAxlAcNSESLe35psxAsJDq4RKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748260406; c=relaxed/simple;
	bh=tKe39hpMYxZ66TPljkbq2DpeIkR0YpIH8Yyuw2QRc/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QcWgQ6aMKyru2IntWGPOsJ1YA2CZtfY1RfpCKY6j6mJXi1MVvzttiHI8NmPhbideovemqyHoDHbGQWMpGsKAHjky+TE7IHnJQGasp4sicngnaUSQAphXqJfuh3xbYYvbYhSKTs0qjn5/TsXRESk+CixoO8IYtDU8BaTSaeSJDC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pg37fU62; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pg37fU62"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-31149f0393dso812355a91.1;
        Mon, 26 May 2025 04:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748260404; x=1748865204; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=371RwblsY76gtSLbLWcDDtjllCtSvyNzkqLXY8Z9aBs=;
        b=Pg37fU62aopn7BF6LCADsdigReqjdXm01IEOD33JNlRoacS1O0N17Y1nd36KBMGnKl
         QPcbxarv3cioWxfRooPozMLOwulzLL4HRr52tHDTdHId/9pz/29jHpQ5+4Y97jqLuj6B
         9MwkKgVUGMKMnwFCePEm9sD/8UsiUoh5i9qiVxdQrMP/OevwnzbFzxgHrjw+F2ef30FW
         aOjaRZVw3DVY/9S8FPKRByEWiVs6k8y0b6bsGCZWXcHqC3Q/jheqPQ0GZs368TznuPCd
         9iQOzgF/dNUogFIjrK74MM7s1iAHwwgE8OFmIz8nO+8K3N1Z0a6V2x/rElH9s4tozcOc
         7eSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748260404; x=1748865204;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=371RwblsY76gtSLbLWcDDtjllCtSvyNzkqLXY8Z9aBs=;
        b=d37M4S7eIHE7L/gCj/HL36freu6nBzqOk53/+/7+mVYmeWCvcz732IjcMZrsatkeRu
         NnLcEWkmN4mtzz0nRa4pGk5iKdAPiHBVsB+BAykzHWdeyvgQ/XXbO57dHsqGtLdUEzuO
         5HIRFhnADnHD5+s3dfPQISMJBUPehOHhQ2RyLb1AbB47bJQ+ZVKIW3D1GAgwKdI1uvi5
         uoqLFAiZH6iF8FqqhHNVW/lsaGyxSCkSl1OoUWrusWeOCcQclU7yadCsvhwV+uvbakkm
         lDwheHjpxrJz0mH7AH6rKB7OVDalj4zTgGqV5IlutYlygSTwqC+d96m/XtAQNj4osuFG
         PD0A==
X-Forwarded-Encrypted: i=1; AJvYcCV09KJSzF9VFoNNSKgIYKomHitmqEchH3q2lFE+17TtjSIRdaoBUPinOV8HJ9kVmJRyggJVfAfYjPvJzYqEny1YSbSm@vger.kernel.org, AJvYcCW9n/PazB5SFwFMUTkh4/yPramYJpJsNChYnN8BydCBTVmSIc8zLGM4V36Pg82guSmwy+O3EGmLK/Ooyps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsRZh5+Oc7gwoMUHzOhifdsVuOogjDw4vDAkv2682O79M8JnzP
	9MNhCMiaIBAdWxae1VdbI4XL0CgPWkP379qzpM0jcbuZV8xcCbVIAgJhqx5ObWfW6G4QlJ+V/mS
	RXESxrxmgOYPqUcmxv/QFzFlWbuThPUM=
X-Gm-Gg: ASbGncs7/5X0EK1x9KheFMsO15SjDSgbBDK5Trkz9IshjBYD38rRw9bDEQ3fkX5HSjF
	z47zTd6w/z+WAV3Ib2zHHiHg+ggTRCAZhIJNd0t+49OpCcmC9evlEfPMfWRh55Y2iM9/NoZquPb
	f3iz16nitGFXChwGIPbU9jU5vFjrFtllSEko33voCZnR32xg==
X-Google-Smtp-Source: AGHT+IGES8hD189zVYyWtpyydz601Uwzv0yWfSFjcgHFrJnEFiVlWr4awbyARjVyC0Qmes99zkOgUoalvxOueKUs8vs=
X-Received: by 2002:a17:90a:d606:b0:310:8d4a:a246 with SMTP id
 98e67ed59e1d1-3110f333de1mr14062468a91.1.1748260403786; Mon, 26 May 2025
 04:53:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526013731.1198030-1-pantaixi@huaweicloud.com>
In-Reply-To: <20250526013731.1198030-1-pantaixi@huaweicloud.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Mon, 26 May 2025 20:53:14 +0900
X-Gm-Features: AX0GCFue50ON86AAW6mPPHdQEVwUBXnvQzLEZz33D0IhBo98NIUPFkuG7CTaGbA
Message-ID: <CAO9qdTHt2vSRhajEYEsaTJRB8yi_5sjLUq12W=8uKf=DnX6PSA@mail.gmail.com>
Subject: Re: [PATCH] tracing: Fix compilation warning on arm32
To: Pan Taixi <pantaixi@huaweicloud.com>
Cc: pantaixi1@huawei.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, yeweihua4@huawei.com
Content-Type: text/plain; charset="UTF-8"

Pan Taixi <pantaixi@huaweicloud.com> wrote:
>
> On arm32, size_t is defined to be unsigned int, while PAGE_SIZE is
> unsigned long. This hence triggers a compilation warning as min()
> asserts the type of two operands to be equal. Casting PAGE_SIZE to size_t
> solves this issue and works on other target architectures as well.
>

Thanks! I forgot to cast PAGE_SIZE to size_t

Reviewed-by: Jeongjun Park <aha310510@gmail.com>

> Compilation warning details:
>
> kernel/trace/trace.c: In function 'tracing_splice_read_pipe':
> ./include/linux/minmax.h:20:28: warning: comparison of distinct pointer types lacks a cast
>   (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>                             ^
> ./include/linux/minmax.h:26:4: note: in expansion of macro '__typecheck'
>    (__typecheck(x, y) && __no_side_effects(x, y))
>     ^~~~~~~~~~~
>
> ...
>
> kernel/trace/trace.c:6771:8: note: in expansion of macro 'min'
>         min((size_t)trace_seq_used(&iter->seq),
>         ^~~
>
> Fixes: f5178c41bb43 ("tracing: Fix oob write in trace_seq_to_buffer()")
> Signed-off-by: Pan Taixi <pantaixi@huaweicloud.com>
> ---
>  kernel/trace/trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 5b8db27fb6ef..766cb3cd254e 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6824,7 +6824,7 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
>                 ret = trace_seq_to_buffer(&iter->seq,
>                                           page_address(spd.pages[i]),
>                                           min((size_t)trace_seq_used(&iter->seq),
> -                                                 PAGE_SIZE));
> +                                                 (size_t)PAGE_SIZE));
>                 if (ret < 0) {
>                         __free_page(spd.pages[i]);
>                         break;
> --
> 2.34.1
>
