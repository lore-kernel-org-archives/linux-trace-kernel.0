Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1DA2749FA;
	Tue,  1 Jul 2025 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382358; cv=none; b=QSNs6wjjw5Fl05/mnocshJ1ssj5eK9G7f77DbL7Z7AzgdD/kUe1pBrTZAWZZDamC4td7vb4OX+8XO8Df5Q/ez+3SzPDwvuWJNoc8wF78piZ6qiUTsf/UDZPEbXJBx7LtASJWIXMtsEtA04B/HV+hsls676SpFUqmobD8PuvBv9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382358; c=relaxed/simple;
	bh=LW+z9xv2OalS5dgdz5Jxpcqe37XTcNklzyxmht7NzKs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVeMdeXb1xUsPXtfCtnW1bzZmigGiGWRZw4xG7Z5Nr7BLTsVhcuHY5beZOzX1vt28/KnZcGB/KKXcfY47Xqvhw9FrSdfOfeWf7f0lBEuhLnjcisa3kBezBXyMz+2URDV0IUY+i9xQrBG3vcko8VWOkC3qh1ZHAwvVVs7CwQoBf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 6F750106AF2;
	Tue,  1 Jul 2025 15:05:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id A5AC12002C;
	Tue,  1 Jul 2025 15:05:52 +0000 (UTC)
Date: Tue, 1 Jul 2025 11:05:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 john.ogness@linutronix.de
Subject: Re: [PATCH v10 17/19] rv: Add rtapp_sleep monitor
Message-ID: <20250701110551.5c2dc2ee@batman.local.home>
In-Reply-To: <20250701110218.5e742850@batman.local.home>
References: <cover.1749547399.git.namcao@linutronix.de>
	<d3cf55d3bf42a0f70a58c394b5cf6d603ca8a9f7.1749547399.git.namcao@linutronix.de>
	<20250630203401.1a11e58f@gandalf.local.home>
	<20250701051757.mBjQVdoo@linutronix.de>
	<20250701110218.5e742850@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 1c7g6n4opbtymoyhiqn8zyczc9habtjz
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: A5AC12002C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18j7/4d+T9UOvy+gyeIhpK0ZW/OSzW6pUw=
X-HE-Tag: 1751382352-318302
X-HE-Meta: U2FsdGVkX1+ZcU4PWhBjEQbxB8RgjXv6c2LW7we9IjGqMwsPHZ3oa0drzquSMkgVKY5KDyHCAOOQpgG7rJAjrPyxbUg+Jv36zDnxL15pkeDv0lKFh7M3s4htXP1dluG9EYhw9pZ3gYaZOPCjh65YDEOVRovXMikAjAhEbzw8GtcG8wVUAH665Uthi4G2xTj/HLQuyM4YlVkgp/y7/ch6k/38dWPfa2lTTQPw54dxhxB41Zx4XOJmVpUXCnS4UO42dVtzhUtjBBiSXhOA3OWFCHgY3JSdbHTWiUgcFjK+mfALHwb5Lt5vxbkX0va3wJjhGPlLazxz/sKRXQOCynszePdLMiMBDc1g26eVCmxc1/nOMn171zVNX7kovcwpo2te

On Tue, 1 Jul 2025 11:02:18 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 1 Jul 2025 07:17:57 +0200
> Nam Cao <namcao@linutronix.de> wrote:
> 
> > > > +	switch (state) {
> > > > +	case S0:
> > > > +		if (val3)
> > > > +			__set_bit(S0, next);
> > > > +		if (val11 && val13)
> > > > +			__set_bit(S1, next);
> > > > +		if (val11 && val14)
> > > > +			__set_bit(S4, next);
> > > > +		if (val5)
> > > > +			__set_bit(S5, next);
> > > > +		break;    
> > > 
> > > What's with all the magic numbers?
> > > 
> > > Can we turn these into enums so they have some meaning for us humans?    
> > 
> > I'm not sure what you mean, we can't use enums as variables.  
> 
> Bah, never mind. My eyes are getting bad and I need to increase my font
> size, as all the S0, S1, S2 looked to me like 50, 51, 52, and I was
> wondering what are all these numbers in the fifties??? :-p

Even with my bad eyesight, these state transitions are generated from
scripts? If so, can they inject comments that state why they generated
this?

There's nothing in the code that even states that this was generated
(if they were).

-- Steve
