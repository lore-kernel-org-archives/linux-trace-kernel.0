Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51329A47;
	Tue,  1 Jul 2025 05:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751347277; cv=none; b=CTl2n9DecBoFcCG1O+C66GBUKlMhj1I5Xz02uJE+KWdYWxrE+PG6j4Kqun62tJAR5QTNPgDHZM/5sJw7udMhRa75uyK8BvLEc/hvi2uSWodKAXy8Rb6d5WusQiqjyxjuNUqmTQtcjpW0H1WtBYWPzjia2XvrbtIsZZurgy0UObk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751347277; c=relaxed/simple;
	bh=yQUoBZ2SMNI4V9Ij37O9fIStbSz+2/2OjfqIEVgGZ9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVgfuoWpoZUJqzK+cZqcLN6WnmG/d2KCM+riIIbuAffuncRGYDgvuQ+A8IUfvPlv2vkg6lA7xm0L3P6siJy8YdfnkGON3U6OR1HWV7wTaEpe8paRZFNfxSoNa8HgXGIRaYYR6FEL3MAWBdEcXRqF5WqlnUQ5HITjavWNajaFaUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lXKkCyxI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZedNDfLk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lXKkCyxI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZedNDfLk"
Date: Tue, 1 Jul 2025 07:21:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751347274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X03KVDX7Q7xCqvrk2MtgunqeHF2/HoDA6sxx6spzF5w=;
	b=lXKkCyxIaWXSW7ZqYX/Bfr4xKROgJo9pl+JyfkSlaEUdx0dZxK4tH8PguLgrMBUcRSXCxN
	ASEihq8UG+EY8WFmKmNFgwucAC+eEJE0RAJiQjLIzhDuUNH/OebsLlZOd5FI1dYK9XPs9h
	mZ01DnwjhG/L54XmrS6ACGKIvaG8shTO3v+W/FdrNBKSrJza0R40/5+Ur8HghQNb7X5+8L
	7MgoF/8xXYpDCS7XgfHADGBy3a9I4cbSSslzNnZEMHn8JL3hH6V8sE/Fbm1/gZ14lgyo3C
	vSG3CSLiQ5XpkzuUb6luQd54c7GV4JddgVoM6YJ0EJ7CcYbqPGBgexK7VxNu9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751347274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X03KVDX7Q7xCqvrk2MtgunqeHF2/HoDA6sxx6spzF5w=;
	b=ZedNDfLkHlbXRoWzxgGihNkRKxnpzREhuqDwHExF1vD8abfOzWLxWN4QkQadRvpZlWS1PP
	dHQsqo2lmsI30GAA==
From: Nam Cao <namcao@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de
Subject: Re: [PATCH v10 14/19] rv: Add rtapp container monitor
Message-ID: <20250701052113.HSInwOOF@linutronix.de>
References: <cover.1749547399.git.namcao@linutronix.de>
 <96c2766a74a730fe54a9339feb5b93128ee65331.1749547399.git.namcao@linutronix.de>
 <20250630160430.20dc6dc0@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630160430.20dc6dc0@batman.local.home>

On Mon, Jun 30, 2025 at 04:04:30PM -0400, Steven Rostedt wrote:
> On Tue, 10 Jun 2025 11:43:39 +0200
> Nam Cao <namcao@linutronix.de> wrote:
> > diff --git a/kernel/trace/rv/monitors/rtapp/Kconfig b/kernel/trace/rv/monitors/rtapp/Kconfig
> > new file mode 100644
> > index 0000000000000..658bb78e733a0
> > --- /dev/null
> > +++ b/kernel/trace/rv/monitors/rtapp/Kconfig
> > @@ -0,0 +1,14 @@
> > +config RV_MON_RTAPP
> > +	depends on RV
> > +	bool "rtapp monitor"
> > +	help
> > +	  Collection of monitors to check for common problems with real-time
> > +	  application that may cause unexpected latency.
> > +
> > +	  If you are developing a real-time system and not entirely sure whether
> > +	  the applications are designed correctly for real-time, you want to say
> > +	  Y here.
> > +
> > +	  Beware that enabling this may have impact on performance, even if the
> > +	  monitors are not running. Therefore you probably should say N for
> > +	  production kernel.
> 
> I'm trying to figure out from the patch how exactly does this cause
> performance issues?
> 
> Can you elaborate?

Sorry for the confusion, this patch alone doesn't affect performance.

It is its child monitor which turns on CONFIG_TRACE_IRQFLAGS, which is
added in a later patch.

Let me move this paragraph to that patch instead.

Nam
