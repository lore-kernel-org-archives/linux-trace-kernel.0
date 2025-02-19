Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FD11EB199;
	Wed, 19 Feb 2025 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739977221; cv=none; b=Rwn1oar4AGgCGqqTCWZ1Ub8rPRc2yUQ9AAXWK4tvzhV5SyCW/WSZEfdVSXE8bHtJaoVljzxv/Ras/WiUaa0JjlZlyEhDg5nkezCZoxSmdnxC20y85LHHHEpGPBMChPNsvLNIbeKbdGkfiJSZALeUd9lFn35ZXAqsVoQtdLycPzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739977221; c=relaxed/simple;
	bh=e2lTigeWc6aXdooPpxHRdq3kQCCHYGJXNTOg6KmbD0E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eenaFP1ICHJevIbDByXNKkG2mqoy/1373cBgd2bHS7eqk/uxm9Yv+3OBWL+rIsZ6KMsotxPpc15WTOc4NLSjntJKHlh8LjQK880rfFbxW5DM5sj7S0EM9X5h58Af+XxeHN0ZqRJU64algzCr7/CYKrMT37gnEFApI8jb4Ot2aj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DB7C4CED1;
	Wed, 19 Feb 2025 15:00:19 +0000 (UTC)
Date: Wed, 19 Feb 2025 10:00:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Sven
 Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 5/5] selftests/ftrace: Update fprobe test to check
 enabled_functions file
Message-ID: <20250219100043.32f3afb6@gandalf.local.home>
In-Reply-To: <20250219100111.6e2c749e17b0f5e451cd6be0@kernel.org>
References: <20250218193033.338823920@goodmis.org>
	<20250218193126.956559192@goodmis.org>
	<20250219100111.6e2c749e17b0f5e451cd6be0@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 10:01:11 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> This looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> BTW, would I pick the last 3 patches via probes/fixes branch?

Only if you think it's necessary.

Or I can push the entire series out to Linus this week, as I plan on basing
all the new work on rc4 (which would be released this Sunday, hopefully
with these fixes).

Or if you want, you can take the entire series if you want to push it to
Linus this week. As I'll be basing off of rc4, it doesn't matter who send
it to Linus as long as it's there before Sunday's release.

-- Steve
