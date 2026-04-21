Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EA2397E91
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Apr 2026 08:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761753; cv=none; b=IhQmw2t+k8l0gWJ5EeTeK79qWUH583bth5mAJoDCYjtRFNOIUX1vG38gKLLDkZhKD4WuKpLv9Qg7W/YiU55T1GQ0Hxtnz3F6O+m5mRtxX6vtCm0QDXW+dmV7yZ+3rBKzXzC/T0yjFbNblgHcp57BUrXIzmp2qGAZ0K2cYPeyovM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761753; c=relaxed/simple;
	bh=AZDR1isMFQyNKFuybLOvsuw5gIrf9qlXU0JZx0dpqaE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VT30IP95sfdGNamIkeWVnOhkWYfyAHAkikh0ZJUalvhw9nxrF2hZOYg+UaVgj3o7OHqj7I40LfVrZ/AM5BjdzcYjwpnoV/gJpmW6D7FG4/v3BLEbrao9fakFDj8f+p57+QiFzlh2nadFbPDUPFevX/zw1Rmd0ckQ+i0/b+zRXL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4WNNxyU; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4WNNxyU"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43cfbd17589so3029300f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Apr 2026 01:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776761750; x=1777366550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tvcz5hSAoObfzS42pi+saOECAJRoncopu43VJxoiKms=;
        b=A4WNNxyUNATfj3IlyyqtWNY2UoeU0VO/XYM8NuelQzPdt06Ylaz1sWGzoem88z2gQ7
         D+yDCvV+HI5srFMWyONvfL+XmUl/Wdvj74OnVeICk+xfO1NEZd1k9Kx/QNmvEFWzbc/L
         MD1/PF+Nc7QUshOYMbxu40TuUs01J8oq4jix173yUptxxnQK3kejFDk9/5UKDRvRnYCT
         dNzieTwjehFMyzeE597AqK98dcQbcFNE/2yGBSH7aY9tal+WdLl4+1Pxa6d3ibqJQlQ7
         c313/weIHtMpGaeXlm7oL2pPqTipZk+JG3DLkkNobgBLyRsSalr3iYq8B4YseOx9IL8f
         /C6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761750; x=1777366550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tvcz5hSAoObfzS42pi+saOECAJRoncopu43VJxoiKms=;
        b=WGezhQH/WEBoX2YVJFEOPnl5pOpIQoRdt5chIzlEv55BAnK74KubC+da31pvzdTL0m
         0BvHgWcDveC7dyUbw+E2SNP4TBXaPENYYPEelGx088IvuNHAOvPSCbXOEBznqX3g5gGF
         rWutKxNQKvljSKm6NdbcsS/i3OPnn0PBV5Taz5BsRWt8FGYZ7dtTncxS87ooQYtv2h+N
         7yHJNkauLzF4Ebyxo+NeZHaCjfqNCUYMydlkxW0ld9X0VSvxNCuOImvkIJdl7+z4meG8
         XwKskoqU3lv+wlWNYQySSwRIdwCI/mbYrceaIJIRw5sDWpnW6bn7ND54vbqjqVjTNay+
         7NwQ==
X-Forwarded-Encrypted: i=1; AFNElJ+uagjgOOJqh8isyD2b8VGLaNuwbcnYH0zb9IEvT4ukFf+dVIrDvrsYoG2k6waL2dD4UDtpe6G1d7VsxEYuzc6Pj4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh/hPGVOeptCPLzKq+zVSzkTExT8Ez4b3zeI0jMyNq+jm4HKYg
	LO3Nny3vDrhar8uzyZ+wfIMVFAoMkB+gWzcp2FRMCT0vKvb5BSH7Abak
X-Gm-Gg: AeBDievyj1U/7nqRIVkmxOvGwfUHlENqD16J25WIFCngzLV2v2g3z1iao4Hbha7akbh
	g2g4urNWaYRM3NaWLptKWd03KwEATWKV0NPTFMitc5Yj09zFDmX+flta+olMXVzcp7/7EnZ4Uf4
	3zf6gxcS3bwHhvBry/ooyquz74VOtv6yOS61BTq1/X/2TmgBCuSqxQKt0aFp4GFDrkfIXLJQCbT
	jL2XzFpqtiQRDNS8ytQPSvEKhFTqSW40oEufahyvDBv4bf+CayGkM5an7TndDDui5cJ6KO/DvF4
	lVCr9ejZ2wmqv4vWJBOkWb5yhriIOYaurSL/kxAAWRQU6prtobd1IFPi7mU9c7dsRnJKFrY4cko
	/nVKncV8RnZ0Wdn2KRYgKd7Ow4rUVCT0aFS4nS4ooCkP/fZTCaX8egmnNOLqpwQ68ckx4S9pczz
	T5GuVOcweWe0/eH2Pwsw==
X-Received: by 2002:a05:6000:4287:b0:43f:e7c9:2402 with SMTP id ffacd0b85a97d-43fe7c9254bmr25968265f8f.3.1776761749886;
        Tue, 21 Apr 2026 01:55:49 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d112sm39816338f8f.29.2026.04.21.01.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:55:49 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 Apr 2026 10:55:47 +0200
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv5 bpf-next 10/28] bpf: Add multi tracing attach types
Message-ID: <aec7k-8w7jx9MN03@krava>
References: <20260417192502.194548-11-jolsa@kernel.org>
 <1ef3a598cb11de0fac8dfe1ac94287d3588ca36257f27b0a2407e85f5037667a@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ef3a598cb11de0fac8dfe1ac94287d3588ca36257f27b0a2407e85f5037667a@mail.kernel.org>

On Fri, Apr 17, 2026 at 08:22:39PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 552bc5d9afbd..5f814e7101cf 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1154,6 +1154,8 @@ enum bpf_attach_type {
> >  	BPF_TRACE_KPROBE_SESSION,
> >  	BPF_TRACE_UPROBE_SESSION,
> >  	BPF_TRACE_FSESSION,
> > +	BPF_TRACE_FENTRY_MULTI,
> > +	BPF_TRACE_FEXIT_MULTI,
> >  	__MAX_BPF_ATTACH_TYPE
> >  };
> 
> In the RFC version posted on February 4, 2026, Leon Hwang asked whether
> BPF_TRACE_FSESSION_MULTI should be added alongside BPF_TRACE_FENTRY_MULTI
> and BPF_TRACE_FEXIT_MULTI for consistency, since BPF_TRACE_FSESSION exists
> and is handled similarly to FENTRY/FEXIT.
> 
> Reference:
> https://lore.kernel.org/bpf/3015991d-2e9b-4bf4-9c17-26e00b5d5926@linux.dev/
> 
> You acknowledged this with "good catch, will add it" in the same thread:
> https://lore.kernel.org/bpf/aYM-jeV50WaVik1b@krava/
> 
> However, BPF_TRACE_FSESSION_MULTI was not added in any subsequent version
> through v5. Should BPF_TRACE_FSESSION_MULTI be included here for API
> consistency?
>

I think the comment was to introduce the support for fsession,
not to add it to this specific patch

and BPF_TRACE_FSESSION_MULTI is introduced in:
  bpf: Add support for tracing_multi link session

jirka

> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24583317711

