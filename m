Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A401DC06F;
	Mon,  7 Oct 2024 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320770; cv=none; b=MyPRmOqjO0P6ukFfbRmMRh5Ou9JXfQpOk6xLC2Ld6825/P5F2+Y2wNHZcBvms88oTMoKOsWXKqFAxXZzSh7de/KvvRMhguEZukLE60+GOiyH6Q14rlCKVsoLngvxjvrKRVbkR/ApYqkU2OXx8lqG72BIAYuDbAOtDak23rgnwUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320770; c=relaxed/simple;
	bh=YJ+E7Zb4V9tc02SJI+I10aIxb82uM2wZAExnY6iUX64=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JAV/Atp84Yp/lLH/u8q7N4b9d+Yr4IymE2ws3ytBEbNIR/FKD2TnZdY75ulU5epvM8BvSlLczFjsOLf19NF6wkKZKb901/6mi+njLwl6nWHqdN3ipqCRWUAgBwiyteW6Rup0499hAImht77gOnTd8WuWh3TuUiJNWjCFq9xvc1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=GbNY8Cmn; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="GbNY8Cmn"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9F9FA42C0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1728320767; bh=YJ+E7Zb4V9tc02SJI+I10aIxb82uM2wZAExnY6iUX64=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GbNY8Cmn0KZPs/Fx1qfx/fa1rbSPQtvBSiwGGYf6UbCYBINWtZsl8BZXdsLvecYGG
	 HdG9x2+id7yudTFHeUvMQA3nw0n+lpQkVJagBQjEW9pFIBfltBdX4W5HtgaKxwXTnZ
	 EbFtwEvnc5VJlxyeO0xFpFu1r6zrdf5I0vsWN6sZY64g+u4+2bif3qYrhjxWVVWwBo
	 /wFL7k8A9po9tu1uO1yQAUqyovOoa+FZtXM86yp200pWGGC7oNaYEWhoqtTEvHFwRs
	 6TPhyY/ksws/6tZWdCs8ki+xPuSWy+adB/fWJ+9KqG1aqrF5oMf3SYjbAm5ryc0vMw
	 Ibbxex2JZvwLg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9F9FA42C0D;
	Mon,  7 Oct 2024 17:06:07 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mike Rapoport <mike.rapoport@gmail.com>,
 Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ardb@kernel.org>, Hans
 de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] Documentation/tracing: Mention that
 RESET_ATTACK_MITIGATION can clear memory
In-Reply-To: <20241004193800.2ffd0d36@gandalf.local.home>
References: <20241001095734.11a67b4b@gandalf.local.home>
 <20241004193800.2ffd0d36@gandalf.local.home>
Date: Mon, 07 Oct 2024 11:06:06 -0600
Message-ID: <87v7y3kflt.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Steven Rostedt <rostedt@goodmis.org> writes:

> Jon,
>
> This version should be good to go.

Applied, thanks.

jon
