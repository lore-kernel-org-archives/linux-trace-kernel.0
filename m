Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1957196D98;
	Tue, 16 Jul 2024 09:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721123557; cv=none; b=n4RMNOqo5DUUbKk67hkZ5ZDy+D2Ugv24Sgr6vJKEQBpGAaYWpHZTL70HrEi0n4gfwwR0ACs3PFNcgaRZVCz9wVtwkiwNee0DPcW9fe32K8KnjGbEDbYEoDqSKvtAlQSeI0JCyeYCJWh+Gs9oJEeJV+QXE/3XoLHI/MrVcMV6u8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721123557; c=relaxed/simple;
	bh=IFxQxOBpCXNtHrOj1Qmg3nTitVZprBCWUOd6OttIEQo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=odp+OP+QiDw7c85qJIpMczd8sc8bqGgWIfpYPbwq0d9rjZtzBMqiwyxZ/Djzu4Vi0KhwlnwP+gz6HBoMBwl2pwvbaYUC1aI0WglltG2zYwtDh2uLalRaqfUDTAwJy6f0tPz7kcntQiHG7sOJnYsUc3sP3upkd5Qzjc1n5aGMsN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=jnGLM5wc; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="jnGLM5wc"
Received: from [192.168.1.103] (unknown [88.230.7.215])
	by mail.ispras.ru (Postfix) with ESMTPSA id 2213E40B1E60;
	Tue, 16 Jul 2024 09:45:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2213E40B1E60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1721123125;
	bh=8z0xCwX0Y91Gmm3XU03ogAxSGYi69FQUcjo49bLpk9Y=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
	b=jnGLM5wcrVimEfWk1y7vQDrDHW/xKUD3au2jCxLJR5vwJ/T5iCPSVtDwoBM+TdrrX
	 8jJ7bhxC6Rk1bSCcBlYhk2oGG1Wfnake8FULApF6Q/zQWFUwy+qDf+TcrrnZ7beoph
	 tCS2Q2I7VejnBK1Ge9mb8n0Ze9WY0OHRQsYopWAc=
Subject: Re: [lvc-project] [PATCH] tracing: remove unreachable trace_array_put
To: Nikita Kiryushin <kiryushin@ancud.ru>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: lvc-project@linuxtesting.org, linux-trace-kernel@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
References: <20240712201258.99070-1-kiryushin@ancud.ru>
 <20240712193306.3174c85e@gandalf.local.home>
 <98c01cc6-dcee-46d0-bdc8-0e35165ec68b@ancud.ru>
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Message-ID: <5ec2d185-0359-b0df-664a-d20722fe3666@ispras.ru>
Date: Tue, 16 Jul 2024 12:45:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <98c01cc6-dcee-46d0-bdc8-0e35165ec68b@ancud.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 15.07.2024 16:47, Nikita Kiryushin wrote:
> As nonseekable_open() documentation states:
> "The function is not supposed to ever fail, the only
> reason it returns an 'int' and not 'void' is so that it can be plugged
> directly into file_operations structure."
> 
> So it seems, that it will not fail anytime as it is not meant to?
> Otherwise,
> there will be a huge problem with leaks in many other parts of code, as
> there are plenty of places, where nonseekable_open() is not checked after
> resource allocations.

Yes, but there is another possible modification: replacement of call to
nonseekable_open() by a call to some other function that returns error.
Current code is already ready for such modification.

--
Alexey
