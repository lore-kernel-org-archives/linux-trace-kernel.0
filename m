Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25D837C0E6;
	Tue, 18 Aug 2026 22:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787093805; cv=none; b=A/UcXBIV2aUFSfWs47BB6dafRCFECqWGOBSoJ68JvL5jsL1MdMSGO4+SdWSDc9sUx0XLkYOBT9iWHHoqV/+a8p60XzMpNioH6rL2wnOxdXbUHbEAQm3MjRlPZqx3c/GgIbK4GPrhum76m+eShw1xyeq5Gbks+HkC7qw1uthovis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787093805; c=relaxed/simple;
	bh=5lKh5BGw7zm9TwWQQfgH7LLEST2T5cU2G/j7BgZboEg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=FpWKdhySHi8SulLTerWe7xzdCjo1ktDstuztozhlh/i19YlK5In9p4Jt25Lc5NlYIREn2NH78+7HdK6H67AnTPyDKhXWVgfYl6ChowGXfe3FJqjkVfDElpdBhQfGji3nDcKs6UugBrqUUL+PXCaHMVaLBDFPX5PJJxRygv5u2Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=ExFI9cit; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="ExFI9cit"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787093799;
	bh=BNGYDh4ZJwFgt3Ju+YTzxQOpy8YN08qwymU4qPNrEak=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ExFI9cit3v4zlSyZ3qgTijsRP+N5WxHLGM5fVau4Y7FOIZ5kbmYoGgfHBCqAi1L0N
	 X5P5rjsCfvIptBxJty0HxlyfuJoNBy85qp6YAykUp1Ue7WIdYUAmNI/FhYA5/JxuJx
	 tuwM947byDRcAE5EQfmMYXLnPyo3M8/81vRlgEH8=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4hPlSR3LFmz6vZN;
	Tue, 18 Aug 2026 22:56:39 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4hPlSR0SYyz4y6W;
	Tue, 18 Aug 2026 22:56:39 +0000 (UTC)
Date: Tue, 18 Aug 2026 23:56:39 +0100
From: Bradley Morgan <include@grrlz.net>
To: Masami Hiramatsu <mhiramat@kernel.org>
CC: Naveen N Rao <naveen@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_kprobes=3A_use_DEFINE=5FDEB?=
 =?US-ASCII?Q?UGFS=5FATTRIBUTE_for_the_enabled_knob?=
In-Reply-To: <20260819075221.18e9abdaab49d39f362ee0dc@kernel.org>
References: <20260818014920.23870-1-include@grrlz.net> <20260819075221.18e9abdaab49d39f362ee0dc@kernel.org>
Message-ID: <96B4535F-EB03-4B13-9A2B-0D3AC34627ED@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 18 August 2026 23:52:21 BST, Masami Hiramatsu <mhiramat@kernel.org>
wrote:
>On Tue, 18 Aug 2026 01:49:20 +0000
>Bradley Morgan <include@grrlz.net> wrote:
>
>> This enabled knob is a disgusting terrible hack. It has rolled its
>> own read/write pair since 2007, writing '1' or '0' into a three byte
>> buffer by hand just to print a single character, with an XXX comment
>> begging debugfs for write callbacks on bool files.
>> DEFINE_DEBUGFS_ATTRIBUTE showed up in 2016 and does exactly that, so
>> the disgusting terrible hack has outlived its excuse for nine years.
>> Kill it, and the stale comment with it.
>
>Hm, OK, but please calm down. Just describe the technical reason here.
>


>> 
>> The behavior does not change, except the write only accepts 0/1 now
>> instead of y/n/on/off, and nothing uses anything else.
>
>I think this comment is needed.
>

What do you suggest?

I'm saying

/* Let's kill this hack */

(I love using the word hack!)

>Please add Signed-off-by.
>

V2 acks it 

>The code looks good to me.
>
>Thanks,
>
>> ---
>>  kernel/kprobes.c | 43 +++++++++----------------------------------
>>  1 file changed, 9 insertions(+), 34 deletions(-)
>> 
>> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
>> index bfc89083daa9..044c6b5fd2aa 100644
>> --- a/kernel/kprobes.c
>> +++ b/kernel/kprobes.c
>> @@ -3013,47 +3013,22 @@ static int disarm_all_kprobes(void)
>>  	return ret;
>>  }
>>  
>> -/*
>> - * XXX: The debugfs bool file interface doesn't allow for callbacks
>> - * when the bool state is switched. We can reuse that facility when
>> - * available
>> - */
>> -static ssize_t read_enabled_file_bool(struct file *file,
>> -	       char __user *user_buf, size_t count, loff_t *ppos)
>> +static int kprobes_enabled_set(void *data, u64 val)
>>  {
>> -	char buf[3];
>> +	if (val)
>> +		return arm_all_kprobes();
>>  
>> -	if (!kprobes_all_disarmed)
>> -		buf[0] = '1';
>> -	else
>> -		buf[0] = '0';
>> -	buf[1] = '\n';
>> -	buf[2] = 0x00;
>> -	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
>> +	return disarm_all_kprobes();
>>  }
>>  
>> -static ssize_t write_enabled_file_bool(struct file *file,
>> -	       const char __user *user_buf, size_t count, loff_t *ppos)
>> +static int kprobes_enabled_get(void *data, u64 *val)
>>  {
>> -	bool enable;
>> -	int ret;
>> -
>> -	ret = kstrtobool_from_user(user_buf, count, &enable);
>> -	if (ret)
>> -		return ret;
>> -
>> -	ret = enable ? arm_all_kprobes() : disarm_all_kprobes();
>> -	if (ret)
>> -		return ret;
>> -
>> -	return count;
>> +	*val = !kprobes_all_disarmed;
>> +	return 0;
>>  }
>>  
>> -static const struct file_operations fops_kp = {
>> -	.read =         read_enabled_file_bool,
>> -	.write =        write_enabled_file_bool,
>> -	.llseek =	default_llseek,
>> -};
>> +DEFINE_DEBUGFS_ATTRIBUTE(fops_kp, kprobes_enabled_get,
>> +			 kprobes_enabled_set, "%llu\n");
>>  
>>  static int __init debugfs_kprobe_init(void)
>>  {
>> -- 
>> 2.47.3
>> 
>
>
>

Thanks!
