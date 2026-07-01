Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914F036165F
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Jul 2026 16:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924730; cv=none; b=m0MwsIia4MpBtCWuy4DijlXtGiY6eL0TMvjSsURKAe6Cb/5YXft+L+O5aT23BD/EOKMl40DkGnw35p12mhxyBxyi13nmQH/DSuw7jlRM4BRJytR52fFJtPPs/ru3vX2vlK3O+3F7NKQrp6YWIx+QDHyA1nj8bbC0YpGkYk33rEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924730; c=relaxed/simple;
	bh=4wE909Viv/4QW7gvr0Tz4foEB91LC61Zan4L84BZxgo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VuQKOYTQO6UxMasByCU0lwVENbeK3epqhLufCY6QM3sugxS3itHG5V088THxvN6jYInAVLqY6Cl/VFonRmWSp5NnDx0PwMhPdBtLVEbiQbaxaBmAU8YqCcDI53aL9pNmBWVlcfbUAo0nM0lFQYniQu62tM4z0Xr2Wp4LVJY9Xig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipF6drPT; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipF6drPT"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493b27c7451so20590825e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Jul 2026 09:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782924727; x=1783529527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaMjr0O6lQYfeKKEbSNHUS6EGtHYKYoYY+zAW6psid0=;
        b=ipF6drPT8sG+HSaIt5fHWwpe0bddlLxx0LGEuxNSSY9xHbj/ba2JSVZ7J9GQn92xJP
         /S9dpvW1faKbNan+ZHeJ5wvL5ZaXues775RrQqdohxYw35Ueh1o2UAnylBP4cJpEaz5r
         2SyTMAwPLgH7Z44ZYdrxtOU8G+ZmVn7UQfBnJmTGzThjkBMf8XWVmVqUkPp473J7D65B
         KSiutgDhWu6zaBwHHHdun507FjO/23cTr6fBZSGC+Fu8PyoNyLrivMT9l8an5Xr4l8cV
         V/kqvXu12F5V6fpvrQFt3z7jN4QTlRvgvKsLLxCoaAJtcK3cQ4hk5LYlkRCGrm4VXeIw
         k+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782924727; x=1783529527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HaMjr0O6lQYfeKKEbSNHUS6EGtHYKYoYY+zAW6psid0=;
        b=d9reblWlGJy5qTOOIFeYiW7VElKXm2kl5z1s8xiomelm+xLZKPIVmyaLfNI9V6nMwY
         946EcXJf8FoFqLXl5E8Rj1woaVBiRXA8f0ZG15eMZgo7S5Fy+zaiboerrhuNyyYl1C/J
         A1Paa70dEYPrbUdCtxR2I3piPqo2VZ1iSehgYJfsdG/yCLraJJNC+cIpIYQNYto0I5GK
         C3CxjPA+HITH5Upy3xjHJZ1JJ+4qQrsUyqhgisIsR/fbywF5MyGY5OxU8uVaSm5/IEkw
         gvq8JJVeRlDtHV1yJt5j02PDH113IknM+zM810eEp2Nrt4LZpyzgrlk9aJiDZnyX99qo
         uB1w==
X-Forwarded-Encrypted: i=1; AHgh+RoWAnIazsnP8lPVxSD0sLrtAePleImEBb7QE+S7mdLxzh1TdqMlm+KzmdvsfLkNLBsRJZi53+/MouzYhgv11o74AHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxht0Dd3ICMOj+dktxTwlszb5CJua7x5+nswIf+UL1MBdGFJDQx
	+j5nVvXrCBgZcDsyv4/D2lJch9S5XEl04VlAwIC1SHCZA3kuLtkbfkPhkcShYIYt
X-Gm-Gg: AfdE7cmT7i+Azp0seFHZDd3oRF1MKSdqxmeUwykbVr4Axs8pn2Mx1uXUlO1w8PmScTB
	sd+u9h8lRD79wMttcvKKFeu2x+1koXoi0UR789m3Y63hsK1n4X6EJ31R3Y3ilaqvjaN2uFWVBiH
	t9FqMVCiafy3BIIBcDXuESJk6O1X7x6MngHKiq1D6qofQlimKszfXWN3O3YM7Ni8G19LbhwRkT4
	yF9CqyrYaUd4SAHLIpPKmUf1/5SmqHkge1CYsETt7XcmupKxk6s01mPsvz/ck4bUQ1f4nkXxvdv
	4sUn+sGAIjinTYyi6lwSu2y5fA5oC9Tj34R3DE3FPZhXedMg7XCq7CyW/DlbuY/2HiasO2GaaCB
	jZGfVogqd3q4j3pWVLjcBitsv7qCZlugKwYoMkFznZ8Kq955BPVopm1vpNg/vuQM3hdZ7ZuCy35
	zdSJkmgHyd3TeOk8dOpaEwylHsDznvDlu/naJ64GDGRvyLjQ==
X-Received: by 2002:a05:6000:612:b0:470:e26d:88ff with SMTP id ffacd0b85a97d-475de07c9dbmr10512636f8f.4.1782924726767;
        Wed, 01 Jul 2026 09:52:06 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dd94c829sm1144333f8f.24.2026.07.01.09.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:52:06 -0700 (PDT)
Date: Wed, 1 Jul 2026 17:52:05 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Michal =?UTF-8?B?S291dG7DvQ==?=
 <mkoutny@suse.com>
Subject: Re: [PATCH 2/2] tracing: Keep pid and comm[] in the same structure
Message-ID: <20260701175205.7d1a8cb6@pumpkin>
In-Reply-To: <20260701082340.5b0bd4e7@gandalf.local.home>
References: <20260626212356.64150-1-david.laight.linux@gmail.com>
	<20260626212356.64150-3-david.laight.linux@gmail.com>
	<20260629164912.4c1c2855@robin>
	<20260630110156.5314e2e6@pumpkin>
	<20260630150348.149e318c@gandalf.local.home>
	<20260701110407.31f7b6ca@pumpkin>
	<20260701063822.3af87520@gandalf.local.home>
	<20260701130404.3887c0e5@pumpkin>
	<20260701082340.5b0bd4e7@gandalf.local.home>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Jul 2026 08:23:40 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 1 Jul 2026 13:04:04 +0100
> David Laight <david.laight.linux@gmail.com> wrote:
> 
> 
> > > Well, that would break trace-cmd. As reading the raw buffers clears the
> > > trace, and trace-cmd reads the saved_cmdlines file *after* it reads the
> > > trace, as during the trace it gets populated.    
> > 
> > So you'd need to clear it when tracing is enabled after the buffer is cleared.
> > Just a matter of getting the timing right.  
> 
> Why? Note, saved_cmdlines is for *all* instances. You can have multiple
> instances tracing different things and they still all use the one
> saved_cmdlines file. It's not tied to any specific buffer. It's a cache. It
> gets populated at the next schedule switch after an event occurs.
> 

Mostly thoughts about the size of the cache and the difference between the
apparent default size of 128 and the actual size of 6300.

I had said that I'd not really looked at when it was used, just what
it contained.

None of that is relevant to this patch which just changes the data structures
a bit.
It also means that most updates will only dirty a single cache line.
Indeed it is probably worth comparing the comm[] strings and only doing
the write it they differ to avoid dirtying the cache line(s).

	David


