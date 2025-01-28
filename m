Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509AD4430;
	Tue, 28 Jan 2025 07:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738048248; cv=none; b=Fuo3aMRqZFFRF98ASQpY8nz0/aT6e4RXIbPKCpr/rfJ7S+/Pteb+jGfwx00Th0rKxD1DBu6p7lwLhM0hqijUkqV9dVecnduTcZD4IhusZE9mv39KJ9tKh3N3T916quKl2s4/10cPolvZsjlXAdBa4X6l35vxwyCvYdlh2IIJk/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738048248; c=relaxed/simple;
	bh=PsqyzNGenRbfWxCHFMRmZd6HZRcU6KsEdJnPappk720=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q80K8+JbH1ZMEGsgxSKt/5nusMhiWZzeOmZn4hNQZk0ujrqRy/O9Nh3uTcWkRfPI2wyz6Q/baZVqhBlOfy5sBmO05VRZaV5EcWiimipD+REvHksMRi47Bg7e9lifu+h4B+pm7+alhXnE+sv95QP6ZTSXXUcClHux8T5JNJ1zsbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w2UXfKtF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zYRFqxTW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w2UXfKtF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zYRFqxTW"
Date: Tue, 28 Jan 2025 08:10:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738048244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F1CZKdS/EEGo9ONyxupcu7KFdFSjQzppoP9SsJA3heY=;
	b=w2UXfKtFK9bLVrVetqsjHg5ln9/A82SsPZsf4HevOd+7JpsiHEyrr7IrykthI4dxrqrbY2
	a6ZcAvie4n7VIG51gKNlWEgw8DUz+5OgZ3rLnbBp5oAW8U7g5YKmK0Q9bznWLzajOIF6cn
	GCNwyF/B8x/Tsfk5myi3G7dgee03a3BcSXLl/CYOf56WDcYvOv2dmNdDwC98LE5yg6a4x3
	VvQtzsjaqTfohJrMfubUMzUKjVgSdAzi4Ei/E6mpp0+CqNVoE1GTZg1MZyCPtX6JxVklne
	wii31RHB8orEH7Csb6uhm7ITUrj0uPmnamoqCYrA5OjXZhAraFE9d0+FP0wj6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738048244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F1CZKdS/EEGo9ONyxupcu7KFdFSjQzppoP9SsJA3heY=;
	b=zYRFqxTWk+RhM2UsYdbzrDnjqSSUPDaRpYH1CAPoChF3ZQfE0sP6Q8IrykBXtbaky8bNzy
	nUXO6VUc4z2llaBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Naveen N Rao <naveen@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 26/28] kprobes: Use RCU in all users of
 __module_text_address().
Message-ID: <20250128071042._1aW_jx4@linutronix.de>
References: <20250108090457.512198-1-bigeasy@linutronix.de>
 <20250108090457.512198-27-bigeasy@linutronix.de>
 <20250128144452.fb5f9741e58f059c7cdf4ce9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250128144452.fb5f9741e58f059c7cdf4ce9@kernel.org>

On 2025-01-28 14:44:52 [+0900], Masami Hiramatsu wrote:
> Hi,

Hi,

> Since the below cleanup has been merged, this patch needs to be updated.
> 
> https://lore.kernel.org/all/20241121-kprobes-preempt-v1-1-fd581ee7fcbb@linutronix.de/
> 
> (may need to change the guard(preempt)() -> guard(rcu)() in the new version.)

Thanks, I'm on it.

> Thank you,

Sebastian
