Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9BD75809
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Dec 2024 06:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735109705; cv=none; b=O4PqFWp0Ky9o5Q+LLOLlZPL85t6rJGzFAiSl1/E4ZSt1qW3vHamzWAVhNrFK1fT5NbeZ7fPp2f/iohV+YF4HvqS8Kmk0pVvF6WcE4sGzVZQ/UPpQStW0dZ06s+vw01uydYJm+tJZWsGxapeF6/rZVX9dk+QGe/aJZXwKo7iCsvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735109705; c=relaxed/simple;
	bh=vCtH0xKpkMLyYyOdDBDic+pLd6WKYQiYK6ZqajPoAa4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QawNQszNzSBfL9TR81d7fEjX8ARZ22oC0OWFdgxgQ8GUmx7l/SqPGmGBGSMtOS9NnKFi6iZpNBds41+8tiLGNBTYb6iZ8OHsROTr4PTgVs8hRRNwPjFki7A44t4RkxMEjoRKPY4tyIjRiazGjChbBkhfNDXZVkkdx9zp813lsEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a9c9b37244so109662615ab.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Dec 2024 22:55:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735109703; x=1735714503;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ta082uJJhcNZbV4mjW5xLMJwbMmb81o4pqVkiCohDVw=;
        b=PIkAgm3XnwxoDRG7kFKyMPAn2mpYb4qy87A4eE/p6nA63rE3wGLV8MIVKCUKgepDp0
         XdaFfMzBv9us9gXzNdeqJ8pxRp93wdqXyg3Ful7l8WB3odUZs6tIjiAW0iIijb+auUwv
         UXuT1GL6VSPDUHxquns1swXmhzrwFyTUKZ9OtZPf+aj9pDnmglzNUetedoTJAi0CeHUa
         +wtA/jWeozdnuF1MTfFlucnm3bWdjTOl5393Shiz90w2zoDzdiKSbfOaKc71bXV207F8
         7wNQUS2XJH7mjVE/TdLXSdk/P4KZJ64y1RoOQkWanXh8uf4b7mkNDzzissV1DwktstcO
         fKwg==
X-Forwarded-Encrypted: i=1; AJvYcCUrf8EDPuRjLS3HiKSGsV+rKA/B9gM0p7N0nk5LjY8gQc60mk3QKrw+AbpzcNVk4/gIakLK7w/ncXCL0jxzdwwlr6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YziXS+O7/K0FHPspVt77gRdS0wypuPZZfb55wr0rfCLSWmWOm9h
	tJQx9VR4Cc60k+5viawu/C1H2jQOmO8genbyGDchYvY4GTjgwcaMq08WVgplcoYwkoRANeoT5ip
	TZJ9uj8rkE97BrnwYsmCFSuXtrIZ2ykK9tZ8P2Pc5hITpEZ4Gz9hAsRU=
X-Google-Smtp-Source: AGHT+IGo/mB++g9H0Iiix3YzJTvrTK6q3jZQ68x3nvhK+kwg0PaPNtGL6q+kyKROY1b4wvaDfpyggNUdRK7wtTg93xxG8D6obP0W
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e9:b0:3a3:4175:79da with SMTP id
 e9e14a558f8ab-3c2d2d5164bmr159902725ab.13.1735109702902; Tue, 24 Dec 2024
 22:55:02 -0800 (PST)
Date: Tue, 24 Dec 2024 22:55:02 -0800
In-Reply-To: <000000000000e7765006072e9591@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676bac46.050a0220.2f3838.02c0.GAE@google.com>
Subject: Re: [syzbot] [bpf?] [trace?] possible deadlock in task_fork_fair
From: syzbot <syzbot+1a93ee5d329e97cfbaff@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, brauner@kernel.org, 
	daniel@iogearbox.net, elic@nvidia.com, haoluo@google.com, 
	jakub@cloudflare.com, jasowang@redhat.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, martin.lau@linux.dev, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, mst@redhat.com, 
	netdev@vger.kernel.org, parav@nvidia.com, rostedt@goodmis.org, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit ff91059932401894e6c86341915615c5eb0eca48
Author: Jakub Sitnicki <jakub@cloudflare.com>
Date:   Tue Apr 2 10:46:21 2024 +0000

    bpf, sockmap: Prevent lock inversion deadlock in map delete elem

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16e922f8580000
start commit:   fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=aef2a55903e5791c
dashboard link: https://syzkaller.appspot.com/bug?extid=1a93ee5d329e97cfbaff
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128b2d33180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10fe01eb180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bpf, sockmap: Prevent lock inversion deadlock in map delete elem

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
