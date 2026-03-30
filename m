Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3CF244685;
	Mon, 30 Mar 2026 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774902456; cv=none; b=rGyXyTQq7+Tr3LfUbI0nSQ63adXwd/SR0uwlkzt1ijtIJN09f8TNxyhhZ/N1abxgOmfZU7OuNsIIv9dCuHKVcCzUOkmexuyybuxqES04jxyWkWKp6RhZc+wkSDZ8l6ZeC/CSummuVqgSrJuhVDENBmgtNHeEFYWQuLIAJC6G0wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774902456; c=relaxed/simple;
	bh=rs1Pr9t8nqH5hZ5ZkHh3djw8IEtk8hUM+gsLcUR/JW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K0//RwsHjPibsELtKUts7LMCd3kbLXloqWmZvfOeU40/bnF1P+KFtgwFM7gjrsjQQQrT6CaToJGIl0sAdUWGm5I5Ky1tqr2da83oe3neQvExE9pb23hwjt1KudOBOOdXpDe9irOe0BBtXVWYnTYrpZJjU0HMJQfYSPhpr537yj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id DCB9DBB0EC;
	Mon, 30 Mar 2026 20:27:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 2D48220025;
	Mon, 30 Mar 2026 20:27:26 +0000 (UTC)
Date: Mon, 30 Mar 2026 16:28:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>
Subject: Re: [PATCH v14 2/5] ring-buffer: Skip invalid sub-buffers when
 validating persistent ring buffer
Message-ID: <20260330162822.54f6bd02@gandalf.local.home>
In-Reply-To: <20260330162210.5e37b0c3@gandalf.local.home>
References: <177487498530.3463592.12715592581212799257.stgit@mhiramat.tok.corp.google.com>
	<177487500432.3463592.13753720277119177967.stgit@mhiramat.tok.corp.google.com>
	<20260330162210.5e37b0c3@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: xtfyfmi18i7eho4k66erbxemgyrmmbxr
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 2D48220025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/EgCTFQxKB88L/uS3WizZAItwpEKdvy/M=
X-HE-Tag: 1774902446-234055
X-HE-Meta: U2FsdGVkX18it7SNbZ4j4r+zB6VnvIQMel7QUBo2CrDheBkqFHw0R51zwTIgSvI0QfX8a2nShwS7Nb2iOfr4/HCdyrfOEViVklktIqflyc6ZLO1IAGaYJkD0p5qi+aXUcY9XgY9hNFxkSkZzNjaX5QTYS6D06Gn4X8/rTbbrDrXHCBkgBX5lUNAs2B3aJwSsGKsUWXRshUIlVSlY9KN/0CwLOSMqGQQP5SM1wBkoVcsYBYS0m7lJ+yCNoUbjiu0K2JlGNiPMF5ogKWLnbYSn0HMj67hu4O6U4F/Dz7LggXQ3PPoJEt5u8Zezl2hTuIv4U4AjJXMC9q2hL+3SSHvPUngGgs3OPx+KycC1aICQbYw6eWh8FtK4W+txL+cxtbDu0pm20ksusYFeuIkoXFgwSw==

On Mon, 30 Mar 2026 16:22:10 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 30 Mar 2026 21:50:04 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > @@ -2042,7 +2065,8 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
> >  	local_set(&cpu_buffer->entries, entries);
> >  	local_set(&cpu_buffer->entries_bytes, entry_bytes);
> >  
> > -	pr_info("Ring buffer meta [%d] is from previous boot!\n", cpu_buffer->cpu);
> > +	pr_info("Ring buffer meta [%d] is from previous boot! (%d pages discarded)\n",
> > +		cpu_buffer->cpu, discarded);  
> 
> As pages should never be discarded unless something went wrong, let's only
> print that if there were discarded pages.
> 
> 	if (discarded) {
> 		pr_info("Ring buffer meta [%d] is from previous boot! (%d pages discarded)\n",
> 			cpu_buffer->cpu, discarded);
> 	} else {
> 		pr_info("Ring buffer meta [%d] is from previous boot!\n", cpu_buffer->cpu);
> 	}

Or perhaps:

	pr_info("Ring buffer meta [%d] is from previous boot!", cpu_buffer->cpu);
	if (discarded)
		pr_cont(" (%d pages discarded)", discarded);
	pr_cont("\n");

-- Steve

