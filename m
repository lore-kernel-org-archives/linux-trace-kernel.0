Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2163E7160;
	Thu, 23 Jul 2026 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784799082; cv=none; b=P3pcJjwj3+0Nq+WyNsluHoQlQk13NhqSjNCL2MYerTz9QXITVOSK8JDE2IY0A1CaA//ZN/XP6R3Gmww4OoEpZ8gq2GIIgngiUB027qC/4fEVbkV5y7LwyxJ7382V6w0GNMR7McyKCkqhSgqleDhWg2AkjYIz8Ca23te9IxrEsO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784799082; c=relaxed/simple;
	bh=3wF2GIKEwwPuUv65bAunVjhRzzgAOmMY9KHOdkd/TX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZKEbpBvT4FfL2MIJBCzgj/HwcY8M1RgS65piR1aSmbXWJjOVWsrW+c3si4caur21GkYMDnhR82L6DmE5plYsQH07Nm79nNFeSldMG4Rho92XBuz1JmZjSrDgM6upuhqhOwLyPyUl1k9TxTPZSukiiM3rbZBU3TsZ8E+Oqr7XZck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nvM17/PJ; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nvM17/PJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=pQbtYu93HgzvAOkimpaqcjShK9zGePFCFy0Jr7kZ8yk=;
	b=nvM17/PJSYinGkKEKaVwPYHFHDJNcvnpaI8xaB+FU4Im1DV2hM851ttDfnCPwW
	ULAa0LlXjgKtYZzWc+aXSBAtE8fdGUG44PIBkU8ENJVg3uC1/bM47ds2GkQsWKU/
	Z9g30ZW1+KFITZ3Q4kOjdPu2LXjwKv9yBulcK4Ey58Xk0=
Received: from [IPV6:2409:8900:1ee3:1304:86b9:38f0:10e1:f1dc] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wCncGc632FqLxgOKw--.29997S2;
	Thu, 23 Jul 2026 17:30:36 +0800 (CST)
Message-ID: <a36a7376-d750-4f07-a626-e916fe77ff77@163.com>
Date: Thu, 23 Jul 2026 17:30:33 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 v1 2/7] ntfs3: add namei tracepoints
To: Steven Rostedt <rostedt@goodmis.org>
Cc: almaz.alexandrovich@paragon-software.com, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 ntfs3@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 liubaolin12138@gmail.com, Baolin Liu <liubaolin@kylinos.cn>,
 liubaolin12138@163.com
References: <20260717032248.3318208-1-liubaolin12138@163.com>
 <20260717032248.3318208-3-liubaolin12138@163.com>
 <20260721170952.26f79352@gandalf.local.home>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20260721170952.26f79352@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCncGc632FqLxgOKw--.29997S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WryrGrykAFWkXw1fuF4kWFg_yoW8Jry8pF
	1qyFW0ga97Jr40kw4Fvws5ta1Sv39Ygr15Kry7Wa48Crsavr1Dtrs2grsFv34rAws09w1f
	XFWjv3sYgw15Ja7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JU_8n8UUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbCwRz5xGph3zxuVgAA3w

Dear Steve,
    dentry->d_name.len is the qstr length and does not include the 
trailing NUL, so it corresponds to strlen(dentry->d_name.name), rather 
than strlen(dentry->d_name.name) + 1.
If you think the extra name_len field here is unnecessary, I can submit 
a v2 patch to drop it. Looking forward to your feedback.

Best regards,
Baolin


在 2026/7/22 05:09, Steven Rostedt 写道:
> On Fri, 17 Jul 2026 11:22:43 +0800
> Baolin Liu <liubaolin12138@163.com> wrote:
> 
>> +TRACE_EVENT(ntfs3_lookup,
>> +	TP_PROTO(struct inode *dir, struct dentry *dentry),
>> +	TP_ARGS(dir, dentry),
>> +	TP_STRUCT__entry(
>> +		__field(dev_t, dev)
>> +		__field(unsigned long, parent_ino)
>> +		__string(name, dentry->d_name.name)
>> +		__field(unsigned int, name_len)
>> +	),
>> +	TP_fast_assign(
>> +		__entry->dev = dir->i_sb->s_dev;
>> +		__entry->parent_ino = dir->i_ino;
>> +		__assign_str(name);
>> +		__entry->name_len = dentry->d_name.len;
> 
> Is dentry->d_name.len not equal to strlen(dentry->d_name.name) + 1 ?
> 
> -- Steve
> 
> 
>> +	),
>> +	TP_printk("dev=(%d,%d) parent=%lu name=%s len=%u",
>> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
>> +		  __entry->parent_ino, __get_str(name),
>> +		  __entry->name_len)
>> +);

