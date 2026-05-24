Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1423101CE
	for <linux-trace-kernel@vger.kernel.org>; Sun, 24 May 2026 22:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779660794; cv=none; b=OlfijEo+NDvcuaoJ/nBx9XS2jLS5MQejHWrmO1heWhTBhcQfzdfppPHxHecD+LAXUX5LUXEwMXkI46TLdnhxdeKdxSLsXgUC4zYQPJi88hqm9P7Ef0cboy8aGtT3plcR9PU6+soxBKQlWA6KrDiP/VpQhrz/XtszwmJODonGeLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779660794; c=relaxed/simple;
	bh=4EV+3AHSmGaq+veCoOVFN0cd8qdhyH8Mjrda8p8jJ3U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eywlsykbQFRHDaZbq04sci75LrElS49spyN1/+wS9xvl2pLVhpQSNmvWurDTBMY7hNPmm5KtrZDrwXkPI8rjPNZ5Hs4qLCy7et93ZGFidcLZRBcqdcgtW1E3g19k/qpbKbUHrvvuUaCX+dGYZk4byNpOglmO4vjrSKGn9eCvQtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVlH0gsr; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVlH0gsr"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49041fb8c23so20497665e9.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 24 May 2026 15:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779660791; x=1780265591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h3y4KA1F5mdiEOcyagHDiVSqxB5Bc5d9TXmTdUct4Pg=;
        b=TVlH0gsrJjCR06WagR0WyZe9g1/956GsRJL0Hz9KVaXuDA5VWaTaQq2AwLYBGwOJFi
         LXKhl6xkKI5jkDQJvIjzzHtAC4IDerOkPiynA28WYdB7QP2OAWNbWB5n7ZhJgHIcXlox
         hQNGuJgb3URxEzIk5obk10hrFwQWtUV73SW/xQvSqB09Ni1XYhnqBwqQUQFLspk0i5XO
         oS17c1NSQZ7hePlnCneqdSX5SkaXo0N7i36GWKbpGZqz0Zo0pOxBheklIfIiqB+ZOjq7
         AsOZ2blwqsatg70iKaMPReFw4Gl9je/gNNi3PHcheJ2eu3N4aHcfIsUsheGmXsVprhVH
         6H4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779660791; x=1780265591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3y4KA1F5mdiEOcyagHDiVSqxB5Bc5d9TXmTdUct4Pg=;
        b=Ze363R7DtrPD9nCn8j0k/1FzBRLD01ZbCREToFE8YlCufPKar8WH3MlARFsc5sCgvC
         BVv2zI0OdvuqFpz2S4YjQIV/o6pAW09olkucE0d5mMNszKXVrYfd6PZbrtom7W7I1Wg7
         nwVMttDqHp82/L/PLQbyAvNYCQvPs9FHJIy21J6U6E10NwzowPsv35d7006rsWnu23b2
         mv2aVdfIUiA1tRAE7b3rrZ9+Cst5uqiZLhfKHB7lcjkxO2+8G3TKhizjxyz+ddSIDSgr
         jTy5o5++TM8oV1mCo2Pz69B+J4scHaExCi+Lv3Tb4GFeELFyTepyv/+zQZoMabfSsKSh
         wU7Q==
X-Forwarded-Encrypted: i=1; AFNElJ+9L1Vls7MQNaMxZoh3XAM/GbLax5Z4VsFNXA+49S6yqo6JJe/qzG6omKQx5piS9uSquBjwsITLOnQ4Rt/9ZCVJ6+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8UUNU/s4O0xNAAPu8m78VUQjAqqnDYn2SYgoUbHxJEDWOLjyR
	qNRajCoHEunDj0vENKO+ZuOPBa9gPx1R/PfdSvKNbC08v+rkwDUgVaa7
X-Gm-Gg: Acq92OESfl0jCKdB7DyJ5zhyJWdBlOBHZQqfMJ0YYriCsbnA4rFJzO0pCLc20b4s1Ic
	lOdY41cKAivDpjrkhKOIvgNLYyz6XBv+C2ZGb2KjiN1hxkEuDhRG4+XqskcN6NoErDUqa9jM9sl
	cyetXxz+t06VN6UII5/QX2y72Eq+NONgN+8PNYVrKxBQyMK4OKbLfzUYj5d7q9eGQDEWWkLhQvn
	ayiG838lXJd99yIGmlzw73y53olXOI3690eLW19fHzexjBQUzt184BjK0Uj6FNKkTDTTXM/1ZDp
	PEMLQePRSuO+nuJ/EgIYatO74jxcpgF693QMRohrLnL4CFxtQyNTowc8QJPf/lgKVFX9J0qQdga
	WgdffLL64xePBWa7qBdqEHQ2C/itTBZCg1DGS7JVj5XJun/85Ic4HMRUQ8O+e/yGl25xLmA0CTC
	eOkFy2c0bP6bv6318w8wsiaQ==
X-Received: by 2002:a05:600c:3e88:b0:490:48b7:c1ff with SMTP id 5b1f17b1804b1-49048b7c21bmr179598815e9.17.1779660791279;
        Sun, 24 May 2026 15:13:11 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5e363sm22901453f8f.28.2026.05.24.15.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 15:13:10 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 25 May 2026 00:13:08 +0200
To: bot+bpf-ci@kernel.org
Cc: oleg@redhat.com, peterz@infradead.org, mingo@kernel.org,
	mhiramat@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv3 02/12] uprobes/x86: Remove struct uprobe_trampoline
 object
Message-ID: <ahN39D9_-M6AkgUC@krava>
References: <20260521124411.31133-3-jolsa@kernel.org>
 <8861cc7af8e0dfff2674ca4ae6381ea2d82c242dec115774e8e11048bde358c4@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8861cc7af8e0dfff2674ca4ae6381ea2d82c242dec115774e8e11048bde358c4@mail.kernel.org>

On Thu, May 21, 2026 at 01:26:09PM +0000, bot+bpf-ci@kernel.org wrote:
> > commit 35d93b034b144060a547b507cfb4268692c328c2
> > Author: Jiri Olsa <jolsa@kernel.org>
> > Date:   Thu May 21 14:44:01 2026 +0200
> >
> >     uprobes/x86: Remove struct uprobe_trampoline object
> >
> >     Removing struct uprobe_trampoline object and it's tracking code,
> >     because it's not needed. We can do same thing directly on top of
> >     struct vm_area_struct objects.
> >
> >     This makes the code simpler and allows easy propagation of the
> >     trampoline vma object into child process in following change.
> >
> >     Note the original code called destroy_uprobe_trampoline if the
> >     optimiation failed, but it only freed the struct uprobe_trampoline
> >     object, not the vma.
> >
> >     Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> This looks like a bug fix for a VMA resource leak. The commit message
> notes that when uprobe optimization failed, the original code only freed
> the struct uprobe_trampoline object but leaked the VMA created by
> _install_special_mapping. Should this include:
> 
>   Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")

no, the logic stays, we just removed one layer.. but we need separate
fix for the possible vma leak, will include it in the next version

jirka
