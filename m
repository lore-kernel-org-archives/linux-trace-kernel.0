Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAED1A5B8A;
	Fri, 10 Apr 2026 04:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775795612; cv=none; b=ZxjNMEYN1OpcQqrJcq2j+smQPahaeXb36kkgjhKdrczNfHSu8PyTT6Erami5cmYKhOtA3JF/tU3NWrrgMsjTl/nRM0j+ixt4upTJ/RQwfMUXAmakEVk5F6VSNZkIBjOw6CyDECH6jCnkyNlrl9wqK+RQnNoWVhGKiXBp1DQ1goQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775795612; c=relaxed/simple;
	bh=SMGsPyxBD/ferwmLgwJAfUSrtW9ZZquY0BZGfcDQGtI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QoGqLusPS9JViYmjMS9jvqIhwr6aPBN7PkQ1TwM5I7OUhz6Tkb0J0O0kP6VAprJupkwf0x6/xVTM1gG1vci7YuLgwvV35UYYnOZg8uZklnK+jCk988rcf7kKIhqFTy8seLisCFI/OInSQC+KAyCdExnuktUKFFuIavOgRi15PDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=csSv6NPg; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="csSv6NPg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=yI
	Pgk9Fvc5GGb1n+c5WvNVrrivP3Qxx7uj2ePzLbvCE=; b=csSv6NPgQ8WBTudhut
	WmlG+w3NqlmDNrE5Id0ORKCp5S3rtOaJfTS6WpOXLAgML++Hb8QHSCXmxM0m3t1r
	urTEyxZD6o+xR1fMYI3tECGnZ35VKKtYeQXLm8KmCSWA7nagnVDmgY/MqRYJWzos
	08Px+KWQWcbYIW47pMcTEhWp4=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDX38lufdhpbcrDAQ--.9S2;
	Fri, 10 Apr 2026 12:32:51 +0800 (CST)
From: Cao Ruichuang <create0818@163.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Cao Ruichuang <create0818@163.com>,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Account for fprobe attachment at creation
Date: Fri, 10 Apr 2026 12:32:43 +0800
Message-Id: <20260410043243.65800-1-create0818@163.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260409172955.98e2d20a7f7736a1a9834816@kernel.org>
References: <20260407115751.96184-1-create0818@163.com> <20260409172955.98e2d20a7f7736a1a9834816@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDX38lufdhpbcrDAQ--.9S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar17JF43JryrGrWDtrW8WFg_yoW8Jw15pa
	9Ykwn8Kr1kta4rKa9xXw1FkFn5ArZrXrs8GF97G393Ww1DZF1kJw4vvF47XF1jvrWkGF1Y
	gF4FgF1Fqw45Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUemhrUUUUU=
X-CM-SenderInfo: pfuht3jhqyimi6rwjhhfrp/xtbCwBMMRWnYfXNeuAAA3D

Hi Masami,

I reran this in clean QEMU on two kernels and got different results.

1. Ubuntu distro kernel:
   Linux 6.8.0-100-generic #100-Ubuntu SMP PREEMPT_DYNAMIC
   Tue Jan 13 16:40:06 UTC 2026

   baseline count=2
   after_create123 count=4
   after_enable1/2/3 count=4

   baseline enabled_functions:
     __hid_bpf_tail_call ...

   after_create123 enabled_functions:
     kernel_clone (2) R ->arch_ftrace_ops_list_func+0x0/0x280
     kmem_cache_free (1) R tramp: ... ->fprobe_handler+0x0/0x40
     __hid_bpf_tail_call ...

2. Current source-tree kernel built from the clean snapshot of my patch
   branch:
   Linux 7.0.0-rc6 #2 SMP PREEMPT_DYNAMIC Fri Apr 10 12:19:39 CST 2026

   baseline count=0
   after_create123 count=0
   after_enable1 count=1
   after_enable2 count=1
   after_enable3 count=2

   after_create123 enabled_functions:
     <empty>

   after_enable3 enabled_functions:
     kernel_clone (2) ->arch_ftrace_ops_list_func+0x0/0x200
     kmem_cache_free (1) tramp: ... ->fprobe_ftrace_entry+0x0/0x220

So the behavior I reported earlier reproduces on that Ubuntu 6.8 kernel,
but not on the current source-tree kernel. I think my earlier conclusion
was too broad.

I will stop pushing this testcase change for now unless I can narrow down
which kernel change caused the difference.

Thanks,
Cao Ruichuang

