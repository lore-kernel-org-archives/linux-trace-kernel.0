Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD840DDC3;
	Sat, 12 Jul 2025 11:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752320732; cv=none; b=fyxqRB5n2iWFc7irtz8Hjv5TQQApivUUH4ZhMCKWwerJbhtz9PrZ3V4YDnGscREOgSL7TP8gNwcZicgtvihhoHry3UjkT9tRtv0F3tbQaS505rB+UOQlvuxTF0KNzMaW5PZJWXFAR10nPPZWl/dve50EpbNfEsX85uackTdVN2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752320732; c=relaxed/simple;
	bh=ddivwdzozJ2VGB4GHxJ253lZeTs7Y4i4mulioXauf0I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=m84JwpcvSEg0EesKRIZJMQXWpH2mgddMWWKlA7C6koPZUu76UMTDvcG2EyssExLrDtvZj5XaxOPko31u/9ZivbLvUrpxiqxddrhIT/VwPOIrP9Q4lbvfbGiWe4JGxuzTLPk3msLoXkhxPxnMTANbMu6FlvzFmULwv2R1LmxX3g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teYBuNIF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teYBuNIF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4CBC4CEEF;
	Sat, 12 Jul 2025 11:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752320731;
	bh=ddivwdzozJ2VGB4GHxJ253lZeTs7Y4i4mulioXauf0I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=teYBuNIFXlrTpBzVBWREfiyv+AnYnmtdyCmT/m38E+5kwh7/goFcereq51OSF9BzH
	 h3MdWULA1mROgshj0jTdOeKclzvfz8ysvse4cRaccuRnwcoC+zs8ZIus3+vadFpp2N
	 ZdjxrLCd8JybdHQNdzCe1Zdg/e+9rxPJlILY09XHz8HgtliNpw4/WKat7AOZORcxMv
	 X6oYBYj5Bq/gbAvoN3kucsafTZpxF2stL63VAmcRjPG3TV3umFCyalARSDGt/P8dlC
	 Az/7MkjVnqpiylUpiGvlEMBDumGJzR00rjmK7WHI7j5P9SdcTTLBW0wHJIayiuRytt
	 q2eMf1pW7mQPQ==
Date: Sat, 12 Jul 2025 20:45:24 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Remove "__attribute__()" from the type
 field of event format
Message-Id: <20250712204524.13ece418f90ea66d4bd0e598@kernel.org>
In-Reply-To: <20250711120322.4ddb9b39@batman.local.home>
References: <175197567999.977073.8989204607899013923.stgit@mhiramat.tok.corp.google.com>
	<175197568917.977073.2201559708302320631.stgit@mhiramat.tok.corp.google.com>
	<20250709131107.397a3278@batman.local.home>
	<20250711143703.60a1a9a9f31a45f2000eec9d@kernel.org>
	<20250711120322.4ddb9b39@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 12:03:22 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 11 Jul 2025 14:37:03 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > I investigated this but it is not possible to use update_event_fields()
> > because that function is only used if the 
> > CONFIG_TRACE_EVAL_MAP_FILE=y.
> 
> That had better *not* be true, otherwise all the TRACE_DEFINE_ENUM() in
> include/trace/events/*.h would be useless and those events would not
> parse. Note, I usually run without that config enabled, so it would
> most definitely break on me if this was true.
> 
> In the code we have:
> 
> ----------------------8<----------------------
> #else /* CONFIG_TRACE_EVAL_MAP_FILE */
> static inline void trace_create_eval_file(struct dentry *d_tracer) { }
> static inline void trace_insert_eval_map_file(struct module *mod,
> 			      struct trace_eval_map **start, int len) { }
> #endif /* !CONFIG_TRACE_EVAL_MAP_FILE */
> 
> static void trace_insert_eval_map(struct module *mod,
> 				  struct trace_eval_map **start, int len)
> {
> 	struct trace_eval_map **map;
> 
> 	if (len <= 0)
> 		return;
> 
> 	map = start;
> 
> 	trace_event_eval_update(map, len);
> 
> 	trace_insert_eval_map_file(mod, start, len);
> }
> ---------------------->8----------------------
> 
> Notice the "#endif". The trace_insert_eval_map_file() is a nop, but the
> trace_event_eval_update() is not. That has the call to
> update_event_printk() and update_event_fields().
> 
> So it can most definitely be used when that config is not defined. That
> config only creates a file to show you *what* was replaced. It doesn't
> stop the replacing.

Hmm, Ok. But when I sanitized the field->type in
update_event_fields(), it did not work. So something
we missed.

Thanksm

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
