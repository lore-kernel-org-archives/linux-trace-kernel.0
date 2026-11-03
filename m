Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674432;
	b=anA/+5CLJyilKTYml9s7xkBeJy+V3SMSZ8BlWh/7PNZGayPscqFC3bLs6e3NUPfctkQk
	 Zvz1/8BVZT6jt0CDY3bio3zTjl3YELFQrqIwjWrK0C1voncsPZ3KCltjv/Oi252JkxwE/
	 Hwxi1GQTd7Da/5TENAwImM/3OzjxN/35DnwUvx4DEix1TKx/FsozXfy6ksWVTygu2LEt2
	 5eQMSzHaYLq9ziMtrPlzRMbdUEzJL8LVEODFPuMU9Q3QyQQtmk+ebh/Kcw8u9QuYxPcbO
	 riC5+jKjM+vfu1nMpH/gXmmVMfUqToIifrf553azTVBIemiJGn+ci3W+FqtD+dWWpzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674432;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam-Status:X-Rspamd-Server:
	 X-Stat-Signature:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=b8PDBem/xIJsEalDu37TvEci4oklugRNp6qciOyhRm4=;
	b=ELG4WB8yLDRFETHxmhRYsIidNfwS2s4QPM3CAaLZCakMEFrlBgW52N19/pQtfJpCMW1W
	 TaTR5wSbTwwa8IyhFgXxl42IlysIWsERoORYib+vTOwqfedGLgkeuh/l2J6gcXM9BZ/ow
	 K1IPxJnVfZqyjSJc/2XzMeChiIooSbGhi/jVVRyklVGp7v1zi40fjsUyIrhK8eKraK7xg
	 XixUGMbvT3hbDq2b5RL4ECyoCz31z1MBg7nZYHrHQAZ98wKlATOqJjrYEz4Q4gVYHnKdx
	 Fm0zSU18QqYneE19+OhgdDcz8piYAUcQLKreo+iIon9AmUDXaumqIqcZeucc6hgEhfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=zyGYukAw;
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8A4606A326;
	Tue,  3 Nov 2026 02:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF8A4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=zyGYukAw
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 8A8D2A02E2;
	Tue,  3 Nov 2026 02:53:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id CAB1133;
	Tue,  3 Nov 2026 02:53:41 +0000 (UTC)
Date: Mon, 2 Nov 2026 21:53:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Anubhav Shelat <ashelat@redhat.com>
Subject: Re: [PATCH v4] tracefs: Add read-only eventfs filesystem at
 /sys/kernel/events
Message-ID: <20261102215340.7ce61964@fedora>
In-Reply-To: <undine-1793672283667563124-a33a39e2a7561653@undined.local>
References: <20261102152748.614ddc8f@gandalf.local.home>
	<undine-1793672283667563124-a33a39e2a7561653@undined.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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
X-Rspamd-Server: rspamout06
X-Stat-Signature: fz6n5g1kd3uk14jzjajh7ucweoy8puc4
X-Rspamd-Queue-Id: CAB1133
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX183Wt8CH8FuISaNIx8K7FGjLVHSKMTik3Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=b8PDBem/xIJsEalDu37TvEci4oklugRNp6qciOyhRm4=; b=zyGYukAwFtkiXv68tVN3semdpsZxpWbn5RLSN9eHk5HpzPBzFSEc8gtQPx3yhnlTpAbdT6kai8p7H2w6RQh6N3N94Nl4S5gdLvB+9u2V6Mzuolzb0qcn/VgLapinsXqE0FMwejpEP7YIKf1/FiYSc7AWbeDAFT/Jymca+KGv+8U=
X-HE-Tag: 1793674421-809585
X-HE-Meta: U2FsdGVkX1+f9bhBzjnh1VJXpfxdsd10BbUG8c/yMoM0BRer/A14IjpxLj7YvkLgwIn7VWIxeYK1eE8Oh957BzR5tIMf2IUuK6X1AAcPS5k2ZfPjKVyajD1WunsWTt02ESKT7JhB9LJRgzFyJvbL2r/GS8a47zlXkgvZccs0OnsV6MvpBPy5XZ/3lQlJPSZy7mQ7USYOMTneO5hMmPByqBQsQJorg4dlh92cJXv3sBw6j+KdOeUJ7FPJRi3fqFUhCKeXEylQF//QZ5UDMn/rJ63EcRTNGN53tETpiYDZYhmINEsmYPL1o5aw8cRsy0M1idvrT8KUOJSdNL0MAGkVy7gNWsVAHBBECrKO+4dF1t9hm8PzIonsNg==

On Tue, 03 Nov 2026 11:18:03 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

\
> Thanks for the work! As we talked offline, I think we can use this for
> the backup instance (an instance copied from another instance at boot)
> because that backup instance is also read only. See trace_array_is_readonly()
> and TRACE_ARRAY_FL_RDONLY[1].

Will do.

> 
> [1] https://lore.kernel.org/all/177502546939.1311542.1826814401724828930.stgit@mhiramat.tok.corp.google.com/
> 
> > 
> > Assisted-by: CLAUDE:claude-opus-4 Apogee  
> 
> BTW, this tag seems removed by commit 1e035297ffda ("docs: remove 
> Assisted-by references")

As I was one of the first people to advocate for that tag, and I wasn't
invited to the Maintainers Summit to argue against the removal of that
tag, I will not remove any assisted by tags.

It may not be required anymore, but hell, I'll keep them for commits
I'm responsible for. I still find them useful.

-- Steve
