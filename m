Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF978218827;
	Mon, 20 Oct 2025 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760986870; cv=none; b=Y9w2+67D5V50wJzrwATv3zVuvdRRgMxFOIWShqlOLMJzw+AiYxnKiJvzDJ/iMuSRMAHGSba7hONbmDDK6bnIZGIXw6DPFSLwbkGd9j8UlxAai63yJwcJ9EWqfZJzQ9I9ZBszPzvWXGaXC9Todl2sYK4Hepbsc3Hy5RW5v9hy+4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760986870; c=relaxed/simple;
	bh=gAXla/m4eXeEBqFU21t865dnowv54sn9SH5X0IqQ/zU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qNVgXL5diZKVVQx8zRt/q+I28RqizT5FU4kpW80vmk+2p7+7MehOSYFLHVg8skkckcnaJE2aXo+vzWXsNn5/a0YrKjPB5eifeRCBz56ukopYpGyrQr2nhLUQ8CJpMyWGPRW1Xk9BcY3MgHPxIrIPvmrvgO/qub52YhLm80IT/Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JEiuM7uM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JEiuM7uM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=zafnlX6TNyUlNl32UJtICMfxmtfFofA1UryFBxmHom4=; b=JEiuM7uMHkAZQC1CbSuwwRR/jl
	1MfOQ0ljk5RbuGl0M9eOadY+jetNbT9l0TuE81uPkZlMy4LCVNIzXd9woMBdSM1XwXsSPE3ncvDwA
	FdudihaGJ42MbrGqbgS54Ak4i6QDwZbIe+9yQm8a6xMr6Tc/RuV3GF52iJQ2hpKMeIle2DsWfgqtU
	VVMv86BxV+J902BRQiggA+4CPvlRcGGwQSPUnqiusBViTx86GB9D5VxlHRsBTevOpYtEy0GTWIZ9E
	KsggCPLJpW2xqxvX1t9tRF6omMXzOO3rrGd8en515l0EpBIK9rVb7/45sHSrXrcL7Pt7/FWYQrm6n
	8hqIQ1qA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAv7v-0000000Ehec-3oYA;
	Mon, 20 Oct 2025 19:01:04 +0000
Message-ID: <d7576aee-7d2d-4703-952d-f0924bfc49c5@infradead.org>
Date: Mon, 20 Oct 2025 12:01:02 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ring-buffer: fix kernel-doc format to avoid a warning
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <laijs@cn.fujitsu.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org
References: <20251020010037.2681824-1-rdunlap@infradead.org>
 <20251020143332.732ae92d@gandalf.local.home>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251020143332.732ae92d@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/20/25 11:33 AM, Steven Rostedt wrote:
> On Sun, 19 Oct 2025 18:00:37 -0700
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> Format the kernel-doc for RINGBUF_TYPE_DATA_TYPE_LEN_MAX correctly
>> to prevent a kernel-doc warning:
>>
>> Warning: include/linux/ring_buffer.h:61 Enum value
>>  'RINGBUF_TYPE_DATA_TYPE_LEN_MAX' not described in enum 'ring_buffer_type'
>>
>> Fixes: 334d4169a659 ("ring_buffer: compressed event header")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
>> v2: reformat based on comments from Steven;
>>     add more enum types to aid with comments;
>>
>> Cc: Lai Jiangshan <laijs@cn.fujitsu.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: linux-trace-kernel@vger.kernel.org
>> ---
>>  include/linux/ring_buffer.h |   13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> --- linux-next-20251016.orig/include/linux/ring_buffer.h
>> +++ linux-next-20251016/include/linux/ring_buffer.h
>> @@ -43,18 +43,23 @@ struct ring_buffer_event {
>>   *				 array[0] = top (28 .. 59) bits
>>   *				 size = 8 bytes
>>   *
>> - * <= @RINGBUF_TYPE_DATA_TYPE_LEN_MAX:
>> - *				Data record
>> - *				 If type_len is zero:
>> + * @RINGBUF_TYPE_DATA:		Data record
>>   *				  array[0] holds the actual length
>>   *				  array[1..(length+3)/4] holds data
>>   *				  size = 4 + length (bytes)
>> - *				 else
>> + *
>> + * @RINGBUF_TYPE_DATA_TYPE_LEN_MIN:
>> + * 				Data record with length and data as below
>> + * . . .
>> + * @RINGBUF_TYPE_DATA_TYPE_LEN_MAX:
>> + *				Data record
>>   *				  length = type_len << 2
>>   *				  array[0..(length+3)/4-1] holds data
>>   *				  size = 4 + length (bytes)
>>   */
>>  enum ring_buffer_type {
>> +	RINGBUF_TYPE_DATA = 0,
>> +	RINGBUF_TYPE_DATA_TYPE_LEN_MIN = 1,
> 
> Adding this just to satisfy kerneldoc seems a bit much.
> 
> If this is going to be added, then it should be used in the code.
> 
> The RINGBUF_TYPE_DATA should probably be called RINGBUF_TYPE_DATA_LARGE, as
> it is zero when it is a large event (bigger than 112 bytes).
> 
>>  	RINGBUF_TYPE_DATA_TYPE_LEN_MAX = 28,
>>  	RINGBUF_TYPE_PADDING,
>>  	RINGBUF_TYPE_TIME_EXTEND,


Fine, I'll drop it.  :)

-- 
~Randy

