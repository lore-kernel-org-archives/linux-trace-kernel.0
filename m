Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41FA23D7E6
	for <linux-trace-kernel@vger.kernel.org>; Sun,  3 May 2026 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777819932; cv=none; b=bbaeUJftEXHqgP2v8Ko8ji0EGdJCXmQK7UKMgfNcD87vcm6CaD74LHmjE494nGCxZ2qHgHB+bA4t8QdUFwtzf8OwUt5qBb8XgCLZziocAG1JvukaL4/lQ08QY4SazEICV95qSwX5SCcBJeULrRkeh8asOHyqxvk+OmBEkeMVArA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777819932; c=relaxed/simple;
	bh=6v8ZFVSMgrqRT7mzzytejuKpXsSRdcBCxqkImebQH8k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/HWxhqgJ87MPu5iJeFiBgwKONr1noyB1AnC816bHRZVdc/WpDRLu9a4ryPT4MJJTsCEP7ABE+ygaaoJvDF5DRQSTTcbbhA2wVFH+5wipl4uM8pfLbExgCXNrnkZSVYFFjVwNIQCrhYrAvQ3ObaTnN+Mw57J/mq6S1hcc8pMaVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sgN4xgdH; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgN4xgdH"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82fbf5d4dc2so2450157b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 03 May 2026 07:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777819930; x=1778424730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qVkyffb8Q0PGQnTBZ+TvlFrjY0CELMdRqK+yVMGHtn0=;
        b=sgN4xgdHqkUHakI3dpwsUe7ddsPilYBfan4baKyvBR2HyugedKEO9VgHwFGR9q/E/A
         8J6ZCTnYZW6OIzrXhIAOTtYPvP6+LzQSL9QHe5YcXbThZ7Fr0S3UNy2awDIiqg8I/Iog
         yR1/CrVcUnqZ/xuXgKmUQ53bqGeheXB9PbkxX9G/bc1UcRkBNGOUXP6nHAfbLb92Z3SR
         JcaeiNFRmIOhJ1jbFLNB3d7GAt6XQdauloISXh5LhZa0ZssEqvl8trIPX6/2o1VMjD0z
         RD/oN4+hCwIGuUbKumdRG8dez8TREn/EVN9pch8so/C5xS8ncd2Ujkjkvbxj6UkhjIP1
         MytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777819930; x=1778424730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVkyffb8Q0PGQnTBZ+TvlFrjY0CELMdRqK+yVMGHtn0=;
        b=Hw10c8PbANKoJAMNaKIReeD1kIiokhR8XVFwJR9tBRsmbD5cMdzBbZhuFFbYM8/gL1
         JjBEkzeRyKyzneY6Z5WabDhIWvEIDo/+XE5rivJIf9GhMKl4SZYtdLYbkLSsgOy7R0NS
         WpH0bQj8cdc4E4eXliyD0gKyQ5zv3xgJ/85gY1E0fUS9/hRo2t2WF0dKBfkToHPaibqt
         ICcZoeJn4ohkyJ4CTqKvfl98Mhd9Vp8fVnyHPtszseFH1eP9wNSzVo/2CtvQisIhWb7i
         Ql9n/L1Hn11hR2jBMkFVflo8DyUPPguUsDoBumqANgTvj0h7u54HK9ozUWZ59CU2+iEM
         Gg/Q==
X-Forwarded-Encrypted: i=1; AFNElJ9RfIqDVlaYQz94Hpkz54QFFrerYWDh0IyPjVNpvOVnmf/gAjMyBPEe4yOJ22saZiE3dHBt5Q3L7o7UktrEjUPLuS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj5s+69h3lpvKvM+H2Qm/jwMuqjuA02yBAgAJjYQfCvSwTYkqH
	dtCYO9TedOVY0/LbSl1F3W2wN4g4yMWpsFAN2mfUVREqGakPRN3sBp65
X-Gm-Gg: AeBDievzV/3vWZxTWctuqFeoUgaE9BuG2cBrVveIrNdLyjh1hz2T1nbjSQZTOlMHPYX
	AwCSsKnwvy8Bxa37TkBh3X57Ib3/IEHbq84CRHW+W7IghvysxYLoUIQNGWGVi918juPA0AJIDUx
	Wvzak2UV0f2c9MQkCpNWPtHUOGoRcf2aO4GZBIASGiMszl24acjFABrUHh5MX72IcohWFvrL8UI
	oQEMkcRugVQ6Xii3kkLv5pSmU5riCPxmEg1c6XRo8D4Q9MtR0zf5S1E9BEBO1lkWKf6VowcM7Qy
	VAIHjbkr77Mz/OVakZhMFqi0P4nbcu4ql6Nwdfy2dpfsX1+oUVCSQuXxuOVVVGPEIPeDz3VX0+C
	xaMmgj4tEffTXExfkjThED9sn5u3ci4howxDs1+QXmivb4+hFRj0DWK8skUK7kpKCwO5vDvoqvv
	s3/af/oA7koLDZE3ouEFB2LXUDFyOp0G2//eWH8sNZU9OnzffqANmSKg==
X-Received: by 2002:a05:6a00:2d9d:b0:81f:3fa0:8c38 with SMTP id d2e1a72fcca58-8352d17504fmr6815426b3a.20.1777819930328;
        Sun, 03 May 2026 07:52:10 -0700 (PDT)
Received: from localhost ([183.227.123.133])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-837aa3e4f30sm121202b3a.1.2026.05.03.07.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 07:52:09 -0700 (PDT)
From: chenqiwu <qiwuchen55@gmail.com>
X-Google-Original-From: chenqiwu <qiwu.chen@transsion.com>
Date: Sun, 3 May 2026 22:52:05 +0800
To: Matthew Wilcox <willy@infradead.org>
Cc: "qiwu.chen" <qiwuchen55@gmail.com>, akpm@linux-foundation.org,
	rostedt@goodmis.org, kasong@tencent.com, mhocko@kernel.org,
	hannes@cmpxchg.org, david@kernel.org, ljs@kernel.org,
	baohua@kernel.org, mhiramat@kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: rework lru_shrink and write_folio tracepoints
Message-ID: <20260503145205.GA3181@rlk>
References: <20260503085705.3276-1-qiwu.chen@transsion.com>
 <afdBCWopkfF2ow-Z@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afdBCWopkfF2ow-Z@casper.infradead.org>

On Sun, May 03, 2026 at 01:35:21PM +0100, Matthew Wilcox wrote:
> 
> You also removed the printing of the folio's PFN.  Was this deliberate?
> If so, it merits a mention in the commit description.
> 
> Also if you are going to do this (and I suspect we should do this!)
> we don't need to do the folio -> pfn -> page conversion.  We can just
> store the folio pointer and print out the folio pointer.
>
Yes, I think printing out the PFN is indeed unnecessary, but miss to
merit a mention in commit messsage. I will remove the unnecessary
conversion and merit a mention in patch v2.
