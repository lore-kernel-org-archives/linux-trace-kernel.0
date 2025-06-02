Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EC0221F11;
	Mon,  2 Jun 2025 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748878093; cv=none; b=kG29Txctmzy6y1Teq7Qtr57ZAfrHSK2bEr2Xfawbly2jv/wsHHMR8bNMv3tNHXWM2kEOw7eqgXY4F3GU6m8l3HRQdGJn/MaD/k8ln4EMwRNv7Otyuruga3oPMiz6En3TmiBWVVIxFU+vfFW1J16oKJR5z17plHUH9wM/OYVqUYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748878093; c=relaxed/simple;
	bh=lijPfkZN/tT8GZJxlXS+MPwdhJl0z6UmpfsGFQ+1Wfc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sebQqRE6MQtRxSksK1aO6y6EH/9CgpV9OfwPS4ytg12Vm7nT7KbBo9gid9laQ5SdiiQN3HQ27QKjXn4Mjukqg2H0Ywo8y5Ep9KJQTrppsSAzBS3oKk7i0gEZIwt7e5fIq/yTztNs6qR0HeSfN/nde329fNOA8wMf69WNRljee+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=moPyvasU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uK+/hVcl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="moPyvasU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uK+/hVcl"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748878089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lijPfkZN/tT8GZJxlXS+MPwdhJl0z6UmpfsGFQ+1Wfc=;
	b=moPyvasUelBOeiv7p3PFDmL2XZYPe2K4Qzp1H4t9pAkBDp/P5iXpwn53eeBpfXCK54vXCT
	GBD1d93epBzX/i6k0vcNQ6rZRiRId16awsWj+RPxRI/zLhMjZKZsIbX2j/sdqss8Zj/Zms
	CrHa7qZkrDYf+KTas8FSvjdoEdAPdjJ84KwBTa+RQoQwZrF1bx43NU4S555wbwmY8xlzVW
	e8Xn6ow4qihB2EaazczleYbARiB289CXwReuV1qZ291TOHrD5zguwRX596sZrWNEAPPueq
	CXUzGsoMfy7TFvbxow+SKHn6aPfemzjeAo3aTakajGKBfbReGDUGG4Za43D7Dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748878089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lijPfkZN/tT8GZJxlXS+MPwdhJl0z6UmpfsGFQ+1Wfc=;
	b=uK+/hVcl6azTZfzEh2lasNceDq109HoSc9gbLHA8K3YF6LZXsnxacu5K5zAfEF0G5PjHXC
	vIq+x79O8EJdROCg==
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Juergen Gross <jgross@suse.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] genirq/matrix: Remove unused irq_matrix_alloc_reserved
 tracepoint
In-Reply-To: <20250529135739.26e5c075@gandalf.local.home>
References: <20250529135739.26e5c075@gandalf.local.home>
Date: Mon, 02 Jun 2025 17:28:08 +0200
Message-ID: <87zfeqp3hz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, May 29 2025 at 13:57, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>
> The tracepoint irq_matrix_alloc_reserved was added but never used.
> Remove it.
>
> Link: https://lore.kernel.org/all/20250529130138.544ffec4@gandalf.local.home/
>
> Fixes: ec0f7cd273dc4 ("genirq/matrix: Add tracepoints")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
