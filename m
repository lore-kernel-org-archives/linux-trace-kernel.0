Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B60419CC0C
	for <linux-trace-kernel@vger.kernel.org>; Sun, 16 Mar 2025 22:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742163692; cv=none; b=qm4fCJGvqZUzaEPDe8k9Auu7qWYjBYu1eonVo9FqSeKtA+zoTY1tg93KAjy1NhCjIcZVT2z+1y5Cz2UvWXg2x18PWrAPsQsk7yXZGZuOY1QB+NcGuxwLXO8r1DCx+CgmrFlEDhE/uX05wtXY6+TLOppopW6IydKUbivJrg1HJac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742163692; c=relaxed/simple;
	bh=f/bkzuKJBrCQQFvFO7kQ6QMquwdda1sZmGWNQShxsnA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=if4O2YuAtCq+R8t52uxAQy+kVXXbiZvpfGFGTTdD1CZ8rKBPhc2krSTy195YlLBqAqL61s+7EcMp8DvehPkc5eST7cFzl5JwaFUWfgmWR0L2STHf8jF+oz9uGccEFwMWUANdNtBGpmXTWegVufPgTHrthTpmOEe1ucjSo1+nhqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d2b3882febso32459845ab.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 16 Mar 2025 15:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742163689; x=1742768489;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vytDXSrDTUIA50F7Adluh0AaQUpx4RGewUd+6TVCqd4=;
        b=WqQ8WHGftjVrmiY/itIeY3jG4NsolDRgWyACpKqBJejm0jHpjykRFV4+8IFnX0lR+X
         50JH9+K8682bAXy5NYCoy4/01FZen0xZIQC4KhAdPulqMufDZZ2v/tDKxJtKlma+skNA
         WV7F2sWQj3FoBaNHur9sFBKbhwl1vNhfmamCz2Tey8u1QhVA3lbXbnZvrkmSXMp7YRJB
         JqzQ3P99qIe0PoG1fTXOFt8jnUyU4Dowsi0p0gcX1kpRfHGBpHcGf3I6O4DyGRnwI4Kv
         SvxrZyTRQ9tYC7lV2y8GzM60BcvxPgsFN8EED2j+W7mc8hySI3OPeTTUl3NqYcyaVSwf
         ZFCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHlHJk0NHrNiOFiBLyuGdi2gbFsO68VH+PlaNHN/HHCfIF3H3LzLGqay21NIcGqdPkwDKYf6eLv2RFCSoyBz3ni6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwIx0ZDLJ5tmWsT2xRwQtxmQhOUhywL62Zzhtgpvp/CL4pDwUo
	fzMRcxpSg20tu8Cots2eWvj5elMgVXCxEzrFIHANYmWhSHquewXAlVpM4x6FcL/2ugL2O2ZKnAl
	NReKi4CAIL1N0ud+lrFuBA81OptNQU4tCBn0fnbUs0ocTkzI8H29fkTo=
X-Google-Smtp-Source: AGHT+IEn+wquHBPxIpt0ermTcUKPWlfXqft6IlQRcDVJwMRJPcgYXM63WiE55Bj7+8ezsWoTIlKXO2u/bBJ0a2JmahvU1f3NbVfO
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184e:b0:3d4:3ab3:e1c9 with SMTP id
 e9e14a558f8ab-3d483a6e932mr96942565ab.15.1742163689656; Sun, 16 Mar 2025
 15:21:29 -0700 (PDT)
Date: Sun, 16 Mar 2025 15:21:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d74ee9.050a0220.2ca2c6.0003.GAE@google.com>
Subject: [syzbot] Monthly trace report (Mar 2025)
From: syzbot <syzbot+listdef366be10f5531c250b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mhiramat@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello trace maintainers/developers,

This is a 31-day syzbot report for the trace subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/trace

During the period, 1 new issues were detected and 0 were fixed.
In total, 15 issues are still open and 42 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1480    Yes   WARNING in format_decode (3)
                  https://syzkaller.appspot.com/bug?extid=e2c932aec5c8a6e1d31c
<2> 162     Yes   WARNING in bpf_get_stack_raw_tp
                  https://syzkaller.appspot.com/bug?extid=ce35de20ed6652f60652
<3> 37      Yes   INFO: task hung in blk_trace_ioctl (4)
                  https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
<4> 34      Yes   WARNING in blk_register_tracepoints
                  https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
<5> 16      Yes   WARNING in get_probe_ref
                  https://syzkaller.appspot.com/bug?extid=8672dcb9d10011c0a160
<6> 15      Yes   WARNING in tracepoint_probe_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=a1d25e53cd4a10f7f2d3
<7> 7       Yes   INFO: task hung in blk_trace_remove (2)
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
