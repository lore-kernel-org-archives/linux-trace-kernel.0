Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A166FE55B;
	Mon, 21 Jul 2025 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753110944; cv=none; b=ofqpKARmzTY7R9wNU+UwMGAYkOX5X+qSC/pri6SU01NNKCx2yEdPJlny9+XnBC8V3565NmisxKjgSQUJN+vTybuE0PzQwsQjzzvwCQ1pUgUJSg4pKZee1OeRX8n2BBtJKdioWaPcXnEpK1JCzNM5fOZPsJ++FLvGfGTljjz09BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753110944; c=relaxed/simple;
	bh=6/7aExFJkxOwLw78r5brWycPpzr4k6dmoO402VCFHys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d57SWcEhffP97O9A/wIbx3t50HMGQsIcv9YXL+IbJIFQdBHJvqXk03zbrHMQ/kvX20zYJYdLUpquHRq3kot56w5e4w4BG2RwBiNTeJW/b1T6r+0G9VN28WiOc2loFwtj2VW/xIrQ5sjZvavyf7sd7v8EBGlKQ/dhbsYIVQkExps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=17Kwozq4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8de6h+pd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="17Kwozq4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8de6h+pd"
Date: Mon, 21 Jul 2025 17:15:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753110940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dzbh3RdKnhVKI7pyWYDdy13al39jKyzCMr6I0KG52wQ=;
	b=17Kwozq4JODdnw0nzGY5Y2k/qePhE8TNfInZ901E/yj+vGOGh4EWcAsu34+G5T552lZ6Ep
	M5pqOsxHV/EL3O5rF0XgKEDaGBz31dxd/rpeQH3fc5WvOLMaMqX74M28YRqod6h1ZoF3xx
	HzuShuKE1ovlLgVxSJnd0/h9s/iKVs4TUAngbM/RrDLqeLc4og8C8NZBNh6/gXVTN/IpV3
	T9+OjXIaBfMmkc8VCB5K4TRCTHIEH806xAUSmD51HYOMcW8UHBs1DXlgmgqp/7HmjkFBD1
	nxMQ0eBX5uWs7Fz9gYUoQ/CDXnpuDbM7OsDMZ3vkC9UB6lmcOj/ijYWNQGSnwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753110940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dzbh3RdKnhVKI7pyWYDdy13al39jKyzCMr6I0KG52wQ=;
	b=8de6h+pdHXfEhx7jV4N8gI1mOnmxDC8iYRoyu9FpCHC4azB47PGaxO1VAelJYk1hBki3Oi
	2xGZy7LejYcBnkBQ==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v4 12/14] rv: Replace tss and sncid monitors with more
 complete sts
Message-ID: <20250721151539.EXglDXpl@linutronix.de>
References: <20250721082325.71554-1-gmonaco@redhat.com>
 <20250721082325.71554-13-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721082325.71554-13-gmonaco@redhat.com>

On Mon, Jul 21, 2025 at 10:23:22AM +0200, Gabriele Monaco wrote:
> The tss monitor currently guarantees task switches can happen only while
> scheduling, whereas the sncid monitor enforces scheduling occurs with
> interrupt disabled.
> 
> Replace the monitors with a more comprehensive specification which
> implies both but also ensures that:
> * each scheduler call disable interrupts to switch
> * each task switch happens with interrupts disabled
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> 
> fixup sts remove sncid

Is this here by accident?

I cannot comment on the model. The CONFIG_X86_LOCAL_APIC case looks
complex, but I cannot comment on that either.

But things look fine from RV perspective, so:
Acked-by: Nam Cao <namcao@linutronix.de>
