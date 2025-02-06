Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D17E23537F;
	Thu,  6 Feb 2025 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738860791; cv=none; b=PALGFYK/P/8CmMdnvhk70YwUSek9GP108ERXszfwjChPZbEv23E1CgISaImz3sHg0y9mPUN5GQVyMfsnnBNqBL8B3L7UFf8aNq6bFtbp97j637T4fSV0kt3ktn2tH4dL2wFqABTJLutBZfETBqUz6kkx8IYMvROK8tCEsTMlEDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738860791; c=relaxed/simple;
	bh=sJiJEkNYXh2cchmUanQA7WTNGhbQyJm9RSJEg++jKqk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=H9SOCedMWflLFvVftUSBXJLwQZmQw7h0j7MW9188j2rpm1JRl0eQ+iol8P2ac0VqjH4pdaH31vglEKk74ISYbsrqCCwtUKyeJw+LlSTzBkW4k1QSJN6k1clMPhOICSMp/6IGJy8DRAZSKik8nprEJfjDZ1l3M+tmPx+YWffAev0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enUXRhMH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enUXRhMH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F11AC4CEDD;
	Thu,  6 Feb 2025 16:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738860790;
	bh=sJiJEkNYXh2cchmUanQA7WTNGhbQyJm9RSJEg++jKqk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=enUXRhMHDIRaCHdmKUCfCuhJBKDTzQh48rJsiPIUY0o9aoEKprc4G08aAlbsvvPrd
	 WI2cOqIy1hmoGPbSD8x3d+emtdOPOlMAHAJyUpaaFycy7Ae/o4UIgnQcnMd2cyUVpa
	 JbtT1/EY/DwewbexGzAGmPmUxbMsm0yXPLZVdgbbhUTsiT6wJnPt/Evq6H8y5H5rNU
	 jPlL0U/OLAlsBUk5qcC/6pvRt3w729KMb6T+ly+nNCms0TpH0GeJk+L2Py2q+XzCPv
	 csTNqhNRi0KJ6yoWl0UPwvuvdIjy2aGNUs1yZYUQsFrv3vtrzzq2ipCW0EBhkStN26
	 rPnF4eBzZZ7qg==
Date: Fri, 7 Feb 2025 01:53:07 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6/8] tracing: Have persistent trace instances save
 module addresses
Message-Id: <20250207015307.ce9273f4cd5eee9335c335d3@kernel.org>
In-Reply-To: <20250206102949.65493416@gandalf.local.home>
References: <20250205225031.799739376@goodmis.org>
	<20250205225103.930895467@goodmis.org>
	<20250206172642.391c16d75dbce00518ef9688@kernel.org>
	<20250206102949.65493416@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 10:29:49 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 6 Feb 2025 17:26:42 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > This maybe too frequently scan the module because the update_last_data() is
> > called when;
> > - change tracer (this maybe OK)
> > - update "set_event"
> > - write 1 to "enable" under events
> > - change pid filter
> > - etc.
> > 
> > Once it is scanned, it should not scan again, but update by module
> > callback, because usually events are enabled individually (thus
> > write 1 to "event" can happen multiple time online).
> > 
> > I think we can move this after TRACE_ARRAY_FL_LAST_BOOT check,
> > if TRACE_ARRAY_FL_LAST_BOOT flag is set, that flag should be cleared
> > with updating the tscratch, and the flag is not set, we can skip updating
> > the scratch.
> 
> No, because we could enable it, disable it, and then the user could be
> adding and removing modules all day long, and we only add and do not remove
> (I do have a patch that does remove them).

I think TRACE_ARRAY_FL_LAST_BOOT is something like one-way flag, it is set
if the buffer is persistent, but cleared when it is reused (start writing)
and never be back. Isn't it?

> 
> But we can do the same check as patch 8 does, and only do this if the
> tracer wasn't already active.

Yeah, so I think this change needs patch 8 change.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
