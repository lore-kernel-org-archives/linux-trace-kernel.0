Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793059967;
	b=fXGMEkhYnKAsELfzHUF2qjXEsGXKQzTRUCxPJKSZymWO3+2o31tnpRCOXmSpZ66BmGUp
	 aG+QK61nBeyEQpIN0Mq5Rw9/d2VBgjzWwZB7iL89tjGQoSsXU5OPmKc6V+3OV+JSq7HLs
	 OLC2RLFK3lOwmruCro9j9zX9t+OHQ4XCwfysECVpdmmqUTFiIpQtIfvoWkQjTA92kOXzi
	 HAH1DiP+er0BxtXYZuCLnP02Vxqc82cgOpz82PIyWC2iEv+D6iiNMn8/4A3Fhx0sdR03e
	 xgVCcXga9OeJX5R1aT4EhI0tkwQBU68rNgy5PjS2asXnXaIAC7dT3KnCuzhNOp6egbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793059967;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6NxHfrzCjecfqUYYIBMtEF1a0oXYC5iaevKK2QCBX88=;
	b=PErkI1MJjsSDHBotXOk+oiBdS8zA4X+UrraXhZ6zUM6bOUA3jMBHVomn0iV418oXGZ50
	 jjoUORY5PcGVYO40Ivg/RvzoEHfD2+RQXaRnQAJ+UKKk8sns2q4r3t2kHyEWGFwyry6eb
	 +PFib0JnxcD7NuVb3w2+CFffaHFgvr303tw17j9CmB6qU+G0iZjidWX5JLe1bYpwr3BfH
	 lP8y3XGdri4o7nnb9za8c1UTx/70k5T7gaMhJeNFacbc/FepgMuXxzZVRY8VR7wIF29FU
	 cZN5BtXbaAWHENrpQY2RnyvRJl6flekPih+U0tYWt62nsgdOP/1cZv6HgpJ+zr2SuSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZxImIoNH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A74606A31E;
	Tue, 27 Oct 2026 00:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZxImIoNH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA03C1F01828;
	Tue, 27 Oct 2026 00:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793059966;
	bh=6NxHfrzCjecfqUYYIBMtEF1a0oXYC5iaevKK2QCBX88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZxImIoNHx8kXLySCT62e36TwqiehoPOB6cJ27sYttuEjlXG8xclt9wCKA3dXYQrc7
	 sy8UN6f2Y6X66kI+YNuBD9BUAmgpkJqOLoRkdhTxcSxOfbKzmdD9W15Z+pSWPFLhp6
	 b+ZgYx2jjIGU5yB+R+UEkmgOashbA9Nt2WBYAAhrCMiDhYKidfUIq7lIEkgEmi0CQU
	 mdcQ61Ji24HDnxWsddAk5EhZfHzCZkwT9fwVVtYjmIT5so5cYvAY5XThfk37iIUUjN
	 jfgiS6Nw5hcn7/om6bAGPZ7qf0sF93DfbQdzSJ2JXB0Woldz7Lx1XXxCtH+G8beF9Y
	 3XQ03PlFbFo+A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 6/9] tracing/filters: Skip second character of '&&' and '||' in calc_stack()
Date: Tue, 27 Oct 2026 09:12:43 +0900
Message-ID: <undine-1793059963392038141-496f89524ad52c64@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <undine-1793058642821980546-e873f302f6a6d563@undined.local>
References: <179291742944.492959.11659339795290028998.stgit@devnote2> <179291748555.492959.3275503783612449972.stgit@devnote2> <20261026164727.0d1636cb@gandalf.local.home> <undine-1793058642821980546-e873f302f6a6d563@undined.local>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Tue, 27 Oct 2026 08:50:42 +0900, Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> On Mon, 26 Oct 2026 16:47:27 -0400, Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Sun, 25 Oct 2026 17:38:05 +0900
> > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> > 
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > In calc_stack(), when encountering '||' or '&&' (where str[i+1] == str[i]),
> > > the loop sets 'is_pred = false' and continues without advancing 'i' past
> > > the second character of the operator. On the next iteration, the second '|'
> > > or '&' sees str[i+1] != str[i], breaks out of the switch statement, and is
> > > counted as the start of a new predicate (incrementing nr_preds and setting
> > > is_pred = true).
> > > 
> > > Consequently, a trailing logical operator (e.g. 'common_pid == 1 ||') is
> > > counted as having 2 predicates instead of 1, and any subsequent non-space
> > > character before a delimiter fails to increment nr_preds.
> > 
> >  "common_pid ||' is an invalid expression.
> > 
> > > 
> > > Increment 'i' when matching '||' or '&&' so the entire two-character
> > > operator is skipped.
> > 
> > This is just wrong.
> > 
> > Masami, don't blindly trust AI.
> > 
> 
> Oops, I might mislead by the code. (I thought I've checked it...)
> 
> > I purposely did it this way. Because && and || creates a new predicate.
> > 
> >  If you have "x||y"
> >               ^
> >               i
> 
> OK,
> 
> > 
> >  Start with i = 0; is_pred = false; nr_preds = 0;
> > 
> >    str[i] == 'x'
> >    if (!is_pred) {
> > 	nr_preds++;  // nr_preds = 1
> >         is_pred = true;
> >    }
> > 
> >  in for loop i++;  // i = 1; str[i] = '|'
> > 
> >    switch (str[i])
> >    case '|':
> >       if (str[i+1] != str[i]) // false
> 
> Ah, somehow I completely misread this is if (str[i+1] == str[i]) ....
> 
> >       is_pred = false;
> >       continue;
> > 
> >  in for loop i++; // i = 2; str[i] == '|';
> > 
> >    switch (str[i])
> >    case '|':
> >       if (str[i+1] != str[i]) // true
> >           break;
> > 
> >    if (!is_pred) {
> > 	nr_preds++;  // nr_preds = 2
> >         is_pred = true;
> >    }
> > 
> >  in for loop i++; // i = 3; str[i] == 'y';
> >  
> >    if (!is_pred) { // false because is_pred == true
> > 
> > Loop ends.
> > 
> > nr_preds == 2. This is correct.
> > 
> > This patch is garbage.
> 
> OK, let me drop it.

BTW, to check the correct input is encoded correctly, we may need
in kernel selftest or a feature to dump the interpreted pred after
"#" line via filter file. Latter one allows us to test it via tracefs
(ftracetest).

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
