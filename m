Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE1D40315F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 09:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782811611; cv=none; b=R7E4o10iiwutdThhygCuk1hLvBWjGpX2Xg2+OpCTvFu+aIvTYhJiiirI/JCdwrmlxxl3NIrKF9RNY/H8HJbZtPSMIbR57mIcQohGpsV2ZwuyU4Cp++7lw39Sk1SkImCjGAuO1OhCpsp1zEvE/Gij9lIdQA6KYcudEalwgkpKlEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782811611; c=relaxed/simple;
	bh=gDWcr9g7V976JXjx5e3SjBfbP1RVsFo27XUAbVqFVo4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KGSHFzgTN3Hr8D7srezTxPjXMP1Q0S+R6iaH29aFzULeLaC0+DZavjttcPMRVK6o/leotZpTY/Uu1/Y3riy2s/x1RqGanWN1ouXVapSanGSIs9IaR3vSzvG7xKzXYnGF0uMvjIsLQh3NNDUZCNvh9jr1clzfal4kz38T89LP51I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o0QYxxKE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0QYxxKE"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493bc8fda98so2497285e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 02:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782811608; x=1783416408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TJARS/20WNrXdEtexEq3wCGR+2Melh6Vz5U3ONlAYM=;
        b=o0QYxxKEigYjhZaQyEY0niaFKzgHYa0cRzR/Kjxf5bpWAn9zUeWB932a413eoKfssA
         svDPGGVoFxhOs+N/mCwuYHuPMrVPVyQ2cbavgymS6V15D/cUeqD8inrQXuCW/59P54af
         Db7GcFi0QLfDSrUoOmgvHbmGksNLo3TCHYPL8RcD9A1QRfYIIySQc/bw+VUNIae75w9e
         blelSlcLSlZQoxCo3Hs/q8hC67zjF4NwfynC/7npWkOkL56QDIjUwlj6f9KfUk6pMm9M
         JsyvUe3U0X01AVXvmisnme6GYsJ6jRTDspc/bIJCYkzdqQC4yYJ2S+ZslcskRVNxqp6q
         pg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782811608; x=1783416408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0TJARS/20WNrXdEtexEq3wCGR+2Melh6Vz5U3ONlAYM=;
        b=Us9JDn5luM0YksNuFCCdEXr9gnvIv2J7zYqDdtSdK6sT7i08Iq9qeeMuOv9eDGUwE8
         KY7Wfws9z7h9sLhwUtXKKE4+nprLd3511sbeIKMKqe2u8KQZ+60TWNUWe3kC3oJyT+xH
         ufm/Tkl/Jyu3ZGsyXY+bXfrdycRN/k1CvdApf174BRazS0JNh54chuIQusBleEBk/8fS
         dBwxok1mjeYs1CapTNoNGzu0aB6S2kM6GHH0S9ELsqO3cJUHxXW/GdrSXUMPZ+14RjBH
         M8rmn2LpcBugUWcaomDjk51r0XQy5QidQ1se8Qqmha9FYNtmmEoAqd9YWNUfgsEpcNgB
         XHow==
X-Forwarded-Encrypted: i=1; AFNElJ+f3g2IP6brOFJ+5pJOvX20Cmg8Eo7vDc/T/tpzkSMp8/a12Jd+hpP6ZK4IufaNLIjFh+0VI7vxjqvtazpuxrbBmYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCDTf8uzMuSiljMhYgUwtMhRl1oGfQY14qfo8Rzt+9FfwtICIB
	tFzDEH9yKF/sctOPx1JMSyfehUpYuV2f+pFX8HHXa9ZCyuWILHG+bkKwggoOAfq4
X-Gm-Gg: AfdE7clarFk6JYZ3JuVssp49dNwGA5JqLZrEcK7Cw0IABDz2M8Gkj0dHcVHGekHnJyJ
	1LntIp9+RwyuVNpHMeKXjfDuFblUf9byadlR3F8FRM72G5VRsx5kRHrDwBr/l4QVGseTI4p7kSV
	ye3ZBeRmLvztb+RLw/H9b8Hl1/10L5B3gLECZN75gO/b6pqDKvbTQhxEQlY+pZaffaqMwnbg/9/
	Hfi4yALs6n2Jwo95Zln9wvJ2a5HoZKwAj3VHFGaX/83DFYpyknNjFzk4J46YhQL79+DIUoeVrT3
	d6mkcdb4FSrhstRPqgMWyUaPJPXiuPo5J5r+JvCkWD5w0XNqLTmaTIZGfy9KOAVM5sIDwdzfex+
	p4Yi7k4etHg6dPPPNEq5AO0kMR6Vev9X+3ltkzxsYzNnuJ9ig7zidesR2Qiv7GKzxOeW3BL9Aj+
	UHzsTzh9vu8GPunDGnqLL+M/LKMsYL/l2jLVMyJkUnAGyOnTWBZ+chRvGv
X-Received: by 2002:a05:600c:1c17:b0:493:bba7:e9f4 with SMTP id 5b1f17b1804b1-493bba7eacamr19656965e9.18.1782811607702;
        Tue, 30 Jun 2026 02:26:47 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bc7aca88sm51454165e9.0.2026.06.30.02.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 02:26:47 -0700 (PDT)
Date: Tue, 30 Jun 2026 10:26:45 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Michal =?UTF-8?B?S291dG7DvQ==?=
 <mkoutny@suse.com>
Subject: Re: [PATCH 1/2] tracing: Embed 'char comm[16]' in a structure
Message-ID: <20260630102645.4457e47e@pumpkin>
In-Reply-To: <20260629162634.0327fa25@robin>
References: <20260626212356.64150-1-david.laight.linux@gmail.com>
	<20260626212356.64150-2-david.laight.linux@gmail.com>
	<20260629162634.0327fa25@robin>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jun 2026 16:26:34 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 26 Jun 2026 22:23:55 +0100
> David Laight <david.laight.linux@gmail.com> wrote:
> 
> \> --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -52,6 +52,7 @@
> >  #include <linux/sort.h>
> >  #include <linux/io.h> /* vmap_page_range() */
> >  #include <linux/fs_context.h>
> > +#include <linux/trace_printk.h>  
> 
> Left over debugging? ;-)

Possibly from a build where I'd taken it out of kernel.h.
I think this file needs that header from somewhere.
Probably for the prototypes for tracing_on() etc.
It really ought to have an explicit include rather than relying on
a 'proxy' include.

I did resolve a lot of those include issues by putting it into the
main trace headers (which is big an non-trivial).

	David

> 
> -- Steve

