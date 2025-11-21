Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8D63090E1
	for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Nov 2025 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763728480; cv=none; b=lCw7mBc10rlRZQ1Hlw9Q7ZJ2oRlHj/YoxALxuprtibYr7glYXeE0+5bm8PKjl748IPZ+NZRW7IW5hxKeSd+6IgAktjo1ed0YyHR8dQ14BGy1bhbCjvzK6X3UdMWp9bfk8fEB5EQDomWM4IMzeJFm39CDxpBxY8f99zW0j16LwxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763728480; c=relaxed/simple;
	bh=luwEOd2cuqEHNGUEhejYGjZIuuD5793J65QXSOAQHMU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fw67RwFwUvk1sABRkwRRJVFu6IpjfKFYFT+jbTPT4h8mQjs4M153DCPTEyttg7xiAIJxjmmmVHeFYgb9eBZYeWNqELju3GIyjxlJKlFThe8eG312uaR2BTnt4Ln8ObWwvHdT8cpl2lqirymE5siq5lA1KVU3W88TbfdrZueJJhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-9490314b781so134456739f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Nov 2025 04:34:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763728478; x=1764333278;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7W2HBh1TleicrZfEbgL2NEiodFl9Mpdqhxr0rQkM6mM=;
        b=iElc6cPuIkkJb5Pba3mAQAq20wg3WlAVV/eqSeQflIeaG6JN1cazFpDZA9YH38DPEx
         0b51XOLyJj+pIG3GkmI/GeOGKgOPtRHQn8DdP70fj8LYCJu7ejgdrWalj4ONFRXhTull
         bK9mqoVp/zYl0ov6+JNvG5SB6RjpJBJCO0oPzf+neKfagkZBI0mccpHMkLuB/bQZwreJ
         R8EyyxQXa+xZliEmSZARNVhI0vvEQtuU79Kzoptm668eUCB20reWhVsGo97qbVMNsT1O
         6Oaf0qdWPPP9l1EBHb+CaUK/JIpFYIkX7AUq+yRQRI0fcshgFozhyxphgagyFd9hBsS1
         kL7g==
X-Forwarded-Encrypted: i=1; AJvYcCV2d1GCvFRed4GtNhPxKzFOMF6kd8+G/DFVaw6RgDEEhPA08tQH/g5YIPnEJ1AtxOGUd5VUcnxZxTZi3GedSxCjs5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLmtiJYXE2Bvn+tWnwfOYwgwCk1VTI2Cri00hgIW/YC4FiES6e
	BgfBMuOfuPQw1L2FJdYNe1+MoFoMs65vXlNJVNqPlnjfUESA9Qov0b9GTjiiWbYsWQ0DUQRjbGr
	Xd7bIvEgEsQxb0+MD1/7KKuD6OBZrkG+1ge0joVxLukLZM2q05J8UZvGgsrw=
X-Google-Smtp-Source: AGHT+IHSi57Q5v5in5sqbX+2IERxl2ilHut6iXvtwJBx/F7H85l+cZ0s76nfQQZq0AUqMDyr8TLxoaOEEuX7EVCCFQzcfNPLac0Q
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:351e:b0:433:7e2f:839d with SMTP id
 e9e14a558f8ab-435b8e79e33mr17115295ab.21.1763728478333; Fri, 21 Nov 2025
 04:34:38 -0800 (PST)
Date: Fri, 21 Nov 2025 04:34:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69205c5e.a70a0220.2ea503.0051.GAE@google.com>
Subject: [syzbot] Monthly trace report (Nov 2025)
From: syzbot <syzbot+list6c3ec839fea04710d817@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mhiramat@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello trace maintainers/developers,

This is a 31-day syzbot report for the trace subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/trace

During the period, 1 new issues were detected and 0 were fixed.
In total, 15 issues are still open and 59 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 773     Yes   INFO: task hung in exit_mm (5)
                  https://syzkaller.appspot.com/bug?extid=1c6607097b258f18065c
<2> 87      Yes   WARNING in blk_register_tracepoints
                  https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
<3> 82      Yes   WARNING in tracepoint_probe_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=a1d25e53cd4a10f7f2d3
<4> 60      Yes   INFO: task hung in blk_trace_ioctl (4)
                  https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
<5> 58      Yes   INFO: task hung in blk_trace_remove (2)
                  https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562
<6> 30      No    INFO: task hung in blk_trace_startstop
                  https://syzkaller.appspot.com/bug?extid=774863666ef5b025c9d0
<7> 19      Yes   WARNING in get_probe_ref
                  https://syzkaller.appspot.com/bug?extid=8672dcb9d10011c0a160

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
