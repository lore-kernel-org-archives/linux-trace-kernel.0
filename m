Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067A3207A32;
	Tue, 23 Dec 2025 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766514796; cv=none; b=Gxn1l3HIHRDPhZWw0Pu24e9cEif7gmqES0UMcSS+UlWyZIDAjMEYY69yCt/xkbs1s2vUD7uVTywr4UMmmuU1aXkrUxG1GokbPCIXoqMHW+p0KgIPSHTcWnDF5YHjjxrO0RlnxSorCyXgonXW4w5ohA+rfVuK2RoJV3PaASacx9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766514796; c=relaxed/simple;
	bh=+CGRUldF+tXtsy85N0VVRIZj8/rzXAZBcZI2UBBG5No=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=piOWWD6nryMcfb1xp56Z1/SCDRmAaDAuDY17o5eiHmxcrlHg0VPdu0On50NdGaiC8RVr2482Gr07VQt4rLN3NlrgPzOFXuyitR4cUmm/N6FI64tatfJu8P3Gh18mRqyarAOeHhDRiQ/7BI24rAGUzX8NLfgJTXKhzjBtRGG8zCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id DA687B98B0;
	Tue, 23 Dec 2025 18:33:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id C2CD62000E;
	Tue, 23 Dec 2025 18:33:02 +0000 (UTC)
Date: Tue, 23 Dec 2025 13:34:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, corbet@lwn.net, sean@ashe.io,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH] tracing: Add bitmask-list option for human-readable
 bitmask display
Message-ID: <20251223133452.416fd539@gandalf.local.home>
In-Reply-To: <20251223035622.2084081-1-atomlin@atomlin.com>
References: <20251223035622.2084081-1-atomlin@atomlin.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 959ot59se51o3yyt75a8sdoxxzsdtf55
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: C2CD62000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19hB6BnmJ+DtMmyI19AhDAN0bGqc8g8+zQ=
X-HE-Tag: 1766514782-842014
X-HE-Meta: U2FsdGVkX18riX5AnSpKO8pyDy4psDxAtdL/wwM8e9m7kH2ntMnQDLthD2jRpnlOn1O7lYbLb0NrXTNo07JL9HKHuhgRJM8aV+rDsffrKawb3qt9ks4njR7dCoAdNkwYKbeYoJrwzQ8d6ogFS1I3VsG8oIdrP7Jsv9R04JwI0XUFE+4FqoHakq6l6usiS5zb+zvOD3rIZKlbnRemzUASwQ0Y2jK1gcM7/fBvBqD38CRDJAvzgrTK0JsL8SPIh+sve9vhXPxW8krlT0xm4BuMx2jDA9AbWo+Jz9Pow0xXLQlnkHJx7AXqe8YHIXwkNObV33DKQ+jIIzCIQLs8VIu81bllPWxJ0MDVblLmH8td246bKpZBgM1QJdCvCrQCrrrq

On Mon, 22 Dec 2025 22:56:22 -0500
Aaron Tomlin <atomlin@atomlin.com> wrote:

> Add support for displaying bitmasks in human-readable list format (e.g.,
> 0,2-5,7) in addition to the default hexadecimal bitmap representation.
> This is particularly useful when tracing CPU masks and other large
> bitmasks where individual bit positions are more meaningful than their
> hexadecimal encoding.
> 
> When the "bitmask-list" option is enabled, the printk "%*pbl" format
> specifier is used to render bitmasks as comma-separated ranges, making
> trace output easier to interpret for complex CPU configurations and
> large bitmask values.

Hmm, I have a couple of issues with this change. One, this is global. It
affects all instances. The other is that if this is going to be done, then
instead of adding a parameter to trace_seq_bitmask(), another trace_seq_*
API should be created. Perhaps trace_seq_bitmask_cnt()? And have
trace_print_bitmask_seq() call them separately.

I'm still not convinced that this is needed. What examples do you see?
Should it be only for CPU bitmasks?

I think a bit more thought needs to be made on a change like this. There's
other options that were added that I now regret. I don't want to add
another one I wish we didn't have.

-- Steve
