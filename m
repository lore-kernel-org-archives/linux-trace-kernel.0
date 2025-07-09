Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E6023C4F4;
	Wed,  9 Jul 2025 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049384; cv=none; b=N7hD1XHdjo5VyalAXln509wHtVdOQP9F8C+1jcKmWuta7vBO0/9p7xljnYz+CsBW9gI1chdniGioUt3vdQp7lsZ61rK6zTDP7eddDI99FIr+MurYjqMNTPwITtAmZiLgeTlI5XN/rADBq1sVTT18fORktcNjJQMhjjw5MsmYwVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049384; c=relaxed/simple;
	bh=zU87l0EITnp9g2Yi4D3PMimHE11g+TG8aeBX8Ho0RJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJgjitxinU3/ZXTIC7XdESCQgUVnWnRf6RzVb5BLbZ7OK0GPQW43jG+1fZED+Zdltp0eIHovkW8a/Vqr02DEj0OXouHl10nT0ngNu+trj8HAU3BCEG3Nqgy1XXK0JaawMxVqCmUWJERd3p+XU6RfdraK3IMNOy6YNnVMaqUFHeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sz3KIhs6; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sz3KIhs6"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a6e8b1fa37so4197617f8f.2;
        Wed, 09 Jul 2025 01:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752049381; x=1752654181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzxIUE4gQTBu7/qvcfY6nYe83AP1dKFA917cFV2PnZI=;
        b=Sz3KIhs6w/AKKpHjcxrxj0/4dYngG++DnEX0+7p8aXQGMzYt59O17d7y5ltMXJk5Zg
         ExmdCqOecDoHtEz+1Wc5y0J9Wtw4EruBX4Mt0owMeszfZjEYkJxg9CtIP0D32M0V/VTq
         lxc2JrIYFwW1ko46VrmR0fdMYbIpFc4G2KkuoKRmTxhgjf0Wrm1xzE6dsnE7uo1msf+I
         Ys+yA6QpTLBK2pt5t8RgKkqLjlhX/OhI8qKMCYZsnJvBNFd+JF/xltwEV9PPANa4Gy/X
         FZepyPWazY6ups1ZcYanmt+R5C4elTZl/V35LNAvD7RJV61DS6GP3/Cil0lYZqi420es
         hEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752049381; x=1752654181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzxIUE4gQTBu7/qvcfY6nYe83AP1dKFA917cFV2PnZI=;
        b=UT/746ism8jcSGC5/ufowxFiBqqkJsPdFEoynAEoFnaVDXAdqQTm0IwKI1p+EbYE1M
         5s05cpTA4wfBXP3A6r+49/OXjcN24l3LbTEBJxZJGU1NXwS3CU72R4rVNMXOYzkxFC4y
         Bk2Wb/ms8txdFJg6rF+4xxe4tIi5UVlwb34yTf81BrimaZRpTCbENpvl+RFqoch/ui0Q
         1ImJxY1pXgJWC1RJ3yI3Q4zR9VBCnU5GyhLLqB1SvlS+wuPdNcCVsbkQ9cPNRyLBIV9Q
         Kzurw6jsLdIVO5DCfxo6djoS+pHkG85BeH5iPaYnFnzW6ZlDnhSXBKWSNy40zR0D8pgE
         CWJw==
X-Forwarded-Encrypted: i=1; AJvYcCV//QOE8EH3PZGghkF/GIKzoQtrPynr0khdphIUCYWVPfVTPcRwEfoOGqChX4kcoEJPuA5LHdcvD9S4MNA=@vger.kernel.org, AJvYcCWMJXerEaOiKvojK0pZkWd8zx377uf3shx3AUaJLE1ESVUZXbLf7r2dZXGuDYhx3XyFN4FWGbQHVhbZ8h4/OQqWWF2b@vger.kernel.org
X-Gm-Message-State: AOJu0YxPAx8gPBveARwgYiafoyzuzH0j2XCcrWADKo7nv2Ek4Lc27MJ9
	4k+XOHlXiFwLBjm8ykP8+tdnqvVZwYEJU61xjqiYqoAax+P4UYtcXKcu
X-Gm-Gg: ASbGncssuwCaiTT7VpgG6a4VFC5SP+j7WLyQSxSyxlk9WXyMZY8c9uTvT0vf4rQSQdY
	hBTl/W/8Hztb+U3FxbNmTpliqMd8Qe4fZVxJF4diu1LoC/K+/eRrU/GzmHYsPDUuTqihEFrEnXY
	wVxDh5bT2lIsObb/btAjygI15Xo/VvfKYokPzmA2hghoqXugxWjp/jQ+CJDSOcRXIH+k7We0O9X
	MgYRjMvbQiWG2Oh7XkGfLJkroUfuu2E1rA61sF9CGoE9fHU37as2enaq6Oghn7uwXRqtBaN/84C
	N/ZXzbhgS9uhcj62T5BIRoD1bQjmFwvR2iD4CyVsSn6Zb1g4yUOmZwN46t92MOkKdd/81lz/N29
	QB9kUpFLmRIepPLhDjw==
X-Google-Smtp-Source: AGHT+IFXf2JEwQ31gzISHIrNFrlKjFfnf+Xl60HwTCt+wrPxOekzSySyQCE1sMt5QvRmOYoYm5GxtQ==
X-Received: by 2002:a05:6000:4a08:b0:3a4:bfda:1e9 with SMTP id ffacd0b85a97d-3b5e452e4cdmr1052250f8f.46.1752049380896;
        Wed, 09 Jul 2025 01:23:00 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47225afefsm14948384f8f.82.2025.07.09.01.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 01:23:00 -0700 (PDT)
Date: Wed, 9 Jul 2025 09:22:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Gabriele
 Monaco <gmonaco@redhat.com>, john.ogness@linutronix.de
Subject: Re: [PATCH] tracing: Remove pointless memory barriers
Message-ID: <20250709092259.791583fe@pumpkin>
In-Reply-To: <20250626123445.5b01849d@gandalf.local.home>
References: <20250626151940.1756398-1-namcao@linutronix.de>
	<20250626113520.315db641@gandalf.local.home>
	<20250626160459.soHxOROG@linutronix.de>
	<20250626123445.5b01849d@gandalf.local.home>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Jun 2025 12:34:45 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 26 Jun 2025 18:04:59 +0200
> Nam Cao <namcao@linutronix.de> wrote:
> 
> > I think you have it inverted? I assume you meant:
> > 
> > "Without the barriers, the tr->buffer_disabled = 1 can be set on one CPU,
> > and the other CPU can think the buffer is still enabled and do work that
> > will end up doing nothing."
> > 
> > Your scenario can still happen despite the memory barrier:  
> 
> Yes, but the point isn't really to prevent the race. It's more about making
> the race window smaller.
> 
> When we disable it, if something is currently using it then it may or may
> not get in. That's fine as this isn't critical.
> 
> But from my understanding, without the barriers, some architectures may
> never see the update. That is, the write from one CPU may not get to memory
> for a long time and new incoming readers will still see the old data. I'm
> more concerned with new readers than ones that are currently racing with
> the updates.

I'm not an expert here, but I don't think the barriers necessarily do anything
to force writes out of the 'store buffer' (so the data gets into the cache
from where it will be snooped).

An implementation of 'wmb' might wait for the store buffer (or other scheme
for pending writes) to empty, but it only has to use a marker to ensure
ordering.

The actual writes of data to the data cache are also likely to happen
'in their own time' regardless of the code the cpu is executing (although
cache line reads from main memory (for reads) may take preference over
those for writes).

Thinks...
A plausible model is that write data is buffered on a cache-line basis
waiting for the old cache line to be read from memory.
While that is happening later writes can be written into other cache lines.

So a 'wmb' might just stall the cpu that executes it without having any
real effect on the timings of the memory updates seen by other cpu.

	David

 
