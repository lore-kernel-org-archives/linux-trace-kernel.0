Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C682512E8;
	Mon, 10 Feb 2025 22:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739226615; cv=none; b=PYkxeXRqajFp9UgJSJgGAUhoy8Uy90i6D1nybEo/GBixW9EVGH2qbjY+URCQ75z4stt4RCEQ7Jx1QlpBEHpn61msVLA68p/DxOLW2sVRYzI/TMMUEhPuZo+hWLCimnUubkEIedDAYQx939LiK4BnMwNzh1OT2Mu4kiQLbYWNReg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739226615; c=relaxed/simple;
	bh=On4u1pJ/lcFgvG7Fm6nIQ+470cFF1Kng8YnIj3HQR8k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZYcjTQVK13eUlsjTci3qbV5eJqC79YyxPWwNDZDzgcGUcQ5G46NjxzntT1FHAaBwixHvxJ/0u9AdHCqoUQYk6lMd9DekIt1FV0Cx8H9U2LeqsdQxW6guV9BIidbj4RlPBY5yEBkDHtY2bBwELZ8hmN+AvajBvkHRq1sf8wOQpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE61C4CED1;
	Mon, 10 Feb 2025 22:30:13 +0000 (UTC)
Date: Mon, 10 Feb 2025 17:30:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Gabriel de Perthuis
 <g2p.code@gmail.com>, Haiyue Wang <haiyuewa@163.com>, Sami Tolvanen
 <samitolvanen@google.com>, Mark Rutland <mark.rutland@arm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H .
 Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ftrace: x86: Fix a compile error about
 get_kernel_nofault()
Message-ID: <20250210173016.0ce79bc8@gandalf.local.home>
In-Reply-To: <20250207085959.b3e9d922eab33edf885368e3@kernel.org>
References: <173881156244.211648.1242168038709680511.stgit@devnote2>
	<20250206081225.GI7145@noisy.programming.kicks-ass.net>
	<20250206205449.5f83a585945ae6eb0cc15483@kernel.org>
	<20250206121328.GN7145@noisy.programming.kicks-ass.net>
	<20250206123307.GO7145@noisy.programming.kicks-ass.net>
	<20250207085959.b3e9d922eab33edf885368e3@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Feb 2025 08:59:59 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Ah, this looks good to me except for the removing redundant asm/ibt.h
> which Haiyue pointed.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Cool, so Peter's going to fix this and I can drop the fixes that are in
patchwork?

-- Steve
