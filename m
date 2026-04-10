Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1271DD0D4
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Apr 2026 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775825218; cv=none; b=rG4NqJk/nBAsWHSU4noVOtCe1WBx5FCmp30pQuOHN70O5x4pZ3a83GZ4CmMxPQe3IFG9A5kl3XKZBVh7BOnaFIpJweFSlgm1vXRrjStxnkDEex82gNZ6+ELuCy2lLDwiJJtMxh1136UKKriXS55etmBiK2OM2nUDpzC/Z2ANfNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775825218; c=relaxed/simple;
	bh=UiG4yHUwYikgqMByAvWLqJ+G1mR3bcCQ6U10nnGXNm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+Elg6StORfF1LxvqZE6HzvBrLW5nqacUPhuAcrFLk3D7KLemejlKJZGwLVMOBa2LSSaS4UsF+YLO8mzTeHRcl0YVPxcqvlm6tzLlSmDKuQJcasvRGe+kyzcYbU4CvY1PbmmTKBe+93JCtzuB6yIwXIM3CQ9AauxGO5LrgSLZkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jChmAZGH; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jChmAZGH"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-66d24c6963bso3519480a12.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Apr 2026 05:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775825215; x=1776430015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iD1Gru4E4GCn+KUuiU59fyOxdMeWJaLwzenw6NOVkUU=;
        b=jChmAZGH/obpoo3e/AgyjPTiqZh7gPzf6KGf2SyI0Uc4s8q4+jOTN6Zal4e0Bj59cr
         +2wp/1NOko9+aPDu8qtmdpX02b1nft+6IpLjF9sv78QQsILy50UDVQU6K0GA+Ry6PixD
         1zuYPNRauiOLXvBh6MWtpVT08PxZtRCsmzepgSMhAQNcvg9MrwGoryG5hfSAqmvluUDr
         rdOERi2cMQtfDi3qXd4K7RGUY7uvL/BToz1uRpWq7TF4Q4HJZblA66ALRRXwxoFHc4e+
         g8MnGulHlDnHa3vHcsxxhhRiIL4u/jdZBD93Y74xv7ZpiARvA4N44X4QBDjP4lCT9FtQ
         kQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775825215; x=1776430015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iD1Gru4E4GCn+KUuiU59fyOxdMeWJaLwzenw6NOVkUU=;
        b=LluuxcnHK58IbdOlUmD+XdCHZ1gDIk7g+Z4NcyzeovOBYYI+ibF7+OpRIwz0nroRTV
         gLiK56iEFJXaUJRIEK/ZGy++1dc64jMfdrJT8p8W1Y/FBu8cwuc/BLEZdjyGKK4qtfjr
         TKUs+EaIg6I6uTvayeABBlBmMJDGT3W6jO2HRcED5pi7fwXaGB0dHPI7X1uA4lPA9SKh
         jxxXMTQ40rNWBZF5Ktcuqid2oFEm1fLJAHXiHU2SY+QaF0/EXJzLTXUwGDPE0AnPTEZ5
         bICviPEZ1TBhLWw6qEJCkklw+gXVx7WJGiF4NyXaBD2ivh4dYjWS+AvlSkgmX7B6NvL7
         wTpg==
X-Gm-Message-State: AOJu0YwPx/YqOhHgf68mcjp+JYyY/o9Snc3BYw32Kp9E+8CD/kT9j3vK
	OTfZdneJqhC7VAUplvDjc3byP2h9gKdyiZkWyDJqKdZqZFlog422fmkQ+H1VUXGB5g==
X-Gm-Gg: AeBDieuEqFhJSw/fgUb1HGx/mmjdy5PAcvuJ9nhznPoYWLNsZ2ugb/F/N1h/uqZkPTM
	gjxDKaA/qk6FiDY1aUhMIAb6E97ZN59Ys7nOVbn5YSxQD/FTXAOiVDsREReFiJ+nSwELq1hqhdV
	0xOEM3iCJ8Q4HPDFx1vEsadokTh1CMsYcpBgwCRqK0dRmaM8PVrq4gwGFwYmCgb83zW8hg+0Lgx
	Xe8KgA2BIzqCYVzTW2CZ/qC7kUs8vhag9sRz7ZEQXsAuVvMdOV90X114I+K+sGcV+6SaHp38V0S
	Yw5LxojbVLvlMiT6uQrIm6DZZkMxR3PNetyfxvKEZesgosY3HgQ/qEwgZc6hlUsImPNtxJ2QXOc
	ZNXe5yDvF+njdtWSq18xSuNgBwmWqtN1OAdDXlZtVtHr6tvw2R0OhyqeMowng+1TQnyUBpZRQkn
	c745RL37xxNhjAzYD7+i1SM4ixEaeUWoXZEd6KRVfuVEUSwdsRg/NEWVRm6Adt+5vpE2BEm3iRR
	PEMBg==
X-Received: by 2002:a05:6402:3506:b0:66b:f154:2e81 with SMTP id 4fb4d7f45d1cf-6707af159a4mr1548801a12.20.1775825214721;
        Fri, 10 Apr 2026 05:46:54 -0700 (PDT)
Received: from google.com (198.115.140.34.bc.googleusercontent.com. [34.140.115.198])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67070826607sm538044a12.27.2026.04.10.05.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 05:46:51 -0700 (PDT)
Date: Fri, 10 Apr 2026 13:46:46 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Dan Carpenter <error27@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [bug report] ring-buffer: Introduce ring-buffer remotes
Message-ID: <adjxNnzgRleH3ll5@google.com>
References: <adjN-1ydA_kPPhmG@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adjN-1ydA_kPPhmG@stanley.mountain>

On Fri, Apr 10, 2026 at 01:16:27PM +0300, Dan Carpenter wrote:
> Hello Vincent Donnefort,
> 
> Commit 2e67fabd8b77 ("ring-buffer: Introduce ring-buffer remotes")
> from Mar 9, 2026 (linux-next), leads to the following Smatch static
> checker warning:
> 
> 	kernel/trace/ring_buffer.c:2243 ring_buffer_desc_page()
> 	warn: array off by one? 'desc->page_va[page_id]'
> 
> kernel/trace/ring_buffer.c
>     2241 static void *ring_buffer_desc_page(struct ring_buffer_desc *desc, int page_id)
>     2242 {
> --> 2243         return page_id > desc->nr_page_va ? NULL : (void *)desc->page_va[page_id];
>                                 ^
> Based on the len = struct_size(desc, page_va, desc->nr_page_va), in
> ring_buffer_desc(), I'm pretty sure this should be >= instead of >.

You are right. Thanks for the report, I have sent a fix.

> 
>     2244 }
> 
> This email is a free service from the Smatch-CI project [smatch.sf.net].
> 
> regards,
> dan carpenter
