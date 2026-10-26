Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793034734;
	b=xhRcyMk0HbL8j3KWjpeWkeMh6mF3gpIVTnlQe6Bg6OkSWoRmBHYDhb6yZcERjreKvQ5k
	 H6HQh9S7yo4/YRfwU8ieNyxhkTmin5VSamz3z9sCRZiDIUu7bnr8i2Hha9Ge6w5nfzuQc
	 IuLVzgjVtesExCCFo3zr1MFvRNQjTY5IAWWcmVmrrz3UviubLLRUofgD+dPgD+gruHbWK
	 aSIm5hdWBnfFhyZtkq0UOMCMNvmZkiUaQIz4ZOSrfyfjperB15B4A3sEkWjQ9up5kaei0
	 DSKL2UKr9bgzDltqtkvKdBYylrRM0OYlHCfn5Nz5PRj15OpuPX6gqrI1BvWOh5Ph2ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793034734;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=4kgg9ASH3ZlFLfzO6HjX27cuvqL8pwhipSRym9Vcj8I=;
	b=usDcZWNBW+rf5BjUIDFml3ImCuFcsHFQp2GqPv+KYhyal+Yfg0y5UoHADyGKtpxwAiav
	 I2bEqWXv72uQWd8BvJeTuYMLQMayguaQog+TbuKTjTJG21FZOYAvlR4C1Cl5VmNlehcqj
	 +SDfP9b7+BpLpspjF9MWUPFcpiTpCxAaJSrVv9qDJD5vjMt1H8qu5PD4Y0syR8Pa228Dt
	 8qvcxai6CAN+iCJNstNoUuTgmLFhtv5qYrkl21n3aB+cdySh7deFVNdM/zuaw1JMQbd+g
	 XHbg/kVq7L1qMaV0oLdB5fFKd4Txg5amBoeU4F7m4HtJ/U+7i/mEiPFiHHzP0sCKA8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=ecxfcjEr;
	arc=none smtp.remote-ip=216.40.44.13
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C74606A31A;
	Mon, 26 Oct 2026 17:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36C74606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=ecxfcjEr
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 667DA407D4;
	Mon, 26 Oct 2026 17:12:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 9D8FD60016;
	Mon, 26 Oct 2026 17:12:03 +0000 (UTC)
Date: Mon, 26 Oct 2026 13:12:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Free tracer resources on instance creation
 failure
Message-ID: <20261026131202.7cfd189e@gandalf.local.home>
In-Reply-To: <undine-1792979620229535425-240da28948f7e6f5@undined.local>
References: <20261025165250.65363-1-pocj8ur4in@gmail.com>
	<undine-1792979620229535425-240da28948f7e6f5@undined.local>
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
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 9D8FD60016
X-Stat-Signature: dw79bfw1wnuys4igsxr5wtgyx7hsdpdp
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+BkmRdG3yar4+/B29eHELLgrGlRfFIdUs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=4kgg9ASH3ZlFLfzO6HjX27cuvqL8pwhipSRym9Vcj8I=; b=ecxfcjEr2CyuDx/zD/SO7WMbwwD0ZhJ9lYK4hPN5LMfIpAavSP1ltf8wfjFMuZS5SQPUVBofmDI3dRjfqXkEky7g1FGQ93RHRv+WSiMLr4f87kABm/oRt4Bw/WjcPPMI/Mh/0K2HLB5HxGvmenM8oVBryTCi5nAkSYXfMeqKlOo=
X-HE-Tag: 1793034723-29865
X-HE-Meta: U2FsdGVkX19+xsY1+S8As2MqruODrA2xllh+YTkBzMMSIQG1m+yN3KI77nIGQQFHcFDC9bMjydctpwz+0P1viFj+RqTPrbdX3wbvkGcdhS+nbZIJpWvdyNqhcw1h/cWEXqsnf2NX2nPN0jV+fOsFKEwc2Jc76QBmm3sk2+CvQM+jRC2ZQtuI8DBCd/O3P6Ek+B6nE10RBA5e7mCCrqHrEWzWCD8+vPq7YFNUUSwcQ+XfTHV4auuy38l5qtuhk5rCvlG0RkHxGvg/BnE4kF9ZCZnzZbUmY6abl8i7OMT5Foy51SeflfhtVMrsAQeGmzLICJg7ZukfmFacarD6NFIm07VRW5D6mMuY

On Mon, 26 Oct 2026 10:53:40 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > + out_free_tracers:
> > +	free_tracers(tr);
> > +	for (int i = 0; i < tr->nr_topts; i++)
> > +		kfree(tr->topts[i].topts);
> > +	kfree(tr->topts);  
> 
> Two minor nits:
> 
> - Please declare `int i;` at the beginning of trace_array_create_systems()
>   rather than inlining it inside `for (int i = 0; ...)`, matching the
>   prevailing style in trace.c (e.g. in __remove_instance()).

Actually, it's now OK to do this. It used to not be (which is why the old
code doesn't do it), but I've been slowing moving to this style. And new
code may do so too.

-- Steve
