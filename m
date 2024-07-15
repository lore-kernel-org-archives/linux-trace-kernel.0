Received: from relay161.nicmail.ru (relay161.nicmail.ru [91.189.117.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4771836D4;
	Mon, 15 Jul 2024 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721051274; cv=none; b=jrHiFA13jGADpyL8caV9lN1UE7/9LNYss1csPhDOoJrOeJ3ERh3dml9v6fIn6fxgNQfP4nGP4tnmAA6hfxjE3EBsbRKRpwXzAfeyWsdF1GRhCg9hRfMiTRkAeD6F/4fAzOolCA+QRyoOJtv5UYQl8jyo937oBzZmiymMDDyPQ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721051274; c=relaxed/simple;
	bh=+NsQiMYq9GRvA+On801DWzAYhvm1mpdnwfnWkou0+qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kQwoDSpYV/Hns7p41zRO0pMlRzLS80Oz6EGtQTXMQ1kzmq8vkJmJlCauwikFnBH/6hILxb2asdJ7/NArLg05FB5ztnmmglU1T18wV4AY2FrzWotmeTAlCo6JFJYMW1iy+ofyJGlrpZE1qOFCBjQI0OPm2gGSaW9hElwwzcTucHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.138.152] (port=27728 helo=[192.168.95.111])
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1sTM3G-00050O-6D;
	Mon, 15 Jul 2024 16:47:39 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
	by incarp1104.mail.hosting.nic.ru (Exim 5.55)
	with id 1sTM3G-008vcH-2j;
	Mon, 15 Jul 2024 16:47:38 +0300
Message-ID: <98c01cc6-dcee-46d0-bdc8-0e35165ec68b@ancud.ru>
Date: Mon, 15 Jul 2024 16:47:36 +0300
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: remove unreachable trace_array_put
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240712201258.99070-1-kiryushin@ancud.ru>
 <20240712193306.3174c85e@gandalf.local.home>
Content-Language: en-US
From: Nikita Kiryushin <kiryushin@ancud.ru>
In-Reply-To: <20240712193306.3174c85e@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MS-Exchange-Organization-SCL: -1

As nonseekable_open() documentation states:
"The function is not supposed to ever fail, the only
reason it returns an 'int' and not 'void' is so that it can be plugged
directly into file_operations structure."

So it seems, that it will not fail anytime as it is not meant to? Otherwise,
there will be a huge problem with leaks in many other parts of code, as
there are plenty of places, where nonseekable_open() is not checked after
resource allocations.

On 7/13/24 02:33, Steven Rostedt wrote:
> Then why does it return a value?
>
> If someday it can return a failure, this would then cause a leak. It
> doesn't hurt to leave it in.
>
> So NACK.
>
> -- Steve
>

