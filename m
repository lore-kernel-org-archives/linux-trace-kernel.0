Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADAC2D627;
	Wed, 29 Jan 2025 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738140570; cv=none; b=mZCT53NUDl6Emi3T67QhpesQbbRiJq79bdyeEDtvrwt6kKnT3IG1pNPJLefYA64uqxfH/xAKAYtyrFhfeeP/9elt3NedAVKVV+YyUPopQJSPXEhjvvWFGKh/LdHuqvb968lnNgzWYltOZbpTMrnEX63+NlGhtu00Bgcto81dUfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738140570; c=relaxed/simple;
	bh=bfE5SYCj6V6UGdS5nxgXa4coj/GqRR42VAWC/OQdfdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcwCWAp1ITK5u1L0X4z+v2fP4PR1alv3I3GF6EayINDrTxQe1q3BMwFiPeWh94blGqns5ZmqCbcLxkDXJTpcUQUmbM7hOu5OuKMcjwH33IWA+Rgagr9DIT/MmRwrlAwCPHVTCwwnV8XFsFulNnabhcEZCuKTDrx9zvWL1mu5Cl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EgqXPD2n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cLGLy8J6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EgqXPD2n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cLGLy8J6"
Date: Wed, 29 Jan 2025 09:49:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738140566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HWDa3Gqo/kGFpJg8UdwNt1BI9/6SVntZxXt0O+HMAv4=;
	b=EgqXPD2nlNjvI/AwTQCjsLiBYLztgsdcgSzPzlyEmYToc0fH4cysRY/N6Zgzaoh8hLjl1d
	4TRntrvXAHJhPs1IgJBQbvVLinsAvXnmiKdyOzIO06i0vsKUsWdBvgAdGCJHM0g6jQKkqp
	1FhGQP3ov+sXMaQ5A2zkTLGPGzUw4IzC80wkbYfUBWD9FJJlZrn0f1mNI8BfuBn2/y8+md
	CbOT0HDwv6vlTc/Ewgc6+/FcZYT5ujU+7/NxM564fxKj6cz6cxOovDM3JkBMs0SN8RO/Jw
	TALQrG2MFgZKA6S0geeoBAa5HUbO3dyCJ5Ohb7qRPa59sq9ilb67X5JN2eCqQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738140566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HWDa3Gqo/kGFpJg8UdwNt1BI9/6SVntZxXt0O+HMAv4=;
	b=cLGLy8J6Hm6ttpUNS8VC9RAa+xOQCxBYxl1zofnw/S1LlaGyoobe9dL6YC5QCdLKkMys7F
	zIFNxR/O+inU+GCg==
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
Subject: [PATCH v3.5 25/28] kprobes: Use RCU in all users of
 __module_text_address().
Message-ID: <20250129084925.9ppBjGLC@linutronix.de>
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

__module_text_address() can be invoked within a RCU section, there is no
requirement to have preemption disabled.

Replace the preempt_disable() section around __module_text_address()
with RCU.

Cc: David S. Miller <davem@davemloft.net>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
Update due to the collision during the merge window.

 kernel/kprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 0305692106709..9c8afbb957b0f 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1547,7 +1547,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	/* Ensure the address is in a text area, and find a module if exists. */
 	*probed_mod = NULL;
 	if (!core_kernel_text((unsigned long) p->addr)) {
-		guard(preempt)();
+		guard(rcu)();
 		*probed_mod = __module_text_address((unsigned long) p->addr);
 		if (!(*probed_mod))
 			return -EINVAL;
-- 
2.47.2

