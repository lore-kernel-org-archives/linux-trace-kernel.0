Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B043947A5
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528480; cv=none; b=Jy9JvkpBkuzEEz8B4eFZ4J5Ty+MBrKacJxtxDVOUrzVcEyPUWFcYZ/1Z0NabDSJcfIS+ZPruEJindfM+jA3E6U4hzJkro2gWTh/5X9TDY4/QmsexYcbQWRWguQel2pO9K0Yjls7BtgxTzct4383ESKcZO/CyHoVWT1cR173Bx/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528480; c=relaxed/simple;
	bh=/wm5asXAYuyHm0O3HDyU+pqM/VRHFW7j7zoS6CUax7Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Z8S0JvgZ/Do8LYpKEHJ1Uh545XbMwuVy5NAVkW9Tgiw7Dx3MOiMshwSk4e8jQnyjfrLUqxL9YFdcw3DH/zZpL4B9KvlfTu0+1LIlVfbzm5fEPJ7bxmkXUGvfTSKyRFCJqPiXBjI9E8N6pYcrfRo3sRcj3XBWcEsn03EJRf8EcRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-67de3f8988cso2575157eaf.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 05:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774528478; x=1775133278;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+4PdzwFarQFnC1ElGdyOopJ2Ey3sY8rb8cPtTkX6BgQ=;
        b=lR3RNB6+4zNYZKgGL2aHwiHTFibDKkH6xa7QqxJJO/DjwXuGA6DgThYDfv1E93wmme
         CGjHy/8clTyKkwa6FKPNuZu5P8xjJCQRevmV+MfQtJQOQ/FFu/i+3s3TLTfsZLs96ayo
         8yCHHwmdqjBcks9XZNyuVXOJeIkOntWW+CCUwhdaGPUzpExaXzfRotYZB47ROl4ehgOy
         RAzoqvrK6vS4UDPS5mdw8YSakzRcoQGfAMl+dCGWxenounIOrbA9utUCjjSdKll7eFW0
         uwFFlLzIJbSEJ1H+JReOIQNaYYsHUKpKvlenZr1CjdPwJKLYNBCP1RVxFS1yrPXQK8PD
         Xy4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUISPz2aBndeq224V3ZxPHT3d1P4XyZVJxL3cMyfKg9x7DIuzcj19KfM/TResp3GymfNNzebS9bVOKWZD9uJfnh0PI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU6BB5vd2OL1I7XBtcAM9DNhzUcmqjQ1bOgL4idz2tnfTSss1K
	G40A7xNdqKJKw2HE8qVjFteL1Of7gzebsjXbo/6JddiNEFBqWtzcJcAnhNdLDmaTWw4QmKb1RsI
	2HfNkURLKkXpofANq7hvjtujrlXwh3Rtkt47qQoJJlQp/UgmATHiAmHuyXhI=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4dc2:b0:67b:c122:d29d with SMTP id
 006d021491bc7-67dff57525dmr3678055eaf.60.1774528478063; Thu, 26 Mar 2026
 05:34:38 -0700 (PDT)
Date: Thu, 26 Mar 2026 05:34:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c527de.a70a0220.38a0e9.0001.GAE@google.com>
Subject: [syzbot] Monthly trace report (Mar 2026)
From: syzbot <syzbot+liste3771d008d599da20ae2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello trace maintainers/developers,

This is a 31-day syzbot report for the trace subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/trace

During the period, 3 new issues were detected and 1 were fixed.
In total, 17 issues are still open and 64 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  277     Yes   WARNING in tracepoint_probe_unregister (3)
                   https://syzkaller.appspot.com/bug?extid=a1d25e53cd4a10f7f2d3
<2>  107     Yes   WARNING in blk_register_tracepoints
                   https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
<3>  76      Yes   KASAN: slab-use-after-free Read in bpf_trace_run2 (3)
                   https://syzkaller.appspot.com/bug?extid=59701a78e84b0bccfe1b
<4>  75      Yes   INFO: task hung in blk_trace_ioctl (4)
                   https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
<5>  46      Yes   INFO: task hung in blk_trace_startstop
                   https://syzkaller.appspot.com/bug?extid=774863666ef5b025c9d0
<6>  42      No    WARNING in ring_buffer_map_get_reader (2)
                   https://syzkaller.appspot.com/bug?extid=c7143161d8215214a993
<7>  27      Yes   INFO: task hung in relay_open (2)
                   https://syzkaller.appspot.com/bug?extid=16ea22f26882d7e46f35
<8>  27      Yes   WARNING in get_probe_ref
                   https://syzkaller.appspot.com/bug?extid=8672dcb9d10011c0a160
<9>  18      Yes   INFO: task hung in blk_trace_setup (4)
                   https://syzkaller.appspot.com/bug?extid=9c1ebb9957045e00ac63
<10> 2       Yes   possible deadlock in down_trylock (3)
                   https://syzkaller.appspot.com/bug?extid=c3740bc819eb55460ec3

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
