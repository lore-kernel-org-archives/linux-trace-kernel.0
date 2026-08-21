Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD9839DBDB;
	Fri, 21 Aug 2026 08:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787300601; cv=none; b=sPSJh0vD5ZGew4VhvTEK6HRffgysKMsZ3hec4oEFkRtUO6IAkVMy+RQV97jxFLNgJW4q/J6+q2/hdeNAF0O5Yag76aNd/5swyOzDaJwd1EQqgT4FkwF6ySxM5hgjSJbarVvrCDwE7L6YH4dOF6Pjs1qxE4vJTywNRjJGfzaahdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787300601; c=relaxed/simple;
	bh=tT/406ZQN1zYZif55ZRS3T5pMH8vECA/Po3SjQEgItQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Q1HBQrmzGFZo9IWLI4ypNKF6mvvbDZdpHoKv2eT7YSarYfBwVQrUVHPgZYwgJAbG1J6fZvh9dHdik//7MGSKEYQzMkrTCiE0IlUzvNsW+ouv7J8S5Mv60na+a7TXqDJkmbmTN9AdPAO8Z4DTXRQzSnYtYjDJzrdCS1JwosLxTWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=CSC7jpkU; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="CSC7jpkU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787300597;
	bh=q9OF37f0kZhtFmwoiAbN6JOPVRzdh3BsVMv4n79fEpE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=CSC7jpkUlZmz3TuaihNSdqIfhmFGlHayM+6PuUUDY9M8w5pGVEcMls2MOJAfJu2Vy
	 Dn+SnsU0OFqayKMSp0k86mjIyLmDO6bcSG5LEi/GxYMNHijr4G06Tsn4+zGTrW/1/d
	 nDMMUQ1XH+bIGEOIg0tFhyRINTVExOullJWmaBg4=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4hRCxK0Pxyz6vMR;
	Fri, 21 Aug 2026 08:23:17 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4hRCxJ4HKyz4y6W;
	Fri, 21 Aug 2026 08:23:16 +0000 (UTC)
Date: Fri, 21 Aug 2026 09:23:16 +0100
From: Bradley Morgan <include@grrlz.net>
To: Masami Hiramatsu <mhiramat@kernel.org>
CC: Naveen N Rao <naveen@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_kprobes=3A_use_DEFINE=5FD?=
 =?US-ASCII?Q?EBUGFS=5FATTRIBUTE_for_the_enabled_knob?=
In-Reply-To: <20260821105648.ebe0e567367bddf8e449fe4c@kernel.org>
References: <20260818015318.24103-1-include@grrlz.net> <20260819080813.d66950e37e660e018dfb19e9@kernel.org> <9533DBAB-DED1-4D61-93ED-AEFA2C585454@grrlz.net> <D6D3A89D-FD2D-4D09-B2DF-7808ED89854D@grrlz.net> <20260821105648.ebe0e567367bddf8e449fe4c@kernel.org>
Message-ID: <002CDFE0-22E1-4082-BFBF-261B8B1FCDCB@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 21 August 2026 02:56:48 BST, Masami Hiramatsu <mhiramat@kernel.org>
wrote:
>On Thu, 20 Aug 2026 16:14:42 +0100
>Bradley Morgan <include@grrlz.net> wrote:
>
>> On 19 August 2026 00:12:40 BST, Bradley Morgan <include@grrlz.net>
>wrote:
>> >On 19 August 2026 00:08:13 BST, Masami Hiramatsu <mhiramat@kernel.org>
>> >wrote:
>> >>On Tue, 18 Aug 2026 01:53:18 +0000
>> >>Bradley Morgan <include@grrlz.net> wrote:
>> >>
>> >>> This enabled knob is a disgusting terrible hack. It has rolled its
>> >>> own read/write pair since 2007, writing '1' or '0' into a three byte
>> >>> buffer by hand just to print a single character, with an XXX comment
>> >>> begging debugfs for write callbacks on bool files.
>> >>> DEFINE_DEBUGFS_ATTRIBUTE showed up in 2016 and does exactly that, so
>> >>> the disgusting terrible hack has outlived its excuse for nine years.
>> >>> Kill it, and the stale comment with it.
>> >>
>> >>In other words, does this mean something like the following?
>> >>
>> >>This "enable" knob implemented custom read/write logic, manually
>writing
>> >>"1" or "0" to a 3-byte buffer solely to output a single character. As
>> >>suggested by comments calling for `debugfs` to support write callbacks
>> >>for boolean files, using `DEFINE_DEBUGFS_ATTRIBUTE` eliminates the
>need
>> >>for these callbacks.
>> >>
>> >
>> >ehhhhh, well, my description very well tells someone about why this is
>> >bad, and a hack, and everything. 
>> >
>> >Your description is good though... But I love to have my personality in
>my
>> >descriptions :(
>> >
>> 
>> Masami, could you give a round down of your nits for V3?
>
>Ah, OK. The phrasing aside, what you said wasn't wrong, so if you're happy
>with it, I'll pick it. (Let me pick it to probes/core)
>

I'm happy with this patch as is, how accurate?

Do the roar! (Pick it, Shrek reference)

>Thanks.
>
>
>
>> 
>> 
>> >
>> >>Thanks,
>> >>
>> >>> 
>> >>> The behavior does not change, except the write only accepts 0/1 now
>> >>> instead of y/n/on/off, and nothing uses anything else.
>> >>> 
>> >>> Signed-off-by: Bradley Morgan <include@grrlz.net>
>> >>> ---
>> >>> Changes since v1:
>> >>>  - Added the missing Signed-off-by, sorry.
>> >>> 
>> >>>  kernel/kprobes.c | 43 +++++++++----------------------------------
>> >>>  1 file changed, 9 insertions(+), 34 deletions(-)
>> >>> 
>> >>> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
>> >>> index bfc89083daa9..044c6b5fd2aa 100644
>> >>> --- a/kernel/kprobes.c
>> >>> +++ b/kernel/kprobes.c
>> >>> @@ -3013,47 +3013,22 @@ static int disarm_all_kprobes(void)
>> >>>  	return ret;
>> >>>  }
>> >>>  
>> >>> -/*
>> >>> - * XXX: The debugfs bool file interface doesn't allow for callbacks
>> >>> - * when the bool state is switched. We can reuse that facility when
>> >>> - * available
>> >>> - */
>> >>> -static ssize_t read_enabled_file_bool(struct file *file,
>> >>> -	       char __user *user_buf, size_t count, loff_t *ppos)
>> >>> +static int kprobes_enabled_set(void *data, u64 val)
>> >>>  {
>> >>> -	char buf[3];
>> >>> +	if (val)
>> >>> +		return arm_all_kprobes();
>> >>>  
>> >>> -	if (!kprobes_all_disarmed)
>> >>> -		buf[0] = '1';
>> >>> -	else
>> >>> -		buf[0] = '0';
>> >>> -	buf[1] = '\n';
>> >>> -	buf[2] = 0x00;
>> >>> -	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
>> >>> +	return disarm_all_kprobes();
>> >>>  }
>> >>>  
>> >>> -static ssize_t write_enabled_file_bool(struct file *file,
>> >>> -	       const char __user *user_buf, size_t count, loff_t *ppos)
>> >>> +static int kprobes_enabled_get(void *data, u64 *val)
>> >>>  {
>> >>> -	bool enable;
>> >>> -	int ret;
>> >>> -
>> >>> -	ret = kstrtobool_from_user(user_buf, count, &enable);
>> >>> -	if (ret)
>> >>> -		return ret;
>> >>> -
>> >>> -	ret = enable ? arm_all_kprobes() : disarm_all_kprobes();
>> >>> -	if (ret)
>> >>> -		return ret;
>> >>> -
>> >>> -	return count;
>> >>> +	*val = !kprobes_all_disarmed;
>> >>> +	return 0;
>> >>>  }
>> >>>  
>> >>> -static const struct file_operations fops_kp = {
>> >>> -	.read =         read_enabled_file_bool,
>> >>> -	.write =        write_enabled_file_bool,
>> >>> -	.llseek =	default_llseek,
>> >>> -};
>> >>> +DEFINE_DEBUGFS_ATTRIBUTE(fops_kp, kprobes_enabled_get,
>> >>> +			 kprobes_enabled_set, "%llu\n");
>> >>>  
>> >>>  static int __init debugfs_kprobe_init(void)
>> >>>  {
>> >>> -- 
>> >>> 2.47.3
>> >>> 
>> >>
>> >>
>> >>
>> >
>> >Thanks!
>> 
>> Thanks!
>
>
>

Thanks!
