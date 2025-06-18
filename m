Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6BF2E8E09
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Jun 2025 13:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750251746; cv=none; b=FWDnENQjCPbPXBX57yWGg6TgC4JhdHJF9BcR7lcX2P2ZL3aijSsKcMBVPqcQ6A6hzzpIWyrSApZ2xIlZ5ZjVjT1cBvP014IUrgSEK1yIu0Q76KqLSkOKmVB9qX3GAO6swGDwvOk8WfzUxzMgKatpy2IQRwTixvN5FIfHcLS4wp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750251746; c=relaxed/simple;
	bh=DZrItFbknpDI8Un2NH1UDZrniGfqOG2TVQADV98m+2M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RQazly6dgmTXvBUJpS+LWaLNVeNOuOnsb8i5DjvWEjuDUupYMncutT2tmN4tdk2qPEtTnOyQs6Cp2QVQSmrv1t+rzSSaCh3LK2YHf8twdOAooKPWrQ+Yg9m3g/8MUxt8+kY7/MlB11zAPH4IlOT0Fcnk5Nl99h2Bn9ZEER6Jio8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ddb4a92e80so90178335ab.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Jun 2025 06:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750251744; x=1750856544;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JHoM2hc0ODan9OanCJjAUYd3bM093eFl/sY6DRIpWVw=;
        b=cpl1uDdqndltdEerbE6QGX8avQTs7+hJbuIlW2M1O+/js8T8TU1KXqIO9KHdAY+5Bd
         DM3NfN6qKDhIzQ32mT5Kctt3tLLRhq9bababI1r6fb3Art0WCDT9LlOrzrCEP9ZHmafN
         xEf2v8z5ZdZHHaKk+cah3Jc8H4EdRyiCvhlCA51umP4bhfH7lA4dai6KFQTlsiMvsz8D
         bYFD2G5035Zm/OAzanFyfdGpFoPRAaaXRStqhIG7+8Vx7YfhNX3mLYmYqLaTzZdTsTPV
         nRDgBzxlSKm4/OMeYRQQUxAhgXbne+XU6G4E7KzYNqQgIS+7b/lL9GrO9vBoHtPK9jzZ
         ntQA==
X-Forwarded-Encrypted: i=1; AJvYcCVS0fZZBHBh3aJ3wz1Txub5JUk2p0zQztyFsm7u/KCRn9p7b1USinv65mODtlCEttTr8cU2RArxQDL9dmxdhQKGNnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1l8lj8hdcI8joo2WhX9Xk364BkDUTiRqEtRTpEOliJneGfupo
	m9CmOKNs6o1az7OqMnsaqrgMawOd3iE3dW7nfTveI/oeEp+gknBDLjfEce8g0dgkjLYKRzDyjxs
	qEycH4k6j7ZyhPtV69y2vHcY3fiKMehcb3Ne8E61zRRVJNsuvdkBaLqjRPfw=
X-Google-Smtp-Source: AGHT+IFZy5E14MM+IwBcGR58yUK6AtH4Lh6pEooLzYU75zu4OARXSaSJbJxCnwzvUpM3s6pBl8Dy2yWCKWo0/hVacfu3CZFSmkim
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:b70e:0:b0:3dd:bfba:ff9c with SMTP id
 e9e14a558f8ab-3de07d686f0mr132141475ab.11.1750251744235; Wed, 18 Jun 2025
 06:02:24 -0700 (PDT)
Date: Wed, 18 Jun 2025 06:02:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6852b8e0.050a0220.a0d10.0009.GAE@google.com>
Subject: [syzbot] Monthly trace report (Jun 2025)
From: syzbot <syzbot+list1e42a46dc3c6fe5776d5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mhiramat@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello trace maintainers/developers,

This is a 31-day syzbot report for the trace subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/trace

During the period, 0 new issues were detected and 1 were fixed.
In total, 14 issues are still open and 47 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1994    Yes   WARNING in format_decode (3)
                  https://syzkaller.appspot.com/bug?extid=e2c932aec5c8a6e1d31c
<2> 149     Yes   WARNING in tracing_buffers_mmap_close
                  https://syzkaller.appspot.com/bug?extid=ddc001b92c083dbf2b97
<3> 56      Yes   WARNING in blk_register_tracepoints
                  https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
<4> 44      Yes   INFO: task hung in blk_trace_ioctl (4)
                  https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
<5> 33      Yes   WARNING in tracepoint_probe_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=a1d25e53cd4a10f7f2d3
<6> 30      Yes   INFO: task hung in blk_trace_remove (2)
                  https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562
<7> 18      Yes   WARNING in get_probe_ref
                  https://syzkaller.appspot.com/bug?extid=8672dcb9d10011c0a160
<8> 12      No    BUG: soft lockup in hsr_announce (3)
                  https://syzkaller.appspot.com/bug?extid=6c68a0400c33951a023c
<9> 6       No    WARNING in tracing_start_tr
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
