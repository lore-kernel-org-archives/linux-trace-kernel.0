Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793068885;
	b=z18C1RA+g48UdXO0D5Wvm/EVVVckY2FIg51Hpt/Uk3WSIotyFc6Th7ez3EjeE2oyv+BR
	 fmZOuY9Z/R/2gxcGG7W3++jn63AyiBsPrA3hbsAZDkW9xG5+EEHlBjK93axuoeIq/FjOk
	 dwOrHbnkz2Aab8jNCglWl+s3WuWWo8NaQPQ79rs+JGPp2Wqc8uRjphjHrUTv4h4+0yxri
	 eP17/FNySikGufsjoW5zAg2Uf6Kwhc1/GhBK4jg4OgmqVCZcA+ggw1R7VZkML9JTr6rtd
	 xe1uv6drcZ9dH+MPIK3alrz83r3a2+/rCzClwRda3kapuHMj7ewQiiOYxhKX27ARwtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793068885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
	b=sPT/rSXIkPflUp4HHk3BvK+Hqo46nwTUsUmlW7LuZjadeE/PgMlYSdIcpCJYKG6xSg/g
	 SrNcNN7EsW7pyje0tOYgJyUItVqg6WgFB2T0UMyGdiENTCCQdTtHAXA0NTB0w3GWX5Q1J
	 /E7atV89LvZFjayA8ejX/xAHkDhCIXXdyAqpABwJD56G3Rh8OFyNXYUBfUd1cMq7A0vHw
	 lUdYWo3zCiIvYFRHYrRIZbWi/+NTVQHqbjvn7LRkfLH9cOXvgVz5XUqcRpvmCRbbId52c
	 dWkhz8GkbWYGMxEfkgB/St/HM1ShLzmqP8bGEyYpHB6OPtidLpz0fA/khSLfk5CqTnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=oc6cZqFa;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1BA606A31B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Oct 2026 02:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C1BA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=oc6cZqFa
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-185fd3a4ca3so3125916c88.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 19:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1793068884; x=1793673684; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=oc6cZqFau/HqROtNMBTq8ZP3TLLLzMKPOdbVxFYEww/DOpOMHzAfKhTORNvN4KTBkp
         LUp5Moi9eFCEYu5/4XDZT8WcjpiPsCN+0zUGPUekQp2yZJY0zBe8yl4kYAkKqjEdTrbQ
         qqNSykJeEwW7qBFZEoQS1rQ+7ZwY381+e8TxKyiv+Q5rLJiCFF4PtyVkTxWHTKQMc6vO
         +lb3qFo71UgGSSnv6IseZ7y8wLhEFz6jBXh4HUpywe8jgXN4FoqKQy7CyAzCO9Yfeytz
         HBIYtHcP3MQ7eijYy79F5eSeZqsN4/+XnIDB6Cna6QVY5R0NQaf50jlOwAuklcgL/mVV
         dVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793068884; x=1793673684;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=bn+1LLOGPzEKIPo4cVRw/F7STnbXn6VJmUzdDzClbkGM36rTFx/b6e/B/p3uZ8zu67
         72jVCRrOEsqoeCJdHCBzy7b61A1CzaTkd9JlS9nAIUEavsqoO8rKYJZbtNXw0p32nDZ9
         QBCfXRvuZpaeubeTLTjroPtsei78MN8qiZuQXJTVqy/Ih9hyaega/SWXFijHGRTDrz6j
         ue5Segm/jppBD8PRBVxvOkB7fJuqeBymNTp5WERausCUFYQtl8St9zLtnVNd7PpWcBiR
         f2RgjiaJpaaTqRKCkovt7uCSzfS3ntPnPsjtXZN04iVyWwqe9GuUELRgoMr36jhJnjaz
         1HMA==
X-Forwarded-Encrypted: i=1; AKwUvBzR8JJa+FMCg28pW6LhzRvxcVR4aYuU4eC1CYzIhb3LpFRA/ju0VeAR+/Q+F584nYTgIvVMWSnkmcx2yDekVSEnujA=@vger.kernel.org
X-Gm-Message-State: AFq9FYILTTroUtwSu18PHqEmZUokE4GQ2wKV56O7puM1Y2gQ29zcrbtW
	dj4Y847c6j/EGm6/eWc79b80Pxb0NzRJ/mY0gMXojrfJgbj4/qGKrTcKQabVH7blZck=
X-Gm-Gg: AYBFou1y5uxA1yrGV/HVOCuzKZZY9gCrT0VVD+6kOB98mS9Ut8EWa2pS7mE2myiA332
	mDowmuynLELbKFn5B6HkHfJRfahrebNra8j4EY+AmqTJ6fhwiN2CebRgV4syumQ6wOVGoOvHsLh
	BwFy9ZWUAUolc3Ex+7K+fxT3B9Z09WQSDcE59IgR3zeRH7QDfescbwricyGLJXeOdHwlfK8czyj
	hnrZWSXruG+gwJXCBgNk/HVbwUYXUoKraD6KzKMLD4JmP6CTev60AjalGGepBZlaReKMouPCAad
	eb4TK8kwrR4AAFqro/2ls9HewutW0DibJPcRT+RyX7UDOxaCKnHvImQCyY7thrro1SM8DnafSps
	avyPWCXSbgDCDhRTVkFlUnMFpFzCe8JBSj2y2XQ2jfTM5ftAoqz1N2AUhHjSJK+8HmMbWUxlp4K
	1tnOCEnNMvxuT5YynU48U6pcL2nmMRk9rFNaLoVHFI2D8FurqTcUj8fuTyiYcUSkscrLf56VI+T
	i/5BLcqAcfQ/dSnN3g16CzB8zZLRrbPnhU2xduRFrWCRrkanGvU8kcQ/qnw9QzLVEsxVHHQBiAJ
	/ghT0VKcaITY8T1r96NpyJCjGO3+OMerIuE3W+c=
X-Received: by 2002:a05:701b:4184:20b0:191:444:425 with SMTP id a92af1059eb24-199290fe40cmr12440066c88.2.1793068884148;
        Mon, 26 Oct 2026 19:41:24 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a1bfaf25sm29293759c88.14.2026.10.26.19.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 19:41:23 -0700 (PDT)
Message-ID: <1ee97e9e-3658-41a7-a879-348f51ab547d@kernel.dk>
Date: Mon, 26 Oct 2026 20:41:21 -0600
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/10] scsi: bsg: Don't copy sense data to user memory
 when canceled
To: James Houghton <jthoughton@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>,
 Pavel Begunkov <asml.silence@gmail.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <mkp@kernel.org>, David Sterba <dsterba@suse.com>,
 Chris Mason <mason@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
 io-uring@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-btrfs@vger.kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261026215226.3713941-1-jthoughton@google.com>
 <20261026215226.3713941-2-jthoughton@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261026215226.3713941-2-jthoughton@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

