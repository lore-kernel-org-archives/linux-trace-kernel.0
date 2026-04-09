Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B822BEC43;
	Thu,  9 Apr 2026 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775750361; cv=none; b=uWSx7rG54ftNAcKqsdw4zzE9sYvdRIr+gEBfOTaQWVA3tATQNfaA5toay9IJi8o8UWCIuUvoaJ+DpDsjbNlcE28wuHlLrWJcJop7eucVNVIK0Du9qIrIBTYKV/ii/9RMRIVhmdmRH44ncSVQ4RWdlRNr3mCFA4rK6wMjQW/6z+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775750361; c=relaxed/simple;
	bh=U9CKN3OU7mysW9YtNEoWjz0fVYEYdpdZw3L+IKx437A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qwqnPC3HYpurNlp18uLEkKv09/FPJLUHCmcyAzdVViqnF1ATryDmnoLHv09FDNHEn9ismxciM5wdrKloxon2DWab199yBwdBtNbkSj4kt/Rb2m88CLsMWPPXaFGPvp2XEjdpmeNTfH7SV+xTXEQetpo50gKDWAdAvaN/5rGg1xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=mc1EB6Dt; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="mc1EB6Dt"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C365140B2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1775750358; bh=oqUXX3RHjScrdzQ2jd+6JPTj/DA3k6L/Y3rrpbUINI0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mc1EB6DtAbrOH0+GWdNAOYljJfIF0YPUAfCz9HJ6WqTLtQFclqe9I4W1JssD23rwv
	 AnQ/JMjX/L6keH1Me9hSTlsP99em8P/xhSG9T/SamoLteLcTbvc1fDnwq11uWG0GoK
	 ic95hUYwF/0645Mmif4lug4JxgbhDo/lixqE0YsoYlwLkOzK9ff0hIEfKPV2f+8FFg
	 bdiEm4F8nPBNQC9tpTZpfobEhtJb9GQaG2TxQbFp2Qp/5xElUpW1QYy68/39VeeFNd
	 yzv2tRDwh2kHtIOEhBaE2l+XBqEnJ+NFU4UPzl9OSPedUEril5Xl1W6M71OpE09FDd
	 QQ4rNHRXfVRDw==
Received: from localhost (c-71-229-227-126.hsd1.co.comcast.net [71.229.227.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C365140B2D;
	Thu,  9 Apr 2026 15:59:18 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux
 Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing: Documentation: Update histogram-design.rst for
 fn() handling
In-Reply-To: <20260409115200.45883a07@gandalf.local.home>
References: <20260126181742.03e8f0d5@gandalf.local.home>
 <20260305110347.31d6bae5@gandalf.local.home>
 <87bjfsb37x.fsf@trenco.lwn.net>
 <20260409115200.45883a07@gandalf.local.home>
Date: Thu, 09 Apr 2026 09:59:17 -0600
Message-ID: <87tstk9lbe.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Steven Rostedt <rostedt@goodmis.org> writes:

> On Thu, 09 Apr 2026 08:47:14 -0600
> Jonathan Corbet <corbet@lwn.net> wrote:
>
>> Steven Rostedt <rostedt@goodmis.org> writes:
>> 
>> > Hi Jon,
>> >
>> > Can you take this through your tree?  
>> 
>> Somehow it fell through a crack in my inbox, but I have, finally, done
>> that.  Sorry for the delay.
>
> Thanks, it has happened to me too often but not as much when I started
> using patchwork. Is there a patchwork monitoring linux-doc? If not, I
> highly recommend it. I stopped missing almost all patches when I started
> managing patches with patchwork. The few times I missed patches was when I
> accidentally incorrectly changed the status of a patch. But that's usually
> due to my own negligence and not simply because it was lost in my INBOX.

No patchwork ... but there is a *massive* pile of stuff that lands on
linux-doc that I'm not meant to touch.  I think that "b4 review" might
be my way forward here.

Thanks,

jon
