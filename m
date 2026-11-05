Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893254;
	b=3B841r39ANE/4+RFU8c/jL1CpdK8vVsD/eQLfw12uc4b0Nwgrhz38hkcwBFVBiikrLf8
	 jfxaA9++MPsh2hqD8tc1+JtecoHSMRU0mGJdLdd9Xd0dICYIG13n6F/9oQmjttn45Pw2J
	 9voAx+PTeKfCSgvc2gj7rPUMAy/nYauHuMcU5Cgf0pIuSbMYvJnlkva0+O1PTMnheFK0Q
	 Q9JpFNN1AszYH8mASJyVXgsDA57cIX6tul21evB9TbyDbCbjn0evmebJreKBXoV+ax6XX
	 Fs50xeFTrrZxKEPbgPFtUBEPy9rN/wSvXxeCsjojeS4lKbE10vNncABAKykVC8cu0uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893254;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3+uo2F8pDT6IdqiaH3j+lNHfZiM0C5S6SnC/vbxl6tk=;
	b=Scz0J3REiqLlK9UKZxIM0NO2VG7U2cKE0v59F5tYSU5Q9KSN4ZorA/twLflegulxFFDR
	 tZBqcZpFLL4Nb2vgB1tWVArwMMoZzGmHsL/ThVTielXVTRDmffiUSW03lz4em5Y2gt8EM
	 jwdvd/gHf030y3N+6Td7+j1soVQOVk1jmROJtBe9zrz1lat6UW2UZTlJT9XfqpK35bEKA
	 ZNRfxhjc9S1HMsMA6fitWv6+JR9PdtkLiln9SiQ3BN50lhAOW9glKAGEygmSXd2IBq07v
	 lrdbyJMONNBWaTnSS9TF7+SYlSNwdBNhzQwb7lR6jMsGvqkm3TWhqcXAZlqJRQGIFtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=celyHGLK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADAF606A332;
	Thu,  5 Nov 2026 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=celyHGLK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FE71F000C1;
	Thu,  5 Nov 2026 15:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793893253;
	bh=3+uo2F8pDT6IdqiaH3j+lNHfZiM0C5S6SnC/vbxl6tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=celyHGLK/YSkCiqL/+CkEnW2Jp2jCwkX7XsxkmZYKiCh/5z+cUcjwKAfyXCGrz/Tj
	 Fxx/2FpzD/+bX5jXM2lIwp8d/cLE2/KAlRi+HYu9zeXcajaOyeOrNZ3/tLiU77hbV7
	 Yw5ztAK2o42iEKD4v6N05+sZatBho+yo/c5V/cr1fwu4XQEdOJW/QqD1m+DcGDwhT1
	 8snnORjCfQMonn8OmDEbp3qAreUyfGZrGYvicWYGmgNa3eLQfHvsEF1DfMPAqJpDB+
	 dDqKYfL/q8agsbpb9z5l3YnBoL5S20c3KIxyN/NMDf9e8dkLuvwSEGpR/3wLNOWHdx
	 pKRYnl+WXTnUQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>, Jonathan Corbet <corbet@lwn.net>, Naveen N Rao <naveen@kernel.org>, "David S . Miller" <davem@davemloft.net>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/3] probes: Use trace_printk() in probe handlers
Date: Fri, 06 Nov 2026 00:40:48 +0900
Message-ID: <undine-1793893248697209795-61fbe8831bcbcfc6@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261103090901.0b5957e9@gandalf.local.home>
References: <179360345418.115681.193455787480210412.stgit@devnote2> <20261102123408.0fb950bf@gandalf.local.home> <871p9251ve.fsf@jogness.linutronix.de> <undine-1793671566795563056-fb7169cffcc7ac3c@undined.local> <aunBcxXXNhXDd-U5@pathway.suse.cz> <20261103090901.0b5957e9@gandalf.local.home>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Tue, 3 Nov 2026 09:09:01 -0500, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 3 Nov 2026 12:11:47 +0100
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > I believe that trace_printk() has a similar problem. You could
> > not use it inside the code used by trace_printk() because
> > it might cause an unbound recursion.
> 
> That is slightly incorrect. I use trace_printk() to debug tracing! ;-)
> 
> Well, adding trace_printk() to the trace_printk() function itself will have
> issues, but the ring buffer logic allows trace_printk() to be injected into
> it. The ring buffer has recursion protection, so adding trace_printk() into
> the ftrace ring buffer will print the trace_printk(). You may need to add a
> way to not do the trace_printk() again, otherwise you may get multiple
> prints until the nested limit is reached.
> 
> But I just wanted to point out that I do use trace_printk() to debug the
> ring buffer even though trace_printk itself uses the ring buffer too.

Yes, so for short term solution to fix the problem, I would like to use
trace_printk() until we ensure to check the printk is safe. After removing
legacy console driver (or introducing a Kconfig to ensure no legacy driver)
I will revisit this.

Thank you,

> 
> -- Steve
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
