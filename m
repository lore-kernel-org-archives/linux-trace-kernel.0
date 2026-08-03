Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C713C1F
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Aug 2026 01:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785720776; cv=none; b=RDaPHWG2WdABo1qjr5/6Q1nfD8/t1H+Q2luTbPt2oCCWBrF1wObG7Ou+y59ptoBUtVf4XMHeFwFgOw6g4HccfBYKj9g+TrzkeK6f7wcOjKMtzkm/hBd1+jY5nv2ufKzm3PdBcpA9h1Y0Dvnm+gzYJr63uVeJqAVCegnCHF63qyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785720776; c=relaxed/simple;
	bh=eXdt19e39fiMwn5NKy7KsU7UGHm0eJ/4kWdcSksrltQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W84cUHZhiQOqcJVbaOniSc3cSkdmaeuWFlr4B1HT4XrekdFh9+LgLGnDIPd5XoNWIAelHoW4zm1px4MHpenj/urnQ6RWoK/drCIvaYOhv8QGo3jC/dTK363cXnZ7531ViD6vwZ4eQJj+Yr9EMR77DxJilRbSzRsQQwyuZXvDLxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PdBfkCdX; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PdBfkCdX"
Message-ID: <6af761df-9abc-4854-971d-ca6e4ed7a2b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785720762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ly5FuncggLhXbMUbhUGfi8iZRSSYI9Jm5KjBg8D2bi0=;
	b=PdBfkCdXX4c2Ob0V4n7XAwF5okf8087+nlLd/Z6DdOK5NsvxNWr43oDh7owS/wZKYuyKQK
	Zgx0dMHJI3r6YiGIlTiiTwJXPdVfTRaQOGI7BPULl2H3nF8TvPxrk/zUFhu9Yww40URGyk
	TsYvYHhQJEziQ9EZY2h2dDaN3Ui15Jw=
Date: Mon, 3 Aug 2026 09:32:14 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] arm64: ftrace: enable single ftrace_ops for direct
 calls
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260727142844.21212-1-leon.hwang@linux.dev>
 <20260727142844.21212-2-leon.hwang@linux.dev> <amnqXeC6D4mjcAe_@krava>
 <d745ca80-6516-4c61-8107-88c6a2d9cea4@linux.dev> <amsuU7eXuoziObdh@krava>
 <3f8e64b4-e60a-4eba-afb6-5af668ac1f85@linux.dev> <am-sK_buCVI3khJv@krava>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <am-sK_buCVI3khJv@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/8/26 04:44, Jiri Olsa wrote:
> On Fri, Jul 31, 2026 at 10:30:37AM +0800, Leon Hwang wrote:
>> On 30/7/26 18:58, Jiri Olsa wrote:

[...]

>>
>> Right.
>>
>> Pls see the sibling thread with Ihor. With in-range BPF trampoline
>> allocation, the slow-path regression should mostly disappear.
>>
>> Let's continue the discussion in that thread.
> 
> please paste the link/subject for that thread
> 

The link is
https://lore.kernel.org/all/77edc25d-a521-4f65-84ed-dbb016593902@linux.dev/.

Thanks,
Leon

