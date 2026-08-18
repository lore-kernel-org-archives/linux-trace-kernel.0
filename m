Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C1C233954;
	Tue, 18 Aug 2026 23:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787094764; cv=none; b=CT+YLwdb2Ww06/Fc42OK98qrgLM/nHy3MqurjOu5SVvrbI0GOC0TTEEC8OCRpDqqHln+rNxJVVktWlwQkUzzXhnhGYVfEZbr5frYT5j9r9hiSyo62J83SBVW6LZ+ao04OU+YnXWxCJJv/R5N7hpNXLZbDx9t0B6bx5saZptxikA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787094764; c=relaxed/simple;
	bh=KnmdjJGlDiEcqiwyb2gL1oqhiezN0ptxk/Vng4N7kXw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=akT2ayqTryTjKeeEyuGDXp7oAyW75DkBfISBo48XF9o2SSeDHV14A8SGuQAWF9OAkshaLoy3/xo8jSAYVetIeLb0lTQwzhtSOMyJDpQXd+9Xm7UOH8UHHm3XiZZq2fcyo15HJlic0BnyZRJjfdHFeowd2iJvGqUNui44xG/tuUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=jTqupWrr; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="jTqupWrr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787094760;
	bh=i5yTHM9sTvE7JYLqlpPURxrPO43udIfu90NwaYLGjvU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=jTqupWrrAewzxi+451xcuZJ4gYi50NGghK7MXFtUJeBfww2AgSDqNNBZ5CBQUrQFg
	 r1ULlR6GzX2jBaUKGgdTsnH348GY6he5ECTLQ33QEYO7OiAMIL4JAsGpFA2EWfdWVY
	 HeByGcKrDpyN+HZlCsM8xPGA4Xc8oFVS969dhnxs=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4hPlpw0M1Nz6vYy;
	Tue, 18 Aug 2026 23:12:40 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4hPlpv3r3vz4y6W;
	Tue, 18 Aug 2026 23:12:39 +0000 (UTC)
Date: Wed, 19 Aug 2026 00:12:40 +0100
From: Bradley Morgan <include@grrlz.net>
To: Masami Hiramatsu <mhiramat@kernel.org>
CC: Naveen N Rao <naveen@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_kprobes=3A_use_DEFINE=5FD?=
 =?US-ASCII?Q?EBUGFS=5FATTRIBUTE_for_the_enabled_knob?=
In-Reply-To: <20260819080813.d66950e37e660e018dfb19e9@kernel.org>
References: <20260818015318.24103-1-include@grrlz.net> <20260819080813.d66950e37e660e018dfb19e9@kernel.org>
Message-ID: <9533DBAB-DED1-4D61-93ED-AEFA2C585454@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 19 August 2026 00:08:13 BST, Masami Hiramatsu <mhiramat@kernel.org>
wrote:
>On Tue, 18 Aug 2026 01:53:18 +0000
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
>In other words, does this mean something like the following?
>
>This "enable" knob implemented custom read/write logic, manually writing
>"1" or "0" to a 3-byte buffer solely to output a single character. As
>suggested by comments calling for `debugfs` to support write callbacks
>for boolean files, using `DEFINE_DEBUGFS_ATTRIBUTE` eliminates the need
>for these callbacks.
>

ehhhhh, well, my description very well tells someone about why this is
bad, and a hack, and everything. 

Your description is good though... But I love to have my personality in my
descriptions :(


>Thanks,
>
>> 
>> The behavior does not change, except the write only accepts 0/1 now
>> instead of y/n/on/off, and nothing uses anything else.
>> 
>> Signed-off-by: Bradley Morgan <include@grrlz.net>
>> ---
>> Changes since v1:
>>  - Added the missing Signed-off-by, sorry.
>> 
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
