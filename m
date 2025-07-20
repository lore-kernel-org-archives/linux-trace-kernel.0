Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DEC1C4A17
	for <linux-trace-kernel@vger.kernel.org>; Sun, 20 Jul 2025 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753002272; cv=none; b=tUTodgiXSiqcP2JAOhZqtpmGglJ0dfLCSZ7/GK3qlEY5AqMrS0XbavybgV6e2AXW2Qb6hfPq/20z5wsUgd5vYv4F4GGBmglMHAGB8Pqk2qkDzaq73GHuAQclcM5TgxCsSLjoKfYwhQ0Z9Q1U3DhpRAL4kC3Pgba+ihwddXtOTt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753002272; c=relaxed/simple;
	bh=DV+d7fQsOplJtUuPgom5MOBYAFtcG5VOuZQYlQjQOg0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AHXQf0sUUt+HfiK0DgsFLsIEaRnEmfJ8g/iI5f7HB6NJZ06zdios1WrFcuHlrmagsOQ8Q2QmctMNOfJBjsAoCJYaFjsN09z4Fr6//9k7bSBJKtNLJFw+vmQw2+obcjCsS487snzFzSQFTXmXW2kU3fusUn9k/N6/SqWo1g2rhHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ddba1b53e8so37150985ab.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 20 Jul 2025 02:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753002270; x=1753607070;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bp6FP9yK5sZE5gMe6Mw+JGVsx/wyOJ2DCfwx+rTMhVM=;
        b=FicLqH90fh8832NkRzD5tv8dOmUz952xYto6p58ORnGddCDJ/L5xDUxWFU25/CXXL+
         bC8769bgpEKF4U+NdqqH/l67T5e23aOR6DKRGfUqU7DU+gTsqNpz/2Jcn4kGLcmHV23d
         +TSO3FzFBPI6Kf8cR9G1bSyyDsc2NOJHlC9VXoBwt4laxRXEWsMfqiw4OEQ6JzMh51LX
         byN3HZKxOtzWKZduGmwUmIGSUTurBbgNtdadO0Pe2TtyQ1l/2Qow1eUkYWcfugzks7j5
         GQmJX/odow1MVZziVb5LQzYHYqx/qka4kL01TmH4eWb9wV0xv4fpjWpPPQQx+0HLboe8
         Gdpw==
X-Forwarded-Encrypted: i=1; AJvYcCUKWPxy6nVS+Br1KBulE9s9ung+Vxc69J2jmK5Yn/c6+B+mOHbU/KyIk6hd4c9cl+6CHQlDJHsri5fFwhqHLDH0EjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxWpwkSOf6pQVCJNcvEORqtxc6bkEQzIOutS4ZyGWynMROUy1C
	DfqyjQMEIMNvy6HM4MSem0ZHc5Owtahrja0q1LDi1TWU5CI9S/6Ct7UyuSH96d4TnAevxcQjKkw
	uWldPMT8e22xB7M7pMf8qbSOGmmsj3eLmyBNbr+IKK2jox6cBMwyG1JLeVC4=
X-Google-Smtp-Source: AGHT+IEogKAS3P/6OQF2OCALURdXUEXElveBV+V2WhZsMf+r7/rUJVDZby4lK+SAi6ZVOefFDg9dI9SdcvWDfo1ZGkTZaQuU041H
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f01:b0:3dd:d995:30ec with SMTP id
 e9e14a558f8ab-3e297409f97mr87646355ab.12.1753002270296; Sun, 20 Jul 2025
 02:04:30 -0700 (PDT)
Date: Sun, 20 Jul 2025 02:04:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687cb11e.a70a0220.693ce.00b8.GAE@google.com>
Subject: [syzbot] Monthly trace report (Jul 2025)
From: syzbot <syzbot+list7b00f28fbeff30efd2db@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mhiramat@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello trace maintainers/developers,

This is a 31-day syzbot report for the trace subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/trace

During the period, 0 new issues were detected and 2 were fixed.
In total, 11 issues are still open and 49 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 350     Yes   WARNING in tracing_buffers_mmap_close
                  https://syzkaller.appspot.com/bug?extid=ddc001b92c083dbf2b97
<2> 77      Yes   WARNING in blk_register_tracepoints
                  https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
<3> 50      Yes   WARNING in tracepoint_probe_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=a1d25e53cd4a10f7f2d3
<4> 48      Yes   INFO: task hung in blk_trace_ioctl (4)
                  https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
<5> 35      Yes   INFO: task hung in blk_trace_remove (2)
                  https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562
<6> 14      No    BUG: soft lockup in hsr_announce (3)
                  https://syzkaller.appspot.com/bug?extid=6c68a0400c33951a023c
<7> 7       Yes   INFO: task hung in blk_trace_setup (4)
                  https://syzkaller.appspot.com/bug?extid=9c1ebb9957045e00ac63
<8> 7       No    WARNING in tracing_start_tr
                  https://syzkaller.appspot.com/bug?extid=ccdec3bfe0beec58a38d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
