Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF01523D2B1;
	Fri,  7 Aug 2026 19:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786132256; cv=none; b=AJ+GFSEonhIvM/csjMROSZBUVo3IkJQrqYlMfoCwc8WyQzW3iS2wtdOx3WMqQrNQbpymaBORwisbDklInGTmoxyJy5303DIddba2/5ohM0AHSqP83p/hVnK4GEcgsnTCKtpOX/h59xucw5RsKnNHvSnM8VQ+Z3CDcdTipEXS1OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786132256; c=relaxed/simple;
	bh=pW2eRMSIRBmL0WZmmE4NhGMN16X8u7MJQrN1O38oywA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=X4607uZbzCJICHpyFfnnnVe3+kQIZC8uR/tqnPfYPqO0Q5F6Oh5EFQSik1FY6oo1ZplJ5/kNzlFx3xqgSvgQ55WXUysfVoOZa2xXJY2CNQ6YdtIrFScahOM7gVaS0uKR7eO46tBOdsKspDGrczRAzhbRu8xaL/aap8KSv9RlltU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=y1TxN7DY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="y1TxN7DY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55931F000E9;
	Fri,  7 Aug 2026 19:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1786132255;
	bh=LGQLBYZ8sXJOnkR3tH0uUyY8O3oqFIt4zUiX/ukeTU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=y1TxN7DYS0h5WK8bX+BiCJsu3MYwDVAHCQxDfN4c5JzJNvebxuBW9AdTC1+HhkvtA
	 zPmNA6JtgnATURgkCTCNYYg8+wZFZRicRYeVg2KQUCz5iMBL3nmVwP20D6Xp5NA4WD
	 gstX2HCC0T4ZJsgdoSsoNHqD8mPptk4Ne8r+9YRI=
Date: Fri, 7 Aug 2026 12:50:54 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Meijing Zhao <zhaomeijing100@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 0/3] mm: trace: decode architecture-specific VMA
 flags
Message-Id: <20260807125054.d69baf2c6df589ddebbccd48@linux-foundation.org>
In-Reply-To: <20260807084745.5d96995e@gandalf.local.home>
References: <20260723092905.761037-1-zhaomeijing100@gmail.com>
	<20260807031349.3119855-1-zhaomeijing100@gmail.com>
	<20260807084745.5d96995e@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Aug 2026 08:47:45 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri,  7 Aug 2026 11:13:49 +0800
> Meijing Zhao <zhaomeijing100@gmail.com> wrote:
> 
> > Hi,
> > 
> > A gentle ping on this patch series. It has been about two weeks since
> > it was posted, and I have not received any feedback yet.
> > 
> > Would you have a chance to take a look? Please let me know if I should
> > rebase or resend the series.
> > 
> > For reference, the original thread is available here:
> > https://lore.kernel.org/linux-mm/20260723092905.761037-1-zhaomeijing100@gmail.com/
> > 
> 
> You may need to Cc the MM maintainers too. Not just linux-mm mailing list.
> Modifications of tracepoints in subsystems belong to the subsystem
> maintainer, not the tracing maintainers. We just maintain the
> infrastructure, not the content.

get_maintainer isn't very useful with include/trace/events/mmflags.h.

As it's a vma-flags thing then cc'ing Lorenzo Stoakes (ARM)
<ljs@kernel.org> would be appropriate.

We're in lockdown-for-merge-window mode so please plan on a resend
after 7.3-rc1.

AI review made a minor comment regarding the changelog:
	https://sashiko.dev/#/patchset/20260723092905.761037-1-zhaomeijing100@gmail.com


