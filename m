Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D0B242D84;
	Tue, 30 Sep 2025 21:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759267637; cv=none; b=UTyBQi2UIGBl0lc2q4WgfkQJtKaIWoMirf5RUMxLPNFanvXgtlyhNu9vuEB1Jkcn5FjO1todrrkIHoPglq1EUfVVOHyZzKZ0TtvuqzKkhrIuIyz9riJth0oUIbNPBJTCd1GL3gmAgQ1DnCaX/x1Ms9WRH4WJxmwdmNNmO6E6bbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759267637; c=relaxed/simple;
	bh=mMUfzHN2HyNIMKXk45Ywxth4hNgq+z/fTFUOp2BaSDM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rja+LmtZMwpkrDVvs0eZg8mSkj4vj4jRGMhskFwNoKbWqWogPrmhv3hfeKzrza9cVynoZn6EafMcCBPCfF8a3MVSD791uGjsO0X4PtAKIB8knBN+Os4y+ZgEa18DEOxHWomw9VxIk1nCS7wM+b+BXHyvgzCg93TdrFm6c/JmOSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id BDAB05B893;
	Tue, 30 Sep 2025 21:27:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id F3D6420025;
	Tue, 30 Sep 2025 21:27:05 +0000 (UTC)
Date: Tue, 30 Sep 2025 17:28:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/osnoise: Replace kmalloc + copy_from_user
 with memdup_user
Message-ID: <20250930172841.63dc86b5@gandalf.local.home>
In-Reply-To: <20250925211736.81737-1-thorsten.blum@linux.dev>
References: <20250925211736.81737-1-thorsten.blum@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: jsxow6d5638k5yy6gar5fs134aayipcz
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: F3D6420025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/oDUrXoqCXdRNl+2WQvLrI0sL3RVE6m2Q=
X-HE-Tag: 1759267625-90581
X-HE-Meta: U2FsdGVkX19tNMzzii2Enil6Oh3uU3yu55Hwr638oUhBq1U72Bck8BQ3krzRNz6p4VLdOWbO5gOHBTaD2lO2UdunxtCR3rK59dZaUzzGXW8TAcLxwb3DIwGpvr2asXE/jCgno+O136q9kdfuqzZyLx3fzdU0BZKXUC5H39DXmJpazHs1BssPyn755VnQBIEu7B7fYZLMN9G3DONT1jjx5DQ8bhYytdPZGxacBzUOJuC/R22sAxLmeU0Mg72yxJGZ0q10yWgOHLrQLOw5vwjL3HreGeJW2soG3HdHqqVQ43H5X5OmJotJMCZmzVr5NI01

On Thu, 25 Sep 2025 23:17:36 +0200
Thorsten Blum <thorsten.blum@linux.dev> wrote:


>  #ifdef CONFIG_X86_LOCAL_APIC
> @@ -2325,12 +2326,9 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
>  	if (count < 1)
>  		return 0;
>  
> -	buf = kmalloc(count, GFP_KERNEL);
> -	if (!buf)
> -		return -ENOMEM;
> -
> -	if (copy_from_user(buf, ubuf, count))
> -		return -EFAULT;
> +	buf = memdup_user(ubuf, count);
> +	if (IS_ERR(buf))
> +		return PTR_ERR(buf);

After adding this to my for-next branch, it failed to merge with upstream.
That's because a bug was found that if user space did not have a '\0'
terminator, reading this as a string could cause the read to go off the
allocated buffer and crash the machine.

>  
>  	if (!zalloc_cpumask_var(&osnoise_cpumask_new, GFP_KERNEL))
>  		return -ENOMEM;

The above was changed to this:

	if (count < 1)
		return 0;

	buf = kmalloc(count + 1, GFP_KERNEL);
	if (!buf)
		return -ENOMEM;

	if (copy_from_user(buf, ubuf, count))
		return -EFAULT;
	buf[count] = '\0';

Which makes your change not quite compatible.

I'm going to rebase and remove your change for now.

-- Steve
