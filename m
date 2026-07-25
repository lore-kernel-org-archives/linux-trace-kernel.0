Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C26EAC7;
	Sat, 25 Jul 2026 00:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784940661; cv=none; b=GS4Zk2cxZR10Xut5n2fnevpOv5k/+zwuA1mqtGb8SscWXMaAmlsWzK79WV1oF05KcB5YDGDAPJm4zZwqhRa6e1kLmNmpir4uxthTR/odu080gO4btVgQIp1SPxWhwmgItmBrgAoy0pqtO/pemTt80RMviAHqOLFOBRPbTMInGbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784940661; c=relaxed/simple;
	bh=fBMvNGQuZ1spqyye1A8wtwkXMfhAaWM8KWn6kKaImjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wq0SUa4MjKHFzm6fAto5Z3vBuCBhYuy5tq5ZCZPdV1yrHxOHMYdtZr6W0XA+V2BJya9bpDAkDgkczczH4Xt+GXJhTyFecOSbaQ3Zdb4YCkExeEydEotzc2vM+Q6topz7i8tGRDsAMM7MA1JFNRFMazUjwlCnNnpOVvoyHRAqyxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h6R8r39dMzKHMW0;
	Sat, 25 Jul 2026 08:50:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 340364087C;
	Sat, 25 Jul 2026 08:50:52 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgCXpXFqCGRqyIbKCQ--.19518S2;
	Sat, 25 Jul 2026 08:50:52 +0800 (CST)
Message-ID: <3efb6324-18fc-48d0-a62e-7bce889eb4e7@huaweicloud.com>
Date: Sat, 25 Jul 2026 08:50:50 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ftrace: Add global mutex to serialize trace_parser
 access
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260723133404.1926732-1-wutengda@huaweicloud.com>
 <20260724184757.502183d4@gandalf.local.home>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260724184757.502183d4@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCXpXFqCGRqyIbKCQ--.19518S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF1kXrykXFy8XryUur4xCrg_yoWfWrX_W3
	4q9F4DGan2krnIvanYyFy8tFn8GFWDXr40v3yUtFZrAasFqF97Za10gFn5KFs7Xry0gF9x
	G3s3Xwn5KryavjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbz8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7IJmUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/7/25 6:47, Steven Rostedt wrote:
> On Thu, 23 Jul 2026 13:34:04 +0000
> Tengda Wu <wutengda@huaweicloud.com> wrote:
> 
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
>> @@ -1097,6 +1097,12 @@ struct ftrace_ops global_ops = {
>>  					  FTRACE_OPS_FL_PID,
>>  };
>>  
>> +/*
>> + * parser_lock - Protects trace_parser state against concurrent operations.
>> + * Held across trace_get_user() and subsequent buffer parsing to prevent races.
>> + */
>> +DEFINE_MUTEX(parser_lock);
>> +
> 
> Sashiko pointed out[1] that this should be static. And it should. Could you
> send a v4?
> 
> static DEFINE_MUTEX(parser_lock);
> 
> Note, you can ignore the other Sashiko comments.
> 
> -- Steve
> 
> [1] https://sashiko.dev/#/patchset/20260723133404.1926732-1-wutengda%40huaweicloud.com

Sorry, I overlooked that. Will add static and send v4 right away.

Thanks,
Tengda

