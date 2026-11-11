Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379259;
	b=1eDYcp5k6+A73LNBSHRUI1OoSIdQj2A+YKe6zmD+Z/XigmqxKkDUlp4V/2G44TLm2+oR
	 PyiZC4BWPG5fJCBD2pLprRdyOSGSqbC4rl354DRWd26g4ukc6ZhZVdIbSmyw9IZ+lYd9I
	 LSd4jZxQL0wrchXZOMVnO+Ix8Qa42g5MECCH+qW0u99cciQO42phCTkcN7qKnXzqYiiyC
	 7Vgyvxkltv7LAAHw5ySZRAcTE9ImLByUSYUJYDujcJum4CH8n/U2o55Q5sfv++ZFV4iuE
	 Nq/CqTnxGRhphchgL9DbXEB3P/O5GRTL7/tfIqSyAT6SS2etHbfGxf9F00OmRYBMFYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379259;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=8bkDBSyUcvT2hacuHSOWV/Kpr2sMAXhIXLb1rh0obIg=;
	b=VhkzSa76heXRcqtmv3FEwyevk087B4QGAluR/nIZSCjOKkc668a0QlBR6QsAn2PxXZ5P
	 EzQeIFpRHD7VR+y4UHufobqV+sGrbxhj1eP4yPPoozi4TCxgm8fEU9yWg0j202iBneRNR
	 8ftLqwiKQ8D2EU8d6Yn6h4UnVJs6KIsClY0Yb8TzR8slK4pKT7osB3aGCtPwlntTNqmox
	 a3mPVxIj+UgAqr/NO/aM/R1LykpM6ETx5yR7pOYKXY6aufolsc1jeVufmkz+kB2X0c/di
	 D/V6LgJWUulA80c5e4ZX57U6ya6bdE199abzChEIUHAJc0FcWn/+AkbIC+ctO120pDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=yhUsaWwf;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB858606A31C;
	Wed, 11 Nov 2026 06:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB858606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=yhUsaWwf
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 1C8511A0228;
	Wed, 11 Nov 2026 06:40:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 7A97C20027;
	Wed, 11 Nov 2026 06:40:52 +0000 (UTC)
Date: Wed, 11 Nov 2026 01:40:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: n3rd <18670333770@163.com>
Cc: "linux-trace-kernel@vger.kernel.org"
 <linux-trace-kernel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "security@kernel.org"
 <security@kernel.org>
Subject: Re: [SECURITY] tracing: splice(2) trace_pipe peek outside the
 access lock
Message-ID: <20261111014046.07a658bd@fedora>
In-Reply-To: <6bc59ae6.bbe98.1a1c54ca872.Coremail.18670333770@163.com>
References: <6bc59ae6.bbe98.1a1c54ca872.Coremail.18670333770@163.com>
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
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 7A97C20027
X-Stat-Signature: k5rzm1jao8iocr9aw1btkche3cmuspxz
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18feHyx77vQXCWFfcQ+TamY8B9+BuW9zq0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=8bkDBSyUcvT2hacuHSOWV/Kpr2sMAXhIXLb1rh0obIg=; b=yhUsaWwfMDL3LiiJLDCkGgV0Ob+8yqFMfVafdb95zWomeGEWz+OodxBU/svY0tFT22rfzSnUgA7qRXmqVeQnYGfIM7hT/yVyV03r9e3l7eil/BUogrJvsKYQAL+vxWetZkXSzyJgv6v2WSQGb6m2n5gb2YFYNoQM7jOLhSC9tRw=
X-HE-Tag: 1794379252-706247
X-HE-Meta: U2FsdGVkX18BK7tC25J3516d7ovVixR1TnBRGjakuPM3yRbjAQungXSdAgydFjEkQDY8HKqCpL2+YS1I9V+60R4msApA04VWD/kriZDRL6eACWD4dVEznrEV9cHNliRqpsm/1NhLGbk91TAU69l1oVzN0hby7F7YE7KWP4PH69LpuuPX40dbe2wy/K2Dg6GYtNrPxx0E9odO54X45oFZwH9lISh761TtafsNMzyJnj3yIdznk/r5383WZaBBTgdd4jehSjufYiPTFCV2+4vKUB6zUwIo4OTrJi9CoZWlT06WsFRKR5JGRM+evri0JXzIp5MxbaWVkaHcZy3OVNKc+QrEdOqHG71Q

On Tue, 10 Nov 2026 19:51:37 +0800 (GMT+08:00)
n3rd <18670333770@163.com> wrote:

> 4. Conditions
> Requires local root to write

Here you state that it requires local root to exploit.

> /sys/kernel/tracing/buffer_subbuf_size_kb and trace_marker and to
> read trace_pipe, tracefs mounted, and at least two CPUs so that the
> order change and the splice reader really run concurrently. The order
> change is what frees the page; a splice(2) reader without concurrent
> order changes does not trigger it. CONFIG_TRACING=y is required for
> the tracefs files and CONFIG_KASAN=y makes the read visible as a
> KASAN report; without KASAN the read is silent. Tested on x86_64
> only, with QEMU TCG and two vCPUs.
> 


> 
> 6. Suggested fix
> Move the trace_find_next_entry_inc() call in
> tracing_splice_read_pipe() below trace_event_read_lock() and
> trace_access_lock(), matching tracing_read_pipe(), so that the peek
> is covered by the same RING_BUFFER_ALL_CPUS access lock that
> serializes ring_buffer_subbuf_order_set(). Alternatively copy the
> event out while the reader lock is held, the way rb_iter_head_event()
> does. No upstream patch exists as of v7.3-rc7.

Feel free to send a patch.

> 
> 
> 7. Mitigation
> Restrict write access to tracefs to trusted processes and avoid
> changing buffer_subbuf_size_kb while trace_pipe is being read with
> splice(2). This reduces exposure but does not fix the root cause.

Now you state the mitigation in to only allow access to tracefs to
trusted processes, which as you stated above, is the default.

This is *not* a security bug. Please continue this conversation in the
linux-trace-kernel. mailing list.

Thanks,

-- Steve
