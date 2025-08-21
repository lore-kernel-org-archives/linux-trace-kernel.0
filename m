Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0519429BDBC
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755801162; cv=none; b=ANhWnx1tQuLFSpdOb/oQMf90vhhmYfpOfNN8ETQCdqmvBusI9okFQ/JoCIjJko4DgQQpjGKVSWR88TLvUOXsyeoiomQbCzUiq3tr2hJ7M7Xj50O86z96jL1JxrgUnEbvocohKZVhVcnJblLnRa5zybVd26GEuOQhK0yG31Mm6Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755801162; c=relaxed/simple;
	bh=u3StDUoNIp/uTjj/g1HQcbTm74CL9LcsVrJjZIctrz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=udMBmXaSxJwH2jMfdgoziJiEGf/oknZne5UKoG0dz6/ckKyfY9kO4TKjVDeacJKaX9hhaKEMDwaD2/OjBTA8VomqYAdYdBakfKMVIq6vVLkskN0PEX3UnAiow4/qpJrmPuGHSrLuEYLMdgB82bKb2CzAdiUFYZEvRMPJNEVQMvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=elijahs.space; spf=pass smtp.mailfrom=elijahs.space; dkim=pass (2048-bit key) header.d=elijahs.space header.i=@elijahs.space header.b=kL9B5bKu; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=XkySpzEw; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=elijahs.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elijahs.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elijahs.space header.i=@elijahs.space header.b="kL9B5bKu";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="XkySpzEw"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=kL9B5bKuQyEB9VwbMCvfExFGwlL0MNF2IrKXOYlVgidkIlab5pdbSaFZfhr4jL1HBr54SFzDv+MIIC0xjoq0RnH4YeEZaUUaT2DOXDFfVQbDsZaCbKbJ/+P8Rw6DLKcE0xGFRCXHOo/IGMgrkF4xtX1dcYHZHeg8WwuoGSRKiLNMYxEUBdD1pykGZpnnu53AYF/dGckzPhkTqdVVNYUW0LbDyjtnStU/sdMav4qi9Qv1xia2mSFiTRwrDh8lR0gJr0ZKSD9iDgFl0Qpc/bJbZCy2273WS6LRr1Ehxpq3o2VCe5T2eCfHSSroYUXvzK0q5cKBKGD0B9r2Pi4eDY2U9Q==; s=purelymail3; d=elijahs.space; v=1; bh=u3StDUoNIp/uTjj/g1HQcbTm74CL9LcsVrJjZIctrz4=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=XkySpzEw9RC0dEwosOmwd9/wjPW/GYqGT00j1fEWh8dEk0sei/kwaGATC9IJXSZa1nvmeYNw8BHW5xFZAJM996y/o17gMQFgKp2N56Mo70AoyTmP2EkC9HNg+HwCW23NNAsk+acK+UcEDdlAJeRNV9ahZKqz0TMQofyOxCpNlDha+l48m9VqH7cSnogdFGAtDPxfKwNTi+3J9yfZHxRQUcLHj6zbmnLs/0fdBxEabQZ2G8AZmWqS8sQvk45Z02fSlyph6LFs4M9KnZ1hYCkZCOxi4l1V6faAyo4CEUgpdqZFFinmAfObQiDl26CJqhuRu6NOB747fUQQtdwAAaVr6g==; s=purelymail3; d=purelymail.com; v=1; bh=u3StDUoNIp/uTjj/g1HQcbTm74CL9LcsVrJjZIctrz4=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 26912:4866:null:purelymail
X-Pm-Original-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -832003948;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 21 Aug 2025 18:32:19 +0000 (UTC)
Message-ID: <ce062d82-41cb-42c0-b970-1312dbcd1094@elijahs.space>
Date: Thu, 21 Aug 2025 11:32:17 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: move buffer in trace_seq to end of struct
To: Steven Rostedt <rostedt@goodmis.org>, Elijah Wright <git@elijahs.space>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20250821053917.23301-1-git@elijahs.space>
 <20250821114355.6ee546b0@gandalf.local.home>
 <20250821115359.3988b807@gandalf.local.home>
Content-Language: en-US
From: Elijah <me@elijahs.space>
In-Reply-To: <20250821115359.3988b807@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

can we maybe encode the overflow state in seq_buf? check if 
seq_buf_has_overflowed and clamp len back to the used size 
(seq_buf_used) in a helper?

On 8/21/2025 8:53 AM, Steven Rostedt wrote:
> On Thu, 21 Aug 2025 11:43:55 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
>> index a93ed5ac3226..92364deb39a5 100644
>> --- a/include/linux/trace_seq.h
>> +++ b/include/linux/trace_seq.h
>> @@ -24,14 +24,12 @@ struct trace_seq {
>>   	char			buffer[TRACE_SEQ_BUFFER_SIZE];
>>   	struct seq_buf		seq;
>>   	size_t			readpos;
>> -	int			full;
>>   };
>>   
> 
> I should have tried compiling it before posting. But trace.c has this:
> 
> 		ret = print_trace_line(iter);
> 		if (ret == TRACE_TYPE_PARTIAL_LINE) {
> 			iter->seq.full = 0;
> 			trace_seq_puts(&iter->seq, "[LINE TOO BIG]\n");
> 		}
> 
> I need to figure out a clean way to fix that too :-p
> 
> -- Steve

