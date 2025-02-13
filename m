Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BDF211A0D;
	Thu, 13 Feb 2025 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739443228; cv=none; b=tGLcr5mfb1Ad+N51WWE1HXimB1Vm52m6JViPMlN7gvh4Auxw0KEtwd93ITa/5EUdgP6c+r2Getp/207BFSme+Dg/QFgjkwXtjOW4o2a1SS+ZQtYm3age8OHchLAnPosN8EPlIDYzzBmB/5urjl80qQXSz8XeMxSjeBr3NBwrrik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739443228; c=relaxed/simple;
	bh=nlI8DXh6tRmM3EDxHee1gmgyvZXId7Jr12OQ0xEC7zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrS5Mc8om/BZqXGh2HmaBnHVedCJkEaYmkPX/bVffMbJK1Bn282ff73Eh6kfKqiP89CW4ASFFsBHiRqVTlLf6N6xPXoz1aJj6xUWnVqCJK0hPwd1pg8LoI0sAHec/37UcKNUMC8oTLAV/mDBDJbtQ1tPH3tY5dgW9yY3DkJCPO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=o0Fl2GgT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o0Fl2GgT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lH5ArMbACkKyHoGFSOksU5INJkkZ8BeZNVoHrbssNbg=; b=o0Fl2GgTmsXXY2o+r7xvH1Hed8
	9kAqTomd5QGtPIOBdtQ9SKdc2dxupT9arC0cok2llTn07UMPm6VZXXmugIFsrEFu9pwxHjOp1J7cc
	Y5Bf3z8CaIokzsye5sw4J8VV81MvIBcrcH/4P5X4DmfyMesT/rNTbF2RpidNPCzivW8YbUF4PBKvf
	IVoKSHywqwLzwrmQeaiIeQRP4MhPjsIkF+s4XYjIgjit8UzELZNsHUMb8z5C55bGfRxX7RpupOGlc
	4Az7z4TAIXsRbYbAP2vSSHjWdQPsC2j1BYCXMchhgBuydMM/GhgBDUaErzhXtjvoY7BpLGjgd0Sre
	K1x8OSVg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tiWdj-000000080Hj-1tYQ;
	Thu, 13 Feb 2025 10:40:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B4ED83001AC; Thu, 13 Feb 2025 11:40:14 +0100 (CET)
Date: Thu, 13 Feb 2025 11:40:14 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Haiyue Wang <haiyuewa@163.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Gabriel de Perthuis <g2p.code@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ftrace: x86: Fix a compile error about
 get_kernel_nofault()
Message-ID: <20250213104014.GD28068@noisy.programming.kicks-ass.net>
References: <20250206205449.5f83a585945ae6eb0cc15483@kernel.org>
 <20250206121328.GN7145@noisy.programming.kicks-ass.net>
 <20250206123307.GO7145@noisy.programming.kicks-ass.net>
 <20250207085959.b3e9d922eab33edf885368e3@kernel.org>
 <20250210173016.0ce79bc8@gandalf.local.home>
 <20250211100914.GA29593@noisy.programming.kicks-ass.net>
 <20250211105002.31b5a517@gandalf.local.home>
 <CABCJKudwf11wAbv9NdKh_FN-Z+pLaupMHJxNGtRKK1-1D94hCQ@mail.gmail.com>
 <20250213100836.GC28068@noisy.programming.kicks-ass.net>
 <08422aab-f4a9-4f67-84ef-82ad3663b01f@163.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08422aab-f4a9-4f67-84ef-82ad3663b01f@163.com>

On Thu, Feb 13, 2025 at 06:25:41PM +0800, Haiyue Wang wrote:

> It is header file include indirect :-)
> 
> https://lore.kernel.org/linux-trace-kernel/20250206131711.ea536f165d5b5980b3909acd@kernel.org/T/#t
> 
> File "asm-prototypes.h" is added to entry.S by 'scripts/Makefile.build',
> adding the missed declaration header file can also fix the error:
> 
>  getasmexports =                                                        \
>     { echo "\#include <linux/kernel.h>" ;                               \
>       echo "\#include <linux/string.h>" ;                               \
> +     echo "\#include <linux/uaccess.h>";                               \
>       echo "\#include <asm/asm-prototypes.h>" ;                         \
>       $(call getexportsymbols,EXPORT_SYMBOL(\1);) ; }
> 

So this is simple enough; but the thread you link to also has another
hunk, which makes the whole thing unfortunate.

I'm not entirely sure what this GENDWARFKSYMS nonsense is about, but it
should not clutter the code like that.

