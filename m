Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834E02741AE
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 May 2025 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747650215; cv=none; b=piDp5R0hT1aVm6XAJVvKDFrjt6p9YGRAqfCZzRq/D/9IN5q2qjE0XQKh8/OXsHGgoGbchiLvmltrGNJFNNNNmG+smh9MrBVfzzKUKYWK27sh7h9OLN5uk4tOxzNGtDuWf1K2zEbZ87PcsHTeBU4l7maXGZAguY/yZ+k095x6wF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747650215; c=relaxed/simple;
	bh=qVYT7soGacmdnnA6v9cyT/+kbXKli+6EeB29u7HK+pw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=q1zuejwBsHF5nZ9m3MCU4dRAcDpcupCafLxZwZqtLsum41rhuz/j3NyqWP3pZN55QdhDVjxLnQaPL/3iJiCc32UmFycarvlh6stKlDzNAQ4sM3+SZNwyjljfCvvI07AmR6aBD7z7UkHnMpdwGEm+NfA2IP7PGls4E3LMPXE4Wrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86a50b5f5bdso12511239f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 May 2025 03:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747650213; x=1748255013;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jII1busYs4xnfa0qv3L8ZQ55pH0fVJVHYY14hn+MxwU=;
        b=Tkh06Fk0PJd0mmAg8/kus78sbCkmbBQRoos5lLLHEjqm/nH3EXDXhmih2xvqUA+t0w
         becN47SlkDkjuy299Zlz1qk8l8zS6oAF5dTV6K+en3YGDxi7yQ7r00PAi0DCHBkH8ZS7
         h3No8TzTFvHbV5Hm1RQOncJOuTIydfvOuMdrj9Q4h4kMhr3acoFW3rRUSV8/0dQ6mH/+
         Yx4FzgFnFRTosEnATH1O0gNyFARAY6luQKsFZGgUoV3szNCmN9mVG4MHpISPJdXpO3rs
         8jrhsHS418SMsBF0ZYmDCk/EN8qbwwE8vxNCUtJdarcTGd9gBJnK4JYQuLLxdXXHsE85
         udHw==
X-Forwarded-Encrypted: i=1; AJvYcCUhdMq2XII1Cwiu6yMQCzfIp3svjBzZDPvzIpESly+WvKtfJqdVMZlORqWUOqHs2A7yNhwKbFL4Kqq8GTAQt38g7NI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRVLRQ2HL1jaP8DlT0V7hB0mhy02Huu3x5hmfAWDeNwRGODO9z
	JLd+D6E1BcRdHzpQ6oxOfrskMJcHAhZ4pXJss8zUP7kYitsKOOSpP//fPjQvjH3OX+2+7oYss4r
	FsNUcKWcyp2x5ShDInDSVCp1OCx62svXl50dXRb+f1RzqynBvXn1ovO00ySI=
X-Google-Smtp-Source: AGHT+IHqR4AfI5timqitN3mlFHSN2ov7sUk7uSod5GMRxFEvnH8gBcgVkwq2BchnttNMRH+s+/D3fsPZnbExr8zVWzyS9wk22y+v
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:388b:b0:85b:b82f:965b with SMTP id
 ca18e2360f4ac-86a24cd615cmr1287509039f.12.1747650213625; Mon, 19 May 2025
 03:23:33 -0700 (PDT)
Date: Mon, 19 May 2025 03:23:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682b06a5.a70a0220.3849cf.00b4.GAE@google.com>
Subject: [syzbot] Monthly trace report (May 2025)
From: syzbot <syzbot+list1df466906ec8f148731d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mhiramat@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello trace maintainers/developers,

This is a 31-day syzbot report for the trace subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/trace

During the period, 1 new issues were detected and 2 were fixed.
In total, 13 issues are still open and 45 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1768    Yes   WARNING in format_decode (3)
                  https://syzkaller.appspot.com/bug?extid=e2c932aec5c8a6e1d31c
<2> 179     Yes   WARNING in bpf_get_stack_raw_tp
                  https://syzkaller.appspot.com/bug?extid=ce35de20ed6652f60652
<3> 52      Yes   WARNING in blk_register_tracepoints
                  https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
<4> 42      Yes   INFO: task hung in blk_trace_ioctl (4)
                  https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
<5> 27      Yes   WARNING in tracepoint_probe_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=a1d25e53cd4a10f7f2d3
<6> 24      Yes   WARNING in tracing_buffers_mmap_close
                  https://syzkaller.appspot.com/bug?extid=ddc001b92c083dbf2b97
<7> 18      Yes   INFO: task hung in blk_trace_remove (2)
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
