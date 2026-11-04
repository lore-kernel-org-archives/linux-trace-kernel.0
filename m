Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793753076;
	b=gcfSo2IQbRfnHQwa5Hrc3Mo75gMHcnojUEdyi1tzvLSwGwgFJpG1AwUmdYAy8wSpb6+q
	 BD8D0hRYHKBfm3BYsV8/s5xk2aFpoALLDVyMCXWDXHq2gEGTLcr00hgXMqm+oWmRRp5rN
	 uh2GbseDPMF8XHeNZiQI7ILz0t7RXQg5SFf9rsI14ZvpfaaH3yJlK5rkne5mwXVlqtqtb
	 ++DTSa9TnRrxwqvESg7zEdwFXd/oH1FPNtDpfRlfXApM6wtVDMgmjPgoRpqRwLiWD/JSw
	 ddSlCaOkO35JuMEz9SCBW9mXMG5X6JLFLfp0mgehNDkRrJu9RMlynYokHo/51+B5jdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793753076;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Stat-Signature:
	 X-Spam-Status:X-Rspamd-Server:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=aEGJHb/5zFbU60eZLgOxUEw96YHWbvU2+MVwYu/t60w=;
	b=XqaEKTS7Zl3HFrh92rgK2yTJ4+dt3kKJ0LLg2/GSE1WyoGciOoDALrz5eApVnc9bk2Xk
	 jxQnCruqORHcQKn+vl3LpC/jCz7LRVPhVw5Eevb18x3cT9nhTKmQ0nQlG+aFelEnzigiW
	 IM8ElOlncLTxt8CD5iSKgavV7z9GDygHPJUEoXB9QmGNFjzV5+f0sI2VZ4PcKETV8du51
	 oCymkRUnlWtK8LrxAIXEkYOdLjEDL3hav79WzJOBjoorrVad4Qet8bgKSGn84dSNH1Z4f
	 E8HLNmAqqiylQtKc5sDSNUTNkhkFM8gGoWMFcYk0EFIte+/3wssr3x3INVJc+GotU+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=asaOTB5Z;
	arc=none smtp.remote-ip=216.40.44.13
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23520606A324;
	Wed,  4 Nov 2026 00:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23520606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=asaOTB5Z
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id EE83440613;
	Wed,  4 Nov 2026 00:44:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id A44C032;
	Wed,  4 Nov 2026 00:44:30 +0000 (UTC)
Date: Tue, 3 Nov 2026 19:44:29 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Li Pengfei <ljdlns1987@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 mark.rutland@arm.com, corbet@lwn.net, skhan@linuxfoundation.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhangbo56@xiaomi.com
Subject: Re: [RFC PATCH v7 00/10] trace: stack trace deduplication for
 ftrace ring buffer
Message-ID: <20261103194429.739feafc@gandalf.local.home>
In-Reply-To: <20261013020321.1898006-1-lipengfei28@xiaomi.com>
References: <20260912083753.3426176-1-lipengfei28@xiaomi.com>
	<20261013020321.1898006-1-lipengfei28@xiaomi.com>
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
X-Rspamd-Queue-Id: A44C032
X-Stat-Signature: b4xterkghayctsue88f8pn6o7yam4z68
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18q6qCv8Ph8nZb8xkdepwjLXLf8IlNcpLs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=aEGJHb/5zFbU60eZLgOxUEw96YHWbvU2+MVwYu/t60w=; b=asaOTB5Z4hcmswm1Wps0saK3glzogXDT6O0HY8WGLmBdBqIdug7KedIBfg1DH0JpwNpYACt6rIv2mZGJoWk2GkwsCiuSrEwZb0/OLbwjI/jnX+ZdXIQgfFzGkwmKB9vGrOa5Mz0FqqljicAiSqCR0zyrvvMhYjbAcLnujtRzclo=
X-HE-Tag: 1793753070-516529
X-HE-Meta: U2FsdGVkX19zsgS+XmZAhH+xydjGFdLZOA84525l5hFdOvxS70wl6GMJwf4OD+OHVYnTR7fTbSzKQonWPDkudxINph4GxAaan2BaKD+XItRBqasnT8TEOooz2e1VG64/GAeEEDe1cl2QF5uaOz3n+YyRzTGmZD1sDVe4D0FWi3/319hcH8IH1Lj84IrNW2l0SSPFwFIqMa/fgfXWdzfZACorb0pn40VFc6D2/wgUMxN7FQsDxWF2yq1Bc3KVB4RIy81tyOqc+cvopIB4hhz6JcSrPcwDO+s2qxCNq8Mp1luG3Th4DQJLHAX8cUBL++D2beXsZr7/SGrRovnAj3+kkaGzaa/c09yp

On Tue, 13 Oct 2026 10:03:21 +0800
Li Pengfei <ljdlns1987@gmail.com> wrote:

> Hi Steven, Masami,
> 
> Open question 2 in the v7 cover letter was whether the map generation
> should be part of the ABI. I think it has to be, and I would rather
> settle the record format with you before sending a v8.
> 
> The problem is that reset clears the map and resets the element cursor to
> zero, so a new stack takes slot 42 immediately afterwards. A stack_id 42
> recorded before the reset is still sitting in the ring buffer, and
> resolving it now yields the new occupant of that slot. Userspace cannot
> tell that apart from a correct lookup - it gets a plausible stack, not an
> error.


> 
> I first tried to fix it in the table, storing the generation per slot and
> comparing it with the current one on lookup. That does not work: the
> comparison tells you which generation the slot now holds, not which
> generation the caller's id came from, and the case that matters is
> exactly when those differ and the slot has already been refilled. The
> identity has to travel with the record.
> 
> So for v8:
> 
> 	struct stack_id_entry {
> 		struct trace_entry	ent;
> 		u64			stack_cookie;	/* gen << 32 | id */
> 	};
> 
> A single opaque 64-bit cookie, high half generation, low half slot. An id
> is still only valid within its own generation; the cookie makes crossing
> that boundary detectable.
> 
> stack_map_bin reports the generation of the dump in the header word that
> is currently reserved (ABI version 1 -> 2), so a dump and a record can be
> paired. Text output splits the cookie rather than printing it raw:
> 
> 	<stack_id 42 gen 3>
> 
> Cost, against the workload measured in the v7 cover letter:
> 
> 	full stack, ~20 frames   trace_entry + size + 8*20 = 172 B
> 	v7, 4-byte id            trace_entry + 4           =  12 B
> 	v8, 8-byte cookie        trace_entry + 8           =  16 B

This is reasonable.

> 
> Retention on that workload drops from about 2.17x to about 2.0x. I will
> re-measure rather than quote that from arithmetic.
> 
> Two alternatives I rejected, in case you would have picked one:
> 
> Packing the generation into the existing 32-bit id keeps the record at 4
> bytes, but with FTRACE_STACKMAP_BITS_MAX at 18 the slot index needs 19
> bits, leaving 12 bits of generation in a signed field. 4096 resets wrap,
> and a wrapped generation passes the check - the same failure, only
> rarer. It also ties the id layout to the capacity limit.
> 
> Two separate u32 fields come to the same 16 bytes and would make the
> format file self-describing, so an event filter could match the slot
> directly. I went with the cookie because an opaque value says the whole
> thing is the identifier - two fields invite userspace to read the slot
> number on its own, which is exactly what is not meaningful without its
> generation. If the filtering matters more, that is an easy change.
> 
> One consequence I had not expected. If a trace spans several resets,
> dumping stack_map_bin before each one keeps the whole timeline resolvable
> afterwards: every record says which generation it belongs to and every
> dump header says which generation it is. Without the tag, saving several
> dumps is pointless, since nothing says which dump a given record should
> be read against.
> 
> Does that format look right?

Yeah, the cookie + generation looks like the best way forward.

Thanks,

-- Steve


> 
> v7 split the series into 10 focused patches following Masami's review of
> v6, and the design is otherwise unchanged.

