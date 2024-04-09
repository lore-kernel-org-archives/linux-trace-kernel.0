Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AB41586C6
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Apr 2024 23:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706088; cv=none; b=NPmRmPk1J0m+JFhdUqqlYW6kVO44/z7SA1OwN6x7gliEkGsilX4SuCKdMxlRKrhGAz7Ct9UD8yKHOs2o/zJ3u2bfeBzWh6Jj24AoEde1E8VrZEmr8JLjuQVtNuLpirjTdZH62LaieYV743Wtgy3MmOBDhTO/+vhnZ9zdG4z9IUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706088; c=relaxed/simple;
	bh=PNy0mBQjw8E74b5RpE2uI+eSralfxKJ9opohJxEN5zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AR1DLcAJBR0rjIw/iOx3lEYAgc48lt4GhE1ZzJmRjrHIYKhYUuBI9AB6oQbnWUfkXEELmwbYK88G1FHDeTZhy2yj+Kat+gpij5pFQdNFN2uIC2/4BrpArGYsEYQI69JdISfu40lkwWOv+UdEtTgc6L1czkDxuCKU96nDZ3pgrnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hqexQfx3; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hqexQfx3"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dff837d674so52570325ad.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Apr 2024 16:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712706085; x=1713310885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=az80y3cRpLeKTQubgh3fpGGNWsXUAJ+YmKoEHWsOqi0=;
        b=hqexQfx3TXWIybb0PG+TlGC4BL56oWeQxCwLNoaRJrD358ZJ+3Dg+rn3/l2g0wGHT3
         VaJ2nI6OucpsafkPcxU9dQb912NbDVISiC6YWdcvhFwsHK4mRXWuVPXv/0fnjxklBUEh
         z/Xn5agxzzBNh29ohDarnfTFTm/D4/25nUGwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712706085; x=1713310885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=az80y3cRpLeKTQubgh3fpGGNWsXUAJ+YmKoEHWsOqi0=;
        b=biD236iOwQhvVzFB411/OKCSuCnmG/zHj5qC3tr0oyQclmEjhpLuJugo3D/+0KfGtJ
         eV+kc1vibRRrwrkglb9qJmmo/+zOCiCZUi2hRAnW3Wv+/W7UZA3huX1fhv1wuwXL/h4z
         J6wdSK4tmNAkUGst7eJyRWDnBnWcT2hfAOukHH6hiQ+56IR+BOCWRMRU8ofU3CIJrPx7
         U74ZByfk3QSMymuYUquU1ohKSugUL0pbZqlQHWbcR7ZrmeLtd1k03QLh55Yop++w5Nqd
         eOznXV2MelKIkro/abfZazxdWbI3+97fe3oTdoecC7iAS+5W8B80jJ+4Eyeb6hY7MKJ5
         afrA==
X-Forwarded-Encrypted: i=1; AJvYcCViKcEy3klpu/jFgAkMH8EFCInY8R/42YknK6S0IGtTvwB56JpByxWV9EIXqczEDnEYkhpRKrKkiBAfXP3QNSud4FBpW1e7u3XTfsbnnNQY/rwF
X-Gm-Message-State: AOJu0YynA2+vckaFwpddp+D85sa4Ni5a3eOnzx0kBA0rpJ8CjU3y4Wmz
	hsoSaiLpDDJ9NU6b/85LaiYHS+YuLMT2Nweac29Ms21PJWq8W+0abLJnIw0IqA==
X-Google-Smtp-Source: AGHT+IHGg8Oq0FNDCNnUG12+MIKam5JOLm5lHVx4R8foCcBX//m7saHYLKuLVznN3ilAFFW+PI4EXA==
X-Received: by 2002:a17:903:98d:b0:1e1:214:1b7d with SMTP id mb13-20020a170903098d00b001e102141b7dmr1718191plb.61.1712706085513;
        Tue, 09 Apr 2024 16:41:25 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e6-20020a17090301c600b001e43a00ee07sm4255351plh.211.2024.04.09.16.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 16:41:25 -0700 (PDT)
Date: Tue, 9 Apr 2024 16:41:24 -0700
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
Subject: Re: [POC][RFC][PATCH 1/2] mm/x86: Add wildcard * option as
 memmap=nn*align:name
Message-ID: <202404091638.2F98764A41@keescook>
References: <20240409210254.660888920@goodmis.org>
 <20240409211351.075320273@goodmis.org>
 <202404091521.B63E85D@keescook>
 <20240409191156.5f92a15c@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409191156.5f92a15c@gandalf.local.home>

On Tue, Apr 09, 2024 at 07:11:56PM -0400, Steven Rostedt wrote:
> On Tue, 9 Apr 2024 15:23:07 -0700
> Kees Cook <keescook@chromium.org> wrote:
> 
> > Do we need to involve e820 at all? I think it might be possible to just
> > have pstore call request_mem_region() very early? Or does KASLR make
> > that unstable?
> 
> Yeah, would that give the same physical memory each boot, and can we
> guarantee that KASLR will not map the kernel over the previous location?

Hm, no, for physical memory it needs to get excluded very early, which
means e820. So, yeah, your proposal makes sense. I'm not super excited
about this be x86-only though. What does arm64 for for memmap?

-- 
Kees Cook
