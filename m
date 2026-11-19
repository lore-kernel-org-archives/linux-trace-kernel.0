Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795111116;
	b=XGa/K40O8ICoK8LKPuUH2s7qLlE1Un6iuK+S1Zk5nWqb8ElKmM7q18RGkrvaISa0C41h
	 r/09ttezYwF0IACBN20PttH8WDII2KzR6N1vvcRfExeaBcBInVPU/4QDuAZxwSH9fFomn
	 DQFTiQpcgI90Zt7XRfUx8PqDeBcJ+voTNuLmP9d2tqDVh2BO/iWxyQA6vbQZ0tr3RS1JQ
	 J+77+eOsEI28LjdH0d7Zb5aAUW5UrNlAToOr5wwp8Id7FGaiW0UNk+EoxRmg3GNSzjJe7
	 7QinycyaTBLrvmYRkIFH3wTzsrK9C0kVgzfU+xZ1wXrUA5IC2lb4RQr9vuVZE4IGPuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795111116;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=s+CfB87n25FOGNdSFLU2P2/91k3UHBcRnw5W8efawEQ=;
	b=uShJ9arlbZGo8iwlnxqWo1Kho+4W7EOf1GbmtLY+wvNbJAaz9r1Nn/gMSqshvJEKS6+m
	 VOaJzwdVojErXKNTDxDsGVXGuJWr8G0UXSHiRKoqQIdPTxQzK65m/2Ry/rs01XwAbhzkv
	 aMBsMKGqn/gvwU3QHrtyMfbfQf22t5p1fn1p7Rr+9nOw1KutwdzBNdWsewDAX3N3nxGhV
	 5FUgAdD7SuTT1cSDpHiYUoHHlhvzV01mEN57zExK2+2uF4tAu5GLJy8ATQv8LFeXFebm+
	 +vHjMmTKNaln+N4GE6orZvHhABk64suZ+Y/QL8QAQjAe1hr1tYAzNFZYn4S81W05a8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=gaQbwAiE;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D1960A6F7F;
	Thu, 19 Nov 2026 17:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32D1960A6F7F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=gaQbwAiE
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 81C681A0B15;
	Thu, 19 Nov 2026 17:58:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id B2D4320015;
	Thu, 19 Nov 2026 17:58:32 +0000 (UTC)
Date: Thu, 19 Nov 2026 12:58:31 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yifan Feng <evanfengff@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ftrace: Reject "!!" in front of a set_ftrace_filter
 command
Message-ID: <20261119125831.54ff59bf@gandalf.local.home>
In-Reply-To: <20261119030900.37343-1-evanfengff@gmail.com>
References: <20261119030900.37343-1-evanfengff@gmail.com>
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
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: B2D4320015
X-Stat-Signature: nwgkfdkxbewemu4wwf9xxwq9t7dgdj7n
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/o63hOv9m6bPEpnBNgW61+7ZWVd0QF8Mw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=s+CfB87n25FOGNdSFLU2P2/91k3UHBcRnw5W8efawEQ=; b=gaQbwAiE+uNbAp+nIFpDEg9RC7jecupXFNunMJus0I2Jy6uJsvfRpeM6ogGlYjD2SRQwvLOCj8RLI/mZ7kSjJwyw+08NQ6ms5wTYxelUVohc2xkWWUTaRbI/Ec4n3RkhhThiNazCD/dn34nKq8I3Xyfvt2JeUn81sCAKNaF1mrA=
X-HE-Tag: 1795111112-237387
X-HE-Meta: U2FsdGVkX1/YnVUEnVkhB6ZVUoi0I+IKr0QMvqt4OZAw51hgWztJr9cOSWudKlv9vI0pBIbsgQL1EBs5FdiqLdJF78Dds3YAtsVMJIqnj0RaEKuLojH0V5b3hpzHbewMiSIN2D/eqrYUm5DW0YOIhNd7urJoW1F2kIVQgHsSOu/O0vcNP6LdOXtALkQO7wq90tZNO3VVnkOlws4tQ34B8l4VHww7LARTxxBM3XzkoykSSMF8LQxO9rzSjKcnyvtMHivpvacj6szK8LGcLbMmk+P/in1VvLKcsumdX84pEeK3uZDIp2aTterNCafyTDBtCLjUsbWdEdJMBTVyt/82V1zDYgNFkDRe

On Wed, 18 Nov 2026 19:09:00 -0800
Yifan Feng <evanfengff@gmail.com> wrote:

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index c7d74b33d36d..44a861f021be 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5846,6 +5846,9 @@ static int ftrace_process_regex(struct ftrace_iterator *iter,
>  
>  	/* command found */
>  

A comment is needed here. Something like:

	/*
	 * A double "!!" confuses the parser. This isn't a boolean operation,
	 * simply reject it.
	 */

> +	if (func[0] == '!' && func[1] == '!')
> +		return -EINVAL;
> +
>  	command = strsep(&next, ":");
>  
>  	guard(mutex)(&ftrace_cmd_mutex);

-- Steve
