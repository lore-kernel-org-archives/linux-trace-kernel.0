Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793058646;
	b=zlH25FYWHI0NfeR+t1HyWSNCcqS7w/SxBdx17McHelL02ACj3qBItsBxI3Tvya1XswDo
	 cR/KziYHD++3WznXBZA5rZ7U4HmDChI3RA8lUB8bE4IDrak0W0N8Ea/JHPgWcPKQSMxtz
	 7bYWRC4kPlkrX9C8KJlGZ8ZayYxrblE4WHnBAsEWH1tTq82X9MU+3wpBJoXvZsjCdJjGA
	 2SAlYG0mw9DjiuuL9O+AC+3UkT6DU9+cWGrkGGV5q7m29zggv6WSJKHqs8RnG7JflyQ02
	 0kCbN2hkxSArmEkxxaMbmAXKeVYZe3T5z+GgJFgbeVQP56eu+fQ6JK/oUVE5GDjan+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793058646;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=eKMgwSook61EDS9Ne7hFx7zRENHFPLDEV6vHhdbMFhc=;
	b=rnfbhsEmO6N429fuxGEw7j+KXUnLIAf7vTSEo5w9KOy+NuA6CjQF5WoP/cB4yG4eqqw0
	 3VPyw9LUqkvlMqISMJijX2ERCr7plVpSa8bG8hh7FUxouuqKs3bwOnWX1Nxlzxyy1RYXo
	 7oi7Abz7599cHmyGyG3g8hc5X+Ks2H03b3EKECMtY3sDbjFWFHHj9IGveuu9whygH9WAY
	 7YY5do2ew0TRzyaFU+OOYDLUOvkYgPK/CgBztziV7N3TZY2qxYMLis4bRcibjVjMTQ0zE
	 /ThD9YcXahSIJLFEfqPz/QCsSYnPFGl9wDvPctP4aIouTu83WbZ0xnOHKxvOm3Z/nAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UerVmejG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7689D606A322;
	Mon, 26 Oct 2026 23:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UerVmejG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD961F01828;
	Mon, 26 Oct 2026 23:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793058646;
	bh=eKMgwSook61EDS9Ne7hFx7zRENHFPLDEV6vHhdbMFhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UerVmejGpPfwfechyUjZ7s/odgEBGEcn6imDKun6cOj90XeOFzUYpxAU5/x7Mo8aB
	 mjadX1AdXAbmtiF+Rf3+mWVVFv6eparS+ttfS1Inu58CNceIrnlH5Uiw3vHznf8sFc
	 ELtaoh2c3JK0MVUECB+9sgvB8ZTg/Y0SH+RIxDJ2TuJw90XwVJOTjk2N7lMVKq9Lka
	 0FSDob4G3iUwGK8TTlXjetA3xw7D3+H3mobn8Tshwc6GjclAp7Q1T0IW2b5Mdx9tWF
	 /8zUf900pPojy+RzsSg+cp5Z6G6B9qU7LehpxZxHCwO7RKhlJLQaVcFXfGs51089PZ
	 Q9JpPeqxYmECw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 6/9] tracing/filters: Skip second character of '&&' and '||' in calc_stack()
Date: Tue, 27 Oct 2026 08:50:42 +0900
Message-ID: <undine-1793058642821980546-e873f302f6a6d563@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261026164727.0d1636cb@gandalf.local.home>
References: <179291742944.492959.11659339795290028998.stgit@devnote2> <179291748555.492959.3275503783612449972.stgit@devnote2> <20261026164727.0d1636cb@gandalf.local.home>
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

On Mon, 26 Oct 2026 16:47:27 -0400, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Sun, 25 Oct 2026 17:38:05 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > In calc_stack(), when encountering '||' or '&&' (where str[i+1] == str[i]),
> > the loop sets 'is_pred = false' and continues without advancing 'i' past
> > the second character of the operator. On the next iteration, the second '|'
> > or '&' sees str[i+1] != str[i], breaks out of the switch statement, and is
> > counted as the start of a new predicate (incrementing nr_preds and setting
> > is_pred = true).
> > 
> > Consequently, a trailing logical operator (e.g. 'common_pid == 1 ||') is
> > counted as having 2 predicates instead of 1, and any subsequent non-space
> > character before a delimiter fails to increment nr_preds.
> 
>  "common_pid ||' is an invalid expression.
> 
> > 
> > Increment 'i' when matching '||' or '&&' so the entire two-character
> > operator is skipped.
> 
> This is just wrong.
> 
> Masami, don't blindly trust AI.
> 

Oops, I might mislead by the code. (I thought I've checked it...)

> I purposely did it this way. Because && and || creates a new predicate.
> 
>  If you have "x||y"
>               ^
>               i

OK,

> 
>  Start with i = 0; is_pred = false; nr_preds = 0;
> 
>    str[i] == 'x'
>    if (!is_pred) {
> 	nr_preds++;  // nr_preds = 1
>         is_pred = true;
>    }
> 
>  in for loop i++;  // i = 1; str[i] = '|'
> 
>    switch (str[i])
>    case '|':
>       if (str[i+1] != str[i]) // false

Ah, somehow I completely misread this is if (str[i+1] == str[i]) ....

>       is_pred = false;
>       continue;
> 
>  in for loop i++; // i = 2; str[i] == '|';
> 
>    switch (str[i])
>    case '|':
>       if (str[i+1] != str[i]) // true
>           break;
> 
>    if (!is_pred) {
> 	nr_preds++;  // nr_preds = 2
>         is_pred = true;
>    }
> 
>  in for loop i++; // i = 3; str[i] == 'y';
>  
>    if (!is_pred) { // false because is_pred == true
> 
> Loop ends.
> 
> nr_preds == 2. This is correct.
> 
> This patch is garbage.

OK, let me drop it.

Thanks,

> 
> -- Stevwe
> 
> 
> 
> > 
> > Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/trace_events_filter.c |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> > index 3bd0b47a627f..bcd37fd6c109 100644
> > --- a/kernel/trace/trace_events_filter.c
> > +++ b/kernel/trace/trace_events_filter.c
> > @@ -2208,6 +2208,7 @@ static int calc_stack(const char *str, int *parens, int *preds, int *err)
> >  		case '&':
> >  			if (str[i+1] != str[i])
> >  				break;
> > +			i++;
> >  			is_pred = false;
> >  			continue;
> >  		case '(':
> 
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
