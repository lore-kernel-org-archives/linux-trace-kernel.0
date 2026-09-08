Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A199355C303;
	Tue,  8 Sep 2026 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788880762; cv=none; b=Elo2Gxo14IFXJcEnh1mXifImtt/rC3VAUsLHLZQGKTI9ijs4HrzoTB6xuiT0+0SE7T9w2pgZLH9o30YhHPvf9iqaxe5XBRDr/T5NUCKzAspsh3XVVaypfzQz+B3MoUYQP+xlAqLgpcB7F33gJ9AXRqG8POUlctf3hioDObrZLz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788880762; c=relaxed/simple;
	bh=H8b8jmFe2YdzJj0316L6EJ6SxjpfRkyqbaHNdoybyI4=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=fTfvAji2I00S/F2yRdqJnHjEAPVwg1DvxwJKFhnCJYYEbIhIRaTuCoTOjhjqQu1atkWyh8DhkQUMQfMQUMEdNdaIfKpWoa6H/La9NNPeKzTfApab3/TqbSDw+QYJNDKg0g/I81N3uVmYxuiYiNMy+DEH+ZsOvbSYx7yxPVokYCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=SmzjIJx0; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=PtkBpivD; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="SmzjIJx0";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="PtkBpivD"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788880740; bh=vKE77yIWKmQjd/EU4+PyYiw
	qouf6KTpmDxpjHJ1yqQ4=; b=SmzjIJx09gQMKYD9GEIgVS86GA9QBh5W+0Oaee83P6oSZDinX+
	YVxjtq6SGU0/0hqZsvs2q5PZ8tet95kx4hjt58qOLvgHvDgnHDkG2mi5T84zqQBLk6dfnR6tt0l
	tZ4n/UY/i8eJPKaZvQdLsHXHzti3IPjiiAdoVhLh2/KiceeHaTRCKIKnHATZ1gMkfolbdi0MOTp
	vxVvI4r4EnsIE8wwAWFiF/D3WPnsMq/gbZp7/Cs2Vlyxkh7IjPSP4LGXfY+GmDoh4qpLh33xqWZ
	RbI6OoL8Dph+uCYv3/wv3zRe/aIuPbw1z7KPIGWWACHW+gVBb0aTEsKaDxYhXBl5zqw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788880740; bh=vKE77yIWKmQjd/EU4+PyYiw
	qouf6KTpmDxpjHJ1yqQ4=; b=PtkBpivDqF6x3oPB5HXunfpGdU/Y8Ht1JZz5lHAxX03FmTIOo9
	HPNu8UgDekWrvA89W52vSlSpI15/GhQAXACQ==;
Date: Tue, 08 Sep 2026 16:19:00 +0100
From: Bradley Morgan <brads@mainlining.org>
To: mhiramat@kernel.org
CC: davem@davemloft.net, include@grrlz.net, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, naveen@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_kprobes=3A_use_DEFINE=5FD?=
 =?US-ASCII?Q?EBUGFS=5FATTRIBUTE_for_the_enabled_knob?=
In-Reply-To: <20260908101017.a4a72b4c93b51571d0fbfbac@kernel.org>
Message-ID: <E69D1F6E-8329-4A67-BCEA-EFBFF91E57D2@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 8 September 2026 02:10:17 BST, Masami Hiramatsu <mhiramat@kernel.org>
wrote:
>On Fri, 21 Aug 2026 09:23:16 +0100
>Bradley Morgan <include@grrlz.net> wrote:
>
>> On 21 August 2026 02:56:48 BST, Masami Hiramatsu <mhiramat@kernel.org>
>> wrote:
>> >On Thu, 20 Aug 2026 16:14:42 +0100
>> >Bradley Morgan <include@grrlz.net> wrote:
>> >
>> >> On 19 August 2026 00:12:40 BST, Bradley Morgan <include@grrlz.net>
>> >wrote:
>> >> >On 19 August 2026 00:08:13 BST, Masami Hiramatsu
><mhiramat@kernel.org>
>> >> >wrote:
>> >> >>On Tue, 18 Aug 2026 01:53:18 +0000
>> >> >>Bradley Morgan <include@grrlz.net> wrote:
>> >> >>
>> >> >>> This enabled knob is a disgusting terrible hack. It has rolled
>its
>> >> >>> own read/write pair since 2007, writing '1' or '0' into a three
>byte
>> >> >>> buffer by hand just to print a single character, with an XXX
>comment
>> >> >>> begging debugfs for write callbacks on bool files.
>> >> >>> DEFINE_DEBUGFS_ATTRIBUTE showed up in 2016 and does exactly that,
>so
>> >> >>> the disgusting terrible hack has outlived its excuse for nine
>years.
>> >> >>> Kill it, and the stale comment with it.
>> >> >>
>> >> >>In other words, does this mean something like the following?
>> >> >>
>> >> >>This "enable" knob implemented custom read/write logic, manually
>> >writing
>> >> >>"1" or "0" to a 3-byte buffer solely to output a single character.
>As
>> >> >>suggested by comments calling for `debugfs` to support write
>callbacks
>> >> >>for boolean files, using `DEFINE_DEBUGFS_ATTRIBUTE` eliminates the
>> >need
>> >> >>for these callbacks.
>> >> >>
>> >> >
>> >> >ehhhhh, well, my description very well tells someone about why this
>is
>> >> >bad, and a hack, and everything. 
>> >> >
>> >> >Your description is good though... But I love to have my personality
>in
>> >my
>> >> >descriptions :(
>> >> >
>> >> 
>> >> Masami, could you give a round down of your nits for V3?
>> >
>> >Ah, OK. The phrasing aside, what you said wasn't wrong, so if you're
>happy
>> >with it, I'll pick it. (Let me pick it to probes/core)
>> >
>> 
>> I'm happy with this patch as is, how accurate?
>> 
>> Do the roar! (Pick it, Shrek reference)
>
>OK, I picked this to probes/core. (sorry for late notice)
>
>Thanks,
>
>> 
>> >Thanks.
>> >
>> >
>> >
>> >> 
>> >> 
>> >> >
>> >> >>Thanks,
>> >> >>
>> >> >>> 
>> >> >>> The behavior does not change, except the write only accepts 0/1
>now
>> >> >>> instead of y/n/on/off, and nothing uses anything else.
>> >> >>> 
>> >> >>> Signed-off-by: Bradley Morgan <include@grrlz.net>
>> >> >>> ---
>> >> >>> Changes since v1:
>> >> >>>  - Added the missing Signed-off-by, sorry.
>> >> >>> 
>> >> >>>  kernel/kprobes.c | 43
>+++++++++----------------------------------
>> >> >>>  1 file changed, 9 insertions(+), 34 deletions(-)
>> >> >>> 
>> >> >>> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
>> >> >>> index bfc89083daa9..044c6b5fd2aa 100644
>> >> >>> --- a/kernel/kprobes.c
>> >> >>> +++ b/kernel/kprobes.c
>> >> >>> @@ -3013,47 +3013,22 @@ static int disarm_all_kprobes(void)
>> >> >>>  	return ret;
>> >> >>>  }
>> >> >>>  
>> >> >>> -/*
>> >> >>> - * XXX: The debugfs bool file interface doesn't allow for
>callbacks
>> >> >>> - * when the bool state is switched. We can reuse that facility
>when
>> >> >>> - * available
>> >> >>> - */
>> >> >>> -static ssize_t read_enabled_file_bool(struct file *file,
>> >> >>> -	       char __user *user_buf, size_t count, loff_t *ppos)
>> >> >>> +static int kprobes_enabled_set(void *data, u64 val)
>> >> >>>  {
>> >> >>> -	char buf[3];
>> >> >>> +	if (val)
>> >> >>> +		return arm_all_kprobes();
>> >> >>>  
>> >> >>> -	if (!kprobes_all_disarmed)
>> >> >>> -		buf[0] = '1';
>> >> >>> -	else
>> >> >>> -		buf[0] = '0';
>> >> >>> -	buf[1] = '\n';
>> >> >>> -	buf[2] = 0x00;
>> >> >>> -	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
>> >> >>> +	return disarm_all_kprobes();
>> >> >>>  }
>> >> >>>  
>> >> >>> -static ssize_t write_enabled_file_bool(struct file *file,
>> >> >>> -	       const char __user *user_buf, size_t count, loff_t *ppos)
>> >> >>> +static int kprobes_enabled_get(void *data, u64 *val)
>> >> >>>  {
>> >> >>> -	bool enable;
>> >> >>> -	int ret;
>> >> >>> -
>> >> >>> -	ret = kstrtobool_from_user(user_buf, count, &enable);
>> >> >>> -	if (ret)
>> >> >>> -		return ret;
>> >> >>> -
>> >> >>> -	ret = enable ? arm_all_kprobes() : disarm_all_kprobes();
>> >> >>> -	if (ret)
>> >> >>> -		return ret;
>> >> >>> -
>> >> >>> -	return count;
>> >> >>> +	*val = !kprobes_all_disarmed;
>> >> >>> +	return 0;
>> >> >>>  }
>> >> >>>  
>> >> >>> -static const struct file_operations fops_kp = {
>> >> >>> -	.read =         read_enabled_file_bool,
>> >> >>> -	.write =        write_enabled_file_bool,
>> >> >>> -	.llseek =	default_llseek,
>> >> >>> -};
>> >> >>> +DEFINE_DEBUGFS_ATTRIBUTE(fops_kp, kprobes_enabled_get,
>> >> >>> +			 kprobes_enabled_set, "%llu\n");
>> >> >>>  
>> >> >>>  static int __init debugfs_kprobe_init(void)
>> >> >>>  {
>> >> >>> -- 
>> >> >>> 2.47.3
>> >> >>> 
>> >> >>
>> >> >>
>> >> >>
>> >> >
>> >> >Thanks!
>> >> 
>> >> Thanks!
>> >
>> >
>> >
>> 
>> Thanks!
>
>
>
Hey, can u change sob to this email if possible? Check lore link below for
info
--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
