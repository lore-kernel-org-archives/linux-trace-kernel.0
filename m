Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2700D274FFC;
	Tue,  1 Jul 2025 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382682; cv=none; b=cZe73AqvMbWN+NcxZIIOuQBM3mxdS+C61w78/njgfvaODsghRVQUugrp4aw55rwGzPaSyHtkJth09MFmaZ8RFHHvB3YUIu1LiHD4N0HegH0WIlxhOqUAmb6Pi70fMXOOt5FHWvjgfYq824ZBs6Xl5sJkYRHE5p9UlAvkXWvY0sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382682; c=relaxed/simple;
	bh=KvHzbQBF3t9IIa1Dm96UqwW36rTTPbMjfkHV0obqDPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNZhL3RF0eIlOhzO7rUQIUoT3C7p1Qu9FmIUfbn+D451mUsayfH/5DDA6b+inUxJ/BH7p3qP03aHdBtJOHkfv2KsLA+JvWBlRpX1Iz3sPsJhuk1J/OBEliMos4lLsBR76q7rf7qyOuIg0Yqo475dABvVq4NBF3BkM4/Q2IJ0kZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PFNf1yhk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PfEXy7IG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PFNf1yhk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PfEXy7IG"
Date: Tue, 1 Jul 2025 17:11:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751382678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mkUl5eomB04clLZcTBjBu9b5U/FIO02anfxFQvMAsDk=;
	b=PFNf1yhkVqIBQZIQgTxjcFrlubE9zSw+f/VSBQWpa/8NryfmX0x7I+FoedFqNOnfVU7hXE
	SFsaH7wBqPULuRJyx2pznZGOt/Svy7IZxldDcpqIop++8jitChdkjCX0HARyxHsVICcoz8
	Z81FowSsmp91Ro5Sw3h0J5a7aemgcYiUXyL0LK1aPlMMa+y3hcTJuzNwb9Ojglfx2oBhza
	pfURcvMxVHHZjBaxaTX9A20qBLwSaFKOj6zdbv9xgtX+LsbeJhLaZEObgEp0VQCQFeGRVy
	Rzd+JznMDpsL0xLlw1BOjtTE1iLXnRha2jy+FhOrfN1gN/OUDx/fIiBtjcs66w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751382678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mkUl5eomB04clLZcTBjBu9b5U/FIO02anfxFQvMAsDk=;
	b=PfEXy7IG+leY0Mbon/CGRgebiyCjW3gGVboL8/0GdapwzwXZ2j5T/IkdWTFZ9pmRTI6gq+
	FFWcPD+KIlMUWgDw==
From: Nam Cao <namcao@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de
Subject: Re: [PATCH v10 17/19] rv: Add rtapp_sleep monitor
Message-ID: <20250701151114.OJQTlRCY@linutronix.de>
References: <cover.1749547399.git.namcao@linutronix.de>
 <d3cf55d3bf42a0f70a58c394b5cf6d603ca8a9f7.1749547399.git.namcao@linutronix.de>
 <20250630203401.1a11e58f@gandalf.local.home>
 <20250701051757.mBjQVdoo@linutronix.de>
 <20250701110218.5e742850@batman.local.home>
 <20250701110551.5c2dc2ee@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701110551.5c2dc2ee@batman.local.home>

On Tue, Jul 01, 2025 at 11:05:51AM -0400, Steven Rostedt wrote:
> On Tue, 1 Jul 2025 11:02:18 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Tue, 1 Jul 2025 07:17:57 +0200
> > Nam Cao <namcao@linutronix.de> wrote:
> > 
> > > > > +	switch (state) {
> > > > > +	case S0:
> > > > > +		if (val3)
> > > > > +			__set_bit(S0, next);
> > > > > +		if (val11 && val13)
> > > > > +			__set_bit(S1, next);
> > > > > +		if (val11 && val14)
> > > > > +			__set_bit(S4, next);
> > > > > +		if (val5)
> > > > > +			__set_bit(S5, next);
> > > > > +		break;    
> > > > 
> > > > What's with all the magic numbers?
> > > > 
> > > > Can we turn these into enums so they have some meaning for us humans?    
> > > 
> > > I'm not sure what you mean, we can't use enums as variables.  
> > 
> > Bah, never mind. My eyes are getting bad and I need to increase my font
> > size, as all the S0, S1, S2 looked to me like 50, 51, 52, and I was
> > wondering what are all these numbers in the fifties??? :-p

Oh..

> Even with my bad eyesight, these state transitions are generated from
> scripts? If so, can they inject comments that state why they generated
> this?
> 
> There's nothing in the code that even states that this was generated
> (if they were).

Yeah this entire file is generated from the LTL specification. I will add a
comment.

Nam
