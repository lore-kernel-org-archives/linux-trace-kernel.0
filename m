Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A0840B6E6;
	Tue, 26 May 2026 17:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779817321; cv=none; b=ElPp+77jp1lJXvRv623SUBiigqs4y6An0zCUjB5VuJ2BeT3WpT+k6lrNgtuI4FonNYZyH28zuDnaohpL3/9sjE6hK9G4jtwtr18gXnb9zFtOoCxgZwyb6fNhgnIQ+Q3K8pFIeEs+SZEKeRJqAeWkspYt2YyngtuJIiEMoCQJvxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779817321; c=relaxed/simple;
	bh=oA9SYI3Vg6WjJ4my1cbreo9H4SpR6X837lBLcyW3YhU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QuZVhaNUB+uY75TXJTjtNU2tuYUu6PI0fxlojDrae0u33adtQ2z/Ye6e29NT6iaCm5+mPs4O82YEBxzmjFOa5H7DoD70ZrZNxErkimyyBNpNK/NSUZo28fcmyFmm3yMiSOyr7+fDfXgU1qaoUJLpXwqV45JYHA+Gxfuq9HLSlKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=an5wcbJQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="an5wcbJQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BAB1F000E9;
	Tue, 26 May 2026 17:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779817320;
	bh=Cv7RpCZ0KM+t4lyA/0h2jSx7KpF5KVLWtYodP6cq/2A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=an5wcbJQm1oN36GxareExRezPK4urPhPMC179lNuWGdcqh/Nx+aQCkJQc7IHivPOx
	 oYJYlAloklib5Ojlg/h0hsgjBmFmnPDhpdRjMWVx9F03MBTwh0mEajN8uEi4EkotAM
	 gDHzDOH+iwRLkn4HVb2KHEDidiAFMSOZpkb1RUT6awDlEzAVitq4lUGDXjq7h7SVmN
	 WI8OEsMQeNrXTALvxmFcqFKNELf3I8+bPfvXRkwi0zW4ipNgtn/1x7wqOuEnZi/eE+
	 TkiixAULbjfVMp43m/U/dNVMtozLMvYy8A6cF9N06s8t7cH6e4MRKslvMHvb56ZH3B
	 Ajo/3fNXeh8uA==
Date: Tue, 26 May 2026 13:42:31 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v21 0/9] ring-buffer: Making persistent ring buffers
 robust
Message-ID: <20260526134231.1a65aef5@gandalf.local.home>
In-Reply-To: <20260526141746.cf0b3c0bed5db3baf8914095@kernel.org>
References: <20260522170857.263969486@kernel.org>
	<20260526141746.cf0b3c0bed5db3baf8914095@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 May 2026 14:17:46 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Fri, 22 May 2026 13:08:57 -0400
> Steven Rostedt <rostedt@kernel.org> wrote:
> 
> > This is to make the persistent ring buffer more robust when sub-buffers
> > are detected to be corrupted. Instead of invalidating the entire buffer,
> > just invalidate the individual sub-buffers.
> > 
> > I started with Masami's patches and modified some from Sashiko reviews.
> > I added a few patches to display the dropped events when the persistent
> > ring buffers validation checks found sub-buffers were dropped due to being
> > corrupted data.  
> 
> It seems that Sashiko still marks it "Incompleted".
> Maybe we need base-commit: tag in this cover mail?
> I also guess that this series does not use "In-Reply-To:" but
> only uses "References:" tag in the mail header. I guess
> Sashiko's mail header parser missed it.

But this applies to mainline. I'm not sure why it's having problems.

-- Steve
