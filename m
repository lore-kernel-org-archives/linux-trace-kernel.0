Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF34329C4A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210971; cv=none; b=I4K+GBwUcudYm1oI0y8/7fpd8oRdUshgs9VU2eCnZXyy8XipVmLE0XlW+BuiWn4vdlwPUNHUdiwleobjZ5A24cpNKX++4hYMEQ6/g9FIVHMPXt6KVW30mTUdkYYLClnm4EH8oZN/OlMjyVf90uGYrNKNQ0J3enRa8xTlm4Tn5tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210971; c=relaxed/simple;
	bh=gBBnGeBm/IqQmJFIlkwqG+/6/hwshNzPubwtwxHJlIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+rSuv4zrhkzKZBbvTPqiWxtVwMi/HpEraeUzL0UlzfPHRMAqziAbCYqgUQRRqPvv+otsnaGhJI3hz1BaSYeu1Z8+tgjvMs9h6SMQebTv58yzHUtLhe2IYNNK2wCXQBBmUeuvoBj/7uaHIZuz5B4bfs2W/BzDDVX6lIx/tvbc/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-65f66d72b3fso1827818eaf.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 01:42:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768210969; x=1768815769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37jw5nLaZWVZ6yrJck1zZSSpLqHqkC9MlKG8jIO3uBA=;
        b=FbyHr33IJfpB4VIbs2IX9djfOZkCUEACn0BlSVhD7dgnAVkS1V0guK+6XC2EYiBnfv
         xwCYcjbhXqFDr+5TxyvOdNG9K0GUr3cmhMknZ6ZQFajAJ5ac4c2H1VXZJVL0wz2eBQHZ
         0uwISZ8ArSaTL1Qkppf0JYNTchxTaw0ofAT72wxoYgMfDIUN1qUiBh+lEkrYQ1r1FgMq
         IsOXmBvT/w7qo4VIlCBNsi1MX4xGzG/VKgU6AIa4TKCzMVv5fF5DDcZs+lReNOARhVWZ
         BbQoW9kgbW3Yqwd6GFF1WP991Wjm9lAwdBx0tSG8aeKHRref0c5Hw9QAyPkRz4mTlRmv
         M8Cg==
X-Forwarded-Encrypted: i=1; AJvYcCV6cG9fMdfum11vGvtgrCkk8lsbTxiW7CuWLFgc5HOtCsPdpLHpX7Dtxik4LBmX78WiCtO3B1SXWzYYxnp8GgOvm28=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdPP7m0+O/UQBNokCFDAiuTkOJxIppq9VN0InVwH6CyRIjMAOS
	48Vsinp50dv6dTDnat8TUiQXqRd8fKpo9DCeYGzkvKNNpHbXFARmx+nyjfM0Vg==
X-Gm-Gg: AY/fxX4I43FRsQ3PZNRkEP2/AClKnU18YIykTOvmFpER7EpocJoCdArysr62Do2sBiZ
	qSbridIfL2zREoS/EwvvoTvXJsm6NS9Lzq2Osqjj4X5WyjhiRkRszFEMTigeKmmCW13+AVHd3cr
	isFwdJ6Pfnp8j4kqG78RJnDDi4IOw/7WbB7BTnUgCq3szepvbMlKaDofBwshaBTwaxZ6s/o5rP6
	eJdpaElcReoUjaNv6dses3fpmyDp54oX8hcNzzcyfIBX2ykdGWEuhyBlD/JiYAWD4YTc1c/o9V7
	Kc6yCQhXmJVnFs8K9gNNXMPgnMf/8ZmzHtKVTtwpYizG0eu3Nkl4t9HAMTUGuC5wbvS74XweFHw
	Qy0N85SmKrGhX6ynqRpxy9iGsI4U7zkZxuQXoNOBvraaAWWZwIncV+j5Z5xBKtppV8RKJo/9057
	14Dw==
X-Google-Smtp-Source: AGHT+IF0hJgzX75ZcIowtNhUjlPnKr/1ZMKF6Ic3Py2DL3yFdhUTF0b1MKvrSAqEbri5ZvRTLM8gzQ==
X-Received: by 2002:a05:6820:16a5:b0:65f:1038:1317 with SMTP id 006d021491bc7-65f54f76ed2mr9334798eaf.70.1768210969330;
        Mon, 12 Jan 2026 01:42:49 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:72::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65f48ced969sm6764615eaf.17.2026.01.12.01.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 01:42:49 -0800 (PST)
Date: Mon, 12 Jan 2026 01:42:47 -0800
From: Breno Leitao <leitao@debian.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, puranjay@kernel.org, usamaarif642@gmail.com, 
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Fix annotated branch unbootable kernel
Message-ID: <74f52o5tq2nodc3otsvknrsf2rpzphtaba7lxia5u3i7322vni@giqfw3ofnnyk>
References: <20251231-annotated-v1-1-9db1c0d03062@debian.org>
 <aVwp_BJx84gXHPlD@willie-the-truck>
 <20260109145022.35da01a3@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109145022.35da01a3@gandalf.local.home>

Hello Steven,

On Fri, Jan 09, 2026 at 02:50:22PM -0500, Steven Rostedt wrote:
> [ Resending with my kernel.org email, as I received a bunch of messages from gmail saying it's blocking me :-p ]
> 
> On Mon, 5 Jan 2026 21:15:40 +0000
> Will Deacon <will@kernel.org> wrote:
> 
> > > Another approach is to disable profiling on all arch/arm64 code, similarly to
> > > x86, where DISABLE_BRANCH_PROFILING is called for all arch/x86 code. See
> > > commit 2cbb20b008dba ("tracing: Disable branch profiling in noinstr
> > > code").  
> > 
> > Yes, let's start with arch/arm64/. We know that's safe and then if
> > somebody wants to make it finer-grained, it's on them to figure out a
> > way to do it without playing whack-a-mole.
> 
> OK, so by adding -DDISABLE_BRANCH_PROFILING to the Makefile configs and for
> the files that were audited, could be opt-in?

How to do the audit in this case? I suppose we want to disable branch
profiling for files that have any function that would eventually call
noinstr functions, right?
