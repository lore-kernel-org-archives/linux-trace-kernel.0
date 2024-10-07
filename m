Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62B512B143;
	Mon,  7 Oct 2024 17:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728322635; cv=none; b=CgRvUgfmd/r7Ueibn8uW3otjaDQcaq0zdzyBPvxaGNQhpdk4QtJKXGMp7uysczwNrjCFLjskpkDONkQux6d1JoH8zggQzlMt+1/xs10cBmqzTgVTr0quVBUdIsKdsVuClleJEF1h9QpmzP8GUwGfGEQZVuV49JiGBuwm8i0zrn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728322635; c=relaxed/simple;
	bh=YheZd7fy6jZTQiPtRwC1f4eQ8RVm3fkTXSUISddTATY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ra+2MPkHMjCDIMed8Xa58izE3HAFcBeO1TtjlKvlhnDFVmRH98toeqMwSPD8XYA0LzvKNOSH4EWBvx/d8sytMi9/Rlyf9O4AUV5zmOMZqNTp8124x6WvCSidpX521JHJnEkjmJxKN5/esfOp1DhfzAm8M+8L0O/bzvUCrGp+NCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Q8Z0ILsk; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Q8Z0ILsk"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 12BBE42B38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1728322633; bh=BYLYVaJHMzRDGD0vXc6iVzKBoQNDBzqFCgfZFi6GVF8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Q8Z0ILskDT2g1j+Z2EaZVPhCJPPA3Q47y0YdwhHzd+ztRT08qmy2DlQfAwaJaek6h
	 dVJCeGA+Zx/ZtIjjHGFUKK4wHv18iPcxeaOdA6Q1+7rmMgvQiC/GPA0hvGw2UB6ISw
	 fqpSsF76qX80ko6RQbrYKXW9zh9CBfZDoh2+Z+xsM5MM270o+b6YhYuphxSxi0/TXm
	 MRXJXehl66jHSlZNG86W9loG+uLZcNJFjxy/sl7nPDT3HMsI2m5lijWaoY2mRLx4YZ
	 b6ukwNd7PC9H18JZ4xGLggocO37ApQ31fChdJvOIHamjhkcno5Xbh+KadHXJ0jtcrW
	 xhawCiNKAwonQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 12BBE42B38;
	Mon,  7 Oct 2024 17:37:13 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mike Rapoport <mike.rapoport@gmail.com>,
 Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ardb@kernel.org>, Hans
 de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] Documentation/tracing: Mention that
 RESET_ATTACK_MITIGATION can clear memory
In-Reply-To: <20241007130858.7e25daeb@gandalf.local.home>
References: <20241001095734.11a67b4b@gandalf.local.home>
 <20241004193800.2ffd0d36@gandalf.local.home>
 <87v7y3kflt.fsf@trenco.lwn.net>
 <20241007130858.7e25daeb@gandalf.local.home>
Date: Mon, 07 Oct 2024 11:37:12 -0600
Message-ID: <878quzizlj.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Steven Rostedt <rostedt@goodmis.org> writes:

> On Mon, 07 Oct 2024 11:06:06 -0600
> Jonathan Corbet <corbet@lwn.net> wrote:
>
>> Steven Rostedt <rostedt@goodmis.org> writes:
>> 
>> > Jon,
>> >
>> > This version should be good to go.  
>> 
>> Applied, thanks.
>
> And I now see I sent an older version that had a typo in it :-p
>
>
> +			Note, saving the trace buffer across reboots does require that the system
> +			is set up to not wipe memory. For instance, CONFIG_RESET_ATTACK_MITIGATION
> +			can force a memory reset on boot which will clear any trace that was stored.
> +			This is just one of many ways that can clear memory. Make sure you system
>
> 										       your system
>
> +			keeps the content of memory across reboots before relying on this option.
> +
>
> I can send a v3.

*Grumble... :)

I haven't pushed out my tree yet, so I can replace the other one.

jon
