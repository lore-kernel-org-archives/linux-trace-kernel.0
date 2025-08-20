Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D203131B12D;
	Wed, 20 Aug 2025 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755695795; cv=none; b=KiTTVIPMvVqfpmwhVX8jOrkJP0Wq0IsyyXgFMcYXnFA6VjdwmTjbNinhWZ7CTye3IzbEq/Nciam+cOiT93TZNbl1UI1zORXa5d1mzd/pcp5zDr2WVt1XU4tJ3EFwg02OKGwGflqNkFr9AM5/f9ypBCZ+AZSwiDjtecHZsp0+q2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755695795; c=relaxed/simple;
	bh=H5D1rOxmchWqymov15BmFrsjqnt9z8B3XgXN6wOCWQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVr8PolCH43oH5z4stno5ez+Pq/p9oAIDgata7M6ph5wZp6f2kKd1VTmU7KYTZMwoReJzj61eVF2MkPXKVAwEgQMX7KHq/AYWQI+oTlfNonXQkW63sPxe9YFXwMeHnIyoNTbLsQrila1AHbTLIZOo5B/ZJyfF77wmMF3IUASpGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 02B84117DC5;
	Wed, 20 Aug 2025 13:16:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 2F6292002D;
	Wed, 20 Aug 2025 13:16:25 +0000 (UTC)
Date: Wed, 20 Aug 2025 09:16:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 2/2] ftrace: Fix potential use-after-free for
 set_ftrace_{notrace,filter} files
Message-ID: <20250820091626.6c60f9cd@gandalf.local.home>
In-Reply-To: <354f6b41-83d1-4496-aec8-764c205990e1@huaweicloud.com>
References: <20250813023044.2121943-1-wutengda@huaweicloud.com>
	<20250813023044.2121943-3-wutengda@huaweicloud.com>
	<20250819210538.29ae29cb@gandalf.local.home>
	<354f6b41-83d1-4496-aec8-764c205990e1@huaweicloud.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: cn9mxagn75siag7mbhmotjjdbq4nmymu
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 2F6292002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Qc0WNTcVOiFeULQQgPOWa8heXJAeXQXM=
X-HE-Tag: 1755695785-615699
X-HE-Meta: U2FsdGVkX19DthW2DY4viAo1etjl5WWt8RrM8iMpq5t4gR0jzY4Q9cM8TOSG4F4E2fUaXNyWKAu1pMp2a+N/Zb0rHAZSi8DXzEyzEBPm6CqZ/sCIPEX7pbFNI7JfMVd+ucKwzJTzpfu1FUUr1v7gPdZdPQDGxvKJVbN26VjKK2vi29YMlGgzvHoXrNx4f4vK/PFSU2yKVLKHc6xYyJbB6x+opghaR//vZNSn/wQJBFhxMXUO/7Xf5udQ+Eo81mFtqsFrfd/VN5EMw5+Z/aMhfQwHG0uOpTiPGdiSpIG9/MsXOSZoBSrggKb6csJWQc7QUUfhZlzHvw0vrsxZghazSLQiY9s04O2CdGSTrbzo6RHqbrtIQ/N3kQ==

On Wed, 20 Aug 2025 16:34:46 +0800
Tengda Wu <wutengda@huaweicloud.com> wrote:

> Agreed. That is a much cleaner solution. I just tested this code and it
> worked perfectly. Looking forward to getting it into the mainline soon.

Thanks, I'll also add a Tested-by tag for you too then.

-- Steve
