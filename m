Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5743290AA;
	Thu, 21 May 2026 15:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376574; cv=none; b=ia5iT0cXJLM7UMhdxpDWFxtS5hlMlQ8ctgFPTzmJf8F1fACdYxy1x+ULB0gPoGH5q9cmtorJMasVanKHp7l2qGCIKuv8HAEcjKKgsak0pHjcIoUy/7kZRLwcmH0WJ8aeSm4HCOpvAuiuI35l8TSCMrvnU4HU//OyeVD/WQenoIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376574; c=relaxed/simple;
	bh=Ce62N7LmzxdUwOCG3QA8mDOmnZQUiwDIVO2FNoD2mLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PES61bzCNwx39dOg8dNo8/cmsgGJvfQkF3aTpoYr0xltfczdQtgy9B43N+WeV3p5M+Bux1g0BZihuA+j7rpwBgpH8XXPeA2k/upkHYC9u/3OYjsMIcNZxqgpdYPAE/HPz9nRzjlr+JEuL9ED3Zd/4lQEKBPprCS3jiZTS/5kLcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 3B43AA0512;
	Thu, 21 May 2026 15:16:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 6B72620026;
	Thu, 21 May 2026 15:16:09 +0000 (UTC)
Date: Thu, 21 May 2026 11:16:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] tracing: Record and show boot ID in
 last_boot_info
Message-ID: <20260521111630.1f558754@gandalf.local.home>
In-Reply-To: <177937543666.2596845.9748178606108139386.stgit@mhiramat.tok.corp.google.com>
References: <177937541909.2596845.17729857441826694760.stgit@mhiramat.tok.corp.google.com>
	<177937543666.2596845.9748178606108139386.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: uzmutyj1wx7sbgtdwpenxactko4sx69q
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 6B72620026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1//Cc/yJL7VVq0chSS4fnrO8b7v6hvavs4=
X-HE-Tag: 1779376569-173304
X-HE-Meta: U2FsdGVkX1+oJOGHqGbfqtROoGfy8XgVz2WH98a1hO0xz/v3zJdMQJhgeThpK1+iviXODJ8Thmv/HtVKxZPFV7G/RVNObtHBhq/e16Fl8170v07dbg97FMC8LNyUqX+Ht0eEBm5EhtNkORn1raIQX/GniUMnbVZMz8LGzZLCCE5r3W5qQlh8tW6sT8e35qrQtpi71D6R4fdvqZiaoS5tly/6OskvnJK7fhFKcY0OzcM/ZuEj3B0eUqfWDzh8QkqSc26xUM8HWRqLZVFGGj2tIlXsxvl9bzd5d29twMoq5IxoZWP/uXHBt9HxQNGu2RhihvrupSlWT727qxaNEDGHs71gvj8/arz4

On Thu, 21 May 2026 23:57:16 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> @@ -4804,6 +4806,7 @@ struct trace_mod_entry {
>  struct trace_scratch {
>  	unsigned int		clock_id;
>  	unsigned long		text_addr;
> +	u8			boot_id[UUID_SIZE];
>  	unsigned long		nr_entries;
>  	struct trace_mod_entry	entries[];
>  };

I just don't like wasting scratch space if boot_id isn't defined. But I
can't figure out a way to optionally have it there without wasting space
anyway.

If the get_boot_id() is accepted by the random folks, then I'm fine with
this change.

-- Steve
