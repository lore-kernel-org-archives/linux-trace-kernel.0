Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793970848;
	b=EbyMFhVpnMC88k6MjzKNsXDwmOeAxzuBYRWYjQOY/r2z4e4kz6H+6WBC9hodllVXO3ll
	 f6Ndy0ez+Y85bKaW8KFF/hJ/ZtCKWP9c4D4v9mOISwU/RVrdf7Mxl4DpRjkW5mZ0yTKAl
	 YXC396gny5kzQOVobT52mzI7ojCxR8+8puUTyeTiQjuboZSWDgBXOmNIFBh4ki1XefLv5
	 uEeMHc6iMU9+5pAPc0YNCSjw86YHaYN8PwVv+Uy6EO6ucePjkZDAKNsbru6V0ZtP3jQiT
	 ya+vw0O8h24KqoItvuLWX3pZIywWw7OfhAFR2z+H+aQRNQ3b8mrOpyHAZgS3fDZ+kbw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793970848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=XDj4Fz5MI5W96I8a8smZZO8uw7M1JDn7fdBwlab3epA=;
	b=Q/C/q8VyFeXSepNifjxJ92vSHHW203gN86N4Oakar6pIjsOms/NpqXeU/Um1VT2ii/pX
	 DO7/mLKlem84Zn37ULawtdAnl+qlqi8aB1q/auEMJQSngGqefRq1CRmkOhI60s6nsIz9b
	 97fV4F1AXC7nf4IAue1qZpE6NdRrB5GQXfyUbMAQ1TagdnVEeRYH+QGDaGpPjXb609X1E
	 n3LY+HRIoVfa2CaW+OKGeiOs4UpNAc52ZR828yiAmLyiSO8sBRVkeRG+z0dqS+bxGfS4j
	 0+LVx76sz0IrZS+bR1/iYwkkNuOpFTHaJaoHkJmkNB/6PVgLT++0S3wxgztnY91FZBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rwLt3FRK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A1F606A32F
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 13:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63A1F606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rwLt3FRK
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-84a248254f4so375253a34.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Nov 2026 05:14:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793970847; cv=none;
        d=google.com; s=arc-20260327;
        b=Wy1VmwEAbZ9yhqlmrEMAhzZz5uzyMvROO2y3DVKpA/+8dZ8fv3rLnxgAYnjEQ0hIS9
         XiKM3Wmdxs3Wcw6zHje+5/TKCXsoe5hGukdKtEaQRGj5i48LzhoSokPnA3aLYWbS0pN1
         br+Uvwzwypmf6dk1YuV0MVPW4kMA4Ucx7kdw5UAanxVGJGWsVMLQbrFuz1++5xBbyBon
         lmDqSYlg1bY5OZ5GJlqcWZHKO+2Tmmlv0ZWEWHfYO/HxDLzECR57oq23jDNdAHuQ3CtW
         VTKxNCmpQyauUa7C29lE23NI52TzkQl7AVZ3GBn4xA7lqEaJR92okbZcTiZUs657H7uv
         ViqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XDj4Fz5MI5W96I8a8smZZO8uw7M1JDn7fdBwlab3epA=;
        fh=N0gQdqdkXvdSSIRtWXEZS5auPR52rlsL/dMFGhk3XaM=;
        b=K25aADHbregCfLYt8ypcjgColDdPmHG7B2sL7A8OVcT7+3gtDMJ5uzVCSwk50grJxz
         G1gzyYtOJEKoRzR4O89/cJw2mdGJb+DyX97Ls+sSXGYMfd0z3DCVOWsezwjtM6GboVjG
         Ov89kWTYbLEMkwwFSQq5v4+ZFmULAPvCz83UM9LIcLnLrss7cLswJrG5dxv9hZsRewzF
         1P4AQL0VpmIQhMBVrOCeSaf9rYcb2c3hUdXmPnWZxFWg/LVZl1kHwcnNpgBNsuSszbo1
         OOBjvtWA3arlWAa8/D5T44a05r3VoNe1oKKXuDRUWq524r6TdlXE4BS6UgkYCWTgm+WV
         kmzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793970847; x=1794575647; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XDj4Fz5MI5W96I8a8smZZO8uw7M1JDn7fdBwlab3epA=;
        b=rwLt3FRKaib2TbFpjgr7R2B5jwDhmJgnrUZ42NuQTG2wKLmY+40UGIeF45BD/GISqz
         BVCDKLRZanqeVQh0U2YPak+Nagm4TNbvzx4lNoku/O3YcapsvfHeuqVgZ8lZ9gA7WlBU
         FtThgZOryzszqriE/hmExA2KW5x9QEJNz9St9K9EgNa7C5b2xz8EWZ/HwOJoESAGpWfa
         G0qvPeEMgkiD581SCsW0KtAziRF6vwQLOlO18x/nYsmxifFXTadrIlP6QuDcaf2YDHZc
         j5T8pVmdZ9jMtoWdLD0DU/h0oyH8GLM73WauVLnljRW4l9KCeSuj1/nKXhsG5Njuho6i
         iQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793970847; x=1794575647;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XDj4Fz5MI5W96I8a8smZZO8uw7M1JDn7fdBwlab3epA=;
        b=ky/bnUZumLGanWhHSEp0y/F2Wi7IQZEEzqGQizfusW/DGozi+uznD3ZXo4+H0dGWz7
         68NmIHLIxh6l/RBNzj0cnycNSFFfwudpQFSk4nYnFyIODKwiwL/1H4p/+iGycsMTlr/G
         dTeikK6/g5Q97sbsiSNU962vC6/AOy0mkDlpgrN0ehwc9QBBwvY0DmAyRMVb5DmQdsJW
         muzBNrWTGZd4eiPmectkgGq5icUpUMfF05FN6xutJGn1JYqmJXzsrLrR7nlUPnPbm38M
         dDTc76dGsFjwPN0tainVSLpetnjdqi5VkIl887tcXJk8RrK+L/UJagOc3scPMRNwpDYb
         YdDQ==
X-Forwarded-Encrypted: i=1; AKwUvBxuH+ZyTaKxlxH25btBdTkITGM3aoRirXq85hvO7hxoUN8Xe3ZbLF1ybCwDEStFLl7gCQQYMLSpuDcBwNhYsRCpbps=@vger.kernel.org
X-Gm-Message-State: APuU4Z/p67lKfFgYt08h0HYeDcM95TaP3vcWuECyYY9EFsXSgiytWiqm
	0QFxL99Qm/g3iNIGbxHOyP50EdHgUi7Q3/YgytYLxTB9+PCpGS8VGI/zj/PTxhoGe5DW8iGZIXQ
	4qIDnclk0mi/RN6G6HPdtMFSDcs6x3g0=
X-Gm-Gg: AYBFou0zfe83eiPn4CGypTUYR1fs5cPXVu35eL6Gti63/lNQ6iJJ6dsaLpTK/bzCW3w
	nn+q3pKsVCx9b83fLTaogPuyi4wCskSGBBZjS3soHkm9VbxpODeDsYsKOKGtAlepU7VqkLSwp2G
	qHF0myOsai15L1Ceg0+PUAdCXJg2fOA+viJ1GNfexbRgGePPWROcaqbixRUDDOuKvnaa1dYOzGK
	0S9AVfqJLrvAWxLwfxYw6Gw0O/w0yHX2YvBdv5iwJAXVGzbotMjZP5ndTtsW4sT7VGov+asKC0M
	xIxh1fh6veOo48fBrAljoYEGw272kghATY2uMZVaBr/WQBfiZkVCWa7HCfjcaUT5IKdtnfnVcg1
	U3e3x13d2hu09jPu/KYTdyh749ft/NjnDL2OvBm0jCGcmhdpSR9hQqNaM6vCPewLD6dkZfC1kKZ
	xfVY1a9j/ZB8PVhSCWow==
X-Received: by 2002:a05:6808:4f6a:b0:4f2:ac42:656b with SMTP id
 5614622812f47-567e098b95bmr2036164b6e.7.1793970847328; Fri, 06 Nov 2026
 05:14:07 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261004-ftrace-mod-bsearch-v2-0-c1de73e72e73@gmail.com> <20261004-ftrace-mod-bsearch-v2-2-c1de73e72e73@gmail.com>
In-Reply-To: <20261004-ftrace-mod-bsearch-v2-2-c1de73e72e73@gmail.com>
From: Mitch Hen Chez <mitch9654@gmail.com>
Date: Fri, 6 Nov 2026 14:13:56 +0100
X-Gm-Features: AclHuK-4pAGkIQBSKZ8F_59E3K5aQv6zvde8cyI5-gaZYBULE-9BuBhH3eqMpKo
Message-ID: <CALr3rD93RT_=w8VB6aKfuV5crbwXK4Tffq9bLD=eJBj07Tv1=A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ftrace: Drop weak function locations of modules
 when loading them
To: deduce@gmail.com
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Stanislaw Gruszka <stf_xl@wp.pl>, 
	David Laight <david.laight.linux@gmail.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hey crew :)

I was also seeing a stall (~2s) on my Fedora 45 machine, and when I
applied this patch, my userspace startup time dropped from ~4.5s to
2.4s.

Hardware: Ryzen 9 5900X CPU, RX 6900 XT GPU
Kernel (base, as well as patched): 7.2.15-300 (fc45)

Would it be possible to have another review pass on this patch? I
don't want it to fall between the cracks :)

Thanks,
Mitch
