Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F246731327A;
	Tue, 18 Aug 2026 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787094499; cv=none; b=R/diqqy5rFLWzHXsLbgZX4fw1+7nJ1C+H0fjwVNICOL14175VZRvOjqeUx/rKi7bzC40qE1PyOWsF/7HfPkFAkGcQH3uNJE5ziu2+9VUjy/V5aFWqNPKqIONfDobDgE3Ij0TG168ANL+IwxwAfkAMickP9IWGwCpEZZAziQQloA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787094499; c=relaxed/simple;
	bh=I0o7jgGqUArAoL8PV8DAwsVh/ZbPd6qFZDJ2H5HtaU0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bCH2Sfbe2XTPBKh6pAwuWqk28JXQR6ZPyvsrvRc3ns51dl5lsW3WPYAiQl9YAjjabDrV+QABMlqSiDt9zlVJR2GVNSOmlYLF0N1DweeAQu1fJ+GKQdxHNenM+AqheOjmafxH9nacN4gmI9iDjUIaPnxLqoRNDnHs7Z2KdHsKldw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+wCZoz6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+wCZoz6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467C11F000E9;
	Tue, 18 Aug 2026 23:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787094497;
	bh=VfKx5DNr0pE+W+fY6zLxse/TAnLY9w43ytpE/LA6q9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=B+wCZoz6pt4hWNcT1/YJtawUyXBFIl9X3myOoYFzbM05XJPy+AFNxHxWc9M8x9hXg
	 uFfYQdMkUlK0qBvfne17GI+sbGARm5hmCrlSAmvEnFoZcV8Zad3alQ/0C9HW/atOmS
	 gvPBjKW08PV/e4zP7p8uIRlhQyU3gRgL1PNbfgheUx6nyZfGa8AjaB6mcBoloK9tWO
	 Cj3qkNrhrKm5TtfTQdPjeaoMn614uQCoEjdnndVXocNlijIpz+/dtWZlw2ya7CFf66
	 WU9Ndc4BuoOvtELrI5dVsXEpcsRD1rflu2FdOOvcf6Glb4IEGjKhZN1uN6+M/FbsxY
	 XRpfgpjc/xuug==
Date: Wed, 19 Aug 2026 08:08:13 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Bradley Morgan <include@grrlz.net>
Cc: Naveen N Rao <naveen@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kprobes: use DEFINE_DEBUGFS_ATTRIBUTE for the
 enabled knob
Message-Id: <20260819080813.d66950e37e660e018dfb19e9@kernel.org>
In-Reply-To: <20260818015318.24103-1-include@grrlz.net>
References: <20260818015318.24103-1-include@grrlz.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Aug 2026 01:53:18 +0000
Bradley Morgan <include@grrlz.net> wrote:

> This enabled knob is a disgusting terrible hack. It has rolled its
> own read/write pair since 2007, writing '1' or '0' into a three byte
> buffer by hand just to print a single character, with an XXX comment
> begging debugfs for write callbacks on bool files.
> DEFINE_DEBUGFS_ATTRIBUTE showed up in 2016 and does exactly that, so
> the disgusting terrible hack has outlived its excuse for nine years.
> Kill it, and the stale comment with it.

In other words, does this mean something like the following?

This "enable" knob implemented custom read/write logic, manually writing
"1" or "0" to a 3-byte buffer solely to output a single character. As
suggested by comments calling for `debugfs` to support write callbacks
for boolean files, using `DEFINE_DEBUGFS_ATTRIBUTE` eliminates the need
for these callbacks.

Thanks,

> 
> The behavior does not change, except the write only accepts 0/1 now
> instead of y/n/on/off, and nothing uses anything else.
> 
> Signed-off-by: Bradley Morgan <include@grrlz.net>
> ---
> Changes since v1:
>  - Added the missing Signed-off-by, sorry.
> 
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
