Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0B922157E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Apr 2025 08:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744879108; cv=none; b=j/cU3n3UClKOT3CPNRycH1pY9RqEK7ruVl3xsN9qHGA5VU1kRokOode4Vo8W0f5bp0aRL1m1veJnQhkedpZli9mLNp6lTLSr6FlfFgYmI3eqWUwuLXMEJMU+bVDDi3iCwufJrXC02zt4ilJUBUpzyzmsNWk10OAKoo6NvFye4xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744879108; c=relaxed/simple;
	bh=Le2DQb6d26PT3nBcXc5FkBee0F9+eT3oXTZcWo3Cixg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Vb7e2Yzk75sQ4HNnIAkRuLpdtgwiOXXcHNdolsnPX9zFaNA1smixmwm1gE0MVWh6pixry9MnTKy47zO8wajhBkF++N7vqmbK/yawTf5tz5HLwmSJQZT9rodxgZfj9HvH3LlBQ+paTD//rks/+5J0d2QutZC6xaHwkUUFMbLBtXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85b418faf73so116917239f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Apr 2025 01:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744879106; x=1745483906;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aj6J3dmz489BCCitLkNNhLteQXiScv4rJV+t3X5Vrqc=;
        b=rSYLZopfrtbNx0NS1TCXxmkXl4IZLSAp8ODWghbFbP7zVp7EmfcnscKKTpHYeGLcWu
         61ioF7377RyEbp+C/q2JfmOrp4lnDsTheRnu6ppwYFe8n2FTxO+uJB7ZY6yBzplYfHH8
         MQjYHmhZpGAfkH64VTxnRP0WjihhWWB13iPfXRniF7BXee++Z9I5AOrdhdfPpXtE8by5
         hiSaTUu8shdtSFUFBuzt/l2HxZmTu8q2ZAXkUBdBIFPpQYp7pvBajM5P/tuY4TuELX3A
         RoXUh+3VrgT+Utk6jtmCZ3YntSv3IHAhpdlVvAiN1oKi+VfB1pvjzYIgRQ+MEn1RvjlN
         jnUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtwD6og6hvarYg8txxqZehWfVDCiYBGAUqebximwHYC9/7hSp8IjaVMrRklhr/mxUtVzyhroSHzTrj2++8jF7XOmI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysl8xLeXwaYLYgyvr7csEJf/fT3M6GqLOAjwUwY7KS3iSWyZo7
	o/m08a16xgUZuYAHHQkGUbVIW3CmJWanEbhTvGZ/PE1cqx55u70IpIRLqvI4fXqCk40R4wd2zBQ
	SIsRMQaX2T3o9mNN8305jLZvYnAsRxqPjFq04Zfq+Lq1NrdWoPWo4mxs=
X-Google-Smtp-Source: AGHT+IFNFKv7FndE/TSGAVUIQjg41XQS7KTGt166sJjk+WHLdvZ0xwSqjyI/3rBvekK3W4KmP/VjFiey0+pfiJsE4ioTHYdQXLNf
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f0a:b0:3d8:1e96:1f0 with SMTP id
 e9e14a558f8ab-3d81e960583mr4482845ab.20.1744879106378; Thu, 17 Apr 2025
 01:38:26 -0700 (PDT)
Date: Thu, 17 Apr 2025 01:38:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6800be02.050a0220.243d89.0010.GAE@google.com>
Subject: [syzbot] Monthly trace report (Apr 2025)
From: syzbot <syzbot+list1cad94e5112980df097c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mhiramat@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello trace maintainers/developers,

This is a 31-day syzbot report for the trace subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/trace

During the period, 2 new issues were detected and 0 were fixed.
In total, 13 issues are still open and 43 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1675    Yes   WARNING in format_decode (3)
                  https://syzkaller.appspot.com/bug?extid=e2c932aec5c8a6e1d31c
<2> 176     Yes   WARNING in bpf_get_stack_raw_tp
                  https://syzkaller.appspot.com/bug?extid=ce35de20ed6652f60652
<3> 51      Yes   WARNING in blk_register_tracepoints
                  https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
<4> 39      Yes   INFO: task hung in blk_trace_ioctl (4)
                  https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
<5> 23      Yes   WARNING in tracing_buffers_mmap_close
                  https://syzkaller.appspot.com/bug?extid=ddc001b92c083dbf2b97
<6> 21      Yes   WARNING in tracepoint_probe_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=a1d25e53cd4a10f7f2d3
<7> 16      Yes   WARNING in get_probe_ref
                  https://syzkaller.appspot.com/bug?extid=8672dcb9d10011c0a160
<8> 9       Yes   INFO: task hung in blk_trace_remove (2)
                  https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
