Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795205412;
	b=h8McwBbLKLZftY16vFcJ8f/+sZTVzmdTPEr2ZErIX83Oz6mAVkRqy8iKK87a1Ny1MDLI
	 AR0DT2TP1WmyLloZDw8klcweVB49V3qOV7NtT0HzyakXs3/2jj29+LU5RiXNma3y5zzvk
	 Uh+UYcuPBbvG3YTL2z+4DPjm+2TjOyVsa29sjqom/5yGb57mZWOg20OJSGNnprWFFWQVM
	 uV6RDdorfWtGGDZH3hn5BwooKux/x5RJ+VYApR5r2wuIrJuayBb7QY2YYlfiCMuPq0PRN
	 GjwZhel5TIpuylyf0z7Thg4sLNX+evEEvyyKuckT4IsP05BQU4byrT0llEaKG/k6U1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795205412;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=hosspx6aaU+k/GrFDy0XlCAJwuBQtVCG9tTxjtZLOwE=;
	b=ObNA+3SoqMQxEEAZNHv9W4Um03e3oEkznfEQOAP20AR5wY3qApQ3reWN2J44AQdotqqP
	 nW3sC8JEjz9pkeSUxtuYQPnLntRDnITDlE3Xu7VjsYmSozeCQNPyr8Aj7MlRM0ikR6Qek
	 SY77gYkhWZqfv79IiQh6+XHDs+AGRdjgc3DEKweqC4qSPTvSk3cJHmd15nvOHW4My/Jg5
	 WafccboLQFumbk5BrxxbSdxhKc28Kn9O/auzocnhpoBZLURaG6fbWlqm69ubyH6YzisI3
	 Atbf2cUvWKT/A9IRUxFWZKNOy/AXHeCMCqOhm+eX58ffKgJmzccHhv5krIQDU/mz9Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=kUGM3OjP;
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0D3606A6E9
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 20:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F0D3606A6E9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=kUGM3OjP
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 8BC5FA019E;
	Fri, 20 Nov 2026 20:10:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 0BF122002F;
	Fri, 20 Nov 2026 20:10:06 +0000 (UTC)
Date: Fri, 20 Nov 2026 15:10:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Linux Trace Kernel"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] tracing/probes: Zero out faulted dereferenced fields
Message-ID: <20261120151005.7142efbe@gandalf.local.home>
In-Reply-To: <sashiko-outbox-225971@kernel.org>
References: <20261120143002.18b364b3@gandalf.local.home>
	<sashiko-outbox-225971@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: c8577iojcnz1jho9g7rdqadtr3cy3tkt
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 0BF122002F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18uEZKSswVMbbkwjEahiYw7sm7wizjqlpI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=hosspx6aaU+k/GrFDy0XlCAJwuBQtVCG9tTxjtZLOwE=; b=kUGM3OjPd/93C20BIkGolWShB6pw9G2o03dbOtfrg9xG78sum0l6I+EQVyg+Mwar9pAvyoPAB4k/QLHl5/ztc9WWQn4hRCXAS7RyINuzSufeVcIMI1G7g9xgbTYuCHD2DltLpCY9I6NEd+Q1Fj7aP98alhGUqeVey37XXWNzNCI=
X-HE-Tag: 1795205406-973688
X-HE-Meta: U2FsdGVkX1/ISfEjAldu9/skfwWLEUwDc+vWPTa66F9QRsA90OT+/RSOzi4NmKGkOBKV7943I3z86boHtgfsSgSfiRgfuDxzjxs461ZhR3lsGs5uJHNbtYhqXWpEW1IXWB81xopF4wFZ2QK2ZD2H9Nvfqz3uo9xkLkpBp3GIRSIKuoyjno7L7tLgRXnmXrZ28P03X/oN0SeFEhQ1I54/9Jfkto7X6/qbJSwAbld3RYScLwbBwwxB8/j4NU1HPwtWBWirUPeKdE2B6dsC9pspw0pktrxOBzDAZBYv/cB0RGb2d+ki7CDwkpkz2kCpg+ZpSrRfZ01bpDsDg0yjXWDbJ5zDyMqKnwst

On Fri, 20 Nov 2026 19:52:53 +0000
sashiko-bot@kernel.org wrote:

> > -			val = lval + sizeof(char *);
> > +			/* Only update a non NULL val */
> > +			if (val)
> > +				val = lval + sizeof(char *);  
> 
> [Severity: Medium]
> Should this check if (lval) instead of if (val) when advancing through a
> string pointer array?
> 
> For FETCH_OP_ST_STRING and FETCH_OP_ST_USTRING arrays, stage 2 saves the
> current array slot address in lval and dereferences that slot into val.
> If the array pointer lval is valid but element i is NULL (or reading it
> faulted), val is 0 while lval is non-zero.  Checking if (val) leaves val
> as 0 instead of advancing to lval + sizeof(char *), so jumping back to
> stage2 overwrites lval with 0 and causes all remaining string elements in
> the array to be skipped and recorded as faulted.

Hmm, I'm not sure if it makes much of a difference. If val were to fault,
it is very likely that lval would fault too. But perhaps it should be:

	val = lval ? lval + sizeof(char *) : 0;

I'll send a v5.

-- Steve
