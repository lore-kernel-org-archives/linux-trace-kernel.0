Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED66309EFC;
	Tue, 18 Aug 2026 22:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787093547; cv=none; b=IP/c2P9HHqa1+jC6UICt5IDGxcC6V9JTg4vE2bXDPhns1mIVWrjPHP4HLbO5Ahlqr34B81hc/p9WE1Fmbsb68WCJDYVr63Nsf1TLs5Ucp/SlFKaIML589neSJJtmaXhZGxkbdcC3hBNc01Mt4oiqSoBke/BOjdeUPzKUzw58vBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787093547; c=relaxed/simple;
	bh=z+Pg69X5kzndENcjRkyUsY4zMp68qmY07qCbm8JeyRc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FkKe8jdjhjmN2aC9EbeyvQJFygEnG+CrM7dA+0+cuFVEqZuDbqVD/OO2gelIenKEeskKAGGH0zddRggvOuZI48qIuQ5U342orYyr6Lt7uCcXVtbF6MUA76JbgkOXEjbpsgjqsz4vvWXu1uzv1Bin6Ov/OSkAZBqPh37uiXBhfZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b601v3Q1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b601v3Q1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DA71F000E9;
	Tue, 18 Aug 2026 22:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787093545;
	bh=Tr+DjgK7lF3lFwRjR19bOkQeerNhcsN0D8r3FOefsIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b601v3Q1b2EQDyM3zY/J+fgai+mCtGCzjbjIWPtxi5CDqx2eZm9VFhewg2FJ48YPM
	 LWYx7eJM9XbiiMwzBjZJ0F2UaILnyhN+6uXWA6U3A0wdslyh5GH2jlVz4WG95OFdka
	 RwgzCqjUXxCQ4BDUxipZUEeO5GycpI5FCWQYQsHPllhHJt7iLaoM9iPRtsWhAZCwyE
	 vxRfIO8aBMl4jw329AdgPYMagDwP9AiEO2V4QB9aKSmpzAroNmto/+k3sPyue34wNU
	 qlRufYf9ACXISKHBEaTdblFWgkApiwqMgq/jrQ7Bv5fkop786ly0UrjTpJdGs5jVAo
	 scx2rUXstmWxA==
Date: Wed, 19 Aug 2026 07:52:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Bradley Morgan <include@grrlz.net>
Cc: Naveen N Rao <naveen@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: use DEFINE_DEBUGFS_ATTRIBUTE for the enabled
 knob
Message-Id: <20260819075221.18e9abdaab49d39f362ee0dc@kernel.org>
In-Reply-To: <20260818014920.23870-1-include@grrlz.net>
References: <20260818014920.23870-1-include@grrlz.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Aug 2026 01:49:20 +0000
Bradley Morgan <include@grrlz.net> wrote:

> This enabled knob is a disgusting terrible hack. It has rolled its
> own read/write pair since 2007, writing '1' or '0' into a three byte
> buffer by hand just to print a single character, with an XXX comment
> begging debugfs for write callbacks on bool files.
> DEFINE_DEBUGFS_ATTRIBUTE showed up in 2016 and does exactly that, so
> the disgusting terrible hack has outlived its excuse for nine years.
> Kill it, and the stale comment with it.

Hm, OK, but please calm down. Just describe the technical reason here.

> 
> The behavior does not change, except the write only accepts 0/1 now
> instead of y/n/on/off, and nothing uses anything else.

I think this comment is needed.

Please add Signed-off-by.

The code looks good to me.

Thanks,

> ---
>  kernel/kprobes.c | 43 +++++++++----------------------------------
>  1 file changed, 9 insertions(+), 34 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index bfc89083daa9..044c6b5fd2aa 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -3013,47 +3013,22 @@ static int disarm_all_kprobes(void)
>  	return ret;
>  }
>  
> -/*
> - * XXX: The debugfs bool file interface doesn't allow for callbacks
> - * when the bool state is switched. We can reuse that facility when
> - * available
> - */
> -static ssize_t read_enabled_file_bool(struct file *file,
> -	       char __user *user_buf, size_t count, loff_t *ppos)
> +static int kprobes_enabled_set(void *data, u64 val)
>  {
> -	char buf[3];
> +	if (val)
> +		return arm_all_kprobes();
>  
> -	if (!kprobes_all_disarmed)
> -		buf[0] = '1';
> -	else
> -		buf[0] = '0';
> -	buf[1] = '\n';
> -	buf[2] = 0x00;
> -	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
> +	return disarm_all_kprobes();
>  }
>  
> -static ssize_t write_enabled_file_bool(struct file *file,
> -	       const char __user *user_buf, size_t count, loff_t *ppos)
> +static int kprobes_enabled_get(void *data, u64 *val)
>  {
> -	bool enable;
> -	int ret;
> -
> -	ret = kstrtobool_from_user(user_buf, count, &enable);
> -	if (ret)
> -		return ret;
> -
> -	ret = enable ? arm_all_kprobes() : disarm_all_kprobes();
> -	if (ret)
> -		return ret;
> -
> -	return count;
> +	*val = !kprobes_all_disarmed;
> +	return 0;
>  }
>  
> -static const struct file_operations fops_kp = {
> -	.read =         read_enabled_file_bool,
> -	.write =        write_enabled_file_bool,
> -	.llseek =	default_llseek,
> -};
> +DEFINE_DEBUGFS_ATTRIBUTE(fops_kp, kprobes_enabled_get,
> +			 kprobes_enabled_set, "%llu\n");
>  
>  static int __init debugfs_kprobe_init(void)
>  {
> -- 
> 2.47.3
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
