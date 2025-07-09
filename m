Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5CB23507E;
	Wed,  9 Jul 2025 18:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752086218; cv=none; b=fhV33/27N8wP6U3t8RWRc4898eyjp6DPadgLOhi/IjA+W2leXEVxsoSu11oO9I1fM6sSmvJmbuhEDSmNTxMcj231ZLX4dJbZJu5eqzBLrWWGoUbehMMeVrICCgpGEo9EHjzlOSjCutTSVwWyTSdqC4Im12tGoAVT9nKtKZf3FO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752086218; c=relaxed/simple;
	bh=gHaZAdE1BBdg7Zp28gqXMRUhC5PTpi7Kocy4ZA067d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4//Fku32cz0XOVCY4X3xJNsSurgUKNwEAlJKRfle3WQBVmw+DX6QXsUzozFEivtt0060qlzlWDwMYZdr1gbxge6fm0sPJrhXAWcUoKTXAnJ1zH21uXj+aQEQLojRDdVHskA+cfyjZBSrY0BgLC0Dsz8vnpqfVGbVmClHjisnw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fA8tmS48; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W+lySQyn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fA8tmS48";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W+lySQyn"
Date: Wed, 9 Jul 2025 20:36:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752086214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YA0RYj+SqjdQ0NF6AXC9+gTGB1RXO4+dpLi7zGFrlOo=;
	b=fA8tmS48Cs0Iabw+qtrI7DLH02e7QBsB5ZaKK0G9KzNK3g0m8ZXzrSv+312x6LUsvu1f9q
	CAt4BGlx5GE5piE9feCWhiZfe4kQ0Fj3lg/Qu+NQ6u9fqGIwmCCVjX2b+NfNZgfY2XgiIQ
	+mNxRuoeYvgCeb0xiUfnKt6x+VlwKVIZxrANgJ2Sw67tbrqccK1MS5BTrOGgPjYzSvr6c1
	de57TcmPrDf/E86/NMartKExuLT+QF24PLgb9Mqhm9hSvnkkAa26p16MyE6FlCdjGBgY+x
	xewrKV3YfT9UkIKH8HOtzTMyWXwvCHxIXMQfZb7jYglrrkBi8Hpe3GYcekW+/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752086214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YA0RYj+SqjdQ0NF6AXC9+gTGB1RXO4+dpLi7zGFrlOo=;
	b=W+lySQyn8xxB3c14eOgOInlvGBZ0F3HR2dUZ1bGMw//bq2zUmU4JFCfVc27S0ad1/dJI2b
	F5ypJLDtYDXVexAg==
From: Nam Cao <namcao@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: John Ogness <john.ogness@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v12 00/12] RV: Linear temporal logic monitors for RT
 application
Message-ID: <20250709183652.Vjv2xgMx@linutronix.de>
References: <cover.1752082806.git.namcao@linutronix.de>
 <20250709140245.555f5fd6@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709140245.555f5fd6@batman.local.home>

On Wed, Jul 09, 2025 at 02:02:45PM -0400, Steven Rostedt wrote:
> On Wed,  9 Jul 2025 19:56:17 +0200
> Nam Cao <namcao@linutronix.de> wrote:
> 
> > v11->v12 https://lore.kernel.org/linux-trace-kernel/cover.1751634289.git.namcao@linutronix.de
> >   - drop the applied patches
> >   - fixup build failure when CONFIG_PRINTK=n
> 
> Bah, I didn't see this. I was actually testing this series, but the
> tests are having issues.

Sorry, I also didn't see this build error before :(

> Anyway, I'll apply these instead and restart the tests.

Thanks!

Nam
