Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640BC18DB2A;
	Mon, 21 Jul 2025 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753109579; cv=none; b=OYjbgnVCbmMDaopGo3jgHxahh6d3Ezf4aFszjVEjUme3/Bef2hxkl2etETcYo1PXzf6eS/zWEYKNz2Coc+O6S0uRN9d6/WqXHPRwLRy8Kv5N/KKwxv75VwpU93fs/u8oFLlz40QltULQCyhuxIeyYNFbzjg20LuSLLwyDX4r/l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753109579; c=relaxed/simple;
	bh=J/w2lNGrR7KJ+ZkYIOBUxtTzeSMAlJKzGmtnxV36JrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qg0Tih2x4hxWwbO+KXjpQxkDizUO1+TaiuY5sjX1VKzMv/s1FkOLyAlD/ZgpLbtvEsSJJZK49ymBz6GB/YMnyzbOroPptRJQa6ZmMsN9l5piCKt3b7JYSxIAm1tfx0hS46caIgiRsx1hV8OsD8pc7PglJHHlmXpkWtktwarFa7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GvxbXt0b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HtRrpd/P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GvxbXt0b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HtRrpd/P"
Date: Mon, 21 Jul 2025 16:52:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753109576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wlbtxu8KKjEbfCs6NyH/KO2wnJiqPKPEBJhcaqwg5cU=;
	b=GvxbXt0bzI4jwIEpnmdXOgQM5Bdrh6zPBpLZQjAI8cOTABEaLhNqBOADL9wGbRABJBfWrW
	KF4bgY/qe+n3fYmlMwWeg6EAhtTrGnsy03GXpvUQGniuFQO9tIY00Bl0DRdDvBZczQbs3V
	MizylPj8HPluTFZ97vWPgBKQtsCOaBIle7KkkZZpeyyYcLHfZJoc5A65L9PhgiT3y4Bhd6
	s+7s9KURInhaeu0F0Lemz3Ll3uU4H1Ae/Z6KLh518+CFIQ0jWUwdFSBTolTXX6tDGk4QJx
	g4QcBuUMbtfyIftT9tYc+YbQchtQxyzj5nW0uutTr6rNkWEQkY/TEkzo3aS/vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753109576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wlbtxu8KKjEbfCs6NyH/KO2wnJiqPKPEBJhcaqwg5cU=;
	b=HtRrpd/PENmWA4L/NzqYxAJE4rudqR4BmCqvOKwpdJT/A6PsLePEIB+EyObLCS10Lq/yMO
	wUkS+t753aeIdMDw==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v4 09/14] tools/dot2c: Fix generated files going over 100
 column limit
Message-ID: <20250721145254.WPp6FNzS@linutronix.de>
References: <20250721082325.71554-1-gmonaco@redhat.com>
 <20250721082325.71554-10-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721082325.71554-10-gmonaco@redhat.com>

On Mon, Jul 21, 2025 at 10:23:19AM +0200, Gabriele Monaco wrote:
> The dot2c.py script generates all states in a single line. This breaks the
> 100 column limit when the state machines are non-trivial.
> 
> Change dot2c.py to generate the states in separate lines in case the
> generated line is going to be too long.
> 
> Also adapt existing monitors with line length over the limit.
> 
> Suggested-by: Nam Cao <namcao@linutronix.de>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
> -        strformat = self.__get_state_string_length()
> -
> +        maxlen = self.__get_max_strlen_of_states() + len(self.enum_suffix)
> +        tab_braces = 2 * 8 + 2 + 1 # "\t\t{ " ... "}"
> +        comma_space = 2 # ", " count last comma here

PEP8 prefers two spaces before the comments.

> +        linetoolong = tab_braces + (maxlen + comma_space) * nr_events >= self.line_length

Shouldn't this be '>' instead of '>='? 100 columns are still within the
limit.

Nam
