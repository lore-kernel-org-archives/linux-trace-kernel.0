Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56D72E717B;
	Mon,  3 Aug 2026 01:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785721896; cv=none; b=pvb3SB1o1z5lxfX0wRdL4MIhHRHo0dOeSHVWINjJj3w//FLNsJ69eqS+fdgiwBOUS2wcxYKDWiNZWSswfNYiNVALgnfJQsGm9NALRKZlSlj9pWsnTScDBrf3cU28TxR2vDd5KalbCT31mjzONACrS2ILxnb14MAEmWEhwTUYRac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785721896; c=relaxed/simple;
	bh=9KRSe9v2lM5ZfdnJllQn1tQtTy50IrZNYP0cqrpTbV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JoO2WbDeLQE68pXQrIg7VqbpvaAwfrfSDdRyw99dLxhMJ3PwKGWKZobAXIzgyx3eIUetrQHhzefMUR7tjldG3AhakMr6iHa2VeyQRdsYqaIsH6mg0gOtkDvh8aoFJNqnNHhb442gtfZpZ59qRxvelFvfOqgFHi9iSMWO/zMX+Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MYaYIczQ; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MYaYIczQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=PbJC3Px+DglQjkUzry32ufdSX8YSNA4WkwOYuIElaYQ=;
	b=MYaYIczQS3sLTcJJOIkH8MCY8tmgZJaF68S+OYd2s2ZtuV1Ux7tV/0/MEuHbMk
	5Y0N+bN1EKQgco1rM/KTl8x0H0weku+esz5LigWyVhqnQvB0YLgPA9URTvlSGdgv
	Im+DNJVYL7i5uSBxSr/P+c+wzMHfQr0sDpSONCemTi85A=
Received: from [IPV6:2409:8900:1fc4:92f1:96e3:5113:7872:40a8] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDXRPPn829qOps5Jg--.34710S2;
	Mon, 03 Aug 2026 09:50:33 +0800 (CST)
Message-ID: <52e968d3-b691-44de-b860-6431e2001c11@163.com>
Date: Mon, 3 Aug 2026 09:50:30 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 v2 2/7] ntfs3: add namei tracepoints
To: Steven Rostedt <rostedt@goodmis.org>
Cc: almaz.alexandrovich@paragon-software.com, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 ntfs3@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 liubaolin12138@gmail.com, Baolin Liu <liubaolin@kylinos.cn>,
 liubaolin12138@163.com
References: <20260728094426.749482-1-liubaolin12138@163.com>
 <20260728094426.749482-3-liubaolin12138@163.com>
 <20260729142622.73d7ef18@gandalf.local.home>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20260729142622.73d7ef18@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDXRPPn829qOps5Jg--.34710S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF4DArWDXw1Dtry8ur48WFg_yoWrJr47pF
	4jy3W09a97Jr1UKwn5Z3Z3XF4rZr4v9r1UKFWa9342yrn2qFn7trZFgw1qva4UArsY9wnF
	qayav398uF45XFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JU_8n8UUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6gmteGpv8+n9xwAA3T

Dear Steve,
    Thank you for your review. I will carefully recheck and modify all 
patches according to your feedback, and submit the v3 version patch as 
soon as possible. Thank you again for your feedback.

Best regards,
Baolin

在 2026/7/30 02:26, Steven Rostedt 写道:
> On Tue, 28 Jul 2026 17:44:21 +0800
> Baolin Liu <liubaolin12138@163.com> wrote:
> 
>> diff --git a/include/trace/events/ntfs3.h b/include/trace/events/ntfs3.h
>> index d00f66e42ba8..041455edec76 100644
>> --- a/include/trace/events/ntfs3.h
>> +++ b/include/trace/events/ntfs3.h
>> @@ -80,6 +80,50 @@ TRACE_EVENT(ntfs3_log_replay,
>>   		  __entry->size, __entry->initialized, __entry->err)
>>   );
>>   
>> +TRACE_EVENT(ntfs3_lookup,
>> +	TP_PROTO(struct inode *dir, struct dentry *dentry),
>> +	TP_ARGS(dir, dentry),
>> +	TP_STRUCT__entry(
>> +		__field(dev_t, dev)
> 
> dev_t is 4 bytes, you should move it after parent_ino as on 64 bit
> machines, it will waste 4 bytes of space here.
> 
>> +		__field(unsigned long, parent_ino)
>> +		__string(name, dentry->d_name.name)
>> +	),
>> +	TP_fast_assign(
>> +		__entry->dev = dir->i_sb->s_dev;
>> +		__entry->parent_ino = dir->i_ino;
>> +		__assign_str(name);
>> +	),
>> +	TP_printk("dev=(%d,%d) parent=%lu name=%s",
>> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
>> +		  __entry->parent_ino, __get_str(name))
>> +);
>> +
>> +TRACE_EVENT(ntfs3_rename,
>> +	TP_PROTO(struct inode *dir, struct dentry *dentry,
>> +		 struct inode *new_dir, struct dentry *new_dentry),
>> +	TP_ARGS(dir, dentry, new_dir, new_dentry),
>> +	TP_STRUCT__entry(
>> +		__field(dev_t, dev)
> 
> Same here.
> 
> In fact, you should audit the rest of your tracepoints to see where you can
> make the sizes more condensed.
> 
> ~# cat /sys/kernel/tracing/events/ntfs3/ntfs3_rename/format
> name: ntfs3_rename
> ID: 1923
> format:
>          field:unsigned short common_type;       offset:0;       size:2; signed:0;
>          field:unsigned char common_flags;       offset:2;       size:1; signed:0;
>          field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
>          field:int common_pid;   offset:4;       size:4; signed:1;
> 
>          field:dev_t dev;        offset:8;       size:4; signed:0;
>          field:unsigned long dir_ino;    offset:16;      size:8; signed:0;
>          field:unsigned long new_dir_ino;        offset:24;      size:8; signed:0;
>          field:unsigned long ino;        offset:32;      size:8; signed:0;
>          field:__data_loc char[] old_name;       offset:40;      size:4; signed:0;
>          field:__data_loc char[] new_name;       offset:44;      size:4; signed:0;
> 
> 
> Notice that dev is at offset 8 and size 4, where as dir_ino is at offset
> 16. That means there's 4 bytes between dev and dir_ino.
> 
> Please look at your other trace events and see if there are other gaps you
> can close. I'm not going to audit all your tracepoints.
> 
> Note that __string() is a 4 byte meta data, so have them act like 4 byte
> fields.
> 
> -- Steve
> 
> 
> 
>> +		__field(unsigned long, dir_ino)
>> +		__field(unsigned long, new_dir_ino)
>> +		__field(unsigned long, ino)
>> +		__string(old_name, dentry->d_name.name)
>> +		__string(new_name, new_dentry->d_name.name)
>> +	),
>> +	TP_fast_assign(
>> +		__entry->dev = dir->i_sb->s_dev;
>> +		__entry->dir_ino = dir->i_ino;
>> +		__entry->new_dir_ino = new_dir->i_ino;
>> +		__entry->ino = d_inode(dentry)->i_ino;
>> +		__assign_str(old_name);
>> +		__assign_str(new_name);
>> +	),
>> +	TP_printk("dev=(%d,%d) dir=%lu new_dir=%lu ino=%lu old=%s new=%s",
>> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
>> +		  __entry->dir_ino, __entry->new_dir_ino, __entry->ino,
>> +		  __get_str(old_name), __get_str(new_name))
>> +);
>> +
>>   #endif /* _TRACE_NTFS3_H */
>>   

