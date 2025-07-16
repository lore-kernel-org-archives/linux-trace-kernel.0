Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8B5231845;
	Wed, 16 Jul 2025 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752658487; cv=none; b=ks6CzeEzIazBuVvhWJztkw/ee4PJO6mvwVZHhgim/TNaqXsq1vaFExzzUyzT44mHfeVXemvhqkwawJsrIvzBHu72jekMDs+75TbGls8n2YJNZcIvIMUuo6rjFBoAihFnJ+kva8ygDleI14v6NVn54uHc2YoFIvz8G2llfQPMcpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752658487; c=relaxed/simple;
	bh=ZGLRAdvUUiJ4v6m7gl7SXPULv4lXVJyQD3tgYWb0Wis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VewPJeE+lGs7UOHTyz/HI+c1cQ4h9RSg8ZdqoOehmFCB9RCEkJ0kbdh19WZgUH5t/TIij7RFFgc96wp87AXNeDiyigNn9bjweji8wjYqaaR7WS2o/fzK3Rs9zfoThtIGdsHwmd7vGvXC7N9kiTDCK/sd2+0UXXP4aFKiiip9YpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qDuQ4KPR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zSMs0STh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qDuQ4KPR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zSMs0STh"
Date: Wed, 16 Jul 2025 11:34:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752658484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IIgCeHULcNXPs8dxxiI8uwbiFr6Dtfuw9TEJv6DqlPw=;
	b=qDuQ4KPRVm9eCAZlNs1JpxpYKvabcA6lxpecNozQybU5CPVV/1l9YKruJbmLCBxG89Frwm
	MlqGiS0JUH2oFNq/x4dFXIw5WpPDVbOoVFLvwh19Gt8+eO8fT5gzyeTxuZnzTFI5pcdjWW
	27G8x+DbzJZrE5mRqlPzfO8NCRwRvA6z79USioWK03uWWIPTab2Pk7lLuHnGpwdESGT3to
	CC/nJYxDfqS3pLuxJgUXgljqjZXX2srjaVILbEb4Jrin1499zh0MXvG1+3OPSEeGpiiZEg
	H2TJ42JKzVVRldl32eIhcVK5b+LmnI7dtSheVPmunyAw8NaE+AMmv+oHUNWsHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752658484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IIgCeHULcNXPs8dxxiI8uwbiFr6Dtfuw9TEJv6DqlPw=;
	b=zSMs0SThcJ/yX4V36u4nvqza0IpyxVEA/MUh1IbfVs6yNqBhgYuRCNyoCjh0/2F7jifwUn
	O5HW4vlmujZHbUCA==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3 09/17] tools/dot2c: Fix generated files going over 100
 column limit
Message-ID: <20250716093442.SSIxaNpr@linutronix.de>
References: <20250715071434.22508-1-gmonaco@redhat.com>
 <20250715071434.22508-10-gmonaco@redhat.com>
 <20250715150156.QXAD4dZl@linutronix.de>
 <d69862275becf1d296c80a08b29b2081857a85a1.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d69862275becf1d296c80a08b29b2081857a85a1.camel@redhat.com>

On Wed, Jul 16, 2025 at 11:27:54AM +0200, Gabriele Monaco wrote:
> On Tue, 2025-07-15 at 17:01 +0200, Nam Cao wrote:
> > On Tue, Jul 15, 2025 at 09:14:26AM +0200, Gabriele Monaco wrote:
> > > From: Nam Cao <namcao@linutronix.de>
> > > -        strformat = self.__get_state_string_length()
> > > -
> > > +        maxlen = self.__get_max_strlen_of_states() +
> > > len(self.enum_suffix)
> > > +        # account for tabs and spaces/punctuation for each event
> > > +        linetoolong = 16 + (maxlen + 3) * nr_events >=
> > > self.line_length
> > 
> > I managed to figure out 16 is the indentation. But I failed to
> > understand
> > where is this '3' from.
> > 
> > Can you please add some comments for these magic numbers? Or better,
> > assign
> > them to variables with self-explanatory names.
> 
> Turns out it was wrong ;)
> I'll fix it and make it clear.

Hah! Got you.

I'm guessing that it was supposed to be 2. I wait for the reveal in v4.

Nam
