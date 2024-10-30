Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF7F217461;
	Wed, 30 Oct 2024 21:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730322935; cv=none; b=f/TZ3NE5r1SsuwtnaKnHaYxizRbxenLBYRsyWJS8U0XWOOFJzBQlsYkkBLkjWcVX1e/OML2TYhC1Ygp4gGvj5BfgMIBrdwJl4lPmeW8Pf56BML999pjvBjqySnwsa/dP5xOQBOp5olUKcvYdxRi+RaaElqCKnXWKIS67Wf+Z1Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730322935; c=relaxed/simple;
	bh=83l95pjNKcaj8A+oDbBqZmvmNHpTJzt8dW28agHKm8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O54w7EcwZ8kxqZJoHHUw8aKP3XCQHvN2XkeYhxwM3JJAIbBgH3OGm9+d+a801dxF+5qqRp/aEWZI00bIa4QtLJgRRz5MgwbrQ+39AgUesZ5saHgv0UTK1KfGIMqnMJWSVY01ejAGN/SP2iubZufT5oxnnK36U4Yj+3jks5f/mYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6283C4CECE;
	Wed, 30 Oct 2024 21:15:33 +0000 (UTC)
Date: Wed, 30 Oct 2024 17:15:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Make percpu stack trace buffer invariant to
 PAGE_SIZE
Message-ID: <20241030171532.7ed01770@rorschach.local.home>
In-Reply-To: <42f825a2-ceb6-488a-8c63-fcc879cce096@arm.com>
References: <20241021141832.3668264-1-ryan.roberts@arm.com>
	<42f825a2-ceb6-488a-8c63-fcc879cce096@arm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 08:50:16 +0000
Ryan Roberts <ryan.roberts@arm.com> wrote:

> On 21/10/2024 15:18, Ryan Roberts wrote:
> > Previously the size of "struct ftrace_stacks" depended upon PAGE_SIZE.
> > For the common 4K page size, on a 64-bit system, sizeof(struct
> > ftrace_stacks) was 32K. But for a 64K page size, sizeof(struct
> > ftrace_stacks) was 512K.
> > 
> > But ftrace stack usage requirements should be invariant to page size. So
> > let's redefine FTRACE_KSTACK_ENTRIES so that "struct ftrace_stacks" is
> > always sized at 32K for 64-bit and 16K for 32-bit.
> > 
> > As a side effect, it removes the PAGE_SIZE compile-time constant
> > assumption from this code, which is required to reach the goal of
> > boot-time page size selection.  
> 
> Just a polite bump on this... Does anyone have any comments?

No, it's in my queue. I've just been traveling.

-- Steve
