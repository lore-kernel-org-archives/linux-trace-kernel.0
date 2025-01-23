Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E4A2B2DA;
	Thu, 23 Jan 2025 02:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737600495; cv=none; b=PnEcdCWOfwJLS2jFf9kckhf1hOq7jDpXPLYvuzgrve9onb13Ty2sNkgrnm0Oi0wCePVbCrtox78u+aCiEhoCS67oT3uYUPLa/QqHorJT2B25I94rSjUSVT2rNDsm0IyCvQHQIF/vCQoFcwxxTsWyJBN2JXRz+QNjDI9xry8I8nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737600495; c=relaxed/simple;
	bh=wW7IsPzlq7FQvJ7p+zJFHmoKFEhEWZm2bJraxNEKwEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TTAe3EjkaStSmr2eugmgtg9Lk+agjDU2ezEJNWNDttUk9dcaomtxTnafd0nFVGAuXSpz8S6iGudhYAveJsbbO9jETP2SSuzxeziM+I7TRFWC5h2L/Wk81VleITNzOyxqgl3BJJ/MZReYx6NzELYSB/NXq+znKvhTDKQNMwBtxq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFC2C4CED2;
	Thu, 23 Jan 2025 02:48:13 +0000 (UTC)
Date: Wed, 22 Jan 2025 21:48:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, naveen@kernel.org,
 anil.s.keshavamurthy@intel.com, davem@davemloft.net,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 john.ogness@linutronix.de
Subject: Re: kprobe on local function
Message-ID: <20250122214819.49ace8ff@gandalf.local.home>
In-Reply-To: <20250123024224.d0h8d4HV@linutronix.de>
References: <20250122075939.qw7HsuMd@linutronix.de>
	<20250122172936.09bc8c9a@gandalf.local.home>
	<20250123104842.92336327f898e546c5b67536@kernel.org>
	<20250123024224.d0h8d4HV@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jan 2025 03:42:24 +0100
Nam Cao <namcao@linutronix.de> wrote:

> So a similar solution for in-kernel code is kallsyms_on_each_match_symbol().
> But I expect register_kretprobe() to do that by itself; or at least report
> a failure if caller specifies the symbol name, but multiple symbols of the
> same name are found. Because at least to me, my code "looks correct and
> should work" but it doesn't.

I guess that could be an enhancement to the code.

Masami?

-- Steve
