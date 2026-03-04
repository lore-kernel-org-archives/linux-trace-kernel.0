Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26726390C8F
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Mar 2026 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610788; cv=none; b=ANRvub0aJxC8T3ZL4a8qcYksXWWtKmT0jEPJ1b4eRMjk8SyaNOAvD4IHxDA/egZNmx9OVCmBENxW7A2gszk23X+BXcKx920Ok+W5cSZigH9sYZVL6gjnaFb2XE/9A3/8PgK3PA+AI2JaO9dpl1MG5hZcb8CWeEVxvMbfH/0QCds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610788; c=relaxed/simple;
	bh=zgt8NOJmo621b4ulFEWxV/ruySqdMkBgDOFDs9sEB0M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iahnjiDiemJY69wmUlovAgV2wqpX+puxbdHJeKrF+lyuyfbQd2OzPdnk7byK1Vl7n7u7M0huGlNMGpflL7Rq+YdxrMXSnQRGJZxq45IoStc3IPDFb4nVnqQ+hIidEYxwh2PJcfb58bwgr91QUj8KIkuUe0UdjxizXr1q1G9QBPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4639a3bf26cso32401617b6e.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Mar 2026 23:53:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772610784; x=1773215584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eARhPwa95rMvtjrvMSpgRRZfWbAgWTWKjI5GGPrNVeI=;
        b=wV1+V4mSNpDeZnINWljyE5o/1uyMip1SHMRe0vdWaoSYhZYUIvVh7MMcK3NvlrFsRy
         akadFYyeuUj7jwVSNXrfTdpyvymSibjewLmGCctx25YgMCsFkaIaOOeQstQOLiah+bQU
         n41r6GezYAPWzsJM4YmiuafWn7lMgljUBUb+COMcJSlhsWvoN+WLxhsHLZfSqYY+MTcC
         KVEl8/rp4zHYXTbbRD+2qEM/YMS+ZLZa+LPuUxBKiWnw8qZvNYqa8Bc3IBh4F2hSX7IN
         X3yfmkFLCMYDNb6Uwov/vXUauVwDLv9b+N2SpY1Cxbdq6c0PmGItVjiIjWDzFEgJdpA+
         L9FA==
X-Forwarded-Encrypted: i=1; AJvYcCVyIAw7hnVseDp4vV0NJ+0qgukeWMlBjHWfxKiX+O2PjX4Vg5vu2Ayhin4O8thaVxo5cnjdQ188Qi/NIUgMhhJn86Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YygrOAqo4WBBp/P4LI1tqjncrRhU/xCI97zaYwEnqQ6BvM4H3ei
	+gu5s78ImquUP7WVgzoJhO8s6EEgjrDUD0I0Lf0kB7WsrVaCBOY3VJXmTy+CHJ5dpvXfCCRTyrF
	4vBIQK3T26vhPbT5IAuzsDtjGfZj1/b/AOrRCRjH0r1EL9t+KXCqpvMcfunw=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1612:b0:676:84e2:1551 with SMTP id
 006d021491bc7-67b1e92ed60mr617652eaf.76.1772610783903; Tue, 03 Mar 2026
 23:53:03 -0800 (PST)
Date: Tue, 03 Mar 2026 23:53:03 -0800
In-Reply-To: <20260304072616.185060-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a7e4df.050a0220.21ae90.0014.GAE@google.com>
Subject: Re: [syzbot] [bpf?] [trace?] KASAN: slab-use-after-free Read in
 bpf_trace_run3 (2)
From: syzbot <syzbot+9ea7c90be2b24e189592@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, 
	mattbobrowski@google.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	wangqing7171@gmail.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9ea7c90be2b24e189592@syzkaller.appspotmail.com
Tested-by: syzbot+9ea7c90be2b24e189592@syzkaller.appspotmail.com

Tested on:

commit:         0031c068 Merge tag 'cgroup-for-7.0-rc2-fixes' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12afb006580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c5c49ee0942d1cdb
dashboard link: https://syzkaller.appspot.com/bug?extid=9ea7c90be2b24e189592
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1566e552580000

Note: testing is done by a robot and is best-effort only.
