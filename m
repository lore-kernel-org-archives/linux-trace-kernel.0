Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462203BFE41
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Jan 2026 21:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769117025; cv=none; b=BEv0PePzPRltWW2+y2RHsWNiE0/QJhp9JHR4xb1xoFSJF92bTxdAo8ooPzqAbtJhhsCMbHX42I49zBs90t99Cm/ckR1cJFFrs8uqFPjUtrPE6G9PXAYtaCRGXHLybR1cUSvPt0b8jGKM5sUM45ljxtOGmnxaN9nu2kqqe1BOee4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769117025; c=relaxed/simple;
	bh=oS/Et39Nzo6dRUQLsj8WNbJhPbTmaF9x5dtIXYRkjU4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HMj+qBiNKaFluBmKqDzdHRDx2oaeXSViQ713bT8WuRBfkdbpEbd6EW8q7xsmaNUCk9wA32lcowoFL5w+PbOjJtiuAoB2nMSssf6e31Ge/jd9AJasWkBAg5P58AosFk1KyNYIu0mU9rlzjplBIZ+KPC0QfYOECp4LoYzcMnaj98w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-662c684079eso2546547eaf.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Jan 2026 13:23:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769117008; x=1769721808;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V2m7/3PjJMQEmVPF2KdOGnvKm4qv6bvMlPqoWSzknyA=;
        b=t37jS/a26S7dPHqWzw039HIRhoygAaE8y4NATpYkx4P/sru5IaLFnDzV4iWEmTwLZh
         hluE1F7g7CRYm3zPdY9CcGNCwqcf2y82BkmzyNJ0QnBdO35SxuDiCbVzwaUI18fL9IIO
         5o+vDRAlL3kWbtcg991BQAn0twUgEAk+Muc60Qc7+/X1UT54WdckY7SFtmYQGZmGIM5+
         ev2bI00oRNqv9i6wncOfQ5EBkKmCiWdU3wNhJ+uoBkw6pBE8rgMo6u0LgCeZLsyPgL5w
         yLz1jhH53Y/5jyVqWggNDLAcTRtaZLA2EVtJH2WRa+zV+1FA/jc5ti3rezzjZtHiCDXF
         k38Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4b3T/g09LbMUJZaQC3ZSWTTTlJ7wKVKcsEpawm81S15Wfq9FNvDO2mb8QPknuQga3IeBqDTXy/cAq9yIbbBW+CJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1iYJiVvrUa83SpY5FlIgXUYw0sIWMCdkoEbiXf8BRFWCQDjMa
	GABnFPTy1CP2f+HKEP5vN1ZNsDXINjckNDOiWg8V85xNb+ZgAOSKdfwfq3LVgWwWqVB3C28FjhZ
	8X9KaMinv+hZduhiB6hDxOEhboq+BP2kDR4VVe4P8t3rrzDL0J6wSkadc75o=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1ca0:b0:656:9e05:31d4 with SMTP id
 006d021491bc7-662caae7f11mr598061eaf.2.1769117008432; Thu, 22 Jan 2026
 13:23:28 -0800 (PST)
Date: Thu, 22 Jan 2026 13:23:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69729550.050a0220.1c5d0b.0007.GAE@google.com>
Subject: [syzbot] Monthly trace report (Jan 2026)
From: syzbot <syzbot+listecc46c7f75f420140aab@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello trace maintainers/developers,

This is a 31-day syzbot report for the trace subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/trace

During the period, 1 new issues were detected and 0 were fixed.
In total, 11 issues are still open and 62 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 101     Yes   WARNING in blk_register_tracepoints
                  https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
<2> 96      Yes   WARNING in tracepoint_probe_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=a1d25e53cd4a10f7f2d3
<3> 71      Yes   INFO: task hung in blk_trace_ioctl (4)
                  https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
<4> 63      Yes   INFO: task hung in blk_trace_remove (2)
                  https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562
<5> 26      Yes   INFO: task hung in relay_open (2)
                  https://syzkaller.appspot.com/bug?extid=16ea22f26882d7e46f35
<6> 22      Yes   WARNING in get_probe_ref
                  https://syzkaller.appspot.com/bug?extid=8672dcb9d10011c0a160
<7> 14      No    WARNING in ring_buffer_map_get_reader (2)
                  https://syzkaller.appspot.com/bug?extid=c7143161d8215214a993

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
