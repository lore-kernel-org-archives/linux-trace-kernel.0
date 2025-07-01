Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4AF2C859;
	Tue,  1 Jul 2025 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382145; cv=none; b=WgsaxBRlDjVXnOnwd3lxXZTaqaY/aMjIxvggFcdqm0UyOmeLVFuIz3ibmCnWAa+fp067f5KR+2aAjmdvzrfEglaJ3wDWteM2pIEcLJGyMbjF7ui00JmPvP/jpPrtDAqiG0HZy1U25zRBeXl5V1OVu5Axn4YX0Xv+GdGUU2x5PzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382145; c=relaxed/simple;
	bh=G6NyVvCMpDwrHrhGlAOQBEVHpEsXrfpUa1OzCDHI4Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bg0R/vhdFgMKtnEX/t391KDde8oOwX9TYN5a/0tURl1HOE/6KyqS9TawXTHo1WHCx2rhNK67Zh9PQ/16GocSMZAcL66C4cYWkaOaIkZ2tllln4GXtyxwDgRQot1PYT8zRU9W5wsX8UuAa42fu9p9rb3TkPkW2w8XzmQD2+vt/hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id A2781123A9F;
	Tue,  1 Jul 2025 15:02:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id C3A6D20028;
	Tue,  1 Jul 2025 15:02:19 +0000 (UTC)
Date: Tue, 1 Jul 2025 11:02:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 john.ogness@linutronix.de
Subject: Re: [PATCH v10 17/19] rv: Add rtapp_sleep monitor
Message-ID: <20250701110218.5e742850@batman.local.home>
In-Reply-To: <20250701051757.mBjQVdoo@linutronix.de>
References: <cover.1749547399.git.namcao@linutronix.de>
	<d3cf55d3bf42a0f70a58c394b5cf6d603ca8a9f7.1749547399.git.namcao@linutronix.de>
	<20250630203401.1a11e58f@gandalf.local.home>
	<20250701051757.mBjQVdoo@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C3A6D20028
X-Stat-Signature: 8enwi1j9we1ng67py8fs5a34655cr4yz
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX190W3pl/bSRk4MqQbpALJ5/VZP/8RSTUJ4=
X-HE-Tag: 1751382139-232240
X-HE-Meta: U2FsdGVkX1/6r20odEW1bufvkOnez5JoETbUAO/3FjkspZjZRucG5mto2yJ4CYLpz1yZ7GXYNbjavRah6PJqDfWKSmxbeplwXoMVhqzeslrHaKzV0sBTtHqQJ9jtzQk6l6/lz9YeqE722pqrrx13msjUBrjJfDQnXwxRyqa00HJ3PedVHTqvK5ANxkUs4GdazfC6B9yXWjlwFyWO3B6YwW/k9pw5Qtefr/SNcJZFyOA9/wqyejS33CxMTKjVMcUMqTSjNMuBj9kfNrjXOyul37xpgzmX6tKOLrDRHiyrojUYL5O381fwv7xFDgm+oIcf

On Tue, 1 Jul 2025 07:17:57 +0200
Nam Cao <namcao@linutronix.de> wrote:

> > > +	switch (state) {
> > > +	case S0:
> > > +		if (val3)
> > > +			__set_bit(S0, next);
> > > +		if (val11 && val13)
> > > +			__set_bit(S1, next);
> > > +		if (val11 && val14)
> > > +			__set_bit(S4, next);
> > > +		if (val5)
> > > +			__set_bit(S5, next);
> > > +		break;  
> > 
> > What's with all the magic numbers?
> > 
> > Can we turn these into enums so they have some meaning for us humans?  
> 
> I'm not sure what you mean, we can't use enums as variables.

Bah, never mind. My eyes are getting bad and I need to increase my font
size, as all the S0, S1, S2 looked to me like 50, 51, 52, and I was
wondering what are all these numbers in the fifties??? :-p

[ Note, it is a beautiful day and on nice days like this I go outside
  to work using my laptop, which has a much smaller screen than my
  desktop. I was reviewing your patches on my laptop where these looked
  like numbers and not something that started with an 'S'!
]

-- Steve
