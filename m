Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794954480;
	b=ZaWynfajcEA28TDuFPxEwszEQ9pnFFKIQG1TNFZT/kUpbq0uRoVz5SONseqwFYJs9ytj
	 K+XVzqgQADCx2k5GhqFf48rPNXTNWimrF4I+xC0txIL9UBM8EAge3SdhahUEXdq7b4PBT
	 WmGAXXIptb3hgprWlip52a0U3S4U2ZouH+dtCkJemoCPG0Bx8hfwHUab0a6TuczVzv08E
	 x7KQY3SKYOKb5X1I0JWTZPyMVNFkuRM2HNFuXHGf0HkJ8lshhAe23qoThrmMNQ0K8nM1y
	 jUHkwtSpcqse8TN4QpxlrU1OUWkaTXeTVnw2xTk55cBAmQPHrXeNuuqxF0iZB0vv+hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794954480;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Rspamd-Server:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=ko/0t8Uo3cYIjjNrJtn/Btsh4RwXHj5exYfcCPg49hM=;
	b=Wpw97X5m1Cm2Fvwxx2OcVjtslYuAzh1cSPW9+LnG9L1MBhenUiuFJFjtGzl86Xfxlj9T
	 hIgrwqS/DHgjifdzcMwByjbMUXaS4hCDBWXkBbhxwpCkvtfNEb2ltACM0J2hUQQ28THxd
	 1dV4QOxYdf8vv5zwPlCFawHuO+IgeNDg1Da3HPbnnIMJwa89gyCRqbpUVViCb742aFD/0
	 FzyUy07qSuyk+UelXLLeH33LO3cJsphWrR8XV50VryyCd4hazbnbplxcm5zWlrukeXQhO
	 DsUV0B7bNhE36xF7xdhOEMmsECICEk61VCunxqfz90wAxi0SopAG6VQce7b+7fNaaFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=EHdbSKZv;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164C4606A32A;
	Tue, 17 Nov 2026 22:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 164C4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=EHdbSKZv
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 1C7691605D3;
	Tue, 17 Nov 2026 22:27:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id D729F20010;
	Tue, 17 Nov 2026 22:27:48 +0000 (UTC)
Date: Tue, 17 Nov 2026 17:27:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Chaosheng Qu <quchaosheng000406@163.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] tracing: record jiffies in writeback events instead
 of computing age
Message-ID: <20261117172746.42d075bd@gandalf.local.home>
In-Reply-To: <1793157924.328974.4869096@163.com>
References: <179299543891.294518.18224691820856958686@163.com>
	<20261026084709.26f7737f@fedora>
	<1793157924.328974.4869096@163.com>
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
X-Rspamd-Queue-Id: D729F20010
X-Rspamd-Server: rspamout08
X-Stat-Signature: s4cdizhjhscjqygk7q3m9hwq93831cn9
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX198/NLHb3rmfOYPbcxeL4+SJl56B6U+SzQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=ko/0t8Uo3cYIjjNrJtn/Btsh4RwXHj5exYfcCPg49hM=; b=EHdbSKZvsn4//OVY5FY9Ahc2Tr8C4l4YN0lT74uTZqOOPhLacf/5lPpne0rS3RvEfZ9Dz6hWOaY62RNhdEFR28cKvlVDus+WOszi56LR5mxRHeMY0/efedKKf8hZ2BVH6nl82a8iGgpjZ1JOrX/PpVzRZKvfWLyKVdkBMGXG5ZE=
X-HE-Tag: 1794954468-512238
X-HE-Meta: U2FsdGVkX190m8CaKzES5kkLjFQxipcm1qgoflPGiCdFdHoV/FJOi7oPWmrW/1uY5DfHuFUsYYtdOUrf/ZK9RxJzapxWclGLxgXg8MEjes2VO9bI+ZVkW9zULcpftBVXpjpzJ5c8oN5jNpC6NyyvI8On5ZS9EWXaoE5tZjHAVYtfSMhC1kjbXuSroDAB8o7oHlSqwwbdpSbPA3ApcT9R49GjPH/6IC69a94Cwb1AlRJzo1Bu2B+60/hZ61I1WTDhjHevSD0Vxyi0Hqseuwm+z0N4+0wvVg90mZX7TKi87U3wk5yplLLOqFVSHrsELlSJWvql6CScXnA5SczNE0BbcN5t730IAdBBHrPJaIKIcGRanX1kpbl3Yb7z/fLVweo/aIv07eiOBJYU5rm0630Jk+led1HWzJNow0UzQMUFkjA=

On Wed, 28 Oct 2026 11:25:24 +0800
Chaosheng Qu <quchaosheng000406@163.com> wrote:

> >From 677560a14dae0d9581effc5cdb9375052902bb21 Mon Sep 17 00:00:00 2001  
> From: Chaosheng Qu <quchaosheng000406@163.com>
> Date: Tue, 27 Oct 2026 14:28:09 +0800
> Subject: [PATCH] tracing: record jiffies in writeback events instead of
>  computing age
> 
> writeback_sb_inodes_requeue and writeback_single_inode_start/() compute
> the inode age with:
> 
> 	(jiffies - __entry->dirtied_when) / HZ
> 
> inside TP_printk().  TP_printk() is not part of the recorded event: it
> runs when the trace is read back, so the expression is evaluated at
> formatter time, not at the time the event was recorded.
> 
> It is also evaluated outside of the kernel: tracefs renders the format
> string once and userspace re-evaluates it.  A tool that has to resolve
> every symbol in the expression (trace-cmd and the parser in LISA both
> do) resolves the bare "jiffies" to its address, so the printed age
> becomes ((unsigned long)&jiffies - dirtied_when) / HZ, which is
> nonsense.  This was reported as a wrong "age" value in trace-cmd
> output:
> 
>   https://bugzilla.kernel.org/show_bug.cgi?id=219839
> 
> Nothing in TP_printk() may depend on the state of the machine at read
> time, which is the same rule that keeps ktime_get() and friends out of
> it.
> 
> v1 stored the age itself in TP_fast_assign().  Steve pointed out that
> the division then runs on the trace path, which is where the side
> effects have to stay small, and that recording the jiffies snapshot
> instead lets userspace compute whatever it wants from the raw value.
> Do that: save jiffies in TP_fast_assign() and keep the subtraction and
> the division in TP_printk(), where they run on the slow path.  This
> follows the same shape as xprtrdma_req's connect/reconnect fields.
> 
> The new __entry->jiffies field is appended after the existing fields,
> so no existing field changes offset and trace consumers that index the
> event by offset keep working.  The "age=%lu" placeholder keeps its
> position in the output text, and the value it prints is unchanged.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219839
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
> ---

This should likely go through the fs or mm tree.

-- Steve
