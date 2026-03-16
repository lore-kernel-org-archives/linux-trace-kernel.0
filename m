Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C05434B438
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Mar 2026 21:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773695771; cv=none; b=Sg/VdMwFkG+uJOktotHft4rIokLowGRsI2nYpa5t3VthsXcXnLExwHh7Rdx3xkaoTthrSmZSS7dlpOEBnB40TELnNtmEqor5m2Gj7StIAQboxKXTcK45GzqnNxFUw8HhSSOks4TGGzIQuhm3qlxVUAVeqDA4/wuc71+IEiRWzfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773695771; c=relaxed/simple;
	bh=W2AnyyzaVV5LaX7Nb+qLh90OipqRJZE0wUkUehV2F+Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0AF7j8h609dlL5BgMOlTDfuWHzGt+vlBcUtgs5rdXZwpy2q/PYpuBoywbZj+Ya52/RkJlLiGq/wvFmd+FMyndlwBS/jt5T+CKX5fwWOkONazv8uJ+nGj3lT9TA5Fs7lgQznK1FJUS2o5trNiLthclYj0UnMOpZTsAoIJaorOGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RquvFETH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RquvFETH"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so44282895e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Mar 2026 14:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773695769; x=1774300569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UySVxzfXOl+RhbhkqosIKwS0W/gUxRLNLq3WDoJufTY=;
        b=RquvFETHNMngD0t+wniVYoiQZ6Cuz7a5U2t5DdpvtTQexrp7X+PB57u0iGs9xWynlb
         supVO9eaB+k8jxVD5b4QkdOHrezpGWc5SHPvs9oDZSDUTEAKqU6JbP8W63e59arJupG4
         C4JSaSSYkI5MqMtxqzg7xdic519P8JRt4hs3FMZLWTwmaUzBKhNuRIU4NNBVkdYRxXiM
         LmhZsdbkHsm5J0uZFQDVs+HKxf4C51InxY1x9iCn9MkYPZ5WdPmbkRRvuEv2rciX1l3H
         pwLkmlqEbsPwkUulELyHOHXYpiMIm61mkY0xbc/nJE9aijs6zUf5uigxr5lVoe8Zr2wB
         gITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773695769; x=1774300569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UySVxzfXOl+RhbhkqosIKwS0W/gUxRLNLq3WDoJufTY=;
        b=bqA42F780pOZqzmNhbDX8qQ3WxTiQtA9kRpcUkeVp6GiMpjm+f1BjVacw2cAVVEv93
         3tp971MbQ8jgBWZ3fLr+VAyF21F0V1YSblk5unXazCmdP1vx0wOBSdXq2ksRBc55diSc
         UEn9owjLkHbEnK5dtCWGFt+tMESNNgupth6NwtjGWnyhndyM9Ekro+Nc1S40tJYbxm6j
         FrUjT6+lPIpCMsgeQPxXyFzWkpB+oKqRErbpsirJjCvUtpx5zPkDrPgdATK70wLBCyko
         HzAiy1/X0Pdn9/Uh+E1wIp2WbXC02FEbRjKJBo7UMeRqZ4g9K70fkecqNargFnbytJZx
         FI9w==
X-Forwarded-Encrypted: i=1; AJvYcCVyF5p1GdsfkRWs6sIlXuWgl0ZSjP63ce/bMiwqoUwkrGfHYIZvcHW3UDZzuVus5OJI/xM6/tEG680ILDxqPhwPa7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzalym63x0wup0CQABzG2avvw9yIuhPPPyJAMmTjnZcCVup+fSq
	RPnRuKxvvSIYuRraANJmDLj0OZEMKBTcIDCKU0qxuYEsHT8QrtlT2cGc
X-Gm-Gg: ATEYQzz3mpbMxotjtTA9ZocGwnmTlJlUfoVlBeD1T7lbVyGwnlFRif2/ykuG42X88cc
	aNTr7LqNr27ESzANknnlLGrnoMciZzwfzkhMLurV1J0imXbHbgnzIs7z0zwMkKHAW0udOawkONe
	z3EcRPfLTKgSHsXlzkQayAihTAZ+s8+bwJ8mSViM83EoH+O1//Na88A5RT7oti9dZUTCqLyy89W
	F2opAjR6EC71l2D8X30oNfpFjXg7iLHpdVbGndeXiJQd4jpQLin5A1ovWGZXYZHX5MG0NZ/niYO
	POWMnCO82N2mYKVvpHcUquHN/ojRZFGeE26NkpgL4PAFGXQ17uN0Tn/3+1cXZ2CGjMUaVZmdv4J
	3gjPBENICzseM5GGTuUln/ofTsVE1Y+ppj4fLyB3pFAk23y4PmObwVj+E2w7FN4oUWwYoT+OHjz
	Ks48lN9cHkpLk=
X-Received: by 2002:a05:600c:3b14:b0:485:3f1c:d8a4 with SMTP id 5b1f17b1804b1-485566d6e54mr258332965e9.9.1773695768633;
        Mon, 16 Mar 2026 14:16:08 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557a73a75sm98824365e9.15.2026.03.16.14.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:16:08 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 16 Mar 2026 22:16:05 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv3 bpf-next 16/24] libbpf: Add support to create tracing
 multi link
Message-ID: <abhzFaNiuTJJhPqA@krava>
References: <20260316075138.465430-17-jolsa@kernel.org>
 <46d7ff451871969354eeff0215fec41d41f1587deb6b0944f8f38184b715e2f3@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46d7ff451871969354eeff0215fec41d41f1587deb6b0944f8f38184b715e2f3@mail.kernel.org>

On Mon, Mar 16, 2026 at 08:35:12AM +0000, bot+bpf-ci@kernel.org wrote:
> > The provided <pattern> is used as 'pattern' argument in
> > bpf_program__attach_kprobe_multi_opts function.
> 
> Should this say bpf_program__attach_tracing_multi instead of
> bpf_program__attach_kprobe_multi_opts?  The auto-attach path in
> attach_tracing_multi() calls bpf_program__attach_tracing_multi(),
> not the kprobe variant.

no, it's a refference to similar kprobe function

jirka

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23133791558

