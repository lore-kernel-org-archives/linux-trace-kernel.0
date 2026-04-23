Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5F03537D5
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Apr 2026 08:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776933361; cv=none; b=AsbbA5COzdtPYBSxc3GxlQohxawwWy9zeLOmHSuXmu1gl9AX4Czyl5I5Ar1T4ABvq9D7t0PT4dxesU0A3VuItAmavaeeFJpcY/Kb/2BX12sv8fM8uXpkxtmiMQ6g5I5korCLtP30hXX+Jlu4bCWr8nmrJKxxw+LJ55n8HKQ1gfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776933361; c=relaxed/simple;
	bh=cGAg77A9vGAqO01N9puooMvj1PtUM0QhbRn4oKLxUtA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYylZTWoh2gQIU+XOEtqA/99syFvwq3R++dva4VmKxkIvp259YdRv5rgL7wJ2UL09RkCwrAiEWM5nSjRSBvRMRlTJ8xrgxU43ad0LcnIh1vFrQwqvW+6nEco0z9v+SkUadgydZzZmR9nMLYw3XHLVTsEbvJwS94ZWUgrBW0+xFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsZmm+UN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsZmm+UN"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso58698225e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Apr 2026 01:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776933358; x=1777538158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pX8X61NK9tT2Owfg7advdmy2f2BYjZERfDDXJtbjaAw=;
        b=DsZmm+UN6pd3bQ+4HicCbv9Gz0rZ7v2vHQUh/mc8Jf0r21+aL7sSHSSnCOmWiibIEk
         0ynTYj3svKjGpwud4trt8JGWvt5NIMG3+n+aT9nFiYX1nb9k5tv21YYbQe6+9zAMVdqH
         RldjEO66z+Ay17AR1XbbF/fKE9fK1KsJrVdA6c2AxxuouU7qy6q7ZIxxHYrF2t20u6WV
         cEo5/8cpXEP3LoBlyS3+9PoSme1R2AiNCCRpp03jU2uLISpx1QgdadIvr23qeSXGFx8Z
         K7xnYf0iqkqLfGiCA+dxaqyPihy6mEnPpJ6bulTC6RTZ7xAWMD9aLQal+8tFEGfix/jb
         74uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776933358; x=1777538158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pX8X61NK9tT2Owfg7advdmy2f2BYjZERfDDXJtbjaAw=;
        b=Nc2lQ+7esaMShtXr8KjbCNfTwBM2FVPLnVRLw98YTwgWDgCVPFLgifVungUmgnGzsm
         Vva5fVrt84iIaS1yOGx8H++y8CZhDz0RdnCW0ewB3HbmDUR9OT8DUsmYILNPLOLRPslD
         w7jDPr1Zpb8CnPWH8vQ9j6dugK5RZGAliayOqGnCg3mOrsue4ur/38uR+dEBb4OeIamG
         qBbj7MZ9xbuTSM1zTwee9gK0sG31Ktqtd9w98ld/QzKjQM7UBZsXXZ25vlzXiXAWj5LN
         bcihy3avy4EwtU2WvAPMaewIMfsfJSkzaquCwNU42427HvYjjQZy1Kw/w+GqSfRqYdPS
         TFsw==
X-Forwarded-Encrypted: i=1; AFNElJ/Rx54XURzpxbUPZdDvC576U+uUpGUMvzDYYB6G84HCdinDmEz8R+1Tf1hscHjNOqttThgGhkj171X4xL+96y6KlzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXfdhxsxZtCJUWO69zmzBwNfPzWmIxRbnRgRsvhXT+cMMVX5Bk
	KdgdUVYXjYuLqCr4aey0PBuMAHHDzSUAFJH6K419Lsce9KzQaJ5dk31G
X-Gm-Gg: AeBDiesNUfBszHiRXFP6fe+fsD/luYc5eaV3Hd8m2cPdCR5KKUmzzrrzG/W2bf9knoE
	vnsbvvpaqfIfPbaNSn9MOMi8GU8mkgWzVYsYNYgFEi4wQV0fYsXZnu7k2pWM3laZz5dM8BAjbSD
	9jCjaS80FdC36O0E5m6pSH0UrdW/AyRi8DmJCjt11LIlkoDM4YR/o6/VS4/PSzQFXTJbY2ryc4L
	DficqhJUl/rRMcEuAuWOFpuMsN/hcw7OXhmM/08OIVgnS9n6UDrwZPINICBMxsIgHah/gUBtpls
	ZkaB5HU1iamjttSbs0m5gHQYFIIC6pfm/HA55tbm+2IpkKUeI801mu1cOElppyTDVwCWHWx5f6C
	B5wZLxp5qssA03LX0j/ViDlpiugZyXom/eHtTtcClU7g+XrKelsulkgFS1RiDdnMATkU40M/MvT
	2CHGtPXCpYT9Ebe8Rr5A==
X-Received: by 2002:a05:600c:888b:b0:485:4bd1:4c64 with SMTP id 5b1f17b1804b1-488fb796f95mr301870745e9.31.1776933357937;
        Thu, 23 Apr 2026 01:35:57 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc100162sm518612495e9.5.2026.04.23.01.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 01:35:57 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 23 Apr 2026 10:35:55 +0200
To: XIAO WU <shawdoxwu@gmail.com>
Cc: bot+bpf-ci@kernel.org, andrii@kernel.org, ast@kernel.org,
	bpf@vger.kernel.org, clm@meta.com, daniel@iogearbox.net,
	eddyz87@gmail.com, ihor.solodrai@linux.dev, kafai@fb.com,
	linux-trace-kernel@vger.kernel.org, martin.lau@kernel.org,
	menglong8.dong@gmail.com, rostedt@kernel.org, songliubraving@fb.com,
	yhs@fb.com, yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next 10/17] bpf: Add support for tracing_multi link
 session
Message-ID: <aenZ68-4ZeNhlXr1@krava>
References: <0520af2c467a82b82aa3014b7e721f95bfde9e91324bb2e183b099e5a37bbc3e@mail.kernel.org>
 <20260423160724.00004f6d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423160724.00004f6d@gmail.com>

On Thu, Apr 23, 2026 at 04:07:24PM +0800, XIAO WU wrote:

SNIP

> I agree the patch should be made bisect-safe. I will post a follow-up
> that ensures BPF_TRACE_FSESSION_MULTI cannot enter this uninitialized
> fexit path (either by initializing it consistently where needed, or
> rejecting this attach route and keeping it exclusive to
> bpf_tracing_multi_attach()).
> 
> Signed-off-by: XIAO WU <shawdoxwu@gmail.com>
> 
> Thanks

fyi there's v5 already https://lore.kernel.org/bpf/20260417192502.194548-1-jolsa@kernel.org/

jirka
