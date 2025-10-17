Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066292F8BD2;
	Fri, 17 Oct 2025 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760728300; cv=none; b=De8k79Ykf5vHohb5NC4iCBSZXkKOmFt0y5aPGfqOLxJDYBZreS20YfvHIMGHbZoL3mUR3BLJmoZp9uJ9LlDgUKyO850U3Vl+fkkhuEGQW8ObYV1SMV5xdHDSEXJtZnocDIQ5SiFSf77FjAhgZCJz6306JgjAXaePUyqgSZHE0Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760728300; c=relaxed/simple;
	bh=Q3Dg2YDddj4VM8KiH9Pw8uzY6HEr9fagLsepUPEdTMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q121Di2igPTHkRrp1vFMcuMHe7EOjN2jOY8q8go/kRUIU5NgRkQ+07Z2/XNuqP5PSQ+Ta5nt018czkLpkJ8yfZUaXwbRfK3bXRFqShkRDwMZXMJfNeg3y3Lk82tTFwrGswP8bowUcDDHN+VRIFBeZfeX8knbAgwdP7wVPBhmpqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cpGerADl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cpGerADl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ENgkLOYG1taSkZ31svUjLwfnRQ8pfwpjuLiuweEunmc=; b=cpGerADlWnxEilBNV3GDwu41rK
	T0zcipAyINWFC8E/DkA05BrVBLB1IEIMijFlyWPwgfSIBjBuR4gw7McZ47DOPPFAu9Z5hOk3+eb0J
	IM+L66NqGwLKJKiqQcNdw78UoNlNSPlp0NNhdpOiKd70gdKvypDa9KE9DxY+DQD9D2QRziTznGplT
	Z02ftpU1v0wk1ympUS6YmvtkAA10IRHv4Htmt2fxCiTyKmDOsOx8ZunwqwBGsgXHGxlWi5n2fwUE3
	fVSbNkf+WL54fwoVUFXbVAigHYw+QH/JbncN5bpPaGUEowh7zrB5P3doul1rtfCdCn4q6VSA+0EZJ
	XSeSHcVA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9prT-00000008p3u-1Wvh;
	Fri, 17 Oct 2025 19:11:35 +0000
Message-ID: <73c2ab88-37a3-4e88-bfc7-b2c6b4cfe34f@infradead.org>
Date: Fri, 17 Oct 2025 12:11:34 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ring-buffer: fix kernel-doc format to avoid a warning
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <laijs@cn.fujitsu.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org
References: <20251017070753.1638717-1-rdunlap@infradead.org>
 <20251017050804.48439442@batman.local.home>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251017050804.48439442@batman.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/17/25 2:08 AM, Steven Rostedt wrote:
> On Fri, 17 Oct 2025 00:07:53 -0700
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> Format the kernel-doc for RINGBUF_TYPE_DATA_TYPE_LEN_MAX correctly
>> to prevent a kernel-doc warning:
>>
>> Warning: include/linux/ring_buffer.h:61 Enum value
>>  'RINGBUF_TYPE_DATA_TYPE_LEN_MAX' not described in enum 'ring_buffer_type'
> 
> Then this needs to be updated differently, because that "<=" is stating
> what happens when the value is <= RINGBUF_TYPE_DATA_TYPE_LEN_MAX.
> 
> It wasn't random characters.
> 
> Basically, the enum describes the event type.
> 
> enum ring_buffer_type {
>         RINGBUF_TYPE_DATA_TYPE_LEN_MAX = 28,
>         RINGBUF_TYPE_PADDING,
>         RINGBUF_TYPE_TIME_EXTEND,
>         RINGBUF_TYPE_TIME_STAMP,
> };
> 
> When the type is > 28 it is either a padding, time-extend or
> time-stamp. But if it is less than or equal to
> RINGBUF_TYPE_DATA_TYPE_LEN_MAX then it is the length of a data event.
> 
> Perhaps we should have it be:
> 
>  * 0:
>  *                              Data record
>  *                                array[0] holds the actual length
>  *                                array[1..(length+3)/4] holds data
>  *                                size = 4 + length (bytes)
>  *
>  * 1 - @RINGBUF_TYPE_DATA_TYPE_LEN_MAX:
>  *                              Data record
>  *                                length = type_len << 2
>  *                                array[0..(length+3)/4-1] holds data
>  *                                size = 4 + length (bytes)
> 
>   ?
> 
> This data is more important that making kerneldoc work.

For sure it is. Thanks for the explanation.
I'll see if I can come up with an alternative - or not.

> 
> 
>>
>> Fixes: 334d4169a659 ("ring_buffer: compressed event header")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
>> Cc: Lai Jiangshan <laijs@cn.fujitsu.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: linux-trace-kernel@vger.kernel.org
>> ---
>>  include/linux/ring_buffer.h |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- linux-next-20251016.orig/include/linux/ring_buffer.h
>> +++ linux-next-20251016/include/linux/ring_buffer.h
>> @@ -43,7 +43,7 @@ struct ring_buffer_event {
>>   *				 array[0] = top (28 .. 59) bits
>>   *				 size = 8 bytes
>>   *
>> - * <= @RINGBUF_TYPE_DATA_TYPE_LEN_MAX:
>> + * @RINGBUF_TYPE_DATA_TYPE_LEN_MAX:
>>   *				Data record
>>   *				 If type_len is zero:
>>   *				  array[0] holds the actual length
> 

-- 
~Randy

