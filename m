Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4EE34D4C1
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771835973; cv=none; b=s2sr9pXKYPJLicW4iL0rnceLhnBHx7fTUQinoCvhh3AlIdMpGl8mzTKzxDU2l8b0+tj9c4+9vM512tbAX2xX63ap9bzbrGq8PJCmyYF91g/IpFTOY8KYDhpvGyt3kMEGMcnlvIguJLTIMi+gKmbqzkuhvGS6cflH2APlLf0PLNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771835973; c=relaxed/simple;
	bh=6MeYRLZzZSm92IUlis6rre4dQi+wfRFupMk50tPHjrU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=t8EJ+pywgNbj+d/WBokt2vb9jN4aqzjDYvnbVc31RT53QP59Boa9bLi3MKLddZaP9vM/k6vsmKAiVYGR6Kh0n0DA6MVDAyI0xRbdgwsZxqEGDN20xQ0q3MjBIbyu4xeV2tcd/wUJYEmSJRDf7QGJJQlPgGunk0Sr9lSBhIT1wwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-463a018f61bso16568467b6e.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 00:39:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771835971; x=1772440771;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nj1Ag1A1pdC0Uf4ojy9tmu9YjAY42iR+zwSKMxy8A/Y=;
        b=iXj5j9KageRikvmGYS0I1iolQQMmkD3uf82/fTEL973rDlhKlxDjB0eXToFGd7e7T/
         Zvp31o8z7Xemtm6MbXyeWam0HlST8cwYzDYACQjIqyxjF1XwLMaoU/1R9VOm4ao+dOR2
         H+2uDlLh72MbPF3RD+u3xiMivK4esiG9pqi4qZayKUPKUpJ1o20Ayc1k79PmHeIIJfoG
         sc0T5rekb9w9PdFtUkmXeHChqGLpx/l3/nPiQay9q8XfDBy5bs20UnLgK1/ts0doySit
         PW+wfRisrRowZnLrehLBMIZXBOsNEmwcGCbo8CbrLF2JGYiBOz3OPwAO4AcXNjSQSBWk
         qRTA==
X-Forwarded-Encrypted: i=1; AJvYcCX1dSC+vhFuh/oOgMJxf3UXTP/Wt+rRfUbh4L71R9HgA+qnRc0vCuBRiUxxJJDvV84cI3PzamdWJo5FDr1L2dwyEJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymmi/yc0abC4A9iOnsvN1/7JL0nIL6xuzNzPftWS5+V7vt0Pj2
	FclDGhxOyB3ZNF0EMpIq8t67J6zz0mQbVlpva5bgh1z5y83gXbBZqnO8Y9bvHkIuihL7UtCYCSe
	K5rZpBfJCQ+sIyQHT9h4IdwtZkEalyW8wVhmEUBJAvyLNboEKUnKTTx4DsNc=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:440a:b0:679:92c7:2bfa with SMTP id
 006d021491bc7-679c44cf2a3mr2924037eaf.45.1771835971312; Mon, 23 Feb 2026
 00:39:31 -0800 (PST)
Date: Mon, 23 Feb 2026 00:39:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <699c1243.a70a0220.2c38d7.0196.GAE@google.com>
Subject: [syzbot] Monthly trace report (Feb 2026)
From: syzbot <syzbot+listcf54b084a38156c4ffbb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello trace maintainers/developers,

This is a 31-day syzbot report for the trace subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/trace

During the period, 1 new issues were detected and 1 were fixed.
In total, 13 issues are still open and 63 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 111     Yes   WARNING in tracepoint_probe_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=a1d25e53cd4a10f7f2d3
<2> 104     Yes   WARNING in blk_register_tracepoints
                  https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
<3> 73      Yes   INFO: task hung in blk_trace_ioctl (4)
                  https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
<4> 41      Yes   INFO: task hung in blk_trace_startstop
                  https://syzkaller.appspot.com/bug?extid=774863666ef5b025c9d0
<5> 31      No    WARNING in ring_buffer_map_get_reader (2)
                  https://syzkaller.appspot.com/bug?extid=c7143161d8215214a993
<6> 16      Yes   KASAN: slab-use-after-free Read in bpf_trace_run2 (3)
                  https://syzkaller.appspot.com/bug?extid=59701a78e84b0bccfe1b
<7> 13      No    WARNING: refcount bug in call_timer_fn (4)
                  https://syzkaller.appspot.com/bug?extid=07dcf509f4c013e25dc5

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
