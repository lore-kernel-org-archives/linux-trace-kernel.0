Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3F2218AD4
	for <linux-trace-kernel@vger.kernel.org>; Sat, 25 Oct 2025 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761394745; cv=none; b=MllolCx5NHdDjIMbqcTtcWtLofQbhj9ieXnDHI0HjAyWE9L5XdQvkTq6Z8Qn81ELaA0QY3LrLsbbL6FTuyjOe4tRuzgxBHQGYEyCEXRqMMpvPPnNUE4z97JjAOyHEZojl27TqSkp1wCUIV63N4de8vdYv6zsI9Vn6W0N8z3hWEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761394745; c=relaxed/simple;
	bh=EVlFebBa6swtthoo3XMik13PZNNqhlB1y4EKOTdvLE8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Dqjc9XAoEZQiC+j41xpdJPKLVvsf/QvY8R6v9xvSzzPdeuAiIuwLqPL14fs4xlse5pmSIU6ydYE1Z3PtdZIeAwltwVLz1IAyBiH76OJ31AUT97VxJsMLxkErk51u5TlVK1Io0joOSjtkZwxaVyrmVp0QZr1p4nG0gcXzlikfCsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430c523ce49so39734745ab.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 25 Oct 2025 05:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761394743; x=1761999543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=detJ0ZqNeJlrOsDrnLZMjTVhzUl3dolYqWJSe5Y+Nq0=;
        b=u9Sv0oGv32PaGOLIFgfQPNCgVV4q43NWYDHJ3jy0acDTfvlZ8Yk8xBDVrEd3TXb8Mz
         fLuNE7DnunOUOaWmygDbmR29q4h7rdXYw6QAeFqv3RPf6zaKwJ3U9z3Zg8/QbQ7AS0uR
         4p4b115Ois4G1zu1qCqrhWfLoBzCQPGd8+qqijscqJFitNs3TJam698CJQdklr6INWxm
         BHynoc4TvyXZhQan9diEJnvuJU9VlQK2yRwXmkXNX9S/vA2PA8YVEUo7XPD4UJnaeU3I
         qRjcSCcs2+AUMLduPU6MQBM6oI90oCMThhp4j+e5eJD6O0sJLFwr9sCg0Yk4q1+EJcfH
         HrTw==
X-Forwarded-Encrypted: i=1; AJvYcCXI+JBYUO9GcMUM+6ijYiNCZ9uMJxw48MvbzPlwlh+TY48qEed6g7NzRgoLcBy8hrxftbe5mQmYztdti5RjcxsIgdo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Z9Hb6n5e55HyaIjZajS45Z4jkxGIv1MH4BFLA35itZ4tvq0Q
	BVSFUwUv3Y9ox7g64iq+cvlwDsyxHrlVyCU6YOxlxYKxvfFvAT3uI2xdDUTWqzpqdChIzGJsKuc
	RKx0YQIvZrv+8t5cCkCUXbvGVmSYrBFGy+aFZ80oZK7kwXYAL7xpaU9GdkKA=
X-Google-Smtp-Source: AGHT+IG0oFMhPB3qHtmC1dmKqk1sRLQIj1ue+TTfk/yvBRc/nkTT76FySFISbYfurl785uiqw6lIns7SAqbjDTDaXjD7xmlkbQv5
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3f04:b0:430:c49d:750c with SMTP id
 e9e14a558f8ab-431ebed79admr68309205ab.27.1761394742947; Sat, 25 Oct 2025
 05:19:02 -0700 (PDT)
Date: Sat, 25 Oct 2025 05:19:02 -0700
In-Reply-To: <68fc07a0.a70a0220.3bf6c6.01aa.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fcc036.a00a0220.9662e.0017.GAE@google.com>
Subject: Re: [syzbot] [block?] [trace?] WARNING in __blk_add_trace
From: syzbot <syzbot+153e64c0aa875d7e4c37@syzkaller.appspotmail.com>
To: axboe@kernel.dk, dlemoal@kernel.org, johannes.thumshirn@wdc.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, martin.petersen@oracle.com, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f9ee38bbf70fb20584625849a253c8652176fa66
Author: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Wed Oct 22 11:41:12 2025 +0000

    blktrace: add block trace commands for zone operations

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1750c7e2580000
start commit:   72fb0170ef1f Add linux-next specific files for 20251024
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14d0c7e2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10d0c7e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f02d98016cc9c137
dashboard link: https://syzkaller.appspot.com/bug?extid=153e64c0aa875d7e4c37
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145ae3cd980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f58be2580000

Reported-by: syzbot+153e64c0aa875d7e4c37@syzkaller.appspotmail.com
Fixes: f9ee38bbf70f ("blktrace: add block trace commands for zone operations")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
