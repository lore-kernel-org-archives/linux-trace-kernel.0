Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4724A1F948;
	Thu, 21 Aug 2025 19:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755804315; cv=none; b=RiYvaGqTsWBWStynGOECMG0+LZm+T+Du++SozCfu6y94oczLok09Vwx3ZMIBNFOJ+Iybyh6L65iZjak/HEFO5FijsAboovDixiEubI2LBGZceOU94ujq0W0UBuYTc6sTimDyTQoY+QMWEGqeXmryJkT76wsPeyGFZgylwc9+U+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755804315; c=relaxed/simple;
	bh=hGBRAm2pJ2TGTxPHI6wNV37hN/B9Cqnijx7TVlmJ478=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dOWvvh6W/7jLz8KUoKlRpvnSg8V1W7XHwDrtzJ6UPVaAm1CFDyKROXQSHW0E0iKEDHV8ztp3I1zPxIH3BCMMrptJX8dMQqLzGt8sGY7s3vVD3DiEcaVGQAY0Ccsxf/BdMB/h2yVSNQSZD+LOqptbR6w1Y9vv3QzH2XJQDzloyNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id DFB08591EC;
	Thu, 21 Aug 2025 19:25:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 09C846000A;
	Thu, 21 Aug 2025 19:25:04 +0000 (UTC)
Date: Thu, 21 Aug 2025 15:25:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski
 <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Daniel Gomez <da.gomez@samsung.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, "Liam
 R. Howlett" <Liam.Howlett@oracle.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra
 <peterz@infradead.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
 <samitolvanen@google.com>, Thomas Gleixner <tglx@linutronix.de>, Yann
 Ylavic <ylavic.dev@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 8/8] x86/ftrace: enable EXECMEM_ROX_CACHE for ftrace
 allocations
Message-ID: <20250821152509.391c1ebe@gandalf.local.home>
In-Reply-To: <aKa4otIF6AbhD2X3@kernel.org>
References: <20250713071730.4117334-1-rppt@kernel.org>
	<20250713071730.4117334-9-rppt@kernel.org>
	<20250820184743.0302a8b5@gandalf.local.home>
	<aKa4otIF6AbhD2X3@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: cyn6qk3us8ocdtde5jpyb3zckzedttjn
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 09C846000A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+CMQG1BETxfdgNxC+cxIEgpiTvO2qKdGo=
X-HE-Tag: 1755804304-494471
X-HE-Meta: U2FsdGVkX184fcxufunVUclfn8DfVrb7JSHS5xeDl0+1DGaNCkqXSAQB78+nX+M9qFzJ+XEGE2xq2wEmhekhDhz0ls29PxPTia0KyCKj2DS3zUHhUKuOG29rvKqA+da4TRvTzYXkmRMxM9yYhP18JaBtbtIBqbDN8KtB5JlbHT5fUu9woGnAPIAoY03eAKVC7nP20wT5veRaNV7o/14O3bY+RR1I2T2s4pkHB1P2h+mTipvoybEfHmn99WxpnapDf4+skh9FOH6Xu6SLdfXz2koCvyMhzz1Aqg8laodsKkDWG+QUPEdGygjNSu+CKwtFaktA/6OzKZRKcuRIwbXZLnWXVDAgIOzhUUC3b75/yXlYBgamghT2isHwhNVCZfb5pWzA9SRRaB2BrM3UVRUBdg==

On Thu, 21 Aug 2025 09:11:46 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> maple tree is initialized after ftrace, so the patch below should fix it:
> 
> diff --git a/init/main.c b/init/main.c
> index 0ee0ee7b7c2c..5753e9539ae6 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -956,6 +956,7 @@ void start_kernel(void)
>  	sort_main_extable();
>  	trap_init();
>  	mm_core_init();
> +	maple_tree_init();
>  	poking_init();
>  	ftrace_init();
>  
> @@ -973,7 +974,6 @@ void start_kernel(void)
>  		 "Interrupts were enabled *very* early, fixing it\n"))
>  		local_irq_disable();
>  	radix_tree_init();
> -	maple_tree_init();
>  
>  	/*
>  	 * Set up housekeeping before setting up workqueues to allow the unbound
>  

Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks,

-- Steve
