Received: from relay161.nicmail.ru (relay161.nicmail.ru [91.189.117.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FB04D8A3;
	Tue, 16 Jul 2024 19:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721157563; cv=none; b=e8/goiKjvGzwZKHPuwSvfkGuwgEB+mNAoJNQmMk2ydC309lHiV8Td4NAHxfoYgUkArW1qCnbIuCuRh2shF8dWxKLSA+jTpNlGV6qQqnnJEyq5HAP9E0wsE06WzZKgCVrszkTyMSaJfrTgNCbxP9jNxXreI6fCN3J8PjZXBsm/1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721157563; c=relaxed/simple;
	bh=uOqxIR/y+C6SavkwmV0PCCVGngtLdxFEej36RUzL8Mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HWGVAEN3i5FeulviBC9izG5cVVGhUhK1FJvdX8X5OXTnQItTQRcR1CD5PZGqn3OE4Nqfbp5dTyd8UChaKo3d3UXgrGArNNtS7LZsGV1Y916qM6LcUfSjTrDvMOCjFZ59V1C7LBcSB+u/sO+XquWmF5UtKYOIbRgGEBnkF5KGk/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.136.255] (port=4522 helo=[192.168.95.111])
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1sTnha-0003cf-5l;
	Tue, 16 Jul 2024 22:19:07 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
	by incarp1105.mail.hosting.nic.ru (Exim 5.55)
	with id 1sTnha-00AzYT-2J;
	Tue, 16 Jul 2024 22:19:06 +0300
Message-ID: <38513f97-d99a-4758-b84e-278e30f5565c@ancud.ru>
Date: Tue, 16 Jul 2024 22:19:05 +0300
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [lvc-project] [PATCH] tracing: remove unreachable trace_array_put
To: Alexey Khoroshilov <khoroshilov@ispras.ru>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: lvc-project@linuxtesting.org, linux-trace-kernel@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
References: <20240712201258.99070-1-kiryushin@ancud.ru>
 <20240712193306.3174c85e@gandalf.local.home>
 <98c01cc6-dcee-46d0-bdc8-0e35165ec68b@ancud.ru>
 <5ec2d185-0359-b0df-664a-d20722fe3666@ispras.ru>
Content-Language: en-US
From: Nikita Kiryushin <kiryushin@ancud.ru>
In-Reply-To: <5ec2d185-0359-b0df-664a-d20722fe3666@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MS-Exchange-Organization-SCL: -1


On 7/16/24 12:45, Alexey Khoroshilov wrote:
> Yes, but there is another possible modification: replacement of call to
> nonseekable_open() by a call to some other function that returns error.
> Current code is already ready for such modification.

The change of which function is called would change the behavior indeed, but,
TBH, I do not see it as a valid point: If we assume that nonseekable_open() changes to something else in the future, we may assume as well that some other call will be
added later with a risk of resource leaking. This is a thing, that whoever would do
such changes should be careful about.

For me, the code as it is now, is not uniform with the other places that use
nonseekable_open().
