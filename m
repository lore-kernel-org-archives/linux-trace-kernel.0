Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA53322DCC;
	Tue, 23 Sep 2025 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758630067; cv=none; b=uYes0SxrRyg7dY/voKdkazuv0DPE2Inme2y38oNfle+1ILKJqR94zz1oVWJcVF2uRGsvq2qynWax7Gz4a4rQjb9dILOTZFrff5t50yUe8RQ592vPPHognMsUT/x2CwljJ+lm93LD/wEFtazFNMe1wea8wcffMQpaqQaJKmITyGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758630067; c=relaxed/simple;
	bh=ABLo2jswb6oVMptEftv8ZsbLxy2tNSDg2uZzb2foPKI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/jlHA9vN4xuQ7XxykJ/V2LAstezABuN8MEUcu6Eyt/pKjIjMTajv45u9PR59+p6oPMHH8RxECY79Z64usFQ4unHhTqvtV3L63fkruktUbsb9CZtM4JUHBG9wlDjsbOte12zddK+L1M/JdcRmMFyeo83ijvNg10ET2bnF9ecjkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRXpU6AN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRXpU6AN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A36C113D0;
	Tue, 23 Sep 2025 12:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758630066;
	bh=ABLo2jswb6oVMptEftv8ZsbLxy2tNSDg2uZzb2foPKI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bRXpU6ANnB781R/HoWY2ijE1V6SscU6ceJfwsdq2n0wLyZ02tPZWI1hMLNBO92udT
	 VvzwAe5tw5TVPNG8O6zfHO/v+3okXetiZZsBlJSY+DPa5uBZLkCyxOIjdIpoKcj7Ek
	 q4s6o/Y1MPVzI4rXsf/lGXLTSPIhqPDxUvS5V7I3lY03k+DzhxihWwplVgVSNpc6kJ
	 rfDqHavPNTK8YABIMcW7L6DTxd6mxGh/UMub9n2ggVs8vm+aG1Ltg8Npw0eZZk6aND
	 t8KhqXeeNPCpoU9H1AzhXpVn9V5tenTAmAudni+b4WR89hprP/QbeCzyu4iQHEbva2
	 3UEps51yVTLlw==
Date: Tue, 23 Sep 2025 08:20:59 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH v2 1/2] unwind_user/x86: Enable frame pointer unwinding
 on x86
Message-ID: <20250923082059.15fc17bc@batman.local.home>
In-Reply-To: <20250923105130.GG3419281@noisy.programming.kicks-ass.net>
References: <20250827193644.527334838@kernel.org>
	<20250827193828.347397433@kernel.org>
	<20250923105130.GG3419281@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 12:51:30 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Moo, and now you have me look at unwind/user.c:
> 
>         /* Make sure that the address is word aligned */
>         shift = sizeof(long) == 4 ? 2 : 3;
>         if (cfa & ((1 << shift) - 1))
>                 return -EINVAL;
> 
> Isn't that just:
> 
> 	if (cfa & (sizeof(long) - 1))
> 
> ?
> 
> Let me go add a patch to clean that up...

Sure, as long as it's commented.

Thanks,

-- Steve
