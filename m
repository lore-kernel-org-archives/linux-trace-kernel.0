Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9C021CC61
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Feb 2025 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739450066; cv=none; b=fI5ZjbgQD6cz8M0NJTL+kqY/jFWg1W47Tei4VRcu6NnsIu0sHqbN88nmmNYOjbBZtXuQrnpOIDwNmr4c8CaMF5nXMYDkYT5l+LTN3PtZ3OjIGkk3BfPBU6Nya2nyczZ1zGB/SMqb2+KDp9m5R9OtHhhjV/QsaQDMBuR5KaQE9t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739450066; c=relaxed/simple;
	bh=ePBw36xOQ9kV2kk6Q8SBQyHHmbT6ZlhvGX8MnQsLOfQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TKHrb0YS8zuUtPReWdXNWjIzCe/s/TU8Zvn4/+zOkgtVD9q9Bvub2V9sLVjqPMzFy0kuDIiPgZDCyCA6VqSxqRnD7dKKBQMDH4zSemOiQztxLzCpJdE+ud+lTlj6WfsmkUJwbVx3Z98hohUvCKOoQ8BB4239x0r9HWCxsCd+aG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d14a3f810fso5058265ab.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Feb 2025 04:34:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739450063; x=1740054863;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YWhPb7k4w08B3afNYcRqEv3V9whBDzgEmIzDh912tx0=;
        b=VrBQ3XyKgA/Ftl6QSBLAH2di4YBroD2BWfIM5wH/gdK2d5Uut6jpb7MeEzgCrfECix
         BOn+ZlbMMISzzVw/xUYxfQOT4UawJvGDwMTO6DDmQX7DQQWlSiARci775OXb0c/GkN3t
         6BZQ2tGqrupYhOVaFpGD1EBdFluagLdrW4Sd8IN5pUrHkNpYPQUXA/gOlUeX2sJDEJmf
         IigrPM6TOijLCRipzNo9YYO8wFWjRjLRKZXO78MbwDhOUQxX7xXJ7IcVJ1JEwm3JtRU1
         WfqMXPCYY+qDye7Z8VAroBaVxGDcW/kb5jFwQE58Yi5NzNlaRO/An49sQoocU7cXElba
         bM9A==
X-Forwarded-Encrypted: i=1; AJvYcCVbLx6naLjvRAKq/x0tFPKYRDpt/eIn2fiwl8hg9dM7AT9ATvyhf82cnPilddRhl9Ex4KV8gErCxj58Kt49b7O5zg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMpHEMIRl9fXb1/3+pMaS1ZNRb1z9vJ7VlM7fTVakp/K7rIl4r
	ycSG/NtTrY/7Z7AWm2oZ6ew2NMHYrmy4/eAg4Z+4UFpX+EQ+vrUVec78lk9IsyDRrIHwD4geJiy
	spQIpmGZbuG1h3dQS6moY1VI73ANFKwzsc4ygmCKX51RjGIRQUamU/YA=
X-Google-Smtp-Source: AGHT+IGOGymSwQ2QQqFPfP1S9F9q1u4lFGssMmBhhhZK4qhYAZqlNMcClPqYsB2s35iqsUzCqCzSj+4f7i259pQBIACQFcpZL4gX
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3889:b0:3d1:79ec:bef2 with SMTP id
 e9e14a558f8ab-3d18c22b107mr24664365ab.6.1739450063488; Thu, 13 Feb 2025
 04:34:23 -0800 (PST)
Date: Thu, 13 Feb 2025 04:34:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ade6cf.050a0220.110943.005c.GAE@google.com>
Subject: [syzbot] Monthly trace report (Feb 2025)
From: syzbot <syzbot+lista00272578215cac56980@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mhiramat@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello trace maintainers/developers,

This is a 31-day syzbot report for the trace subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/trace

During the period, 0 new issues were detected and 1 were fixed.
In total, 15 issues are still open and 42 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1458    Yes   WARNING in format_decode (3)
                  https://syzkaller.appspot.com/bug?extid=e2c932aec5c8a6e1d31c
<2> 157     Yes   WARNING in bpf_get_stack_raw_tp
                  https://syzkaller.appspot.com/bug?extid=ce35de20ed6652f60652
<3> 35      Yes   INFO: task hung in blk_trace_ioctl (4)
                  https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
<4> 29      Yes   WARNING in blk_register_tracepoints
                  https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
<5> 15      Yes   WARNING in get_probe_ref
                  https://syzkaller.appspot.com/bug?extid=8672dcb9d10011c0a160
<6> 11      Yes   WARNING in tracepoint_probe_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=a1d25e53cd4a10f7f2d3

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
