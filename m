Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2CA38D007
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Apr 2026 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123283; cv=none; b=qnqqc2R6Qn4KmZAIgAC5BWxNgxmxR1SS2nIPH58NqewKyAJrnTbQZq1GjcVU++dfhHGeuvJk1guAId71GGKyzDPmekyPBs/abiqczLdhXmL+/VSmsgdpGj+CSnCBCTSmRF/mGKGbgPOFT1cV1D0JW4NRYlXw/nUOPudiQEErq7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123283; c=relaxed/simple;
	bh=3MNlmfskCwYBwR7CMMQW06KYDtniDQG1Ht8Ze5B6Rbs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ge6TarBVKevMQjD+Y0uuGZT2Yy2t+hEZaEKptOjYSMfb5JNwVNoRSv1gMvMh2VSn1X/qBPQuJNMRuuJN9edjSjqwRhFetA1/1qIgWeblNU7T7Lka1LlotICg3ZUX1Y+ZrYo6rhDa4I7YmYTaR3HT3Wkf0tH/IVt6FhngEbE0JKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fh2qjTHr; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fh2qjTHr"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d029f346eso661628f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Apr 2026 02:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775123277; x=1775728077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ol8Pk56vvShAuV2VIl+T3q12S1MFkuELXmy9np3CGds=;
        b=fh2qjTHrsLRpM1+CD4qYjffE3wb4ByYem2TQep3XJes8lTJnUcUvrrCWSttwuNA4F/
         bLr18EYvvpL71DhcAoKAvoDIAJnoRxIof5w15Tp7tJw+C3ySFAktUOJGJxPhXbpVs5E6
         rsedP9lLdCMeLjjDW1fW4v+qe5YivPZO5YCLNFbdNLGp3baBfszfj00pRSRYpY4/wVFt
         EW6eGPepib2Dqd7QPekbIvFd7CbKCWWsFHT3sy7rvW4VRlhYF8kmvAYZ9PkO9aiw5orf
         I3i6DkGBN5JzUWt0VDuuEsts+k9hsapTplKcbWSHJAybwkvDMuYy2VQNpMhV+hl+yR7n
         3MtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775123277; x=1775728077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ol8Pk56vvShAuV2VIl+T3q12S1MFkuELXmy9np3CGds=;
        b=qcOn4jpymdjoSvWl/E0SBV/O+QXEhublfXKc95BsjZLe2m4dfqpB2Wlt2WULpJigJ5
         ESoEsoz8T+gK14qeOfKtgwjmKE9v1ULvJhPcrmdUFa3MzcG97avDUXLY+nKSQNM8GRAc
         kk6R3zA9LkxjLc4pUblyTYLng6CHTzN2gRBLpC6LSAxlTiZ4LBRMb/ziNWsNhMN8d4r3
         07QCoH7LTjPX2hJaCRXAciegUOLmfbcfTwXTYcp9G3hF9cAOQTlIh03WoxxDIsCluEsn
         R7SOxFBWZzoiVp8hqTysyXh+PpYID3BWi3nPkrXMCHz4aGiU15NZ+8hPa/ZoJN94Oyhe
         5EMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKshBw3912TUErMwPYaaRFpe/moH4aQq/qa/D67V2aYnsPRv6p+ixIbQVJ7YL/+g7RUi7MpxywBseYFqRHsDv69J4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzCXKkWjxdIXC/axTl1/QJ52SdfwpXYTWAs0ialeeQoyC2KNID
	z2lA65ERhz9M88Bw6O7eOFAzVKi4cn9jFcnLZzV1aeneJl651ZWYCyFq
X-Gm-Gg: ATEYQzxfAUq32yzCUNKdoarN59UWDvSzvi48Ld0pMIm3UKJDoE7QTyMWHo9KaPJjSk2
	rL0IZ3xC5Z0SFSBKor+Z4xrr3Ma+2HU8fXlpTsXb5rEviic4OHbjR6U+w44TygSOVF6AoUss02U
	67QOTBd5KSQO23Tf9UtuM69stgUipL0nX2a75VrjBRAaXQxnHV9c/+6rX1Jrh3nGBezPoY1uReu
	mpQvHwgNv0x43H6XyrvncVNsGXlCL/n10KO6WVXTH2HUWhfmb4ePxgVcSkCldtX6VTd428R7A5N
	QrNsEWXi/KrklhTRrGwkSsgFrAqccEa9FtF1ZKRB+de79R1jqogDXGs6C6RFgW7Y2Jw73Az8ljp
	2NnBgPVZ5OpzdDmn25YTLP0mJjTcWrEh3m/ihprS1QtqiAqPJUhqrP1xv2e+lNvJusQZqEHp9
X-Received: by 2002:a05:6000:24c1:b0:43b:3d4f:e17a with SMTP id ffacd0b85a97d-43d1f25ad1bmr4932336f8f.37.1775123277062;
        Thu, 02 Apr 2026 02:47:57 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c60a2sm6492968f8f.10.2026.04.02.02.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 02:47:56 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 2 Apr 2026 11:47:54 +0200
To: Varun R Mallya <varunrmallya@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	memxor@gmail.com, yonghong.song@linux.dev, rostedt@goodmis.org,
	mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf v3 1/2] bpf: Reject sleepable kprobe_multi programs
 at attach time
Message-ID: <ac47SnLz6WncARyH@krava>
References: <20260401191126.440683-1-varunrmallya@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401191126.440683-1-varunrmallya@gmail.com>

On Thu, Apr 02, 2026 at 12:41:25AM +0530, Varun R Mallya wrote:
> kprobe.multi programs run in atomic/RCU context and cannot sleep.
> However, bpf_kprobe_multi_link_attach() did not validate whether the
> program being attached had the sleepable flag set, allowing sleepable
> helpers such as bpf_copy_from_user() to be invoked from a non-sleepable
> context.
> 
> This causes a "sleeping function called from invalid context" splat:
> 
>   BUG: sleeping function called from invalid context at ./include/linux/uaccess.h:169
>   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1787, name: sudo
>   preempt_count: 1, expected: 0
>   RCU nest depth: 2, expected: 0
> 
> Fix this by rejecting sleepable programs early in
> bpf_kprobe_multi_link_attach(), before any further processing.
> 
> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
> Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>

nice catch!

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> ---
>  kernel/trace/bpf_trace.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 0b040a417442..af7079aa0f36 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2752,6 +2752,10 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>  	if (!is_kprobe_multi(prog))
>  		return -EINVAL;
>  
> +	/* kprobe_multi is not allowed to be sleepable. */
> +	if (prog->sleepable)
> +		return -EINVAL;
> +
>  	/* Writing to context is not allowed for kprobes. */
>  	if (prog->aux->kprobe_write_ctx)
>  		return -EINVAL;
> -- 
> 2.53.0
> 
