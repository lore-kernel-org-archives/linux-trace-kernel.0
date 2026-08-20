Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE217379EDA;
	Thu, 20 Aug 2026 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787238886; cv=none; b=tThYv/8U7rkrJMwIYynbbtxdhWcO0Br/gcJ2CvUp41ENU7SMkWhpPPO98DwIxZbfyPQLS5OjlaR2i7Q3IiPBX4ccxC5tGE6ohgIh3wzGv3k844NV2gU4N5hpWujEH9lvtj/ZYHaAWnm2WpCv1zmZz6GR5i+GWnIyCZlobgMtah8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787238886; c=relaxed/simple;
	bh=lNSe0xhrDkAmAn3QZ4m1NfnuIzVK2gCsHZC07PQ5zPI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=fnP4/xzFMX+H+C3nSysExS3AuRAjrlexlXse2wrU/PGsJTDsZixEhWOU0rdOe3eJyePHpC1Vj+e0JzXWNRV/DZ0Dbh7t78y7J/paPzX70+wVUlPy5Rg4iTVwOlhFuH60ATKDRGqhLgqoxrofK10vj1dfXKulDylUFdYuUngn7Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=PYlD9/uJ; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="PYlD9/uJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787238881;
	bh=DA9axZiz12z1uSU3CRoNiulZdFRUWsVDE5pNbA/uQSU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=PYlD9/uJS4MEmdcxEzquG+UHwpbSIb5XEusctKwCM8MgyhVRCveQlY3DgwZ0CAAN8
	 TvC5aHbPC/QmZQsH9b+iEb1YD1/H3MxOcwHLGlhh7t0wCTaPrb13/28uRs9AafTA1l
	 7D/Xec1Kp9/CrZ8/MHmBQYn9bQESCYDC3vZ0XrDs=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4hQn6T4ycDz110q;
	Thu, 20 Aug 2026 15:14:41 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4hQn6T2053z110G;
	Thu, 20 Aug 2026 15:14:41 +0000 (UTC)
Date: Thu, 20 Aug 2026 16:14:42 +0100
From: Bradley Morgan <include@grrlz.net>
To: Masami Hiramatsu <mhiramat@kernel.org>
CC: Naveen N Rao <naveen@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_kprobes=3A_use_DEFINE=5FD?=
 =?US-ASCII?Q?EBUGFS=5FATTRIBUTE_for_the_enabled_knob?=
In-Reply-To: <9533DBAB-DED1-4D61-93ED-AEFA2C585454@grrlz.net>
References: <20260818015318.24103-1-include@grrlz.net> <20260819080813.d66950e37e660e018dfb19e9@kernel.org> <9533DBAB-DED1-4D61-93ED-AEFA2C585454@grrlz.net>
Message-ID: <D6D3A89D-FD2D-4D09-B2DF-7808ED89854D@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 19 August 2026 00:12:40 BST, Bradley Morgan <include@grrlz.net> wrote:
>On 19 August 2026 00:08:13 BST, Masami Hiramatsu <mhiramat@kernel.org>
>wrote:
>>On Tue, 18 Aug 2026 01:53:18 +0000
>>Bradley Morgan <include@grrlz.net> wrote:
>>
>>> This enabled knob is a disgusting terrible hack. It has rolled its
>>> own read/write pair since 2007, writing '1' or '0' into a three byte
>>> buffer by hand just to print a single character, with an XXX comment
>>> begging debugfs for write callbacks on bool files.
>>> DEFINE_DEBUGFS_ATTRIBUTE showed up in 2016 and does exactly that, so
>>> the disgusting terrible hack has outlived its excuse for nine years.
>>> Kill it, and the stale comment with it.
>>
>>In other words, does this mean something like the following?
>>
>>This "enable" knob implemented custom read/write logic, manually writing
>>"1" or "0" to a 3-byte buffer solely to output a single character. As
>>suggested by comments calling for `debugfs` to support write callbacks
>>for boolean files, using `DEFINE_DEBUGFS_ATTRIBUTE` eliminates the need
>>for these callbacks.
>>
>
>ehhhhh, well, my description very well tells someone about why this is
>bad, and a hack, and everything. 
>
>Your description is good though... But I love to have my personality in my
>descriptions :(
>

Masami, could you give a round down of your nits for V3?


>
>>Thanks,
>>
>>> 
>>> The behavior does not change, except the write only accepts 0/1 now
>>> instead of y/n/on/off, and nothing uses anything else.
>>> 
>>> Signed-off-by: Bradley Morgan <include@grrlz.net>
>>> ---
>>> Changes since v1:
>>>  - Added the missing Signed-off-by, sorry.
>>> 
>>>  kernel/kprobes.c | 43 +++++++++----------------------------------
>>>  1 file changed, 9 insertions(+), 34 deletions(-)
>>> 
>>> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
>>> index bfc89083daa9..044c6b5fd2aa 100644
>>> --- a/kernel/kprobes.c
>>> +++ b/kernel/kprobes.c
>>> @@ -3013,47 +3013,22 @@ static int disarm_all_kprobes(void)
>>>  	return ret;
>>>  }
>>>  
>>> -/*
>>> - * XXX: The debugfs bool file interface doesn't allow for callbacks
>>> - * when the bool state is switched. We can reuse that facility when
>>> - * available
>>> - */
>>> -static ssize_t read_enabled_file_bool(struct file *file,
>>> -	       char __user *user_buf, size_t count, loff_t *ppos)
>>> +static int kprobes_enabled_set(void *data, u64 val)
>>>  {
>>> -	char buf[3];
>>> +	if (val)
>>> +		return arm_all_kprobes();
>>>  
>>> -	if (!kprobes_all_disarmed)
>>> -		buf[0] = '1';
>>> -	else
>>> -		buf[0] = '0';
>>> -	buf[1] = '\n';
>>> -	buf[2] = 0x00;
>>> -	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
>>> +	return disarm_all_kprobes();
>>>  }
>>>  
>>> -static ssize_t write_enabled_file_bool(struct file *file,
>>> -	       const char __user *user_buf, size_t count, loff_t *ppos)
>>> +static int kprobes_enabled_get(void *data, u64 *val)
>>>  {
>>> -	bool enable;
>>> -	int ret;
>>> -
>>> -	ret = kstrtobool_from_user(user_buf, count, &enable);
>>> -	if (ret)
>>> -		return ret;
>>> -
>>> -	ret = enable ? arm_all_kprobes() : disarm_all_kprobes();
>>> -	if (ret)
>>> -		return ret;
>>> -
>>> -	return count;
>>> +	*val = !kprobes_all_disarmed;
>>> +	return 0;
>>>  }
>>>  
>>> -static const struct file_operations fops_kp = {
>>> -	.read =         read_enabled_file_bool,
>>> -	.write =        write_enabled_file_bool,
>>> -	.llseek =	default_llseek,
>>> -};
>>> +DEFINE_DEBUGFS_ATTRIBUTE(fops_kp, kprobes_enabled_get,
>>> +			 kprobes_enabled_set, "%llu\n");
>>>  
>>>  static int __init debugfs_kprobe_init(void)
>>>  {
>>> -- 
>>> 2.47.3
>>> 
>>
>>
>>
>
>Thanks!

Thanks!
