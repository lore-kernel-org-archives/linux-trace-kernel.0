Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D589C184F;
	Fri, 26 Jul 2024 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722025224; cv=none; b=My87xu9Xmo5QHqjdSLmFWUg/0NFOZ80XYrlwvrZ0UMBQC4aa2vSzYMTGfLU6yNNDRkOiFogqroz7kEkCjz8Cw71sAS6puTi4pK1esqE6b1ZpaTiuTqcBWv6+1yG4ZDSAq7PtUjFkmKOu+4q+Mt4rP7fiZ3p9xXKJIjSHAeSyrwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722025224; c=relaxed/simple;
	bh=Bfn77UoI+GDApZjtpAH6NYHQnNHZCa/ThotEFedtg54=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yb+ixjM81Gpn31/prnZtWg6s4Fa4397D5CM35Gs8nS2MM0mKCev7Xd+rHkWi9DVSQQYxI3jWgbn3rqeJAQBUq674b8W1uXhfQ64qnmuGuZMSEOHAF11baL99tfBJ90qvFllqTOo2WTCT/xfiMfoKgn7K/bNWlwHZm5tgLggfkP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE23C32782;
	Fri, 26 Jul 2024 20:20:22 +0000 (UTC)
Date: Fri, 26 Jul 2024 16:20:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathias Krause <minipli@grsecurity.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>, Ilkka =?UTF-8?B?TmF1bGFww6TDpA==?=
 <digirigawa@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al
 Viro <viro@zeniv.linux.org.uk>, regressions@leemhuis.info, Dan Carpenter
 <dan.carpenter@linaro.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Alexey Makhalov
 <alexey.makhalov@broadcom.com>, Vasavi Sirnapalli
 <vasavi.sirnapalli@broadcom.com>
Subject: Re: [PATCH] tracing: Have format file honor EVENT_FILE_FL_FREED
Message-ID: <20240726162021.63a86a9d@rorschach.local.home>
In-Reply-To: <ad2f644d-b77e-4cc5-8396-f02214010103@grsecurity.net>
References: <20240725201517.3c52e4b0@gandalf.local.home>
	<0b80cb48-6604-44ec-bfa9-f5ec1fc5d7d7@grsecurity.net>
	<20240726105212.120a74b2@rorschach.local.home>
	<ad2f644d-b77e-4cc5-8396-f02214010103@grsecurity.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jul 2024 21:58:30 +0200
Mathias Krause <minipli@grsecurity.net> wrote:
> >>
> >> IMHO, this needs at least the following additional fixes tags to ensure
> >> all stable kernels get covered:
> >>
> >> Fixes: 5790b1fb3d67 ("eventfs: Remove eventfs_file and just use
> >> eventfs_inode")
> >> Fixes: 27152bceea1d ("eventfs: Move tracing/events to eventfs")
> >>
> >> Even if 27152bceea1d is not the real cause, just the commit making the
> >> bug reachable. But from looking at the history, this was always wrong?  
> > 
> > All stable kernels should get covered as 27152bceea1d has both a Cc
> > stable tag and a Fixes tag for 5790b1fb3d67. And the stable kernels
> > look at what commits have been backported to determine what other
> > commits should be backported.  
> 
> Now you lost me. Neither has 27152bceea1d a Cc stable tag, nor a Fixes
> tag for 5790b1fb3d67. It simply cannot, because it's from July 2023
> (v6.6-rc1) and 5790b1fb3d67 is from October 2024 (v6.7-rc1).

I'm juggling too many things around. I was thinking that 27152bceea1d
was b63db58e2fa5d. My mistake.

> 
> >                               By saying this fixes 27152bceea1d, it
> > should all work out correctly.  
> 
> That would be fine with me, as that's what my git bisect run pointed at
> as well -- the oldest commit triggering the bug. However, in your v2
> it's still b63db58e2fa5d (which has a Fixes tag for 5790b1fb3d672 but
> not 27152bceea1d) which would suggest only kernels down to v6.7 are
> affected.

OK, I see what your saying. So the bug is present with 27152bceea1d,
but so are a lot of other bugs. This was completely rewritten with the help
from Linus, and an effort was made to backport it all to 6.6.

  https://lore.kernel.org/all/20240206120905.570408983@rostedt.homelinux.com/

The above includes the 5790b1fb3d672 commit. Which is why this is the
commit I labeled as the main patch to backport to.

-- Steve
