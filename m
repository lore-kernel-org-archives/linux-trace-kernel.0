Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7089515884B
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Apr 2024 22:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712701191; cv=none; b=Rk818NOIkIOlL8jErmXPJiJMfdIpoufNyz0scbJhdNRtw/cju9FQMHaOeke1VopvZYEVH1+yxsZrsJHyBxifB9DrJ2H7OIpGlD4ZJslyS+Y57Cmjs1FuwShe3mf+cAGGYKXeSV7W9IkxlHuY15yQtsea2Cp6wbUfGyxtidGlCfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712701191; c=relaxed/simple;
	bh=EYMsqegjT4OXpgUDL/2KYBA7Xq+Ay65w52yrQrkbRj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3T3gt+kVHvQz/iP8FsjAUnFF9KaNF6Mz0AEN5FYaRFFKkMRBRvmQwd6EvMX6sFbLAdPTm9l728Di/Mm0cvapzQJdgMu4Nqth4lBxIHCK0VfR4bqwf2rfJI+kD0G2M7Uxs/NN7ioWTH/RpAfrCAZhE0RpaZm9Vd3LZc7RaPRXDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EkS3kAfm; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EkS3kAfm"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e3dda73192so22637065ad.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Apr 2024 15:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712701190; x=1713305990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dVGaEP7K5QMj4iEVzjXOSGPdsEqHFt6Mr5ict+7OkIA=;
        b=EkS3kAfm3b4tg5R0ENXz6MqqojkQDmkTIcn+4G7j29Pd4leFC1THFYzfl2xRFSAJyo
         vQINOf6H+q+RnxTUIFRcHdB994UNjBTgi1guHuCJtwc5Ae60hdlBcx6hbEhwOO8X95o5
         g7r/zckXU3zj6QMeb4UlyzHTbz9rAuLUJPI10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712701190; x=1713305990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVGaEP7K5QMj4iEVzjXOSGPdsEqHFt6Mr5ict+7OkIA=;
        b=wv6iMXLMmskucxVVr45BuhSHU6HOD2KkSrC3wLTlBc4s2pBdOJLki/WdAhQJiXQVEj
         jFwN1K8dw0rsX6i5r2y9CzNMq54YObDslJTmmBTkkYeWA8rHHJCW06/2NIN9+Qa/erlh
         JViTq4Gxfl1m+zak7pS4TO1Q8+zHn2ogRmxRp1ii99e1Vutd9nIajB2vEWOZGMkel17x
         jhGK4Izk4KFfRGiIaNiqL9QY4Cru4FNOOoaghtnjF9Ga7k0wiRta5+ZYkcGLWla8jG+/
         d2KMzfT4O7iOv7fV/ub0R0iZHQVxoJ1gAWmRD0ur98d5wKI9bY+FUKE9hX5uccboQq/0
         KFeg==
X-Forwarded-Encrypted: i=1; AJvYcCVDs9Rf1lkl82zN3wc6qe3RQMIDj9LDSOiWMVoWlt7jABm1+e5zXJlkoW2hc+yocBhrikulOOiLr5WdsbsL5XNZFGw/SD4yZUud4qdbz+TL3IdL
X-Gm-Message-State: AOJu0YzV4d0c12H0FILsaRd3dcJS9CJuceHMFMai3jxKIUIbXb1R21K8
	n4e7iym4B1GE75f3ZciIsqmlnImmW2Kaf3zpYJe7eFK/fvirbhV4V90bV8N8UQ==
X-Google-Smtp-Source: AGHT+IEGUmXhtGH19b1H/WgCD2Rpis8vZRMumjN97SwnqzVkgy1CeZDYsMWyzkA9riCGUi1oxXbPcg==
X-Received: by 2002:a17:903:2441:b0:1e4:1fb8:3216 with SMTP id l1-20020a170903244100b001e41fb83216mr1246750pls.52.1712701189791;
        Tue, 09 Apr 2024 15:19:49 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902650300b001e4ea358407sm205887plk.46.2024.04.09.15.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 15:19:49 -0700 (PDT)
Date: Tue, 9 Apr 2024 15:19:48 -0700
From: Kees Cook <keescook@chromium.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	Ross Zwisler <zwisler@google.com>, wklin@google.com,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [POC][RFC][PATCH 0/2] pstore/mm/x86: Add wildcard memmap to map
 pstore consistently
Message-ID: <202404091519.B7B2221@keescook>
References: <20240409210254.660888920@goodmis.org>
 <20240409172358.34ea19f0@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409172358.34ea19f0@gandalf.local.home>

On Tue, Apr 09, 2024 at 05:23:58PM -0400, Steven Rostedt wrote:
> On Tue, 09 Apr 2024 17:02:54 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> >   memmap=12M*4096:oops   ramoops.mem_name=oops
> 
> I forgot to mention that this makes it trivial for any machine that doesn't
> clear memory on soft-reboot, to enable console ramoops (to have access to
> the last boot dmesg without needing serial).
> 
> I tested this on a couple of my test boxes and on QEMU, and it works rather
> well.

I've long wanted a "stable for this machine and kernel" memory region
like this for pstore. It would make testing much easier.

-- 
Kees Cook
