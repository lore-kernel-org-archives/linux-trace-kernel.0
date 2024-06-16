Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96619DDD4
	for <linux-trace-kernel@vger.kernel.org>; Sun, 16 Jun 2024 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718546705; cv=none; b=EkjjNJLh1FNyJNm4F/mkIeF0rGOPQNPu3T5RpT30/fhgayniqLAtw5IpmqIOQ4Y8Ce2Lic7VSQxdrwTY0pG1kYwI2WI0yAnEtpZpa5208REQbWPlnz2ZzHHxHZ9quHx5tYIRDViO8EME6V/0tP+DmxSc5ikEtHp6JZzjgj9fxgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718546705; c=relaxed/simple;
	bh=6io00tG+BXXD/bjavj6Wc0ZSI2uXwoyQQXTJiFre6ec=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DEVFvP7uDwfR0Y1ML2Hz0O2ekDTwgByCpm1CkEQWKarhvzThonifsSLvW0fz+7iimSvMhBvWaGqV7oaEZIzGLQhjgmS6p5dQjmsQDDDiIx/idwnIPsNvrsQCR6HdnA/xz2dXVg1h0jevNjv+BLWf69L5lrzSaXhstS0tl7j6dCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7eb69c65e9aso424978239f.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 16 Jun 2024 07:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718546704; x=1719151504;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLcaaWng2TQ/H+FaOLphi+VM/bKUwUbvtr6FoaGnNrI=;
        b=r9TDCE8lEv8hosEUOmY0JDsaWssUNu3+yb59XGAteyVN4tn2SVxcpeDkAef3UCl6YX
         Rtt1uAgJa1akah8TCOMlcIF1kBznm3IgUslNUlSTj/ssqVYBeV4tjNm1vqxZ53zBnQob
         hC0RAHmVSYLjei20ObGncog0XBZIOssGxnDdNsQZalc3j1ksKvvRuukTaKEotXB32TG2
         QLs3EnbXJvjkk3rrr5JDT+un5Eykrryx+86dyrj6PqePZl826Rg2/aMJRS/cq1+E1ntk
         INP6heKWWqRVH7zJU8mqis6qfz5ENeMba3ZjzhgkwipVSBxSekKQ7UEswwNwqQConlWi
         atiw==
X-Forwarded-Encrypted: i=1; AJvYcCVCENm9Pw6RRkjDaRMWURcSyRz4TlRZbbgb1rmJvZUkNVOgu+8CH9RiaAaYwhHqLCW8y/8fNfv7zgoIxcE287llb1nZ84xcpO/RyvzXG6hC3qm1
X-Gm-Message-State: AOJu0YzQcJJhd9s8XW8vY98hF9ly9LcqT9/69Sn961VTc4Iijx4Vrwbt
	LMcTc60O6J8NQqIwovTH6CYkNKj8CCZLlhPKvbiJ+aHPevLAjPW/aV+2HK8fMhSSO5qB5V3ZG8z
	24FAEM00YSDHVSC9J+WBR0+D1VZDc3kRlOFQXFUIV7+e6GCvM3SbzDnQ=
X-Google-Smtp-Source: AGHT+IGHyeFtvlt+ImnEUgnwm5dEInqksvU32QABvMV0/yconOjWp25/ZCqoFaDWtWWVmgcbKMIB0yhITZPgs6UzpCsDR8a/2Hhl
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:150f:b0:7eb:78b4:faff with SMTP id
 ca18e2360f4ac-7ebeb62c796mr20918739f.3.1718546703860; Sun, 16 Jun 2024
 07:05:03 -0700 (PDT)
Date: Sun, 16 Jun 2024 07:05:03 -0700
In-Reply-To: <00000000000041df050616f6ba4e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d05580061b025528@google.com>
Subject: Re: [syzbot] [mm?] possible deadlock in __mmap_lock_do_trace_start_locking
From: syzbot <syzbot+6ff90931779bcdfc840c@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	hawk@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, lizefan.x@bytedance.com, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, netdev@vger.kernel.org, 
	rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 21c38a3bd4ee3fb7337d013a638302fb5e5f9dc2
Author: Jesper Dangaard Brouer <hawk@kernel.org>
Date:   Wed May 1 14:04:11 2024 +0000

    cgroup/rstat: add cgroup_rstat_cpu_lock helpers and tracepoints

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16695261980000
start commit:   36534d3c5453 tcp: use signed arithmetic in tcp_rtx_probe0_..
git tree:       bpf
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15695261980000
console output: https://syzkaller.appspot.com/x/log.txt?x=11695261980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=333ebe38d43c42e2
dashboard link: https://syzkaller.appspot.com/bug?extid=6ff90931779bcdfc840c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1585acfa980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bdb7ee980000

Reported-by: syzbot+6ff90931779bcdfc840c@syzkaller.appspotmail.com
Fixes: 21c38a3bd4ee ("cgroup/rstat: add cgroup_rstat_cpu_lock helpers and tracepoints")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
