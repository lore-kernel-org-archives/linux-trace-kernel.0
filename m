Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D663C196DA2
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590614; cv=none; b=C6ilkCMgOFQuwXYwXPEKH9Ns5HtSjI6vAOrXvXfmmsXfxR9YajTYG8PZCB7s9V22O7cLQb74vwT2O3/kQJXV75jMMAix7RaqZMhRtvWdziluYH20wTA/+YPt8tZmZUYaCaJOnKxpbB8Wjkl5bGYLA4U5ELXoNkZbJ8YFi73G4UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590614; c=relaxed/simple;
	bh=dkg8331t8LxpNGCdxPCOB732ygnUsv+AQW0it3BPDd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oj4/PIPDeuuLlR2TLoK1jcXCy8ibh4dYZWN58ekzk9z8OJnAapgCV58cNInZlvJtjL6PuU6mtz0Kxy5rNhL2a6B4meoYjd5+kc/cQbrP04800z2UtOq8H6OOweQNdjKUK6M9izby0GLLmpcEancygkYpyD1mtMe8nKlz884KZ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IvVS7Nuy; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IvVS7Nuy"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cb72918bddso2150352a12.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Oct 2024 02:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729590610; x=1730195410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GuEtkiKrWTPUPMX7DUf6yDaOYLap9WgquDZggw/uRXI=;
        b=IvVS7NuyVKVz5NLkjhX05d4qSVzZQQMQgTU/EFb9Kk2V8Ia+SJHCu5mqBp3YA9e4Wc
         mFm+fNlJrVHzyfPY7m2FkGTouQFcDDekgczC3WZu8Of7Oz9bbBJIFovmCQ03y8CmdeZx
         5NpIALe1XdPy7nPW1VXFBkHVoAv7Zn7Z6JDuAQOx/oWd/5FOXIyhvEM0v5hSEUw4HTOr
         J5CNBI6YiPaR8cL2EgeFAknwxeUEfA83PsmLqQW29Wqsz4/aBLj0yafngKB+ZzyGp/V0
         2n0lB1NPyK8jgXig3hsUa663erjJ7BRiGzdBAkuzTAZCEX/rT4Zcv/ObNnR8b8u/Z2ru
         hEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729590610; x=1730195410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GuEtkiKrWTPUPMX7DUf6yDaOYLap9WgquDZggw/uRXI=;
        b=unlo0vvwb1KQVLUQtS0j5zOcVMKW1ka4BHO64Ja7Tv+5A5hiyA0lStoauDBhL5LbQO
         4a4duj+d9TOBor3eITJwYmezzrM9AebHExama4o1O6jVy8PKuRYlnHtKqx6ReK7k8ILJ
         yk7Rpe6eXMuKW+/m1D5bLkm9Ur5UIis1xdiWRXENwR6lSSz/h/VvjVX2uk+b8OO0RB6h
         tnkekwtz9AezVRqWa3DoSrhdkKQka5bg7ogviS69GZtIFaub+DKILuSwa0aetVIWF6CM
         1X5u5tnkIuYK2v3bvXebPus702UaJiabPGxGEsOTwb4q6a0UcIurYN+wUy94xTjq3xb8
         sgyQ==
X-Gm-Message-State: AOJu0YwIcWILH5fYlqJNPcO4UQD5jTolANqTZfi07sg6JJzwnOLTXKcN
	UgRyabnAFdKg4D+uQMI9U6J3ESZ3neDOibwvoJC2ih/oypOKnmG77wTfCBC9d090rHpgpv/JO+Y
	Q
X-Google-Smtp-Source: AGHT+IFqkw6hYudDWT0n79eevXlzc/mIXkiPKeu6FoSZDKy0FN+X4s8oixI6Rz+UzhvDt9/kRj/Vug==
X-Received: by 2002:a17:906:f59f:b0:a99:f4c3:580d with SMTP id a640c23a62f3a-a9aad21a920mr224925066b.42.1729590609946;
        Tue, 22 Oct 2024 02:50:09 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a915993basm313815866b.203.2024.10.22.02.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 02:50:09 -0700 (PDT)
Message-ID: <5eb3d33e-b238-4023-8c1b-2b24c0d5d923@suse.com>
Date: Tue, 22 Oct 2024 11:50:08 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] ring-buffer: Limit time with disabled interrupts in
 rb_check_pages()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-trace-kernel@vger.kernel.org
References: <d51fd42f-9fc7-4b0b-aae3-ee8bfd909d69@stanley.mountain>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <d51fd42f-9fc7-4b0b-aae3-ee8bfd909d69@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/24 11:09, Dan Carpenter wrote:
> Hello Petr Pavlu,
> 
> Commit 1f1c2bc9d075 ("ring-buffer: Limit time with disabled
> interrupts in rb_check_pages()") from Jul 15, 2024 (linux-next),
> leads to the following Smatch static checker warning:
> 
> 	kernel/trace/ring_buffer.c:1540 rb_check_pages()
> 	warn: ignoring unreachable code.
> 
> kernel/trace/ring_buffer.c
>     1501 static void rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
>     1502 {
>     1503         struct list_head *head, *tmp;
>     1504         unsigned long buffer_cnt;
>     1505         unsigned long flags;
>     1506         int nr_loops = 0;
>     1507 
>     1508         /*
>     1509          * Walk the linked list underpinning the ring buffer and validate all
>     1510          * its next and prev links.
>     1511          *
>     1512          * The check acquires the reader_lock to avoid concurrent processing
>     1513          * with code that could be modifying the list. However, the lock cannot
>     1514          * be held for the entire duration of the walk, as this would make the
>     1515          * time when interrupts are disabled non-deterministic, dependent on the
>     1516          * ring buffer size. Therefore, the code releases and re-acquires the
>     1517          * lock after checking each page. The ring_buffer_per_cpu.cnt variable
>     1518          * is then used to detect if the list was modified while the lock was
>     1519          * not held, in which case the check needs to be restarted.
>     1520          *
>     1521          * The code attempts to perform the check at most three times before
>     1522          * giving up. This is acceptable because this is only a self-validation
>     1523          * to detect problems early on. In practice, the list modification
>     1524          * operations are fairly spaced, and so this check typically succeeds at
>     1525          * most on the second try.
>     1526          */
>     1527 again:
>     1528         if (++nr_loops > 3)
>     1529                 return;
>     1530 
>     1531         raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
>     1532         head = rb_list_head(cpu_buffer->pages);
>     1533         if (!rb_check_links(cpu_buffer, head))
>     1534                 goto out_locked;
>     1535         buffer_cnt = cpu_buffer->cnt;
>     1536         tmp = head;
>     1537         raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
>     1538                 return;
>                          ^^^^^^
> You probably intended to delete this return?

There was a problem with rebasing the patch, see
https://lore.kernel.org/oe-kbuild-all/20241019110743.72fa5f29@gandalf.local.home/

It has been fixed in ftrace/for-next.

-- 
Thanks,
Petr
