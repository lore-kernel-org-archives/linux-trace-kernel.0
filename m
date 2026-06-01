Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2438E2DA75C
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Jun 2026 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302697; cv=none; b=CmFMMCe1Ck0VZJk9ceY8x9GBRYSmCf7BzN2LQ66TMLsHQ7id4hgb9BLuOXPh6H1jyi5fcdFKBumqdxjMvJfSGn3SDO3uLy0GD38e4W95lHJ5yntPGB0ac8W3nECPvReKhrWlxmTcFuKVsVWU96m+CwuQCAzz5Yl/JzFoySXY1Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302697; c=relaxed/simple;
	bh=iNvpJG7E1ziR3C7zfQSDCsofJj39lDOjSN2/S5E5GPE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wf3DaPKmWatiBdoky87UjH1G+WDInPFTKGj8DTk7q8t99OeEF3BIGtNuSOOLO6pId4h9qwOSuS/h8ELn3gjQ/bQEdJhZnQxxBr3n74bLF1qU3ZoTMq6tLx6xCoOBJXEBV/9UCFzy6n4V3CBleMdJ5jr1dcXZPKiAvRMfIxE5CCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KK920SHO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KK920SHO"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490686877a1so55805985e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 01 Jun 2026 01:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780302694; x=1780907494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i5zmSSlKo4hZN0RfddmedFqEkVnWBhlYoh9eeXOlFwE=;
        b=KK920SHOxOIKLPnvaoz/gS5OMtbmr0B6wF9I3krENh+5CXvxyMvBOpyvUcASJOuzu1
         Jtw6bziz4EQ3Bc4b/C8MZdULtT5IBzgTml5Ycj1WDDFlx47jsETA9tmciKOYIgtUoP8H
         khuyUr1ksWQmwSac8PDn/6TkG1sdKZ04x+bR5gBfOp2ozPQ8F4LR+X21sPpVarGn9jFW
         YBCSrXmcoXTuhUeoTS5vMyHrKuTrW7MS0MVTZoHhxSwckZjdXcyyQc4FewzlFMFeYk3F
         qi0y0p4BEYl3fhDLz2Jwh1hOraxW9h+alA7Ltjuixp8JciIz2J+atdacc8fc17j+1ok4
         v0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780302694; x=1780907494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5zmSSlKo4hZN0RfddmedFqEkVnWBhlYoh9eeXOlFwE=;
        b=IUeAaUURHHET4Id9CmbdARp7pY8tO9cgb2eVGpxiGQnWTKIuFdX+zVONC7PETVJDu9
         wCsCrrohTEeTGC+XG5ERAigAnKO7KHV5+nrYwzR10k9Zg2Yw2gVqPNnR2p3vW9O8iZCL
         7Z0Vo4N13BZiH0Q0Qtx8o5RufFT6AFZcZKTzycrVRLJfI8ujFymeuqnOtMSYUfjMRO6j
         FUiCz6fkKvI7OU/rR+o6pQQKiCmt7b2CK1PISeoEhrBQ3SwYN2PCn6sq6Z0/rKFOUjEZ
         7hYtoHteZGIWD91+eHZbPllbAxHc9OiJ2QTCzLQtN7p+Mo8XcnBII1C4LRQZaWluKjN9
         XQFQ==
X-Forwarded-Encrypted: i=1; AFNElJ8TUEVBnAX7PVg8nc2o6gQ251/E5ug4I/h5uVC0R90dZ8p7FQa2R8aspekCepfy05WZKG1Mj1ben62fyJE4zX2fB5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8By+VIuUq+k1Tv3jVPH8znG+vlEU6OAb2mUR3LWyyuIb8Ffq8
	ELAwNCnfB7rN6WKwK8+IE2FrBBnlr78xjeCeUYNGQdCHTELCDKZRJjDq
X-Gm-Gg: Acq92OGVZQyet0/g693QBy5JWk0Lzpb2duosPI97eqejVoKVcggmNTOVpRSon4DPzee
	OiJErt3UdZGTbHgCHpv6p1+8LrwJCCMPIdMRXctXXLAZKwBiiJQSmAC9dfVLxHuFevwDJropq6K
	4bg6rI1ZuijydBkMh35CgkjVyjo2gmVYBds/iyG92AHY4+3E7454wixsRzBWCfXvokFmr2+qsPG
	1cN2WR1NEKoiujwZzSqYnrXhVJGEitErprMCXGwTvofcIpRFI6M5NQGBaziOOvTm3hOz5yZogAL
	EWYlqbEqf0y4D7OH9fBGt/QBscYj6VTUhofBHFx86aXtuK7sPNMVfYL1lWviEq/3+NMRKieVCsu
	y9hOi9lyO7KGNuFm73w19LDTj9a4BnG1KDDdi4B98tOrv/lzFTjQoxVVWZtB0Oon1L3EoAUNZ5c
	L4KGbeeTqby+0ta7QOJMRHZT3QMw==
X-Received: by 2002:a05:600c:45c9:b0:490:8b0b:d3b1 with SMTP id 5b1f17b1804b1-490a2a4bac0mr139388825e9.12.1780302694364;
        Mon, 01 Jun 2026 01:31:34 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ae24427asm6345985e9.6.2026.06.01.01.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 01:31:33 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 1 Jun 2026 10:31:31 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bot+bpf-ci@kernel.org, oleg@redhat.com, peterz@infradead.org,
	mingo@kernel.org, mhiramat@kernel.org, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCHv4 02/13] uprobes/x86: Remove struct uprobe_trampoline
 object
Message-ID: <ah1DY06p3QN2nHlm@krava>
References: <20260526205840.173790-3-jolsa@kernel.org>
 <22e6111c3aa950ec8eaa29c776670e6f834f82249190a652b2afa9a9cb551d76@mail.kernel.org>
 <ahbAXMH-R9Sk5N_3@krava>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahbAXMH-R9Sk5N_3@krava>

On Wed, May 27, 2026 at 11:58:52AM +0200, Jiri Olsa wrote:

SNIP

> > Although the old destroy_uprobe_trampoline only freed the struct (not the
> > underlying VMA), the new code appears to introduce a VMA leak: the freshly
> > mapped PAGE_SIZE special mapping in the user's address space stays mapped
> > even though optimization failed. arch_uprobe_optimize() then sets
> > ARCH_UPROBE_FLAG_OPTIMIZE_FAIL so subsequent calls won't retry, leaving the
> > orphan trampoline mapping in the address space until exit_mmap() reaps it at
> > process teardown.
> > 
> > The commit message mentions: "Note the original code called
> > destroy_uprobe_trampoline if the optimiation failed, but it only freed the
> > struct uprobe_trampoline object, not the vma. The new vma leak is fixed in
> > following change."
> > 
> > Is the VMA leak addressed in the subsequent commit in this series?
> 
> yes, in:
> 
>       [1] uprobes/x86: Unmap trampoline vma object in case it's unused
> 
> > 
> > A secondary behaviour change is that 'return WARN_ON_ONCE(swbp_optimize(...))'
> > now returns the boolean truth value of the error (0 or 1) instead of the
> > original errno. While the current caller (arch_uprobe_optimize) only treats
> > the value as boolean, could this surprise a future caller that propagates the
> > return code?
> 
> ah ok, this is actualy 'fixed' in [1] above, but yea we should
> fix that directly in this change, will do

nah, it's ok, the caller does not care about the exact error
value, just 0 or 1 is fine

jirka
