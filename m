Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310D6426EBB;
	Wed, 19 Aug 2026 08:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787128812; cv=none; b=V2gHa8z209ddZmlvakP9MhSUiwxdeN7en4n0IZcvL4XBbsg2aJXdI/wWaSMv3FbQaLlyATamqDPFknn1COu3RU/nhx2QYbJkdgcukNh9ICsJaQ7j24KCwkiR3xpQqT4NFu4THEmjG4Xv6vXCAMXVDE15+/dWdIz7BkHN1dtgV5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787128812; c=relaxed/simple;
	bh=5sp0ZOSizpx1rl/ZMRHYi+J59YozI/sLh2pAPtTDMEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4aRBnHiEECshcrAs+SmG+PNyYIoRpdTx0h96z/DOGBT0aLuGOB37/aT84u9p1sDaQKczCsHe+jVFTu5ezZ4jcIYJsd5hBRL/PVTtpU0vFqbFsSEE2YEUWWGA5o+k5vijkGdYqtTudvjIoFRz/sPgJonxUNC40aoE9gTzSXU6Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jx6NBQ/V; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jx6NBQ/V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=pyPevrNvwrpsc4GFG5zdT4e/PGot5Vg1pJ6/pkkmBV8=;
	b=jx6NBQ/VTYUnCUvk2RLB8yrr+LIb0Xur07jzlVYbsFOLtHdf713PmzkFi4rinn
	tMXQR846Xzk+2RzEyUSE34aQVkbfikVSix+0NchqGBhEx7VbBiakzVQDbXIIu4lv
	ZMhzKbkllD11haxlK6mXegdd4S+YtgyRHpRl94tjcIkqI=
Received: from [IPV6:2409:8900:1ef9:dee:d4ad:8b9c:ebb5:20bf] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wAn0eyya4VqSDunOw--.20480S2;
	Wed, 19 Aug 2026 16:39:15 +0800 (CST)
Message-ID: <69b2de59-f2cf-4c26-aa97-909117eabf15@163.com>
Date: Wed, 19 Aug 2026 16:39:14 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 v3 5/7] ntfs3: add allocation tracepoints
To: Steven Rostedt <rostedt@goodmis.org>
Cc: almaz.alexandrovich@paragon-software.com, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 ntfs3@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 liubaolin12138@gmail.com, Baolin Liu <liubaolin@kylinos.cn>
References: <20260807010354.2277156-1-liubaolin12138@163.com>
 <20260807010354.2277156-6-liubaolin12138@163.com>
 <20260811162127.5f98eadb@gandalf.local.home>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20260811162127.5f98eadb@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAn0eyya4VqSDunOw--.20480S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr48urW7WryfCr1DKFW8Crg_yoW5Gr1xpr
	ZxA3WSga1kJrWj9w1S9w1xAw4Fga409rWjkryY9rW2vrn2v3WxtFsFgrWUuayjvr4kXwn0
	qw1qvay3Ww1UZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRYYLQUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6RQEzmqFa7Q5xwAA35

Dear Steven,
    Thanks for your review. You are right, I will fix it as suggested in v4.


Thanks,
Baolin

在 2026/8/12 04:21, Steven Rostedt 写道:
> Also Sashiko had something to say about this patch: https://sashiko.dev/#/patchset/20260807010354.2277156-8-liubaolin12138%40163.com
> 
>> --- Patch [5]: [PATCH v3 v3 5/7] ntfs3: add allocation tracepoints ---
>> commit 0592c540bc564c346cb524c624f6ee4a5768406b
>> Author: Baolin Liu <liubaolin@kylinos.cn>
>>
>> ntfs3: add allocation tracepoints
>>
>> This commit adds trace events for ntfs3 allocation operations. It introduces
>> events for attr_allocate_clusters, attr_set_size_ex, and attr_data_get_block
>> to help observe cluster allocation, size changes, and block mapping activity.
>>
>>> diff --git a/include/trace/events/ntfs3.h b/include/trace/events/ntfs3.h
>>> index 4ac05ed29e49d..d16dd127ff2e5 100644
>>> --- a/include/trace/events/ntfs3.h
>>> +++ b/include/trace/events/ntfs3.h
>> [ ... ]
>>> +TRACE_EVENT(ntfs3_attr_set_size_ex,
>>> +	TP_PROTO(struct inode *inode, u32 type, u64 new_size, bool keep_prealloc,
>>> +		 bool no_da),
>>> +	TP_ARGS(inode, type, new_size, keep_prealloc, no_da),
>>> +	TP_STRUCT__entry(
>>> +		__field(loff_t, old_size)
>>> +		__field(u64, new_size)
>>> +		__field(unsigned long, ino)
>>> +		__field(dev_t, dev)
>>> +		__field(u32, type)
>>> +		__field(bool, keep_prealloc)
>>> +		__field(bool, no_da)
>>> +	),
>>> +	TP_fast_assign(
>>> +		__entry->old_size = i_size_read(inode);
>>
>> Will this actually record the previous size during truncate operations?
>>
>> When an application truncates a file, the VFS size is often updated before
>> calling into the filesystem. For instance, looking at how ntfs_setattr()
>> handles this:
>>
>> fs/ntfs3/file.c:ntfs_setattr() {
>>          ...
>>          truncate_setsize(inode, newsize);
>>          
>>          err = ntfs_set_size(inode, newsize);
>>          ...
>> }
>>
>> Since truncate_setsize() updates the VFS inode size before attr_set_size_ex()
>> and this tracepoint are reached, won't i_size_read(inode) just return the
>> newly truncated size, resulting in old_size equaling new_size?
>>
>> Could the actual old size be passed as an explicit parameter to the
>> tracepoint instead of sampling it here?
>>
>>> +		__entry->new_size = new_size;
>>> +		__entry->ino = inode->i_ino;
>>> +		__entry->dev = inode->i_sb->s_dev;
>>> +		__entry->type = type;
>>> +		__entry->keep_prealloc = keep_prealloc;
>>> +		__entry->no_da = no_da;
>>> +	),
>> [ ... ]
> 
> -- Steve

