Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714955;
	b=Ul5YaEvosntLfneYsM1QJh5j4erCqtptGrMVNxqkH/lm+8jvklDHThD+uMRlZiqzw3tc
	 QualWS+dxnnwglrW2frl/WV32hFBEiPF6iGlM7ZCaSkbfiX+1L0cHZJECsVuu7hmDjj1u
	 IEme45UDIkUhVkr0YfBqGtUXREfyVOT2UUd++2aXQO/r/aO10j4riIpeHcfQLyhiQUVu/
	 /Nh4orNA6Owh4BOfBEv+GSTNnbAQKwkzUaa7vK7AeZb7p2bZJRy6sWHE9LpXn0sUeSKaF
	 E+d/zaCWAdryvJ74ImS5Kw+xRy8Qzko4ekksJCTGrJ5C/SM05X0CfxFbJJw+gzLNN7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714955;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=v+uRgwbRUU4aheoQPyto2Oz4JzeLx90BnFlBnJNi9qE=;
	b=mwDttaefKD8Wn3qaoNwUWrUdJptMkZfGwmy4UnFAVS/h4VhZ/OXQphbf44KZRvjyGC5R
	 2mB7L1ENXIcp3MmF0kNuATfFt6MmRzDqUJQ8NM6PQbF8v1/Fi4Br10HAqlqLWOUxuU4Ob
	 UI8/3NzAgyzWURyDvcDfE1oSHmwu3Vwayb3Re5AT6joNIHHfrmKxMZ4/n3rsyG6h6TDT6
	 99D9DxqoPMD4DXd7662+RW0SXGw+93SKBggeAgv4jkEEMoeJSABzX3r1OtnO5rj81H2Au
	 mEJp5Zdo+HcTRfUZ8WZPlt2uPgKlcdiFCZcuonDZ+ll95IGf+aLgd22zbauxzAP75lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b="RcA/7teZ";
	arc=none smtp.remote-ip=216.40.44.13
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0DA606A324;
	Tue,  3 Nov 2026 14:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C0DA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=RcA/7teZ
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 8F06640454;
	Tue,  3 Nov 2026 14:09:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id B861F60016;
	Tue,  3 Nov 2026 14:09:02 +0000 (UTC)
Date: Tue, 3 Nov 2026 09:09:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Mladek <pmladek@suse.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, John Ogness
 <john.ogness@linutronix.de>, Jonathan Corbet <corbet@lwn.net>, Naveen N Rao
 <naveen@kernel.org>, "David S . Miller" <davem@davemloft.net>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Tiezhu
 Yang <yangtiezhu@loongson.cn>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/3] probes: Use trace_printk() in probe handlers
Message-ID: <20261103090901.0b5957e9@gandalf.local.home>
In-Reply-To: <aunBcxXXNhXDd-U5@pathway.suse.cz>
References: <179360345418.115681.193455787480210412.stgit@devnote2>
	<20261102123408.0fb950bf@gandalf.local.home>
	<871p9251ve.fsf@jogness.linutronix.de>
	<undine-1793671566795563056-fb7169cffcc7ac3c@undined.local>
	<aunBcxXXNhXDd-U5@pathway.suse.cz>
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
X-Stat-Signature: nq4s4fjsfjocj8t6iixs6h4humbp4ruq
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: B861F60016
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/QnPlfa3I395bqi8l8xsN2mnoDaFGMewc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=v+uRgwbRUU4aheoQPyto2Oz4JzeLx90BnFlBnJNi9qE=; b=RcA/7teZrODlM5KYH8KSEoVpU9j+dS0QzO/mc6D1E+jRxUPuqH2Cz6ZCUrK3AT3Z/IwKoNHIsvGfj2xrlx3t3LDvl7Bz7JchdPFVwr9uanXdvVth6hMwYGLkXz+7XGA8UUuf+TwiYRJtt4vYKKE+tYyH1U/bXFsJUxbP9qLbrTo=
X-HE-Tag: 1793714942-743349
X-HE-Meta: U2FsdGVkX1/3qNtaCofL59FjZEa84TUZgw3Trz2OZkzfhk3I3l4+qiIfQnr1P2qj0FRkGu9WhokLbcR5J4EAU3BbnVEimd2bqlqnNPrewt/Dua1s5+6CrZLk7sxitIndDGTbqqEzY84oKQ3Tzntwg1nR7CtZpMx1QiIyJ8zRorLweoKnmK5K7VAK1l/rw5w3iJ6N0bpyEDqPB8MtcsZW8nZIVYBeztctiovl41KH5gaB8uwuZpSMXFmx91OEMVjxpHbV5LRepnFO9icODD+X3xHwp8JsahuROZflTCfaAJwT7GfhjpEGb9FwrjSordW4Ui58wK+0+lhiYDBsKeaX6L6WFLfkJM+8gaim7OvZVy9KQ4PHHZiRXlUI3EP5f4gX

On Tue, 3 Nov 2026 12:11:47 +0100
Petr Mladek <pmladek@suse.com> wrote:

> I believe that trace_printk() has a similar problem. You could
> not use it inside the code used by trace_printk() because
> it might cause an unbound recursion.

That is slightly incorrect. I use trace_printk() to debug tracing! ;-)

Well, adding trace_printk() to the trace_printk() function itself will have
issues, but the ring buffer logic allows trace_printk() to be injected into
it. The ring buffer has recursion protection, so adding trace_printk() into
the ftrace ring buffer will print the trace_printk(). You may need to add a
way to not do the trace_printk() again, otherwise you may get multiple
prints until the nested limit is reached.

But I just wanted to point out that I do use trace_printk() to debug the
ring buffer even though trace_printk itself uses the ring buffer too.

-- Steve
