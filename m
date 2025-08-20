Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AA727280B;
	Wed, 20 Aug 2025 08:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678896; cv=none; b=TEJ6Tol3ZtIwigmel2hjcIgt93FyYFHlPj70JP9oXeXP8sgwqJkB7ANmM2CvpucihGjxmenoE2/lvPJOX5pgWIutTe+wk8NJEe3XMaZZx8+jJpjc3Pc4/lM5xnjtFg+onXSQjGKfC1Lddrxk3qDGT4nwlRyutHpPVkhW7cOHMY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678896; c=relaxed/simple;
	bh=PDzWpGekjg3I5j8s5iVqM3/yznjCATGcph6FgJxmSxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rkjghywl/KE4iqbZzHpxIoJ+AUOtoVM25aG0vVuodgsUjNoTyGv6pDMkms3V/HTIKh3GWt62/k5rNOU5bpsrfQJiDYkKu5xW8Q15ayeRfDPiJs8AHPb+QpZwjExzBncYKq8kgqIGCQ59hsr0yQQAqZvL1fFEXMEjepwG0u1kGXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c6KWb0k8czYQvFp;
	Wed, 20 Aug 2025 16:34:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id A9F941A1C4E;
	Wed, 20 Aug 2025 16:34:49 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with SMTP id _Ch0CgD3u9amiKVou6_pEA--.53613S2;
	Wed, 20 Aug 2025 16:34:47 +0800 (CST)
Message-ID: <354f6b41-83d1-4496-aec8-764c205990e1@huaweicloud.com>
Date: Wed, 20 Aug 2025 16:34:46 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 2/2] ftrace: Fix potential use-after-free for
 set_ftrace_{notrace,filter} files
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250813023044.2121943-1-wutengda@huaweicloud.com>
 <20250813023044.2121943-3-wutengda@huaweicloud.com>
 <20250819210538.29ae29cb@gandalf.local.home>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20250819210538.29ae29cb@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgD3u9amiKVou6_pEA--.53613S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1kXF4UJr4rGF1fJFy7Wrg_yoW5Zr1xpF
	Waqr4DKr1kCFsYywnFgr10k34UCw4FyFy8GF1kJ34fZr9xXr1a93yIvrWrWr4DKr97XrWa
	vr42vw1qk34UZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7IJmUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2025/8/20 9:05, Steven Rostedt wrote:
> On Wed, 13 Aug 2025 02:30:44 +0000
> Tengda Wu <wutengda@huaweicloud.com> wrote:
> 
> 
>> Since the reader's hash is always tied to its file descriptor (fd),
>> the writer cannot directly manage the reader's hash. To fix this,
>> introduce a refcount for ftrace_hash, initialized to 1. The count
>> is incremented only when a reader opens it, and decremented when
>> either a reader or writer releases it, thereby controlling the timing
>> of ftrace_hash deallocation.
> 
> Hmm, I think the code that the first patch touches is the issue here too.
> 
> Instead of doing all these extra hacks, we should simply copy the hash for
> read too.
> 
> That is, the real fix for both patches is this:
> 
> -- Steve
> 
> From: Steven Rostedt <rostedt@goodmis.org>
> Subject: [PATCH] ftrace: Also allocate hash for reading of filter files
> 
> Currently the reader of set_ftrace_filter and set_ftrace_notrace just adds
> the pointer to the global tracer hash to its iterator. Unlike the writer
> that allocates a copy of the hash, the reader keeps the pointer to the
> filter hashes. This is problematic because this pointer is static across
> function calls that release the locks that can update the global tracer
> hashes. This can cause UAF and similar bugs.
> 
> Allocate the hash for reading the filter files like it is done for the
> writers. This not only fixes UAF bugs, but also makes the code a bit
> simpler as it doesn't have to differentiate when to free the iterator's
> hash between writers and readers.

Agreed. That is a much cleaner solution. I just tested this code and it
worked perfectly. Looking forward to getting it into the mainline soon.

-- Tengda

> 
> Cc: stable@vger.kernel.org
> Fixes: c20489dad156 ("ftrace: Assign iter->hash to filter or notrace hashes on seq read")
> Closes: https://lore.kernel.org/all/20250813023044.2121943-1-wutengda@huaweicloud.com/
> Reported-by: Tengda Wu <wutengda@huaweicloud.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ftrace.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 00b76d450a89..f992a5eb878e 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -4661,13 +4661,14 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
>  	        } else {
>  			iter->hash = alloc_and_copy_ftrace_hash(size_bits, hash);
>  		}
> +	} else {
> +		iter->hash = alloc_and_copy_ftrace_hash(hash->size_bits, hash);
> +	}
>  
> -		if (!iter->hash) {
> -			trace_parser_put(&iter->parser);
> -			goto out_unlock;
> -		}
> -	} else
> -		iter->hash = hash;
> +	if (!iter->hash) {
> +		trace_parser_put(&iter->parser);
> +		goto out_unlock;
> +	}
>  
>  	ret = 0;
>  
> @@ -6543,9 +6544,6 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
>  		ftrace_hash_move_and_update_ops(iter->ops, orig_hash,
>  						      iter->hash, filter_hash);
>  		mutex_unlock(&ftrace_lock);
> -	} else {
> -		/* For read only, the hash is the ops hash */
> -		iter->hash = NULL;
>  	}
>  
>  	mutex_unlock(&iter->ops->func_hash->regex_lock);

