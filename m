Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5C9376BF9;
	Mon, 12 Jan 2026 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768237255; cv=none; b=uuUqSleroWpno/bYPR76OeFLrO117Mvi2jnrIUpD30dghR/elot4bMzGNgZo2UkLAUqrtewchikwHcbONKalj6zj3tp1thGihfRC+pwuO289M1Y+IES21OntmYXf5qLhjDkOhh5RVtJS6fEdbHIGonr0qGjVPSpjO+nkJUD6QyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768237255; c=relaxed/simple;
	bh=Jl2o7xY3SsQe7fHQWhgedk2WROIQowMAaCRZT0tYLKk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omDDishC8SpaHOp9kTc8nYcs1gPbq8kfv83paoj4blvlOOZGJnJdKFPxqOq79DBQ6n2wc3kVSQj1oKTcq8KNPm+gmMX2lXTeQlfTV80sZoNPIs97uFhzv6jqoiq4TNsaMEX/A3vzerDHpGk43kbRCbAZmD11hqcRffUHOca2Jhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 92A8C1A0782;
	Mon, 12 Jan 2026 16:54:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 2C4AB1B;
	Mon, 12 Jan 2026 16:54:05 +0000 (UTC)
Date: Mon, 12 Jan 2026 11:54:08 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, Ard Biesheuvel
 <ardb@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add Rust files to STATIC BRANCH/CALL and
 TRACING
Message-ID: <20260112115408.48ed4d35@gandalf.local.home>
In-Reply-To: <aWUO59edshSRit-Y@google.com>
References: <20260107-jump-label-rust-maintainers-v1-1-702b03482f2e@google.com>
	<CANiq72nV0Z_UjdAwT=41TjjfmKnT6WL4hVNcxg_QCe7TAEYK_Q@mail.gmail.com>
	<20260112100006.7db6d31d@gandalf.local.home>
	<aWUO59edshSRit-Y@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 2C4AB1B
X-Stat-Signature: ifbjfdsqhcka7or6cghds8e4pz9ipyeq
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18Q+cnv8rvi3GY8qiX6BT+RQhDh0YnszcI=
X-HE-Tag: 1768236845-784065
X-HE-Meta: U2FsdGVkX1/I8KlO2y8NGt+GrgObI+tk9MBBqj1R1keSOF9+8JzP2oMeVsgthKFRhJMymDKnyo1kLCXys/KFGGdLwlv278+2/19E6f5/YdhouV+2tKMxCa8dAVXt5b0I5qJGcBedWgE9lhi9OQdnp3j5+8YSi42cogojV7OnREZw2fmSlY5m4aQ0Tgbo/1Lz9+9YNgJyKLX0MKxY5Tbx9SFgRlGq9gArh8RI0rxbIjNPzJPw7nKad5jMJDUhfgYFcaLH1xpfWBioi6nU0qkQ8dWFKx7n5+caVnd6EqLZbdac+cXse6IXJXKqAPaBVY4/HzDFRdRVyVOM8sqzFsz1u+0InRhfBlja

On Mon, 12 Jan 2026 15:10:31 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> > And have the M of the other sections be R here?  
> 
> Sure, we can do that.
> 
> Are you still willing to pick up the patches? I think that is simpler in
> case there are any series that touch both the C and Rust parts. (Such as
> the initial tracepoint series did.)

Yes. So I guess you can still add me with a 'M:'. But I wanted a separate
section so that all the Rust expertise is still included.

-- Steve
