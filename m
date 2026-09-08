Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242ED1397;
	Tue,  8 Sep 2026 01:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788829823; cv=none; b=glkjrViBzrZt2JnjiiYzDoHH8664wlaABLFnXyc8z2D2p4SFj4Stps5tlP9f2NB3W9uJXbxCuZOR1sBkTFHweA7JtNBK42MmZQ9imvMiXSmXT0lO3FyGIH6W+HBeuhybguDn7Sza7My1sToXHYgQ/s1YfctMOXKeFKc6P/vjD9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788829823; c=relaxed/simple;
	bh=+2fWzZPJNxyPIBFPZ33vmoSmWuHbZdmA+Bqrgz1ZLqs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LkOs39VPOII92xuJbhzGtnemqbh8N5dDJbrq6T3yk12+P+SMaxek6V41t+cgQc/xnNm8dGJf3fhm/rry6+S/8bbqvQ26Bo3/1Sa9a75iroBaTfmc5eISOaTepBjE8PXVwijDh9Xmh6hbQvPALUz8RSvktdWbXwYeomuQiJfw8eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUSzpP5Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUSzpP5Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4071F00A3A;
	Tue,  8 Sep 2026 01:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788829821;
	bh=f+HvhEx96gIcR7dBxdtnSk8QbXLk8srqASCuGpattKc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IUSzpP5QuuMqIztvk3w3oh2RNf/wEuY9MbjbXIB6YvCJtxdCiAWk81r9cGvtXDS01
	 e8Q6NtJbHWjZsekInu37gZepZxt3P64zMSB85RGaAPSH9lUI6BLMGAODs+Pf+B7EXU
	 G3xU8LvGgdmN5nKx1eAAOH11SfM8okG3uBh7Do+VlANTmyDJEmPdOdXqKR5WbgRdHl
	 lLGJ6lca1U1pT1ZfItRoI6LzuVyOgm7b2PYRsqbQ5mosJmVn7Bjb7wIPXW0XWRF32W
	 RpRM9kS3qfO6H9POGzqvhj5JTZhGISwBMXhj8OwVJBnCWi769hhdw2LNacjKK+UChO
	 udAn/fbtrQ8vw==
Date: Tue, 8 Sep 2026 10:10:17 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Bradley Morgan <include@grrlz.net>
Cc: Naveen N Rao <naveen@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kprobes: use DEFINE_DEBUGFS_ATTRIBUTE for the
 enabled knob
Message-Id: <20260908101017.a4a72b4c93b51571d0fbfbac@kernel.org>
In-Reply-To: <002CDFE0-22E1-4082-BFBF-261B8B1FCDCB@grrlz.net>
References: <20260818015318.24103-1-include@grrlz.net>
	<20260819080813.d66950e37e660e018dfb19e9@kernel.org>
	<9533DBAB-DED1-4D61-93ED-AEFA2C585454@grrlz.net>
	<D6D3A89D-FD2D-4D09-B2DF-7808ED89854D@grrlz.net>
	<20260821105648.ebe0e567367bddf8e449fe4c@kernel.org>
	<002CDFE0-22E1-4082-BFBF-261B8B1FCDCB@grrlz.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Aug 2026 09:23:16 +0100
Bradley Morgan <include@grrlz.net> wrote:

> On 21 August 2026 02:56:48 BST, Masami Hiramatsu <mhiramat@kernel.org>
> wrote:
> >On Thu, 20 Aug 2026 16:14:42 +0100
> >Bradley Morgan <include@grrlz.net> wrote:
> >
> >> On 19 August 2026 00:12:40 BST, Bradley Morgan <include@grrlz.net>
> >wrote:
> >> >On 19 August 2026 00:08:13 BST, Masami Hiramatsu <mhiramat@kernel.org>
> >> >wrote:
> >> >>On Tue, 18 Aug 2026 01:53:18 +0000
> >> >>Bradley Morgan <include@grrlz.net> wrote:
> >> >>
> >> >>> This enabled knob is a disgusting terrible hack. It has rolled its
> >> >>> own read/write pair since 2007, writing '1' or '0' into a three byte
> >> >>> buffer by hand just to print a single character, with an XXX comment
> >> >>> begging debugfs for write callbacks on bool files.
> >> >>> DEFINE_DEBUGFS_ATTRIBUTE showed up in 2016 and does exactly that, so
> >> >>> the disgusting terrible hack has outlived its excuse for nine years.
> >> >>> Kill it, and the stale comment with it.
> >> >>
> >> >>In other words, does this mean something like the following?
> >> >>
> >> >>This "enable" knob implemented custom read/write logic, manually
> >writing
> >> >>"1" or "0" to a 3-byte buffer solely to output a single character. As
> >> >>suggested by comments calling for `debugfs` to support write callbacks
> >> >>for boolean files, using `DEFINE_DEBUGFS_ATTRIBUTE` eliminates the
> >need
> >> >>for these callbacks.
> >> >>
> >> >
> >> >ehhhhh, well, my description very well tells someone about why this is
> >> >bad, and a hack, and everything. 
> >> >
> >> >Your description is good though... But I love to have my personality in
> >my
> >> >descriptions :(
> >> >
> >> 
> >> Masami, could you give a round down of your nits for V3?
> >
> >Ah, OK. The phrasing aside, what you said wasn't wrong, so if you're happy
> >with it, I'll pick it. (Let me pick it to probes/core)
> >
> 
> I'm happy with this patch as is, how accurate?
> 
> Do the roar! (Pick it, Shrek reference)

OK, I picked this to probes/core. (sorry for late notice)

Thanks,

> 
> >Thanks.
> >
> >
> >
> >> 
> >> 
> >> >
> >> >>Thanks,
> >> >>
> >> >>> 
> >> >>> The behavior does not change, except the write only accepts 0/1 now
> >> >>> instead of y/n/on/off, and nothing uses anything else.
> >> >>> 
> >> >>> Signed-off-by: Bradley Morgan <include@grrlz.net>
> >> >>> ---
> >> >>> Changes since v1:
> >> >>>  - Added the missing Signed-off-by, sorry.
> >> >>> 
> >> >>>  kernel/kprobes.c | 43 +++++++++----------------------------------
> >> >>>  1 file changed, 9 insertions(+), 34 deletions(-)
> >> >>> 
> >> >>> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> >> >>> index bfc89083daa9..044c6b5fd2aa 100644
> >> >>> --- a/kernel/kprobes.c
> >> >>> +++ b/kernel/kprobes.c
> >> >>> @@ -3013,47 +3013,22 @@ static int disarm_all_kprobes(void)
> >> >>>  	return ret;
> >> >>>  }
> >> >>>  
> >> >>> -/*
> >> >>> - * XXX: The debugfs bool file interface doesn't allow for callbacks
> >> >>> - * when the bool state is switched. We can reuse that facility when
> >> >>> - * available
> >> >>> - */
> >> >>> -static ssize_t read_enabled_file_bool(struct file *file,
> >> >>> -	       char __user *user_buf, size_t count, loff_t *ppos)
> >> >>> +static int kprobes_enabled_set(void *data, u64 val)
> >> >>>  {
> >> >>> -	char buf[3];
> >> >>> +	if (val)
> >> >>> +		return arm_all_kprobes();
> >> >>>  
> >> >>> -	if (!kprobes_all_disarmed)
> >> >>> -		buf[0] = '1';
> >> >>> -	else
> >> >>> -		buf[0] = '0';
> >> >>> -	buf[1] = '\n';
> >> >>> -	buf[2] = 0x00;
> >> >>> -	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
> >> >>> +	return disarm_all_kprobes();
> >> >>>  }
> >> >>>  
> >> >>> -static ssize_t write_enabled_file_bool(struct file *file,
> >> >>> -	       const char __user *user_buf, size_t count, loff_t *ppos)
> >> >>> +static int kprobes_enabled_get(void *data, u64 *val)
> >> >>>  {
> >> >>> -	bool enable;
> >> >>> -	int ret;
> >> >>> -
> >> >>> -	ret = kstrtobool_from_user(user_buf, count, &enable);
> >> >>> -	if (ret)
> >> >>> -		return ret;
> >> >>> -
> >> >>> -	ret = enable ? arm_all_kprobes() : disarm_all_kprobes();
> >> >>> -	if (ret)
> >> >>> -		return ret;
> >> >>> -
> >> >>> -	return count;
> >> >>> +	*val = !kprobes_all_disarmed;
> >> >>> +	return 0;
> >> >>>  }
> >> >>>  
> >> >>> -static const struct file_operations fops_kp = {
> >> >>> -	.read =         read_enabled_file_bool,
> >> >>> -	.write =        write_enabled_file_bool,
> >> >>> -	.llseek =	default_llseek,
> >> >>> -};
> >> >>> +DEFINE_DEBUGFS_ATTRIBUTE(fops_kp, kprobes_enabled_get,
> >> >>> +			 kprobes_enabled_set, "%llu\n");
> >> >>>  
> >> >>>  static int __init debugfs_kprobe_init(void)
> >> >>>  {
> >> >>> -- 
> >> >>> 2.47.3
> >> >>> 
> >> >>
> >> >>
> >> >>
> >> >
> >> >Thanks!
> >> 
> >> Thanks!
> >
> >
> >
> 
> Thanks!


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
