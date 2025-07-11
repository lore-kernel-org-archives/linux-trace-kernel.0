Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DFC5383;
	Fri, 11 Jul 2025 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752257935; cv=none; b=tGTQQ52tPWwaKkdtmJRIg4egaKMR/y1aqW1PlEBmGw8giftITsEku75AVxN6hT45BpVWw0+qgNvUet2dl5u3aU3ZVG+0Ywh0E9Q4t2CVfe+LGLhdI4dE1fMLz7MCFZFpkbAoRULs+MaNKR/Hz3MNpuHWW87Vs8DQy0Rwgixl3MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752257935; c=relaxed/simple;
	bh=RaXFaKhMptA0VWI0bcnG6YmJ4qntVveyRzZV3R4NIWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMwUFt0tuL38JurLud6FYftsp/aSlySIuZY93YMLLMTSiCg0XQAUJQ8VOmw0Zn685VIbG3Q9WMn0KZAr3MGDjiFB0QAywbQvor3JXul01hHi0jwY23sV2aGM7BXPsqr9/G+2sZZAPl/nTehF3vNMtZ0dGp0GJsgPvQSnpV5ydlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R58PcrH/; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R58PcrH/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Adhh9U7HQoWtfmousRvgTn6pHJmknUfcCaBoye1pSMY=; b=R58PcrH/4K187twPLAxOLJLy3Y
	EEIzQod0raQWLqjhgHb+OWq3UrI/tB2Z9xnnkHGs9kcrdW72tuTdPwLtkrsj1YBF4r3LVlk3O4xRl
	/Ugm8jCyGTIliT8P+a/kdVEtgp9bBPWBbVz10dvjNO8T6TLeNHstcH9tfXstTK4nhYXWmNMUwcqug
	/HfbANSG32eHWS5OgWdGOsp1gVf89e7Olva0Wi5riQNCH7C3bSC0RBRaeIyq1APBArH2jdi+2oTWk
	Aro1btZHZdXK5OF3S9jM/30ctMi0BuRsQlYegBkoNW4TaXjyas18/XuoJ5IPGMg6xqLo9qBmzsMMj
	CBJLW06A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaIKd-00000009JrZ-1A1X;
	Fri, 11 Jul 2025 18:18:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0A55B3001AA; Fri, 11 Jul 2025 20:18:46 +0200 (CEST)
Date: Fri, 11 Jul 2025 20:18:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, John Ogness <john.ogness@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix up build issues with vpanic
Message-ID: <20250711181845.GA4105545@noisy.programming.kicks-ass.net>
References: <cover.1752232374.git.namcao@linutronix.de>
 <20250711122413.15b8456f@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711122413.15b8456f@batman.local.home>

On Fri, Jul 11, 2025 at 12:24:13PM -0400, Steven Rostedt wrote:
> On Fri, 11 Jul 2025 13:20:41 +0200
> Nam Cao <namcao@linutronix.de> wrote:
> 
> > Hi,
> > 
> > The newly introduced vpanic() has some build issues. This series fix them
> > up.
> > 
> > As the vpanic() is only in ftrace tree for now, it is probably best to let
> > this series goes to ftrace tree, if everyone is okay with that.
> 
> Since the bug is in my tree I'll take it, but can I get an acked-by
> from Peter or Josh?

Sure

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
