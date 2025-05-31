Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B4F1487E9;
	Sat, 31 May 2025 20:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748722762; cv=none; b=lXh1fcbMNJSdsyG/vaa48T6BYgYnx2ngtL4K94KPDi5QlVTQRw7nl+zpQedOsN9cr7WOTspOncy+CMoqiF9dmUltqDRdegQ+oE1Lc4ZiJBdoB1g1LiuIikNn6Hu92Bv7pRFPFICkTxRO8M0etAvJW8yTjGfvynqDhgKJywkcefM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748722762; c=relaxed/simple;
	bh=erAyjsqjStgVouI9Z5+V1KtR7M4lw8/lfdZTRc5Gl0M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDJ7JGGp2j6KMBT0vaiO/V+v9lLMoKRNPcvCko4Z+3F/9Ayjbx2cTs85mUbntOLTWOhKwryoSUrMA/uairyg83Xb96VBG4q4pcllMG1Zr8TCU1zKdJAZyp77rInN5Sj0hQhJRcOR9tsiaU2PZPIMEeEv206LNgZzqqHmeOIlHJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4078C4CEE3;
	Sat, 31 May 2025 20:19:20 +0000 (UTC)
Date: Sat, 31 May 2025 16:20:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, Oleg Nesterov <oleg@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu
 <mhiramat@kernel.org>
Subject: Re: [PATCH] x86/fpu: Remove unused trace events
Message-ID: <20250531162028.5db6e2f7@gandalf.local.home>
In-Reply-To: <20250531161723.1ea6a41c@gandalf.local.home>
References: <20250529131024.7c2ef96f@gandalf.local.home>
	<20250531161723.1ea6a41c@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 31 May 2025 16:17:23 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Can I get an acked-by, and I'll pull this in through my tree (with the
> other patches that remove unused events)?

Never mind, I just noticed the tip message that this was already merged and
going upstream.

Thanks,

-- Steve
