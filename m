Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9284F2B9DD;
	Wed,  4 Sep 2024 02:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725415455; cv=none; b=qal3qFqa12pXj69FnFpUDUGUN9eV77R930VqM6RX128GihGN6bRY8HhqAx/McwiS7jfeCFVuM6VAo8KGyrG3nU5GYf2U7ZFFD5rudHy8LD3nVjeK9hiBu/9RtHu2IHaFJ64fb3ZEZExBD+7wTppuXLkHfrTo5C8EW1koQp7FkMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725415455; c=relaxed/simple;
	bh=mOLo7uxc+zyKUKVPqtsesBtnTvOj1TgvWFgKIaXT7kI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rKu3gxRg7GIb2CuIdZxyckE8wlv0h7SoxOJIPfgWRci0cTA+0F2t2AoHlDd5ws5odsT4mIVwnueeLghHresyGmBnGhp2PzVVp+0UZaVXZyDhX+9HUWlpw7tSEO0y8qaqp1+PNlaTtj84+sAXvMFFdyA334NTF/A79VoMMFrWm4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fq9OG0g4; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fq9OG0g4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=R4ZezYIoiZAjq1PpNIuq4c3s3VGGQxCxeXQeazgl4sw=;
	b=fq9OG0g4gPC8pbhz0VCTaojvpXSkOSWu4/030A8JIQ9FKps4CAi/NDFu1inK5w
	cxUeXun3jxkUmcRgy/emuaNSKOIKK4kSvFf4fErMt3+aq/3ya2gPDW2W/OZaozqn
	aewVTFR3aq0m+fED2/GFX8KRTIF6tVBZPM1J/L8xSbnf4=
Received: from [10.42.116.6] (unknown [111.48.58.10])
	by gzsmtp3 (Coremail) with SMTP id sigvCgDn1+Wiv9dmPPcjAw--.49606S2;
	Wed, 04 Sep 2024 10:02:12 +0800 (CST)
Message-ID: <9b0ff6b4-560f-ae7c-25e8-de349a089761@163.com>
Date: Wed, 4 Sep 2024 10:02:09 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] eventfs: fix a null pointer access in eventfs_iterate
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chi Zhiling <chizhiling@kylinos.cn>
References: <20240829032436.2997321-1-chizhiling@163.com>
 <20240903155128.5e02e40a@gandalf.local.home>
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <20240903155128.5e02e40a@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:sigvCgDn1+Wiv9dmPPcjAw--.49606S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFWUuF15KFW7Gw43CFy7Awb_yoW5XrWrpr
	Z7JF9xKw4xJw4I9F9av3Wqgr1Fqwn2gF4DGF1fCw1xJ398ZrnrKF9rtF4UWrWSyrW8Aayj
	qa10ka1UC3yjqFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UI2NNUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbBaxBPnWV4IHkN8wABsS


On 2024/9/4 03:51, Steven Rostedt wrote:
> On Thu, 29 Aug 2024 11:24:36 +0800
> Chi Zhiling <chizhiling@163.com> wrote:
>
>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>
>> We found a null pointer accessing in tracefs[1], the reason is that
>> the variable 'ei_child' is set to LIST_POISON1, that means the list
>> was removed in eventfs_remove_rec. so when access the ei_child->is_freed,
>> the panic triggered.
>>
>> the linked list is protected by eventfs_mutex in eventfs_remove_rec,
> Only writes of the link list is protected by the mutex. Reads are not.
>
>> so when we access the list of ei_child in eventfs_iterate, we also need
>> a mutex_lock in there to avoid eventfs_remove_rec modify the list.
> Yes you hit a bug, but no this is *not* the solution!
>
>
>> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
>> ---
>>   fs/tracefs/event_inode.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
>> index 01e99e98457d..4895ed07376b 100644
>> --- a/fs/tracefs/event_inode.c
>> +++ b/fs/tracefs/event_inode.c
>> @@ -642,6 +642,7 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
>>   	/* Subtract the skipped entries above */
>>   	c -= min((unsigned int)c, (unsigned int)ei->nr_entries);
>>   
>> +	mutex_unlock(&eventfs_mutex);
> This list is protected by SRCU (hence the name of the iterator), if you
> need to add a mutex around it, something else is broken.
>
>>   	list_for_each_entry_srcu(ei_child, &ei->children, list,
>>   				 srcu_read_lock_held(&eventfs_srcu)) {
>>   
>> @@ -659,9 +660,12 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
>>   
>>   		ino = eventfs_dir_ino(ei_child);
>>   
>> -		if (!dir_emit(ctx, name, strlen(name), ino, DT_DIR))
>> +		if (!dir_emit(ctx, name, strlen(name), ino, DT_DIR)) {
>> +			mutex_unlock(&eventfs_mutex);
>>   			goto out_dec;
>> +		}
>>   	}
>> +	mutex_unlock(&eventfs_mutex);
>>   	ret = 1;
>>    out:
>>   	srcu_read_unlock(&eventfs_srcu, idx);
> The real fix is:
>
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 01e99e98457d..8705c77a9e75 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -862,7 +862,7 @@ static void eventfs_remove_rec(struct eventfs_inode *ei, int level)
>   	list_for_each_entry(ei_child, &ei->children, list)
>   		eventfs_remove_rec(ei_child, level + 1);
>   
> -	list_del(&ei->list);
> +	list_del_rcu(&ei->list);
>   	free_ei(ei);
>   }
>   
> Can you test that and let me know if it fixes your issue. I'll just go
> ahead and apply it as it is an obvious bug.
>
Okay, I've tested it and I haven't seen any errors.

