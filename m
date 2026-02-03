Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57FD3A7857;
	Tue,  3 Feb 2026 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770128995; cv=none; b=FsyrizTbKI3XjwfsRH5IlJMbVZWyZwMOIozcAu32UvEs4IoAigohrAjXi5u3nqMPGtxfHWN3i4DRbWVEWVJYyox77RnaRbpkIdj/Ly1A1Lqa7exEW8KqBYy7SGjb7xGeMEf2ZadIPZnz5AyMvHnLdMVHijSwwrp/wnQSe4Cqc10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770128995; c=relaxed/simple;
	bh=T+hMuGIY76t3lLIwOw1rWdzWI6jjBaIC8Im80rJ1Smw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SwJ3bwIj/UaphT2vV3lJ7JY6ftmnCovMMZCIx2PnDa/2hal+Ra5FRCRbsOGvswN+Ba/+Dl9FgrebjocVZe0s1FbCqBtsS5+OpbZDl6dZkuA8zHBVliH2HjfIWkGZKZ1yz7TWamDXQBO3s9u0vZIjg4oQw2oDPP6oJFpFCmEV8pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 2BD7E8BD02;
	Tue,  3 Feb 2026 14:29:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 47AE780012;
	Tue,  3 Feb 2026 14:29:50 +0000 (UTC)
Date: Tue, 3 Feb 2026 09:30:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "jempty.liang" <imntjempty@163.com>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Fix funcgraph_exit calltime/rettime offset
 for 32-bit ARM
Message-ID: <20260203093018.66c3b3b2@gandalf.local.home>
In-Reply-To: <19eab264.7fae.19c22f5d17c.Coremail.imntjempty@163.com>
References: <20260202123342.2544795-1-imntjempty@163.com>
	<20260202103804.40cbaa27@gandalf.local.home>
	<20260202110828.440c8d44@gandalf.local.home>
	<19eab264.7fae.19c22f5d17c.Coremail.imntjempty@163.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: mgaip91yqjm8sngigzpgzjtqnhme1ru1
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 47AE780012
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18JPLKcKj1mSo8vyoht80weyBYHgJD8Ldk=
X-HE-Tag: 1770128990-178489
X-HE-Meta: U2FsdGVkX1/IrPwkA8FChPLHlyImaORVDcA5laWr98vW5iu/gxZf8WAEkSGt4xAsVhAZS8IpdRyID0Kcchs23KeonpA3j3L94ICXcDUBWMWZ/igY3nD2g5nlEu91/7ljvDku9dNCgGksacWzoaogQ2UTTjyALTd65+pFIaSpW4eQ9qXXYvKtJflCR81zomJJTIcqECwBMLqF34cgF6pTmTKIqKUclA8c/BkEUaysjdpb2JMikYZC+T41UY56n3lNtD4gnu/txc1Y5hZEO6YOy5hvZfATzhz4wxYQS6h/R6ns4Jul0C9vjJYY0V7ErYxdXeOSecc35sRYhxQrIS9D8+4/L3+s4fzn

On Tue, 3 Feb 2026 18:04:21 +0800 (CST)
"jempty.liang" <imntjempty@163.com> wrote:

> > #include "trace_output.h"
> > 
> >+/* The alignment of a type when in a structure */
> >+#define ALIGN_STRUCTFIELD(type) ((int)(__alignof__(struct {type b;})))
> >+
> > /* Stub function for events with triggers */
> > static int ftrace_event_register(struct trace_event_call *call,
> > 				 enum trace_reg type, void *data)
> >@@ -88,7 +91,7 @@ static void __always_unused ____ftrace_check_##name(void)		\
> > #undef __field_ext
> > #define __field_ext(_type, _item, _filter_type) {			\
> > 	.type = #_type, .name = #_item,					\
> >-	.size = sizeof(_type), .align = __alignof__(_type),		\
> >+	.size = sizeof(_type), .align = ALIGN_STRUCTFIELD(_type),	\
> > 	is_signed_type(_type), .filter_type = _filter_type },
> >   
> On the 32-bit ARM platform, when _type is unsigned long long, the resulting align value is 8 instead of the expected 4.
> >   

Are you saying this still doesn't work?

That would be an issue because then it would have the same bugs with
generic trace events which uses the same solution.

-- Steve
