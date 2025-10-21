Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AA72EC09A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761033747; cv=none; b=cNpQ4XoUy6mdy+5QgpC245oFVj+0szPaAMO+IagWWJDPbAQeGtlSkot8t8Gd/GcQtFQDXL+F7aX2WJJWj/hG1vtbCHjPBxVbiypGX4nUlzk9Uv/G4/AjYVXMR61XLF+3X74BlxGJViT31oRGu3iQcmQ4xzkMFDuYO/wyZTj8kOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761033747; c=relaxed/simple;
	bh=hL2gB1q0VDI1syvgqzalY45oVF7hQIYm3mMV4Q8i8f8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mVqi3JjoUmQ/ugEyvZvgPBXCa8ptpbB+G/Z8gS5FakjLMI9dLlZ8A9eZ1ZEgAS+3ld6RGUwoaNxm7weZm9xpnrttt+lpAt2dSOjR6fZP91ZQF0Wdk5Atew7gusPHVc1+WD94m2hb1Z0bc3ENPI9ff0wiJOCEJ2Sk0fXJD/3acMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430db6d36c6so82363615ab.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761033744; x=1761638544;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BVojPbmDd8gpKG50KykZMIwE1cqFIKnT3dH0bMxWekQ=;
        b=tMsFqWt/ymGOhx8HuGatFmJH8Vc3Tja6UxgTtsIzgLTVGxBPllZ0app88SnI+c16+v
         OxdFcYiFlnMVgrEfC5D9jRD5YIRz4MoKorE4SGkBm6xXGZZxii0RsPQthGybLsc0oakg
         /xjMeOi0+WPnRf+0pEDtBD6JD4qYTgH+/QGHU0U7U5ARD+s444VzBx3bWJaY8qvNrulv
         5v8ib4moBTeXHP5uRZCYpRPm+tfkf0AjEFrXHOjVK5Ty24tayPZtNT5qakiYgx39XgEj
         kHlp6QHe0lxMFsoI8E+ItT8/l7wvq6+TqvS3n2KXE0nQecp3Ive/DmVqNGtZkIesmvFb
         wRNA==
X-Forwarded-Encrypted: i=1; AJvYcCXWFL2znsqW3T5/4MTN2cN0ZYxtnXGYP7PzPWD8VzZ7uQGIZK2BCZiPCefNFmWT8F5hJkoqRL7yFT7tkbazZS+r/SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy47ph35bbvQSQsGLqhhzL8m4aTlHNXOdE28ktE2zQm96SgFRzu
	eSgp1z6pfSh2LJd11cbX0d7f4WzO89Ebz1XrtD0bJ8ZhU8MvJzH4Stjx6fMP2J2cXDEwcw3ZfSl
	Apu1NyeDqNCfkR7LK9/JDWIKER8ltaL4srS8BD3XBOwRR+Gopu7x2JepxkbA=
X-Google-Smtp-Source: AGHT+IGWFogsWiEGXpT6LEkD/wmRqVt7qt+7Dl9ZTxt72m86e+M9GYYLMuJv4FX7L4/87earjVxjJqLGdKGMzgpGFHd2FsY0U2UJ
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a29:b0:423:fcd6:5488 with SMTP id
 e9e14a558f8ab-430c5223fe8mr250787785ab.12.1761033744757; Tue, 21 Oct 2025
 01:02:24 -0700 (PDT)
Date: Tue, 21 Oct 2025 01:02:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f73e10.a70a0220.3bf6c6.0002.GAE@google.com>
Subject: [syzbot] Monthly trace report (Oct 2025)
From: syzbot <syzbot+list8aaabda4014edfca824f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mhiramat@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello trace maintainers/developers,

This is a 31-day syzbot report for the trace subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/trace

During the period, 2 new issues were detected and 2 were fixed.
In total, 13 issues are still open and 58 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 144     Yes   BUG: soft lockup in mac80211_hwsim_beacon (2)
                  https://syzkaller.appspot.com/bug?extid=7e51ea277ea81fe6935d
<2> 85      Yes   WARNING in blk_register_tracepoints
                  https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
<3> 70      Yes   WARNING in tracepoint_probe_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=a1d25e53cd4a10f7f2d3
<4> 58      Yes   INFO: task hung in blk_trace_ioctl (4)
                  https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
<5> 53      Yes   INFO: task hung in blk_trace_remove (2)
                  https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562
<6> 9       Yes   INFO: task hung in blk_trace_setup (4)
                  https://syzkaller.appspot.com/bug?extid=9c1ebb9957045e00ac63
<7> 1       No    BUG: stack guard page was hit in br_handle_frame
                  https://syzkaller.appspot.com/bug?extid=593efacb260a29c44abc

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
