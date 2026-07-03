Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA4738E8B9
	for <linux-trace-kernel@vger.kernel.org>; Fri,  3 Jul 2026 11:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783076861; cv=none; b=XlvFoYsSHTM0vUlkXybu6cQVnp5h3hqUwrQoF/U8iCCMC22I1La8zd4Lv+gMiEpM8FCGqn9jCf8u2UGP0sTal0QOn7fzYqnYfloLxdBLK7F4dwKbVTe4aQlls8HldOWKWITaf2aXJnl9bKdHpCfPp6xuoyCCm39/ZIPs8l9+Yek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783076861; c=relaxed/simple;
	bh=GEVrl9iAypCDnU7cVBquDYwwNQsdXV+ow4a7huIPPs8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vhu/EfwcCpg6VakVnJBVPol7iSDQogBC3JPwgaqxc611uzwHXHBCNxsTaFIpgdLRJJ9u1gTVyxM6Eo8hoWGBVgq1Ly25ppN8wEapIcMy+8XPk2EkciUlhj1zY+H1CpSrDNxm6i6dsFp6VjpQ5xF7M28QEPmJEqenLSKAf+MNHWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwQe++WA; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwQe++WA"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-475881b9a4bso370876f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Jul 2026 04:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783076858; x=1783681658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7ICeSij0heCeWd1xnNWfCSIcK8dF/iVCS3zFSp56UcI=;
        b=LwQe++WAmg8yQLAC2Hz6xsms0kyx00yyZ3MfKMRW2nHE5ygAP0cYrxl+mJ6+4zTa8F
         hWFpu4G/Dvf5qQpg34FT4GxFY6ZGSGzQ5zpw2D3SyzGEa4TgiquaWkK3MQqP+qxrlCnN
         2/l6E3osA9WmMpxErzMeF60D5bJhrj4pJViAMAlOB2i34eEpCWGwW6QDsNL+KFsWB08l
         /a0I7q8J3/IdfSBVgCIaNDBluMhJZs0G+GTa1aC7pK9gzJE4CIamNKgjHLWbuf6SXb1c
         Ky955bYHEfQyZ3qOhJjkejBC3kvdRlpLr9tuMNLT68ImTn8hS7zDgLPtBAVwGPbazo8c
         z9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076858; x=1783681658;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7ICeSij0heCeWd1xnNWfCSIcK8dF/iVCS3zFSp56UcI=;
        b=srBOvAapa+ZGDa6fBC1OHEvF78qMPN7P6KOwxTW8vE2wrb8Y56UMJfFtntTrk4hu0f
         L+7BZCkV4w1BQ/UT2qXBskqXiHRMxzmejVAUAOLdwHvEEzoErfzJR7HX4XJkjc/Upygz
         yGTj/mFwGXLFX8ps3HxmvN7CiMR6l2BTm2i2h2YkE9ot+jGv/qZ5j6nyB3XGrxE6lylj
         Es4YeuP/wfxTxEc47FANn+/SWX92lDWAoh2l+qUX6g3OWWfHigr9Un3K5LPpTVWyxVJc
         q4hjvGwx5A6uMt2II5Demg4uGC56Il4bcanNI9pdwxqFKQdYE4YgLQm4kh3c9YjLC/+o
         5pwg==
X-Forwarded-Encrypted: i=1; AHgh+RrfIlkW74/LK2lcpL+Cg9kHNe/CNqRk+FCEUaprXmiglMSsd7U2EHGzJf9rizPZTZZSxFPsFUvBrs65ZwiABeZM/Js=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXW/p2Vw21WxbdoGkf41Gd0cRTaBV9NjTbCeDb6G0AEB/BJ1qq
	RQmG+bbduK9tmYNGnsiLXYzCGHzMC8jTt4dxV65PrLQnNkQHgauFp1Zn
X-Gm-Gg: AfdE7cm+SVe5utfQsaMg3bVgn+qNJjLtF3R4RXf6JE/JjgqYVdmN5H47mRLHXX5bQW9
	xL8zCOU2o53YFEEqvSUY/K9TaNFaijVHhwnKvYu7WU1ZyyLRpqcUuGm5xSgDKfQEsy4/oh7hBYG
	62XxJFN8n2PuxmuPdyiU0ycxYD5xbH0LhsE9tf6XS2DgBqZFE2lJn874io0coULcGmURUuW6Son
	ZBbmShLjvlHQBOq203VZ9KROPES9zWAin+mB4aQa/bTiKUtsb2J+gYqnEANp2/eckYioW3ZSqSk
	CgKKknQQDGXbdvm4WoQ8jDNqNqxSLXe2KLfvNpeEFe/G7aWaTTFMob0HZhuzR62itzTDqyTSbRm
	w3BTgIxou0GKVUrP1kihSdKFgpQRtNa09gU7+cfAgellWiIaXitPcmXMfnxkFXvLyjwJLg8Zh9t
	WVkUkzRNcrvFjvqsTJlK/Ka7rHhuK9lcKCbrw=
X-Received: by 2002:a05:6000:1788:b0:46d:1433:77ec with SMTP id ffacd0b85a97d-477b34b0578mr12955058f8f.2.1783076858236;
        Fri, 03 Jul 2026 04:07:38 -0700 (PDT)
Received: from krava (37-188-223-191.red.o2.cz. [37.188.223.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477db3dbacbsm17657372f8f.4.2026.07.03.04.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:07:37 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 3 Jul 2026 13:07:33 +0200
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv5 00/13] uprobes/x86: Fix red zone issue for optimized
 uprobes
Message-ID: <akeX9SJH76guXykU@krava>
References: <20260701111337.53943-1-jolsa@kernel.org>
 <CAEf4BzYiPeLTbgeVEDKqU45oHBFJgU6ULgK=3i1J7dbzKS2+yg@mail.gmail.com>
 <akZJZth3-fVUhADl@krava>
 <CAEf4BzaDwwW1ebPO+4r5rhmdyXk+XddWTDBzN4iOaCU8qEPZRw@mail.gmail.com>
 <20260703105859.GD651302@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703105859.GD651302@noisy.programming.kicks-ass.net>

On Fri, Jul 03, 2026 at 12:58:59PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 02, 2026 at 09:20:25AM -0700, Andrii Nakryiko wrote:
> 
> > > I failed to release link in test_uprobe_fork_optimized, fix is below
> > > I can send new version or separate fix
> > 
> > yeah, please fix the test, adjust comments as pointed out by AI and
> > send v6. Seems like Peter wants to pick it up through tip, I don't
> > mind.
> 
> So I should wait for v6, and not munge the below delta in?

yep, I'll send it out later today

thanks,
jirka
